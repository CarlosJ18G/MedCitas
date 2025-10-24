using System;
using Xunit;
using MedCitas.Core.Entities;

namespace MedCitas.Tests.Entities
{
    public class PacienteTests
    {
        #region CalcularEdad

        [Theory]
        [InlineData("2000-01-01", 25)]  // Nació en 2000, hoy es 2025
        [InlineData("1990-06-15", 35)]  // 35 años
        [InlineData("2010-12-31", 14)]  // 14 años
        [InlineData("1980-03-20", 45)]  // 45 años
        public void CalcularEdad_ConDiferentesFechas_DeberiaRetornarEdadCorrecta(string fechaNacimiento, int edadEsperada)
        {
            // Arrange
            var paciente = new Paciente
            {
                FechaNacimiento = DateTime.Parse(fechaNacimiento)
            };

            // Act
            var edad = paciente.CalcularEdad();

            // Assert
            Assert.Equal(edadEsperada, edad);
        }

        [Fact]
        public void CalcularEdad_CuandoCumpleañosNoHaPasado_DeberiaRestarUnAño()
        {
            // Arrange
            var hoy = DateTime.Today;
            var fechaNacimiento = new DateTime(hoy.Year - 30, hoy.Month, hoy.Day).AddDays(1); // Cumpleaños es mañana
            var paciente = new Paciente
            {
                FechaNacimiento = fechaNacimiento
            };

            // Act
            var edad = paciente.CalcularEdad();

            // Assert
            Assert.Equal(29, edad); // Aún tiene 29 porque no ha cumplido
        }

        [Fact]
        public void CalcularEdad_CuandoEsElDiaDelCumpleaños_DeberiaRetornarEdadCompleta()
        {
            // Arrange
            var hoy = DateTime.Today;
            var fechaNacimiento = new DateTime(hoy.Year - 25, hoy.Month, hoy.Day); // Cumple hoy
            var paciente = new Paciente
            {
                FechaNacimiento = fechaNacimiento
            };

            // Act
            var edad = paciente.CalcularEdad();

            // Assert
            Assert.Equal(25, edad);
        }

        [Fact]
        public void CalcularEdad_RecienNacido_DeberiaRetornarCero()
        {
            // Arrange
            var paciente = new Paciente
            {
                FechaNacimiento = DateTime.Today
            };

            // Act
            var edad = paciente.CalcularEdad();

            // Assert
            Assert.Equal(0, edad);
        }

        #endregion

        #region EsMayorDeEdad

        [Theory]
        [InlineData("2006-01-01", true)]  // 19 años
        [InlineData("1990-01-01", true)]  // 35 años
        [InlineData("2010-01-01", false)] // 15 años
        public void EsMayorDeEdad_ConDiferentesEdades_DeberiaRetornarResultadoCorrecto(string fechaNacimiento, bool esperado)
        {
            // Arrange
            var paciente = new Paciente
            {
                FechaNacimiento = DateTime.Parse(fechaNacimiento)
            };

            // Act
            var resultado = paciente.EsMayorDeEdad();

            // Assert
            Assert.Equal(esperado, resultado);
        }

        [Fact]
        public void EsMayorDeEdad_Con18AñosExactos_DeberiaRetornarTrue()
        {
            // Arrange
            var fechaNacimiento = DateTime.Today.AddYears(-18);
            var paciente = new Paciente
            {
                FechaNacimiento = fechaNacimiento
            };

            // Act
            var resultado = paciente.EsMayorDeEdad();

            // Assert
            Assert.True(resultado);
        }

        [Fact]
        public void EsMayorDeEdad_Con17Años11Meses_DeberiaRetornarFalse()
        {
            // Arrange
            var fechaNacimiento = DateTime.Today.AddYears(-17).AddMonths(-11);
            var paciente = new Paciente
            {
                FechaNacimiento = fechaNacimiento
            };

            // Act
            var resultado = paciente.EsMayorDeEdad();

            // Assert
            Assert.False(resultado);
        }

        #endregion

        #region EsPacientePreferencial

        [Theory]
        [InlineData("1950-01-01", true)]  // 75 años - preferencial (>= 65)
        [InlineData("1960-01-01", true)]  // 65 años - preferencial (>= 65)
        [InlineData("2015-01-01", true)]  // 10 años - preferencial (<= 12)
        [InlineData("2013-01-01", true)]  // 12 años - preferencial (<= 12)
        [InlineData("1990-01-01", false)] // 35 años - no preferencial
        [InlineData("2005-01-01", false)] // 20 años - no preferencial
        [InlineData("2011-01-01", false)] // 13 o 14 años - no preferencial
        public void EsPacientePreferencial_ConDiferentesEdades_DeberiaRetornarResultadoCorrecto(
            string fechaNacimiento,
            bool esperado)
        {
            // Arrange
            var paciente = new Paciente
            {
                FechaNacimiento = DateTime.Parse(fechaNacimiento)
            };

            // Act
            var resultado = paciente.EsPacientePreferencial();

            // Assert
            Assert.Equal(esperado, resultado);
        }

        [Fact]
        public void EsPacientePreferencial_RecienNacido_DeberiaRetornarTrue()
        {
            // Arrange
            var paciente = new Paciente
            {
                FechaNacimiento = DateTime.Today
            };

            // Act
            var resultado = paciente.EsPacientePreferencial();

            // Assert
            Assert.True(resultado); // 0 años es <= 12
        }

        [Fact]
        public void EsPacientePreferencial_Con65AñosExactos_DeberiaRetornarTrue()
        {
            // Arrange
            var fechaNacimiento = DateTime.Today.AddYears(-65);
            var paciente = new Paciente
            {
                FechaNacimiento = fechaNacimiento
            };

            // Act
            var resultado = paciente.EsPacientePreferencial();

            // Assert
            Assert.True(resultado);
        }

        [Fact]
        public void EsPacientePreferencial_Con12AñosExactos_DeberiaRetornarTrue()
        {
            // Arrange
            var fechaNacimiento = DateTime.Today.AddYears(-12);
            var paciente = new Paciente
            {
                FechaNacimiento = fechaNacimiento
            };

            // Act
            var resultado = paciente.EsPacientePreferencial();

            // Assert
            Assert.True(resultado);
        }

        [Fact]
        public void EsPacientePreferencial_Con13Años_DeberiaRetornarFalse()
        {
            // Arrange
            var fechaNacimiento = DateTime.Today.AddYears(-13);
            var paciente = new Paciente
            {
                FechaNacimiento = fechaNacimiento
            };

            // Act
            var resultado = paciente.EsPacientePreferencial();

            // Assert
            Assert.False(resultado);
        }

        #endregion
    }
}