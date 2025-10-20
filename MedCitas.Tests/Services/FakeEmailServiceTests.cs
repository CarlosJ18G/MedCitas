using System;
using System.IO;
using System.Threading.Tasks;
using Xunit;
using MedCitas.Infrastructure.Services;

namespace MedCitas.Tests.Services
{
    public class FakeEmailServiceTests
    {
        private readonly FakeEmailService _emailService;

        public FakeEmailServiceTests()
        {
            _emailService = new FakeEmailService();
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
            var salida = new StringWriter();
            Console.SetOut(salida);

            // Act
            await _emailService.EnviarCorreoVerificacionAsync(destinatario, token);

            // Assert
            var textoSalida = salida.ToString();
            Assert.Contains(destinatario, textoSalida);
            Assert.Contains(token, textoSalida);
            Assert.Contains("[EMAIL SIMULADO]", textoSalida);

            // Restaurar consola
            Console.SetOut(Console.Out);
        }
    }
}
