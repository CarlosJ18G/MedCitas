using System;
using Xunit;
using MedCitas.Core.Services;

namespace MedCitas.Tests.Services
{
    public class OtpServiceTests
    {
        #region GenerarOTP - Tests Esenciales

        [Fact]
        public void GenerarOTP_DeberiaRetornarCodigo6Digitos()
        {
            // Act
            var otp = OtpService.GenerarOTP();

            // Assert
            Assert.NotNull(otp);
            Assert.Equal(6, otp.Length);
            Assert.Matches(@"^\d{6}$", otp);
        }

        [Fact]
        public void GenerarOTP_DeberiaEstarEnRangoCorrecto()
        {
            // Act
            var otp = OtpService.GenerarOTP();
            var numero = int.Parse(otp);

            // Assert - Debe estar entre 100000 y 999999
            Assert.InRange(numero, 100000, 999999);
        }

        [Fact]
        public void GenerarOTP_DeberiaGenerarCodigosUnicos()
        {
            // Arrange
            var codigos = new HashSet<string>();

            // Act - Generar 50 OTPs
            for (int i = 0; i < 50; i++)
            {
                var otp = OtpService.GenerarOTP();
                codigos.Add(otp);
            }

            // Assert - Debería haber alta variedad (al menos 45 únicos de 50)
            Assert.True(codigos.Count >= 45, $"Solo se generaron {codigos.Count} códigos únicos de 50");
        }

        #endregion

        #region ObtenerFechaExpiracion - Tests Esenciales

        [Fact]
        public void ObtenerFechaExpiracion_DeberiaSer15MinutosEnFuturo()
        {
            // Arrange
            var antes = DateTime.UtcNow.AddMinutes(15);

            // Act
            var expiracion = OtpService.ObtenerFechaExpiracion();

            var despues = DateTime.UtcNow.AddMinutes(15);

            // Assert
            Assert.True(expiracion >= antes && expiracion <= despues.AddSeconds(1));
            Assert.Equal(DateTimeKind.Utc, expiracion.Kind);
        }

        #endregion

        #region ValidarOTP - Casos Críticos

        [Fact]
        public void ValidarOTP_DeberiaRetornarTrue_CuandoOTPEsValidoYNoExpirado()
        {
            // Arrange
            var otpAlmacenado = "123456";
            var otpIngresado = "123456";
            var expiracion = DateTime.UtcNow.AddMinutes(10);

            // Act
            var resultado = OtpService.ValidarOTP(otpIngresado, otpAlmacenado, expiracion);

            // Assert
            Assert.True(resultado);
        }

        [Theory]
        [InlineData("123456", "654321")]  // OTP incorrecto
        [InlineData("123456", "12345")]   // Longitud diferente
        [InlineData("123456", "")]        // OTP vacío
        public void ValidarOTP_DeberiaRetornarFalse_CuandoOTPEsIncorrecto(string almacenado, string ingresado)
        {
            // Arrange
            var expiracion = DateTime.UtcNow.AddMinutes(10);

            // Act
            var resultado = OtpService.ValidarOTP(ingresado, almacenado, expiracion);

            // Assert
            Assert.False(resultado);
        }

        [Fact]
        public void ValidarOTP_DeberiaRetornarFalse_CuandoOTPExpirado()
        {
            // Arrange
            var otpAlmacenado = "123456";
            var otpIngresado = "123456";
            var expiracion = DateTime.UtcNow.AddMinutes(-1); // Expiró hace 1 minuto

            // Act
            var resultado = OtpService.ValidarOTP(otpIngresado, otpAlmacenado, expiracion);

            // Assert
            Assert.False(resultado);
        }

        [Theory]
        [InlineData(null, "123456", true)]      // OTP ingresado null
        [InlineData("123456", null, true)]      // OTP almacenado null
        [InlineData("123456", "123456", false)] // Expiración null
        public void ValidarOTP_DeberiaRetornarFalse_CuandoParametrosNull(string? ingresado, string? almacenado, bool expiracionValida)
        {
            // Arrange
            DateTime? expiracion = expiracionValida ? DateTime.UtcNow.AddMinutes(10) : null;

            // Act
            var resultado = OtpService.ValidarOTP(ingresado!, almacenado!, expiracion);

            // Assert
            Assert.False(resultado);
        }

        #endregion

        #region Integración - Flujo Completo

        [Fact]
        public void FlujoCompleto_GenerarYValidarOTP_DeberiaFuncionar()
        {
            // Arrange - Simular generación de OTP
            var otpGenerado = OtpService.GenerarOTP();
            var expiracion = OtpService.ObtenerFechaExpiracion();

            // Act - Validar con el mismo OTP
            var resultado = OtpService.ValidarOTP(otpGenerado, otpGenerado, expiracion);

            // Assert
            Assert.True(resultado);
        }

        [Fact]
        public void FlujoCompleto_GenerarYValidarConOTPIncorrecto_DeberiaFallar()
        {
            // Arrange
            var otpGenerado = OtpService.GenerarOTP();
            var expiracion = OtpService.ObtenerFechaExpiracion();
            var otpIncorrecto = "000000";

            // Act
            var resultado = OtpService.ValidarOTP(otpIncorrecto, otpGenerado, expiracion);

            // Assert
            Assert.False(resultado);
        }

        #endregion
    }
}