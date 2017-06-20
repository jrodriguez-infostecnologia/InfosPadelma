using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cdespachos
/// </summary>
public class Cdespachos
{
    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public Cdespachos()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }


    public DataView SeleccionaDespachosRango(DateTime fechaI, DateTime fechaF, int empresa)
    {
        string[] iParametros = new string[] { "@fechaI", "@fechaF", "@empresa" };
        object[] objValores = new object[] { fechaI, fechaF, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaDespachosRango",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaTiqueteDespacho(string tiquete, int empresa)
    {
        string[] iParametros = new string[] { "@tiquete", "@empresa" };
        object[] objValores = new object[] { tiquete, empresa };

        return AccesoDatos.DataSetParametros(
            "SpSeleccionaTiqueteDespacho",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView RetornaSellosDespacho(string numero, string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "tipo", "@empresa" };
        object[] objValores = new object[] { numero, tipo, empresa };

        return AccesoDatos.DataSetParametros(
            "spRetornaSellosDespacho",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public int ActualizarImagenSello(string tipo, string numero, string sello, int empresa, string ruta, string url)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@sello", "@empresa", "@ruta", "@url" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipo, numero, sello, empresa, ruta, url };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizarImagenSello",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }



}