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
/// Summary description for Cccostos
/// </summary>
public class Cpuc
{
    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();
    public Cpuc()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public DataView BuscarEntidad(string texto, int empresa)
    {
        DataView dvEntidad = accesoDatos.EntidadGet(            "cPuc",            "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa =" + empresa + " and (codigo like '%" + texto + "%' or descripcion like '%" + texto + "%')";
        return dvEntidad;
    }

    public DataView DatosCuenta(string cuenta, int empresa)
    {
        string[] iParametros = new string[] { "@codigo", "@empresa" };
        object[] objValores = new object[] { cuenta, empresa };
        return accesoDatos.DataSetParametros("SpGetcPuckey", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    private DataSet GetPuc()
    {
        return accesoDatos.EntidadGet("cPuc", "ppa");
    }

    public DataView GetPucDestino(string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@tipo", "@empresa" };
        object[] objValores = new object[] { tipo, empresa };
        return accesoDatos.DataSetParametros("spSeleccionaPucTipo", iParametros, objValores, "ppa").Tables[0].DefaultView;
    }

    private DataView GetPuc(string codigo, int empresa)
    {
        DataView dvEntidad = new DataView();

        dvEntidad = accesoDatos.EntidadGet("cPuc", "ppa").Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa =" + empresa + " and codigo = '" + codigo + "'";
        return dvEntidad;
    }

    private DataView GetPucRaiz(string cuenta)
    {
        DataView dvPuc = new DataView();

        dvPuc = GetPuc().Tables[0].DefaultView;
        dvPuc.RowFilter = "raiz = '" + cuenta + "'";

        return dvPuc;
    }

    public int RegistraPuc(bool activo, bool auxiliar, decimal baseIR,string claseIR,  string codigo, string nombre, bool disponible, int empresa, string grupoCC, bool manejaIR, bool mCcosto,
        bool mTercero, string naturaleza, decimal nivel,string notas, string plan,string raiz,string saldoTercero,decimal tasaIR, string tipoCuenta, string tipoDisponible, string tipoIR, string tipoManejoTercero, string operacion)
    {

        if (codigo.Length == 0 | nombre.Length == 0)
            return 5;
        else
        {
            if (codigo.Length == 1)
            {
                raiz = "";
                nivel = 1;
                auxiliar = false;
            }
            else
            {
                if (codigo.Length == 2)
                {
                    foreach (DataRowView registro in GetPuc(codigo.Substring(0, 1), empresa))
                    {
                        raiz = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                        nivel = Convert.ToInt16(registro.Row.ItemArray.GetValue(5)) + 1;
                        tipoCuenta = Convert.ToString(registro.Row.ItemArray.GetValue(6));
                    }

                    if (raiz.Length == 0)
                        return 2;

                    if (auxiliar == true)
                        return 3;

                    if (GetPucRaiz(codigo).Count > 0)
                        return 4;

                    if (GetPucRaiz(codigo).Count > 0 & auxiliar == true)
                        return 4;
                }
                else
                {
                    foreach (DataRowView registro in GetPuc(codigo.Substring(0, codigo.Length - 2), empresa))
                    {
                        raiz = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                        nivel = Convert.ToInt16(registro.Row.ItemArray.GetValue(5)) + 1;
                        tipoCuenta = Convert.ToString(registro.Row.ItemArray.GetValue(6));
                    }

                    if (raiz.Length == 0)
                        return 2;

                    if (auxiliar == true)
                        return 3;

                    if (GetPucRaiz(codigo).Count > 0 & auxiliar == true)
                        return 4;
                }
            }

            if (codigo.Substring(0, 1) == "1" | codigo.Substring(0, 1) == "5" | codigo.Substring(0, 1) == "6" | codigo.Substring(0, 1) == "7" | codigo.Substring(0, 1) == "8")
                naturaleza = "D";
            else
                naturaleza = "C";

            object[] objValores = new object[] {  activo,  auxiliar,  baseIR, claseIR , codigo,  nombre,  disponible,  empresa,  grupoCC,  manejaIR,  mCcosto,
         mTercero,  naturaleza,  nivel, notas,  plan, raiz, saldoTercero, tasaIR,  tipoCuenta,  tipoDisponible,  tipoIR,  tipoManejoTercero };

            return accesoDatos.EntidadInsertUpdateDelete("cPuc", operacion, "ppa", objValores);
        }
    }

    public int VerificaCuentaEnMovimientos(string cuenta)
    {
        string[] iParametros = new string[] { "cuenta" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { cuenta };

        return Convert.ToInt16(accesoDatos.ExecProc(
            "spVerificaCuentaEnMovimientos",
            iParametros,
            oParametros,
            objValores,
            "ppa").GetValue(0));
    }
}
