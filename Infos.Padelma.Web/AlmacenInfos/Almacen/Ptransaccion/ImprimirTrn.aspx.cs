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

public partial class Administracion_Caracterizacion : System.Web.UI.Page
{
    #region Atributos

    ReportParameter rpNumero;

    #endregion Atributos

    #region Instancias

    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();

    #endregion Instancias

    #region Metodos

    private object TipoTransaccionConfig(int posicion)
    {
        object retorno = null;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            retorno = CcontrolesUsuario.TipoTransaccionConfig(
                        this.ddlTipoTransaccion.SelectedValue.Trim()).Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {            
            this.lblMensaje.Text = "Error al recuperar posición de configuración de tipo de transacción. Correspondiente a: " + ex.Message;
            return null;
        }
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlTipoTransaccion.DataSource = tipoTransaccion.GetTipoTransaccionModuloImpresion(System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString());
            this.ddlTipoTransaccion.DataValueField = "codigo";
            this.ddlTipoTransaccion.DataTextField = "descripcion";
            this.ddlTipoTransaccion.DataBind();
            this.ddlTipoTransaccion.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar tipos de transacción. Correspondiente a: " + ex.Message;
        }
    }

 
    private void SetParametrosReportes()
    {
        rpNumero = new ReportParameter("numero", this.txtNumero.Text.Trim());
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

    protected void imbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        this.lblMensaje.Text = "";

        if (this.ddlTipoTransaccion.SelectedValue.Trim().Length == 0 || this.txtNumero.Text.Trim().Length == 0)
        {
            this.lblMensaje.Text = "Debe seleccionar un tipo de transacción y un número de transacción para realizar la consulta";
            return;
        }

        SetParametrosReportes();

        Uri url = new Uri(System.Configuration.ConfigurationSettings.AppSettings["ReportService"].ToString());

        switch (this.ddlTipoTransaccion.SelectedValue)
        {
            case "OCO":

                this.rvTransaccion.Visible = true;
                this.rvTransaccion.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                this.rvTransaccion.ServerReport.ReportServerUrl = url;

                if (this.rblFormato.SelectedValue == "02")
                {
                    this.rvTransaccion.ServerReport.ReportPath = System.Configuration.ConfigurationSettings.AppSettings["UrlFormato"].ToString() + "ordenCompra";
                }
                else
                {
                    this.rvTransaccion.ServerReport.ReportPath = System.Configuration.ConfigurationSettings.AppSettings["UrlFormato"].ToString() + "OrdenComB";
                }

                this.rvTransaccion.ServerReport.SetParameters(new ReportParameter[] { rpNumero });
                this.rvTransaccion.ServerReport.Refresh();
                break;

            default:

                this.rvTransaccion.Visible = true;
                this.rvTransaccion.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                this.rvTransaccion.ServerReport.ReportServerUrl = url;
                this.rvTransaccion.ServerReport.ReportPath = System.Configuration.ConfigurationSettings.AppSettings["UrlFormato"].ToString() + Convert.ToString(TipoTransaccionConfig(7)).Trim();
                this.rvTransaccion.ServerReport.SetParameters(new ReportParameter[] { rpNumero });
                this.rvTransaccion.ServerReport.Refresh();
                break;
        }    
    }

    protected void ddlTipoTransaccion_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.ddlTipoTransaccion.SelectedValue == "OCO")
        {
            this.rblFormato.Visible = true;
        }
        else
        {
            this.rblFormato.Visible = false;
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

}
