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

    AccesoDatos.AccesoDatos Cacceso = new AccesoDatos.AccesoDatos();


    public DataView GetAnalisisProducto(string producto, int empresa)
    {
        string[] iParametros = new string[] { "@producto", "@empresa" };
        object[] objValores = new object[] { producto, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaAnalisisProducto",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int ActualizaConsecutivo(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spActualizaConsecutivoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
    public string RetornaConsecutivo(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@empresa" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToString(Cacceso.ExecProc("spRetornaConsecutivoTransaccion",
                iParametros, oParametros, objValores, "ppa").GetValue(0));
    }

    public DataView SeleccionaBodegaProducto(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        object[] objValores = new object[] { tipo, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaBodegaProducto",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetProductoTransaccion(string transaccion, int empresa)
    {
        string[] iParametros = new string[] { "@transaccion", "@empresa" };
        object[] objValores = new object[] { transaccion, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaProductoTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetBasculaTiquete(string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tiquete", "@empresa" };
        object[] objValores = new object[] { tiquete, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaBregistroBasculaTiquete",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetBasculaNumero(string numero, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "@empresa" };
        object[] objValores = new object[] { numero, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaBregistroBasculaNumero",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetDespachoTiquete(string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tiquete", "@empresa" };
        object[] objValores = new object[] { tiquete, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaLogDespachoTiquete",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetAnalisisTiquete(string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tiquete", "@empresa" };
        object[] objValores = new object[] { tiquete, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaAnalisisTiquete",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetFincasProcedencia(string procedencia, int empresa)
    {
        string[] iParametros = new string[] { "@procedencia", "@empresa" };
        object[] objValores = new object[] { procedencia, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaFincaProveedor",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int AnulaTiquete(string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tiquete", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tiquete, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spAnulaTiqueteBascula",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int AnulaTiqueteNumero(string numero, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { numero, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spAnulaTiqueteIncompletoBascula",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int AnulaDespacho(string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tiquete", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tiquete, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spAnulaDespacho",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ActualizaTiquete(string tipo, string numero, string analisis, decimal valor, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@analisis", "@valor", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipo, numero, analisis, valor, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spActualizaAnalisisTiquete",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int AnulaCreaTiquete(string tiquete, string tipoTiquete, string tipoTrans, DateTime fechaProceso, decimal pesoBruto,
        decimal pesoTara, string vehiculo, string remolque, string producto, string procedencia, string finca, decimal racimos,
        decimal sacos, decimal pesoSacos, string sellos, string funcionario, out string tiqueteNuevo, int empresa, decimal pesoDescuento)
    {
        object[] objRetorno = new object[2];

        string[] iParametros = new string[]{ "@tiquete", "@tipoTiquete", "@tipoTrans", "@fechaProceso", "@pesoBruto", "@pesoTara","@pesoDes",
            "@vehiculo", "@remolque", "@producto", "@procedencia", "@finca", "@racimos", "@sacos", "@pesoSacos", "@sellos", "@funcionario" ,"@empresa"};
        string[] oParametros = new string[] { "@tiqueteN", "@retorno" };
        object[] objValores = new object[] { tiquete, tipoTiquete, tipoTrans, fechaProceso, pesoBruto, pesoTara,pesoDescuento, vehiculo, remolque, producto,
            procedencia, finca, racimos, sacos, pesoSacos, sellos, funcionario, empresa };

        objRetorno = Cacceso.ExecProc(
            "spAnulaModificaTiquete",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        tiqueteNuevo = Convert.ToString(objRetorno.GetValue(0));

        return Convert.ToInt16(objRetorno.GetValue(1));
    }

    public int CompletaTiquete(string numero, string tipoTiquete, string tipoTrans, DateTime fechaProceso, decimal pesoBruto,
        decimal pesoTara, string vehiculo, string remolque, string producto, string procedencia, string finca, int racimos,
        int sacos, decimal pesoSacos, string sellos, string funcionario, out string tiqueteNuevo, int empresa, decimal pesoDescuento)
    {
        object[] objRetorno = new object[2];

        string[] iParametros = new string[]{ "@numero", "@tipoTiquete", "@tipoTrans", "@fechaProceso", "@pesoBruto", "@pesoTara",
            "@vehiculo", "@remolque", "@producto", "@procedencia", "@finca", "@racimos", "@sacos", "@pesoSacos", "@sellos", "@funcionario" ,"@empresa","@pesoDescuento"};
        string[] oParametros = new string[] { "@tiqueteN", "@retorno"  };
        object[] objValores = new object[] { numero, tipoTiquete, tipoTrans, fechaProceso, pesoBruto, pesoTara, vehiculo, remolque, producto,
            procedencia, finca, racimos, sacos, pesoSacos, sellos, funcionario , empresa, pesoDescuento};

        objRetorno = Cacceso.ExecProc(
            "spCompletaTiquete",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        tiqueteNuevo = Convert.ToString(objRetorno.GetValue(0));

        return Convert.ToInt16(objRetorno.GetValue(1));
    }

    public int AnulaCreaDespacho(DateTime fecha, string tipo, string tipoC, string remision, string remisionC, string vehiculo, string remolque,
        string producto, string cliente, string lEntrega, string comercializadora, string planta, string tiquete, out string remisionN, int empresa)
    {
        object[] objRetorno = new object[2];

        string[] iParametros = new string[]{ "@fecha", "@tipo", "@tipoC", "@remision", "@remisionC", "@vehiculo", "@remolque",
            "@producto", "@cliente", "@lEntrega", "@comer", "@planta", "@tiquete" ,"@empresa"};
        string[] oParametros = new string[] { "@remisionN", "@retorno" };
        object[] objValores = new object[] { fecha, tipo, tipoC, remision, remisionC, vehiculo, remolque, producto, cliente, lEntrega, comercializadora,
            planta, tiquete, empresa };

        objRetorno = Cacceso.ExecProc(
            "spAnulaModificaDespacho",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        remisionN = Convert.ToString(objRetorno.GetValue(0));

        return Convert.ToInt16(objRetorno.GetValue(1));
    }

    public int ModificaDespacho(DateTime fecha, string remision, string remisionC, string vehiculo, string remolque,
        string producto, string cliente, string lEntrega, string comercializadora, string planta, string tiquete, int empresa)
    {
        object[] objRetorno = new object[1];

        string[] iParametros = new string[]{ "@fecha", "@remision", "@remisionC", "@vehiculo", "@remolque",
            "@producto", "@cliente", "@lEntrega", "@comer", "@planta", "@tiquete" , "@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { fecha, remision, remisionC, vehiculo, remolque, producto, cliente, lEntrega, comercializadora,
            planta, tiquete ,empresa};

        objRetorno = Cacceso.ExecProc(
            "spModificaDespacho",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        return Convert.ToInt16(objRetorno.GetValue(0));
    }

    public int ModificaTiquete(string tiquete, DateTime fechaProceso, decimal pesoBruto, decimal pesoTara, string vehiculo, string remolque,
        string producto, string procedencia, string finca, decimal racimos, decimal sacos, decimal pesoSacos, string sellos, string bodega, string cooperativa, int empresa, decimal pesoDes)
    {
        object[] objRetorno = new object[2];

        string[] iParametros = new string[]{ "@tiquete", "@fechaProceso", "@pesoBruto", "@pesoTara", "@vehiculo", "@remolque", "@producto", 
            "@procedencia", "@finca", "@racimos", "@sacos", "@pesoSacos", "@sellos" ,"@bodega", "@cooperativa","@empresa","@pesoDes"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tiquete, fechaProceso, pesoBruto, pesoTara, vehiculo, remolque, producto,
            procedencia, finca, racimos, sacos, pesoSacos, sellos,bodega,cooperativa , empresa, pesoDes};

        objRetorno = Cacceso.ExecProc(
            "spModificaTiquete",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        return Convert.ToInt16(objRetorno.GetValue(0));
    }

    public int ModificaIncompleto(string numero, DateTime fechaProceso, decimal pesoBruto, decimal pesoTara, string vehiculo, string remolque,
        string producto, string procedencia, string finca, int racimos, int sacos, decimal pesoSacos, string sellos, string bodega, string descargador, int empresa, decimal pesoDescuento)
    {
        object[] objRetorno = new object[2];

        string[] iParametros = new string[]{ "@numero", "@fechaProceso", "@pesoBruto", "@pesoTara", "@vehiculo", "@remolque", "@producto", 
            "@procedencia", "@finca", "@racimos", "@sacos", "@pesoSacos", "@sellos" ,"@bodega","@descargador","@empresa","@pesoDescuento"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { numero, fechaProceso, pesoBruto, pesoTara, vehiculo, remolque, producto,
            procedencia, finca, racimos, sacos, pesoSacos, sellos , bodega,descargador,empresa, pesoDescuento};

        objRetorno = Cacceso.ExecProc(
            "spModificaBasculaIncompleto",
            iParametros,
            oParametros,
            objValores,
            "ppa");

        return Convert.ToInt16(objRetorno.GetValue(0));
    }

    public DataView GetLugarEntregaCliente(string cliente, int empresa)
    {
        string[] iParametros = new string[] { "@cliente", "@empresa" };
        object[] objValores = new object[] { cliente, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaLugarEntregaCliente",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetIncompletos(int empresa)
    {

        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaIncompletosBascula",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;


    }


    public DataView GetLugarEntregaCliente(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaIncompletosBascula",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}