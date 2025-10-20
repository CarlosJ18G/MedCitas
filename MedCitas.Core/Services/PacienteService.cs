using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MedCitas.Core.Entities;
using MedCitas.Core.Interfaces;
using System.Text.RegularExpressions;
using BCrypt.Net;

namespace MedCitas.Core.Services
{
    public class PacienteService
    {
        private readonly IPacienteRepository _repo;
        private readonly IEmailService _emailService;

        public PacienteService(IPacienteRepository repo, IEmailService emailService)
        {
            _repo = repo;
            _emailService = emailService;
        }

        // -----------------------------------------
        // REGISTRO
        // -----------------------------------------
        public async Task<Paciente> RegistrarAsync(Paciente nuevo, string plainPassword, string confirmarPassword)
        {
            // Validaciones básicas
            if (nuevo == null) throw new ArgumentNullException(nameof(nuevo));

            ValidarCampos(nuevo, plainPassword, confirmarPassword);

            // Validar duplicados
            var porCorreo = await _repo.ObtenerPorCorreoAsync(nuevo.CorreoElectronico);
            if (porCorreo != null) throw new InvalidOperationException("El correo electrónico ya está registrado.");

            var porDoc = await _repo.ObtenerPorDocumentoAsync(nuevo.NumeroDocumento);
            if (porDoc != null) throw new InvalidOperationException("El número de documento ya está registrado.");

            // Crear hash seguro
            nuevo.PasswordHash = BCrypt.Net.BCrypt.HashPassword(plainPassword);

            // Generar token de verificación
            nuevo.TokenVerificacion = Guid.NewGuid().ToString();
            nuevo.EstaVerificado = false;
            nuevo.FechaRegistro = DateTime.UtcNow;

            // Guardar paciente
            await _repo.RegistrarAsync(nuevo);

            // Enviar correo (simulado)
            await _emailService.EnviarCorreoVerificacionAsync(nuevo.CorreoElectronico, nuevo.TokenVerificacion);

            return nuevo;
        }

        // -----------------------------------------
        // LOGIN
        // -----------------------------------------
        public async Task<Paciente?> LoginAsync(string correo, string password)
        {
            if (string.IsNullOrWhiteSpace(correo) || string.IsNullOrWhiteSpace(password))
                throw new ArgumentException("Correo y contraseña son obligatorios.");

            var paciente = await _repo.ObtenerPorCorreoAsync(correo);
            if (paciente == null) return null;

            if (!paciente.EstaVerificado)
                throw new InvalidOperationException("Cuenta pendiente de verificación.");

            bool passwordCorrecto = BCrypt.Net.BCrypt.Verify(password, paciente.PasswordHash);
            return passwordCorrecto ? paciente : null;
        }

        // -----------------------------------------
        // ACTIVAR CUENTA
        // -----------------------------------------
        public async Task<bool> ActivarCuentaAsync(string token)
        {
            if (string.IsNullOrWhiteSpace(token))
                throw new ArgumentException("Token inválido.");

            return await _repo.ActivarCuentaAsync(token);
        }

        // -----------------------------------------
        // VALIDACIONES
        // -----------------------------------------
        private void ValidarCampos(Paciente p, string password, string confirmar)
        {
            // Timeout de 100ms para prevenir ReDoS (Regular Expression Denial of Service)
            var regexTimeout = TimeSpan.FromMilliseconds(100);

            if (string.IsNullOrWhiteSpace(p.NombreCompleto))
                throw new ArgumentException("El nombre completo es obligatorio.");

            if (!Regex.IsMatch(p.NumeroDocumento, @"^\d+$", RegexOptions.None, regexTimeout))
                throw new ArgumentException("El número de documento solo debe contener números.");

            if (!Regex.IsMatch(p.Telefono, @"^\d{7,15}$", RegexOptions.None, regexTimeout))
                throw new ArgumentException("El teléfono debe contener entre 7 y 15 dígitos.");

            if (!Regex.IsMatch(p.CorreoElectronico, @"^[^@\s]+@[^@\s]+\.[^@\s]+$", RegexOptions.None, regexTimeout))
                throw new ArgumentException("Formato de correo inválido.");

            if (password != confirmar)
                throw new ArgumentException("Las contraseñas no coinciden.");

            if (!Regex.IsMatch(password, @"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z\d]).{8,}$", RegexOptions.None, regexTimeout))
                throw new ArgumentException("La contraseña debe tener mínimo 8 caracteres, con mayúscula, minúscula, número y carácter especial.");
        }
    }
}


