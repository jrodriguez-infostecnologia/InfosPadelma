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
                    case "NovedadDetalle":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
		    case "FormatoIR":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
		   case "Ausentismos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ContratosDestajos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "IngresoReteDetalle":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ConsolidadoVacaciones":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "liquidacionContratoInforme":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "Prestamos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "IBCTrabajador":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "liquidacionNominaTrabajador":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "Funcionarios":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "RelacionDescuentosTercero":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "RelacionNovedadesPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "VencerContratos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "Contratos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "TrabajadoresxCcosto":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "Preliquidacion":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "Conceptos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "RegistroNovedades":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "NovedadesPeriodicas":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "NovedadesTrabajadorFecha":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "liquidacionNomina":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ResumenPrenomina":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ResumenLiquidacionMes":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ResumenLiquidacion":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "DesprendibleNomina":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "PagoNominaPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ResumenDescuentos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "SeguridadSocialPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "AcumuladosTerceroPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "AcumuladosTerceroAño":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "LiquidacionHoras":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "LiquidacionHorasTotales":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "AcumuladosPrestaciones":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "Laboresnopagadasfecha":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "SeguridadSocialEntidades":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "VacacionesxPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "LiquidacionNominaInforme":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "PreLiquidacionPrimas":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "DescuentosLiquidacionNomina":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;


                    case "IBCSeguridadSocialPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "InformeSeguridadSocialNomina":
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