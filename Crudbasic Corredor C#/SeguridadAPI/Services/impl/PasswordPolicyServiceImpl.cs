using SeguridadAPI.Entities;
using System;
using System.Linq;
using System.Text.RegularExpressions;

namespace SeguridadAPI.Services.Impl
{
    public class PasswordPolicyServiceImpl : IPasswordPolicyService
    {
        public bool ValidarPassword(string password, PoliticasContraseñas politicas, out string mensaje)
        {
            mensaje = string.Empty;

            if (politicas is null)
            {
                mensaje = "Política de contraseñas no configurada.";
                return false;
            }

            if (string.IsNullOrEmpty(password))
            {
                mensaje = "Contraseña vacía.";
                return false;
            }

            if (password.Length < politicas.MinLongitud)
            {
                mensaje = $"La contraseña debe tener al menos {politicas.MinLongitud} caracteres.";
                return false;
            }

            if (password.Length > politicas.MaxLongitud)
            {
                mensaje = $"La contraseña debe tener como máximo {politicas.MaxLongitud} caracteres.";
                return false;
            }

            if (politicas.RequiereMayusculas && !password.Any(char.IsUpper))
            {
                mensaje = "La contraseña debe contener al menos una letra mayúscula.";
                return false;
            }

            if (politicas.RequiereNumeros && !password.Any(char.IsDigit))
            {
                mensaje = "La contraseña debe contener al menos un número.";
                return false;
            }

            // \w incluye letras, dígitos y guion bajo; \W cualquiera que no sea palabra.
            if (politicas.RequiereSimbolos && !Regex.IsMatch(password, @"[\W_]"))
            {
                mensaje = "La contraseña debe contener al menos un símbolo (p. ej. !@#$%).";
                return false;
            }

            return true;
        }

        public bool PasswordExpirada(DateTime? fechaUltimoCambio, PoliticasContraseñas politicas, out string mensaje)
        {
            mensaje = string.Empty;

            if (politicas is null)
            {
                mensaje = "Política de contraseñas no configurada.";
                return true; // tratar como expirada para forzar acción
            }

            if (!fechaUltimoCambio.HasValue)
            {
                // Si no hay fecha de último cambio la consideramos expirada
                mensaje = "La contraseña requiere actualización.";
                return true;
            }

            var dias = (DateTime.UtcNow - fechaUltimoCambio.Value.ToUniversalTime()).TotalDays;
            if (dias > politicas.CaducidadDias)
            {
                mensaje = $"La contraseña expiró hace {Math.Floor(dias)} días. Debe cambiarla.";
                return true;
            }

            return false;
        }
    }
}
