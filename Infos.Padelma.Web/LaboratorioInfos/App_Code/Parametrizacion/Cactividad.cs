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
/// Summary description for Cjerarquia
/// </summary>
public class Cactividad
{
    public Cactividad()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();
    public DataView BuscarEntidad(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "pActividad",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "labor like '%" + texto + "%' or descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataSet BuscarEntidadCicloValor(string labor, string texto)
    {
        string[] iParametros = new string[] { "@labor", "@texto" };
        object[] objValores = new object[] { labor, texto };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaLaborCicloValor",
            iParametros,
            objValores,
            "ppa");
    }

    public DataView BuscarContadorLabor(string labor)
    {
        DataView dvContador = AccesoDatos.EntidadGet(
            "cContadorLabor",
            "agronomico").Tables[0].DefaultView;

        dvContador.RowFilter = "labor = '" + labor + "'";

        return dvContador;
    }

    public DataSet GetClasificacionActividad()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaClasificacionActividadPro",
            "ppa");
    }

    public DataSet GetActividadCalsificacion(string clasificacion)
    {
        string[] iParametros = new string[] { "@clasificacion" };
        object[] objValores = new object[] { clasificacion };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaActividadClasificacionPro",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet GetCaracteristicaActividad(string labor)
    {
        string[] iPramaetros = new string[] { "@labor" };
        object[] objValores = new object[] { labor };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaCaracteristicaActividadPro",
            iPramaetros,
            objValores,
            "ppa");
    }

    public DataView GetLaboresCicloCosto()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaLaboresCicloCosto",
            "agronomico").Tables[0].DefaultView;
    }

    public DataView GetLaboresCostoPadre(int nivel, int padre, string labor)
    {
        string[] iParametros = new string[] { "@nivel", "@padre", "@labor" };
        object[] objValores = new object[] { nivel, padre, labor };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaLaborCostoPadre",
            iParametros,
            objValores,
            "agronomico").Tables[0].DefaultView;
    }

    public DataView GetJerarquiasSinCicloCosto(int nivel, int padre, string labor)
    {
        string[] iParametros = new string[] { "@nivel", "@padre", "@labor" };
        object[] objValores = new object[] { nivel, padre, labor };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaJerarquiaSinLaborCosto",
            iParametros,
            objValores,
            "agronomico").Tables[0].DefaultView;
    }

    public bool IsActividad(string actividad)
    {
        DataView dvLabores = new DataView();
        bool retorno = true;

        dvLabores = AccesoDatos.EntidadGet(
            "mActividad",
            "ppa").Tables[0].DefaultView;

        dvLabores.RowFilter = "codigo = '" + actividad + "'";

        if (dvLabores.Count == 0)
        {
            retorno = false;
        }

        return retorno;
    }

    public int RetornaAplicaCantidadUmedidaLabor(string labor, out string uMedida)
    {
        int retorno = 0;
        object[] objRetorno = new object[2];
        string[] iParametros = new string[] { "@labor" };
        string[] oParametros = new string[] { "@programacionCantidad", "@uMedida" };
        object[] objValores = new object[] { labor };

        objRetorno = AccesoDatos.ExecProc(
            "spRetornaAplicaCantidadUmedidaLabor",
            iParametros,
            oParametros,
            objValores,
            "agronomico");

        retorno = Convert.ToInt16(objRetorno.GetValue(0));
        uMedida = Convert.ToString(objRetorno.GetValue(1));

        return retorno;
    }

    public string RetornaProcedimientoLabor(string labor)
    {
        string[] iParametros = new string[] { "@labor" };
        string[] oParametros = new string[] { "@procedimiento" };
        object[] objValores = new object[] { labor };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaDescripcionProcedimientoActividadPro",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetContadorLabor(int nivel, int padre, string labor)
    {
        string[] iParametros = new string[] { "@nivel", "@padre", "@labor" };
        object[] objValores = new object[] { nivel, padre, labor };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaContadorLaborPadre",
            iParametros,
            objValores,
            "agronomico").Tables[0].DefaultView;
    }

    public DataView GetJerarquiasSinConteoLabor(int nivel, int padre, string labor)
    {
        string[] iParametros = new string[] { "@nivel", "@padre", "@labor" };
        object[] objValores = new object[] { nivel, padre, labor };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaJerarquiaSinConteoLabor",
            iParametros,
            objValores,
            "agronomico").Tables[0].DefaultView;
    }
}
