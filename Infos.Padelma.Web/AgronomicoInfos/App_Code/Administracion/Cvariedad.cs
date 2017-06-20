using System;
using System.Data;

/// <summary>
/// Summary description for Cjerarquia
/// </summary>
public class Cvariedad
{
    public Cvariedad()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "aVariedad",
            "ppa").Tables[0].DefaultView;        
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa)  + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }
   
    
}
