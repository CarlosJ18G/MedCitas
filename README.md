# ?? MedCitas - Sistema de Gesti�n de Citas M�dicas

![Tests](https://img.shields.io/badge/tests-85%20passing-brightgreen)
![Coverage](https://img.shields.io/badge/coverage-65--70%25-brightgreen)
![.NET](https://img.shields.io/badge/.NET-9.0-blue)
![C#](https://img.shields.io/badge/C%23-13.0-blue)
![Security](https://img.shields.io/badge/security%20hotspots-0-brightgreen)

Sistema web para gesti�n de citas m�dicas, registro de pacientes y administraci�n de consultorios desarrollado con ASP.NET Core Razor Pages.

---

## ?? Tabla de Contenidos

- [Caracter�sticas](#-caracter�sticas)
- [Requisitos](#-requisitos)
- [Instalaci�n](#-instalaci�n)
- [Testing](#-testing)
- [Coverage](#-coverage)
- [SonarQube](#-sonarqube)
- [Arquitectura](#-arquitectura)
- [Contribuir](#-contribuir)

---

## ? Caracter�sticas

- ? Registro y autenticaci�n de pacientes
- ? Verificaci�n de correo electr�nico
- ? Gesti�n de citas m�dicas
- ? Panel de administraci�n
- ? Notificaciones por email
- ? Seguridad con BCrypt
- ? Validaciones robustas

---

## ?? Requisitos

- **.NET 9 SDK** - [Descargar](https://dotnet.microsoft.com/download/dotnet/9.0)
- **SQL Server** (LocalDB o Express)
- **Visual Studio 2022** o **VS Code**
- **Git** para control de versiones

---

## ?? Instalaci�n

### 1. Clonar el repositorio
```bash
git clone https://github.com/CarlosJ18G/MedCitas.git
cd MedCitas
```

### 2. Restaurar dependencias
```bash
dotnet restore
```

### 3. Ejecutar migraciones
```bash
dotnet ef database update --project MedCitas.Infrastructure
```

### 4. Ejecutar la aplicaci�n
```bash
dotnet run --project MedCitas.Web
```

### 5. Abrir en navegador
```
https://localhost:5001
```

---

## ?? Testing

### Ejecutar todos los tests
```powershell
dotnet test
```

### Ver tests espec�ficos
```powershell
# Solo tests de PacienteService
dotnet test --filter "FullyQualifiedName~PacienteServiceTests"

# Solo tests de Repository
dotnet test --filter "FullyQualifiedName~RepositoryTests"
```

### Tests con verbose
```powershell
dotnet test --logger "console;verbosity=detailed"
```

---

## ?? Coverage

### Script automatizado (Recomendado)
```powershell
.\run-tests-coverage.ps1
```

Este script:
1. Ejecuta todos los tests
2. Genera reporte de coverage
3. Abre el reporte HTML en el navegador

### Coverage manual
```powershell
# Ejecutar con coverage
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# Generar reporte HTML
reportgenerator "-reports:MedCitas.Tests/coverage/coverage.opencover.xml" "-targetdir:coverage-report" "-reporttypes:Html"

# Abrir reporte
Start-Process "coverage-report/index.html"
```

### M�tricas actuales
| Proyecto | Line Coverage | Branch Coverage |
|----------|---------------|-----------------|
| MedCitas.Core | ~75-80% | ~70-75% |
| MedCitas.Infrastructure | ~85% | ~75% |
| MedCitas.Web | ~60% | ~50% |
| **TOTAL** | **~65-70%** | **~60-65%** |

---

## ?? SonarQube

### Instalaci�n con Docker (Recomendado)
```powershell
docker run -d --name sonarqube -p 9000:9000 sonarqube:latest
```

### Ejecutar an�lisis
```powershell
.\run-sonarqube-analysis.ps1 -SonarToken "TU_TOKEN_AQUI"
```

### Ver resultados
```
http://localhost:9000/dashboard?id=MedCitasAPI
```

### Quality Gate actual
- ? Security: A Rating (0 hotspots)
- ? Reliability: A Rating
- ? Maintainability: A Rating
- ? Coverage: ~65-70%

---

## ??? Arquitectura

### Estructura del Proyecto
```
MedCitas/
??? MedCitas.Core/              # L�gica de negocio
?   ??? Entities/               # Entidades del dominio
?   ??? Services/               # Servicios de negocio
?   ??? Interfaces/             # Contratos
?
??? MedCitas.Infrastructure/    # Infraestructura
?   ??? Repositories/           # Acceso a datos
?   ??? Services/               # Servicios externos
?
??? MedCitas.Web/               # Presentaci�n (Razor Pages)
?   ??? Pages/                  # P�ginas Razor
?   ??? Controllers/            # Controladores MVC
?   ??? Models/                 # ViewModels
?
??? MedCitas.Tests/             # Tests unitarios
    ??? Services/               # Tests de servicios
    ??? Repositories/           # Tests de repositorios
    ??? Controllers/            # Tests de controladores
    ??? Models/                 # Tests de modelos
```

### Tecnolog�as Utilizadas
- **Framework**: ASP.NET Core 9.0 (Razor Pages)
- **ORM**: Entity Framework Core
- **Base de Datos**: SQL Server
- **Testing**: xUnit + Moq
- **Coverage**: Coverlet + ReportGenerator
- **Quality**: SonarQube
- **Password Hashing**: BCrypt.Net

---

## ?? Estad�sticas del Proyecto

### Tests
- **Total**: 85 tests unitarios
- **PacienteService**: 50 tests
- **Repositories**: 14 tests
- **Controllers**: 6 tests
- **Models**: 5 tests
- **Email Service**: 7 tests

### Coverage
- **L�neas cubiertas**: ~65-70%
- **Ramas cubiertas**: ~60-65%
- **M�todos cubiertos**: ~75%

### Seguridad
- **Security Hotspots**: 0
- **Vulnerabilities**: 0
- **Security Rating**: A

---

## ??? Seguridad

### Medidas Implementadas
- ? Hash de contrase�as con BCrypt
- ? Validaci�n de entrada con Regex + Timeout (prevenci�n ReDoS)
- ? Tokens de verificaci�n �nicos (Guid)
- ? Validaci�n de correo electr�nico
- ? Validaci�n de contrase�as fuertes
- ? Prevenci�n de duplicados

### Validaciones de Contrase�a
```
Requisitos m�nimos:
- Al menos 8 caracteres
- Al menos 1 may�scula
- Al menos 1 min�scula
- Al menos 1 n�mero
- Al menos 1 car�cter especial
```

---

## ?? Documentaci�n

### Gu�as Disponibles
- [Testing Best Practices](TESTING_BEST_PRACTICES.md) - Gu�a completa de testing
- [Resumen Ejecutivo](RESUMEN_EJECUTIVO.md) - Overview del proyecto
- [Final Summary](FINAL_SUMMARY.md) - Resumen de mejoras implementadas

### Scripts Disponibles
- `run-tests-coverage.ps1` - Ejecutar tests con coverage
- `run-sonarqube-analysis.ps1` - An�lisis completo con SonarQube

---

## ?? Contribuir

### 1. Fork el proyecto
```bash
git clone https://github.com/TU_USUARIO/MedCitas.git
```

### 2. Crear rama
```bash
git checkout -b feature/nueva-caracteristica
```

### 3. Commit cambios
```bash
git commit -am 'Agregar nueva caracter�stica'
```

### 4. Push a la rama
```bash
git push origin feature/nueva-caracteristica
```

### 5. Crear Pull Request

---

## ?? Licencia

Este proyecto est� bajo la Licencia MIT - ver [LICENSE](LICENSE) para detalles.

---

## ?? Autor

**Carlos Jimenez**
- GitHub: [@CarlosJ18G](https://github.com/CarlosJ18G)
- Proyecto: [MedCitas](https://github.com/CarlosJ18G/MedCitas)

---

## ?? Agradecimientos

- ASP.NET Core Team
- xUnit Contributors
- SonarQube Community

---

? Si te gusta este proyecto, �dale una estrella!
