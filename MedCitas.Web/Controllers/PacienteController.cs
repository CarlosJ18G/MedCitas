using MedCitas.Core.Entities;
using MedCitas.Core.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Logging;
using System;
using System.Diagnostics.CodeAnalysis;
using System.Threading.Tasks;

namespace MedCitas.Web.Controllers
{
    [SuppressMessage("SonarLint", "S4502", Justification = "Usando enrutamiento MVC de C#")]
#pragma warning disable S6934
    public class PacienteController : Controller
#pragma warning restore S6934
    {
        private readonly PacienteService _pacienteService;
        private readonly ILogger<PacienteController> _logger;

        // Constantes para nombres de acciones
        private const string LoginAction = "Login";
        private const string VerificarOTPView = "VerificarOTP";

        public PacienteController(PacienteService pacienteService, ILogger<PacienteController> logger)
        {
            _pacienteService = pacienteService;
            _logger = logger;
        }

        // -------------------------------------
        // GET: /Paciente/Registro
        // -------------------------------------
        [HttpGet]
        public IActionResult Registro()
        {
            return View();
        }

        // -------------------------------------
        // POST: /Paciente/Registro
        // -------------------------------------
        [HttpPost]
        public async Task<IActionResult> Registro(Paciente model, string password, string confirmarPassword)
        {
            try
            {
                if (!ModelState.IsValid)
                {
                    return View(model);
                }

                var nuevoPaciente = await _pacienteService.RegistrarAsync(model, password, confirmarPassword);

                TempData["Mensaje"] = $"¡Registro exitoso! Te hemos enviado un código de verificación a {nuevoPaciente.CorreoElectronico}";
                TempData["CorreoRegistrado"] = nuevoPaciente.CorreoElectronico;

                return RedirectToAction(VerificarOTPView);
            }
            catch (DbUpdateException dbEx)
            {
                // Error específico de base de datos
                ViewBag.Error = $"Error de BD: {dbEx.InnerException?.Message ?? dbEx.Message}";
                return View(model);
            }
            catch (Exception ex)
            {
                ViewBag.Error = $"Error: {ex.Message}";
                if (ex.InnerException != null)
                {
                    ViewBag.Error += $" | Inner: {ex.InnerException.Message}";
                }
                return View(model);
            }
        }

        // -------------------------------------
        // GET: /Paciente/VerificarOTP
        // -------------------------------------
        [HttpGet]
        public IActionResult VerificarOTP()
        {
            ViewBag.Correo = TempData["CorreoRegistrado"]?.ToString() ?? "";
            ViewBag.Mensaje = TempData["Mensaje"]?.ToString();
            return View();
        }

        // -------------------------------------
        // POST: /Paciente/VerificarOTP
        // -------------------------------------
        [HttpPost]
        public async Task<IActionResult> VerificarOTP(string correo, string codigoOTP)
        {
            try
            {
                var resultado = await _pacienteService.VerificarOTPAsync(correo, codigoOTP);

                if (resultado)
                {
                    TempData["MensajeExito"] = "¡Cuenta verificada exitosamente! Ya puedes iniciar sesión.";
                    return RedirectToAction(LoginAction);
                }
                else
                {
                    ViewBag.Error = "Código OTP inválido o expirado. Intenta nuevamente.";
                    ViewBag.Correo = correo;
                    return View();
                }
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                ViewBag.Correo = correo;
                return View();
            }
        }

        // -------------------------------------
        // POST: /Paciente/ReenviarOTP
        // -------------------------------------
        [HttpPost]
        public async Task<IActionResult> ReenviarOTP(string correo)
        {
            try
            {
                await _pacienteService.ReenviarOTPAsync(correo);
                ViewBag.Mensaje = "Código reenviado exitosamente. Revisa tu correo.";
                ViewBag.Correo = correo;
                return View(VerificarOTPView);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                ViewBag.Correo = correo;
                return View(VerificarOTPView);
            }
        }

        // -------------------------------------
        // GET: /Paciente/Login
        // -------------------------------------
        [HttpGet]
        public IActionResult Login()
        {
            ViewBag.Mensaje = TempData["MensajeExito"]?.ToString();
            return View();
        }

        // -------------------------------------
        // POST: /Paciente/Login
        // -------------------------------------
        [HttpPost]
        public async Task<IActionResult> Login(string correoElectronico, string password)
        {
            try
            {
                var paciente = await _pacienteService.LoginAsync(correoElectronico, password);

                if (paciente == null)
                {
                    ViewBag.Error = "Credenciales incorrectas.";
                    return View();
                }

                HttpContext.Session.SetString("PacienteId", paciente.Id.ToString());
                HttpContext.Session.SetString("PacienteNombre", paciente.NombreCompleto);

                return RedirectToAction("Index", "Home");
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View();
            }
        }

        // -------------------------------------
        // GET: /Paciente/VerificarCuenta/{token} (método legacy)
        // -------------------------------------
        [HttpGet]
        [Route("Paciente/VerificarCuenta/{token}")]
        public async Task<IActionResult> VerificarCuenta(string token)
        {
            var result = await _pacienteService.ActivarCuentaAsync(token);
            ViewBag.Resultado = result ? "Cuenta activada correctamente." : "Token inválido o expirado.";
            return View();
        }

        // -------------------------------------
        // NUEVO: GET - Mostrar formulario de recuperación de contraseña
        // -------------------------------------
        [HttpGet]
        public IActionResult RecuperarPassword()
        {
            return View();
        }

        // -------------------------------------
        // NUEVO: POST - Procesar solicitud de recuperación
        // -------------------------------------
        [HttpPost]
        public async Task<IActionResult> RecuperarPassword(string correoElectronico)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(correoElectronico))
                {
                    ViewBag.ErrorMessage = "Por favor ingresa tu correo electrónico.";
                    return View();
                }

                // Obtener la URL base
                string urlBase = $"{Request.Scheme}://{Request.Host}";
                _logger.LogInformation("Solicitando recuperación de contraseña para: {Correo} con URL base: {UrlBase}", correoElectronico, urlBase);

                await _pacienteService.SolicitarRecuperacionPasswordAsync(correoElectronico, urlBase);

                ViewBag.SuccessMessage = "Te hemos enviado un enlace de recuperación a tu correo electrónico. Revisa tu bandeja de entrada.";
  
                return View();
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogWarning(ex, "Error de operación al recuperar contraseña para: {Correo}", correoElectronico);
                ViewBag.ErrorMessage = ex.Message;
                return View();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error inesperado al procesar recuperación de contraseña para: {Correo}", correoElectronico);
                ViewBag.ErrorMessage = "Ocurrió un error al procesar tu solicitud. Por favor intenta nuevamente.";
                return View();
            }
        }

        // -------------------------------------
        // NUEVO: GET - Mostrar formulario para restablecer contraseña
        // -------------------------------------
        [HttpGet]
        public IActionResult RestablecerPassword(string token)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(token))
                {
                    _logger.LogWarning("Intento de acceso a RestablecerPassword sin token");
                    TempData["ErrorMessage"] = "El enlace de recuperación es inválido o ha expirado.";
                    return RedirectToAction(LoginAction);
                }

                ViewBag.Token = token;
                return View();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error al cargar vista RestablecerPassword");
                TempData["ErrorMessage"] = "Ocurrió un error. Por favor solicita un nuevo enlace de recuperación.";
                return RedirectToAction(LoginAction);
            }
        }

        // -------------------------------------
        // NUEVO: POST - Procesar nueva contraseña
        // -------------------------------------
        [HttpPost]
        public async Task<IActionResult> RestablecerPassword(string token, string nuevaPassword, string confirmarPassword)
        {
            try
            {
                if (string.IsNullOrWhiteSpace(token))
                {
                    _logger.LogWarning("Intento de restablecer contraseña sin token");
                    TempData["ErrorMessage"] = "El enlace de recuperación es inválido.";
                    return RedirectToAction(LoginAction);
                }

                _logger.LogInformation("Intentando restablecer contraseña con token");

                await _pacienteService.RestablecerPasswordAsync(token, nuevaPassword, confirmarPassword);

                TempData["MensajeExito"] = "¡Contraseña restablecida exitosamente! Ya puedes iniciar sesión con tu nueva contraseña.";
                _logger.LogInformation("Contraseña restablecida exitosamente");
  
                return RedirectToAction(LoginAction);
            }
            catch (ArgumentException ex)
            {
                _logger.LogWarning(ex, "Error de validación al restablecer contraseña");
                ViewBag.Error = ex.Message;
                ViewBag.Token = token;
                return View();
            }
            catch (InvalidOperationException ex)
            {
                _logger.LogWarning(ex, "Error de operación al restablecer contraseña");
                ViewBag.Error = ex.Message;
                ViewBag.Token = token;
                return View();
            }
            catch (Exception ex)
            {
                _logger.LogError(ex, "Error inesperado al restablecer contraseña");
                ViewBag.Error = "Ocurrió un error al restablecer tu contraseña. Por favor intenta nuevamente.";
                ViewBag.Token = token;
                return View();
            }
        }
    }
}