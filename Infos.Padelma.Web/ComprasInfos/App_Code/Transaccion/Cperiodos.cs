using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cperiodos
/// </summary>
public class Cperiodos
{
	public Cperiodos()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos Cacceso = new AccesoDatos.AccesoDatos();


    public int RetornaPeriodoCerrado(int año, int mes, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@mes", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { año, mes, empresa };

        return Convert.ToInt16(Cacceso.ExecProc(
            "spRetornaPeriodoCerrado",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}