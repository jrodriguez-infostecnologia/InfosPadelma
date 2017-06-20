using System;
using System.Data;

/// <summary>
/// Summary description for Cjerarquia
/// </summary>
public class CunidadMedida
{
    public CunidadMedida()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "gUnidadMedida",
            "ppa").Tables[0].DefaultView;        
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa)  + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }
   
    
}
