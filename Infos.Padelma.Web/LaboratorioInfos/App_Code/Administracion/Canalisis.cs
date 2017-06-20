using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Canalisis
/// </summary>
public class Canalisis
{
    public Canalisis()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "lAnalisis",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView BuscarEntidadItems(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(            "lAnalisisItem",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and ( descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView BuscarEntidadItem(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = AccesoDatos.EntidadGet("iItemsBodega", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and ( descripcion like '%" + texto + "%')";
        return dvEntidad;
    }

    public DataView GetAnalisisSinImpresion(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaRemisionSinImprimir",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

    }

    public int VerificaBodegaItems(int item, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@item" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, item };

        return Convert.ToInt16(AccesoDatos.ExecProc("spVerificaBodegaItems", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }

    public int VerificaItemBodega(int item, int empresa, string bodega)
    {
        string[] iParametros = new string[] { "@empresa", "@item", "@bodega" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, item, bodega };

        return Convert.ToInt16(AccesoDatos.ExecProc("spVerificaItemBodega", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }

    public int EliminaAnalisis(int item, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@item" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, item };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpEliminalAnalisisItem",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetAnalisisProducto(string producto, int empresa, string modulo)
    {
        string[] iParametros = new string[] { "@producto", "@empresa", "@modulo" };
        object[] objValores = new object[] { producto, empresa, modulo };

        return AccesoDatos.DataSetParametros(
            "SpSeleccionaMovimientosProduccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int VerificaRemisionComercializadoraImpre(string numero, string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "@tipoTran", "empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { numero, tipoTransaccion, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaRemisionComercializadoraImpre",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int VerificaAnalisisSellos(int item, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@item" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, item };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaAnalisisSellos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ValidaSellos(string sello, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@sello" };
        string[] oParametros = new string[] { "@retorno"};
        object[] objValores = new object[] { empresa, sello };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpValidaSellos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
   
    public DataView GetAnalisisRemision(string remision, int empresa)
    {
        string[] iParametros = new string[] { "@remision", "@empresa",  };
        object[] objValores = new object[] { remision, empresa};

        return AccesoDatos.DataSetParametros(
            "SpSeleccionaAnalisisRemision",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetSellosRemision(string remision, int empresa)
    {
        string[] iParametros = new string[] { "@remision", "@empresa", };
        object[] objValores = new object[] { remision, empresa };

        return AccesoDatos.DataSetParametros(
            "SpSeleccionaSellosRemision",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}