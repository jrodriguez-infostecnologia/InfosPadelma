using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cbodega
/// </summary>
public class CitemsBodega
{
    public CitemsBodega()
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
            "iItemsBodega",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  item like '%" + texto + "%'";

        return dvEntidad;
    }


    public int VerificaItemBodega(string item, string bodega, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@item", "@bodega" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, item, bodega };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaItemBodega",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    
    public int EliminaItemBodega(string item, int empresa)
    {
        string[] iParametros = new string[] { "@item", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] {  item,empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spEliminaItem",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}

