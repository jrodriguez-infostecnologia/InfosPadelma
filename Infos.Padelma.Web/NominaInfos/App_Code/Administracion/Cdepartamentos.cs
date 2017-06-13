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
public class Cdepartamentos
{
    public Cdepartamentos()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "nDepartamento",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView GetDepartamentosUsuario(string usuario, int empresa)
    {
        string[] iParametros = new string[] { "@usuario" ,"@empresa"};
        object[] objValores = new object[] { usuario , empresa};

        return Cacceso.DataSetParametros(
            "spSeleccionaDepartamentosUsuario",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public string Consecutivo(string cCosto, int empresa)
    {
        string[] iParametros = new string[] { "@cCosto" ,"@empresa"};
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { cCosto ,empresa};

        return Convert.ToString(Cacceso.ExecProc(
            "spConsecutivoDepartamento",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}
