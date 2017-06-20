using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Ctransacciones
/// </summary>
public class Ctransacciones
{
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();

    public Ctransacciones()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public DataView EjecutaFormulaA(string jerarquia, string variable, string varObj, string modo, DateTime fecha, int empresa)
    {
        string[] iParametros = new string[] { "@producto", "@movimiento", "@objVar", "@modo", "@fecha", "@empresa" };
        object[] objValores = new object[] { jerarquia, variable, varObj, modo, fecha, empresa };

        return CentidadMetodos.DataSetParametros(
            "spEjecutaFormulaProduccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetMovimientoResultadoProducto(int producto, int empresa, string modulo)
    {
        string[] iParametros = new string[] { "@producto", "@empresa" ,"@modulo"};
        object[] objValores = new object[] { producto, empresa, modulo };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaMovimientosResultadoProducto",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetMovimientoResultadoProductoMostrar(int producto, int empresa, string modulo)
    {
        string[] iParametros = new string[] { "@producto", "@empresa", "@modulo" };
        object[] objValores = new object[] { producto, empresa, modulo };

        return CentidadMetodos.DataSetParametros("spSeleccionaMovimientosResultadoProductoMostrar",
            iParametros, objValores, "ppa").Tables[0].DefaultView;
    }


    public DataView GetProductos(string planta, int empresa)
    {
        string[] iParametros = new string[] { "@planta", "@empresa" };
        object[] objValores = new object[] { planta, empresa };

        return CentidadMetodos.DataSetParametros(
            "SpSeleccionaProductosPlanta",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

  public int AnulaTransaccion(string tipo, string numero, string usuario, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo", "@numero", "@usuario" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tipo, numero, usuario };

        return Convert.ToInt16(CentidadMetodos.ExecProc(
            "spAnulaTrnLaboratorio",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public DataView GetMovimientoResultadoProductoMostrar(string producto, int empresa)
    {
        string[] iParametros = new string[] { "@producto", "@empresa" };
        object[] objValores = new object[] { producto, empresa };

        return CentidadMetodos.DataSetParametros("spSeleccionaMovimientosResultadoProductoMostrar",
            iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    public DataView GetProductoTransaccion(string transaccion, int empresa)
    {
        string[] iParametros = new string[] { "@transaccion", "@empresa" };
        object[] objValores = new object[] { transaccion, empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaProductoTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetTransaccionCompleta(string where, int empresa)
    {
        string[] iParametros = new string[] { "@where", "@empresa" };
        object[] objValores = new object[] { where, empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaTransaccionCompletalTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
    public DataView GetTransaccionCompletaLaboratorio(string where, int empresa)
    {
        string[] iParametros = new string[] { "@where", "@empresa" };
        object[] objValores = new object[] { where, empresa };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaTransaccionCompletalTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetCamposEntidades(string id1, string id2)
    {
        string[] iParametros = new string[] { "@id1", "@id2" };
        object[] objValores = new object[] { id1, id2 };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaCamposEntidadesII",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView GetTipoTransaccionModulo(int empresa)
    {
        DataView dvTipoTransaccion = CentidadMetodos.EntidadGet(
            "gTipoTransaccion",
            "ppa").Tables[0].DefaultView;

        dvTipoTransaccion.RowFilter = "modulo= '" + ConfigurationManager.AppSettings["modulo"].ToString() + "'" + " and empresa = " + empresa.ToString();
        dvTipoTransaccion.Sort = "descripcion";

        return dvTipoTransaccion;
    }

    public string RetornaNumeroTransaccion(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@empresa" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToString(CentidadMetodos.ExecProc(
            "spRetornaConsecutivoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ActualizaConsecutivo(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToInt16(CentidadMetodos.ExecProc(
            "spActualizaConsecutivoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
	
	
    public DataView GetMovimientoResultadoFormulacion(string formulacion, int empresa, string modulo)
    {
        string[] iParametros = new string[] { "@formulacion", "@empresa", "@modulo" };
        object[] objValores = new object[] { formulacion, empresa, modulo };

        return CentidadMetodos.DataSetParametros(
            "spGetMovimientoResultadoFormulacion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView EjecutaFormulaLaboratario(string grupo,string jerarquia,string formulacion,  string variable, string varObj, string modo, DateTime fecha, int empresa)
    {
        string[] iParametros = new string[] { "@grupo", "@jerarquia","@formulacion", "@movimiento", "@objVar", "@modo", "@fecha", "@empresa" };
        object[] objValores = new object[] { grupo,jerarquia, formulacion, variable, varObj, modo, fecha, empresa };

        return CentidadMetodos.DataSetParametros(
            "spEjecutaFormulaLaboratorio",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

     
    public int VerificaRegistroFormulacion( int empresa, string tipo, DateTime fecha, string formulacion, string hora, string  minuto)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo", "@fecha","@formulacion", "@hora", "@minuto" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tipo, fecha, formulacion, hora, minuto };

        return Convert.ToInt16(CentidadMetodos.ExecProc(
            "spVerificaRegistroFormulacion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

}