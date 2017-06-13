using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

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


    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDatos.EntidadGet(
            "bVehiculo",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public int ActualizaFechaSalidaEstado(string vehiculo, string remolque, int empresa, string remision)
    {
        string[] iParametros = new string[] { "@vehiculo", "@remolque", "@empresa" ,"@remision"};
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { vehiculo, remolque, empresa, remision };

        return Convert.ToInt16(AccesoDatos.ExecProc("spActualizaEstadoFechaSalidaVehiculosAdmin",
            iParametros, oParametros, objValores, "ppa").GetValue(0));
    }


    public DataView GetVehiculosEnPlanta(int empresa)
    {
        string[] iParametros = new string[] {  "@empresa" };
        object[] objValores = new object[] {  empresa };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaVehiculosEnPlantaAdmin",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

}