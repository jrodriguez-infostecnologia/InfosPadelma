using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CgrupoIR
/// </summary>
public class CgrupoIR
{
	public CgrupoIR()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = accesoDatos.EntidadGet(
            "cGrupoIR",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa =" + empresa + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView SeleccionaImpuestos(int empresa)
    {
        string[] iParametros = new string[] {  "@empresa" };
        object[] objValores = new object[] {  empresa };

        return accesoDatos.DataSetParametros(
            "spSeleccionaConceptosIRyClase",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int VerificaConceptoyGrupoIR(string grupo, string concepto , int empresa)
    {
        string[] iParametros = new string[] { "@empresa","@concepto","@grupo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa,concepto,grupo };

        return Convert.ToInt16(accesoDatos.ExecProc(
            "spVerificaConceptoyGrupoIR",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int EliminaConceptosdelGrupo(string grupo,  int empresa)
    {
        string[] iParametros = new string[] { "@empresa", "@grupo" };
        string[] oParametros = new string[] { "@Retorno" };
        object[] objValores = new object[] { empresa, grupo };

        return Convert.ToInt16(accesoDatos.ExecProc(
            "spEliminaConcesptosdelGrupo",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


}