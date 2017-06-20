using System;
using System.Collections.Generic;
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



    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = CentidadMetodos.EntidadGet(
            "bVehiculo",
            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";

        return dvEntidad;
    }

    public DataView GetVehiculosEnPlanta(string estado, int empresa)
    {
        string[] iParametros = new string[] { "@estado", "@empresa" };
        object[] objValores = new object[] { estado, empresa };

        return Cacceso.DataSetParametros(
            "spSeleccionaPorteriaEstado",
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
            Cacceso.ExecProc(
            "spActualizaEstadoFechaSalidaVehiculos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

}