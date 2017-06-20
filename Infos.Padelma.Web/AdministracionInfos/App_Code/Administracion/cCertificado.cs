﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de cCertificado
/// </summary>
public class cCertificado
{

    public cCertificado()
    {
    }

    public DataView BuscarEntidad(string texto, string entidad, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = CentidadMetodos.EntidadGet(entidad, "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and codigo like '%" + texto + "%'";
        return dvEntidad;
    }

    public int VerificaCertificado(int empresa, string codigo, string certificado)
    {
        string[] iParametros = new string[] { "@empresa", "@codigo", "@certificado" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { empresa, codigo, certificado };
        return Convert.ToInt16(Cacceso.ExecProc("spVerificaCertificado", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }
}