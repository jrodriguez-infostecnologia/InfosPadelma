using System;
using System.Data;

/// <summary>
/// Summary description for Cjerarquia
/// </summary>
public class CgrupoCaracteristica
{
    public CgrupoCaracteristica()
    {
    }
    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = CentidadMetodos.EntidadGet("aGrupoCaracteristica", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";
        return dvEntidad;
    }

    public string Consecutivo(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { empresa };
        return Convert.ToString(Cacceso.ExecProc("spConsecutivoGrupoCaracteristica", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }


}
