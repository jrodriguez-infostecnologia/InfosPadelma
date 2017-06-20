﻿using System;
using System.Data;

/// <summary>
/// Descripción breve de Cfinca
/// </summary>
public class Cfinca
{
	public Cfinca()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "aFinca",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView SeleccionaParametrizacionLotes(string codigo, int empresa)
    {

        string[] iParametros = new string[] { "@codigo", "@empresa" };
        object[] objValores = new object[] { codigo, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaSecionFinca",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

    }


}