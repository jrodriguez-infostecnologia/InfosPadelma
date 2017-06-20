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
        DataView dvEntidad = null;

         string[] iParametros = new string[] {"@empresa" };
        object[] objValores = new object[] { empresa };

        dvEntidad =  accesoDatos.DataSetParametros(
            "spSeleccioDocumentosCausacionNomina",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa =" + empresa + " and (numero like '%" + texto + "%' or periodoNomina like '%" + texto + "%' or periodoContable like '%" + texto + "%')";

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

    public DataView GuardaContabilizacion(int año, int periodo, string tipo, int empresa, int noComprobante, string nota, int consecutivocruce, DateTime fecha, string numero)
    {
        string[] iParametros = new string[] { "@año", "@periodo", "@tipo", "@empresa", "@noComprobante", "@nota", "@consecutivocruce", "@fecha", "@numero" };
        // string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { año, periodo, tipo, empresa, noComprobante, nota, consecutivocruce, fecha, numero };

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
        object[] objValores = new object[] { empresa };

        return accesoDatos.DataSetParametros(
            "spSeleccionaConceptosNoParametrizadosCon",
            iParametros,
            //oParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView RetornaDocumentosPeriodosNomina(int empresa, int año, int periodo)
    {
        string[] iParametros = new string[] { "@empresa", "@año", "@periodo" };
        // string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, año, periodo };

        return accesoDatos.DataSetParametros(
            "spRetornaDocumentosPeriodosNomina",
            iParametros,
            //oParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int PrecontabilizaNominaTipoPeriodo(int año, int periodo, string tipo, int empresa, DateTime fechaT, string usuario, string numero)
    {
        string[] iParametros = new string[] { "@año", "@periodo", "@tipo", "@empresa", "@fechaT", "@usuario", "@numeroTransaccion" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { año, periodo, tipo, empresa, fechaT, usuario, numero };
        return Convert.ToInt16(accesoDatos.ExecProc(
            "spPrecontabilizaNominaTipoPeriodo",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public void ContabilizaNominaTipoPeriodo(int año, int periodo, string tipo, int empresa, DateTime fechaT, string usuario, string observacion, string numero, out string retorno, out string noTransaccion)
    {
        string[] iParametros = new string[] { "@año", "@periodo", "@tipo", "@empresa", "@fechaT", "@usuario", "@observacion", "@numeroLiquidacion" };
        string[] oParametros = new string[] { "@retorno", "@numeroTraCont" };
        object[] objValores = new object[] { año, periodo, tipo, empresa, fechaT, usuario, observacion, numero };
        object [] retor = new  object[2] ;

        retor = accesoDatos.ExecProc(
            "spcontabilizaNominaTipoPeriodo",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        retorno = retor[0].ToString();
        noTransaccion = retor[1].ToString();
       
    }

    public int AnulaTransaccionContable(int empresa, string tipo, string tipoLiquidacion ,string numero, int año, int periodo, string usuario)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo", "@tipoLiquidacion", "@numero", "@año", "@periodo","@usuario" };
        string[] oParametros = new string[] { "@retorno"};
        object[] objValores = new object[] { empresa, tipo, tipoLiquidacion ,  numero, año, periodo, usuario };

        return  Convert.ToInt16(accesoDatos.ExecProc(
            "spAnulaTransacionContable",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GeneraPlanoContabilizacion(int año,  string tipo, int empresa,  string nocomprobante, string nota, int consecutivoCruce,
       DateTime fecha , string documentoContable)
    {
        string[] iParametros = new string[] {  "@año" ,
 "@tipo",
 "@empresa",
 "@noComprobante",
 "@nota",
 "@consecutivocruce",
 "@fecha",
 "@documentoContable"};
        object[] objValores = new object[] { año, tipo, empresa, nocomprobante, nota, consecutivoCruce, fecha, documentoContable };

        return accesoDatos.DataSetParametros(
            "spGeneraPlanoContabilizacion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView RetornaEmpleadosLiquidacionContratos(int empresa, int año, int periodo)
    {
        string[] iParametros = new string[] { "@empresa", "@año", "@periodo" };
        // string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, año, periodo };

        return accesoDatos.DataSetParametros(
            "spSeleccionaTercerosLiquidadosNC",
            iParametros,
            //oParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView SeleccionaDocumentostipo(string tipo, int empresa, int año)
    {
        DataView dvEntidad = null;

        string[] iParametros = new string[] { "@empresa", "@tipo" ,"@año"};
        object[] objValores = new object[] { empresa, tipo, año };

        dvEntidad = accesoDatos.DataSetParametros(
            "spSeleccionaDocumentosTipo",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        return dvEntidad;
    }




}
