using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cnivel
/// </summary>
public class Cnivel
{
	public Cnivel()
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
            "iNivelDestino",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  (descripcion like '%" + texto + "%'  or codigo  like '% " + texto+ "%')";

        return dvEntidad;
    }
}