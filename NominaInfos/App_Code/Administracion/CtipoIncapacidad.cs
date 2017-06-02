using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CtipoIncapacidad
/// </summary>
public class CtipoIncapacidad
{
    public CtipoIncapacidad()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet("nTipoIncapacidad", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";

        return dvEntidad;
    }
}