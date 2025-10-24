using System;
using System.Threading.Tasks;
using MedCitas.Core.Entities;
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
        private readonly Mock<PacienteService> _pacienteServiceMock;
        private readonly PacienteController _controller;

        public PacienteControllerTests()
        {
            _pacienteServiceMock = new Mock<PacienteService>(
                Mock.Of<Core.Interfaces.IPacienteRepository>(),
                Mock.Of<Core.Interfaces.IEmailService>());

            _controller = new PacienteController(_pacienteServiceMock.Object);

            // Configurar HttpContext y TempData
            var httpContext = new DefaultHttpContext();
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
                NombreCompleto = "Test User"
            };

            _pacienteServiceMock
                .Setup(s => s.RegistrarAsync(It.IsAny<Paciente>(), It.IsAny<string>(), It.IsAny<string>()))
                .ReturnsAsync(paciente);

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
            var paciente = new Paciente();
            _pacienteServiceMock
                .Setup(s => s.RegistrarAsync(It.IsAny<Paciente>(), It.IsAny<string>(), It.IsAny<string>()))
                .ThrowsAsync(new Exception("Error de prueba"));

            // Act
            var resultado = await _controller.Registro(paciente, "pass", "pass");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
            Assert.Contains("Error de prueba", _controller.ViewBag.Error);
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
                CorreoElectronico = "test@example.com"
            };

            _pacienteServiceMock
                .Setup(s => s.LoginAsync("test@example.com", "Password123!"))
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
            _pacienteServiceMock
                .Setup(s => s.LoginAsync(It.IsAny<string>(), It.IsAny<string>()))
                .ReturnsAsync((Paciente?)null);

            // Act
            var resultado = await _controller.Login("test@example.com", "WrongPass");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
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
            _pacienteServiceMock
                .Setup(s => s.VerificarOTPAsync("test@example.com", "123456"))
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
            _pacienteServiceMock
                .Setup(s => s.VerificarOTPAsync("test@example.com", "000000"))
                .ReturnsAsync(false);

            // Act
            var resultado = await _controller.VerificarOTP("test@example.com", "000000");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
            Assert.Contains("OTP inválido", _controller.ViewBag.Error);
        }

        #endregion

        #region ReenviarOTP

        [Fact]
        public async Task ReenviarOTP_Exitoso_DeberiaRetornarViewConMensaje()
        {
            // Arrange
            _pacienteServiceMock
                .Setup(s => s.ReenviarOTPAsync("test@example.com"))
                .Returns(Task.CompletedTask);

            // Act
            var resultado = await _controller.ReenviarOTP("test@example.com");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
            Assert.Equal("VerificarOTP", viewResult.ViewName);
            Assert.Contains("reenviado", _controller.ViewBag.Mensaje);
        }

        [Fact]
        public async Task ReenviarOTP_ConExcepcion_DeberiaRetornarViewConError()
        {
            // Arrange
            _pacienteServiceMock
                .Setup(s => s.ReenviarOTPAsync(It.IsAny<string>()))
                .ThrowsAsync(new Exception("Error al reenviar"));

            // Act
            var resultado = await _controller.ReenviarOTP("test@example.com");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
            Assert.Contains("Error al reenviar", _controller.ViewBag.Error);
        }

        #endregion

        #region VerificarCuenta (Legacy)

        [Fact]
        public async Task VerificarCuenta_ConTokenValido_DeberiaRetornarViewConExito()
        {
            // Arrange
            _pacienteServiceMock
                .Setup(s => s.ActivarCuentaAsync("token-valido"))
                .ReturnsAsync(true);

            // Act
            var resultado = await _controller.VerificarCuenta("token-valido");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
            Assert.Contains("activada correctamente", _controller.ViewBag.Resultado);
        }

        [Fact]
        public async Task VerificarCuenta_ConTokenInvalido_DeberiaRetornarViewConError()
        {
            // Arrange
            _pacienteServiceMock
                .Setup(s => s.ActivarCuentaAsync("token-invalido"))
                .ReturnsAsync(false);

            // Act
            var resultado = await _controller.VerificarCuenta("token-invalido");

            // Assert
            var viewResult = Assert.IsType<ViewResult>(resultado);
            Assert.Contains("inválido", _controller.ViewBag.Resultado);
        }

        #endregion
    }
}