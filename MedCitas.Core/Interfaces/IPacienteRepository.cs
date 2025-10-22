using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using MedCitas.Core.Entities;

namespace MedCitas.Core.Interfaces
{
    public interface IPacienteRepository
    {
        Task<Paciente?> ObtenerPorDocumentoAsync(string numeroDocumento);
        Task<Paciente?> ObtenerPorCorreoAsync(string correoElectronico);
        Task RegistrarAsync(Paciente paciente);
        Task<bool> ActivarCuentaAsync(string tokenVerificacion);
        Task<bool> VerificarOTPAsync(string correo, string codigoOTP);
        Task ActualizarOTPAsync(Paciente paciente);
    }
}

