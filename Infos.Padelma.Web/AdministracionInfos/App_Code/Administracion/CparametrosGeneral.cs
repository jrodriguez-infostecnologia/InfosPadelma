﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CparametrosGeneral
/// </summary>
public class CparametrosGeneral
{
    public CparametrosGeneral()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }


    public DataView BuscarEntidad(int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet("gParametrosGenerales", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa);

        return dvEntidad;
    }
}