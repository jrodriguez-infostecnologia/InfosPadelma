using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cbascula
/// </summary>
public class Cbascula
{
	public Cbascula()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public int ActualizaBasculaMp(string tipo, string numero, decimal pesoTara, decimal pesoNeto, string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@pesoTara", "@pesoNeto", "@tiquete", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipo, numero, pesoTara, pesoNeto, tiquete , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaBasculaMp",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ActualizaBasculaMpMixto(string tipo, string numero, decimal pesoTara, decimal pesoNeto, string tiquete, int racimos, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@pesoTara", "@pesoNeto", "@tiquete", "@racimosTot", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipo, numero, pesoTara, pesoNeto, tiquete, racimos , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaBasculaMpMixto",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ActualizaBasculaDes(string tipo, string numero, decimal pesoBruto, decimal pesoNeto, string tiquete, int nroSacos, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@pesoBruto", "@pesoNeto", "@tiquete", "@nroSacos" ,"@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipo, numero, pesoBruto, pesoNeto, tiquete, nroSacos , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaBasculaDes",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ActualizaBasculaPes(string tipo, string numero, decimal pesoBruto, decimal pesoNeto, string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@pesoBruto", "@pesoNeto", "@tiquete", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipo, numero, pesoBruto, pesoNeto, tiquete , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaBasculaPes",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetRemisionNumero(string numero, int empresa)
    {
        string[] iParametros = new string[] { "@numero" ,"@empresa" };
        object[] objValores = new object[] { numero , empresa};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaRemisionNumero",
            iParametros,
            objValores,
            "agronomico").Tables[0].DefaultView;
    }

    public string RetornaFuncionarioAnalisis(string remision, int empresa)
    {
        string[] iParametros = new string[] { "@remision", "@empresa" };
        string[] oParametros = new string[] { "@funcionario" };
        object[] objValores = new object[] { remision , empresa};

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaUsuarioAnalisis",
            iParametros,
            oParametros,
            objValores,
            "agronomico").GetValue(0));
    }

    public DataView GetProductoTransaccion(string transaccion, int empresa)
    {
        string[] iParametros = new string[] { "@transaccion" ,"@empresa" };
        object[] objValores = new object[] { transaccion , empresa};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaProductoTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetFincasProcedencia(string procedencia, int empresa)
    {
        string[] iParametros = new string[] { "@procedencia", "@empresa" };
        object[] objValores = new object[] { procedencia, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaFincaProveedor",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

  
    public DataView GetPorteriaRemision(string remision, int empresa)
    {
        string[] iParametros = new string[] { "@remision" ,"@empresa" };
        object[] objValores = new object[] { remision , empresa};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaPorteriaRemision",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    
  
}
