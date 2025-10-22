using MedCitas.Core.Entities;
using MedCitas.Core.Interfaces;
using MedCitas.Infrastructure.DataDb;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedCitas.Infrastructure.Repositories
{
    public class EfPacienteRepositorio : IPacienteRepository
    {
        private readonly MedCitasDbContext _db;

        public EfPacienteRepositorio(MedCitasDbContext db) => _db = db;

        public async Task<Paciente?> ObtenerPorDocumentoAsync(string numeroDocumento) =>
            await _db.Pacientes.FirstOrDefaultAsync(p => p.NumeroDocumento == numeroDocumento);

        public async Task<Paciente?> ObtenerPorCorreoAsync(string correoElectronico) =>
            await _db.Pacientes.FirstOrDefaultAsync(p => p.CorreoElectronico.ToLower() == correoElectronico.ToLower());

        public async Task RegistrarAsync(Paciente paciente)
        {
            if (paciente.Id == Guid.Empty) paciente.Id = Guid.NewGuid();
            _db.Pacientes.Add(paciente);
            await _db.SaveChangesAsync();
        }

        public async Task<bool> ActivarCuentaAsync(string tokenVerificacion)
        {
            var paciente = await _db.Pacientes.FirstOrDefaultAsync(p => p.TokenVerificacion == tokenVerificacion);
            if (paciente == null) return false;
            paciente.EstaVerificado = true;
            paciente.TokenVerificacion = null;
            await _db.SaveChangesAsync();
            return true;
        }

        public async Task<bool> VerificarOTPAsync(string correo, string codigoOTP)
        {
            var paciente = await ObtenerPorCorreoAsync(correo);
            if (paciente == null) return false;

            if (paciente.CodigoOTP != codigoOTP ||
                paciente.OTPExpiracion == null ||
                DateTime.UtcNow > paciente.OTPExpiracion)
            {
                paciente.IntentosOTPFallidos++;
                await _db.SaveChangesAsync();
                return false;
            }

            paciente.EstaVerificado = true;
            paciente.CodigoOTP = null;
            paciente.OTPExpiracion = null;
            paciente.IntentosOTPFallidos = 0;
            await _db.SaveChangesAsync();
            return true;
        }

        public async Task ActualizarOTPAsync(Paciente paciente)
        {
            _db.Pacientes.Update(paciente);
            await _db.SaveChangesAsync();
        }
    }
}
