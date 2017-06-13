using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CImpRet
/// </summary>
public class CImpRet
{
	public CImpRet()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}


    public DataView BuscarEntidad(string texto, int empresa)
    {
        ADInfos.AccesoDatos ADdatos = new ADInfos.AccesoDatos();

        DataView dvEntidad = ADdatos.EntidadGet(
            "cClaseIR",
            "ppa").Tables[0].DefaultView;
        if (texto == "") {
            texto = "0";
        }
        dvEntidad.RowFilter = "empresa =" + empresa.ToString() + "and  (descripcion like '%" + texto + "%')";

        return dvEntidad;
    }
}