using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cpuc
/// </summary>
public class Cpuc
{
	public Cpuc()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView GetPuc(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        object[] objValores = new object[] { tipo , empresa};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaPucTipo",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
}