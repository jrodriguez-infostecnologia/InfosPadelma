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
public class Ccontabilizacion
{
    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();
    public Ccontabilizacion()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = accesoDatos.EntidadGet(
            "cPuc",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa =" + empresa + " and (codigo like '%" + texto + "%' or nombre like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView GetPucDestino(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        object[] objValores = new object[] { tipo, empresa };

        return accesoDatos.DataSetParametros(
            "spSeleccionaPucTipo",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GuardaContabilizacion(int año, int periodo, string tipo, int empresa, int noComprobante, string nota, int consecutivocruce, DateTime fecha)
    {
        string[] iParametros = new string[] {  "@año" ,"@periodo","@tipo","@empresa","@noComprobante","@nota","@consecutivocruce","@fecha"};
      // string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { año, periodo, tipo, empresa, noComprobante, nota, consecutivocruce, fecha };

        return accesoDatos.DataSetParametros(
            "spGuardaContabilizacion",
            iParametros,
          //oParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView VerificaConceptosSinParametros(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        // string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] {empresa };

        return accesoDatos.DataSetParametros(
            "spSeleccionaConceptosNoParametrizadosCon",
            iParametros,
            //oParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
}
