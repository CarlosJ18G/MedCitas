using MedCitas.Core.Entities;
using MedCitas.Core.Interfaces;
using MedCitas.Infrastructure.DataDb;
using Microsoft.EntityFrameworkCore;
using System;
using System.Diagnostics.CodeAnalysis;
using System.Threading.Tasks;

namespace MedCitas.Infrastructure.Repositories
{
    public class EfPacienteRepositorio : IPacienteRepository
    {
        private readonly MedCitasDbContext _db;

        public EfPacienteRepositorio(MedCitasDbContext db) => _db = db;

        public async Task<Paciente?> ObtenerPorDocumentoAsync(string numeroDocumento) =>
      await _db.Pacientes.FirstOrDefaultAsync(p => p.NumeroDocumento == numeroDocumento);

        // ✅ ToLower() es la forma correcta para EF Core - StringComparison no es traducible a SQL
        [SuppressMessage("SonarLint", "S1449", Justification = "EF Core no puede traducir StringComparison a SQL")]
 public async Task<Paciente?> ObtenerPorCorreoAsync(string correoElectronico) =>
            await _db.Pacientes
        .Where(p => p.CorreoElectronico.ToLower() == correoElectronico.ToLower())
                .FirstOrDefaultAsync();

        public async Task RegistrarAsync(Paciente paciente)
        {
            if (paciente.Id == Guid.Empty)
   {
        paciente.Id = Guid.NewGuid();
    }
    _db.Pacientes.Add(paciente);
    await _db.SaveChangesAsync();
 }

        public async Task<bool> ActivarCuentaAsync(string tokenVerificacion)
   {
         var paciente = await _db.Pacientes.FirstOrDefaultAsync(p => p.TokenVerificacion == tokenVerificacion);
      if (paciente == null)
     {
         return false;
    }
 paciente.EstaVerificado = true;
     paciente.TokenVerificacion = null;
      await _db.SaveChangesAsync();
       return true;
 }

     public async Task<bool> VerificarOTPAsync(string correo, string codigoOTP)
    {
  var paciente = await ObtenerPorCorreoAsync(correo);
  if (paciente == null)
    {
       return false;
            }

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
          ArgumentNullException.ThrowIfNull(paciente);

            _db.Pacientes.Update(paciente);
         await _db.SaveChangesAsync();
        }

        // ✅ IMPLEMENTACIÓN DE MÉTODOS PARA RECUPERACIÓN DE CONTRASEÑA
        public async Task<Paciente?> ObtenerPorTokenRecuperacionAsync(string token) =>
            await _db.Pacientes.FirstOrDefaultAsync(p => p.TokenRecuperacion == token);

        public async Task ActualizarTokenRecuperacionAsync(Paciente paciente)
     {
         ArgumentNullException.ThrowIfNull(paciente);

    // Validación adicional específica para token de recuperación
            if (string.IsNullOrEmpty(paciente.TokenRecuperacion))
{
    throw new ArgumentException("El token de recuperación no puede estar vacío.", nameof(paciente));
            }

            _db.Pacientes.Update(paciente);
       await _db.SaveChangesAsync();
 }

        public async Task ActualizarPasswordAsync(Paciente paciente)
        {
  ArgumentNullException.ThrowIfNull(paciente);

            // Validación adicional específica para contraseña
            if (string.IsNullOrEmpty(paciente.PasswordHash))
            {
    throw new ArgumentException("El hash de contraseña no puede estar vacío.", nameof(paciente));
            }

      _db.Pacientes.Update(paciente);
            await _db.SaveChangesAsync();
        }
    }
}
