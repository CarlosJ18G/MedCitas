using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MedCitas.Core.Entities
{
    public class Paciente
    {
        public Guid Id { get; set; } = Guid.NewGuid();

        [Required]
        public string NombreCompleto { get; set; } = string.Empty;

        [Required]
        public string TipoDocumento { get; set; } = string.Empty;

        [Required, MaxLength(20)]
        public string NumeroDocumento { get; set; } = string.Empty;

        [Required]
        public DateTime FechaNacimiento { get; set; }

        [Required]
        public string Sexo { get; set; } = string.Empty;

        [Required, MaxLength(10)]
        public string Telefono { get; set; } = string.Empty;

        [Required, EmailAddress]
        public string CorreoElectronico { get; set; } = string.Empty;

        [Required, MaxLength(64)]
        public string PasswordHash { get; set; } = string.Empty;

        [Required]
        public string Eps { get; set; } = string.Empty;

        [Required]
        public string TipoSangre { get; set; } = string.Empty;

        public bool EstaVerificado { get; set; } = false;
        public string? TokenVerificacion { get; set; }
        public DateTime FechaRegistro { get; set; } = DateTime.UtcNow;

        public string ToString()
        {
            return $"Paciente: {NombreCompleto}, Documento: {TipoDocumento} {NumeroDocumento}, Nacimiento: {FechaNacimiento.ToShortDateString()}, Sexo: {Sexo}, Teléfono: {Telefono}, Correo: {CorreoElectronico}, EPS: {Eps}, Tipo de Sangre: {TipoSangre}, Verificado: {EstaVerificado}, Fecha de Registro: {FechaRegistro}";
        }
    }

}


