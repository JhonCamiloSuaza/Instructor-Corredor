using SeguridadAPI.Entities;

namespace SeguridadAPI.Services
{
    public interface IPasswordPolicyService
    {
        /// <summary>
        /// Valida si la contraseña cumple la política. Devuelve true/false y un mensaje de error (si aplica).
        /// </summary>
        bool ValidarPassword(string password, PoliticasContraseñas politicas, out string mensaje);

        /// <summary>
        /// Comprueba si la contraseña (según la fecha de último cambio) ha expirado según la política.
        /// </summary>
        bool PasswordExpirada(DateTime? fechaUltimoCambio, PoliticasContraseñas politicas, out string mensaje);
    }
}
