using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using MedCitas.Core.Services;
using System.ComponentModel.DataAnnotations;

namespace MedCitas.Web.Pages.Cuenta
{
    public class VerificarOTPModel : PageModel
    {
        private readonly PacienteService _pacienteService;

        public VerificarOTPModel(PacienteService pacienteService)
        {
            _pacienteService = pacienteService;
        }

        [BindProperty]
        [Required(ErrorMessage = "El correo es obligatorio")]
        [EmailAddress]
        public string Correo { get; set; } = string.Empty;

        [BindProperty]
        [Required(ErrorMessage = "El código OTP es obligatorio")]
        [RegularExpression(@"^\d{6}$", ErrorMessage = "El código debe tener 6 dígitos")]
        public string CodigoOTP { get; set; } = string.Empty;

        public string? Mensaje { get; set; }
        public bool Exitoso { get; set; }

        public void OnGet(string correo)
        {
            Correo = correo ?? string.Empty;
        }

        public async Task<IActionResult> OnPostAsync()
        {
            if (!ModelState.IsValid)
                return Page();

            try
            {
                var verificado = await _pacienteService.VerificarOTPAsync(Correo, CodigoOTP);
                
                if (verificado)
                {
                    Mensaje = "¡Cuenta verificada exitosamente!";
                    Exitoso = true;
                    return RedirectToPage("/Cuenta/Login");
                }
                else
                {
                    Mensaje = "Código OTP inválido o expirado.";
                    Exitoso = false;
                }
            }
            catch (Exception ex)
            {
                Mensaje = ex.Message;
                Exitoso = false;
            }

            return Page();
        }

        public async Task<IActionResult> OnPostReenviarAsync()
        {
            try
            {
                await _pacienteService.ReenviarOTPAsync(Correo);
                Mensaje = "Código reenviado exitosamente.";
                Exitoso = true;
            }
            catch (Exception ex)
            {
                Mensaje = ex.Message;
                Exitoso = false;
            }

            return Page();
        }
    }
}