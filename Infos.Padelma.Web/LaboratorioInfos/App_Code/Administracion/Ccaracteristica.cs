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
/// Summary description for Ccaracteristica
/// </summary>
public class Ccaracteristica
{
	public Ccaracteristica()
	{
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    Cactividad actividades = new Cactividad();

    public DataView BuscaEntidad(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "pCaracteristica",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "codigo like '%" + texto + "%' or descripcion like '%" + texto + "%'";

          return dvEntidad;
    }

    public DataView BuscaEntidadClasificacion(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "pClasificacionCaracteristica",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "codigo like '%" + texto + "%' or descripcion like '%" + texto + "%'";

          return dvEntidad;
    }

    public DataView BuscaEntidadVariable(string texto)
    {
        DataView dvEntidad = AccesoDatos.EntidadGet(
           "pVariable",
           "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "codigo like '%" + texto + "%' or descripcion like '%" + texto + "%'";
        

        return dvEntidad;
    }

    public int IndicaCaracteristicaReferencia(string caracteristica)
    {
        string[] iParametros = new string[] { "@caracteristica" };
        string[] oPrametros = new string[] { "@retorno" };
        object[] objValores = new object[] { caracteristica };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spRetornaReferenciaCaracteristicaP",
            iParametros,
            oPrametros,
            objValores,
            "ppa").GetValue(0));
    }        

    public string RetornaEntidadCaracteristica(string caracteristica)
    {
        string[] iParametros = new string[] { "@caracteristica" };
        string[] oParametros = new string[] { "@entidad" };
        object[] objValores = new object[] { caracteristica };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaEntidadReferenciaCaracteristicaP",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaUmedida(string caracteristica)
    {
        string[] iParametros = new string[] { "@caracteristica" };
        string[] oParametros = new string[] { "@uMedida" };
        object[] objValores = new object[] { caracteristica };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaUmedidaCaracteristicaP",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaTipo(string caracteristica)
    {
        string[] iParametros = new string[] { "@caracteristica" };
        string[] oParametros = new string[] { "@tipo" };
        object[] objValores = new object[] { caracteristica };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaTipoCaracteristicaP",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaUmedidaVariable(string variable)
    {
        string[] iParametros = new string[] { "@variable" };
        string[] oParametros = new string[] { "@uMedida" };
        object[] objValores = new object[] { variable };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaUmedidaVariableP",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaUmedidaAnalisis(string analisis, int empresa)
    {
        string[] iParametros = new string[] { "@variable", "@empresa" };
        string[] oParametros = new string[] { "@uMedida" };
        object[] objValores = new object[] { analisis,empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaUmedidaAnalisisP",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
	
	  public DataSet GetMovimientoProducto(string producto, int empresa, string modulo)
    {
        string[] iParametros = new string[] { "@producto" ,"@empresa","@modulo"};
        object[] objValores = new object[] { producto , empresa, modulo};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaMovimientosProducto",
            iParametros,
            objValores,
            "ppa");
    }
}
