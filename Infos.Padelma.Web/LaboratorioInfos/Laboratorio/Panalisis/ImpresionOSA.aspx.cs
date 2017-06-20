using Microsoft.Reporting.WebForms;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Net;
using System.Security.Principal;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Laboratorio_Panalisis_ImprimeRemision : System.Web.UI.Page
{

    #region Atributos

    ReportParameter rpTransaccion;
    ReportParameter rpEmpresa;
    ReportParameter rpDespacho;
    ReportParameter rpUsuario;
    ReportParameter rpMotivo;

    #endregion Atributos

    #region Instancias

    Canalisis analisis = new Canalisis();
    Cvehiculos vehiculos = new Cvehiculos();

    #endregion Instancias

    #region Metodos

    private void SetParametros()
    {
        rpTransaccion = new ReportParameter("despacho", Request.QueryString["despacho"].ToString());
        rpEmpresa = new ReportParameter("empresa", Request.QueryString["empresa"].ToString());
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlRemision.DataSource = analisis.GetAnalisisSinImpresion(Convert.ToInt16(Session["empresa"]));
            this.ddlRemision.DataValueField = "numero";
            this.ddlRemision.DataTextField = "cadena";
            this.ddlRemision.DataBind();
            this.ddlRemision.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.ForeColor = System.Drawing.Color.Red;
            this.lblMensaje.Text = "Error al seleccionar vehículos para impresión. Correspondiente a: " + ex.Message;
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

    protected void ddlRemision_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.txtRemision.Text = Convert.ToString(this.ddlRemision.SelectedValue);

    }




    private void imprimeOrdenSalida()
    {
        rpDespacho = new ReportParameter("despacho", txtRemision.Text);
        rpEmpresa = new ReportParameter("empresa", this.Session["empresa"].ToString());
        rpUsuario = new ReportParameter("usuario", this.Session["usuario"].ToString());
        this.rvTiquete.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
        Uri url = new Uri(ConfigurationManager.AppSettings["reportService"].ToString());
        this.rvTiquete.Visible = true;
        this.rvTiquete.ServerReport.ReportServerUrl = url;
        this.rvTiquete.ServerReport.ReportPath = ConfigurationManager.AppSettings["urlFormato"].ToString() + ConfigurationManager.AppSettings["FormatoOS"].ToString();
        this.rvTiquete.ServerReport.SetParameters(new ReportParameter[] { rpDespacho, rpEmpresa, rpUsuario });
        this.rvTiquete.ServerReport.Refresh();

    }


    protected void imbImprimirOS_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            switch (vehiculos.ActualizaOS(
          Convert.ToString(this.ddlRemision.SelectedValue),
          Convert.ToInt16(Session["empresa"]),
            txtMotivo.Text))
            {
                case 1:
                    this.lblMensaje.Text = "Error al insertar el despacho. Operación no realizada";
                    return;
            }

            imprimeOrdenSalida();
            imbImprimirOS.Visible = false;
            btnAtras.Visible = true;

        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al insertar el despacho. Correpondiente a: " + ex.Message;
        }
    }

    protected void tbnAtras_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("ImpresionRemision.aspx");
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