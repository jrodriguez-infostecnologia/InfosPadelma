using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cproductos
/// </summary>
public class Cproductos
{
	public Cproductos()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "lProducto",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "codigo like '%" + texto + "%' or descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView BuscarEntidadAnalisis(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "lAnalisisProducto",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "producto like '%" + texto + "%' or analisis like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView BuscarEntidadTanques(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "lTanques",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "codigo like '%" + texto + "%' or producto like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView GetTanquesProducto(string producto, int empresa)
    {
        string[] iParametros = new string[] { "@producto" ,"@empresa"};
        object[] objValores = new object[] { producto , empresa};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaTanquesProducto",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetTransaccionProducto(string producto)
    {
        string[] iParametros = new string[] { "@producto" };
        object[] objValores = new object[] { producto };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaTransaccionProducto",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetAnalisisConjunto()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaAnalisisConjunto",
            "ppa").Tables[0].DefaultView;
    }


}