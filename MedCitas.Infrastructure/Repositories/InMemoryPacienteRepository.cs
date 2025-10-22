//using System;
//using System.Collections.Generic;
//using System.Linq;
//using System.Text;
//using System.Threading.Tasks;
//using MedCitas.Core.Entities;
//using MedCitas.Core.Interfaces;

//namespace MedCitas.Infrastructure.Repositories
//{
//    public class InMemoryPacienteRepository : IPacienteRepository
//    {
//        private readonly List<Paciente> _pacientes = new();

//        public Task<Paciente?> ObtenerPorDocumentoAsync(string numeroDocumento)
//        {
//            var p = _pacientes.FirstOrDefault(x => x.NumeroDocumento == numeroDocumento);
//            return Task.FromResult<Paciente?>(p);
//        }

//        public Task<Paciente?> ObtenerPorCorreoAsync(string correoElectronico)
//        {
//            var p = _pacientes.FirstOrDefault(x =>
//                string.Equals(x.CorreoElectronico, correoElectronico, StringComparison.OrdinalIgnoreCase));
//            return Task.FromResult<Paciente?>(p);
//        }

//        public Task RegistrarAsync(Paciente paciente)
//        {
//            if (paciente.Id == Guid.Empty)
//                paciente.Id = Guid.NewGuid();

//            _pacientes.Add(paciente);
//            return Task.CompletedTask;
//        }

//        public Task<bool> ActivarCuentaAsync(string tokenVerificacion)
//        {
//            var paciente = _pacientes.FirstOrDefault(x => x.TokenVerificacion == tokenVerificacion);
//            if (paciente == null) return Task.FromResult(false);

//            paciente.EstaVerificado = true;
//            paciente.TokenVerificacion = null;
//            return Task.FromResult(true);
//        }
//    }
//}


