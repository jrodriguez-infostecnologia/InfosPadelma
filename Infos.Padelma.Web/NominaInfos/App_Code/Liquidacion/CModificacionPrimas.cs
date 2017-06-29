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

    public DataRow CargarCabeceraPrima(string empresa, string tipo, string numero)
    {
        string[] iParametros = new string[] { "@empresa", "@numero", "@tipo" };
        object[] objValores = new object[] { empresa, numero, tipo };

        var ds = Cacceso.DataSetParametros(
            "SpSeleccionaCabeceraLiquidacionPrima",
            iParametros,
            objValores,
            "ppa");
        return ds.Tables[0].Rows.Count > 0 ? ds.Tables[0].Rows[0] : null;
    }

    public void GuardarCambios(DataTable table)
    {
        string[] iParametros = new string[] { "@DataTable" };
        string[] oParametros = new string[] {  };
        object[] objValores = new object[] { table };

        var ds = Cacceso.ExecProc(
            "SpActualizaDetalleLiquidacionPrima",
            iParametros,
            oParametros,
            objValores,
            "ppa");
    }
}