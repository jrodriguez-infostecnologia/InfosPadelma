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

public partial class Bascula_Pinformes_ImprimeInforme : System.Web.UI.Page
{
    #region Atributos

    ReportParameter rpEmpresa;

    #endregion Atributos

    #region Instancias


    #endregion Instancias

    #region Metodos

    private void SetParametrosReportes()
    {
        rpEmpresa = new ReportParameter("empresa", Convert.ToString(this.Session["empresa"]));
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

                this.rvImprimir.ServerReport.ReportServerCredentials = new MyReportServerCredentials();
                this.rvImprimir.ServerReport.ReportServerUrl = url;

                SetParametrosReportes();

                switch (this.Request.QueryString["informe"].ToString())
                {

                    case "NovedadesPeriodicas":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "NovedadesTrabajadorFecha":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ResumenLiquidacion":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "DesprendibleNomina":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "PagoNominaPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "IBCSeguridadSocialPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;






                    case "DescuentosLiquidacionNomina":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "Labores":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "LaboresFechaTercero":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "LaboresFechaCentroCosto":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "PesoPromedioLote":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "LaboresFechaLote":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ListaPrecioLote":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ProduccionFrutaLote":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "LiquidacionContratista":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "LiquidacionContratistaLote":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ResumeLaboresxFecha":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ResumenContratista":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ResumeLaboresxFechaPagada":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesAgro"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "ResumenGrupoConceptoxAño":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesNomina"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "ConceptosFaltantesCont":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "ContabilizaciónNomina x Periodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "ParametrizacionContabilizacion":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "InformexConceptos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ContabilizacionNominaPeriodoTercero":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                }
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
}