using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Threading.Tasks;

namespace MedCitas.Core.Services
{
    public static class OtpService
    {
        private const int OTP_EXPIRATION_MINUTES = 15;

        public static string GenerarOTP()
        {
            return RandomNumberGenerator.GetInt32(100000, 999999).ToString();
        }

        public static DateTime ObtenerFechaExpiracion()
        {
            return DateTime.UtcNow.AddMinutes(OTP_EXPIRATION_MINUTES);
        }

        public static bool ValidarOTP(string otpIngresado, string otpAlmacenado, DateTime? expiracion)
        {
            if (string.IsNullOrWhiteSpace(otpIngresado) ||
                string.IsNullOrWhiteSpace(otpAlmacenado) ||
                expiracion == null)
                return false;

            if (DateTime.UtcNow > expiracion)
                return false;

            return otpIngresado == otpAlmacenado;
        }
    }
}
