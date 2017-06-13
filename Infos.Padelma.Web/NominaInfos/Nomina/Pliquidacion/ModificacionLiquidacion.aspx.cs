using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Net;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_Liquidacion : System.Web.UI.Page
{

    public List<LiquidacionDetalle> ListadoDetalleLiquidacion
    {
        get
        {
            object o = ViewState["ListadoDetalleLiquidacion"];
            return (o == null) ? null : (List<LiquidacionDetalle>)o;
        }
        set
        {
            ViewState["ListadoDetalleLiquidacion"] = value;
        }
    }

    public List<LiquidacionDetalle> ListadoDetalleLiquidacionEliminados
    {
        get
        {
            object o = ViewState["ListadoDetalleLiquidacionEliminados"];
            return (o == null) ? null : (List<LiquidacionDetalle>)o;
        }
        set
        {
            ViewState["ListadoDetalleLiquidacionEliminados"] = value;
        }
    }


    #region Instancias

    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cperiodos periodo = new Cperiodos();
    CModificacionNomina modificacionNomina = new CModificacionNomina();
    #endregion Instancias

    #region Metodos

    private void cargarConcepto()
    {
        try
        {
            DataView dvConceptos = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvConceptos.RowFilter = "empresa = " + Convert.ToInt16(Session["empresa"]).ToString();
            this.ddlConcepto.DataSource = dvConceptos;
            this.ddlConcepto.DataValueField = "codigo";
            this.ddlConcepto.DataTextField = "descripcion";

            this.ddlConcepto.DataBind();
            this.ddlConcepto.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void cargarPeriodos()
    {
        try
        {
            this.ddlPeriodo.DataSource = periodo.PeriodosAbiertoNominaAño(Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
            this.ddlPeriodo.DataValueField = "noPeriodo";
            this.ddlPeriodo.DataTextField = "descripcion";

            this.ddlPeriodo.DataBind();
            if (this.ddlPeriodo.Items.Count == 0)
            {
                limpiarPeriodos();
                return;
            }
            this.ddlPeriodo.Items.Insert(0, new ListItem("", ""));
            this.ddlPeriodo.Enabled = true;
            limpiarTipoDeDocumento();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar periodo inicial. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private void CargarCombos()
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
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
                return;
            }
            if (!IsPostBack)
            {
                CargarCombos();
                cargarConcepto();
                InitView();
            }
            else
            {
                ListadoDetalleLiquidacion = new List<LiquidacionDetalle>();
                var i = 1;
                foreach (GridViewRow dr in gvDetalleLiquidacion.Rows)
                {
                    var item = new LiquidacionDetalle();
                    item.RegistroDetalleNomina = (i++).ToString();
                    item.CodConcepto = Server.HtmlDecode(dr.Cells[2].Text.ToString());
                    item.DescripcionConcepto = Server.HtmlDecode(dr.Cells[3].Text.ToString());
                    item.Cantidad = ((TextBox)dr.FindControl("txvCantidad")).Text.ToString();
                    item.ValorUnitario = ((TextBox)dr.FindControl("txvValorUnitario")).Text.ToString();
                    item.ValorTotal = ((TextBox)dr.FindControl("txvValorTotal")).Text.ToString();
                    ListadoDetalleLiquidacion.Add(item);
                }
            }
        }
    }

    private string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void InitView()
    {
        detailLoadedPanel.Visible = false;
        hasMadeChangesPanel.Visible = false;
        limpiarContrato();
        limpiarDetalle();
        limpiarDocumentos();
        limpiarEmpleados();
        limpiarPeriodos();
        limpiarTipoDeDocumento();
    }

    #endregion Eventos

    #region EventosFuncionario

    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlPeriodo.SelectedValue.Trim().Length > 0)
            cargarTipoDeDocumento();
        else
            limpiarTipoDeDocumento();
    }

    private void limpiarTipoDeDocumento()
    {
        ddlTipoDocumento.DataSource = null;

        ddlTipoDocumento.SelectedValue = null;
        ddlTipoDocumento.DataBind();
        ddlTipoDocumento.Enabled = false;
        limpiarDocumentos();
    }

    private void cargarTipoDeDocumento()
    {
        try
        {
            this.ddlTipoDocumento.DataSource = modificacionNomina.CargarTipoDeDocumento(Convert.ToInt32(ddlAño.SelectedValue), Convert.ToInt32(ddlPeriodo.SelectedValue), Convert.ToInt32(Session["empresa"]));
            this.ddlTipoDocumento.DataValueField = "codigo";
            this.ddlTipoDocumento.DataTextField = "tipo";
            this.ddlTipoDocumento.DataBind();
            if (this.ddlTipoDocumento.Items.Count == 0)
            {
                limpiarTipoDeDocumento();
                return;
            }
            this.ddlTipoDocumento.Items.Insert(0, new ListItem("", ""));
            this.ddlTipoDocumento.Enabled = true;
            limpiarDocumentos();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion EventosFuncionario

    protected void ddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length > 0)
            cargarPeriodos();
        else
            limpiarPeriodos();
    }

    private void limpiarPeriodos()
    {

        ddlPeriodo.DataSource = null;
        ddlPeriodo.SelectedValue = null;
        ddlPeriodo.DataBind();
        ddlPeriodo.Enabled = false;
        limpiarTipoDeDocumento();
    }

    protected void ddlEmpleado_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlEmpleado.SelectedValue.Trim().Length > 0)
            cargarContrato();
        else
            limpiarContrato();
    }

    private void limpiarContrato()
    {
        ddlContratos.DataSource = null;
        ddlContratos.SelectedValue = null;
        ddlContratos.DataBind();
        ddlContratos.Enabled = false;
        limpiarDetalle();
    }

    private void cargarContrato()
    {
        try
        {
            this.ddlContratos.DataSource = modificacionNomina.CargarContratos(
                Convert.ToInt32(ddlAño.SelectedValue),
                Convert.ToInt32(ddlPeriodo.SelectedValue),
                ddlTipoDocumento.SelectedValue,
                Convert.ToInt32(Session["empresa"]),
                ddlNumeroDocumento.SelectedValue,
                Convert.ToInt32(ddlEmpleado.SelectedValue));
            this.ddlContratos.DataValueField = "codContrato";
            this.ddlContratos.DataTextField = "descContrato";
            this.ddlContratos.DataBind();

            if (ddlContratos.Items.Count == 0)
            {
                limpiarContrato();
                return;
            }

            this.ddlContratos.Items.Insert(0, new ListItem("", ""));
            ddlContratos.Enabled = true;
            limpiarDetalle();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }
    }


    protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlTipoDocumento.SelectedValue.Trim().Length > 0)
            cargarDocumentos();
        else
            limpiarDocumentos();
    }

    private void limpiarDocumentos()
    {
        ddlNumeroDocumento.DataSource = null;
        ddlNumeroDocumento.SelectedValue = null;
        ddlNumeroDocumento.DataBind();
        ddlNumeroDocumento.Enabled = false;
        limpiarEmpleados();
    }

    private void cargarDocumentos()
    {
        try
        {
            this.ddlNumeroDocumento.DataSource = modificacionNomina.CargarNumeroDeDocumento(Convert.ToInt32(ddlAño.SelectedValue), Convert.ToInt32(ddlPeriodo.SelectedValue), ddlTipoDocumento.SelectedValue, Convert.ToInt32(Session["empresa"]));
            this.ddlNumeroDocumento.DataValueField = "numero";
            this.ddlNumeroDocumento.DataTextField = "numero";
            this.ddlNumeroDocumento.DataBind();
            if (this.ddlNumeroDocumento.Items.Count == 0)
            {
                limpiarDocumentos();
                return;
            }
            this.ddlNumeroDocumento.Items.Insert(0, new ListItem("", ""));
            this.ddlNumeroDocumento.Enabled = true;
            limpiarEmpleados();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlNumeroDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlNumeroDocumento.SelectedValue.Trim().Length > 0)
            cargarEmpleados();
        else
            limpiarEmpleados();
    }

    private void limpiarEmpleados()
    {
        ddlEmpleado.DataSource = null;
        ddlEmpleado.SelectedValue = null;
        ddlEmpleado.DataBind();
        ddlEmpleado.Enabled = false;
        limpiarContrato();
    }

    private void cargarEmpleados()
    {
        try
        {
            this.ddlEmpleado.DataSource = modificacionNomina.CargarEmpleado(
                Convert.ToInt32(ddlAño.SelectedValue),
                Convert.ToInt32(ddlPeriodo.SelectedValue),
                ddlTipoDocumento.SelectedValue,
                Convert.ToInt32(Session["empresa"]),
                ddlNumeroDocumento.SelectedValue);
            this.ddlEmpleado.DataValueField = "codTercero";
            this.ddlEmpleado.DataTextField = "descripcion";
            this.ddlEmpleado.DataBind();
            if (ddlEmpleado.Items.Count == 0)
            {
                limpiarEmpleados();
                return;
            }
            this.ddlEmpleado.Items.Insert(0, new ListItem("", ""));
            this.ddlEmpleado.Enabled = true;
            limpiarContrato();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlContratos_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlContratos.SelectedValue.Trim().Length > 0)
            CargarDetalle();
        else
            limpiarDetalle();
    }

    private void limpiarDetalle()
    {
        gvDetalleLiquidacion.DataSource = null;
        gvDetalleLiquidacion.DataBind();
        gvDetalleLiquidacion.Visible = false;
        detailLoadedPanel.Visible = false;
        ddlConceptoVal.Text = "";
    }

    private void CargarDetalle()
    {
        try
        {
            ListadoDetalleLiquidacion = new List<LiquidacionDetalle>();
            var result = modificacionNomina.CargarDetalleLiquidación(
                Convert.ToInt32(ddlAño.SelectedValue),
                Convert.ToInt32(ddlPeriodo.SelectedValue),
                ddlTipoDocumento.SelectedValue,
                Convert.ToInt32(Session["empresa"]),
                ddlNumeroDocumento.SelectedValue,
                Convert.ToInt32(ddlEmpleado.SelectedValue),
                Convert.ToInt32(ddlContratos.SelectedValue));
            foreach (DataRow dr in result.Tables[0].AsEnumerable())
            {
                var item = new LiquidacionDetalle();
                item.CodConcepto = dr["codConcepto"].ToString();
                item.DescripcionConcepto = dr["descripcionConcepto"].ToString();
                item.Cantidad = dr["cantidad"].ToString();
                item.ValorUnitario = dr["valorUnitario"].ToString();
                item.ValorTotal = dr["valorTotal"].ToString();
                item.RegistroDetalleNomina = dr["registroDetalleNomina"].ToString();
                ListadoDetalleLiquidacion.Add(item);
            }
            this.gvDetalleLiquidacion.DataSource = ListadoDetalleLiquidacion;
            this.gvDetalleLiquidacion.DataBind();
            gvDetalleLiquidacion.Visible = true;
            detailLoadedPanel.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvDetalleLiquidacion_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (ListadoDetalleLiquidacionEliminados == null)
            ListadoDetalleLiquidacionEliminados = new List<LiquidacionDetalle>();

        var dr = ListadoDetalleLiquidacion[e.RowIndex];
        if (!dr.RegistroDetalleNomina.ToString().Equals("0"))
            ListadoDetalleLiquidacionEliminados.Add(dr);

        ListadoDetalleLiquidacion.Remove(dr);
        var i = 1;
        foreach(var rd in ListadoDetalleLiquidacion) {
            rd.RegistroDetalleNomina = (i++).ToString();
        }
        
        gvDetalleLiquidacion.DataSource = ListadoDetalleLiquidacion;
        gvDetalleLiquidacion.DataBind();
        hasMadeChangesPanel.Visible = true;
    }

    protected void btnCargar_Click(object sender, ImageClickEventArgs e)
    {
        ddlConceptoVal.Text = "";
        if (string.IsNullOrEmpty(ddlConcepto.SelectedValue.Trim()))
        {
            ddlConceptoVal.Text = "Debe seleccionar un concepto";
            return;
        }

        var dt = ListadoDetalleLiquidacion;
        var dataRow = new LiquidacionDetalle();
        dataRow.RegistroDetalleNomina = ListadoDetalleLiquidacion.Count.ToString();
        dataRow.CodConcepto = ddlConcepto.SelectedValue;
        dataRow.DescripcionConcepto = ddlConcepto.SelectedItem.Text;
        dataRow.Cantidad = "0";
        dataRow.ValorUnitario = "0";
        dataRow.ValorTotal = "0";
        dt.Add(dataRow);

        gvDetalleLiquidacion.DataSource = ListadoDetalleLiquidacion;
        gvDetalleLiquidacion.DataBind();

        ddlConcepto.SelectedValue = "";
        hasMadeChangesPanel.Visible = true;
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        ddlConceptoVal.Text = "";
        CargarDetalle();
        ddlConcepto.SelectedValue = "";
        hasMadeChangesPanel.Visible = false;
    }

    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            modificacionNomina.ElimnarDetalleLiquidación(
                Convert.ToInt32(ddlAño.SelectedValue),
                Convert.ToInt32(ddlPeriodo.SelectedValue),
                ddlTipoDocumento.SelectedValue,
                Convert.ToInt32(Session["empresa"]),
                ddlNumeroDocumento.SelectedValue,
                Convert.ToInt32(ddlEmpleado.SelectedValue),
                Convert.ToInt32(ddlContratos.SelectedValue));
            modificacionNomina.GuardarDetalleLiqidación(
                Convert.ToInt32(ddlAño.SelectedValue),
                Convert.ToInt32(ddlPeriodo.SelectedValue),
                ddlTipoDocumento.SelectedValue,
                Convert.ToInt32(Session["empresa"]),
                ddlNumeroDocumento.SelectedValue,
                Convert.ToInt32(ddlEmpleado.SelectedValue),
                Convert.ToInt32(ddlContratos.SelectedValue),
                ListadoDetalleLiquidacion)                                                           ;
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos. Correspondiente a: " + ex.Message, "C");
        }
    }
}
