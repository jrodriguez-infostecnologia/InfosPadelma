﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de cTipoCotizante
/// </summary>
public class cTipoCotizante
{
    public cTipoCotizante()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = CentidadMetodos.EntidadGet("nTipoCotizante", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }
}