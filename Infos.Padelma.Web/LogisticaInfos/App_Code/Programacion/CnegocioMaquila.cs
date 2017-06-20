using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CnegocioMaquila
/// </summary>
public class CnegocioMaquila
{
    public CnegocioMaquila()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = AccesoDatos.EntidadGet("logNegocio", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  (procedencia like '%" + texto + "%' or  proveedor like '%" + texto + "%')";
        return dvEntidad;
    }

    public DataView SeleccionaAnalisisNegocio(int empresa, string numero, string proveedor)
    {
        string[] iParametros = new string[] { "@empresa", "@numero", "@proveedor" };
        object[] objValores = new object[] { empresa, numero, proveedor };
        return AccesoDatos.DataSetParametros("spSeleccionaAnalisisNegocio", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaMaquilaNegocio(int empresa, string numero, string proveedor)
    {
        string[] iParametros = new string[] { "@empresa", "@numero", "@proveedor" };
        object[] objValores = new object[] { empresa, numero, proveedor };
        return AccesoDatos.DataSetParametros("spSeleccionaMaquilaNegocio", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

}