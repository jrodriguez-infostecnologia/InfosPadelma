using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cmercados
/// </summary>
public class Cmercados
{
	public Cmercados()
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
            "fMercado",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";

        return dvEntidad;
    }



    public string Consecutivo(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { tipo, empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spConsecutivoMercados",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

}