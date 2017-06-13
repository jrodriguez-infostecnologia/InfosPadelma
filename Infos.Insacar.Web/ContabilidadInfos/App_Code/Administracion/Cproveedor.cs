using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cproveedor
/// </summary>
public class Cproveedor
{
    ADInfos.AccesoDatos accesodatos = new ADInfos.AccesoDatos();
    public Cproveedor()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = accesodatos.EntidadGet(
            "cxpProveedor",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + empresa + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";
        dvEntidad.Sort = "descripcion";

        return dvEntidad;
    }

    public int VerificaClaseIR(string proveedor, int tercero, int clase, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tercero", "@proveedor", "@clase" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tercero, proveedor, clase };

        return Convert.ToInt16(accesodatos.ExecProc(
            "spVerificaProveedorClaseIR",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int EliminaClaseProveedor(string proveedor, int tercero, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tercero", "@proveedor" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tercero, proveedor };

        return Convert.ToInt16(accesodatos.ExecProc(
            "SpDeleteProveedorCalseIR",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView ConceptosClase(int clase, int empresa)
    {
        string[] iParametros = new string[] { "@clase", "@empresa" };
        object[] objValores = new object[] { clase, empresa };

        return accesodatos.DataSetParametros(
            "spSeleccionaConceptosClase",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView TerceroClase(int clase, string proveedor, int tercero, int empresa)
    {
        string[] iParametros = new string[] { "@clase", "@proveedor", "@tercero", "@empresa" };
        object[] objValores = new object[] { clase, proveedor, tercero, empresa };

        return accesodatos.DataSetParametros(
            "spSeleccionaclaseProveedor",
            iParametros,
            objValores,
                    "ppa").Tables[0].DefaultView;
    }



}