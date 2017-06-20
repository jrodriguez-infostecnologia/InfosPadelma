using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cformulacion
/// </summary>
public class Cformulacion
{
	public Cformulacion()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();


    public int consecutivoTransaccionFormulacion(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] {  empresa };

        return Convert.ToInt32(AccesoDatos.ExecProc(
            "spconsecutivoTransaccionFormulacion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    
    }

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "lformulacion",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public int verificaItemFormulacion(string codigo, int item , int empresa)
    {
        string[] iParametros = new string[] { "@codigo","@item", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { codigo, item, empresa };

        return Convert.ToInt32(AccesoDatos.ExecProc(
            "spVerificaItemFormulacion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public DataView formulacionTipoTransaccion(string tipoTra, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTra", "@empresa" };
        object[] objValores = new object[] { tipoTra, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaFormulacionTipoTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


}