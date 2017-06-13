using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cgeneral
/// </summary>
public class Cgeneral
{
    public Cgeneral()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }




    static public string RetornaConsecutivoAutomatico(string tabla, string nombreCampo, int empresa)
    {
        AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

        DataView dvEntidad = new DataView();
        string[] iParametros = new string[] { "@tabla", "@campo", "@empresa" };
        object[] objValores = new object[] { tabla, nombreCampo, empresa };

        dvEntidad = AccesoDatos.DataSetParametros(
               "spRetornaConsecutivoAutomatico",
               iParametros,
               objValores,
               "ppa").Tables[0].DefaultView;

        return dvEntidad.Table.Rows[0].ItemArray[0].ToString();

    }

    static public string RetornaConsecutivoAutomaticoSinEmpresa(string tabla, string nombreCampo)
    {
        AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

        DataView dvEntidad = new DataView();
        string[] iParametros = new string[] { "@tabla", "@campo" };
        object[] objValores = new object[] { tabla, nombreCampo};

        dvEntidad = AccesoDatos.DataSetParametros(
               "spRetornaConsecutivoAutomaticoSinEmpresa",
               iParametros,
               objValores,
               "ppa").Tables[0].DefaultView;

        return dvEntidad.Table.Rows[0].ItemArray[0].ToString();

    }
}