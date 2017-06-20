using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cdensidad
/// </summary>
public class Cdensidad
{
	public Cdensidad()
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
}