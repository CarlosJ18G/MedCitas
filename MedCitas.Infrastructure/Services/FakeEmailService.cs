using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MedCitas.Core.Interfaces;

namespace MedCitas.Infrastructure.Services
{
    public class FakeEmailService : IEmailService
    {
        public Task EnviarCorreoVerificacionAsync(string destinatario, string tokenVerificacion)
        {
            Console.WriteLine($"[EMAIL SIMULADO] Enviado a: {destinatario}");
            Console.WriteLine($"Enlace de verificación: https://medcitas.com/verificar/{tokenVerificacion}");
            return Task.CompletedTask;
        }
    }
}

