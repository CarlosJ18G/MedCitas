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
                entity.Property(e => e.TipoDocumento).IsRequired().HasMaxLength(5);
                entity.Property(e => e.NumeroDocumento).IsRequired().HasMaxLength(20);

                // ✅ Especificar que FechaNacimiento es solo fecha (sin hora)
                entity.Property(e => e.FechaNacimiento)
                    .IsRequired()
                    .HasColumnType("date"); // Solo fecha, no timestamp

                entity.Property(e => e.Sexo).IsRequired().HasMaxLength(1);
                entity.Property(e => e.Telefono).IsRequired().HasMaxLength(15);
                entity.Property(e => e.CorreoElectronico).IsRequired().HasMaxLength(200);
                entity.Property(e => e.PasswordHash).HasMaxLength(100);
                entity.Property(e => e.Eps).IsRequired();
                entity.Property(e => e.TipoSangre).IsRequired();
                entity.Property(e => e.EstaVerificado);
                entity.Property(e => e.TokenVerificacion);

                // ✅ Especificar que FechaRegistro es timestamp UTC
                entity.Property(e => e.FechaRegistro)
                    .HasColumnType("timestamp with time zone");

                entity.Property(e => e.CodigoOTP).HasMaxLength(6);

                // ✅ Especificar que OTPExpiracion es timestamp UTC
                entity.Property(e => e.OTPExpiracion)
                    .HasColumnType("timestamp with time zone");

                entity.Property(e => e.IntentosOTPFallidos).HasDefaultValue(0);
            });

            base.OnModelCreating(modelBuilder);
        }

        // ✅ AGREGAR: Convertir automáticamente DateTime a UTC antes de guardar
        public override int SaveChanges()
        {
            ConvertDateTimesToUtc();
            return base.SaveChanges();
        }

        public override Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
        {
            ConvertDateTimesToUtc();
            return base.SaveChangesAsync(cancellationToken);
        }

        private void ConvertDateTimesToUtc()
        {
            var entries = ChangeTracker.Entries()
                .Where(e => e.State == EntityState.Added || e.State == EntityState.Modified);

            foreach (var entry in entries)
            {
                foreach (var property in entry.Properties)
                {
                    if (property.Metadata.ClrType == typeof(DateTime))
                    {
                        var value = (DateTime)property.CurrentValue!;
                        if (value.Kind == DateTimeKind.Unspecified)
                        {
                            property.CurrentValue = DateTime.SpecifyKind(value, DateTimeKind.Utc);
                        }
                        else if (value.Kind == DateTimeKind.Local)
                        {
                            property.CurrentValue = value.ToUniversalTime();
                        }
                    }
                    else if (property.Metadata.ClrType == typeof(DateTime?))
                    {
                        var value = (DateTime?)property.CurrentValue;
                        if (value.HasValue)
                        {
                            if (value.Value.Kind == DateTimeKind.Unspecified)
                            {
                                property.CurrentValue = DateTime.SpecifyKind(value.Value, DateTimeKind.Utc);
                            }
                            else if (value.Value.Kind == DateTimeKind.Local)
                            {
                                property.CurrentValue = value.Value.ToUniversalTime();
                            }
                        }
                    }
                }
            }
        }
    }
}