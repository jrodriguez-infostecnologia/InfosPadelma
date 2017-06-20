﻿using System;
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
                    case "BalancePerdidasPeriodo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ProveedorCastigo":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesLogistica"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "TransaccionesLaboratorioporfecha":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "BasculaFecha":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ConsultaPorteria":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "ProduccionDiario":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "BasculaVehiculos":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "BasculaProcedencia":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "BasculaProducto":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;
                    case "BasculaDia":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformes"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ProgramacionesFecha":
                        this.rvImprimir.ServerReport.ReportPath = ConfigurationManager.AppSettings["UrlInformesLogistica"].ToString() + this.Request.QueryString["informe"].ToString();
                        this.rvImprimir.ServerReport.Refresh();
                        this.rvImprimir.ServerReport.ReportServerUrl = url;
                        SetParametrosReportes();
                        this.rvImprimir.ServerReport.SetParameters(new ReportParameter[] { rpEmpresa });
                        break;

                    case "ControlAnalisisVolumetrico":
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