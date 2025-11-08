# ? CHECKLIST DE EJECUCIÓN Y VALIDACIÓN

## ?? Pasos para Validar las Mejoras de Coverage

### Fase 1: Validación Inicial ?

- [x] **Build del proyecto exitoso**
  ```bash
  dotnet build
  ```
  
- [x] **Archivos de tests creados**
  - [x] EmailServiceTests.cs
  - [x] ErrorViewModelTests.cs
  - [x] PacienteControllerTests.cs (ampliado)
  - [x] PacienteTests.cs (ampliado)

- [x] **Documentación generada**
  - [x] PLAN_MEJORA_COVERAGE.md
  - [x] COVERAGE_README.md
  - [x] RESUMEN_COVERAGE.md
  - [x] CHECKLIST.md (este archivo)

- [x] **Scripts de automatización creados**
  - [x] run-coverage.ps1 (Windows)
  - [x] run-coverage.sh (Linux/Mac)

---

### Fase 2: Ejecutar Tests ??

#### Paso 1: Ejecutar Todos los Tests
```bash
cd C:\Users\Carlos\source\repos\MedCitas
dotnet test
```

**Resultado Esperado:**
```
Passed!  - Failed:     0, Passed:    60+, Skipped:     0, Total:    60+
```

- [ ] ? Todos los tests pasan
- [ ] ? 0 tests fallan
- [ ] ? 0 tests ignorados

#### Paso 2: Ejecutar Tests con Detalles
```bash
dotnet test --verbosity detailed
```

- [ ] ? Revisar output detallado
- [ ] ? Verificar que no hay warnings
- [ ] ? Confirmar que todos los tests nuevos aparecen

---

### Fase 3: Generar Reporte de Coverage ??

#### Opción A: Windows (PowerShell)
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
.\run-coverage.ps1
```

#### Opción B: Linux/Mac
```bash
chmod +x run-coverage.sh
./run-coverage.sh
```

#### Opción C: Manual
```bash
# 1. Ejecutar tests con coverage
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover

# 2. Instalar reportgenerator (si no está)
dotnet tool install -g dotnet-reportgenerator-globaltool

# 3. Generar reporte
reportgenerator -reports:coverage.opencover.xml -targetdir:coverage-report

# 4. Abrir reporte
start coverage-report/index.html  # Windows
# xdg-open coverage-report/index.html  # Linux
# open coverage-report/index.html  # Mac
```

**Checklist de Validación:**
- [ ] ? Script ejecuta sin errores
- [ ] ? Archivo `coverage.opencover.xml` generado
- [ ] ? Carpeta `coverage-report` creada
- [ ] ? Reporte HTML se abre en navegador

---

### Fase 4: Validar Métricas de Coverage ??

#### Abrir `coverage-report/index.html`

**Verificar Coverage Global:**
- [ ] ? Line Coverage >= 80%
- [ ] ? Branch Coverage >= 70%

**Verificar Coverage por Archivo:**

| Archivo | Coverage Objetivo | Validado |
|---------|-------------------|----------|
| EmailService.cs | ~75% | [ ] |
| PacienteController.cs | >85% | [ ] |
| ErrorViewModel.cs | 100% | [ ] |
| Paciente.cs | >95% | [ ] |
| ValidationHelper.cs | >84% | [ ] |
| OtpService.cs | >96% | [ ] |

**Notas:**
- Hacer clic en cada archivo para ver líneas cubiertas/no cubiertas
- Verde = Cubierto, Rojo = No cubierto, Amarillo = Parcialmente cubierto

---

### Fase 5: Validar Tests Específicos ??

#### EmailServiceTests (8 tests)
```bash
dotnet test --filter "FullyQualifiedName~EmailServiceTests"
```

- [ ] ? 8/8 tests pasan
- [ ] ? Constructor_ConConfiguracionValida_InicializaCorrectamente
- [ ] ? Constructor_ConConfiguracionInvalida_LogueaAdvertencia
- [ ] ? EnviarCorreoVerificacionAsync_ConConfiguracionInvalida_NoEnviaEmail
- [ ] ? EnviarOTPAsync_ConConfiguracionInvalida_NoEnviaEmail
- [ ] ? EnviarCorreoRecuperacionAsync_ConConfiguracionInvalida_NoEnviaEmail
- [ ] ? EnviarCorreoVerificacionAsync_ConDestinatarioValido_LogueaInformacion
- [ ] ? EnviarOTPAsync_ConParametrosValidos_LogueaInformacion
- [ ] ? EnviarCorreoRecuperacionAsync_ConParametrosValidos_LogueaInformacion

#### PacienteControllerTests (28+ tests)
```bash
dotnet test --filter "FullyQualifiedName~PacienteControllerTests"
```

- [ ] ? Tests de Registro (existentes)
- [ ] ? Tests de Login (existentes)
- [ ] ? Tests de VerificarOTP (existentes)
- [ ] ? Tests de RecuperarPassword (5 nuevos)
- [ ] ? Tests de RestablecerPassword (9 nuevos)

#### ErrorViewModelTests (6 tests)
```bash
dotnet test --filter "FullyQualifiedName~ErrorViewModelTests"
```

- [ ] ? 6/6 tests pasan
- [ ] ? RequestId_PuedeSerAsignado
- [ ] ? RequestId_PuedeSerNull
- [ ] ? ShowRequestId_ConRequestIdNulo_RetornaFalse
- [ ] ? ShowRequestId_ConRequestIdVacio_RetornaFalse
- [ ] ? ShowRequestId_ConRequestIdValido_RetornaTrue
- [ ] ? ShowRequestId_ConRequestIdConEspacios_RetornaTrue

#### PacienteTests (20+ tests)
```bash
dotnet test --filter "FullyQualifiedName~PacienteTests"
```

- [ ] ? Tests de CalcularEdad (existentes)
- [ ] ? Tests de EsMayorDeEdad (existentes)
- [ ] ? Tests de EsPacientePreferencial (existentes)
- [ ] ? Tests de ToStringPaciente (nuevo)
- [ ] ? Tests de ObtenerResumenContacto (nuevo)
- [ ] ? Tests de ActualizarDatosContacto (nuevo)
- [ ] ? Tests de EsTokenRecuperacionValido (5 nuevos)
- [ ] ? Tests de Constructor (nuevo)

---

### Fase 6: Validación de Calidad de Código ??

#### Visual Studio Code Analysis
- [ ] ? Abrir proyecto en Visual Studio
- [ ] ? Ejecutar `Analyze > Run Code Analysis on Solution`
- [ ] ? Verificar: 0 errores
- [ ] ? Verificar: 0 warnings (o solo los suprimidos)

#### SonarLint (si está instalado)
- [ ] ? Ejecutar análisis de SonarLint
- [ ] ? Verificar: 0 bugs
- [ ] ? Verificar: 0 vulnerabilidades
- [ ] ? Verificar: Code smells aceptables

---

### Fase 7: Documentación y Comunicación ??

#### Revisar Documentación
- [ ] ? Leer COVERAGE_README.md
- [ ] ? Leer PLAN_MEJORA_COVERAGE.md
- [ ] ? Leer RESUMEN_COVERAGE.md

#### Compartir Resultados
- [ ] ?? Compartir reporte HTML con equipo
- [ ] ?? Documentar métricas alcanzadas
- [ ] ?? Comunicar logros en standup/reunión
- [ ] ?? Capturar screenshots del reporte

---

### Fase 8: Integración Continua (Opcional) ??

#### GitHub Actions (Recomendado)
```yaml
# .github/workflows/tests.yml
name: Tests and Coverage

on: [push, pull_request]

jobs:
test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup .NET
      uses: actions/setup-dotnet@v1
        with:
          dotnet-version: '9.0.x'
      - name: Run tests with coverage
        run: dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover
    - name: Upload coverage
        uses: codecov/codecov-action@v2
```

- [ ] ?? Crear archivo `.github/workflows/tests.yml`
- [ ] ? Hacer commit y push
- [ ] ? Verificar que la acción se ejecuta
- [ ] ? Revisar resultados en GitHub

#### Azure DevOps (Alternativa)
```yaml
# azure-pipelines.yml
trigger:
  - main

pool:
  vmImage: 'ubuntu-latest'

steps:
- task: UseDotNet@2
  inputs:
    version: '9.0.x'
- task: DotNetCoreCLI@2
  displayName: 'Run Tests'
  inputs:
    command: 'test'
    arguments: '/p:CollectCoverage=true /p:CoverletOutputFormat=cobertura'
- task: PublishCodeCoverageResults@1
  inputs:
    codeCoverageTool: 'Cobertura'
 summaryFileLocation: '**/coverage.cobertura.xml'
```

- [ ] ?? Crear archivo `azure-pipelines.yml`
- [ ] ? Configurar pipeline en Azure DevOps
- [ ] ? Ejecutar pipeline
- [ ] ? Revisar coverage en Azure DevOps

---

### Fase 9: Mantenimiento Futuro ??

#### Establecer Reglas
- [ ] ?? Coverage mínimo: 80% para nuevos archivos
- [ ] ?? Todos los PRs deben incluir tests
- [ ] ?? No bajar el coverage general
- [ ] ?? Revisar coverage en code reviews

#### Monitoreo Continuo
- [ ] ?? Ejecutar reporte de coverage semanalmente
- [ ] ?? Tracking de métricas en dashboard
- [ ] ?? Meta trimestral: >85% coverage
- [ ] ?? Reconocer contribuciones que mejoren coverage

---

## ?? Criterios de Éxito

### Mínimos Requeridos:
- [x] ? Build exitoso
- [ ] ? Todos los tests pasan (60+ tests)
- [ ] ? Coverage general >= 80%
- [ ] ? 0 archivos con 0% coverage
- [ ] ? Documentación completa

### Objetivos Ideales:
- [ ] ?? Coverage general >= 85%
- [ ] ?? EmailService.cs >= 75%
- [ ] ?? PacienteController.cs >= 85%
- [ ] ?? ErrorViewModel.cs = 100%
- [ ] ?? Paciente.cs >= 95%
- [ ] ?? CI/CD configurado

---

## ?? Template de Reporte

```markdown
# Reporte de Coverage - [Fecha]

## Resultados
- **Line Coverage:** ___%
- **Branch Coverage:** ___%
- **Tests Totales:** ___
- **Tests Pasando:** ___
- **Tests Fallando:** ___

## Top 5 Archivos Mejorados
1. EmailService.cs: 0% ? ___%
2. PacienteController.cs: 42% ? ___%
3. ErrorViewModel.cs: 50% ? ___%
4. Paciente.cs: 62% ? ___%
5. [Otro]: __% ? ___%

## Archivos Pendientes
- [ ] PacienteService.cs (59.5%)
- [ ] [Otros...]

## Próximos Pasos
1. ...
2. ...
3. ...

## Notas
- ...
```

---

## ?? Troubleshooting

### Problema: Tests fallan
```bash
# Ver detalles del error
dotnet test --verbosity detailed

# Ejecutar test específico
dotnet test --filter "FullyQualifiedName~NombreDelTest"
```

### Problema: Coverage bajo en archivo específico
1. Abrir `coverage-report/index.html`
2. Hacer clic en el archivo
3. Identificar líneas rojas (no cubiertas)
4. Crear tests para esas líneas

### Problema: Script de coverage no funciona
```bash
# Verificar que dotnet está instalado
dotnet --version

# Instalar reportgenerator manualmente
dotnet tool install -g dotnet-reportgenerator-globaltool

# Ejecutar paso a paso
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover
reportgenerator -reports:coverage.opencover.xml -targetdir:coverage-report
```

---

## ? Checklist Final

- [ ] ?? Todos los tests ejecutados y pasando
- [ ] ?? Reporte de coverage generado y revisado
- [ ] ?? Métricas de coverage validadas (>80%)
- [ ] ?? Documentación leída y comprendida
- [ ] ?? CI/CD configurado (opcional)
- [ ] ?? Resultados comunicados al equipo
- [ ] ?? Plan de mantenimiento establecido

---

## ?? ¡Felicitaciones!

Si has completado todos los pasos de este checklist, has logrado:

? Aumentar el coverage de ~60% a ~80-85%  
? Crear 37 nuevos tests unitarios  
? Establecer buenas prácticas de testing  
? Documentar el proceso completamente  
? Mejorar la calidad y confiabilidad del código  

**¡Excelente trabajo! ??**

---

**Última Actualización:** ${new Date().toISOString().split('T')[0]}  
**Autor:** Copilot AI  
**Estado:** Listo para Ejecutar
