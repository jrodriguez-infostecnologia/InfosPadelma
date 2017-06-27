using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Coperadores
/// </summary>
public class CModificacionPrimas
{
    public CModificacionPrimas() { }

    public DataSet CargarDetallePrima(string empresa, string tipo, string numero)
    {
        string[] iParametros = new string[] { "@empresa", "@numero", "@tipo" };
        object[] objValores = new object[] { empresa, numero, tipo };

        return Cacceso.DataSetParametros(
            "SpSeleccionaDetalleLiquidacionPrima",
            iParametros,
            objValores,
            "ppa");
    }
}