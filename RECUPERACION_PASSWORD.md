# Sistema de Recuperación de Contraseña - MedCitas

## ?? Flujo Completo

### 1. **Usuario olvida su contraseña**
- El usuario va a `/Paciente/Login`
- Hace clic en "¿Olvidaste tu contraseña? Recupérala aquí"
- Es redirigido a `/Paciente/RecuperarPassword`

### 2. **Solicitud de recuperación**
- El usuario ingresa su correo electrónico
- El sistema valida que el correo exista y esté verificado
- Se genera un token único de 32 bytes
- El token expira en 15 minutos
- Se envía un email con el enlace de recuperación

### 3. **Email de recuperación**
- El usuario recibe un email HTML profesional
- El email contiene un enlace: `https://localhost:XXXX/Paciente/RestablecerPassword?token=XXXXX`
- El enlace es válido por 15 minutos

### 4. **Restablecer contraseña**
- El usuario hace clic en el enlace del email
- Es redirigido a `/Paciente/RestablecerPassword?token=XXXXX`
- Ingresa su nueva contraseña (debe cumplir requisitos)
- Confirma la contraseña
- El sistema valida:
  - Token válido y no expirado
  - Contraseñas coinciden
  - Contraseña cumple requisitos de complejidad

### 5. **Contraseña actualizada**
- La contraseña se actualiza con hash BCrypt
- El token se elimina (solo se puede usar una vez)
- El usuario es redirigido a `/Paciente/Login`
- Mensaje: "¡Contraseña restablecida exitosamente!"

## ?? Seguridad

- ? Token de 32 bytes generado con `RandomNumberGenerator`
- ? Token válido por solo 15 minutos
- ? Token de un solo uso
- ? Contraseña hash con BCrypt
- ? Validación de complejidad:
  - Mínimo 8 caracteres
  - Al menos una mayúscula
  - Al menos una minúscula
  - Al menos un número
  - Al menos un carácter especial

## ?? Configuración de Email

### Gmail
```json
"Email": {
  "SmtpHost": "smtp.gmail.com",
  "SmtpPort": "587",
  "SmtpUser": "tu-correo@gmail.com",
  "SmtpPassword": "contraseña-de-aplicacion-sin-espacios",
  "FromEmail": "tu-correo@gmail.com",
  "FromName": "MedCitas",
  "EnableSsl": "true"
}
```

**Nota:** Para Gmail necesitas:
1. Habilitar verificación en 2 pasos
2. Generar contraseña de aplicación en: https://myaccount.google.com/apppasswords
3. Usar la contraseña sin espacios

### Outlook/Office 365
```json
"Email": {
  "SmtpHost": "smtp-mail.outlook.com",
  "SmtpPort": "587",
  "SmtpUser": "tu-correo@outlook.com",
  "SmtpPassword": "tu-contraseña",
  "FromEmail": "tu-correo@outlook.com",
  "FromName": "MedCitas",
  "EnableSsl": "true"
}
```

## ?? Pruebas

### Probar flujo completo:

1. **Iniciar aplicación:**
   ```bash
   dotnet run --project MedCitas.Web
   ```

2. **Ir a Login:**
   ```
   https://localhost:XXXX/Paciente/Login
   ```

3. **Hacer clic en "Recupérala aquí"**

4. **Ingresar correo registrado**

5. **Revisar logs en consola** para ver el email simulado con el enlace

6. **Copiar la URL** del enlace que aparece en los logs

7. **Pegar en el navegador** para ir a RestablecerPassword

8. **Ingresar nueva contraseña** (debe cumplir requisitos)

9. **Confirmar** y verificar que redirige a Login con mensaje de éxito

### Logs esperados:

```
?? EmailService inicializado:
  - SMTP Host: smtp.gmail.com
  - SMTP Port: 587
  - SMTP User: jepcertificados@gmail.com
  - From Email: jepcertificados@gmail.com
  - SSL Enabled: True

Solicitando recuperación de contraseña para: usuario@ejemplo.com
URL base generada: https://localhost:7XXX
?? Intentando enviar email:
  - Destinatario: usuario@ejemplo.com
  - Asunto: Recuperación de Contraseña - MedCitas
?? Configurando cliente SMTP...
  - Host: smtp.gmail.com:587
  - SSL: True
?? Enviando email...
? Email enviado exitosamente a usuario@ejemplo.com
Email de recuperación enviado exitosamente a: usuario@ejemplo.com
```

## ??? Archivos del Sistema

### Controladores:
- `MedCitas.Web/Controllers/PacienteController.cs` - Maneja todos los endpoints

### Vistas:
- `MedCitas.Web/Views/Paciente/Login.cshtml` - Página de login
- `MedCitas.Web/Views/Paciente/RecuperarPassword.cshtml` - Solicitar recuperación
- `MedCitas.Web/Views/Paciente/RestablecerPassword.cshtml` - Restablecer contraseña

### Servicios:
- `MedCitas.Core/Services/PacienteService.cs` - Lógica de negocio
- `MedCitas.Infrastructure/Services/EmailService.cs` - Envío de emails

### Repositorios:
- `MedCitas.Infrastructure/Repositories/EfPacienteRepositorio.cs` - Acceso a datos

### Base de Datos:
- Tabla: `Pacientes`
- Columnas nuevas:
  - `TokenRecuperacion` (varchar 64)
  - `TokenRecuperacionExpiracion` (timestamp with time zone)

## ? Archivos Eliminados (ya no se usan)

- ? `MedCitas.Infrastructure/Services/FakeEmailService.cs` - Reemplazado por EmailService real
- ? `MedCitas.Web/Pages/Cuenta/VerificarOTP.cshtml` - Duplicado (ya existe en Views)
- ? `MedCitas.Web/Pages/Cuenta/VerificarOTP.cshtml.cs` - Duplicado
- ? `MedCitas.Tests/Page/VerificarOtpModelTests.cs` - Test obsoleto
- ? `MedCitas.Tests/Services/FakeEmailServiceTests.cs` - Test obsoleto

## ?? Próximos pasos recomendados

1. ? Configurar credenciales SMTP reales
2. ? Probar con correos reales
3. ?? Mover credenciales a User Secrets en desarrollo
4. ?? Usar variables de entorno en producción
5. ?? Considerar usar Azure Communication Services o SendGrid para producción
6. ?? Implementar rate limiting para prevenir abuso
7. ?? Agregar captcha en formulario de recuperación
