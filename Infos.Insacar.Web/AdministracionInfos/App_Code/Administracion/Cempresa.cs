using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cempresa
/// </summary>
public class Cempresa
{
    public Cempresa()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    AccesoDatos.AccesoDatos datos = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = datos.EntidadGet("gempresa",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "nit like '%" + texto + "%' or razonsocial like '%" + texto + "%'";

        return dvEntidad;
    }

}