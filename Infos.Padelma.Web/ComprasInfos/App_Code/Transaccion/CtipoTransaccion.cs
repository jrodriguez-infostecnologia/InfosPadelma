using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CtipoTransaccion
/// </summary>
public class CtipoTransaccion
{
	public CtipoTransaccion()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView GetTipoTransaccionModulo(int empresa)
    {
        DataView dvTipoTransaccion = AccesoDatos.EntidadGet(
            "gTipoTransaccion",
            "ppa").Tables[0].DefaultView;

        dvTipoTransaccion.RowFilter = " empresa = " + Convert.ToString(empresa) + "and modulo = '" + ConfigurationManager.AppSettings["Modulo"].ToString() + "'";
        dvTipoTransaccion.Sort = "descripcion";

        return dvTipoTransaccion;
    }

    public string TipoTransaccionConfig(string tipoTransaccion, int empresa)
    {
        string retorno = "";
        object[] objKey = new object[] { empresa, tipoTransaccion };

        foreach (DataRowView registro in AccesoDatos.EntidadGetKey(
            "gTipoTransaccionConfig",
            "ppa",
            objKey).Tables[0].DefaultView)
        {
            for (int i = 2; i < registro.Row.ItemArray.Length; i++)
            {
                retorno = retorno + registro.Row.ItemArray.GetValue(i).ToString() + "*";
            }
        }

        return retorno;
    }

    private string RetornaDsTipoTransaccion(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@empresa" };
        string[] oParametros = new string[] { "@ds" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaDsTipoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetReferenciaTercero(string tercero, string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tercero" ,"@empresa"};
        object[] objValores = new object[] { tercero , empresa};

        return AccesoDatos.DataSetParametros(
            RetornaDsTipoTransaccion(tipoTransaccion, empresa),
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetReferencia(string tipoTransaccion, int empresa, int tercero)
    {
        string[] iParametros = new string[] {"@empresa","@tercero"};
        object[] objValores = new object[] { empresa, tercero};

        return AccesoDatos.DataSetParametros(
            RetornaDsTipoTransaccion(tipoTransaccion, empresa),
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int RetornaReferenciaTipoTransaccion(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion" ,"@empresa"};
        string[] oParametros = new string[] { "@referencia" };
        object[] objValores = new object[] { tipoTransaccion , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spRetornaReferenciaTipoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int RetornavalidacionRegistro(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipo" ,"@empresa"};
        string[] oParametros = new string[] { "@retorna" };
        object[] objValores = new object[] { tipoTransaccion , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpRetornaDiaSemanaTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public DataView ExecReferenciaDetalle(string sp, string numero, int empresa)
    {
        string[] iParametros = new string[] { "@numero" ,"@empresa"};
        object[] objValores = new object[] { numero , empresa};

        return AccesoDatos.DataSetParametros(
            sp,
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}