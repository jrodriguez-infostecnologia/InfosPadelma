using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for Vehiculos
/// </summary>
public class Cvehiculos
{
    public Cvehiculos()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();




    public object[] GetVehiculosCargaEntrada(string vehiculo, int empresa)
    {
        object[] retorno = new object[12];
        string[] iParametros = new string[] { "@vehiculo", "@empresa" };
        object[] objValores = new object[] { vehiculo, empresa };

        foreach (DataRowView registro in AccesoDatos.DataSetParametros(
            "spSeleccionaVehiculosCargaEntrada",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView)
        {
            retorno.SetValue(registro.Row.ItemArray.GetValue(0), 0);
            retorno.SetValue(registro.Row.ItemArray.GetValue(1), 1);
            retorno.SetValue(registro.Row.ItemArray.GetValue(2), 2);
            retorno.SetValue(registro.Row.ItemArray.GetValue(3), 3);
            retorno.SetValue(registro.Row.ItemArray.GetValue(4), 4);
            retorno.SetValue(registro.Row.ItemArray.GetValue(5), 5);
            retorno.SetValue(registro.Row.ItemArray.GetValue(6), 6);
            retorno.SetValue(registro.Row.ItemArray.GetValue(7), 7);
            retorno.SetValue(registro.Row.ItemArray.GetValue(8), 8);
            retorno.SetValue(registro.Row.ItemArray.GetValue(9), 9);
            retorno.SetValue(registro.Row.ItemArray.GetValue(10), 10);
            retorno.SetValue(registro.Row.ItemArray.GetValue(11), 11);
        }

        return retorno;
    }

    public DataView GetVehiculosCargaPlanta(int empresa)
    {
        string[] iParametros = new string[] { "@planta", "@empresa" };
        object[] objValores = new object[] { ConfigurationManager.AppSettings["Planta"].ToString(), empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaVehiculosCargaPlanta",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaVehiculos(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros("spSeleccionaVehiculosPropios", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaRemolques(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros("spSeleccionaRemolquesPropios", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaConductores(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros("spSeleccionaConductores", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }


    public DataView GetVehiculosEnPlanta(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaVehiculosEnPlanta",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetVehiculosDesCargaPlanta(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaVehiculosDesCargaPlanta",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetVehiculosDesCargaPlantaDespachos(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaVehiculosDesCargaPlantaDeapachos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public int ActualizaFechaSalidaEstado(string vehiculo, string remolque, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo", "@remolque", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { vehiculo, remolque, empresa };

        return Convert.ToInt16(
            AccesoDatos.ExecProc(
            "spActualizaEstadoFechaSalidaVehiculos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ActualizaEstadoProgramacion(string numero, string despacho, string tipo, string estado, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "@despacho", "@estado", "@empresa", "@tipo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { numero, despacho, estado, empresa, tipo };

        return Convert.ToInt16(
            AccesoDatos.ExecProc(
            "SpActualizaEstadoProgramacionVehiculo",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public DataView GetVehiculosPropios(string codigo, string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@tipo", "@empresa" };
        object[] objValores = new object[] { codigo, tipo, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaVehicluosPropiosTipo",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public int ValidaTercero(string tercero, int empresa)
    {
        string[] iParametros = new string[] { "@tercero", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tercero, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaTerceroProgramacion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int RetornaTerceroProgramacion(string tercero, int empresa)
    {
        string[] iParametros = new string[] { "@tercero", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tercero, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spRetornaTerceroProgramacion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int insertaClienteComer(string codigo, int empresa, string descripcion)
    {
        string[] iParametros = new string[] { "@codigo", "@empresa", "@descripcion" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { codigo,empresa, descripcion };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spInsertaClienteComer",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int insertaSucursalCliente(string tercero, int empresa, string idSucursal, string sucursal)
    {
        string[] iParametros = new string[] { "@tercero", "@empresa","@idSucursal", "@sucursal" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tercero, empresa, idSucursal, sucursal };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spInsertaSucursalCliente",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public DataView GetConductoresPropios(string codigo, int estado, int emprea)
    {
        string[] iParametros = new string[] { "@codigo", "@estado", "@empresa" };
        object[] objValores = new object[] { codigo, estado, emprea };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaConductoresPropiosEstado",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int VerificaRemisionEstado(string codigo, string estado, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@estado", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { codigo, estado, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaEstadoRemision",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int VerificaVehiculoEnPlanta(string remolque, string vehiculo, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo", "@remolque", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { vehiculo, remolque, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaVehiculoEnPlanta",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int CambiaEstadoRemision(string codigo, string estado, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@estado", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { codigo, estado, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spCambioEstadoRemision",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public bool RetornaVehiculoPropio(string codigo, string tipo, int empresa)
    {
        if (GetVehiculosPropios(
            codigo,
            tipo, empresa).Count > 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public string RetornaNombreConductor(string codigo, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@empresa" };
        string[] oParametros = new string[] { "@nombre" };
        object[] objValores = new object[] { codigo, empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaConductorRecientePorteria",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView VerificaProgramacionPlanta(string vehiculo, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo", "@empresa" };
        object[] objValores = new object[] { vehiculo, empresa };
        DataView dvEntidad = AccesoDatos.DataSetParametros("spVerificaProgramacionPlanta", iParametros, objValores, "ppa").Tables[0].DefaultView;
        return dvEntidad;
    }


    public DataView ValidaProgramacionDespachosExtractora(string vehiculo, out string registro, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo", "@empresa" };
        object[] objValores = new object[] { vehiculo, empresa };

        registro = "";

        DataView dvEntidad = AccesoDatos.DataSetParametros(
            "spVerificaProgramacionDespachoPorteria",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        foreach (DataRowView dato in dvEntidad)
        {
            registro = Convert.ToString(dato.Row.ItemArray.GetValue(1));
        }

        return dvEntidad;
    }


    public DataView ValidaProgramacionDespachosExtractoraRemolque(string vehiculo,string remolque, out string registro, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo","@remolque" , "@empresa" };
        object[] objValores = new object[] { vehiculo, remolque,empresa };

        registro = "";

        DataView dvEntidad = AccesoDatos.DataSetParametros(
            "spVerificaProgramacionDespachoPorteriaRemolque",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        foreach (DataRowView dato in dvEntidad)
        {
            registro = Convert.ToString(dato.Row.ItemArray.GetValue(1));
        }

        return dvEntidad;
    }

    public int ValidaVehiculoEnPlanta(string vehiculo, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { vehiculo, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaProgramacionDespachoPorteriaSW",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetProgramacionDespachos(string registro, int empresa)
    {
        string[] iParametros = new string[] { "@registro", "@empresa" };
        object[] objValores = new object[] { registro, empresa };

        DataView dvEntidad = AccesoDatos.DataSetParametros(
            "spSeleccionaProgramacionDespachoPorteria",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        return dvEntidad;
    }

    public int CambiaEstadoCarnet(string codigo, string estado, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@estado", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { codigo, estado, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spCambioEstadoCarnetDespacho",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaEstadoCarnet(string codigo, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@empresa" };
        string[] oParametros = new string[] { "@estado" };
        object[] objValores = new object[] { codigo, empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaEstadoCarnet",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView ValidaProgramacionDespachos(string vehiculo, out string registro)
    {
        Biocosta.swBiocosta biocosta = new Biocosta.swBiocosta();
        DataView dvEntidad = new DataView();
        registro = "";

        if (biocosta.ValidaProgramacionDespachos(
          Convert.ToString(ConfigurationManager.AppSettings["UsuarioSW"])
            , Convert.ToString(ConfigurationManager.AppSettings["ClaveSW"]),
           vehiculo).Tables.Count > 0)
        {

            dvEntidad = biocosta.ValidaProgramacionDespachos(
               Convert.ToString(ConfigurationManager.AppSettings["UsuarioSW"])
                 , Convert.ToString(ConfigurationManager.AppSettings["ClaveSW"]),
                vehiculo).Tables[0].DefaultView;
        }


        foreach (DataRowView dato in dvEntidad)
        {
            registro = Convert.ToString(dato.Row.ItemArray.GetValue(1));
        }

        return dvEntidad;
    }


    public int RetornaItemRefProducto(string codigo, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@empresa" };
        string[] oParametros = new string[] { "@item" };
        object[] objValores = new object[] { codigo, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spRetornaItemRefProducto",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int verificaVehiculoPropio(string vehiculo, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { vehiculo, empresa };

        return Convert.ToInt16(
            AccesoDatos.ExecProc(
            "spverificaVehiculoPropio",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int verificaVehiculoPropioRemolquePlanta(string vehiculo, string remolque, int empresa)
    {
        string[] iParametros = new string[] { "@vehiculo", "remolque","@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { vehiculo, remolque,empresa };

        return Convert.ToInt16(
            AccesoDatos.ExecProc(
            "spverificaVehiculoPropioRemolquePlanta",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

}
