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
/// Summary description for Cusuario
/// </summary>
public class Cusuario
{
    ADInfos.AccesoDatos AccesoDatos = new ADInfos.AccesoDatos();
	public Cusuario()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public string RetornaNombreUsuario(string id)
    {
        string[] iParametros = new string[] { "@id" };
        string[] oParametros = new string[] { "@nombre" };
        object[] objValores = new object[] { id };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spRetornaNombreUsuario",
                iParametros,
                oParametros,
                objValores,
                "seguridad").GetValue(0));
    }
}
