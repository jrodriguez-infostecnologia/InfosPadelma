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

    public int EliminarPeriodosAno(int año, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { año, empresa };

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

    public DataSet PeriodosCeradoNominaAño(int año, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@empresa" };
        object[] objValores = new object[] { año, empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaCerradoNominaAño",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet PeriodosSeguridadSocial(int año, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@empresa" };
        object[] objValores = new object[] { año, empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionarPeriodosSeguridadSocial",
            iParametros,
            objValores,
            "ppa");
    }


    public DataView PeriodoAñoCerradoNomina(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaAñosCerradoNomina",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public string RetornaNombreArchivoPlano(int empresa, int año, int periodo)
    {
        string[] iParametros = new string[] { "@empresa", "@año", "@periodo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, año, periodo };

        return Convert.ToString(CentidadMetodos.ExecProc(
                "spRetornaNombreArchivoPlanoConta",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }
}
