using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cbonificacion
/// </summary>
public class Cbonificacion
{

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad( int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = AccesoDatos.EntidadGet("logBonificaMaquila", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) ;
        return dvEntidad;
    }


	public Cbonificacion()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
}