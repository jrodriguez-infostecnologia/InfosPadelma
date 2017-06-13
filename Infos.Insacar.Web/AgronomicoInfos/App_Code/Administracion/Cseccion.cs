﻿using System;
using System.Data;

/// <summary>
/// Descripción breve de Cfinca
/// </summary>
public class Cseccion
{
    public Cseccion()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }



    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet("aSecciones", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView SeleccionaSesionesFinca(int empresa, string finca)
    {
        string[] iParametros = new string[] { "@empresa", "@finca" };
        object[] objValores = new object[] { empresa, finca };

        return Cacceso.DataSetParametros("spSeleccionaSesionesFinca", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

}