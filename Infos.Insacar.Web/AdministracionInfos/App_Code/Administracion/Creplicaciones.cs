using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de transacciones
/// </summary>
public class Creplicaciones
{
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();

    public Creplicaciones()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public DataView BuscarEntidadCampo(string texto)
    {
        DataView dvTipoTransaccion = CentidadMetodos.EntidadGet(
            "sReplicacion",
            "ppa").Tables[0].DefaultView;

        dvTipoTransaccion.RowFilter = "tabla like '%" + texto + "%'";
        return dvTipoTransaccion;
    }


    public string[] NoRegistros(string empresaA, string tabla)
    {
        string[] noRegistros = new string[1];
        string[] iParametros = new string[] { "@empresaA", "@tabla" };
        object[] objValores = new object[] { empresaA, tabla };

        foreach (DataRowView registro in CentidadMetodos.DataSetParametros(
            "spNoRegistrosTablaReplicar", iParametros, objValores,
            "ppa").Tables[0].DefaultView)
        {
            noRegistros.SetValue(Convert.ToString(registro.Row.ItemArray.GetValue(0)), 0);

        }

        return noRegistros;
    }


    public int AgregarRegistro(string empresaA, string empresaB, string tabla)
    {
        string[] iParametros = new string[] { "@empresaA", "@empresaB", "@tabla" };
        string[] oParametros = new string[] { "@Retorno" };
        object[] objValores = new object[] { empresaA, empresaB, tabla };

        return Convert.ToInt16(
            CentidadMetodos.ExecProc(
                "spInsertaTablaReplicar",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }



}