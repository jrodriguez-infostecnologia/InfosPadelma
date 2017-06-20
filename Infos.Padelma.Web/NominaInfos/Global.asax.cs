using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.SessionState;

namespace NominaInfos
{
    public class Global : System.Web.HttpApplication
    {
        protected void Application_Start(object sender, EventArgs e)
        {
        }

		protected void Application_BeginRequest(Object sender, EventArgs e)
	    {
	        System.Globalization.CultureInfo newCulture = (System.Globalization.CultureInfo)System.Threading.Thread.CurrentThread.CurrentCulture.Clone();
	        newCulture.DateTimeFormat.ShortDatePattern = "dd/MM/yyyy";
	        newCulture.DateTimeFormat.DateSeparator = "/";
	        newCulture.NumberFormat.CurrencyDecimalSeparator = ".";
	        newCulture.NumberFormat.CurrencyDecimalDigits = 3;        
	        System.Threading.Thread.CurrentThread.CurrentCulture = newCulture;
	    }
    }
}