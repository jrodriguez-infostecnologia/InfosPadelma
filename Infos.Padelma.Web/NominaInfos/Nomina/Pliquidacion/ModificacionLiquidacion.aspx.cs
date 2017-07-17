using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
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
            this.ddlPeriodo.DataSource = periodo.PeriodosAbiertoNominaA�o(Convert.ToInt32(ddlA�o.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
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
            if (ddlPeriodo.Items.Count == 2)
            {
                ddlPeriodo.SelectedIndex = 1;
                cargarTipoDeDocumento();
            }
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
            this.ddlA�o.DataSource = periodo.PeriodoA�oAbiertoNomina(Convert.ToInt16(Session["empresa"]));
            this.ddlA�o.DataValueField = "a�o";
            this.ddlA�o.DataTextField = "a�o";

            this.ddlA�o.DataBind();
            this.ddlA�o.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�o. Correspondiente a: " + ex.Message, "C");
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
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
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
                foreach (GridViewRow dr in gvDetalleLiquidacion.Rows)
                {
                    var item = new LiquidacionDetalle();
                    item.CodConcepto = Server.HtmlDecode(dr.Cells[2].Text.ToString());
                    item.DescripcionConcepto = Server.HtmlDecode(dr.Cells[3].Text.ToString());
                    item.Cantidad = ((HiddenField)dr.FindControl("cantidad")).Value.ToString();
                    item.ValorUnitario = ((HiddenField)dr.FindControl("valorUnitario")).Value.ToString();
                    item.ValorTotal = ((HiddenField)dr.FindControl("valorTotal")).Value.ToString();
                    item.BaseSeguridadSocial = ((HiddenField)dr.FindControl("BaseSeguridadSocial")).Value.ToString() == true.ToString();
                    item.ValidaPorcentaje = ((HiddenField)dr.FindControl("ValidaPorcentaje")).Value.ToString() == true.ToString();
                    item.Deduccion = ((HiddenField)dr.FindControl("Deduccion")).Value.ToString() == true.ToString();
                    item.HabilitaValorTotal = ((HiddenField)dr.FindControl("HabilitaValorTotal")).Value.ToString() == true.ToString();
                    item.Porcentaje = ((HiddenField)dr.FindControl("Porcentaje")).Value.ToString();
                    item.ValorUnitario = Math.Round(Convert.ToDouble(item.ValorUnitario)).ToString();
                    item.ValorTotal = Math.Round(Convert.ToDouble(item.ValorTotal)).ToString();
                    item.Cantidad = Math.Round(Convert.ToDouble(item.Cantidad)).ToString();
                    ListadoDetalleLiquidacion.Add(item);
                }
                var i = 1;
                ListadoDetalleLiquidacion = ListadoDetalleLiquidacion.OrderBy(_i => _i.Deduccion ? 1 : 0).ToList();
                ListadoDetalleLiquidacion.ForEach(_i => _i.RegistroDetalleNomina = (i++).ToString());

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
        detalleLiqidacion.Visible = false;
        //hasMadeChangesPanel.Visible = true;
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
            this.ddlTipoDocumento.DataSource = modificacionNomina.CargarTipoDeDocumento(Convert.ToInt32(ddlA�o.SelectedValue), Convert.ToInt32(ddlPeriodo.SelectedValue), Convert.ToInt32(Session["empresa"]));
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
            if (ddlTipoDocumento.Items.Count == 2)
            {
                ddlTipoDocumento.SelectedIndex = 1;
                cargarDocumentos();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�o. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion EventosFuncionario

    protected void ddlA�o_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlA�o.SelectedValue.Trim().Length > 0)
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
                Convert.ToInt32(ddlA�o.SelectedValue),
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
            if (ddlContratos.Items.Count == 2)
            {
                ddlContratos.SelectedIndex = 1;
                CargarDetalle();
            }
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
            this.ddlNumeroDocumento.DataSource = modificacionNomina.CargarNumeroDeDocumento(Convert.ToInt32(ddlA�o.SelectedValue), Convert.ToInt32(ddlPeriodo.SelectedValue), ddlTipoDocumento.SelectedValue, Convert.ToInt32(Session["empresa"]));
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
            if (ddlNumeroDocumento.Items.Count == 2)
            {
                ddlNumeroDocumento.SelectedIndex = 1;
                cargarEmpleados();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�o. Correspondiente a: " + ex.Message, "C");
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
                Convert.ToInt32(ddlA�o.SelectedValue),
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
            if (ddlEmpleado.Items.Count == 2)
            {
                ddlEmpleado.SelectedIndex = 1;
                cargarContrato();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�o. Correspondiente a: " + ex.Message, "C");
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
        detalleLiqidacion.Visible = false;
        ddlConceptoVal.Text = "";
        successMessage.Text = "";
        failMessage.Text = "";
    }

    private void CargarDetalle()
    {
        try
        {
            ListadoDetalleLiquidacion = new List<LiquidacionDetalle>();
            var result = modificacionNomina.CargarDetalleLiquidaci�n(
                Convert.ToInt32(ddlA�o.SelectedValue),
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
                item.Porcentaje = dr["porcentaje"].ToString();
                item.RegistroDetalleNomina = dr["registroDetalleNomina"].ToString();
                item.BaseSeguridadSocial = !(dr["baseSeguridadSocial"] is bool) ? false : (bool)dr["baseSeguridadSocial"];
                item.ValidaPorcentaje = !(dr["validaPorcentaje"] is bool) ? false : (bool)dr["validaPorcentaje"];
                item.Deduccion = !(dr["signo"] is int) ? false : ((int)dr["signo"] == 2);
                item.HabilitaValorTotal = !(dr["habilitaValorTotal"] is bool) ? false : (bool)dr["habilitaValorTotal"];
                item.ValorUnitario = Math.Round(Convert.ToDouble(item.ValorUnitario)).ToString();
                item.ValorTotal = Math.Round(Convert.ToDouble(item.ValorTotal)).ToString();
                item.Cantidad = Math.Round(Convert.ToDouble(item.Cantidad)).ToString();
                ListadoDetalleLiquidacion.Add(item);
            }
            var i = 1;
            ListadoDetalleLiquidacion = ListadoDetalleLiquidacion.OrderBy(_i => _i.Deduccion ? 1 : 0).ToList();
            ListadoDetalleLiquidacion.ForEach(_i => _i.RegistroDetalleNomina = (i++).ToString());

            this.gvDetalleLiquidacion.DataSource = ListadoDetalleLiquidacion;
            this.gvDetalleLiquidacion.DataBind();
            gvDetalleLiquidacion.Visible = true;
            detailLoadedPanel.Visible = true;
            detalleLiqidacion.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�o. Correspondiente a: " + ex.ToString(), "C");
        }
    }

    protected void gvDetalleLiquidacion_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        failMessage.Text = "";
        successMessage.Text = "";
        ddlConceptoVal.Text = "";
        var dr = ListadoDetalleLiquidacion[e.RowIndex];
        ListadoDetalleLiquidacion.Remove(dr);
        var i = 1;
        ListadoDetalleLiquidacion = ListadoDetalleLiquidacion.OrderBy(_i => _i.Deduccion ? 1 : 0).ToList();
        ListadoDetalleLiquidacion.ForEach(_i => _i.RegistroDetalleNomina = (i++).ToString());

        gvDetalleLiquidacion.DataSource = ListadoDetalleLiquidacion;
        gvDetalleLiquidacion.DataBind();
        //hasMadeChangesPanel.Visible = true;
    }

    protected void btnCargar_Click(object sender, ImageClickEventArgs e)
    {
        successMessage.Text = "";
        ddlConceptoVal.Text = "";
        failMessage.Text = "";
        if (string.IsNullOrEmpty(ddlConcepto.SelectedValue.Trim()))
        {
            ddlConceptoVal.Text = "Debe seleccionar un concepto";
            return;
        }
        try
        {
            var dr = modificacionNomina.CargarInformacionContepto(Convert.ToInt16(Session["empresa"]), ddlConcepto.SelectedValue.Trim()).Tables[0].Rows[0];

            var dt = ListadoDetalleLiquidacion;
            var item = new LiquidacionDetalle();
            item.RegistroDetalleNomina = (ListadoDetalleLiquidacion.Count + 1).ToString();
            item.CodConcepto = ddlConcepto.SelectedValue;
            item.DescripcionConcepto = ddlConcepto.SelectedItem.Text;
            item.Cantidad = "0";
            item.ValorUnitario = "0";
            item.ValorTotal = "0";
            item.BaseSeguridadSocial = !(dr["baseSeguridadSocial"] is bool) ? false : (bool)dr["baseSeguridadSocial"];
            item.ValidaPorcentaje = !(dr["calculaSobrePorcentaje"] is bool) ? false : (bool)dr["calculaSobrePorcentaje"];
            item.Deduccion = !(dr["signo"] is int) ? false : ((int)dr["signo"] == 2);
            item.HabilitaValorTotal = !(dr["habilitaValorTotal"] is bool) ? false : (bool)dr["habilitaValorTotal"];
            item.Porcentaje = dr["porcentaje"].ToString();
            dt.Add(item);
            var i = 1;
            ListadoDetalleLiquidacion = ListadoDetalleLiquidacion.OrderBy(_i => _i.Deduccion ? 1 : 0).ToList();
            ListadoDetalleLiquidacion.ForEach(_i => _i.RegistroDetalleNomina = (i++).ToString());
            gvDetalleLiquidacion.DataSource = ListadoDetalleLiquidacion;
            gvDetalleLiquidacion.DataBind();

            ddlConcepto.SelectedValue = "";
            //hasMadeChangesPanel.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la informaci�n de la categor�a." + ex.ToString(), "C");
        }
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        ddlConceptoVal.Text = "";
        CargarDetalle();
        ddlConcepto.SelectedValue = "";
        successMessage.Text = "";
        //hasMadeChangesPanel.Visible = false;
    }

    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            failMessage.Text = "";
            bool valid = true;
            foreach (var detalle in ListadoDetalleLiquidacion)
            {
                valid &= Convert.ToDouble(detalle.ValorTotal) > 0;
            }
            if (!valid)
            {
                failMessage.Text = "Todos los conceptos deben tener un valor total mayor a 0";
                return;
            }
            using (TransactionScope ts = new TransactionScope())
            {
                modificacionNomina.ElimnarDetalleLiquidaci�n(
                    Convert.ToInt32(ddlA�o.SelectedValue),
                    Convert.ToInt32(ddlPeriodo.SelectedValue),
                    ddlTipoDocumento.SelectedValue,
                    Convert.ToInt32(Session["empresa"]),
                    ddlNumeroDocumento.SelectedValue,
                    Convert.ToInt32(ddlEmpleado.SelectedValue),
                    Convert.ToInt32(ddlContratos.SelectedValue));

                modificacionNomina.GuardarDetalleLiqidaci�n(
                    Convert.ToInt32(ddlA�o.SelectedValue),
                    Convert.ToInt32(ddlPeriodo.SelectedValue),
                    ddlTipoDocumento.SelectedValue,
                    Convert.ToInt32(Session["empresa"]),
                    ddlNumeroDocumento.SelectedValue,
                    Convert.ToInt32(ddlEmpleado.SelectedValue),
                    Convert.ToInt32(ddlContratos.SelectedValue),
                    ListadoDetalleLiquidacion);
				ts.Complete();
            }
            successMessage.Text = "Cambios realizados exitosamente";
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos. Correspondiente a: " + ex.ToString(), "C");
        }
    }
}
