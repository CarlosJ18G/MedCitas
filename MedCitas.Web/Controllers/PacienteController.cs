using MedCitas.Core.Entities;
using MedCitas.Core.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Diagnostics.CodeAnalysis;
using System.Threading.Tasks;

namespace MedCitas.Web.Controllers
{
    [SuppressMessage("SonarLint", "S4502", Justification ="Usando enrutamiento MVC de C#")]
#pragma warning disable S6934
    public class PacienteController : Controller
#pragma warning restore S6934
    {
        private readonly PacienteService _pacienteService;

        public PacienteController(PacienteService pacienteService)
        {
            _pacienteService = pacienteService;
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
                    return View(model);

                var nuevoPaciente = await _pacienteService.RegistrarAsync(model, password, confirmarPassword);

                TempData["Mensaje"] = $"¡Registro exitoso! Te hemos enviado un código de verificación a {nuevoPaciente.CorreoElectronico}";
                TempData["CorreoRegistrado"] = nuevoPaciente.CorreoElectronico;

                return RedirectToAction("VerificarOTP");
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
                    ViewBag.Error += $" | Inner: {ex.InnerException.Message}";
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
                    return RedirectToAction("Login");
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
                return View("VerificarOTP");
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                ViewBag.Correo = correo;
                return View("VerificarOTP");
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
    }
}