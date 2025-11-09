using System;
using System.Threading.Tasks;
using MedCitas.Core.DTOs;
using MedCitas.Core.Services;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;

namespace MedCitas.Web.Controllers
{
  public class CitaController : Controller
    {
        private readonly AppointmentService _appointmentService;
        private readonly ILogger<CitaController> _logger;

        private const string LoginAction = "Login";
        private const string LoginController = "Paciente";
    private const string MensajeExitoKey = "MensajeExito";
        private const string ErrorKey = "Error";

        public CitaController(AppointmentService appointmentService, ILogger<CitaController> logger)
        {
   _appointmentService = appointmentService;
          _logger = logger;
        }

        // -------------------------------------
        // HELPER: Obtener Paciente ID de la sesión
        // -------------------------------------
        private Guid? ObtenerPacienteIdSesion()
        {
       var pacienteIdStr = HttpContext.Session.GetString("PacienteId");
    return string.IsNullOrEmpty(pacienteIdStr) ? null : Guid.Parse(pacienteIdStr);
        }

   // -------------------------------------
// GET: /Cita/MisCitas
        // -------------------------------------
[HttpGet]
     public async Task<IActionResult> MisCitas(string? estado = null, DateTime? desde = null, DateTime? hasta = null)
        {
        if (!ModelState.IsValid)
       {
  return View();
            }

        var pacienteId = ObtenerPacienteIdSesion();
    if (!pacienteId.HasValue)
       {
           return RedirectToAction(LoginAction, LoginController);
      }

       try
  {
       var citas = await _appointmentService.ObtenerCitasPacienteAsync(
              pacienteId.Value, estado, desde, hasta);

 return View(citas);
       }
     catch (Exception ex)
          {
_logger.LogError(ex, "Error al obtener citas del paciente {PacienteId}", pacienteId);
           ViewBag.Error = "Error al cargar las citas";
         return View();
}
        }

        // -------------------------------------
  // GET: /Cita/Detalle/{id}
    // -------------------------------------
[HttpGet]
        public async Task<IActionResult> Detalle(Guid id)
        {
  if (!ModelState.IsValid)
            {
        TempData[ErrorKey] = "Datos inválidos";
 return RedirectToAction(nameof(MisCitas));
            }

            var pacienteId = ObtenerPacienteIdSesion();
            if (!pacienteId.HasValue)
          {
return RedirectToAction(LoginAction, LoginController);
    }

            try
      {
    var cita = await _appointmentService.ObtenerDetalleCitaAsync(id, pacienteId.Value);
    if (cita == null)
       {
              TempData[ErrorKey] = "Cita no encontrada";
return RedirectToAction(nameof(MisCitas));
                }

                return View(cita);
            }
       catch (Exception ex)
     {
_logger.LogError(ex, "Error al obtener detalle de cita {CitaId}", id);
   TempData[ErrorKey] = "Error al cargar el detalle de la cita";
        return RedirectToAction(nameof(MisCitas));
  }
        }

   // -------------------------------------
    // GET: /Cita/Agendar
        // -------------------------------------
        [HttpGet]
  public IActionResult Agendar()
        {
   var pacienteId = ObtenerPacienteIdSesion();
      if (!pacienteId.HasValue)
   {
                return RedirectToAction(LoginAction, LoginController);
      }

  return View();
        }

        // -------------------------------------
        // POST: /Cita/Agendar
   // -------------------------------------
        [HttpPost]
     public async Task<IActionResult> Agendar(AgendarCitaDto dto)
        {
    var pacienteId = ObtenerPacienteIdSesion();
    if (!pacienteId.HasValue)
     {
      return RedirectToAction(LoginAction, LoginController);
   }

  try
    {
            if (!ModelState.IsValid)
     {
              ViewBag.Error = "Por favor corrige los errores del formulario";
           return View(dto);
         }

       var cita = await _appointmentService.AgendarCitaAsync(dto, pacienteId.Value);

       TempData[MensajeExitoKey] = "¡Cita agendada exitosamente!";
   return RedirectToAction(nameof(Detalle), new { id = cita.Id });
        }
            catch (InvalidOperationException ex)
        {
        _logger.LogWarning(ex, "Error al agendar cita para paciente {PacienteId}", pacienteId);
        ViewBag.Error = ex.Message;
  return View(dto);
      }
 catch (Exception ex)
         {
_logger.LogError(ex, "Error inesperado al agendar cita");
                ViewBag.Error = "Error al agendar la cita. Intenta nuevamente";
                return View(dto);
    }
        }

        // -------------------------------------
   // POST: /Cita/Cancelar/{id}
        // -------------------------------------
   [HttpPost]
        public async Task<IActionResult> Cancelar(Guid id, string? motivoCancelacion)
        {
          if (!ModelState.IsValid)
     {
     TempData[ErrorKey] = "Datos inválidos";
       return RedirectToAction(nameof(Detalle), new { id });
       }

       var pacienteId = ObtenerPacienteIdSesion();
            if (!pacienteId.HasValue)
            {
   return RedirectToAction(LoginAction, LoginController);
    }

   try
          {
           await _appointmentService.CancelarCitaAsync(id, pacienteId.Value, motivoCancelacion);

    TempData[MensajeExitoKey] = "Cita cancelada exitosamente";
      return RedirectToAction(nameof(MisCitas));
     }
            catch (InvalidOperationException ex)
            {
    _logger.LogWarning(ex, "Error al cancelar cita {CitaId}", id);
      TempData[ErrorKey] = ex.Message;
  return RedirectToAction(nameof(Detalle), new { id });
      }
      catch (UnauthorizedAccessException ex)
            {
          _logger.LogWarning(ex, "Acceso no autorizado al cancelar cita {CitaId}", id);
           TempData[ErrorKey] = ex.Message;
                return RedirectToAction(nameof(MisCitas));
 }
            catch (Exception ex)
            {
        _logger.LogError(ex, "Error inesperado al cancelar cita {CitaId}", id);
       TempData[ErrorKey] = "Error al cancelar la cita";
                return RedirectToAction(nameof(Detalle), new { id });
  }
    }
    }
}
