using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_Liquidacion : System.Web.UI.Page
{

    #region Instancias


    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cfuncionarios funcionarios = new Cfuncionarios();
    Coperadores operadores = new Coperadores();
    CtransaccionNovedad transaccionNovedad = new CtransaccionNovedad();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Cperiodos periodo = new Cperiodos();
    string numerotransaccion = "";
    Ctransacciones transacciones = new Ctransacciones();
    CliquidacionNomina liquidacion = new CliquidacionNomina();
    Cgeneral general = new Cgeneral();
    Cfuncionarios funcionario = new Cfuncionarios();
    CModificacionNomina modificacionNomina = new CModificacionNomina();

    #endregion Instancias

    #region Metodos

    private void cargarConcepto()
    {
        try
        {
            DataView dvConceptosNoFijos = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvConceptosNoFijos.RowFilter = "empresa = " + Convert.ToInt16(Session["empresa"]).ToString() + " and fijo = 0 and ausentismo=0";
            this.ddlConcepto.DataSource = dvConceptosNoFijos;
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
    private void manejaConceptos()
    {
        if (gvDetalleLiquidacion.Rows.Count > 0)
        {
            lblConcepto.Visible = true;
            ddlConcepto.Visible = true;
            txvValorTotal.Visible = true;
            btnCargar.Visible = true;
            btnLiquidar.Visible = true;
            txvValorTotal.Text = "0";
            lblCantidad.Visible = true;
            lblValorUnitario.Visible = true;
            lblValorTotal.Visible = true;
            txvValorUnitario.Visible = true;

            cargarConcepto();
        }
        else
        {
            lblConcepto.Visible = false;
            ddlConcepto.Visible = false;
            txvValorTotal.Visible = false;
            btnCargar.Visible = false;
            btnLiquidar.Visible = false;
            lblCantidad.Visible = false;
            lblValorUnitario.Visible = false;
            txvValorUnitario.Visible = false;
            lblValorTotal.Visible = false;
        }
    }

    private void cargarLiquidacion()
    {
        gvDetalleLiquidacion.Visible = true;
        int año, perido;
        DateTime fechaCorte;
        if (ddlAño.Visible == true)
        {
            año = Convert.ToInt16(ddlAño.SelectedValue);
            perido = Convert.ToInt16(ddlPeriodo.SelectedValue);
        }
        else
        {
            año = DateTime.Now.Year;
            perido = 0;
        }


        DataView dvLiquidacion = liquidacion.PreliquidarContrato(perido, Convert.ToInt16(Session["empresa"]), año, Convert.ToInt16(ddlEmpleado.SelectedValue), false, DateTime.Now);
        gvDetalleLiquidacion.DataSource = dvLiquidacion;
        gvDetalleLiquidacion.DataBind();

        if (gvDetalleLiquidacion.Rows.Count > 0)
            this.Session["liquidacionContrato"] = dvLiquidacion;
    }

    private void cargarPeriodos()
    {
        try
        {
            this.ddlPeriodo.DataSource = periodo.PeriodosAbiertoNominaAño(Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
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

    private string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
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

    private string ConsecutivoTransaccion(string tipoTransaccion)
    {
        string numero = "";

        try
        {
            numero = transacciones.RetornaNumeroTransaccion(tipoTransaccion, Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el número de transacción. Correspondiente a: " + ex.Message, "C");
        }

        return numero;
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
            CargarCombos();
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        CargarCombos();
        manejaConceptos();
        this.Session["editar"] = null;
        this.Session["liquidacionContrato"] = null;
        this.nilblInformacion.Text = "";
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.gvDetalleLiquidacion.DataSource = null;
        this.gvDetalleLiquidacion.DataBind();
        gvDetalleLiquidacion.Visible = false;
        this.nilblInformacion.Text = "";
        this.Session["editar"] = null;
    }


    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.nilblMensaje.Text = "";

        using (TransactionScope ts = new TransactionScope())
        {
            try
            {

            }
            catch (Exception ex)
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }

    #endregion Eventos

    #region MetodosFuncionario




    #endregion MetodosFuncionario

    #region EventosFuncionario


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);

        this.gvDetalleLiquidacion.DataSource = null;
        this.gvDetalleLiquidacion.DataBind();
        gvDetalleLiquidacion.Visible = false;
    }




    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarTipoDeDocumento();
        //manejoLiquidacion();
    }

    private void cargarTipoDeDocumento()
    {
        try
        {
            this.ddlTipoDocumento.DataSource = modificacionNomina.CargarTipoDeDocumento(Convert.ToInt32(ddlAño.SelectedValue), Convert.ToInt32(ddlPeriodo.SelectedValue), Convert.ToInt32(Session["empresa"]));
            this.ddlTipoDocumento.DataValueField = "codigo";
            this.ddlTipoDocumento.DataTextField = "tipo";
            this.ddlTipoDocumento.DataBind();
            this.ddlTipoDocumento.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void lbPreLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlEmpleado.Focus();
                return;
            }
            cargarLiquidacion();
            manejaConceptos();
            ddlEmpleado.Enabled = false;


        }
        catch (Exception ex)
        {
            ManejoError("Error al liquidar el documento debido a :" + ex.Message, "I");
        }
    }



    protected void btnLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {

            if (ddlAño.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un año para guardar liquidación";
                ddlAño.Focus();
                return;
            }


            if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un empleado para seguir";
                ddlEmpleado.Focus();
                return;
            }

            if (ddlContratos.SelectedValue.ToString().Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar contrato";
                return;
            }

            this.gvDetalleLiquidacion.DataSource = null;
            this.gvDetalleLiquidacion.DataBind();
            gvDetalleLiquidacion.Visible = false;


        }
        catch (Exception ex)
        {
            ManejoError("Error al liquidar el documento debido a :" + ex.Message, "I");
        }
    }
    #endregion EventosFuncionario

    protected void ddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length > 0)
        {
            cargarPeriodos();
            //manejoLiquidacion();
        }
    }
    protected void gvSaludPension_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            switch (liquidacion.EliminaConceptoLiquidacionContrato(Convert.ToInt16(ddlEmpleado.SelectedValue.Trim()),
                Convert.ToString((this.gvDetalleLiquidacion.Rows[e.RowIndex].Cells[1].Text)), Convert.ToInt16(Session["empresa"])))
            {
                case 0:
                    cargarGrillaConceptos();
                    break;
                case 1:
                    ManejoError("Error al eliminar el registro. Operación no realizada", "E");
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

    protected void btnCargar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlConcepto.SelectedValue.Length == 0 || txvValorTotal.Text.Length == 0 || txvValorUnitario.Text.Length == 0 || txvValorUnitario.Text.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

        if (Convert.ToDecimal(txvValorTotal.Text) == 0 || Convert.ToDecimal(txvValorUnitario.Text) == 0 || Convert.ToDecimal(txvValorUnitario.Text) == 0)
        {
            nilblMensaje.Text = "Campos cero (0), por favor corrija";
            return;
        }

        foreach (GridViewRow r in gvDetalleLiquidacion.Rows)
        {
            if (r.Cells[3].Text == ddlConcepto.SelectedValue)
            {
                CcontrolesUsuario.MensajeError("El concepto seleccionado ya se encuentra registrado. Por favor corrija", nilblMensaje);
                return;
            }
        }
        guardarCocepto();
    }

    private void guardarCocepto()
    {

        try
        {
            switch (liquidacion.InsertaConceptoLiquidacionContrato(ddlEmpleado.SelectedValue.Trim(), ddlConcepto.SelectedValue, Convert.ToDecimal(txvValorTotal.Text), Convert.ToInt16(Session["empresa"]), Convert.ToDecimal(txvValorUnitario.Text), Convert.ToDecimal(txvValorUnitario.Text)))
            {
                case 0:
                    cargarGrillaConceptos();
                    break;
                case 1:
                    nilblMensaje.Text = "Error al cargar concepto.";
                    break;
            }
        }

        catch (Exception ex)
        {
            ManejoError("Error al eliminar borrar la fila debido a : " + ex.Message, "E");
        }
    }

    private void cargarGrillaConceptos()
    {
        gvDetalleLiquidacion.Visible = true;
        DataView dvLiquidacion = liquidacion.cargarConceptosLiquidacionContrato(Convert.ToInt16(Session["empresa"]));
        gvDetalleLiquidacion.DataSource = dvLiquidacion;
        gvDetalleLiquidacion.DataBind();

    }
    protected void ddlEmpleado_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarContrato();
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
            this.ddlContratos.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }
    }


    protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarDocumentos();
    }

    private void cargarDocumentos()
    {
        try
        {
            this.ddlNumeroDocumento.DataSource = modificacionNomina.CargarNumeroDeDocumento(Convert.ToInt32(ddlAño.SelectedValue), Convert.ToInt32(ddlPeriodo.SelectedValue), ddlTipoDocumento.SelectedValue, Convert.ToInt32(Session["empresa"]));
            this.ddlNumeroDocumento.DataValueField = "numero";
            this.ddlNumeroDocumento.DataTextField = "numero";
            this.ddlNumeroDocumento.DataBind();
            this.ddlNumeroDocumento.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlNumeroDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarEmpleados();
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
            this.ddlEmpleado.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlContratos_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarDetalle();
    }

    private void CargarDetalle()
    {
        try
        {
            this.gvDetalleLiquidacion.DataSource = modificacionNomina.CargarDetalleLiquidación(
                Convert.ToInt32(ddlAño.SelectedValue),
                Convert.ToInt32(ddlPeriodo.SelectedValue),
                ddlTipoDocumento.SelectedValue,
                Convert.ToInt32(Session["empresa"]),
                ddlNumeroDocumento.SelectedValue,
                Convert.ToInt32(ddlEmpleado.SelectedValue),
                Convert.ToInt32(ddlContratos.SelectedValue));
            this.gvDetalleLiquidacion.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }
}
