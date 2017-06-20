using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Cprogramacion
/// </summary>
public class Cprogramacion
{
    public Cprogramacion()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    public DataView PeriodoAñoAbierto(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        object[] objValores = new object[] { empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaAñosAbiertos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView GetDespachosDiarios(DateTime fechai, DateTime fechaf, int empresa)
    {
        string[] iParametros = new string[] { "@fechaI", "fechaF", "@empresa" };
        object[] objValores = new object[] { fechai, fechaf, empresa };

        return AccesoDatos.DataSetParametros("spSeleccionaDespachosDiario", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    public int ActualizaDespachosPlanta(string numero, string planta, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "@planta", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { numero, planta, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaPlantaDespachos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public DataSet PeriodoMesAbierto(int año, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@empresa" };
        object[] objValores = new object[] { año, empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaMesAbiertos",
            iParametros,
            objValores,
            "ppa");
    }

    public DataView GetProgramacionCab(int año, int mes, int empresa)
    {
        DataView dvProgramacion = new DataView();
        string[] iParametros = new string[] { "@año", "@mes", "@empresa" };
        object[] objValores = new object[] { año, mes, empresa };

        dvProgramacion = AccesoDatos.DataSetParametros(
            "spSeleccionaProgramacionCargaCab",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        return dvProgramacion;
    }

    public DataView BuscarEntidad(int año, int mes, int empresa)
    {
        DataView dvEntidad = new DataView();
        string[] iParametros = new string[] { "@año", "@mes", "@empresa" };
        object[] objValores = new object[] { año, mes, empresa };

        dvEntidad = AccesoDatos.DataSetParametros(
            "spGetProgramacionPeriodo",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        return dvEntidad;
    }

    public string[] ValoresProgramacion(string programacion, int empresa)
    {
        string[] sProgramacion = new string[4];
        object[] objValores = new object[] { empresa, programacion };

        foreach (DataRow registro in AccesoDatos.EntidadGetKey(
            "logProgramacionGeneral",
            "ppa",
            objValores).Tables[0].Rows)
        {
            sProgramacion.SetValue(registro.ItemArray.GetValue(2).ToString(), 0);//año
            sProgramacion.SetValue(registro.ItemArray.GetValue(3).ToString(), 1);//mes
            sProgramacion.SetValue(registro.ItemArray.GetValue(4).ToString(), 2);//Producto
            sProgramacion.SetValue(registro.ItemArray.GetValue(6).ToString(), 3);//mercado

        }

        return sProgramacion;
    }

    public DataView GetProgramacionCargaProgramacionGrl(string programacion, string estado, int empresa)
    {
        DataView dvProgramacion = new DataView();
        string[] iParametros = new string[] { "@programacion", "@estado", "@empresa" };
        object[] objValores = new object[] { programacion, estado, empresa };

        dvProgramacion = AccesoDatos.DataSetParametros(
            "spSeleccionaProgramacionCargaProgramacionGrl",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        return dvProgramacion;
    }

    public bool ProgramacionValida(int año, int mes)
    {
        if (año == Convert.ToInt16(DateTime.Today.Year.ToString()))
        {
            if (mes == Convert.ToInt16(DateTime.Today.Month.ToString()))
            {
                return true;
            }
            else
            {
                if (DateTime.Today.Day <= 5)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
        }
        else
        {
            return false;
        }
    }

    public object[] GetPRogramacionCargaKey(int empresa, string numero, string tipo)
    {
        DataView dvProgramacion = new DataView();
        object[] objRetorno = new object[50];
        int i = 0;

        object[] objKey = new object[] { empresa, numero, tipo };

        dvProgramacion = AccesoDatos.EntidadGetKey(
            "logProgramacionVehiculo",
            "ppa",
            objKey).Tables[0].DefaultView;

        foreach (DataRowView dato in dvProgramacion)
        {
            while (i < dato.Row.ItemArray.GetLength(0))
            {
                objRetorno.SetValue(dato.Row.ItemArray.GetValue(i), i);
                i++;
            }
        }

        return objRetorno;
    }

    public string RetornaNombreConductor(string codigo, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@empresa" };
        string[] oParametros = new string[] { "@nombre" };
        object[] objValores = new object[] { codigo, empresa };

        return Convert.ToString(AccesoDatos.ExecProc(
            "spRetornaConductorRecienteProgramacion",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int VerificaProgramacionEnPlanta(string numero, int empresa)
    {
        string[] iParametros = new string[] { "@numero", "@empresa" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { numero, empresa };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "SpVerificaProgramacionEnPlanta",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

}