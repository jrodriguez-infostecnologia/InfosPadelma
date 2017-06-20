using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CcarnetDes
/// </summary>
public class CcarnetDes
{
    public CcarnetDes()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet("logCarnetDespacho", "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + empresa.ToString() + " and  codigo like '%" + texto + "%'";

        return dvEntidad;
    }
}