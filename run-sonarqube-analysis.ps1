# Script para an�lisis completo con SonarQube
param(
    [string]$SonarHost = "http://localhost:9000",
    [Parameter(Mandatory=$false)]
    [string]$SonarToken = "",
    [string]$ProjectKey = "MedCitasAPI",
    [string]$ProjectName = "MedCitas"
)

Write-Host "?? MedCitas - An�lisis SonarQube" -ForegroundColor Cyan
Write-Host "=================================" -ForegroundColor Cyan
Write-Host ""

# Verificar token
if ([string]::IsNullOrWhiteSpace($SonarToken)) {
    Write-Host "??  No se proporcion� token de SonarQube" -ForegroundColor Yellow
    Write-Host "   El an�lisis puede fallar si SonarQube requiere autenticaci�n" -ForegroundColor Yellow
    Write-Host ""
    $continuar = Read-Host "�Deseas continuar sin token? (S/N)"
    if ($continuar -ne "S" -and $continuar -ne "s") {
        Write-Host "An�lisis cancelado." -ForegroundColor Red
        exit 0
    }
}

# Verificar si SonarScanner est� instalado
$scannerExists = Get-Command dotnet-sonarscanner -ErrorAction SilentlyContinue
if (-not $scannerExists) {
    Write-Host "??  SonarScanner no est� instalado. Instalando..." -ForegroundColor Yellow
    dotnet tool install --global dotnet-sonarscanner
    Write-Host ""
}

# Eliminar sonar-project.properties si existe
if (Test-Path "sonar-project.properties") {
    Write-Host "???  Eliminando sonar-project.properties (no compatible con Scanner for .NET)..." -ForegroundColor Yellow
    Rename-Item "sonar-project.properties" "sonar-project.properties.backup" -Force
    Write-Host "   Archivo respaldado como: sonar-project.properties.backup" -ForegroundColor Gray
    Write-Host ""
}

# Limpiar builds anteriores
Write-Host "?? Limpiando builds anteriores..." -ForegroundColor Yellow
dotnet clean
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "coverage-report"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue "MedCitas.Tests/coverage"
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue ".sonarqube"

Write-Host ""
Write-Host "?? Iniciando an�lisis de SonarQube..." -ForegroundColor Yellow

# Construir comando de inicio con TODOS los par�metros
$beginParams = @(
    "/k:`"$ProjectKey`""
    "/n:`"$ProjectName`""
    "/v:`"1.0`""
    "/d:sonar.host.url=`"$SonarHost`""
    "/d:sonar.cs.opencover.reportsPaths=`"**/coverage.opencover.xml`""
    "/d:sonar.coverage.exclusions=`"**/*Tests.cs,**/Program.cs,**/Migrations/**`""
    "/d:sonar.exclusions=`"**/obj/**,**/bin/**,**/Migrations/**,**/*.Designer.cs,**/wwwroot/lib/**`""
)

if (-not [string]::IsNullOrWhiteSpace($SonarToken)) {
    $beginParams += "/d:sonar.token=`"$SonarToken`""
}

$beginCommand = "dotnet sonarscanner begin " + ($beginParams -join " ")

Write-Host "?? Ejecutando: dotnet sonarscanner begin..." -ForegroundColor Gray
Write-Host ""

# Ejecutar inicio de an�lisis
& dotnet sonarscanner begin @beginParams

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "? Error al iniciar an�lisis de SonarQube!" -ForegroundColor Red
    Write-Host "   Verifica que SonarQube est� corriendo en: $SonarHost" -ForegroundColor Red
    exit 1
}

# Build del proyecto
Write-Host ""
Write-Host "?? Compilando proyecto..." -ForegroundColor Yellow
dotnet build --no-incremental

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "? Error en la compilaci�n!" -ForegroundColor Red
    exit 1
}

# Ejecutar tests con coverage
Write-Host ""
Write-Host "?? Ejecutando tests con coverage..." -ForegroundColor Yellow
dotnet test /p:CollectCoverage=true /p:CoverletOutputFormat=opencover /p:CoverletOutput=./coverage/ --no-build

$testExitCode = $LASTEXITCODE
if ($testExitCode -ne 0) {
    Write-Host ""
    Write-Host "??  Algunos tests fallaron. Continuando con el an�lisis..." -ForegroundColor Yellow
}

# Verificar que se gener� el archivo de coverage
$coverageFile = Get-ChildItem -Path "MedCitas.Tests\coverage" -Filter "coverage.opencover.xml" -Recurse -ErrorAction SilentlyContinue
if ($coverageFile) {
    Write-Host "? Archivo de coverage encontrado: $($coverageFile.FullName)" -ForegroundColor Green
} else {
    Write-Host "??  No se encontr� archivo de coverage" -ForegroundColor Yellow
}

# Finalizar an�lisis
Write-Host ""
Write-Host "?? Enviando resultados a SonarQube..." -ForegroundColor Yellow

$endParams = @()
if (-not [string]::IsNullOrWhiteSpace($SonarToken)) {
    $endParams += "/d:sonar.token=`"$SonarToken`""
}

if ($endParams.Count -gt 0) {
    & dotnet sonarscanner end @endParams
} else {
    & dotnet sonarscanner end
}

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "? Error al finalizar an�lisis de SonarQube!" -ForegroundColor Red
    exit 1
}

# �xito
Write-Host ""
Write-Host "? �An�lisis completado exitosamente!" -ForegroundColor Green
Write-Host ""
Write-Host "?? Resumen:" -ForegroundColor Cyan
Write-Host "   - Proyecto: $ProjectName ($ProjectKey)" -ForegroundColor Gray
Write-Host "   - Tests: $testExitCode" -ForegroundColor Gray
Write-Host "   - SonarQube: $SonarHost" -ForegroundColor Gray
Write-Host ""
Write-Host "?? Ver resultados en: $SonarHost/dashboard?id=$ProjectKey" -ForegroundColor Cyan
Write-Host ""

# Abrir navegador (opcional)
$respuesta = Read-Host "�Deseas abrir el dashboard de SonarQube? (S/N)"
if ($respuesta -eq "S" -or $respuesta -eq "s") {
    Start-Process "$SonarHost/dashboard?id=$ProjectKey"
}

Write-Host ""
Write-Host "? �Proceso completado!" -ForegroundColor Green
Write-Host ""
