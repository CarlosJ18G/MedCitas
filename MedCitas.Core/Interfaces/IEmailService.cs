using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedCitas.Core.Interfaces
{
    public interface IEmailService
    {
        Task EnviarCorreoVerificacionAsync(string destinatario, string tokenVerificacion);
    }
}
