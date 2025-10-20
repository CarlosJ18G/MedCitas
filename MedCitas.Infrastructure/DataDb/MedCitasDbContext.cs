using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using MedCitas.Core.Entities;


namespace MedCitas.Infrastructure.DataDb
{
    public class MedCitasDbContext : DbContext
    {
        public MedCitasDbContext(DbContextOptions<MedCitasDbContext> options) : base(options) { }

        public DbSet<Paciente> Pacientes { get; set; } = null!;

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Paciente>(entity =>
            {
                entity.HasKey(e => e.Id);
                entity.Property(e => e.NombreCompleto).IsRequired();
                entity.Property(e => e.TipoDocumento).IsRequired();
                entity.Property(e => e.NumeroDocumento).IsRequired().HasMaxLength(20);
                entity.Property(e => e.FechaNacimiento).IsRequired();
                entity.Property(e => e.Sexo).IsRequired();
                entity.Property(e => e.Telefono).IsRequired().HasMaxLength(10);
                entity.Property(e => e.CorreoElectronico).IsRequired().HasMaxLength(200);
                entity.Property(e => e.PasswordHash).IsRequired().HasMaxLength(64);
                entity.Property(e => e.Eps).IsRequired();
                entity.Property(e => e.TipoSangre).IsRequired();
                entity.Property(e => e.EstaVerificado);
                entity.Property(e => e.TokenVerificacion);
                entity.Property(e => e.FechaRegistro);
            });

            base.OnModelCreating(modelBuilder);

        }
    }
}
