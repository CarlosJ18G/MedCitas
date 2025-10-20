using Xunit;
using MedCitas.Web.Models;

namespace MedCitas.Tests.Models
{
    public class ErrorViewModelTests
    {
        [Fact]
        public void ShowRequestId_ConRequestIdNull_DeberiaRetornarFalse()
        {
            // Arrange
            var model = new ErrorViewModel
            {
                RequestId = null
            };

            // Act
            var resultado = model.ShowRequestId;

            // Assert
            Assert.False(resultado);
        }

        [Fact]
        public void ShowRequestId_ConRequestIdVacio_DeberiaRetornarFalse()
        {
            // Arrange
            var model = new ErrorViewModel
            {
                RequestId = string.Empty
            };

            // Act
            var resultado = model.ShowRequestId;

            // Assert
            Assert.False(resultado);
        }

        [Fact]
        public void ShowRequestId_ConRequestIdValido_DeberiaRetornarTrue()
        {
            // Arrange
            var model = new ErrorViewModel
            {
                RequestId = "12345"
            };

            // Act
            var resultado = model.ShowRequestId;

            // Assert
            Assert.True(resultado);
        }

        [Theory]
        [InlineData("abc-123")]
        [InlineData("request-id-456")]
        [InlineData("guid-789")]
        public void ShowRequestId_ConDiferentesRequestIds_DeberiaRetornarTrue(string requestId)
        {
            // Arrange
            var model = new ErrorViewModel
            {
                RequestId = requestId
            };

            // Act
            var resultado = model.ShowRequestId;

            // Assert
            Assert.True(resultado);
        }

        [Fact]
        public void RequestId_DeberiaPermitirAsignarYObtenerValor()
        {
            // Arrange
            var expectedRequestId = "test-request-id";
            var model = new ErrorViewModel();

            // Act
            model.RequestId = expectedRequestId;

            // Assert
            Assert.Equal(expectedRequestId, model.RequestId);
        }
    }
}
