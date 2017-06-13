using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CLotes
/// </summary>
public class Clotes
{
    public Clotes()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "aLotes",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }


    public DataView PeriodoAñoAbierto(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaAñosAbiertosAgro",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaLoteDetalle(int empresa, string codigo)
    {
        string[] iParametros = new string[] { "@empresa", "@codigo" };
        object[] objValores = new object[] { empresa, codigo };

        return Cacceso.DataSetParametros(
            "spSeleccionaLoteDetalle",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaLoteCanal(int empresa, string codigo)
    {
        string[] iParametros = new string[] { "@empresa", "@codigo" };
        object[] objValores = new object[] { empresa, codigo };

        return Cacceso.DataSetParametros(
            "spSeleccionaLoteCanal",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }



    public DataSet PeriodoMesAbierto(int año, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@empresa" };
        object[] objValores = new object[] { año, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaMesAbiertosAgro",
            iParametros,
            objValores,
            "ppa");
    }

    public DataView LotesSeccionFinca(string seccion, int empresa, string finca)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "aLotes",
            "ppa").Tables[0].DefaultView;
	if (seccion.Length>0)
            dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  seccion like '%" + seccion + "%' and finca='" + finca + "'";
        else
            dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and finca='" + finca + "'";

        return dvEntidad;
    }

    public DataView LineaLote( int empresa,  string lote)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "aLotesDetalle",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + "  and lote = '" + lote + "'";

        return dvEntidad;
    }


    public string LotesConfig(string lote, int empresa)
    {
        string retorno = "";
        object[] objKey = new object[] { lote, empresa };

        foreach (DataRowView registro in CentidadMetodos.EntidadGetKey(
            "aLotes",
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


}