using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using MedCitas.Core.Entities;
using MedCitas.Core.Interfaces;
using MedCitas.Infrastructure.DataDb;
using Microsoft.EntityFrameworkCore;

namespace MedCitas.Infrastructure.Repositories
{
    public class EfDoctorRepository : IDoctorRepository
    {
        private readonly MedCitasDbContext _db;

        public EfDoctorRepository(MedCitasDbContext db) => _db = db;

        public async Task<Doctor?> ObtenerPorIdAsync(Guid id) =>
            await _db.Doctors
       .Include(d => d.Specialty)
                .FirstOrDefaultAsync(d => d.Id == id);

        public async Task<List<Doctor>> ObtenerTodosAsync() =>
await _db.Doctors
 .Include(d => d.Specialty)
     .Where(d => d.EstaActivo)
  .OrderBy(d => d.NombreCompleto)
    .ToListAsync();

   public async Task<List<Doctor>> ObtenerPorEspecialidadAsync(Guid especialidadId) =>
 await _db.Doctors
                .Include(d => d.Specialty)
           .Where(d => d.SpecialtyId == especialidadId && d.EstaActivo)
                .OrderBy(d => d.NombreCompleto)
  .ToListAsync();
 }
}
