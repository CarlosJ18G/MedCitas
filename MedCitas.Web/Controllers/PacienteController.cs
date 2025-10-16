using MedCitas.Core.Entities;
using MedCitas.Core.Services;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Threading.Tasks;

namespace MedCitas.Web.Controllers
{
    public class PacienteController : Controller
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

                ViewBag.Mensaje = "Registro exitoso. Revisa tu correo para activar la cuenta.";
                return View("RegistroExitoso", nuevoPaciente);
            }
            catch (Exception ex)
            {
                ViewBag.Error = ex.Message;
                return View(model);
            }
        }

        // -------------------------------------
        // GET: /Paciente/Login
        // -------------------------------------
        [HttpGet]
        public IActionResult Login()
        {
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
        // GET: /Paciente/VerificarCuenta/{token}
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
