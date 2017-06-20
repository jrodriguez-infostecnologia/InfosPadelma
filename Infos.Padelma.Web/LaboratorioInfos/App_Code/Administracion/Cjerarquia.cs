using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cjerarquia
/// </summary>
public class Cjerarquia
{
    public Cjerarquia()
    {
    }

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        Int32 codigo = 0;

        try
        {
            codigo = Convert.ToInt32(texto);
        }
        catch
        {
        }

        dvEntidad = AccesoDatos.EntidadGet(
            "lJerarquia",
            "ppa").Tables[0].DefaultView;

        if (codigo > 0)
        {
            dvEntidad.RowFilter = "id = " + codigo + " or item = '" + codigo + "'";
        }


        return dvEntidad;
    }

    public DataView BuscarEntidadBodega(string texto)
    {
        DataView dvEntidad = new DataView();
        Int32 codigo = 0;

        try
        {
            codigo = Convert.ToInt32(texto);
        }
        catch
        {
        }

        dvEntidad = AccesoDatos.EntidadGet(
            "pJerarquiaBodega",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "jerarquia = " + Convert.ToInt16(codigo) + " or bodega like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataView BuscarEntidadCorriente(string texto)
    {
        DataView dvEntidad = new DataView();
        Int32 codigo = 0;

        try
        {
            codigo = Convert.ToInt32(texto);
        }
        catch
        {
        }

        dvEntidad = AccesoDatos.EntidadGet(
            "pJerarquiaCorriente",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "jerarquia = " + Convert.ToInt16(codigo) + " or corriente like '%" + texto + "%'";

        return dvEntidad;
    }

    public Int32 RetornaNiveljerarquia(int jerarquia, int empresa)
    {
        string[] iParametros = new string[] { "@jerarquia", "@empresa" };
        string[] oParametros = new string[] { "@nivelPadre" };
        object[] objValores = new object[] { jerarquia, empresa };

        return Convert.ToInt32(AccesoDatos.ExecProc(
            "spRetornaNivelPadrePro",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataView GetJerarquiaNivel(int nivel, int empresa)
    {
        string[] iParametros = new string[] { "@nivel", "@empresa" };
        object[] objValores = new object[] { nivel, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaJerarquiaNivelPro",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataSet GetCaracteristicasJerarquia(Int32 jerarquia)
    {
        string[] iParametros = new string[] { "@jerarquia" };
        object[] objValores = new object[] { jerarquia };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaCaracteristicaJerarquiaPro",
            iParametros,
            objValores,
            "ppa");
    }

    public bool VerificaCaracteristicasJerarquiaBorrado(Int32 jerarquia)
    {
        if (GetCaracteristicasJerarquia(jerarquia).Tables[0].Rows.Count == 0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    public DataSet GetNodosRaiz(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaNodoRaizPro",
            iParametros,
            objValores,
              "ppa"
            );
    }

    public DataSet GetNodosHijo(int codigo, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@empresa" };
        object[] objValores = new object[] { codigo, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaNodoHijoPro",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet GetVariablesJerarquia(Int32 jerarquia)
    {
        string[] iParametros = new string[] { "@jerarquia" };
        object[] objValores = new object[] { jerarquia };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaVariableJerarquiaPro",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet GetAnalisisJerarquia(int jerarquia, int empresa)
    {
        string[] iParametros = new string[] { "@jerarquia", "@empresa" };
        object[] objValores = new object[] { jerarquia, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaAnalisisJerarquiaPro",
            iParametros,
            objValores,
            "ppa");
    }


    public DataSet GetNivelJerarquia(int nivel, int empresa)
    {
        string[] iParametros = new string[] { "@nivel", "@empresa" };
        object[] objValores = new object[] { nivel, empresa };

        return AccesoDatos.DataSetParametros(
            "spGetNivelJerarquia",
            iParametros,
            objValores,
            "ppa");
    }
}

