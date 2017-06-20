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
public class Cestados
{
    public Cestados()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public DataView BuscarEntidad(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "sEstados",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "estado like '%" + texto + "%' or descripcion like '%" + texto + "%'";

        return dvEntidad;
    }
}
