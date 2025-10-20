# ??? Guía de Archivos del Proyecto

## ? Archivos ESENCIALES (NO Eliminar)

### **Código Fuente**
```
MedCitas/
??? MedCitas.Core/           # Lógica de negocio
??? MedCitas.Infrastructure/ # Acceso a datos
??? MedCitas.Web/            # UI (Razor Pages)
??? MedCitas.Tests/          # Tests unitarios
```

### **Configuración del Proyecto**
- ? `MedCitas.sln` - Solución de Visual Studio
- ? `.gitignore` - Exclusiones de Git
- ? `sonar-project.properties` - Config de SonarQube

### **Documentación Principal**
- ? `README.md` - Documentación principal del proyecto
- ? `README_TESTING.md` - Guía de testing
- ? `TESTING_BEST_PRACTICES.md` - Mejores prácticas
- ? `RESUMEN_EJECUTIVO.md` - Resumen ejecutivo
- ? `FINAL_SUMMARY.md` - Resumen de mejoras

### **Scripts Útiles**
- ? `run-tests-coverage.ps1` - Ejecutar tests con coverage
- ? `run-sonarqube-analysis.ps1` - Análisis con SonarQube
- ? `cleanup-docs.ps1` - Limpiar archivos temporales

---

## ??? Archivos OPCIONALES (Puedes Eliminar)

### **Documentación Redundante**
- ?? `COVERAGE_SCRIPTS.md` - Info ya está en README.md
- ?? `FIXES_SUMMARY.md` - Info ya está en FINAL_SUMMARY.md
- ?? `SECURITY_COVERAGE_FIXES.md` - Info ya está en FINAL_SUMMARY.md
- ?? `NEW_COVERAGE_TESTS.md` - Info ya está en README_TESTING.md
- ?? `QUICK_START.md` - Info ya está en README.md
- ?? `README_BADGES.md` - Solo ejemplos, ya implementados

### **Scripts Temporales**
- ?? `verify-fixes.ps1` - Solo para verificación temporal
- ?? `verify-new-tests.ps1` - Solo para verificación temporal

---

## ?? Cómo Limpiar

### **Opción 1: Script Automatizado (Recomendado)**
```powershell
.\cleanup-docs.ps1
```

Este script:
1. Elimina archivos redundantes
2. Mantiene archivos esenciales
3. Muestra un resumen de lo eliminado

### **Opción 2: Manual**
```powershell
# Eliminar archivos de documentación redundantes
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

## ?? Tamaño Estimado Liberado

| Archivo | Tamaño |
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

## ?? Estructura Recomendada Después de Limpieza

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
- 20+ archivos de documentación
- Información duplicada
- Confusión sobre qué archivo leer

### **Después**
- 5 archivos de documentación esenciales
- Información consolidada en README.md
- Estructura clara y organizada

---

## ?? Recomendaciones

### **Para el Repositorio de Git**
1. ? Mantén `README.md` como punto de entrada principal
2. ? Usa `README_TESTING.md` para documentación técnica de testing
3. ? Mantén `FINAL_SUMMARY.md` como referencia histórica de mejoras

### **Para Desarrollo Local**
1. ? Ejecuta `cleanup-docs.ps1` después de cada gran cambio
2. ? Actualiza `README.md` en lugar de crear archivos nuevos
3. ? Usa `.gitignore` para excluir archivos temporales

### **Para Colaboradores**
1. ? Sigue la estructura de archivos existente
2. ? No crees archivos de documentación sin consultar
3. ? Actualiza archivos existentes en lugar de crear nuevos

---

## ? Checklist de Limpieza

- [ ] Ejecutar `.\cleanup-docs.ps1`
- [ ] Verificar que `README.md` contiene toda la info necesaria
- [ ] Hacer commit de los cambios
- [ ] Push a GitHub
- [ ] Verificar que el proyecto sigue funcionando
- [ ] Actualizar documentación si es necesario

---

## ?? Verificación Post-Limpieza

```powershell
# Ver archivos restantes
Get-ChildItem -Filter "*.md" | Select-Object Name, Length

# Ver scripts restantes
Get-ChildItem -Filter "*.ps1" | Select-Object Name, Length

# Ejecutar tests para verificar que todo funciona
dotnet test
```

---

**Última actualización**: 2024  
**Autor**: Carlos Jimenez  
**Estado**: ? Listo para limpiar
