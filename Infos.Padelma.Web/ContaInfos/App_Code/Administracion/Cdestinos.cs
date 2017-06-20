using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for Cestados
/// </summary>
public class Cdestinos
{
   
    public Cdestinos()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = accesoDatos.EntidadGet(
            "iDestino",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + empresa.ToString() + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView BuscarEntidadNivel(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = accesoDatos.EntidadGet(
            "iNivelDestino",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView GetDestinoNivel(int nivel, int empresa)
    {
        string[] iParametros = new string[] { "@nivel", "@empresa"};
        object[] objValores = new object[] { nivel, empresa };

        return accesoDatos.DataSetParametros(
            "spSeleccionaDestinoNivel",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
}
