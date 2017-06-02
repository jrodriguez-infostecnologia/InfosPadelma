using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Web.UI.Adapters;

/// <summary>
/// Summary description for Logica
/// </summary>
public class Logica
{
    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();
	public Logica()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public int VerificaUsuario(string usuario, string clave, string sitio)
    {
        int retorno = 0;

        try
        {
            string[] iParametros = new string[] { "@usuario", "@clave", "@sitio" };
            string[] oParametros = new string[] { "@retorno" };
            object[] objValores = new object[] { usuario, clave, sitio };

            retorno = Convert.ToInt16(AccesoDatos.ExecProc(
                "spSeguridadVerificaUsuario",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
        }
        catch
        {
            return -1;
        }

        return retorno;
    }

    public int InsertaLog(string usuario, string operacion, string entidad , string estado, string mensaje, string ip, int empresa)
    {
        string empresas = null;
        if (empresa == 0)
            empresas = null;
        else
            empresas = Convert.ToString(empresa);

        string[] iParametros = new string[] { "@usuario", "@operacion","@entidad", "@estado", "@mensajeSistema", "@ip","@empresa" };
        string[] oParametros = new string[] { "@Retorno" };
        object[] objValores = new object[] { usuario, operacion, entidad, estado, mensaje, ip , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpInsertaLogRegistro",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int VerificaAccesoPagina(string usuario, string sitio, string pagina, int empresa)
    {
        string[] iParametros = new string[] { "@usuario", "@sitio", "@pagina","@empresa" };
        string[] oParametros = new string[] { "@conteo" };
        object[] objValores = new object[] { usuario, sitio, pagina, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaAccesoPagina",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int VerificaAccesoOperacion(string usuario, string sitio, string pagina, string operacion, int empresa)
    {
        string[] iParametros = new string[] { "@usuario", "@sitio", "@pagina", "@operacion","@empresa" };
        string[] oParametros = new string[] { "@conteo" };
        object[] objValores = new object[] { usuario, sitio, pagina, operacion, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaAccesoOperaciones",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int RetornaEmpresa(string usuario)
    {
        string[] iParametros = new string[] { "@usuario" };
        string[] oParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { usuario };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spRetornaEmpresa",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}
