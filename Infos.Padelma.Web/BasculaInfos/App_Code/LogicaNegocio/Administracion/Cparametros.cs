using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cparametros
/// </summary>
public class Cparametros
{
	public Cparametros()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public string RetornaValorParametro(string parametro)
    {
        string[] iParametros = new string[] { "@parametro" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { parametro };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaValorParametro",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaCorreoTiquete(string tiquete)
    {
        string[] iParametros = new string[] { "@tiquete" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tiquete };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaCorreoProcedenciaTiquete",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string[] RetornaDatosTiquete(string tiquete)
    {
        string[] iParametros = new string[] { "@tiquete" };
        string[] oParametros = new string[] { "@fechaE", "@pesoBruto", "@pesoTara", "@pesoNeto", "@vehiculo", "@remolque", "@procedencia",
            "@finca", "@racimos", "@sacos", "@pesoSacos", "@dura", "@tenera" };
        object[] objValores = new object[] { tiquete };
        string[] retorno = new string[13];

        object[] objRetorno = AccesoDatos.ExecProc(
            "spRetornaDatosTiquete",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        for (int i = 0; i < 13; i++)
        {
            retorno.SetValue(Convert.ToString(objRetorno.GetValue(i)), i);
        }

        return retorno;
    }

    public DataView GetCorreoTiquete(string tiquete)
    {
        string[] iParametros = new string[] { "@tiquete" };
        object[] objValores = new object[] { tiquete };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaCorreoProcedenciaTiquete",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
}
