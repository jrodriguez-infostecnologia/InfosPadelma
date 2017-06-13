using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cpermisos
/// </summary>
public class Cpermisos
{
	public Cpermisos()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataSet ModulosActivos()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaModulosActivos",
            "ppa");
    }

    public DataSet PerfilesActivos()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaPerfiilesActivos",
            "ppa");
    }

    public DataSet UsuariosActivos()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaUsuariosActivos",
            "ppa");
    }

    public DataSet OperecionesActivos()
    {
        return AccesoDatos.DataSete(
            "spSeleccionaOperacionActivos",
            "ppa");
    }

    public DataSet SeleccionaMenuModulo(string modulo)
    {
        string[] iParametros = new string[] { "@modulo" };
        object[] objValores = new object[] { modulo };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaMenuModulos",
            iParametros,
            objValores,
            "ppa");
    }



    public int ValidaModulos(string modulo)
    {
        string[] iParametros = new string[] { "@modulo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { modulo };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spValidaMenuModulos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


}