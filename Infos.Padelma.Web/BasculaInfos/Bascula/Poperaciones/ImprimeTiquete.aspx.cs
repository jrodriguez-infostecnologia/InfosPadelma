using System;
using System.Configuration;
using System.Web.UI;
using System.Net;
using System.Security.Principal;
using Microsoft.Reporting.WebForms;
public partial class Bascula_Poperaciones_ImprimeTiquete : System.Web.UI.Page
{

    #region Atributos

    ReportParameter rpTransaccion;
    ReportParameter rpEmpresa;

    #endregion Atributos

    #region Instancias


    #endregion Instancias

    #region Metodos

    private void SetParametros()
    {
        rpTransaccion = new ReportParameter("tiquete", Request.QueryString["tiquete"].ToString());
        rpEmpresa = new ReportParameter("empresa", Request.QueryString["empresa"].ToString());
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
            if (!IsPostBack)
            {
                System.Uri url = new Uri(ConfigurationManager.AppSettings["ReportService"].ToString());
                this.rvTiquete.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                this.rvTiquete.ServerReport.ReportServerUrl = url;
                this.rvTiquete.ServerReport.ReportPath = ConfigurationManager.AppSettings["urlFormato"].ToString() + this.Request.QueryString["tipoTiquete"].ToString();
                SetParametros();
                rvTiquete.ServerReport.SetParameters(new ReportParameter[] { rpTransaccion, rpEmpresa });
                this.rvTiquete.ServerReport.Refresh();
            }
        }
    }
    protected void lbNuevoPeso_Click(object sender, ImageClickEventArgs e)
    {
        switch (Request.QueryString["tipoTiquete"].ToString())
        {
            case "tiqueteB":

                Response.Redirect("MateriaPrima.aspx");
                break;

            case "tiqueteD":

                Response.Redirect("Despachos.aspx");
                break;

            case "tiqueteP":

                Response.Redirect("Pesajes.aspx");
                break;
        }
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

                return null;
            }
        }

        public ICredentials NetworkCredentials
        {
            get
            {
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

            return false;
        }
    }

    #endregion ClaseInterna

}