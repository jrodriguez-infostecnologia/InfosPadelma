using System;
using System.Collections.Generic;
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

    
    public string RetornaConsecutivo(string tipoTransaccion, int empresa )
    {
        string[] iParametros = new string[] { "@tipoTransaccion" ,"@empresa"};
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { tipoTransaccion , empresa};

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spRetornaConsecutivoTransaccion",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

    public int ActualizaConsecutivo(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipo" ,"@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipoTransaccion , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaConsecutivoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}