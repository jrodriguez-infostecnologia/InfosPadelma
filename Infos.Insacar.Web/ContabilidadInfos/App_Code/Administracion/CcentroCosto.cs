using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CcentroCosto
/// </summary>
public class CcentroCosto
{
    public CcentroCosto()
    {
    }

    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = accesoDatos.EntidadGet("cCentrosCostoSigo", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa = " + Convert.ToString(empresa) + "and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";
        return dvEntidad;
    }

    public DataView BuscarEntidadNivel(string texto)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = accesoDatos.EntidadGet("iNivelDestino", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "descripcion like '%" + texto + "%'";
        return dvEntidad;
    }

    public DataView CentroCostoNivel(string nivel, int empresa)
    {
        string[] iParametros = new string[] { "@nivel", "@empresa" };
        object[] objValores = new object[] { nivel, empresa };
        return accesoDatos.DataSetParametros("spSeleccionaCentroCostoSiigoNivel", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

}