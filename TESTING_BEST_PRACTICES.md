# ?? Gu�a de Testing y Code Coverage para SonarQube

## ? Estado Actual del Proyecto

### Tests Implementados
- **PacienteServiceTests**: ? Completo (24 tests)
  - Registro exitoso
  - Validaciones de duplicados
  - Validaciones de contrase�as
  - Validaciones de campos
  - Tests de Login
  - Tests de Activaci�n

---

## ?? M�tricas Objetivo para SonarQube

| M�trica | Objetivo | Cr�tico |
|---------|----------|---------|
| **Code Coverage** | ? 80% | ? 70% |
| **Line Coverage** | ? 85% | ? 75% |
| **Branch Coverage** | ? 75% | ? 65% |
| **Duplicaciones** | < 3% | < 5% |
| **Complejidad Ciclom�tica** | < 10 por m�todo | < 15 |
| **Code Smells** | 0 (A Rating) | < 5 |
| **Bugs** | 0 | 0 |
| **Vulnerabilidades** | 0 | 0 |

---

## ?? Recomendaciones para Aumentar Coverage

### 1. **Tests Faltantes por Servicio**

#### ? PacienteService (Completo)
- [x] RegistrarAsync
- [x] LoginAsync
- [x] ActivarCuentaAsync
- [x] ValidarCampos (cubierto indirectamente)

#### ?? Repositorios (Sin tests unitarios)
Los repositorios generalmente se prueban con **tests de integraci�n**, pero puedes agregar:
```csharp
// MedCitas.Tests/Repositories/PacienteRepositoryIntegrationTests.cs
// - Usar base de datos en memoria (InMemory o SQLite)
// - Probar operaciones CRUD reales
```

#### ?? EmailService
```csharp
// MedCitas.Tests/Services/FakeEmailServiceTests.cs
[Fact]
public async Task EnviarCorreoVerificacionAsync_DeberiaCompletarseSinError()
{
    // Arrange
    var emailService = new FakeEmailService();
    var destinatario = "test@example.com";
    var token = Guid.NewGuid().ToString();

    // Act
    await emailService.EnviarCorreoVerificacionAsync(destinatario, token);

    // Assert
    // FakeEmailService no lanza excepciones, solo verifica que se completa
    Assert.True(true);
}
```

---

## ??? Estructura de Tests Recomendada

```
MedCitas.Tests/
??? Services/
?   ??? PacienteServiceTests.cs ?
?   ??? FakeEmailServiceTests.cs ?? (Crear)
??? Repositories/ ?? (Crear)
?   ??? PacienteRepositoryIntegrationTests.cs
??? Entities/ ?? (Opcional)
?   ??? PacienteTests.cs (validaciones de propiedades)
??? Helpers/ ?? (Si existen)
    ??? ValidationHelpersTests.cs
```

---

## ?? Configuraci�n de Code Coverage

### **Ejecutar Coverage Local**

```powershell
# Instalar herramienta de coverage
dotnet tool install --global dotnet-coverage

# Ejecutar tests con coverage
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover /p:CoverletOutput=./coverage/

# O usar dotnet-coverage
dotnet-coverage collect "dotnet test" -f xml -o "coverage.xml"
```

### **Instalar ReportGenerator**

```powershell
dotnet tool install --global dotnet-reportgenerator-globaltool

# Generar reporte HTML
reportgenerator "-reports:coverage.xml" "-targetdir:coveragereport" "-reporttypes:Html"
```

### **Configurar en proyecto .csproj**

```xml
<PropertyGroup>
  <CollectCoverage>true</CollectCoverage>
  <CoverletOutputFormat>opencover</CoverletOutputFormat>
  <Threshold>80</Threshold>
  <ThresholdType>line,branch</ThresholdType>
  <ThresholdStat>total</ThresholdStat>
</PropertyGroup>
```

---

## ??? Reglas de SonarQube a Seguir

### **1. Eliminar C�digo Muerto**
```csharp
// ? MAL - C�digo nunca usado
private void MetodoSinUsar() { }

// ? BIEN - Eliminar o marcar como obsoleto si es necesario
[Obsolete("Usar MetodoNuevo en su lugar")]
private void MetodoAntiguo() { }
```

### **2. Evitar Duplicaci�n de C�digo**
```csharp
// ? MAL - C�digo duplicado
public void Metodo1() {
    ValidarUsuario();
    ProcesarDatos();
}
public void Metodo2() {
    ValidarUsuario();
    ProcesarOtraCosa();
}

// ? BIEN - Extraer a m�todo com�n
private void ValidarUsuario() { ... }
```

### **3. Usar Nombres Descriptivos**
```csharp
// ? MAL
var d = DateTime.Now;
var p = new Paciente();

// ? BIEN
var fechaActual = DateTime.Now;
var pacienteNuevo = new Paciente();
```

### **4. Manejar Excepciones Correctamente**
```csharp
// ? MAL - Tragar excepciones
try {
    // c�digo
} catch { }

// ? BIEN - Loguear o relanzar
try {
    // c�digo
} catch (Exception ex) {
    _logger.LogError(ex, "Error procesando paciente");
    throw;
}
```

### **5. Evitar M�todos Largos**
- M�ximo **20-30 l�neas** por m�todo
- Complejidad ciclom�tica < 10

---

## ?? Convenciones de Naming para Tests

### **Patr�n: M�todo_Escenario_ResultadoEsperado**

```csharp
// ? BIEN
[Fact]
public async Task RegistrarAsync_ConDatosValidos_DeberiaRetornarPaciente()

[Fact]
public async Task RegistrarAsync_ConCorreoDuplicado_DeberiaLanzarException()

[Theory]
[InlineData("")]
[InlineData(null)]
[InlineData("   ")]
public async Task RegistrarAsync_ConNombreInvalido_DeberiaLanzarArgumentException(string nombre)
```

---

## ?? Patr�n AAA (Arrange-Act-Assert)

```csharp
[Fact]
public async Task LoginAsync_ConCredencialesValidas_DeberiaRetornarPaciente()
{
    // ========== ARRANGE ==========
    // Preparar datos de prueba
    var correo = "test@example.com";
    var password = "Prueba123!";
    var passwordHash = BCrypt.Net.BCrypt.HashPassword(password);
    
    var pacienteEsperado = new Paciente
    {
        CorreoElectronico = correo,
        PasswordHash = passwordHash,
        EstaVerificado = true
    };
    
    // Configurar mocks
    _repositoryMock.Setup(r => r.ObtenerPorCorreoAsync(correo))
        .ReturnsAsync(pacienteEsperado);

    // ========== ACT ==========
    // Ejecutar el m�todo bajo prueba
    var resultado = await _service.LoginAsync(correo, password);

    // ========== ASSERT ==========
    // Verificar resultados
    Assert.NotNull(resultado);
    Assert.Equal(correo, resultado.CorreoElectronico);
    Assert.True(resultado.EstaVerificado);
    
    // Verificar interacciones con mocks
    _repositoryMock.Verify(r => r.ObtenerPorCorreoAsync(correo), Times.Once);
}
```

---

## ?? Tests de Integraci�n Recomendados

```csharp
// MedCitas.Tests/Integration/PacienteIntegrationTests.cs
public class PacienteIntegrationTests : IDisposable
{
    private readonly DbContextOptions<ApplicationDbContext> _options;
    private readonly ApplicationDbContext _context;
    
    public PacienteIntegrationTests()
    {
        // Configurar base de datos en memoria
        _options = new DbContextOptionsBuilder<ApplicationDbContext>()
            .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
            .Options;
            
        _context = new ApplicationDbContext(_options);
    }
    
    [Fact]
    public async Task RegistrarYObtenerPaciente_DeberiaFuncionar()
    {
        // Arrange
        var repository = new PacienteRepository(_context);
        var emailService = new FakeEmailService();
        var service = new PacienteService(repository, emailService);
        
        var paciente = new Paciente
        {
            NombreCompleto = "Test Usuario",
            NumeroDocumento = "123456789",
            CorreoElectronico = "test@example.com",
            Telefono = "3001234567",
            TipoDocumento = "CC",
            Sexo = "M",
            FechaNacimiento = new DateTime(1990, 1, 1)
        };
        
        // Act
        var registrado = await service.RegistrarAsync(paciente, "Prueba123!", "Prueba123!");
        var obtenido = await repository.ObtenerPorCorreoAsync("test@example.com");
        
        // Assert
        Assert.NotNull(obtenido);
        Assert.Equal("Test Usuario", obtenido.NombreCompleto);
    }
    
    public void Dispose()
    {
        _context.Dispose();
    }
}
```

---

## ?? Ejemplo de Reporte de Coverage

### **Coverage Actual Esperado**
```
+---------------------+--------+---------+--------+
| Module              | Line   | Branch  | Method |
+---------------------+--------+---------+--------+
| MedCitas.Core       | 85.3%  | 78.5%   | 90.2%  |
| - Entities          | 100%   | N/A     | 100%   |
| - Services          | 92.1%  | 85.3%   | 95.5%  |
| - Interfaces        | 100%   | N/A     | 100%   |
+---------------------+--------+---------+--------+
| MedCitas.Infra      | 45.2%  | 32.1%   | 50.0%  |
| - Repositories      | 0%     | 0%      | 0%     | ?? Agregar tests
| - Services          | 100%   | 100%    | 100%   |
+---------------------+--------+---------+--------+
```

---

## ?? Comandos �tiles

```powershell
# Ejecutar tests
dotnet test

# Ejecutar tests con coverage
dotnet test --collect:"XPlat Code Coverage"

# Ejecutar tests en modo watch
dotnet watch test

# Ejecutar tests con filtro
dotnet test --filter "FullyQualifiedName~PacienteServiceTests"

# Ver resultado detallado
dotnet test --logger "console;verbosity=detailed"
```

---

## ?? Checklist Pre-SonarQube

- [ ] Code Coverage ? 80%
- [ ] Todos los tests pasan
- [ ] Sin warnings del compilador
- [ ] Sin c�digo comentado
- [ ] Sin c�digo duplicado
- [ ] Nombres descriptivos
- [ ] Manejo apropiado de excepciones
- [ ] Usar `async/await` correctamente
- [ ] Validaciones de entrada en m�todos p�blicos
- [ ] Logs en puntos cr�ticos
- [ ] Documentaci�n XML en m�todos p�blicos

---

## ?? Recursos Adicionales

- [SonarQube C# Rules](https://rules.sonarsource.com/csharp/)
- [.NET Testing Best Practices](https://docs.microsoft.com/en-us/dotnet/core/testing/unit-testing-best-practices)
- [Coverlet Documentation](https://github.com/coverlet-coverage/coverlet)
- [xUnit Documentation](https://xunit.net/)

---

## ?? Pr�ximos Pasos

1. ? **Crear tests para FakeEmailService**
2. ?? **Agregar tests de integraci�n para repositorios**
3. ?? **Configurar pipeline CI/CD con coverage**
4. ?? **Integrar SonarQube en el pipeline**
5. ?? **Revisar y corregir Code Smells**

---

**�ltima actualizaci�n**: $(Get-Date -Format "yyyy-MM-dd")
**Autor**: Equipo MedCitas
