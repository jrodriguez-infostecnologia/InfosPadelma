using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Citems
/// </summary>
public class Citems
{
	public Citems()
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
            "iItems",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public string Consecutivo( int empresa)
    {
        string[] iParametros = new string[] {  "@empresa" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] {  empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaConsecutivoItems",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaPapeleta(int empresa)
    {
        string[] iParametros = new string[] { "@empresa"};
        string[] oParametros = new string[] { "@papeleta" };
        object[] objValores = new object[] { empresa};

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaPapepeletaCatalogo",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView ConsultaMayorPlan( string plan, int empresa)
    {
        string[] iParametros = new string[] { "@plan","@empresa" };
        object[] objValores = new object[] { plan, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaMayoresPlanItems",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView ConsultaCriteriosItems(int item, int empresa)
    {
        string[] iParametros = new string[] { "@item", "@empresa" };
        object[] objValores = new object[] { item, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaCriteriosItem",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}