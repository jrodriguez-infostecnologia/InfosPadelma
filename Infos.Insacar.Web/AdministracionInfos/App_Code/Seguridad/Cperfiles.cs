using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cperfiles
/// </summary>
public class Cperfiles
{
	public Cperfiles()
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
            "sPerfiles",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "codigo like '%" + texto + "%' or descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView GetPermisosPerfilCab(string perfil)
    {
        string[] iParametros = new string[] { "@perfil" };
        object[] objValores = new object[] { perfil };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaPerfilPermisosCab",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetPermisosPerfil(string perfil)
    {
        DataView dvPerfil = AccesoDatos.EntidadGet(
            "perfilPermisos",
            "ppa").Tables[0].DefaultView;

        dvPerfil.RowFilter = "perfil = '" + perfil + "'";

        return dvPerfil;
    }

    public int InsertaPerfilPermisos(bool activo, string perfil, string sitio, string menu, string operacion, bool todasOperacion)
    {
        string[] iParametros = new string[] { "@activo", "@perfil", "@sitio", "@menu", "@operacion", "@todasOperaciones" };
        string[] oParametros = new string[] { "@Retorno" };
        object[] objValores = new object[] { activo, perfil, sitio, menu, operacion, todasOperacion };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpInsertaperfilPermisos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int EliminaPermisosPerfilSitioMenu(string perfil, string sitio, string menu)
    {
        string[] iParametros = new string[] { "@perfil", "@sitio", "@menu" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { perfil, sitio, menu };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spEliminaPerfilPermisosSitioMenu",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetDepartamentosPerfil(string perfil)
    {
        string[] iParametros = new string[] { "@perfil" };
        object[] objValores = new object[] { perfil };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaPerfilDepartamentos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
}
