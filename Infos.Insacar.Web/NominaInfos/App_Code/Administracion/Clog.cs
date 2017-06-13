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
public class Clog
{
    public Clog()
	{
		//
		// TODO: Add constructor logic here
		//
	}


    public DataView RetornaEncabezadoSNominaLog(int empresa, DateTime fechaInicial, DateTime fechaFinal)
    {
        string[] iParametros = new string[] { "@empresa", "@fechaInicial", "@fechaFinal" };
        object[] objValores = new object[] {  empresa, fechaInicial, fechaFinal };

        return Cacceso.DataSetParametros(
            "spRetornaEncabezadoSNominaLog",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }

    public DataView RetornaDetalleSNominaLog(int empresa, int id)
    {
        string[] iParametros = new string[] { "@empresa", "@id"};
        object[] objValores = new object[] { empresa, id };

        return Cacceso.DataSetParametros(
            "spRetornaDetalleSNominaLog",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
}
