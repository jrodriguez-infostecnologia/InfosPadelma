using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Descripción breve de Cvehiculos
/// </summary>
public class Cvehiculos
{
	public Cvehiculos()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView GetProductoTransaccion(string transaccion, int empresa)
    {
        string[] iParametros = new string[] { "@transaccion", "@empresa" };
        object[] objValores = new object[] { transaccion, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaProductoTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public int VerificaRemision(string remision, int producto, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@producto","@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { remision, producto ,empresa};

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spVerificaRemisionTarima",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView RetornaDatosVehiculoRemision(string remision, int empresa)
    {
        string[] iParametros = new string[] { "@remision", "@empresa" };
        object[] objValores = new object[] { remision , empresa};

        return AccesoDatos.DataSetParametros(
            "spRetornaVehiculoRemision",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetBasculaRemision(string remision, int empresa )
    {
        string[] iParametros = new string[] { "@codigo","@empresa" };
        object[] objValores = new object[] { remision ,empresa};

        return AccesoDatos.DataSetParametros(
            "spSeleccionaBasculaRemision",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView SeleccionaBodegaTipo(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@tipo","@empresa" };
        object[] objValores = new object[] { tipo, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaBodegaTipoTransaccion",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public void CalculaVariedad(int total, int dura, int tenera, out decimal pDura, out decimal pTenera)
    {
        pTenera = Math.Round((Convert.ToDecimal(tenera) * 100) / Convert.ToDecimal(total), 2);
        pDura = Math.Round((100 - Convert.ToDecimal(pTenera)), 2);
    }

    public void CalculaCastigo(int total, int verdes, int maduros, int sobreMaduros, int podridos, out decimal pVerdes, out decimal pMaduros,
        out decimal pSobreMaduros, out decimal pPodridos)
    {
        pVerdes = Math.Round((Convert.ToDecimal(verdes) * 100) / Convert.ToDecimal(total), 2);
        pMaduros = Math.Round((Convert.ToDecimal(maduros) * 100) / Convert.ToDecimal(total), 2);
        pSobreMaduros = Math.Round((Convert.ToDecimal(sobreMaduros) * 100) / Convert.ToDecimal(total), 2);
        pPodridos = Math.Round((Convert.ToDecimal(podridos) * 100) / Convert.ToDecimal(total), 2);
    }

    public void CalculaPedunculoEnfermos(int total, int pedunculo, int enfermos, out decimal pPedunculo, out decimal pEnfermos)
    {
        pPedunculo = Math.Round((Convert.ToDecimal(pedunculo) * 100) / Convert.ToDecimal(total), 2);
        pEnfermos = Math.Round((Convert.ToDecimal(enfermos) * 100) / Convert.ToDecimal(total), 2);
    }

    public int RegistroAnalisis(string tipo, string numero, string producto, string usuario, int sacos, decimal tenera, decimal dura,
        decimal verde, decimal madura, decimal sobreMadura, decimal podrida, decimal enfermos, decimal pedunculo, string bodega, int empresa,
        string cooperativa, decimal pesoSacos)
    {
        string[] iParametros = new string[] { "@tipo", "@numero", "@producto", "@usuario", "@sacos", "@pTenera", "@pDura", "@pVerde",
            "@pMadura", "@pSobreMadura", "@pPodridos", "@pEnfermos", "@pPedunculo", "@bodega", "@cooperativa", "@pesoSacos" ,"@empresa"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipo, numero, producto, usuario, sacos, tenera, dura, verde, madura, sobreMadura, podrida, enfermos, 
            pedunculo, bodega, cooperativa, pesoSacos,empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spInsertaAnalisisTarima",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}