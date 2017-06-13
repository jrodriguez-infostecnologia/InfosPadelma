using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CparametroTipoCotizante
/// </summary>
public class CparametroTipoCotizante
{
	public CparametroTipoCotizante()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "nParametrosTipoCotizante",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (tipoCotizante like '%" + texto + "%' or subTipoCotizante like '%" + texto + "%')";

        return dvEntidad;
    }

}