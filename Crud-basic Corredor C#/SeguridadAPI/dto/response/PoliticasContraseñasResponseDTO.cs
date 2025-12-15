using System;

namespace SeguridadAPI.DTOs.Response
{
    public class PoliticasContraseñasResponseDTO
    {
        public int PoliticaID { get; set; }
        public int MinLongitud { get; set; }
        public int MaxLongitud { get; set; }
        public bool RequiereMayusculas { get; set; }
        public bool RequiereNumeros { get; set; }
        public bool RequiereSimbolos { get; set; }
        public int CaducidadDias { get; set; }
    }
}
