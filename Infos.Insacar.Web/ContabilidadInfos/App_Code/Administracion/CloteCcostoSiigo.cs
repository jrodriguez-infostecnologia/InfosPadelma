using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CloteCcostoSiigo
/// </summary>
public class CloteCcostoSiigo
{
    public CloteCcostoSiigo()
    {
    }

    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = accesoDatos.EntidadGet("aLoteCcostoSigo", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa = " + Convert.ToString(empresa) + "and ( lote like '%" + texto + "%' and mccostosigo like '%" + texto + "%'"+ " or accostosigo like '%" + texto + "%')";
        return dvEntidad;
    }

}