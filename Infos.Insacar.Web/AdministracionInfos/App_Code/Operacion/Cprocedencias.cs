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
public class Cprocedencias
{
    public Cprocedencias()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();
    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "bProcedencia",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + empresa.ToString() + " and (codigo like '%" + texto + "%' or desProveedor like '%" + texto + "%')";
         return dvEntidad;
    }

    public DataView BuscarEntidadFinca(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "aProveedorJerarquiaCampo",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "proveedor like '%" + texto + "%' or jerarquia like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView GetFincaSinProveedor()
    {
        return AccesoDatos.DataSete(
            "apSeleccionaFincaSinProveedor",
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetCorreoProcedencia()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaCorreoProcedencia",
            "ppa").Tables[0].DefaultView;
    }
}
