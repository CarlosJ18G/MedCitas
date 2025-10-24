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

        #region EnviarOTPAsync

        [Fact]
        public async Task EnviarOTPAsync_DeberiaCompletarseSinError()
        {
            // Arrange
            var correo = "test@example.com";
            var codigoOTP = "123456";
            var nombreCompleto = "Carlos Jimenez";

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarOTPAsync(correo, codigoOTP, nombreCompleto));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarOTPAsync_DeberiaRetornarTaskCompletado()
        {
            // Arrange
            var correo = "usuario@example.com";
            var codigoOTP = "654321";
            var nombreCompleto = "Maria Lopez";

            // Act
            var task = _emailService.EnviarOTPAsync(correo, codigoOTP, nombreCompleto);
            await task;

            // Assert
            Assert.True(task.IsCompletedSuccessfully);
        }

        [Theory]
        [InlineData("carlos@example.com", "123456", "Carlos Jimenez")]
        [InlineData("maria@gmail.com", "654321", "Maria Lopez")]
        [InlineData("test@hotmail.com", "999888", "Test Usuario")]
        public async Task EnviarOTPAsync_ConDiferentesDatos_DeberiaCompletarse(
            string correo,
            string codigoOTP,
            string nombreCompleto)
        {
            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarOTPAsync(correo, codigoOTP, nombreCompleto));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarOTPAsync_ConCorreoVacio_DeberiaCompletarse()
        {
            // Arrange
            var correo = "";
            var codigoOTP = "123456";
            var nombreCompleto = "Test User";

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarOTPAsync(correo, codigoOTP, nombreCompleto));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarOTPAsync_ConOTPVacio_DeberiaCompletarse()
        {
            // Arrange
            var correo = "test@example.com";
            var codigoOTP = "";
            var nombreCompleto = "Test User";

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarOTPAsync(correo, codigoOTP, nombreCompleto));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarOTPAsync_ConNombreVacio_DeberiaCompletarse()
        {
            // Arrange
            var correo = "test@example.com";
            var codigoOTP = "123456";
            var nombreCompleto = "";

            // Act
            var exception = await Record.ExceptionAsync(async () =>
                await _emailService.EnviarOTPAsync(correo, codigoOTP, nombreCompleto));

            // Assert
            Assert.Null(exception);
        }

        [Fact]
        public async Task EnviarOTPAsync_LlamadasMultiples_DeberiaCompletarseTodasSinError()
        {
            // Arrange
            var envios = new[]
            {
                ("usuario1@example.com", "123456", "Usuario Uno"),
                ("usuario2@example.com", "654321", "Usuario Dos"),
                ("usuario3@example.com", "999888", "Usuario Tres")
            };

            // Act & Assert
            foreach (var (correo, otp, nombre) in envios)
            {
                var exception = await Record.ExceptionAsync(async () =>
                    await _emailService.EnviarOTPAsync(correo, otp, nombre));
                Assert.Null(exception);
            }
        }
        #endregion
    }
}
