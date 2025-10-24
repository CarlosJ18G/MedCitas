using System;
using System.Threading.Tasks;
using MedCitas.Core.Entities;
using MedCitas.Core.Interfaces;
using MedCitas.Core.Services;
using MedCitas.Web.Controllers;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Moq;
using Xunit;

namespace MedCitas.Tests.Controllers
{
    public class PacienteControllerTests
    {
        private readonly Mock<IPacienteRepository> _pacienteRepositoryMock;
        private readonly Mock<IEmailService> _emailServiceMock;
        private readonly PacienteService _pacienteService;
        private readonly PacienteController _controller;

        public PacienteControllerTests()
        {
            _pacienteRepositoryMock = new Mock<IPacienteRepository>();
            _emailServiceMock = new Mock<IEmailService>();
            
            _pacienteService = new PacienteService(
                _pacienteRepositoryMock.Object,
                _emailServiceMock.Object);

            _controller = new PacienteController(_pacienteService);

            // Configurar HttpContext y TempData
            var httpContext = new DefaultHttpContext();
            httpContext.Session = new Mock<ISession>().Object;
            var tempData = new TempDataDictionary(httpContext, Mock.Of<ITempDataProvider>());
            _controller.TempData = tempData;
            _controller.ControllerContext = new ControllerContext
            {
                HttpContext = httpContext
            };
        }

        #region Registro GET

        [Fact]
        public void RegistroGet_DeberiaRetornarView()
        {
            // Act
            var resultado = _controller.Registro();

            // Assert
            Assert.IsType<ViewResult>(resultado);
        }

        #endregion

        #region Registro POST

        [Fact]
        public async Task RegistroPost_ConDatosValidos_DeberiaRedirigirAVerificarOTP()
        {
            // Arrange
            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                NombreCompleto = "Test User",
                NumeroDocumento = "12345678",
                Telefono = "3001234567",
                TipoDocumento = "CC"
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync(It.IsAny<string>()))
                .ReturnsAsync((Paciente?)null);

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorDocumentoAsync(It.IsAny<string>()))
                .ReturnsAsync((Paciente?)null);

            _pacienteRepositoryMock
                .Setup(r => r.RegistrarAsync(It.IsAny<Paciente>()))
                .Returns(Task.CompletedTask);

            _emailServiceMock
                .Setup(e => e.EnviarOTPAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>()))
                .Returns(Task.CompletedTask);

            // Act
            var resultado = await _controller.Registro(paciente, "Password123!", "Password123!");

            // Assert
            var redirectResult = Assert.IsType<RedirectToActionResult>(resultado);
            Assert.Equal("VerificarOTP", redirectResult.ActionName);
            Assert.Equal("test@example.com", _controller.TempData["CorreoRegistrado"]);
        }

        [Fact]
        public async Task RegistroPost_ConExcepcion_DeberiaRetornarViewConError()
        {
            // Arrange
            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                NombreCompleto = "Test User",
                NumeroDocumento = "12345678",
                Telefono = "3001234567",
                TipoDocumento = "CC"
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync(It.IsAny<string>()))
                .ThrowsAsync(new Exception("Error de prueba"));

            // Act
            var resultado = await _controller.Registro(paciente, "Password123!", "Password123!");

            // Assert
            Assert.IsType<ViewResult>(resultado);
            Assert.Contains("Error de prueba", _controller.ViewBag.Error.ToString());
        }

        #endregion

        #region Login GET

        [Fact]
        public void LoginGet_DeberiaRetornarView()
        {
            // Act
            var resultado = _controller.Login();

            // Assert
            Assert.IsType<ViewResult>(resultado);
        }

        #endregion

        #region Login POST

        [Fact]
        public async Task LoginPost_ConCredencialesValidas_DeberiaRedirigirAHome()
        {
            // Arrange
            var paciente = new Paciente
            {
                Id = Guid.NewGuid(),
                NombreCompleto = "Test User",
                CorreoElectronico = "test@example.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("Password123!"),
                EstaVerificado = true
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ReturnsAsync(paciente);

            // Act
            var resultado = await _controller.Login("test@example.com", "Password123!");

            // Assert
            var redirectResult = Assert.IsType<RedirectToActionResult>(resultado);
            Assert.Equal("Index", redirectResult.ActionName);
            Assert.Equal("Home", redirectResult.ControllerName);
        }

        [Fact]
        public async Task LoginPost_ConCredencialesInvalidas_DeberiaRetornarViewConError()
        {
            // Arrange
            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync(It.IsAny<string>()))
                .ReturnsAsync((Paciente?)null);

            // Act
            var resultado = await _controller.Login("test@example.com", "WrongPass");

            // Assert
            Assert.IsType<ViewResult>(resultado);
            Assert.Equal("Credenciales incorrectas.", _controller.ViewBag.Error);
        }

        #endregion

        #region VerificarOTP GET

        [Fact]
        public void VerificarOTPGet_DeberiaRetornarView()
        {
            // Act
            var resultado = _controller.VerificarOTP();

            // Assert
            Assert.IsType<ViewResult>(resultado);
        }

        #endregion

        #region VerificarOTP POST

        [Fact]
        public async Task VerificarOTPPost_ConOTPValido_DeberiaRedirigirALogin()
        {
            // Arrange
            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                CodigoOTP = "123456",
                OTPExpiracion = DateTime.UtcNow.AddMinutes(15),
                IntentosOTPFallidos = 0,
                EstaVerificado = false
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ReturnsAsync(paciente);

            _pacienteRepositoryMock
                .Setup(r => r.VerificarOTPAsync("test@example.com", "123456"))
                .ReturnsAsync(true);

            // Act
            var resultado = await _controller.VerificarOTP("test@example.com", "123456");

            // Assert
            var redirectResult = Assert.IsType<RedirectToActionResult>(resultado);
            Assert.Equal("Login", redirectResult.ActionName);
        }

        [Fact]
        public async Task VerificarOTPPost_ConOTPInvalido_DeberiaRetornarViewConError()
        {
            // Arrange
            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                CodigoOTP = "123456",
                OTPExpiracion = DateTime.UtcNow.AddMinutes(15),
                IntentosOTPFallidos = 0,
                EstaVerificado = false
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ReturnsAsync(paciente);

            _pacienteRepositoryMock
                .Setup(r => r.ActualizarOTPAsync(It.IsAny<Paciente>()))
                .Returns(Task.CompletedTask);

            _pacienteRepositoryMock
                .Setup(r => r.VerificarOTPAsync("test@example.com", "000000"))
                .ReturnsAsync(false);

            // Act
            var resultado = await _controller.VerificarOTP("test@example.com", "000000");

            // Assert
            Assert.IsType<ViewResult>(resultado);
            Assert.Contains("OTP inválido", _controller.ViewBag.Error.ToString());
        }

        #endregion

        #region ReenviarOTP

        [Fact]
        public async Task ReenviarOTP_Exitoso_DeberiaRetornarViewConMensaje()
        {
            // Arrange
            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                NombreCompleto = "Test User",
                EstaVerificado = false
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ReturnsAsync(paciente);

            _pacienteRepositoryMock
                .Setup(r => r.ActualizarOTPAsync(It.IsAny<Paciente>()))
                .Returns(Task.CompletedTask);

            _emailServiceMock
                .Setup(e => e.EnviarOTPAsync(It.IsAny<string>(), It.IsAny<string>(), It.IsAny<string>()))
                .Returns(Task.CompletedTask);

            // Act
            var resultado = await _controller.ReenviarOTP("test@example.com");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
            Assert.Equal("VerificarOTP", viewResult.ViewName);
            Assert.Contains("reenviado", _controller.ViewBag.Mensaje.ToString());
        }

        [Fact]
        public async Task ReenviarOTP_ConExcepcion_DeberiaRetornarViewConError()
        {
            // Arrange
            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync(It.IsAny<string>()))
                .ThrowsAsync(new Exception("Error al reenviar"));

            // Act
            var resultado = await _controller.ReenviarOTP("test@example.com");

            // Assert
            Assert.IsType<ViewResult>(resultado);
            Assert.Contains("Error al reenviar", _controller.ViewBag.Error.ToString());
        }

        #endregion

        #region VerificarCuenta (Legacy)

        [Fact]
        public async Task VerificarCuenta_ConTokenValido_DeberiaRetornarViewConExito()
        {
            // Arrange
            _pacienteRepositoryMock
                .Setup(r => r.ActivarCuentaAsync("token-valido"))
                .ReturnsAsync(true);

            // Act
            var resultado = await _controller.VerificarCuenta("token-valido");

            // Assert
            Assert.IsType<ViewResult>(resultado);
            Assert.Contains("activada correctamente", _controller.ViewBag.Resultado.ToString());
        }

        [Fact]
        public async Task VerificarCuenta_ConTokenInvalido_DeberiaRetornarViewConError()
        {
            // Arrange
            _pacienteRepositoryMock
                .Setup(r => r.ActivarCuentaAsync("token-invalido"))
                .ReturnsAsync(false);

            // Act
            var resultado = await _controller.VerificarCuenta("token-invalido");

            // Assert
            Assert.IsType<ViewResult>(resultado);
            Assert.Contains("inválido", _controller.ViewBag.Resultado.ToString());
        }

        #endregion
    }
}