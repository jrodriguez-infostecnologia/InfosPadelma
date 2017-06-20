using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Descripción breve de Cvehiculos
/// </summary>
public class Cvehiculos
{
	public Cvehiculos()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos Cacceso = new AccesoDatos.AccesoDatos();

    public DataView GetVehiculosAnalisis(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { };
        object[] objValores = new object[] { empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaVehiculosAnalisis",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
       

    public object[] GetVehiculosAnalisisRemision(string remision, int empresa)
    {
        object[] objResultado = new object[10];
        string[] iParametros = new string[] { "@remision","@empresa" };
        object[] objValores = new object[] { remision, empresa };

        foreach (DataRowView registro in Cacceso.DataSetParametros(
            "spSeleccionaVehiculosAnalisisRemision",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView)
        {
            objResultado.SetValue(registro.Row.ItemArray.GetValue(0), 0);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(1), 1);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(2), 2);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(3), 3);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(4), 4);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(5), 5);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(6), 6);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(7), 7);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(8), 8);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(9), 9);
        }

        return objResultado;
    }

    public int ActualizaEstadoBascula(string tipoTransaccion, string remision, string estado, string sellos, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@remision", "@estado", "@sellos" ,"@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipoTransaccion, remision, estado, sellos, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spActualizaEstadoRegistroBascula",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int InsertaDespacho(string despacho, string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@numero",  "@tipoTran" ,"@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { despacho,  tipoTransaccion, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spInsertaDespacho",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int ActualizaOS(string despacho,  int empresa, string motivo)
    {
        string[] iParametros = new string[] { "@numero",  "@empresa" ,"@motivo"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { despacho,  empresa, motivo };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spActualizaOS",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int VerificaRemisionComercializadora(string despacho, int empresa)
    {
        string[] iParametros = new string[] { "@numero","@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { despacho , empresa};

        return Convert.ToInt16(Cacceso.ExecProc(
            "spVerificaRemisionComercializadora",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView SeleccionaBodegaTipo(string tipo,string item, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@item","@empresa" };
        object[] objValores = new object[] { tipo,item, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaBodegaTipoTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int verificaOrdenSalida(string despacho,  int empresa)
    {
        string[] iParametros = new string[] { "@despacho", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { despacho,  empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spVerificaOrdenSalida",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
     public int ActualizaEstadoBasculaRemision(string tipoTransaccion, string numero, string estado, string sellos, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@numero", "@estado", "@sellos","@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipoTransaccion, numero, estado, sellos, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spActualizaEstadoRegistroBasculaRemision",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
        public DataView GetVehiculosAnalisisModificacion(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { };
        object[] objValores = new object[] { empresa };
        return Cacceso.DataSetParametros("spSeleccionaVehiculosAnalisisModificacion", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }


    public object[] GetVehiculosAnalisisRemisionModificacion(string remision, int empresa)
    {
        object[] objResultado = new object[10];
        string[] iParametros = new string[] { "@remision", "@empresa" };
        object[] objValores = new object[] { remision, empresa };

        foreach (DataRowView registro in Cacceso.DataSetParametros("spSeleccionaVehiculosAnalisisRemisionModificacion", iParametros, objValores, "ppa").Tables[0].DefaultView)
        {
            objResultado.SetValue(registro.Row.ItemArray.GetValue(0), 0);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(1), 1);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(2), 2);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(3), 3);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(4), 4);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(5), 5);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(6), 6);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(7), 7);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(8), 8);
            objResultado.SetValue(registro.Row.ItemArray.GetValue(9), 9);
        }

        return objResultado;
    }
}