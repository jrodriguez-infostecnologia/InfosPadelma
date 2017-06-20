using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cdestinos
/// </summary>
public class Cdestinos
{
	public Cdestinos()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public int ConsultaMostrarCuenta(string destino, Boolean inverson, int empresa)
    {
        string[] iParametros = new string[] { "@destino", "@inversion" ,"@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { destino, inverson , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpValidaCuentaPadreDestino",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView CuentasAuxiliares(string destino, Boolean inversion, int empresa)
    {
        string[] iParametros = new string[] { "@destino", "@inversion" ,"@empresa"};
        object[] objValores = new object[] { destino, inversion , empresa};

        return AccesoDatos.DataSetParametros(
            "SpSeleccionaCuentaDestinos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int ConsultaCuentaCentroCosto(string cuenta, int empresa)
    {
        string[] iParametros = new string[] { "@cuenta", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { cuenta, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpValidaCentroCostoCuenta",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ValidaCuentaMayor(string cuenta, int empresa)
    {
        string[] iParametros = new string[] { "@cuenta" ,"@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { cuenta , empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spValidaCuentaMayor",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ValidaDestinoInversion(string destino, Boolean inversion, int empresa)
    {
        string[] iParametros = new string[] { "@destino", "@inversion", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { destino, inversion, empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpValidaDestinosCuenta",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


}