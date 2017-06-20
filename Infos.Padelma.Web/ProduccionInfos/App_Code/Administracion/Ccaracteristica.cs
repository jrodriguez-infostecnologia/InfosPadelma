using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Ccaracteristica
/// </summary>
public class Ccaracteristica
{
	public Ccaracteristica()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "pDensidad",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  item like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataSet GetMovimientoProducto(string producto, int empresa, string modulo)
    {
        string[] iParametros = new string[] { "@producto" ,"@empresa","@modulo"};
        object[] objValores = new object[] { producto , empresa, modulo};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaMovimientosProducto",
            iParametros,
            objValores,
            "ppa");
    }

    public string RetornaUmedidaAnalisis(string analisis, int empresa)
    {
        string[] iParametros = new string[] { "@variable" , "@empresa"};
        string[] oParametros = new string[] { "@uMedida" };
        object[] objValores = new object[] { analisis , empresa};

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaUmedidaAnalisisP",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}