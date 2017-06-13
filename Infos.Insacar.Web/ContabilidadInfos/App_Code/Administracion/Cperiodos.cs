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
public class Cperiodos
{
    ADInfos.AccesoDatos CentidadMetodos = new ADInfos.AccesoDatos();

    public Cperiodos()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = CentidadMetodos.EntidadGet(
            "cPeriodo",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa = " + Convert.ToString(empresa) + " and periodo like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView GetAnosPeriodos()
    {
        return CentidadMetodos.DataSete(
            "spSeleccionaAnosCperiodos",
            "ppa").Tables[0].DefaultView;
    }



    public int AbrirCerrarPeriodosAno(int ano, int empresa, out int conteo, bool cerrado)
    {
        string[] iParametros = new string[] { "@ano", "@empresa", "@cerrado" };
        string[] oParametros = new string[] { "@retorno", "@conteo" };
        object[] objValores = new object[] { ano, empresa, cerrado };

        object[] resultado = CentidadMetodos.ExecProc(
            "spAbrirPeriodosAno",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        conteo = Convert.ToInt16(resultado.GetValue(1));

        return Convert.ToInt16(resultado.GetValue(0));
    }

    public int GenerarPeriodosAno(int ano, out int conteo, int empresa)
    {
        string[] iParametros = new string[] { "@ano", "@empresa" };
        string[] oParametros = new string[] { "@retorno", "@conteo" };
        object[] objValores = new object[] { ano, empresa };

        object[] resultado = CentidadMetodos.ExecProc(
            "spGeneraPeriodosAno",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        conteo = Convert.ToInt16(resultado.GetValue(1));

        return Convert.ToInt16(resultado.GetValue(0));
    }

    public int EliminarPeriodosAno(int a�o, int empresa)
    {
        string[] iParametros = new string[] { "@a�o", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { a�o, empresa };

        object[] resultado = CentidadMetodos.ExecProc(
            "spEliminarPeriodosAno",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        return Convert.ToInt16(resultado.GetValue(0));
    }

    public int RetornaPeriodoCerrado(string periodo)
    {
        string[] iParametros = new string[] { "@periodo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { periodo };

        return Convert.ToInt16(CentidadMetodos.ExecProc(
            "spRetornaPeriodoCerrado",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataSet PeriodosCeradoNominaA�o(int a�o, int empresa)
    {
        string[] iParametros = new string[] { "@a�o", "@empresa" };
        object[] objValores = new object[] { a�o, empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaCerradoNominaA�o",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet PeriodosSeguridadSocial(int a�o, int empresa)
    {
        string[] iParametros = new string[] { "@a�o", "@empresa" };
        object[] objValores = new object[] { a�o, empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionarPeriodosSeguridadSocial",
            iParametros,
            objValores,
            "ppa");
    }


    public DataView PeriodoA�oCerradoNomina(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaA�osCerradoNomina",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public string RetornaNombreArchivoPlano(int empresa, int a�o, int periodo)
    {
        string[] iParametros = new string[] { "@empresa", "@a�o", "@periodo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, a�o, periodo };

        return Convert.ToString(CentidadMetodos.ExecProc(
                "spRetornaNombreArchivoPlanoConta",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }
}
