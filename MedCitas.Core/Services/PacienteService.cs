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
            // Generar OTP en lugar de token
            var otpService = new OtpService();
            nuevo.CodigoOTP = otpService.GenerarOTP();
            nuevo.OTPExpiracion = otpService.ObtenerFechaExpiracion();
            nuevo.IntentosOTPFallidos = 0;
            nuevo.EstaVerificado = false;
            nuevo.FechaRegistro = DateTime.UtcNow;

            // Guardar paciente
            await _repo.RegistrarAsync(nuevo);

            // Enviar OTP por correo
            await _emailService.EnviarOTPAsync(
                nuevo.CorreoElectronico,
                nuevo.CodigoOTP,
                nuevo.NombreCompleto
            );

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

        public async Task<bool> VerificarOTPAsync(string correo, string codigoOTP)
        {
            if (string.IsNullOrWhiteSpace(correo) || string.IsNullOrWhiteSpace(codigoOTP))
                throw new ArgumentException("Correo y código OTP son obligatorios.");

            var paciente = await _repo.ObtenerPorCorreoAsync(correo);
            if (paciente == null)
                throw new InvalidOperationException("Usuario no encontrado.");

            if (paciente.IntentosOTPFallidos >= 3)
                throw new InvalidOperationException("Demasiados intentos fallidos. Solicita un nuevo código.");

            var otpService = new OtpService();
            if (!otpService.ValidarOTP(codigoOTP, paciente.CodigoOTP!, paciente.OTPExpiracion))
            {
                paciente.IntentosOTPFallidos++;
                await _repo.ActualizarOTPAsync(paciente);
                return false;
            }

            return await _repo.VerificarOTPAsync(correo, codigoOTP);
        }

        // Método para reenviar OTP
        public async Task ReenviarOTPAsync(string correo)
        {
            var paciente = await _repo.ObtenerPorCorreoAsync(correo);
            if (paciente == null)
                throw new InvalidOperationException("Usuario no encontrado.");

            if (paciente.EstaVerificado)
                throw new InvalidOperationException("La cuenta ya está verificada.");

            var otpService = new OtpService();
            paciente.CodigoOTP = otpService.GenerarOTP();
            paciente.OTPExpiracion = otpService.ObtenerFechaExpiracion();
            paciente.IntentosOTPFallidos = 0;

            await _repo.ActualizarOTPAsync(paciente);
            await _emailService.EnviarOTPAsync(correo, paciente.CodigoOTP, paciente.NombreCompleto);
        }
    }
}


