using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CConceptoIR
/// </summary>
public class CConceptoIR
{
	public CConceptoIR()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}


    public DataView BuscarEntidad(string texto, int empresa)
    {
        ADInfos.AccesoDatos ADdatos = new ADInfos.AccesoDatos();

        DataView dvEntidad = ADdatos.EntidadGet(
            "cConceptoIR",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa =" + empresa.ToString() + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }
}