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


    public int InsertaDespacho(string despacho, string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "@tipoTran", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { despacho, tipoTransaccion, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spInsertaDespacho",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }
    public int ActualizaConsecutivo(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToInt16(Cacceso.ExecProc("spActualizaConsecutivoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public void PasarInformacionSiesa()
    {
        string[] iParametros = new string[] { };
        string[] oParametros = new string[] { };
        object[] objValores = new object[] { };

        Cacceso.ExecProc("SpSincronizaInformacionSiesa", iParametros, oParametros, objValores, "ppa");
    }

    public void SicronizaCasino()
    {
        string[] iParametros = new string[] { };
        string[] oParametros = new string[] { };
        object[] objValores = new object[] { };

        Cacceso.ExecProc("spSincronizaCasino", iParametros, oParametros, objValores, "ppa");
    }


    public DataView BuscarEntidadCampo(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "gTipoTransaccionCampo",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and tipoTransaccion like '%" + texto + "%' or entidad like '%" + texto + "%' or campo = '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView BuscarEntidadConfig(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "gTipoTransaccionConfig",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and tipoTransaccion like '%" + texto + "%'";

        return dvEntidad;
    }

    public string RetornaConsecutivo(string tipoTransaccion)
    {
        string[] iParametros = new string[] { "@tipoTransaccion" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { tipoTransaccion };

        return Convert.ToString(
            Cacceso.ExecProc(
                "spRetornaConsecutivoTransaccion",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

    public DataView BuscarEntidadTransaccionProducto(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "gTipoTransaccionProducto",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and tipo like '%" + texto + "%' or producto like '%" + texto + "%'";

        return dvEntidad;
    }


    public DataView BuscarEntidadTransaccionBodega(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
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

        return Convert.ToInt16(Cacceso.ExecProc(
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

        return Convert.ToInt16(Cacceso.ExecProc(
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

        return Convert.ToInt16(Cacceso.ExecProc(
            "spEliminaProductoTipo",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}
