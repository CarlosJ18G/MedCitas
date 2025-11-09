using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using MedCitas.Core.Entities;

namespace MedCitas.Core.Interfaces
{
    /// <summary>
  /// Repositorio para la gestión de médicos
    /// </summary>
    public interface IDoctorRepository
    {
    /// <summary>
        /// Obtiene un médico por su ID
  /// </summary>
   Task<Doctor?> ObtenerPorIdAsync(Guid id);

        /// <summary>
        /// Obtiene todos los médicos activos
  /// </summary>
   Task<List<Doctor>> ObtenerTodosAsync();

 /// <summary>
        /// Obtiene médicos por especialidad
        /// </summary>
        Task<List<Doctor>> ObtenerPorEspecialidadAsync(Guid especialidadId);
    }
}
