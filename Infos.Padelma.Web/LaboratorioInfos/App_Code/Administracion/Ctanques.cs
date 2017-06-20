using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Canalisis
/// </summary>
public class Ctanques
{
	public Ctanques()
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
            "lTanque",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

  
    public int EliminaAnalisis(int item, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@item" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, item };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpEliminalAnalisisItem",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetAnalisisProducto(string producto, int empresa)
    {
        string[] iParametros = new string[] { "@producto" ,"@empresa"};
        object[] objValores = new object[] { producto , empresa};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaAnalisisProducto",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}