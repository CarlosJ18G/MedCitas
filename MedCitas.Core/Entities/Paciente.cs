using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedCitas.Core.Entities
{
    public class Paciente
    {
        public Guid Id { get; set; } = Guid.NewGuid();
        public string NombreCompleto { get; set; } = string.Empty;
        public string TipoDocumento { get; set; } = string.Empty;
        public string NumeroDocumento { get; set; } = string.Empty;
        public DateTime FechaNacimiento { get; set; }
        public string Sexo { get; set; } = string.Empty;
        public string Telefono { get; set; } = string.Empty;
        public string CorreoElectronico { get; set; } = string.Empty;
        public string PasswordHash { get; set; } = string.Empty;
        public string Eps { get; set; } = string.Empty;
        public string TipoSangre { get; set; } = string.Empty;
        public bool EstaVerificado { get; set; } = false;
        public string? TokenVerificacion { get; set; }
        public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;
    }
}


