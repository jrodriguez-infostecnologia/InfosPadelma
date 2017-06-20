using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Security.Principal;
using System.Net;
using Microsoft.Reporting.WebForms;

public partial class Administracion_Caracterizacion : System.Web.UI.Page
{
    #region Atributos

    ReportParameter rpTransaccion;

    #endregion Atributos

    #region Instancias


    #endregion Instancias

    #region Metodos

    private void SetParametros()
    {
        rpTransaccion = new ReportParameter("numero", Request.QueryString["numero"].ToString());
    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            SetParametros();

            this.rvTransaccion.ServerReport.ReportServerCredentials = new MyReportServerCredentials();

            Uri url = new Uri(System.Configuration.ConfigurationSettings.AppSettings["reportService"].ToString());

            this.rvTransaccion.Visible = true;
            this.rvTransaccion.ServerReport.ReportServerUrl = url;
            this.rvTransaccion.ServerReport.ReportPath = System.Configuration.ConfigurationSettings.AppSettings["urlFormato"].ToString() +
                this.Request.QueryString["tipoTransaccion"].ToString();
            this.rvTransaccion.ServerReport.SetParameters(new ReportParameter[] { rpTransaccion });
            this.rvTransaccion.ServerReport.Refresh();
        }
    }

    protected void lbNuevoPeso_Click(object sender, EventArgs e)
    {
        Response.Redirect("Transacciones.aspx");
    }

    #endregion Eventos       

    #region ClaseInterna

    [Serializable]
    public sealed class MyReportServerCredentials :
        IReportServerCredentials
    {
        public WindowsIdentity ImpersonationUser
        {
            get
            {
                // Use the default Windows user.  Credentials will be
                // provided by the NetworkCredentials property.
                return null;
            }
        }

        public ICredentials NetworkCredentials
        {
            get
            {
                // Read the user information from the Web.config file.  
                // By reading the information on demand instead of 
                // storing it, the credentials will not be stored in 
                // session, reducing the vulnerable surface area to the
                // Web.config file, which can be secured with an ACL.

                // User name
                string userName =
                    ConfigurationManager.AppSettings["Usuario"].ToString();

                if (string.IsNullOrEmpty(userName))
                    throw new Exception(
                        "Missing user name from web.config file");

                // Password
                string password =
                    ConfigurationManager.AppSettings["Clave"].ToString();

                if (string.IsNullOrEmpty(password))
                    throw new Exception(
                        "Missing password from web.config file");

                // Domain
                string domain =
                    ConfigurationManager.AppSettings["Dominio"].ToString();

                if (string.IsNullOrEmpty(domain))
                    throw new Exception(
                        "Missing domain from web.config file");

                return new NetworkCredential(userName, password, domain);
            }
        }

        public bool GetFormsCredentials(out Cookie authCookie,
                    out string userName, out string password,
                    out string authority)
        {
            authCookie = null;
            userName = null;
            password = null;
            authority = null;

            // Not using form credentials
            return false;
        }
    }

    #endregion ClaseInterna

}
