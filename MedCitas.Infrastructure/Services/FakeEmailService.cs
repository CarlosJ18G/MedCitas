using MedCitas.Core.Interfaces;
using Microsoft.Extensions.Logging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedCitas.Infrastructure.Services
{
    public class FakeEmailService : IEmailService
    {
        private const string V = "----------------------------------------";
        private readonly ILogger<FakeEmailService> _logger;

        public FakeEmailService(ILogger<FakeEmailService> logger)
        {
            _logger = logger;
        }
        

        public Task EnviarCorreoVerificacionAsync(string destinatario, string tokenVerificacion)
        {
            // ✅ Un solo LogWarning con mensaje completo
            var mensaje = new StringBuilder()
                .AppendLine(V)
                .AppendLine($"[EMAIL SIMULADO] Enviado a: {destinatario}")
                .AppendLine($"Enlace de verificación: https://medcitas.com/verificar/{tokenVerificacion}")
                .AppendLine(V)
                .ToString();

            _logger.LogWarning("{Mensaje}", mensaje);
            return Task.CompletedTask;
        }

        public Task EnviarOTPAsync(string correo, string codigoOTP, string nombreCompleto)
        {
            var mensaje = new StringBuilder()
                .AppendLine(V)
                .AppendLine($"[EMAIL SIMULADO - OTP] Enviando a: {correo}")
                .AppendLine($"Hola {nombreCompleto},")
                .AppendLine($"🔐 Tu código de verificación es: {codigoOTP}")
                .AppendLine("⏰ Este código expira en 15 minutos.")
                .AppendLine(V)
                .ToString();

            _logger.LogWarning("{Mensaje}", mensaje);
            return Task.CompletedTask;
        }
    }
}

