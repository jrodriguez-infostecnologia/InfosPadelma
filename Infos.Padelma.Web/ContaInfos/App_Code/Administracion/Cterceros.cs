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
public class Cterceros
{
    ADInfos.AccesoDatos accesodatos = new ADInfos.AccesoDatos();
    public Cterceros()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = accesodatos.EntidadGet(
            "cTercero",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa="+empresa+" and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";
        dvEntidad.Sort = "descripcion";

        return dvEntidad;
    }



    public DataView RetornaDatosTercero(string tercero, int empresa)
    {
        string[] iParametros = new string[] { "@tercero", "@empresa" };
        object[] objValores = new object[] { tercero, empresa };

        return accesodatos.DataSetParametros(
            "spRetornaDatosTercero",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int VerificaTercero(string tercero, out string nombre)
    {        
        object[] objKey = new object[] { tercero };

        DataView dvTerceros = accesodatos.EntidadGetKey(
            "cTerceros",
            "ppa",
            objKey).Tables[0].DefaultView;

        dvTerceros.RowFilter = "estado = 'S'";

        foreach (DataRowView registro in dvTerceros)
        {
            nombre = Convert.ToString(registro.Row.ItemArray.GetValue(1));
            return 1;
        }

        nombre = "!! Tercero Inexistente !!";
        return 0;
    }

    public int RetornaConsecutivoIdtercero(int empresa)
    {

        string[] iParametros = new string[] { "@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa};

        object[] resultado = accesodatos.ExecProc(
            "spRetornaConsecutivoIdTercero",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        return Convert.ToInt16(resultado.GetValue(0));

    }


    public int RetornaCodigoTercero(string codigo, int empresa)
    {

        string[] iParametros = new string[] { "@codigo","@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { codigo, empresa};

        object[] resultado = accesodatos.ExecProc(
            "spRetornaCodigoTercero",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        return Convert.ToInt16(resultado.GetValue(0));

    }


    public DataView SeleccionaTercerosProveedor( int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return accesodatos.DataSetParametros(
            "spSeleccionaTercerosProveedor",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}
