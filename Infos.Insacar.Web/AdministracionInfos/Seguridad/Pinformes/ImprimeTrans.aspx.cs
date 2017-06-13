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
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Security.Principal;

public partial class Bascula_Pinformes_ImprimeTrans : System.Web.UI.Page
{
    #region Atributos

    ReportParameter rpEmpresa;
    ReportParameter rpNumero;
    ReportParameter rpDespacho;
    Ctransacciones transacciones = new Ctransacciones();

    #endregion Atributos

    #region Instancias


    #endregion Instancias

    #region Metodos

    private void SetParametrosReportes()
    {
        rpEmpresa = new ReportParameter("empresa", Convert.ToString(this.Session["empresa"]));
        rpNumero = new ReportParameter("tiquete", this.txtNumero.Text.Trim());
        rpDespacho = new ReportParameter("despacho", this.txtNumero.Text.Trim());
    }

    private object TipoTransaccionConfig(int posicion)
    {
        object retorno = null;
        string cadena;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            cadena = transacciones.TipoTransaccionConfig(ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"])).ToString();
            retorno = cadena.Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {
            lblMensaje.Text = "Error al recuperar posición de configuración de tipo de transacción. Correspondiente a: " + ex.Message;

            return null;
        }
    }


    private void CargarCombos()
    {
        try
        {
            this.ddlTipoDocumento.DataSource = transacciones.GetTipoTransaccionModulo(Convert.ToInt16(this.Session["empresa"]));
            this.ddlTipoDocumento.DataValueField = "codigo";
            this.ddlTipoDocumento.DataTextField = "descripcion";
            this.ddlTipoDocumento.DataBind();
            this.ddlTipoDocumento.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            lblMensaje.Text = "Error al cargar tipos de transacción. Correspondiente a: " + ex.Message;
        }
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
                CargarCombos();
            }
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


    protected void imbBuscar_Click(object sender, ImageClickEventArgs e)
    {

        try
        {

            this.lblMensaje.Text = "";

            if (this.ddlTipoDocumento.SelectedValue.Trim().Length == 0 || this.txtNumero.Text.Trim().Length == 0)
            {
                this.lblMensaje.Text = "Debe seleccionar un tipo de transacción y un número de transacción para realizar la consulta";
                return;
            }

            SetParametrosReportes();

            Uri url = new Uri(ConfigurationManager.AppSettings["ReportService"].ToString());

            switch (this.ddlTipoDocumento.SelectedValue)
            {
                case "TIQ":

                    this.rvTransaccion.Visible = true;
                    this.rvTransaccion.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                    this.rvTransaccion.ServerReport.ReportServerUrl = url;

                    if (this.rblFormato.SelectedValue == "01")
                    {
                        this.rvTransaccion.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlFormatos"].ToString() + "TiqueteD";
                    }
                    if (this.rblFormato.SelectedValue == "02")
                    {
                        this.rvTransaccion.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlFormatos"].ToString() + "TiqueteB";
                    }
                    if (this.rblFormato.SelectedValue == "03")
                    {
                        this.rvTransaccion.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlFormatos"].ToString() + "TiqueteP";
                    }

                    this.rvTransaccion.ServerReport.SetParameters(new ReportParameter[] { rpNumero, rpEmpresa });
                    this.rvTransaccion.ServerReport.Refresh();
                    break;
                
                case "RINV":

                    this.rvTransaccion.Visible = true;
                    this.rvTransaccion.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                    this.rvTransaccion.ServerReport.ReportServerUrl = url;
                    this.rvTransaccion.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlFormatos"].ToString() + Convert.ToString(TipoTransaccionConfig(7)).Trim();
                    this.rvTransaccion.ServerReport.SetParameters(new ReportParameter[] { rpDespacho, rpEmpresa });
                    this.rvTransaccion.ServerReport.Refresh();
                    break;
                case "RPAD":

                    this.rvTransaccion.Visible = true;
                    this.rvTransaccion.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                    this.rvTransaccion.ServerReport.ReportServerUrl = url;
                    this.rvTransaccion.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlFormatos"].ToString() + Convert.ToString(TipoTransaccionConfig(7)).Trim();
                    this.rvTransaccion.ServerReport.SetParameters(new ReportParameter[] { rpDespacho, rpEmpresa });
                    this.rvTransaccion.ServerReport.Refresh();
                    break;

                default:

                    this.rvTransaccion.Visible = true;
                    this.rvTransaccion.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                    this.rvTransaccion.ServerReport.ReportServerUrl = url;
                    this.rvTransaccion.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlFormatos"].ToString() + Convert.ToString(TipoTransaccionConfig(7)).Trim();
                    this.rvTransaccion.ServerReport.SetParameters(new ReportParameter[] { rpNumero, rpEmpresa });
                    this.rvTransaccion.ServerReport.Refresh();
                    break;
            }
        }
        catch (Exception ex)
        {
            lblMensaje.Text = "Error al cargar informe. Correspondiente a: " + ex.Message;
        }

    }
    protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.ddlTipoDocumento.SelectedValue == "TIQ")
        {
            this.rblFormato.Visible = true;
        }
        else
        {
            this.rblFormato.Visible = false;
        }
    }
}