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
 public DataView GetTipoTransaccionModulo(int empresa)
    {
        DataView dvTipoTransaccion = AccesoDatos.EntidadGet(
            "gTipoTransaccion",
            "ppa").Tables[0].DefaultView;

        dvTipoTransaccion.RowFilter = " empresa = " + Convert.ToString(empresa) + "and modulo = '" + ConfigurationManager.AppSettings["Modulo"].ToString() + "'";
        dvTipoTransaccion.Sort = "descripcion";

        return dvTipoTransaccion;
    }

 public DataView GetTipoTransaccionModuloFormulacion(int empresa)
 {
     string[] iParametros = new string[] { "@empresa" };
     object[] objValores = new object[] { empresa };

     return AccesoDatos.DataSetParametros("spGetTipoTransaccionModuloFormulacion",
         iParametros, objValores, "ppa").Tables[0].DefaultView;
 }

    public string RetornaTipoBorrado(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@empresa" };
        string[] oParametros = new string[] { "@tipoBorrado" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaModoBorradoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ValidaRegistroProductoFecha(int producto, DateTime fecha, int empresa)
    {
        string[] iParametros = new string[] { "@producto", "@fecha", "@empresa" };
        string[] oParametros = new string[] { "@Retorno" };
        object[] objValores = new object[] { producto, fecha, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVelidaRegistroProductoFecha",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public DataView ExecReferenciaDetalle(string sp, string numero, DateTime fecha, int empresa)
    {
        string[] iParametros = new string[] { "@producto", "@fecha", "@empresa" };
        object[] objValores = new object[] { numero, fecha, empresa };

        return AccesoDatos.DataSetParametros(
            sp,
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaProductoMovimiento(int producto, int empresa, string modulo)
    {
        string[] iParametros = new string[] { "@producto", "@empresa", "@modulo" };
        object[] objValores = new object[] { producto, empresa, modulo };

        return AccesoDatos.DataSetParametros("SpSeleccionaMovimientosProduccion",
            iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionapTransaccionDetalle(int empresa, string tipo, string numero)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@empresa" };
        object[] objValores = new object[] { tipo, numero, empresa };

        return AccesoDatos.DataSetParametros(
            "SpSeleccionapTransaccionDetalle",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionalTransaccionDetalle(int empresa, string tipo, string numero)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@empresa" };
        object[] objValores = new object[] { tipo, numero, empresa };

        return AccesoDatos.DataSetParametros(
            "SpSeleccionalTransaccionDetalle",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaNovedadTipoDocumentos(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo" };
        object[] objValores = new object[] { empresa, tipo };

        if (AccesoDatos.DataSetParametros(
             "spSeleccionaNovedadesxTipo",
             iParametros,
             objValores,
             "ppa").Tables.Count > 0)
        {

            return AccesoDatos.DataSetParametros(
                "spSeleccionaNovedadesxTipo",
                iParametros,
                objValores,
                "ppa").Tables[0].DefaultView;

        }
        else return null;
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
	
	
    public DataView SeleccionalTransaccionDetalleG(int empresa, string tipo, string numero)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@empresa" };
        object[] objValores = new object[] { tipo, numero, empresa };

        return AccesoDatos.DataSetParametros(
            "SpSeleccionalTransaccionDetalleG",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionalTransaccionDetalleD(int empresa, string tipo, string numero, string equipo, string grupo)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@empresa","@equipo","@grupo" };
        object[] objValores = new object[] { tipo, numero, empresa, equipo, grupo };

        return AccesoDatos.DataSetParametros(
            "SpSeleccionalTransaccionDetalleD",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaFormulacion(int empresa, string tipo, string formulacion)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" ,"@formulacion"};
        object[] objValores = new object[] { tipo, empresa, formulacion };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaFormulacion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaFormulacionDetalle(int empresa, string tipo, string modulo, string formulacion)
    {
        string[] iParametros = new string[] { "@empresa", "@tipo", "@modulo" ,"@formulacion"};
        object[] objValores = new object[] { empresa, tipo, modulo, formulacion };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaFormulacionDetalle",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }



    public int ValidaRegistroTipoTransaccionFecha(int producto, DateTime fecha, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@fecha", "@empresa" };
        string[] oParametros = new string[] { "@Retorno" };
        object[] objValores = new object[] { producto, fecha, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spValidaRegistroTipoTransaccionFecha",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
	
	
	
}