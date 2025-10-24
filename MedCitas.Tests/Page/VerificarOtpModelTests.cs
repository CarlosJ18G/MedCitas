using System;
using System.Threading.Tasks;
using MedCitas.Core.Entities;
using MedCitas.Core.Interfaces;
using MedCitas.Core.Services;
using MedCitas.Web.Pages.Cuenta;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ModelBinding;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using Microsoft.AspNetCore.Routing;
using Moq;
using Xunit;

namespace MedCitas.Tests.Pages.Cuenta
{
    public class VerificarOtpModelTests
    {
        private readonly Mock<IPacienteRepository> _pacienteRepositoryMock;
        private readonly Mock<IEmailService> _emailServiceMock;
        private readonly PacienteService _pacienteService;
        private readonly VerificarOtpModel _pageModel;

        public VerificarOtpModelTests()
        {
            _pacienteRepositoryMock = new Mock<IPacienteRepository>();
            _emailServiceMock = new Mock<IEmailService>();
            _pacienteService = new PacienteService(
                _pacienteRepositoryMock.Object,
                _emailServiceMock.Object);

            _pageModel = new VerificarOtpModel(_pacienteService);

            // Configurar PageContext
            var httpContext = new DefaultHttpContext();
            var modelState = new ModelStateDictionary();
            var actionContext = new ActionContext(httpContext, new RouteData(), new PageActionDescriptor(), modelState);
            var modelMetadataProvider = new EmptyModelMetadataProvider();
            var viewData = new ViewDataDictionary(modelMetadataProvider, modelState);
            var tempData = new TempDataDictionary(httpContext, Mock.Of<ITempDataProvider>());
            var pageContext = new PageContext(actionContext)
            {
                ViewData = viewData
            };

            _pageModel.PageContext = pageContext;
            _pageModel.TempData = tempData;
        }

        #region OnGet

        [Fact]
        public void OnGet_ConCorreoValido_DeberiaAsignarCorreo()
        {
            // Arrange
            var correoEsperado = "test@example.com";

            // Act
            _pageModel.OnGet(correoEsperado);

            // Assert
            Assert.Equal(correoEsperado, _pageModel.Correo);
        }

        [Fact]
        public void OnGet_ConCorreoNull_DeberiaAsignarStringVacio()
        {
            // Act
            _pageModel.OnGet(null!);

            // Assert
            Assert.Equal(string.Empty, _pageModel.Correo);
        }

        [Fact]
        public void OnGet_ConCorreoVacio_DeberiaAsignarStringVacio()
        {
            // Act
            _pageModel.OnGet(string.Empty);

            // Assert
            Assert.Equal(string.Empty, _pageModel.Correo);
        }

        #endregion

        #region OnPostAsync - Casos Exitosos

        [Fact]
        public async Task OnPostAsync_ConOTPValido_DeberiaRedirigirALogin()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "123456";

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
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            var redirectResult = Assert.IsType<RedirectToPageResult>(resultado);
            Assert.Equal("/Cuenta/Login", redirectResult.PageName);
            Assert.True(_pageModel.Exitoso);
            Assert.Equal("¡Cuenta verificada exitosamente!", _pageModel.Mensaje);
        }

        [Fact]
        public async Task OnPostAsync_ConOTPValido_DeberiaLlamarVerificarOTPAsync()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "654321";

            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                CodigoOTP = "654321",
                OTPExpiracion = DateTime.UtcNow.AddMinutes(10),
                IntentosOTPFallidos = 0,
                EstaVerificado = false
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ReturnsAsync(paciente);

            _pacienteRepositoryMock
                .Setup(r => r.VerificarOTPAsync("test@example.com", "654321"))
                .ReturnsAsync(true);

            // Act
            await _pageModel.OnPostAsync();

            // Assert
            _pacienteRepositoryMock.Verify(
                r => r.VerificarOTPAsync("test@example.com", "654321"),
                Times.Once);
        }

        #endregion

        #region OnPostAsync - OTP Inválido

        [Fact]
        public async Task OnPostAsync_ConOTPInvalido_DeberiaRetornarPageConMensajeError()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "000000";

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
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.False(_pageModel.Exitoso);
            Assert.Equal("Código OTP inválido o expirado.", _pageModel.Mensaje);
        }

        [Fact]
        public async Task OnPostAsync_ConOTPExpirado_DeberiaRetornarPageConMensajeError()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "123456";

            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                CodigoOTP = "123456",
                OTPExpiracion = DateTime.UtcNow.AddMinutes(-1), // Expirado
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
                .Setup(r => r.VerificarOTPAsync("test@example.com", "123456"))
                .ReturnsAsync(false);

            // Act
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.False(_pageModel.Exitoso);
            Assert.Equal("Código OTP inválido o expirado.", _pageModel.Mensaje);
        }

        #endregion

        #region OnPostAsync - ModelState Inválido

        [Fact]
        public async Task OnPostAsync_ConModelStateInvalido_DeberiaRetornarPage()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "12345"; // Solo 5 dígitos (inválido)
            _pageModel.ModelState.AddModelError("CodigoOTP", "El código debe tener 6 dígitos");

            // Act
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            _pacienteRepositoryMock.Verify(
                r => r.VerificarOTPAsync(It.IsAny<string>(), It.IsAny<string>()),
                Times.Never);
        }

        [Fact]
        public async Task OnPostAsync_ConCorreoVacio_DeberiaRetornarPage()
        {
            // Arrange
            _pageModel.Correo = string.Empty;
            _pageModel.CodigoOTP = "123456";
            _pageModel.ModelState.AddModelError("Correo", "El correo es obligatorio");

            // Act
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
        }

        [Fact]
        public async Task OnPostAsync_ConOTPVacio_DeberiaRetornarPage()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = string.Empty;
            _pageModel.ModelState.AddModelError("CodigoOTP", "El código OTP es obligatorio");

            // Act
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
        }

        #endregion

        #region OnPostAsync - Excepciones

        [Fact]
        public async Task OnPostAsync_ConExcepcion_DeberiaRetornarPageConMensajeError()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "123456";

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ThrowsAsync(new Exception("Error de base de datos"));

            // Act
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.False(_pageModel.Exitoso);
            Assert.Equal("Error de base de datos", _pageModel.Mensaje);
        }

        [Fact]
        public async Task OnPostAsync_ConInvalidOperationException_DeberiaCapturarExcepcion()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "123456";

            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                CodigoOTP = "123456",
                OTPExpiracion = DateTime.UtcNow.AddMinutes(15),
                IntentosOTPFallidos = 3, // Máximo intentos alcanzado
                EstaVerificado = false
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ReturnsAsync(paciente);

            // Act
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.False(_pageModel.Exitoso);
            Assert.Contains("intentos fallidos", _pageModel.Mensaje);
        }

        #endregion

        #region OnPostReenviarAsync - Casos Exitosos

        [Fact]
        public async Task OnPostReenviarAsync_ConCorreoValido_DeberiaRetornarPageConMensajeExito()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";

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
            var resultado = await _pageModel.OnPostReenviarAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.True(_pageModel.Exitoso);
            Assert.Equal("Código reenviado exitosamente.", _pageModel.Mensaje);
        }

        [Fact]
        public async Task OnPostReenviarAsync_DeberiaLlamarReenviarOTPAsync()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";

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
            await _pageModel.OnPostReenviarAsync();

            // Assert
            _pacienteRepositoryMock.Verify(
                r => r.ObtenerPorCorreoAsync("test@example.com"),
                Times.Once);
            _pacienteRepositoryMock.Verify(
                r => r.ActualizarOTPAsync(It.IsAny<Paciente>()),
                Times.Once);
            _emailServiceMock.Verify(
                e => e.EnviarOTPAsync("test@example.com", It.IsAny<string>(), "Test User"),
                Times.Once);
        }

        [Fact]
        public async Task OnPostReenviarAsync_DeberiaGenerarNuevoOTP()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";

            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                NombreCompleto = "Test User",
                CodigoOTP = "123456",
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
            await _pageModel.OnPostReenviarAsync();

            // Assert
            _pacienteRepositoryMock.Verify(
                r => r.ActualizarOTPAsync(It.Is<Paciente>(p =>
                    p.CodigoOTP != "123456" &&
                    p.CodigoOTP!.Length == 6 &&
                    p.IntentosOTPFallidos == 0)),
                Times.Once);
        }

        #endregion

        #region OnPostReenviarAsync - Excepciones

        [Fact]
        public async Task OnPostReenviarAsync_ConUsuarioNoEncontrado_DeberiaRetornarPageConError()
        {
            // Arrange
            _pageModel.Correo = "noexiste@example.com";

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("noexiste@example.com"))
                .ReturnsAsync((Paciente?)null);

            // Act
            var resultado = await _pageModel.OnPostReenviarAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.False(_pageModel.Exitoso);
            Assert.Equal("Usuario no encontrado.", _pageModel.Mensaje);
        }

        [Fact]
        public async Task OnPostReenviarAsync_ConCuentaYaVerificada_DeberiaRetornarPageConError()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";

            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                NombreCompleto = "Test User",
                EstaVerificado = true
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ReturnsAsync(paciente);

            // Act
            var resultado = await _pageModel.OnPostReenviarAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.False(_pageModel.Exitoso);
            Assert.Equal("La cuenta ya está verificada.", _pageModel.Mensaje);
        }

        [Fact]
        public async Task OnPostReenviarAsync_ConExcepcionGenerica_DeberiaRetornarPageConError()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync("test@example.com"))
                .ThrowsAsync(new Exception("Error de conexión"));

            // Act
            var resultado = await _pageModel.OnPostReenviarAsync();

            // Assert
            Assert.IsType<PageResult>(resultado);
            Assert.False(_pageModel.Exitoso);
            Assert.Equal("Error de conexión", _pageModel.Mensaje);
        }

        #endregion

        #region Validaciones de Propiedades

        [Theory]
        [InlineData("test@example.com", "123456", true)]
        [InlineData("user@domain.com", "654321", true)]
        [InlineData("", "123456", false)]
        [InlineData("test@example.com", "", false)]
        [InlineData("invalid-email", "123456", false)]
        [InlineData("test@example.com", "12345", false)] // Solo 5 dígitos
        [InlineData("test@example.com", "1234567", false)] // 7 dígitos
        public void PropiedadesBindProperty_DeberianValidarseCorrectamente(
            string correo,
            string codigoOTP,
            bool esValido)
        {
            // Arrange
            _pageModel.Correo = correo;
            _pageModel.CodigoOTP = codigoOTP;

            // Act
            var validationContext = new System.ComponentModel.DataAnnotations.ValidationContext(_pageModel);
            var validationResults = new System.Collections.Generic.List<System.ComponentModel.DataAnnotations.ValidationResult>();
            var isValid = System.ComponentModel.DataAnnotations.Validator.TryValidateObject(
                _pageModel,
                validationContext,
                validationResults,
                validateAllProperties: true);

            // Assert
            Assert.Equal(esValido, isValid);
        }

        #endregion

        #region Edge Cases

        [Fact]
        public async Task OnPostAsync_ConCorreoConEspacios_DeberiaFuncionar()
        {
            // Arrange
            _pageModel.Correo = " test@example.com ";
            _pageModel.CodigoOTP = "123456";

            var paciente = new Paciente
            {
                CorreoElectronico = "test@example.com",
                CodigoOTP = "123456",
                OTPExpiracion = DateTime.UtcNow.AddMinutes(15),
                IntentosOTPFallidos = 0,
                EstaVerificado = false
            };

            _pacienteRepositoryMock
                .Setup(r => r.ObtenerPorCorreoAsync(It.IsAny<string>()))
                .ReturnsAsync(paciente);

            _pacienteRepositoryMock
                .Setup(r => r.VerificarOTPAsync(It.IsAny<string>(), "123456"))
                .ReturnsAsync(true);

            // Act
            var resultado = await _pageModel.OnPostAsync();

            // Assert
            var redirectResult = Assert.IsType<RedirectToPageResult>(resultado);
            Assert.Equal("/Cuenta/Login", redirectResult.PageName);
        }

        [Fact]
        public async Task OnPostAsync_LlamadaSimultanea_DeberiaFuncionar()
        {
            // Arrange
            _pageModel.Correo = "test@example.com";
            _pageModel.CodigoOTP = "123456";

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
            var task1 = _pageModel.OnPostAsync();
            var task2 = _pageModel.OnPostAsync();

            var resultados = await Task.WhenAll(task1, task2);

            // Assert
            Assert.IsType<RedirectToPageResult>(resultados[0]);
            Assert.IsType<RedirectToPageResult>(resultados[1]);
        }

        #endregion
    }
}