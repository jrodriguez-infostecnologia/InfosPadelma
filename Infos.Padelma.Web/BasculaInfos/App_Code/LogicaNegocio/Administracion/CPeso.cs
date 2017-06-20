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
/// Summary description for Peso
/// </summary>
public class CPeso
{
	public CPeso()
	{
		//
		// TODO: Add constructor logic here	
        //
	}

    public double CalculaPesoNeto(double pesoTara, double pesoBruto)
    {
        double pesoNeto = 0;

        if (pesoBruto < pesoTara)
        {
            pesoNeto = 0;
        }
        else
        {
            pesoNeto = pesoBruto - pesoTara;
        }

        return pesoNeto;
    }

}
