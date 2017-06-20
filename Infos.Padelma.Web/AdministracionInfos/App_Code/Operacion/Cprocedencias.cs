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
    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = CentidadMetodos.EntidadGet("bProcedencia", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + empresa.ToString() + " and (codigo like '%" + texto + "%' or desProveedor like '%" + texto + "%' or DesAgrupado like '%" + texto + "%')";
        return dvEntidad;
    }

    public DataView BuscarEntidadFinca(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(            "aProveedorJerarquiaCampo",            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "proveedor like '%" + texto + "%' or jerarquia like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView seleccionaProveedor(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaProveedorTercero",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView GetFincaSinProveedor()
    {
        return Cacceso.DataSet(
            "apSeleccionaFincaSinProveedor",
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetCorreoProcedencia()
    {
        return Cacceso.DataSet(
            "spSeleccionaCorreoProcedencia",
            "ppa").Tables[0].DefaultView;
    }

    public int GetConsecutivo(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { "@Retorno" };
        object[] objValores = new object[] { empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spConsecutivoProcedencia",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

}
