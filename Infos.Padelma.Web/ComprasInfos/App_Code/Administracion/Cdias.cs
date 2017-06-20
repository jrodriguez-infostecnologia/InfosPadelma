using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cdias
/// </summary>
public class Cdias
{
	public Cdias()
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
            "gTipoTransaccionDias",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  tipo like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView GetTipoTransaccionModulo(int empresa)
    {
        DataView dvTipoTransaccion = AccesoDatos.EntidadGet(
            "gTipoTransaccion",
            "ppa").Tables[0].DefaultView;

        dvTipoTransaccion.RowFilter = " empresa = " + Convert.ToString(empresa) + "and modulo = '" + ConfigurationManager.AppSettings["Modulo"].ToString() + "'";
        dvTipoTransaccion.Sort = "descripcion";

        return dvTipoTransaccion;
    }
}