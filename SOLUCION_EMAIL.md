# ?? GUÍA DE SOLUCIÓN - ENVÍO DE CORREOS

## ? Problemas Corregidos

### 1. Error LINQ (Entity Framework)
```csharp
// ? CORREGIDO:
public async Task<Paciente?> ObtenerPorCorreoAsync(string correoElectronico) =>
    await _db.Pacientes
 .Where(p => p.CorreoElectronico.ToLower() == correoElectronico.ToLower())
        .FirstOrDefaultAsync();
```

### 2. EmailService Mejorado
- ? Lanza excepción si config es inválida
- ? Logging detallado de cada paso
- ? Muestra errores SMTP con StatusCode

---

## ?? Cómo Verificar que Funcione

### 1. Ejecuta la aplicación
```bash
dotnet run --project MedCitas.Web
```

### 2. Registra un usuario con TU email
```
https://localhost:7001/Paciente/Registro
```

### 3. Revisa los LOGS en la consola

**? Si TODO está bien, verás:**
```
[Info] ? EmailService inicializado correctamente
[Info] ?? Intentando enviar email a tu@email.com: Código de Verificación
[Info] ?? Conectando a SMTP: smtp.gmail.com:587 como jepcertificados@gmail.com
[Info] ?? Enviando mensaje de jepcertificados@gmail.com a tu@email.com
[Info] ? Email enviado exitosamente a tu@email.com
```

**? Si HAY PROBLEMAS, verás:**
```
[Error] ? Configuración de email inválida: SmtpPassword es requerido
```
O
```
[Error] ? Error SMTP al enviar email. StatusCode: AuthenticationFailed
```

---

## ?? Problemas Comunes

### Problema 1: "Authentication Required"
**Solución:** Verifica que uses **App Password de Gmail**, no tu contraseña normal.

Genera uno aquí: https://myaccount.google.com/apppasswords

### Problema 2: "Connection Refused"
**Solución:** Verifica que el puerto 587 esté abierto:
```powershell
Test-NetConnection smtp.gmail.com -Port 587
```

### Problema 3: No llega el correo
1. Revisa la carpeta de SPAM
2. Verifica que el email en appsettings.Development.json sea correcto
3. Revisa los logs para ver si se envió

---

## ?? Endpoint de Prueba Rápida

Agrega esto temporalmente en `PacienteController.cs`:

```csharp
[HttpGet("test-email")]
public async Task<IActionResult> TestEmail()
{
    try
    {
      var testEmail = "TU_EMAIL_AQUI@gmail.com"; // ? Cambia esto
        await _pacienteService.ReenviarOTPAsync(testEmail);
      return Ok("Email enviado! Revisa tu bandeja de entrada.");
    }
    catch (Exception ex)
    {
return BadRequest($"Error: {ex.Message}");
    }
}
```

Luego visita: `https://localhost:7001/Paciente/test-email`

---

**Estado:** ? Listo para probar  
**Acción:** Ejecuta la app y registra un usuario
