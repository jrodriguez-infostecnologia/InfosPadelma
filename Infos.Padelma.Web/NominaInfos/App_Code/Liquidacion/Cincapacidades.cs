using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cincapacidades
/// </summary>
public class Cincapacidades
{
    public Cincapacidades()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }




    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet("nIncapacidad", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (nombreEmpleado like '%" + texto + "%' or identificacion like '%" + texto + "%' )";
        dvEntidad.Sort = "tercero, numero";


        return dvEntidad;
    }

    public string Consecutivo(int empresa, string idtercero)
    {
        string[] iParametros = new string[] { "@empresa", "@tercero" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { empresa, idtercero };

        return Convert.ToString(Cacceso.ExecProc("spConsecutivoIncapacidadTercero", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }

    public int validaRegistroIncapacidadFecha(int empresa, string idtercero, DateTime fi, DateTime ff)
    {
        string[] iParametros = new string[] { "@empresa", "@tercero", "@fi", "@ff" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, idtercero, fi, ff };

        return Convert.ToInt16(Cacceso.ExecProc("spValidaAusentismoTerceroFecha", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }

    public DataView ProrrogaIncapacidadTercero(DateTime fecha, int empresa, string tercero)
    {
        string[] iParametros = new string[] { "@fecha", "@empresa", "@tercero" };
        object[] objValores = new object[] { fecha, empresa, tercero };

        return Cacceso.DataSetParametros("spSeleccionaIncapacidadesAño", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    public object[] CalculaIncapacidad(int empresa, string tercero, decimal noDias, string tipoIncapacidad, DateTime fecha, int diaPago, int diaInicio)
    {
        string[] iParametros = new string[] { "@empresa", "@tercero", "@noDias", "@tipoIncapacidad", "@fecha", "@diaPagos", "@diainicio" };
        string[] oParametros = new string[] { "@valor", "@valorPago" };
        object[] objValores = new object[] { empresa, tercero, noDias, tipoIncapacidad, fecha, diaPago, diaInicio };
        object[] objRetono = new object[2];

        objRetono[0] = Convert.ToDecimal(Cacceso.ExecProc("spCalulaIncapacidadEmpleado", iParametros, oParametros, objValores, "ppa").GetValue(0));
        objRetono[1] = Convert.ToDecimal(Cacceso.ExecProc("spCalulaIncapacidadEmpleado", iParametros, oParametros, objValores, "ppa").GetValue(1));

        return objRetono;
    }
}