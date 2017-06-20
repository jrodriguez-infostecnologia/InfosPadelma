using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Ctransaccion
/// </summary>
public class CVariables
{
    public CVariables()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    public DataView getGruposEquipo()
    {
        return Cacceso.DataSet(
            "spSeleccionaGruposEquipos",
            "ppaInd").Tables[0].DefaultView;
    }

    public DataView getEquipos(int grupo )
    {
        string[] iParametros = new string[] { "@grupo" };
        object[] objValores = new object[] { grupo };

        return Cacceso.DataSetParametros(
            "spSeleccionaEquipos",
            iParametros,
            objValores,
            "ppaInd").Tables[0].DefaultView;
    }

    public DataView getVariables(int equipo)
    {
        string[] iParametros = new string[] { "@equipo" };
        object[] objValores = new object[] { equipo };

        return Cacceso.DataSetParametros(
            "spSeleccionaVariables",
            iParametros,
            objValores,
            "ppaInd").Tables[0].DefaultView;
    }


    public DataView SeleccionaVariableProcesoEquipoLabels(int variable, DateTime fechaI, DateTime fechaF, string tipo)
    {
        string[] iParametros = new string[] { "@variable", "@fechaI", "@fechaF", "@tipo" };
        object[] objValores = new object[] { variable, fechaI, fechaF, tipo };
         
        DataView retorno = Cacceso.DataSetParametros(
            "spSeleccionaVariableProcesoEquipoLabels",
            iParametros,
            objValores,
            "ppaInd").Tables[0].DefaultView;

        return retorno;
    }


    public DataView SeleccionaVariableProcesoEquipo(int variable, DateTime fechaI, DateTime fechaF, string tipo)
    {
        string[] iParametros = new string[] { "@variable", "@fechaI", "@fechaF", "@tipo" };
        object[] objValores = new object[] { variable, fechaI, fechaF, tipo };

        return Cacceso.DataSetParametros(
            "spSeleccionaVariableProcesoEquipo",
            iParametros,
            objValores,
            "ppaInd").Tables[0].DefaultView;
    }



}