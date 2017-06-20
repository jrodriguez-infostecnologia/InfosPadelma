using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Ctransacciones
/// </summary>
public class Ctransacciones
{
	public Ctransacciones()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();

    public DataView GetCamposEntidades(string id1, string id2)
    {
        string[] iParametros = new string[] { "@id1", "@id2" };
        object[] objValores = new object[] { id1, id2 };

        return CentidadMetodos.DataSetParametros(
            "spSeleccionaCamposEntidadesII",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public string RetornaNumeroTransaccion(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipoTransaccion", "@empresa" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToString(CentidadMetodos.ExecProc(
            "spRetornaConsecutivoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public int ActualizaConsecutivo(string tipoTransaccion, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { tipoTransaccion, empresa };

        return Convert.ToInt16(CentidadMetodos.ExecProc(
            "spActualizaConsecutivoTransaccion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetSaldoTotalProducto(string producto, int empresa )
    {
        string[] iParametros = new string[] { "@producto" ,"@empresa"};
        object[] objValores = new object[] { producto , empresa};

        return CentidadMetodos.DataSetParametros(
            "spSaldoProductoTotal",
            iParametros,
            objValores,
            "planta").Tables[0].DefaultView;
    }


}