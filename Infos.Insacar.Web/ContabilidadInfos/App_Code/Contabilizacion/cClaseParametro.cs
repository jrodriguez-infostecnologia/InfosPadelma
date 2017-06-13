using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de cClaseParametro
/// </summary>
public class cClaseParametro
{
	public cClaseParametro()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    ADInfos.AccesoDatos AccesoDatos = new ADInfos.AccesoDatos();


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet("cClaseParametroContaNomi", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and   descripcion like '%" + texto + "%'";

        return dvEntidad;
    }



}