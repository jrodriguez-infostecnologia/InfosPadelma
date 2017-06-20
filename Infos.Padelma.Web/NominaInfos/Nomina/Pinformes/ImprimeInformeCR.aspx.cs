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
using CrystalDecisions.CrystalReports.Engine;
using System.Data.SqlClient;

public partial class Bascula_Pinformes_ImprimeInforme : System.Web.UI.Page
{
    #region Atributos

    ReportParameter rpEmpresa;
    cInformesCrystal ic = new cInformesCrystal();
    ReportDocument crystalReport;
    Cperiodos periodo = new Cperiodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Ctransacciones transacciones = new Ctransacciones();

    #endregion Atributos

    #region Instancias


    #endregion Instancias

    #region Metodos
    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private void manejoDocumento()
    {
        if (ddlAño.SelectedValue.Trim().Length > 0 & ddlPeriodo.SelectedValue.Trim().Length > 0)
        {
            ddlDocumento.DataSource = transacciones.SeleccionaDocumentosNominaxPeriodo(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()));
            ddlDocumento.DataValueField = "numero";
            ddlDocumento.DataTextField = "documento";
            ddlDocumento.DataBind();
            this.ddlDocumento.Items.Insert(0, new ListItem("", ""));
        }
        else
        {
            nilblInformacion.Text = "Debe seleccionar periodo y año valido";
            ddlDocumento.DataSource = null;
            ddlDocumento.DataBind();
        }
    }

    protected void cargarPeriodos()
    {
        try
        {
            this.ddlPeriodo.DataSource = periodo.PeriodoDetalle( Convert.ToInt16(this.Session["empresa"]), Convert.ToInt16( ddlAño.SelectedValue));
            this.ddlPeriodo.DataValueField = "noPeriodo";
            this.ddlPeriodo.DataTextField = "descripcion";
            this.ddlPeriodo.DataBind();
            this.ddlPeriodo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar periodo inicial. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void cargarCombos()
    {
        try
        {
            this.ddlAño.DataSource = periodo.PeriodoAñoAbiertoNomina(Convert.ToInt16(Session["empresa"]));
            this.ddlAño.DataValueField = "año";
            this.ddlAño.DataTextField = "año";
            this.ddlAño.DataBind();
            this.ddlAño.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
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
            try
            {
                if (!IsPostBack)
                {
                    this.Session["Reporte"] = null;
                    this.crViewer.Visible = false;
                    cargarCombos();
                }
                else
                {
                    crViewer.ReportSource = this.Session["Reporte"];
                }

            }
            catch (Exception ex)
            {
                Console.Write("Error de cystal");
            }
        }
    }

    protected void niimbImprimir_Click(object sender, ImageClickEventArgs e)
    {
      //  try
      //  {
            System.Uri url = new Uri(ConfigurationManager.AppSettings["ReportService"].ToString());
            string documento = ddlDocumento.SelectedValue.Trim();
            string periodo = ddlPeriodo.SelectedValue.Trim();
            int año = Convert.ToInt16(ddlAño.SelectedValue);
            crystalReport = new ReportDocument();
            crystalReport.Load(Server.MapPath("../RptCrystal/ChequeBancolombia.rpt"));
            crystalReport.SetDataSource(ic.PagoChequeBancolombia(periodo, año, documento, Convert.ToInt16(this.Session["empresa"])).Tables[0]);
            crViewer.ReportSource = crystalReport;
            this.Session["Reporte"] = crystalReport;
            crViewer.Visible = true;
        //}
        //catch (Exception ex)
        //{
        //    ManejoError("Error al visualizar cheque debido a: " + ex.Message, "C");
      //  }
    }
    protected void ddlAño_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length > 0)
        {
            cargarPeriodos();
        }
    }

    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlDocumento.DataSource = null;
        ddlDocumento.DataBind();


        try
        {
            // liquidarInformacionPago();
            manejoDocumento();
            niimbImprimir.Visible = true;

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar el documento debido a: " + ex.Message, "C");
        }
    }

    #endregion Eventos




}