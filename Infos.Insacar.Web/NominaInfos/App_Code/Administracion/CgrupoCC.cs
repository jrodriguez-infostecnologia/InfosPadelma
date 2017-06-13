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
/// Summary description for Cccostos
/// </summary>
public class CgrupoCC
{
    public CgrupoCC()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = CentidadMetodos.EntidadGet("cGrupoCCosto", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa =" + empresa.ToString() + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";
        return dvEntidad;
    }
}
