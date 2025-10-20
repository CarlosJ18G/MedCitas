# ?? MedCitas - Sistema de Gestión de Citas Médicas

![Tests](https://img.shields.io/badge/tests-85%20passing-brightgreen)
![Coverage](https://img.shields.io/badge/coverage-65--70%25-brightgreen)
![.NET](https://img.shields.io/badge/.NET-9.0-blue)
![C#](https://img.shields.io/badge/C%23-13.0-blue)
![Security](https://img.shields.io/badge/security%20hotspots-0-brightgreen)

Sistema web para gestión de citas médicas, registro de pacientes y administración de consultorios desarrollado con ASP.NET Core Razor Pages.

---

## ?? Tabla de Contenidos

- [Características](#-características)
- [Requisitos](#-requisitos)
- [Instalación](#-instalación)
- [Testing](#-testing)
- [Coverage](#-coverage)
- [SonarQube](#-sonarqube)
- [Arquitectura](#-arquitectura)
- [Contribuir](#-contribuir)

---

## ? Características

- ? Registro y autenticación de pacientes
- ? Verificación de correo electrónico
- ? Gestión de citas médicas
- ? Panel de administración
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

## ?? Instalación

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

### 4. Ejecutar la aplicación
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

### Ver tests específicos
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

### Métricas actuales
| Proyecto | Line Coverage | Branch Coverage |
|----------|---------------|-----------------|
| MedCitas.Core | ~75-80% | ~70-75% |
| MedCitas.Infrastructure | ~85% | ~75% |
| MedCitas.Web | ~60% | ~50% |
| **TOTAL** | **~65-70%** | **~60-65%** |

---

## ?? SonarQube

### Instalación con Docker (Recomendado)
```powershell
docker run -d --name sonarqube -p 9000:9000 sonarqube:latest
```

### Ejecutar análisis
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
??? MedCitas.Core/              # Lógica de negocio
?   ??? Entities/               # Entidades del dominio
?   ??? Services/               # Servicios de negocio
?   ??? Interfaces/             # Contratos
?
??? MedCitas.Infrastructure/    # Infraestructura
?   ??? Repositories/           # Acceso a datos
?   ??? Services/               # Servicios externos
?
??? MedCitas.Web/               # Presentación (Razor Pages)
?   ??? Pages/                  # Páginas Razor
?   ??? Controllers/            # Controladores MVC
?   ??? Models/                 # ViewModels
?
??? MedCitas.Tests/             # Tests unitarios
    ??? Services/               # Tests de servicios
    ??? Repositories/           # Tests de repositorios
    ??? Controllers/            # Tests de controladores
    ??? Models/                 # Tests de modelos
```

### Tecnologías Utilizadas
- **Framework**: ASP.NET Core 9.0 (Razor Pages)
- **ORM**: Entity Framework Core
- **Base de Datos**: SQL Server
- **Testing**: xUnit + Moq
- **Coverage**: Coverlet + ReportGenerator
- **Quality**: SonarQube
- **Password Hashing**: BCrypt.Net

---

## ?? Estadísticas del Proyecto

### Tests
- **Total**: 85 tests unitarios
- **PacienteService**: 50 tests
- **Repositories**: 14 tests
- **Controllers**: 6 tests
- **Models**: 5 tests
- **Email Service**: 7 tests

### Coverage
- **Líneas cubiertas**: ~65-70%
- **Ramas cubiertas**: ~60-65%
- **Métodos cubiertos**: ~75%

### Seguridad
- **Security Hotspots**: 0
- **Vulnerabilities**: 0
- **Security Rating**: A

---

## ??? Seguridad

### Medidas Implementadas
- ? Hash de contraseñas con BCrypt
- ? Validación de entrada con Regex + Timeout (prevención ReDoS)
- ? Tokens de verificación únicos (Guid)
- ? Validación de correo electrónico
- ? Validación de contraseñas fuertes
- ? Prevención de duplicados

### Validaciones de Contraseña
```
Requisitos mínimos:
- Al menos 8 caracteres
- Al menos 1 mayúscula
- Al menos 1 minúscula
- Al menos 1 número
- Al menos 1 carácter especial
```

---

## ?? Documentación

### Guías Disponibles
- [Testing Best Practices](TESTING_BEST_PRACTICES.md) - Guía completa de testing
- [Resumen Ejecutivo](RESUMEN_EJECUTIVO.md) - Overview del proyecto
- [Final Summary](FINAL_SUMMARY.md) - Resumen de mejoras implementadas

### Scripts Disponibles
- `run-tests-coverage.ps1` - Ejecutar tests con coverage
- `run-sonarqube-analysis.ps1` - Análisis completo con SonarQube

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
git commit -am 'Agregar nueva característica'
```

### 4. Push a la rama
```bash
git push origin feature/nueva-caracteristica
```

### 5. Crear Pull Request

---

## ?? Licencia

Este proyecto está bajo la Licencia MIT - ver [LICENSE](LICENSE) para detalles.

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

? Si te gusta este proyecto, ¡dale una estrella!
