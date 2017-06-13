using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cbodega
/// </summary>
public class Cbodega
{
	public Cbodega()
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
            "iBodega",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";

        return dvEntidad;
    }


    public DataView SeleccionaAuxiliaresBodega(int empresa, string bodega)
    {
        string[] iParametros = new string[] { "@empresa", "@bodega" };
        object[] objValores = new object[] { empresa,bodega };

       return  AccesoDatos.DataSetParametros(
            "spSeleccionaAuxiliaresBodega",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}