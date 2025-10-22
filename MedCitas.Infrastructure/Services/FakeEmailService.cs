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
        private readonly ILogger<FakeEmailService> _logger;

        public FakeEmailService(ILogger<FakeEmailService> logger)
        {
            _logger = logger;
        }

        public Task EnviarCorreoVerificacionAsync(string correo, string tokenVerificacion)
        {
            _logger.LogWarning("========================================");
            _logger.LogWarning("[EMAIL SIMULADO] Enviado a: {Correo}", correo);
            _logger.LogWarning("Enlace de verificación: https://medcitas.com/verificar/{Token}", tokenVerificacion);
            _logger.LogWarning("========================================");
            return Task.CompletedTask;
        }

        public Task EnviarOTPAsync(string correo, string codigoOTP, string nombreCompleto)
        {
            _logger.LogWarning("========================================");
            _logger.LogWarning("[EMAIL SIMULADO - OTP] Enviando a: {Correo}", correo);
            _logger.LogWarning("Hola {Nombre},", nombreCompleto);
            _logger.LogWarning("🔐 Tu código de verificación es: {CodigoOTP}", codigoOTP);
            _logger.LogWarning("⏰ Este código expira en 15 minutos.");
            _logger.LogWarning("========================================");
            return Task.CompletedTask;
        }
    }
}

