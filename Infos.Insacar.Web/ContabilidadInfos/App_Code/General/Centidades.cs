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
/// Summary description for Centidades
/// </summary>
public class Centidades
{
    ADInfos.AccesoDatos AccesoDatos = new ADInfos.AccesoDatos();

	public Centidades()
	{
		//
		// TODO: Add constructor logic here
		//
	}

    public DataView GetCamposEntidades(string id1, string id2)
    {
        string[] iParametros = new string[] { "@id1", "@id2" };
        object[] objValores = new object[] { id1, id2 };

        return AccesoDatos.DataSetParametros(
            "spSeleccionaCamposEntidadesII",
            iParametros,
            objValores,
            "ppa").Tables[0].DefaultView;
    }
}
