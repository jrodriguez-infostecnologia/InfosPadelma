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


    public DataSet ModulosActivos()
    {
        return Cacceso.DataSet("spSeleccionaModulosActivos", "ppa");
    }

    public DataSet PerfilesActivos()
    {
        return Cacceso.DataSet("spSeleccionaPerfiilesActivos", "ppa");
    }

    public DataSet UsuariosActivos()
    {
        return Cacceso.DataSet("spSeleccionaUsuariosActivos", "ppa");
    }

    public DataSet OperecionesActivos()
    {
        return Cacceso.DataSet("spSeleccionaOperacionActivos", "ppa");
    }

    public DataSet SeleccionaMenuModulo(string modulo)
    {
        string[] iParametros = new string[] { "@modulo" };
        object[] objValores = new object[] { modulo };

        return Cacceso.DataSetParametros(
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

        return Convert.ToInt16(Cacceso.ExecProc(
            "spValidaMenuModulos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


}