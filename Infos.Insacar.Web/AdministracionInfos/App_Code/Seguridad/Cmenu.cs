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
/// Summary description for Clog
/// </summary>
public class Cmenu
{
	public Cmenu()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView GetMenuSitio(string modulo)
    {
        string[] iParametros = new string[] { "@modulo" };
        object[] objValores = new object[] { modulo };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaMenuSitio",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int ActualizaIdSysUsuario(string id, string idSys, string idSysNew)
    {
        string[] iParametros = new string[] { "@id", "@idSys", "@idSysNew" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { id, idSys, idSysNew };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaUsuarios",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
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
                "ppa").GetValue(0));
    }

    public string RetornaNombreEmpresa(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { "@nombreEmpresa" };
        object[] objValores = new object[] { empresa };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spRetornaNombreEmpresa",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

    public int RetornaCodigoEmpresaUsuario(string usuario)
    {
        string[] iParametros = new string[] { "@usuario" };
        string[] oParametros = new string[] { "@codigoEmpresa" };
        object[] objValores = new object[] { usuario };

        return Convert.ToInt16(
            AccesoDatos.ExecProc(
                "spRetornaCodigoEmpresaUsuario",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }


    public DataView SeleccionaEmpresaUsuario(string usuario)
    {
        string[] iParametros = new string[] { "@usuario" };
        object[] objValores = new object[] { usuario };

        return AccesoDatos.DataSetParametros(
            "spSeleccionEmpresaUsuarioPermisos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView SeleccionaMenu(string usuario, string clave)
    {
        string[] iParametros = new string[] { "@usuario", "@clave" };
        object[] objValores = new object[] { usuario, clave };

        return AccesoDatos.DataSetParametros(
            "SpseleccioaSitiosInfos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public string SeleccionaFoto(string usuario)
    {
        string[] iParametros = new string[] { "@usuario" };
        string[] oParametros = new string[] { "@foto" };
        object[] objValores = new object[] { usuario };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spretornafoto",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

 public string SeleccionaMenuPrincipal(string usuario, string clave, int empresa)
    {
        string[] iParametros = new string[] { "@usuario" ,"@clave","@empresa"};
        string[] oParametros = new string[] { "@menuPrincipal" };
        object[] objValores = new object[] { usuario,clave,empresa };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spSeleccionMenuPrincipal",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

}
