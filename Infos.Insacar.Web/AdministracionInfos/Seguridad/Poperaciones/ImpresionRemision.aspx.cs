using Microsoft.Reporting.WebForms;
using System;
using System.Configuration;
using System.Net;
using System.Security.Principal;
using System.Web;

public partial class Seguridad_Poperaciones_ImpresionRemision : System.Web.UI.Page
{
    #region Atributos

    ReportParameter rpEstado;
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();

    #endregion Atributos

    #region Instancias

    Cremision remisiones = new Cremision();

    #endregion Instancias

    #region Metodos

    private void SetParametrosReportes()
    {
        rpEstado = new ReportParameter("estado", "I");
    }

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er",
            error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
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
            
                System.Uri url = new Uri(ConfigurationManager.AppSettings["ReportService"].ToString());

                this.rvRemision.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                this.rvRemision.ServerReport.ReportServerUrl = url;

                SetParametrosReportes();

                //this.rvRemision.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlFormatos"].ToString() + "RemisionMp";
                //this.rvRemision.ServerReport.SetParameters(new ReportParameter[] { rpEstado });
         
        }
    }

    protected void lbActivar_Click(object sender, EventArgs e)
    {
        try
        {
            switch (remisiones.CambiaEstadoRemisiones(
                "G",
                "I",
                null,Convert.ToInt16(Session["empresa"])))
            {
                case 0:

                    this.nilblMensaje.Text = "Remisiones activadas satisfactoriamente";
                    this.rvRemision.ServerReport.Refresh();
                    break;

                case 1:

                    this.nilblMensaje.Text = "Error al activar remisiones. Operación no realizada";
                    break;
            }
        }
        catch (Exception ex)
        {
            this.nilblMensaje.Text = "Error al activar remisiones. Correspondiente a: " + ex.Message;
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

            // Not using form credentials
            return false;
        }
    }

    #endregion ClaseInterna

    protected void nilblRegresar_Click(object sender, System.Web.UI.ImageClickEventArgs e)
    {
        Response.Redirect("Remisiones.aspx");
    }
}