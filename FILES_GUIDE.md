# ??? Gu�a de Archivos del Proyecto

## ? Archivos ESENCIALES (NO Eliminar)

### **C�digo Fuente**
```
MedCitas/
??? MedCitas.Core/           # L�gica de negocio
??? MedCitas.Infrastructure/ # Acceso a datos
??? MedCitas.Web/            # UI (Razor Pages)
??? MedCitas.Tests/          # Tests unitarios
```

### **Configuraci�n del Proyecto**
- ? `MedCitas.sln` - Soluci�n de Visual Studio
- ? `.gitignore` - Exclusiones de Git
- ? `sonar-project.properties` - Config de SonarQube

### **Documentaci�n Principal**
- ? `README.md` - Documentaci�n principal del proyecto
- ? `README_TESTING.md` - Gu�a de testing
- ? `TESTING_BEST_PRACTICES.md` - Mejores pr�cticas
- ? `RESUMEN_EJECUTIVO.md` - Resumen ejecutivo
- ? `FINAL_SUMMARY.md` - Resumen de mejoras

### **Scripts �tiles**
- ? `run-tests-coverage.ps1` - Ejecutar tests con coverage
- ? `run-sonarqube-analysis.ps1` - An�lisis con SonarQube
- ? `cleanup-docs.ps1` - Limpiar archivos temporales

---

## ??? Archivos OPCIONALES (Puedes Eliminar)

### **Documentaci�n Redundante**
- ?? `COVERAGE_SCRIPTS.md` - Info ya est� en README.md
- ?? `FIXES_SUMMARY.md` - Info ya est� en FINAL_SUMMARY.md
- ?? `SECURITY_COVERAGE_FIXES.md` - Info ya est� en FINAL_SUMMARY.md
- ?? `NEW_COVERAGE_TESTS.md` - Info ya est� en README_TESTING.md
- ?? `QUICK_START.md` - Info ya est� en README.md
- ?? `README_BADGES.md` - Solo ejemplos, ya implementados

### **Scripts Temporales**
- ?? `verify-fixes.ps1` - Solo para verificaci�n temporal
- ?? `verify-new-tests.ps1` - Solo para verificaci�n temporal

---

## ?? C�mo Limpiar

### **Opci�n 1: Script Automatizado (Recomendado)**
```powershell
.\cleanup-docs.ps1
```

Este script:
1. Elimina archivos redundantes
2. Mantiene archivos esenciales
3. Muestra un resumen de lo eliminado

### **Opci�n 2: Manual**
```powershell
# Eliminar archivos de documentaci�n redundantes
Remove-Item "COVERAGE_SCRIPTS.md"
Remove-Item "FIXES_SUMMARY.md"
Remove-Item "SECURITY_COVERAGE_FIXES.md"
Remove-Item "NEW_COVERAGE_TESTS.md"
Remove-Item "QUICK_START.md"
Remove-Item "README_BADGES.md"

# Eliminar scripts temporales
Remove-Item "verify-fixes.ps1"
Remove-Item "verify-new-tests.ps1"
```

---

## ?? Tama�o Estimado Liberado

| Archivo | Tama�o |
|---------|--------|
| COVERAGE_SCRIPTS.md | ~10 KB |
| FIXES_SUMMARY.md | ~5 KB |
| SECURITY_COVERAGE_FIXES.md | ~5 KB |
| NEW_COVERAGE_TESTS.md | ~6 KB |
| QUICK_START.md | ~4 KB |
| README_BADGES.md | ~7 KB |
| verify-fixes.ps1 | ~3 KB |
| verify-new-tests.ps1 | ~2 KB |
| **TOTAL** | **~42 KB** |

---

## ?? Estructura Recomendada Despu�s de Limpieza

```
MedCitas/
??? .gitignore
??? MedCitas.sln
??? README.md ?
??? README_TESTING.md
??? TESTING_BEST_PRACTICES.md
??? RESUMEN_EJECUTIVO.md
??? FINAL_SUMMARY.md
??? sonar-project.properties
??? run-tests-coverage.ps1
??? run-sonarqube-analysis.ps1
??? cleanup-docs.ps1
?
??? MedCitas.Core/
??? MedCitas.Infrastructure/
??? MedCitas.Web/
??? MedCitas.Tests/
```

---

## ?? Beneficios de la Limpieza

### **Antes**
- 20+ archivos de documentaci�n
- Informaci�n duplicada
- Confusi�n sobre qu� archivo leer

### **Despu�s**
- 5 archivos de documentaci�n esenciales
- Informaci�n consolidada en README.md
- Estructura clara y organizada

---

## ?? Recomendaciones

### **Para el Repositorio de Git**
1. ? Mant�n `README.md` como punto de entrada principal
2. ? Usa `README_TESTING.md` para documentaci�n t�cnica de testing
3. ? Mant�n `FINAL_SUMMARY.md` como referencia hist�rica de mejoras

### **Para Desarrollo Local**
1. ? Ejecuta `cleanup-docs.ps1` despu�s de cada gran cambio
2. ? Actualiza `README.md` en lugar de crear archivos nuevos
3. ? Usa `.gitignore` para excluir archivos temporales

### **Para Colaboradores**
1. ? Sigue la estructura de archivos existente
2. ? No crees archivos de documentaci�n sin consultar
3. ? Actualiza archivos existentes en lugar de crear nuevos

---

## ? Checklist de Limpieza

- [ ] Ejecutar `.\cleanup-docs.ps1`
- [ ] Verificar que `README.md` contiene toda la info necesaria
- [ ] Hacer commit de los cambios
- [ ] Push a GitHub
- [ ] Verificar que el proyecto sigue funcionando
- [ ] Actualizar documentaci�n si es necesario

---

## ?? Verificaci�n Post-Limpieza

```powershell
# Ver archivos restantes
Get-ChildItem -Filter "*.md" | Select-Object Name, Length

# Ver scripts restantes
Get-ChildItem -Filter "*.ps1" | Select-Object Name, Length

# Ejecutar tests para verificar que todo funciona
dotnet test
```

---

**�ltima actualizaci�n**: 2024  
**Autor**: Carlos Jimenez  
**Estado**: ? Listo para limpiar
