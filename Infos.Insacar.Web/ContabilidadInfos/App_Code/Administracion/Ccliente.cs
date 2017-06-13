using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cproveedor
/// </summary>
public class Ccliente
{
    ADInfos.AccesoDatos accesodatos = new ADInfos.AccesoDatos();
    public Ccliente()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = accesodatos.EntidadGet(
            "cxcCliente",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa=" + empresa.ToString() + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";
        dvEntidad.Sort = "descripcion";

        return dvEntidad;
    }

    public int EliminaClaseCliente(string cliente, int tercero, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tercero", "@cliente" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, tercero, cliente };

        return Convert.ToInt16(accesodatos.ExecProc(
            "SpDeleteClienteClaseIR",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int VerificaClaseIR(string cliente, int tercero,int clase, int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@tercero","@cliente", "@clase" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa,tercero ,cliente, clase };

        return Convert.ToInt16(accesodatos.ExecProc(
            "spVerificaClienteClaseIR",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView ConceptosClase(int clase, int empresa)
    {
        string[] iParametros = new string[] { "@clase", "@empresa" };
        object[] objValores = new object[] { clase, empresa };

        return accesodatos.DataSetParametros(
            "spSeleccionaConceptosClase",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView TerceroClase(int clase,string cliente, int tercero, int empresa)
    {
        string[] iParametros = new string[] { "@clase","@cliente", "@tercero","@empresa" };
        object[] objValores = new object[] { clase, cliente, tercero, empresa };

        return accesodatos.DataSetParametros(
            "spSeleccionaclaseCliente",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

   
}