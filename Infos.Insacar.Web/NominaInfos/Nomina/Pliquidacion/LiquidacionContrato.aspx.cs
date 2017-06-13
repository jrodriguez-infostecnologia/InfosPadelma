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
            txvValorUnittario.Visible = true;
            txvCantidad.Visible = true;

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
            txvValorUnittario.Visible = false;
            txvCantidad.Visible = false;
            lblValorTotal.Visible = false;
        }
    }

    private void cargarLiquidacion()
    {
        gvDetalleLiquidacion.Visible = true;
        int año, perido;
        DateTime fechaCorte = Convert.ToDateTime(txtFecha.Text);
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


        DataView dvLiquidacion = liquidacion.PreliquidarContrato(perido, Convert.ToInt16(Session["empresa"]), año, Convert.ToInt16(ddlEmpleado.SelectedValue), chkLiquiNomina.Checked, fechaCorte);
        gvDetalleLiquidacion.DataSource = dvLiquidacion;
        gvDetalleLiquidacion.DataBind();

        if (gvDetalleLiquidacion.Rows.Count > 0)
            this.Session["liquidacionContrato"] = dvLiquidacion;
    }

    private void Preliquidar()
    {
        DataView dvLiquidacion = liquidacion.getLiquidacionNomina(Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"])); ;

    }


    private void manejoLiquidacion()
    {
        if (ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlAño.SelectedValue.Trim().Length > 0)
            lbPreLiquidar.Visible = true;
        else
            lbPreLiquidar.Visible = false;
    }
    protected void cargarPeriodos()
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

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }
    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            this.gvLista.DataSource = liquidacion.BuscarEntidadContrato(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C", ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                        this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, "C");
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
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
      "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
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

        try
        {
            this.ddlEmpleado.DataSource = funcionarios.SelecccionaFuncionariosRetirados(Convert.ToInt32(this.Session["empresa"]));
            this.ddlEmpleado.DataValueField = "tercero";
            this.ddlEmpleado.DataTextField = "descripcion";
            this.ddlEmpleado.DataBind();
            this.ddlEmpleado.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
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
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
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
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = null;
        this.Session["liquidacionContrato"] = null;
        this.nilblInformacion.Text = "";
        lbFecha.Enabled = true;
        this.txtFecha.Focus();
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvDetalleLiquidacion.DataSource = null;
        this.gvDetalleLiquidacion.DataBind();
        gvDetalleLiquidacion.Visible = false;
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.Session["editar"] = null;
        lbFecha.Enabled = true;
    }


    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.nilblMensaje.Text = "";

        using (TransactionScope ts = new TransactionScope())
        {
            try
            {
                this.Session["numerotransaccion"] = this.gvLista.Rows[e.RowIndex].Cells[2].Text;
                if (transacciones.VerificaEdicionBorrado(this.gvLista.Rows[e.RowIndex].Cells[1].Text, this.gvLista.Rows[e.RowIndex].Cells[2].Text, Convert.ToInt16(Session["empresa"])) != 0)
                {
                    this.nilblMensaje.Text = "Transacción ejecutada / anulada no es posible su edición";
                    return;
                }

                switch (transacciones.AnulaLiquidacionDefinitiva(this.gvLista.Rows[e.RowIndex].Cells[1].Text, this.gvLista.Rows[e.RowIndex].Cells[2].Text, this.Session["usuario"].ToString().Trim(), Convert.ToInt16(Session["empresa"]),
                    Convert.ToInt16(gvLista.Rows[e.RowIndex].Cells[4].Text), Convert.ToInt16(gvLista.Rows[e.RowIndex].Cells[5].Text), Convert.ToInt16(gvLista.Rows[e.RowIndex].Cells[6].Text)))
                {
                    case 0:
                        nilblMensaje.Text = "Registro Anulado satisfactoriamente";
                        ts.Complete();
                        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                        this.nilbNuevo.Visible = true;
                        GetEntidad();
                        break;
                    case 1:
                        nilblMensaje.Text = "Error al anular la transacción. Operación no realizada";
                        break;
                }
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
        this.nilbNuevo.Visible = true;
        GetEntidad();

        this.gvDetalleLiquidacion.DataSource = null;
        this.gvDetalleLiquidacion.DataBind();
        gvDetalleLiquidacion.Visible = false;
    }


    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToShortDateString();
       
    }
    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }


    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {

        try
        {
            Convert.ToDateTime(txtFecha.Text);
        }
        catch
        {
            nilblInformacion.Text = "Formato de fecha no valido";
            txtFecha.Text = "";
            txtFecha.Focus();
            return;
        }


    }

    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoLiquidacion();
    }

    protected void lbPreLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (txtFecha.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una fecha para guardar liquidación";
                txtFecha.Focus();
                return;
            }

            if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlEmpleado.Focus();
                return;
            }
            cargarLiquidacion();
            manejaConceptos();
            ddlEmpleado.Enabled = false;
            lbFecha.Enabled = false;
            txtFecha.Enabled = false;

        }
        catch (Exception ex)
        {
            ManejoError("Error al liquidar el documento debido a :" + ex.Message, "I");
        }
    }

    private void Liquidar()
    {
        string script = "", numeroTransaccion = "";
        int retorno = 0;

        gvDetalleLiquidacion.Visible = true;
        int año, perido;
        DateTime fechaCorte = Convert.ToDateTime(txtFecha.Text);

        año = Convert.ToInt16(ddlAño.SelectedValue);
        perido = Convert.ToInt16(ddlPeriodo.SelectedValue);

        liquidacion.LiquidacionContratoDefinitiva(año, perido, Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(),
            Convert.ToInt32(Convert.ToDateTime(txtFecha.Text).Month), fechaCorte, ConfigurationManager.AppSettings["TipoTransaccionContrato"].ToString(),
        Session["usuario"].ToString(), txtObservacion.Text, chkLiquiNomina.Checked, out retorno, out numeroTransaccion);
        switch (retorno)
        {
            case 1:
                script = @"<script type='text/javascript'>
                            alerta('Periodo no existe o cerrado');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;
            case 2:
                script = @"<script type='text/javascript'>
                            alerta('El funcionario ya tiene una liquidacion');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;
            case 0:
                ManejoExito("Liquidacion registrada satisfactoriamente.", "I");
                script = "<script language='javascript'>VisualizacionContrato('liquidacionContrato','" + numeroTransaccion + "');</script>";
                Page.RegisterStartupScript("VisualizacionLiquidacion", script);
                break;
        }
    }

    protected void btnLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (txtFecha.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una fecha para guardar liquidación";
                txtFecha.Focus();
                return;
            }

            if (ddlAño.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un año para guardar liquidación";
                ddlAño.Focus();
                return;
            }

            if (ddlAño.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una forma de liquidación para seguir";
                txtFecha.Focus();
                return;
            }


            if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlEmpleado.Focus();
                return;
            }
            Liquidar();
            this.gvDetalleLiquidacion.DataSource = null;
            this.gvDetalleLiquidacion.DataBind();
            gvDetalleLiquidacion.Visible = false;


        }
        catch (Exception ex)
        {
            ManejoError("Error al liquidar el documento debido a :" + ex.Message, "I");
        }
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    #endregion EventosFuncionario

    protected void ddlAño_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length > 0)
        {
            cargarPeriodos();
            manejoLiquidacion();
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
        if (ddlConcepto.SelectedValue.Length == 0 || txvValorTotal.Text.Length == 0 || txvValorUnittario.Text.Length == 0 || txvCantidad.Text.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

        if (Convert.ToDecimal(txvValorTotal.Text) == 0 || Convert.ToDecimal(txvCantidad.Text) == 0 || Convert.ToDecimal(txvValorUnittario.Text) == 0)
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
            switch (liquidacion.InsertaConceptoLiquidacionContrato(ddlEmpleado.SelectedValue.Trim(), ddlConcepto.SelectedValue, Convert.ToDecimal(txvValorTotal.Text), Convert.ToInt16(Session["empresa"]),Convert.ToDecimal(txvCantidad.Text),Convert.ToDecimal(txvValorUnittario.Text)))
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
}
