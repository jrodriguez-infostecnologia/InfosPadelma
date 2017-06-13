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
/// Summary description for Clog
/// </summary>
public class Clog
{
	public Clog()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    AccesoDatos.AccesoDatos datos = new AccesoDatos.AccesoDatos();

    public DataView GetLogFechaParametro(DateTime fechaI, DateTime fechaF, string parametro, int empresa)
    {
        string[] iParametros = new string[] { "@fechaI", "@fechaF" ,"@empresa"};
        object[] objValores = new object[] { fechaI, fechaF ,empresa};

        DataView dvLog = datos.DataSetParametros(
            "spSeleccionaLogFechaParametro",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;

        dvLog.RowFilter = "usuario like '%" + parametro + 
            "%' or descripcion like '%" + parametro + 
            "%' or entidad like '%" + parametro + 
            "%' or estado like '%" + parametro + 
            "%' or mensajeSistema like '%" + parametro + "%'";

        return dvLog;
    }
}
