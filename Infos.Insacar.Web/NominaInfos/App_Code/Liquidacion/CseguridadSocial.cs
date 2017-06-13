using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CseguridadSocial
/// </summary>
public class CseguridadSocial
{
    public CseguridadSocial()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    


    public DataView BuscarEntidad(int empresa, int año, int mes, string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet("nSeguridadSocial", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and año =" + Convert.ToString(año) + " and mes =" + Convert.ToString(mes) +
            " and ( NombreEmpleado  like '%" + texto + "%' or Identificacion  like '%" + texto + "%' )";

        return dvEntidad;
    }


    public DataView LiquidaSeguridadSocial(int empresa,  int año,int mes)
    {
        string[] iParametros = new string[] { "@año", "@mes", "@empresa" };
        object[] objValores = new object[] { año, mes, empresa };

        return Cacceso.DataSetParametros("spLiquidarSeguridadSocialPeriodo", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }


}