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

    ReportParameter rpEmpresa;
    ReportParameter rpDespacho;
    ReportParameter rpUsuario;

    #endregion Atributos

    #region Instancias

    Canalisis analisis = new Canalisis();
    Cvehiculos vehiculos = new Cvehiculos();

    #endregion Instancias

    #region Metodos

    private void SetParametros()
    {
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
        this.imbImprimir.Visible = true;
        this.txtRemision.Text = Convert.ToString(this.ddlRemision.SelectedValue);

    }

    protected void imbImprimir_Click(object sender, ImageClickEventArgs e)
    {

        try
        {
            imprimeRemision();
            if (analisis.VerificaRemisionComercializadoraImpre(ddlRemision.Text, rblTipoImpresion.SelectedValue, (int)this.Session["empresa"]) == 1)
            {
                imbImprimirBiocosta.Visible = true;
                imbImprimir.Visible = false;
                btnAtras.Visible = false;

            }
            else
            {
                imbImprimirBiocosta.Visible = true;
                imbImprimir.Visible = false;
                btnAtras.Visible = true;
            }

            if (vehiculos.verificaOrdenSalida(ddlRemision.Text, (int)this.Session["empresa"]) ==1)
            {
                imbImprimir.Visible = false;
                imbImprimirOS.Visible = true;

                if (analisis.VerificaRemisionComercializadoraImpre(ddlRemision.Text, rblTipoImpresion.SelectedValue, (int)this.Session["empresa"]) == 1)
                {
                    imbImprimirBiocosta.Visible = true;
                    imbImprimir.Visible = false;
                    btnAtras.Visible = false;

                }
                else
                {
                    imbImprimirBiocosta.Visible = true;
                    imbImprimir.Visible = false;
                    btnAtras.Visible = true;
                }
            }

        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al insertar el despacho. Correpondiente a: " + ex.Message;
        }
    }

    private void imprimeRemision()
    {
        string tipo = "";

        if (Convert.ToString(this.rblTipoImpresion.SelectedValue) == "REM")
        {
            tipo = "RemisionS";
        }
        else
        {
            tipo = "OrdenEnvio";

        }

        switch (vehiculos.InsertaDespacho(
            Convert.ToString(this.ddlRemision.SelectedValue),
            Convert.ToString(this.rblTipoImpresion.SelectedValue),
            Convert.ToInt16(Session["empresa"])))
        {
            case 1:
                this.lblMensaje.Text = "Error al insertar el despacho. Operación no realizada";
                return;
        }
        rpEmpresa = new ReportParameter("empresa", Session["empresa"].ToString());
        rpDespacho = new ReportParameter("tiquete", ddlRemision.SelectedValue);
        this.rvTiquete.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
        Uri url = new Uri(ConfigurationManager.AppSettings["reportService"].ToString());
        this.rvTiquete.ServerReport.ReportServerUrl = url;
        this.rvTiquete.ServerReport.ReportPath = ConfigurationManager.AppSettings["urlFormato"].ToString() + tipo;
        this.rvTiquete.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa, rpDespacho });
        this.rvTiquete.ServerReport.Refresh();
        this.rvTiquete.Visible = true;

    }

    private void imprimeRemisionBiocosta()
    {

        rpDespacho = new ReportParameter("tiquete", txtRemision.Text);
        rpEmpresa = new ReportParameter("empresa", this.Session["empresa"].ToString());
        this.rvTiquete.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
        Uri url = new Uri(ConfigurationManager.AppSettings["reportService"].ToString());
        this.rvTiquete.Visible = true;
        this.rvTiquete.ServerReport.ReportServerUrl = url;
        this.rvTiquete.ServerReport.ReportPath = ConfigurationManager.AppSettings["urlFormato"].ToString() + ConfigurationManager.AppSettings["FormatoBio"].ToString();
        this.rvTiquete.ServerReport.SetParameters(new ReportParameter[] {  rpEmpresa, rpDespacho });
        this.rvTiquete.ServerReport.Refresh();

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

    protected void imbImprimirBiocosta_Click(object sender, ImageClickEventArgs e)
    {
        try
        {

            imprimeRemisionBiocosta();
            imbImprimirBiocosta.Visible = true;
            btnAtras.Visible = true;

            
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al insertar el despacho. Correpondiente a: " + ex.Message;
        }
    }

    protected void imbImprimirOS_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
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