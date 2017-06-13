using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cmodulos
/// </summary>
public class Cmodulos
{
	public Cmodulos()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "sModulos",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "codigo like '%" + texto + "%' or descripcion like '%" + texto + "%'";

        return dvEntidad;
    }


    public DataView GetPermisosPerfilCab(string perfil)
    {
        string[] iParametros = new string[] { "@perfil" };
        object[] objValores = new object[] { perfil };

        return AccesoDatos.DataSetParametros(
            "SpInsertagFoto",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}