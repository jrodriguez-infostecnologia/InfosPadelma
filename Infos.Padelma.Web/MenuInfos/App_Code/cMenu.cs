﻿using System;
using System.Collections.Generic;
using System.Web;
using System.Data;
/// <summary>
/// Descripción breve de Cmenu
/// </summary>
public class cMenu
{
    public cMenu()
	{
			}

     AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();


    public int ActualizaIdSysUsuario(string id, string idSys, string idSysNew)
    {
        string[] iParametros = new string[] { "@id", "@idSys", "@idSysNew" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { id, idSys, idSysNew };

        return Convert.ToInt16(AccesoDatos.ExecProc(
            "spActualizaUsuarios",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }

    public string RetornaNombreUsuario(string id)
    {
        string[] iParametros = new string[] { "@id" };
        string[] oParametros = new string[] { "@nombre" };
        object[] objValores = new object[] { id };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spRetornaNombreUsuario",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

    public string RetornaNombreEmpresa(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { "@nombreEmpresa" };
        object[] objValores = new object[] { empresa };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spRetornaNombreEmpresa",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }

    public int RetornaCodigoEmpresaUsuario(string usuario)
    {
        string[] iParametros = new string[] { "@usuario" };
        string[] oParametros = new string[] { "@codigoEmpresa" };
        object[] objValores = new object[] { usuario };

        return Convert.ToInt16(
            AccesoDatos.ExecProc(
                "spRetornaCodigoEmpresaUsuario",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }


    public DataView SeleccionaEmpresaUsuario(string usuario)
    {
        string[] iParametros = new string[] { "@usuario" };
        object[] objValores = new object[] { usuario};

        return AccesoDatos.DataSetParametros(
            "spSeleccionEmpresaUsuarioPermisos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public DataView SeleccionaMenu(string usuario, string clave, int empresa)
    {
        string[] iParametros = new string[] { "@usuario", "@clave","@empresa" };
        object[] objValores = new object[] { usuario, clave,empresa };

        return AccesoDatos.DataSetParametros(
            "SpseleccioaSitiosInfos",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }


    public string SeleccionaFoto(string usuario)
    {
        string[] iParametros = new string[] { "@usuario" };
        string[] oParametros = new string[] { "@foto" };
        object[] objValores = new object[] { usuario };

        return Convert.ToString(
            AccesoDatos.ExecProc(
                "spretornafoto",
                iParametros,
                oParametros,
                objValores,
                "ppa").GetValue(0));
    }
}