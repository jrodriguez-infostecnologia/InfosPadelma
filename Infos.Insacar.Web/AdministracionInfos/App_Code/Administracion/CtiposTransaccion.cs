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
public class CtiposTransaccion
{
    public CtiposTransaccion()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView GetTipoTransaccionModulo()
    {
        DataView dvTipoTransaccion = AccesoDatos.EntidadGet(
            "gTipoTransaccion",
            "ppa").Tables[0].DefaultView;

        dvTipoTransaccion.RowFilter = "codigo in ( 'EMP','DPT','DES' )";
        dvTipoTransaccion.Sort = "descripcion";

        return dvTipoTransaccion;
    }

    public DataView BuscarEntidad(string texto , int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "gTipoTransaccion",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa="+ Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView BuscarEntidadCampo(string texto,int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "gTipoTransaccionCampo",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and tipoTransaccion like '%" + texto + "%' or entidad like '%" + texto + "%' or campo = '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView BuscarEntidadConfig(string texto,int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "gTipoTransaccionConfig",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa="+ Convert.ToString(empresa) + " and tipoTransaccion like '%" + texto + "%'";

        return dvEntidad;
    }

    public string RetornaConsecutivo(string tipoTransaccion)
    {
        string[] iParametros = new string[] { "@tipoTransaccion" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { tipoTransaccion };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spRetornaConsecutivoTransaccion",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

    public DataView BuscarEntidadTransaccionProducto(string texto, int empresa) {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "gTipoTransaccionProducto",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and tipo like '%" + texto + "%' or producto like '%" + texto + "%'";

        return dvEntidad;
    }


    public DataView BuscarEntidadTransaccionBodega(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "iBodegaTipoTransaccion",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and tipo like '%" + texto + "%' or bodega like '%" + texto + "%'";

        return dvEntidad;
    }

    public int VerificaProductoTipo(string tipo, string producto, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo", "@producto" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tipo, producto };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaProductoTipoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int VerificaBodegaTipo(string tipo, string bodega, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo", "@bodega" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tipo, bodega };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaBodegaTipoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int EliminaProductoTipo(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tipo };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spEliminaProductoTipo",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}
