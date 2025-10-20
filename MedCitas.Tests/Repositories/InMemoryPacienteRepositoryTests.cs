using System;
using System.Threading.Tasks;
using Xunit;
using MedCitas.Core.Entities;
using MedCitas.Infrastructure.Repositories;

namespace MedCitas.Tests.Repositories
{
    public class InMemoryPacienteRepositoryTests
    {
        [Fact]
        public async Task RegistrarAsync_DeberiaAgregarPacienteALaLista()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var paciente = new Paciente
            {
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "123456789",
                CorreoElectronico = "carlos@example.com"
            };

            // Act
            await repository.RegistrarAsync(paciente);

            // Assert
            var resultado = await repository.ObtenerPorDocumentoAsync("123456789");
            Assert.NotNull(resultado);
            Assert.Equal("Carlos Jimenez", resultado.NombreCompleto);
        }

        [Fact]
        public async Task RegistrarAsync_DeberiaAsignarIdSiEsEmpty()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var paciente = new Paciente
            {
                Id = Guid.Empty,
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "123456789",
                CorreoElectronico = "carlos@example.com"
            };

            // Act
            await repository.RegistrarAsync(paciente);

            // Assert
            Assert.NotEqual(Guid.Empty, paciente.Id);
        }

        [Fact]
        public async Task RegistrarAsync_NoDeberiaModificarIdSiYaTieneUno()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var expectedId = Guid.NewGuid();
            var paciente = new Paciente
            {
                Id = expectedId,
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "123456789",
                CorreoElectronico = "carlos@example.com"
            };

            // Act
            await repository.RegistrarAsync(paciente);

            // Assert
            Assert.Equal(expectedId, paciente.Id);
        }

        [Fact]
        public async Task ObtenerPorDocumentoAsync_ConDocumentoExistente_DeberiaRetornarPaciente()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var paciente = new Paciente
            {
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "123456789",
                CorreoElectronico = "carlos@example.com"
            };
            await repository.RegistrarAsync(paciente);

            // Act
            var resultado = await repository.ObtenerPorDocumentoAsync("123456789");

            // Assert
            Assert.NotNull(resultado);
            Assert.Equal("123456789", resultado.NumeroDocumento);
        }

        [Fact]
        public async Task ObtenerPorDocumentoAsync_ConDocumentoNoExistente_DeberiaRetornarNull()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();

            // Act
            var resultado = await repository.ObtenerPorDocumentoAsync("999999999");

            // Assert
            Assert.Null(resultado);
        }

        [Fact]
        public async Task ObtenerPorCorreoAsync_ConCorreoExistente_DeberiaRetornarPaciente()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var paciente = new Paciente
            {
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "123456789",
                CorreoElectronico = "carlos@example.com"
            };
            await repository.RegistrarAsync(paciente);

            // Act
            var resultado = await repository.ObtenerPorCorreoAsync("carlos@example.com");

            // Assert
            Assert.NotNull(resultado);
            Assert.Equal("carlos@example.com", resultado.CorreoElectronico);
        }

        [Fact]
        public async Task ObtenerPorCorreoAsync_DeberiaSerCaseInsensitive()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var paciente = new Paciente
            {
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "123456789",
                CorreoElectronico = "carlos@example.com"
            };
            await repository.RegistrarAsync(paciente);

            // Act
            var resultado = await repository.ObtenerPorCorreoAsync("CARLOS@EXAMPLE.COM");

            // Assert
            Assert.NotNull(resultado);
            Assert.Equal("carlos@example.com", resultado.CorreoElectronico);
        }

        [Fact]
        public async Task ObtenerPorCorreoAsync_ConCorreoNoExistente_DeberiaRetornarNull()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();

            // Act
            var resultado = await repository.ObtenerPorCorreoAsync("noexiste@example.com");

            // Assert
            Assert.Null(resultado);
        }

        [Fact]
        public async Task ActivarCuentaAsync_ConTokenValido_DeberiaActivarCuenta()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var token = Guid.NewGuid().ToString();
            var paciente = new Paciente
            {
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "123456789",
                CorreoElectronico = "carlos@example.com",
                TokenVerificacion = token,
                EstaVerificado = false
            };
            await repository.RegistrarAsync(paciente);

            // Act
            var resultado = await repository.ActivarCuentaAsync(token);

            // Assert
            Assert.True(resultado);
            Assert.True(paciente.EstaVerificado);
            Assert.Null(paciente.TokenVerificacion);
        }

        [Fact]
        public async Task ActivarCuentaAsync_ConTokenInvalido_DeberiaRetornarFalse()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var token = Guid.NewGuid().ToString();

            // Act
            var resultado = await repository.ActivarCuentaAsync(token);

            // Assert
            Assert.False(resultado);
        }

        [Fact]
        public async Task RegistrarAsync_VariasPacientes_DeberiaAlmacenarTodos()
        {
            // Arrange
            var repository = new InMemoryPacienteRepository();
            var paciente1 = new Paciente
            {
                NombreCompleto = "Carlos Jimenez",
                NumeroDocumento = "111111111",
                CorreoElectronico = "carlos@example.com"
            };
            var paciente2 = new Paciente
            {
                NombreCompleto = "Maria Lopez",
                NumeroDocumento = "222222222",
                CorreoElectronico = "maria@example.com"
            };

            // Act
            await repository.RegistrarAsync(paciente1);
            await repository.RegistrarAsync(paciente2);

            // Assert
            var resultado1 = await repository.ObtenerPorDocumentoAsync("111111111");
            var resultado2 = await repository.ObtenerPorDocumentoAsync("222222222");
            Assert.NotNull(resultado1);
            Assert.NotNull(resultado2);
            Assert.Equal("Carlos Jimenez", resultado1.NombreCompleto);
            Assert.Equal("Maria Lopez", resultado2.NombreCompleto);
        }
    }
}
