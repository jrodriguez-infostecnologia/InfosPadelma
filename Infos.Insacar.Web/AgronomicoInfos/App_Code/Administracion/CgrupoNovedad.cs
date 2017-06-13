using System;
using System.Data;

/// <summary>
/// Summary description for Cjerarquia
/// </summary>
public class CgrupoNovedad
{
    public CgrupoNovedad()
    {
    }
    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = new DataView();
        dvEntidad = CentidadMetodos.EntidadGet("aGrupoNovedad", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and  descripcion like '%" + texto + "%'";
        return dvEntidad;
    }

    public string Consecutivo(int empresa)
    {
        string[] iParametros = new string[] { "@empresa" };
        string[] oParametros = new string[] { "@consecutivo" };
        object[] objValores = new object[] { empresa };
        return Convert.ToString(Cacceso.ExecProc("spConsecutivoGrupoNovedad", iParametros, oParametros, objValores, "ppa").GetValue(0));
    }


}
