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
public class CservicioWeb
{
	public CservicioWeb()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    //public object[] GetVehiculosCargaEntrada(string vehiculo)
    //{
    //    object[] retorno = new object[12];
    //    string[] iParametros = new string[] { "@vehiculo" };
    //    object[] objValores = new object[] { vehiculo };

    //    foreach (DataRowView registro in Cacceso.DataSet(
    //        "spSeleccionaVehiculosCargaEntrada",
    //        iParametros,
    //        objValores,
    //        "ppa").Tables[0].DefaultView)
    //    {
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(0), 0);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(1), 1);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(2), 2);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(3), 3);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(4), 4);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(5), 5);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(6), 6);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(7), 7);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(8), 8);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(9), 9);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(10), 10);
    //        retorno.SetValue(registro.Row.ItemArray.GetValue(11), 11);
    //    }

    //    return retorno;
    //}

    //public DataView GetVehiculosCargaPlanta()
    //{
    //    string[] iParametros = new string[] { "@planta" };
    //    object[] objValores = new object[] { ConfigurationManager.AppSettings["Planta"].ToString() };

    //    return Cacceso.DataSetparametr(
    //        "spSeleccionaVehiculosCargaPlanta",
    //        iParametros,
    //        objValores,
    //        "ppa").Tables[0].DefaultView;
    //}

    //public DataView GetVehiculosEnPlanta()
    //{
    //    string[] iParametros = new string[] { "@planta" };
    //    object[] objValores = new object[] { ConfigurationManager.AppSettings["Planta"].ToString() };

    //    return Cacceso.DataSet(
    //        "spSeleccionaVehiculosEnPlanta",
    //        iParametros,
    //        objValores,
    //        "ppa").Tables[0].DefaultView;
    //}

    //public DataView GetVehiculosDesCargaPlanta()
    //{
    //    return Cacceso.DataSet(
    //        "spSeleccionaVehiculosDesCargaPlanta",
    //        "ppa").Tables[0].DefaultView;
    //}

    //public DataView GetProgramacionDespachos(string registro)
    //{
    //    Biocosta.swBiocosta biocosta = new Biocosta.swBiocosta();

    //    DataView dvEntidad = biocosta.GetProgramacionDespachos(
    //        Convert.ToString(ConfigurationManager.AppSettings["UsuarioSW"])
    //        , Convert.ToString(ConfigurationManager.AppSettings["ClaveSW"]),
    //        registro).Tables[0].DefaultView;

    //    return dvEntidad;
     
    //}

    //public int InsertaDespachos(bool ar, DateTime arFecha, int bruto, bool ep, DateTime epFecha, bool fp,
    //    DateTime fpFecha, int neto, string numero, bool pp, DateTime ppFecha, string producto, string remision,
    //        string remisionBiocosta, string sellos, bool sp, DateTime spFecha, int tara, string usuario, string clave)
    //{
    //    Biocosta.swBiocosta biocosta = new Biocosta.swBiocosta();

    //    return biocosta.InsertaDespachos(ar, arFecha, bruto, ep, epFecha, fp, fpFecha,
    //         neto, numero, pp, ppFecha, producto, remision, remisionBiocosta,
    //         sellos, sp, spFecha, tara, usuario, clave);

    //}

    //public int ActualizaFechaSalidaEstado(string vehiculo, string remolque)
    //{
    //    string[] iParametros = new string[] { "@vehiculo", "@remolque" };
    //    string[] oParametros = new string[] { "@retorno" };
    //    object[] objValores = new object[] { vehiculo,remolque };

    //    return Convert.ToInt16(
    //        Cacceso.ExecProc(
    //        "spActualizaEstadoFechaSalidaVehiculos",
    //        iParametros,
    //        oParametros,
    //        objValores,
    //        "ppa").GetValue(0));
    //}

    //public DataView GetVehiculosPropios(string codigo, string tipo)
    //{
    //    string[] iParametros = new string[] { "@codigo", "@tipo" };
    //    object[] objValores = new object[] { codigo, tipo };

    //    return Cacceso.DataSet(
    //        "spSeleccionaVehicluosPropiosTipo",
    //        iParametros,
    //        objValores,
    //        "ppa").Tables[0].DefaultView;
    //}

    //public DataView GetConductoresPropios(string codigo, int estado)
    //{
    //    string[] iParametros = new string[] { "@codigo", "@estado" };
    //    object[] objValores = new object[] { codigo, estado };

    //    return Cacceso.DataSet(
    //        "spSeleccionaConductoresPropiosEstado",
    //        iParametros,
    //        objValores,
    //        "ppa").Tables[0].DefaultView;
    //}

    //public int VerificaRemisionEstado(string codigo, string estado)
    //{
    //    string[] iParametros = new string[] { "@codigo", "@estado" };
    //    string[] oParametros = new string[] { "@retorno" };
    //    object[] objValores = new object[] { codigo, estado };

    //    return Convert.ToInt16(Cacceso.ExecProc(
    //        "spVerificaEstadoRemision",
    //        iParametros,
    //        oParametros,
    //        objValores,
    //        "ppa").GetValue(0));
    //}

    //public int VerificaVehiculoEnPlanta(string remolque, string vehiculo)
    //{
    //    string[] iParametros = new string[] { "@vehiculo", "@remolque" };
    //    string[] oParametros = new string[] { "@retorno" };
    //    object[] objValores = new object[] { vehiculo ,remolque};

    //    return Convert.ToInt16(Cacceso.ExecProc(
    //        "spVerificaVehiculoEnPlanta",
    //        iParametros,
    //        oParametros,
    //        objValores,
    //        "ppa").GetValue(0));
    //}

    //public int CambiaEstadoRemision(string codigo, string estado)
    //{
    //    string[] iParametros = new string[] { "@codigo", "@estado" };
    //    string[] oParametros = new string[] { "@retorno" };
    //    object[] objValores = new object[] { codigo, estado };

    //    return Convert.ToInt16(Cacceso.ExecProc(
    //        "spCambioEstadoRemision",
    //        iParametros,
    //        oParametros,
    //        objValores,
    //        "ppa").GetValue(0));
    //}

    //public bool RetornaVehiculoPropio(string codigo, string tipo)
    //{
    //    if (GetVehiculosPropios(
    //        codigo,
    //        tipo).Count > 0)
    //    {
    //        return true;
    //    }
    //    else
    //    {
    //        return false;
    //    }
    //}

    //public string RetornaNombreConductor(string codigo)
    //{
    //    string[] iParametros = new string[] { "@codigo" };
    //    string[] oParametros = new string[] { "@nombre" };
    //    object[] objValores = new object[] { codigo };

    //    return Convert.ToString(Cacceso.ExecProc(
    //        "spRetornaConductorRecientePorteria",
    //        iParametros,
    //        oParametros,
    //        objValores,
    //        "ppa").GetValue(0));
    //}

    //public DataView ValidaProgramacionDespachos(string vehiculo, out string registro)
    //{
    //   Biocosta.swBiocosta biocosta = new Biocosta.swBiocosta();

    //   DataView dvEntidad = biocosta.ValidaProgramacionDespachos(
    //      Convert.ToString(ConfigurationManager.AppSettings["UsuarioSW"])
    //        , Convert.ToString(ConfigurationManager.AppSettings["ClaveSW"]),
    //       vehiculo).Tables[0].DefaultView;
    //   registro = "";

    //    foreach (DataRowView dato in dvEntidad)
    //    {
    //        registro = Convert.ToString(dato.Row.ItemArray.GetValue(1));
    //    }

    //    return dvEntidad;
    //}

    //public int CambiaEstadoCarnet(string codigo, string estado)
    //{
    //    string[] iParametros = new string[] { "@codigo", "@estado" };
    //    string[] oParametros = new string[] { "@retorno" };
    //    object[] objValores = new object[] { codigo, estado };

    //    return Convert.ToInt16(Cacceso.ExecProc(
    //        "spCambioEstadoCarnetDespacho",
    //        iParametros,
    //        oParametros,
    //        objValores,
    //        "ppa").GetValue(0));
    //}

    //public string RetornaEstadoCarnet(string codigo)
    //{
    //    string[] iParametros = new string[] { "@codigo" };
    //    string[] oParametros = new string[] { "@estado" };
    //    object[] objValores = new object[] { codigo };

    //    return Convert.ToString(Cacceso.ExecProc(
    //        "spRetornaEstadoCarnet",
    //        iParametros,
    //        oParametros,
    //        objValores,
    //        "ppa").GetValue(0));
    //}
}
