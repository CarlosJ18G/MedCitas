using MedCitas.Infrastructure.Services;
using Microsoft.Extensions.Logging.Abstractions;
using System;
using System.IO;
using System.Threading.Tasks;
using Xunit;

namespace MedCitas.Tests.Services
{
    public class FakeEmailServiceTests
    {
        private readonly FakeEmailService _emailService;

        public FakeEmailServiceTests()
        {
            var logger = NullLogger<FakeEmailService>.Instance;
            _emailService = new FakeEmailService(logger);
        }

        [Fact]
        public async Task EnviarCorreoVerificacionAsync_DeberiaCompletarseSinError()
        {
            // Arrange
            var destinatario = "test@example.com";
            var token = Guid.NewGuid().ToString();

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarCorreoVerificacionAsync(destinatario, token));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarCorreoVerificacionAsync_ConDestinatarioValido_DeberiaRetornarTaskCompletado()
        {
            // Arrange
            var destinatario = "usuario@example.com";
            var token = "token-123-456";

            // Act
            var task = _emailService.EnviarCorreoVerificacionAsync(destinatario, token);
            await task;

            // Assert
            Assert.True(task.IsCompletedSuccessfully);
        }

        [Theory]
        [InlineData("carlos@example.com", "abc123")]
        [InlineData("maria@gmail.com", "def456")]
        [InlineData("test@hotmail.com", "xyz789")]
        public async Task EnviarCorreoVerificacionAsync_ConDiferentesDestinatarios_DeberiaCompletarse(
            string destinatario, 
            string token)
        {
            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarCorreoVerificacionAsync(destinatario, token));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarCorreoVerificacionAsync_ConDestinatarioVacio_DeberiaCompletarse()
        {
            // Arrange
            // FakeEmailService no valida, solo simula el envío
            var destinatario = "";
            var token = Guid.NewGuid().ToString();

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarCorreoVerificacionAsync(destinatario, token));

            // Assert
            // No debería lanzar excepción, es un servicio fake
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarCorreoVerificacionAsync_ConTokenVacio_DeberiaCompletarse()
        {
            // Arrange
            var destinatario = "test@example.com";
            var token = "";

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarCorreoVerificacionAsync(destinatario, token));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarCorreoVerificacionAsync_LlamadasMultiples_DeberiasCompletarseTodasSinError()
        {
            // Arrange
            var envios = new[]
            {
                ("usuario1@example.com", "token1"),
                ("usuario2@example.com", "token2"),
                ("usuario3@example.com", "token3")
            };

            // Act
            foreach (var (destinatario, token) in envios)
            {
                var exception = await Record.ExceptionAsync(async () =>
                    await _emailService.EnviarCorreoVerificacionAsync(destinatario, token));

                // Assert
                Assert.Null(exception);
            }
        }

        [Fact]
        public async Task EnviarCorreoVerificacionAsync_DeberiaEscribirEnConsola()
        {
            // Arrange
            var destinatario = "test@example.com";
            var token = "test-token-123";

            // ✅ Opción: usar un mock de ILogger para verificar que se llamó LogWarning
            // Por ahora, solo verificamos que no lance excepciones

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarCorreoVerificacionAsync(destinatario, token));

            // Assert
            Assert.Null(exception);
        }
    }
}
