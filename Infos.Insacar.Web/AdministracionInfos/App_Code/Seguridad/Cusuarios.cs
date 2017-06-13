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
/// Summary description for Cestados
/// </summary>
public class Cusuarios
{
    public Cusuarios()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    AccesoDatos.AccesoDatos AccesoDato = new AccesoDatos.AccesoDatos();

    public DataView BuscarEntidad(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDato.EntidadGet(
            "sUsuarios",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "usuario like '%" + texto + "%' or descripcion like '%" + texto + "%'";

        return dvEntidad;
    }

    public DataSet Empleados()
    {
        return AccesoDato.DataSete(
            "spSeleccionaEmpleados",
            "ppa");
    }


    public DataView BuscarEntidadPerfil(string texto)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = AccesoDato.EntidadGet(
            "sUsuarioPerfiles",
            "ppa").Tables[0].DefaultView;

        dvEntidad.RowFilter = "usuario like '%" + texto + "%' or perfil like '%" + texto + "%'";

        return dvEntidad;
    }

    public int InsertaUsuario(string usuario, string descripcion, string contrasena, bool activo, DateTime fechaIngreso, string correo)
    {
        string[] iParametros = new string[] { "@id", "@nombre", "@idSys", "@activo", "@fecha", "@correo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { usuario, descripcion, contrasena, activo, fechaIngreso, correo };
        return Convert.ToInt16(AccesoDato.ExecProc("spInsertaUsuarios", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }

    public int ModificaUsuario(string usuario, string descripcion, bool activo, string correo)
    {
        string[] iParametros = new string[] { "@id", "@nombre", "@activo", "@correo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { usuario, descripcion, activo, correo };
        return Convert.ToInt16(AccesoDato.ExecProc("spModificaUsuarios", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }

    public int ActualizaIdSysUsuario(string id, string idSys, string idSysNew)
    {
        string[] iParametros = new string[] { "@id", "@idSys", "@idSysNew" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { id, idSys, idSysNew };

        return Convert.ToInt16(AccesoDato.ExecProc(
            "spActualizaUsuarios",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }


    public int ReestableceUsuario(string id, string clave)
    {
        string[] iParametros = new string[] { "@usuario", "@clave" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { id, clave };

        return Convert.ToInt16(AccesoDato.ExecProc(
            "spRestableceUsuarios",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}
