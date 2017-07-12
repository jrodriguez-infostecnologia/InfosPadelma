using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for LiquidacionDetalle
/// </summary>
[Serializable]
public class LiquidacionPrimas
{
    public string CodigoTercero { get; set; }
    public string IdentificacionTercero { get; set; }
    public string NombreTercero { get; set; }
    public string FechaIngreso { get; set; }
    public string FechaInicial { get; set; }
    public string FechaFinal { get; set; }
    public string Basico { get; set; }
    public string Transporte { get; set; }
    public string ValorPromedio { get; set; }
    public string Base { get; set; }
    public string DiasPromedio { get; set; }
    public string DiasPrimas { get; set; }
    public string ValorPrima { get; set; }
    public int Contrato { get; set; }

    public LiquidacionPrimas()
    {

    }
}