﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CtipoDocuemnto
/// </summary>
public class CtipoDocuemnto
{
    public CtipoDocuemnto()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = CentidadMetodos.EntidadGet("gTipoDocumento", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";
        return dvEntidad;
    }

}