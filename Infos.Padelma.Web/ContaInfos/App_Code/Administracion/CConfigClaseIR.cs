using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CConceptoIR
/// </summary>
public class CConfigClaseIR
{
    public CConfigClaseIR()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    ADInfos.AccesoDatos ADdatos = new ADInfos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {

        DataView dvEntidad = ADdatos.EntidadGet(
            "cConfigClaseIR",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "empresa =" + empresa.ToString() + " and (descripcion like '%" + texto + "%')";

        return dvEntidad;
    }


    public DataView ValoresClasesConfig(int clase, int empresa)
    {
        string[] iParametros = new string[] { "@clase", "@empresa" };
        object[] objValores = new object[] { clase, empresa };

        return ADdatos.DataSetParametros(
            "spValoresClasesConfig",
            iParametros,
            objValores,
                    "ppa").Tables[0].DefaultView;
    }


    public int ManejaLlaveClase(int clase, int empresa)
    {
        string[] iParametros = new string[] { "@clase", "@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { clase, empresa};
        return Convert.ToInt16(ADdatos.ExecProc(
            "spManejaLlaveClase",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView ConceptosClase(int clase, int empresa)
    {
        string[] iParametros = new string[] { "@clase", "@empresa" };
        object[] objValores = new object[] { clase, empresa };

        return ADdatos.DataSetParametros(
            "spSeleccionaConceptosClase",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }



}