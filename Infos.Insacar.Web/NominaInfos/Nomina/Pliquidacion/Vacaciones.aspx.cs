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
using System.Collections.Generic;
using System.Transactions;

public partial class Facturacion_Padministracion_Embargos : System.Web.UI.Page
{
    #region Instancias
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cfuncionarios funcionarios = new Cfuncionarios();
    CtransaccionVacaciones travaca;
    CIP ip = new CIP();
    Cvacaciones vacaciones = new Cvacaciones();
    Cperiodos periodo = new Cperiodos();
    #endregion Instancias

    #region Metodos


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

    private void RetornaDatosContrato()
    {
        foreach (DataRowView dtv in funcionarios.RetornaDatosTercerosContratos(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlEmpleado.SelectedValue)))
        {
            lblCodCcosto.Text = dtv.Row.ItemArray.GetValue(0).ToString();
            lblCentroCosto.Text = dtv.Row.ItemArray.GetValue(1).ToString();
            lblCodDepartamento.Text = dtv.Row.ItemArray.GetValue(2).ToString();
            lblDepartamento.Text = dtv.Row.ItemArray.GetValue(3).ToString();
            string sueldo = string.Format("{0:N2}", decimal.Round(Convert.ToDecimal(dtv.Row.ItemArray.GetValue(4).ToString()), 0).ToString());
            lblSueldo.Text = sueldo;
        }
    }

    private void RetornaDatosVacacionesPendientes()
    {
        foreach (DataRowView dtv in vacaciones.RetornaVacacionePendientePeriodo(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlEmpleado.SelectedValue), Convert.ToDateTime(txtPeriodoInicial.Text), Convert.ToDateTime(txtPeriodoFinal.Text)))
        {
            lblDiasPendientes.Text = dtv.Row.ItemArray.GetValue(10).ToString();
            lblUltimaLiquidación.Text = Convert.ToDateTime(dtv.Row.ItemArray.GetValue(6).ToString()).Year.ToString() + "    de  " + Convert.ToDateTime(dtv.Row.ItemArray.GetValue(6).ToString()).ToShortDateString() + " hasta    " + Convert.ToDateTime(dtv.Row.ItemArray.GetValue(7).ToString()).ToShortDateString();
            lblPeriodoIUvacaciones.Text = Convert.ToDateTime(dtv.Row.ItemArray.GetValue(1).ToString()).ToShortDateString();
            lblPeriodoFUVacaciones.Text = Convert.ToDateTime(dtv.Row.ItemArray.GetValue(2).ToString()).ToShortDateString();
            manejoUltivaVacaciones(true);
        }
    }

    private void manejoUltivaVacaciones(bool manejo)
    {
        lblUltimaLiquidación.Visible = manejo;
        lblEUltimaLiquidacion.Visible = manejo;
        lblPeriodoIUvacaciones.Visible = manejo;
        lblPeriodoFUVacaciones.Visible = manejo;
        lblDiasPendientes.Visible = manejo;
        lblEDiasPendientes.Visible = manejo;
        lblEguion.Visible = manejo;
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

            this.gvLista.DataSource = vacaciones.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

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

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        CcontrolesUsuario.InhabilitarControles(pnConceptos.Controls);
        CcontrolesUsuario.LimpiarControles(
          pnConceptos.Controls);
        pnConceptos.Visible = false;
        this.nilbNuevo.Visible = true;
        nilblInformacion.Text = mensaje;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
             ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }

    private void Guardar()
    {
        string operacion = "inserta";
        int codigo;
        bool validar = false;
        bool liquidada = false;

        try
        {
            using (TransactionScope ts = new TransactionScope())
            {
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                    codigo = Convert.ToInt32(txtCodigo.Text);
                }
                else
                    codigo = Convert.ToInt32(vacaciones.Consecutivo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), Convert.ToDateTime(txtPeriodoInicial.Text), Convert.ToDateTime(txtPeriodoFinal.Text)));


                if (chkLiquiNomina.Checked == true)
                {
                    liquidada = false;
                }

                object[] objValores = new object[]{

                                          false,  // @acumulada	bit
                                          false,  //@anulado	bit
                                          Convert.ToInt32(lblPeriodoVacaciones.Text),//@año	int
                                          Convert.ToInt32(ddlAño.SelectedValue.Trim()), //@añoPago	int
                                           Convert.ToInt32(txvNoDiasCausados.Text),    // @diasCausados	int
                                            Convert.ToInt32(txvDiasPagar.Text),       //@diasPagados	int
                          Convert.ToInt32(txvNoDiasPendientes.Text),        //@diasPendientes	int
                           Convert.ToInt32(txvNoDiasDisfrutados.Text),     //@diasTomados	int
                           false ,//@ejecutado bit
                           Convert.ToInt32(ddlEmpleado.SelectedValue),     //@empleado	int
                                        Convert.ToInt16(Session["empresa"]),          //@empresa	int
                                             null,//@fechaAnulado
                             DateTime.Now,   //@fechaRegistro	datetime
                             Convert.ToDateTime(txtFechaRetorno.Text),   //@fechaRetorno	date
                             Convert.ToDateTime(txtFecha.Text),   //@fechaSalida	date
                                            liquidada   ,//@liquidada
                               0 ,//@mes
                             txtObservacion.Text,   //@observaciones	varchar
                              chkLiquiNomina.Checked, //@pagaNomina bit
                                 Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()),  //@periodo int
                             Convert.ToDateTime(txtPeriodoFinal.Text),   //@periodoFinal	date
                             Convert.ToDateTime(txtPeriodoInicial.Text),   //@periodoInicial	date
                             Convert.ToInt32(txtCodigo.Text),    //@registro	int
                             ddlTipoVacaciones.SelectedValue,   //@tipo	varchar
                             (string)this.Session["usuario"],   //@usuario	varchar
                             null,//@usuarioAnulado,
                            Convert.ToDecimal(txvValorBase.Text),    //@valorBase	decimal
                             Convert.ToDecimal(txtValorVacaciones.Text)   //@valorPagado	decimal                              
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nVacaciones", operacion, "ppa", objValores))
                {
                    case 0:

                        foreach (GridViewRow r in gvSaludPension.Rows)
                        {
                            switch (vacaciones.InsertaDetalleVacaciones(Convert.ToInt16(Session["empresa"]),
                                Convert.ToDateTime(txtPeriodoInicial.Text), Convert.ToDateTime(txtPeriodoFinal.Text),
                                Convert.ToInt32(ddlEmpleado.SelectedValue), codigo, r.Cells[1].Text,
                                Convert.ToDecimal(r.Cells[3].Text), 0, Convert.ToDecimal(r.Cells[4].Text), Convert.ToInt16(r.Cells[6].Text)))
                            {
                                case 1:
                                    validar = true;
                                    break;
                            }
                        }
                        break;
                    case 1:
                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }

                if (validar == false)
                {
                    ManejoExito("Registros insertado satisfactoriamente", "I");
                    ts.Complete();
                }
                else
                    ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
            }
        }
        catch (Exception ex)
        {
            ManejoError("Errores al insertar el registro. debido a:  " + ex.Message, "I");
        }

        if (validar == false)
        {

        }
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlEmpleado.DataSource = funcionarios.RetornaTercerosContratosActivos(Convert.ToInt32(this.Session["empresa"]));
            this.ddlEmpleado.DataValueField = "tercero";
            this.ddlEmpleado.DataTextField = "descripcion";
            this.ddlEmpleado.DataBind();
            this.ddlEmpleado.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }

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
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
             ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
                this.nitxtBusqueda.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                              nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        this.Session["vacaciones"] = null;
        manejoNuevo();
        CargarCombos();
        txvNoDiasCausados.Enabled = true;
    }

    private void manejoNuevo()
    {
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        manejoUltivaVacaciones(false);
        this.txtCodigo.Enabled = false;
        this.txtPeriodoInicial.Enabled = false;
        this.txtPeriodoFinal.Enabled = false;
        this.txvDiasPagar.Enabled = false;
        this.txvValorBase.Enabled = false;
        this.txvNoDiasPendientes.Enabled = false;
        this.txvNoDiasDisfrutados.Enabled = false;
        this.txtFechaRetorno.Enabled = false;
        this.nilblInformacion.Text = "";
        this.Session["transaccionVaca"] = null;
        this.Session["edicionConA"] = null;
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        CcontrolesUsuario.InhabilitarControles(pnConceptos.Controls);
        CcontrolesUsuario.LimpiarControles(pnConceptos.Controls);
        pnConceptos.Visible = false;
        ddlEmpleado.DataSource = null;
        ddlEmpleado.DataBind();
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.Session["vacaciones"] = null;
        this.Session["transaccionVaca"] = null;
        this.Session["edicionConA"] = null;
        txvNoDiasCausados.Enabled = false;
        ddlPeriodo.DataSource = null;
        ddlPeriodo.DataBind();
        ddlAño.DataSource = null;
        ddlAño.DataBind();
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        gvLista.DataSource = null;
        gvLista.DataBind();
        gvSaludPension.DataSource = null;
        gvSaludPension.DataBind();
        pnConceptos.Visible = false;
        GetEntidad();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (gvSaludPension.Rows.Count == 0)
        {
            this.nilblInformacion.Text = "Debe liquidar vacaciones para registrar";
            return;
        }

        if (ddlEmpleado.SelectedValue.Trim().Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
        nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    private void calculaFechaFinal()
    {
        try
        {
            TimeSpan diasPagados;
            int noDiasvaca = vacaciones.RetornaDiasVacaciones(Convert.ToInt16(Session["empresa"]));
            if (txtFecha.Text.Trim().Length > 0)
            {
                if (Convert.ToInt32(txvNoDiasCausados.Text) > noDiasvaca)
                {
                    nilblInformacion.Text = "El numero de dias causados no puede ser mayor a :    " + noDiasvaca.ToString();
                    txvNoDiasCausados.Text = "0";
                    txvNoDiasCausados.Focus();
                    return;
                }
            }

            if (lblDiasPendientes.Text.Trim().Length > 0)
            {
                if (Convert.ToInt32(lblDiasPendientes.Text) > 0)
                {
                    if (Convert.ToInt32(txvNoDiasCausados.Text) > Convert.ToInt32(lblDiasPendientes.Text))
                    {
                        nilblInformacion.Text = "El numero de dias causados no puede ser mayor a :    " + Convert.ToInt32(lblDiasPendientes.Text).ToString();
                        txvNoDiasCausados.Text = "0";
                        txvNoDiasCausados.Focus();
                        return;
                    }
                }
            }
            if (txtFecha.Text.Trim().Length > 0)
            {
                if (vacaciones.fechaFinalxDiaHabil(Convert.ToDateTime(txtFecha.Text),
                    Convert.ToInt16(Session["empresa"]), Convert.ToInt32(txvNoDiasDisfrutados.Text), Convert.ToInt32(ddlEmpleado.SelectedValue.Trim())) == "1")
                {
                    nilblInformacion.Text = "Debe parametrizar días habiles";
                    return;
                }
                else
                {
                    switch (Convert.ToInt32(ddlTipoVacaciones.SelectedValue))
                    {
                        case 1:
                            txtFechaRetorno.Text = vacaciones.fechaFinalxDiaHabil(Convert.ToDateTime(txtFecha.Text),
                                Convert.ToInt16(Session["empresa"]), Convert.ToInt32(txvNoDiasCausados.Text), Convert.ToInt32(ddlEmpleado.SelectedValue.Trim()));
                            diasPagados = Convert.ToDateTime(txtFechaRetorno.Text).Subtract(Convert.ToDateTime(txtFecha.Text));
                            txvDiasPagar.Text = diasPagados.Days.ToString();
                            break;
                        case 2:
                            txtFechaRetorno.Text = Convert.ToDateTime(txtFecha.Text).AddDays(Convert.ToInt32(txvNoDiasCausados.Text)).ToShortDateString();
                            diasPagados = Convert.ToDateTime(txtFechaRetorno.Text).Subtract(Convert.ToDateTime(txtFecha.Text));
                            txvDiasPagar.Text = diasPagados.Days.ToString();
                            break;

                        case 3:
                            txvNoDiasCausados.Text = Convert.ToString(noDiasvaca);
                            txvNoDiasCausados.Enabled = false;
                            txtFechaRetorno.Text = vacaciones.fechaFinalxDiaHabil(Convert.ToDateTime(txtFecha.Text), Convert.ToInt16(Session["empresa"]), Convert.ToInt32(8), Convert.ToInt32(ddlEmpleado.SelectedValue.Trim()));
                            txtFechaRetorno.Text = Convert.ToDateTime(txtFechaRetorno.Text).ToShortDateString();
                            diasPagados = Convert.ToDateTime(Convert.ToDateTime(txtFechaRetorno.Text).AddDays(7).ToShortDateString()).Subtract(Convert.ToDateTime(txtFecha.Text));
                            txvDiasPagar.Text = diasPagados.Days.ToString();
                            break;
                    }
                    if (lblDiasPendientes.Text.Length > 0)
                    {
                        if (Convert.ToInt32(lblDiasPendientes.Text) > 0)
                        {
                            txvNoDiasPendientes.Text = (Convert.ToInt32(lblDiasPendientes.Text) - Convert.ToInt32(txvNoDiasCausados.Text)).ToString();
                            txvValorBase.Text = lblSueldo.Text;
                        }
                        else
                        {
                            txvNoDiasPendientes.Text = (noDiasvaca - Convert.ToInt32(txvNoDiasCausados.Text)).ToString();
                            txvValorBase.Text = lblSueldo.Text;
                        }
                    }
                    else
                    {
                        txvNoDiasPendientes.Text = (noDiasvaca - Convert.ToInt32(txvNoDiasCausados.Text)).ToString();
                        txvValorBase.Text = lblSueldo.Text;
                    }

                    if (Convert.ToInt32(ddlTipoVacaciones.SelectedValue) == 1)
                        txvNoDiasDisfrutados.Text = txvNoDiasCausados.Text;
                    else
                        txvNoDiasDisfrutados.Text = "0";
                }
            }
            else
                txtFecha.Focus();
        }
        catch (Exception ex)
        {
            ManejoError("Error debudo a calcular días habiles debido a: " + ex.Message, "C");
        }
    }
    protected void niCalendarFechaSalida_SelectionChanged(object sender, EventArgs e)
    {
        txtFecha.Text = niCalendarFechaSalida.SelectedDate.ToShortDateString();
        txtFecha.Enabled = false;
        txtFecha.Visible = true;
        niCalendarFechaSalida.Visible = false;

        switch (vacaciones.VerificaFechaVacaciones(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlEmpleado.SelectedValue.Trim()), Convert.ToDateTime(txtFecha.Text)))
        {
            case 1:
                nilblInformacion.Text = "Fecha no valida se encuentra el empleado de vacaciones";
                txtFecha.Text = "";
                txtFecha.Focus();
                return;
            case 2:
                nilblInformacion.Text = "Fecha no valida se encuentra el empleado esta incapacitado";
                txtFecha.Text = "";
                txtFecha.Focus();
                return;
        }
        manejoLiquidaVaca();
    }
    private void manejoVacaciones()
    {
        try
        {
            if (ddlEmpleado.SelectedValue.Trim().Length > 0)
            {
                string[] periodo = vacaciones.cargarPeriodo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim()).Split('-');
                txtPeriodoInicial.Text = periodo[0];
                txtPeriodoFinal.Text = periodo[1];
                txtCodigo.Text = vacaciones.Consecutivo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), Convert.ToDateTime(txtPeriodoInicial.Text), Convert.ToDateTime(txtPeriodoFinal.Text));
                DateTime fechaI = Convert.ToDateTime(txtPeriodoInicial.Text);
                DateTime ahora = DateTime.Now;
                TimeSpan ts = ahora - fechaI;
                int diferenciaDias = ts.Days;
                if (diferenciaDias < 365)
                {
                    ManejoError("aun el empleado no cumple su periodo de vacaciones", "C");
                    nilblInformacion.Text = "aun el empleado no cumple su periodo de vacaciones";
                }
                lblPeriodoVacaciones.Text = fechaI.Year.ToString();
            }
            else
            {
                nilblInformacion.Text = "Por favor seleccione un empleado valido";
                return;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar codigo embargos debido a : " + ex.Message, "C");
        }
    }
    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            switch (vacaciones.VerificaFechaVacaciones(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlEmpleado.SelectedValue.Trim()), Convert.ToDateTime(txtFecha.Text)))
            {
                case 1:
                    nilblInformacion.Text = "Fecha no valida se encuentra el empleado de vacaciones";
                    txtFecha.Text = "";
                    txtFecha.Focus();
                    return;
                case 2:
                    nilblInformacion.Text = "Fecha no valida se encuentra el empleado esta incapacitado";
                    txtFecha.Text = "";
                    txtFecha.Focus();
                    return;
            }
            manejoLiquidaVaca();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar datos de la liquidación debido a: ", "C");
        }
    }

    private void manejoLiquidaVaca()
    {
        nilblInformacion.Text = "";
        try
        {
            Convert.ToDateTime(txtFecha.Text);
            lblPeriodoVacaciones.Text = Convert.ToDateTime(txtPeriodoInicial.Text).Year.ToString();
        }
        catch
        {
            nilblInformacion.Text = "Seleccione una fecha valida";
            return;
        }

        if (Convert.ToDateTime(txtPeriodoInicial.Text) >= Convert.ToDateTime(txtFecha.Text))
        {
            nilblInformacion.Text = "La fecha de salida no puede ser menor al del periodo liquidado";
            txtFecha.Text = "";
            txtFecha.Focus();
            return;
        }
        if (txvNoDiasCausados.Text == "0")
            txvNoDiasCausados.Focus();
        else
        {
            calculaFechaFinal();
            LiquidarBasicos();
            manejoConceptoDetalle();
            totalizar();
        }
    }

    private void manejoConceptoDetalle()
    {
        pnConceptos.Visible = true;
        CcontrolesUsuario.HabilitarControles(pnConceptos.Controls);
        CcontrolesUsuario.LimpiarControles(pnConceptos.Controls);
        txtValorVacaciones.Enabled = false;
    }

    private void LiquidarBasicos()
    {
        try
        {
            if (Convert.ToInt32(ddlTipoVacaciones.SelectedValue) != 2)
            {
                DataView vaca = vacaciones.LiquidaConceptosBasicosVacaciones(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlEmpleado.SelectedValue.Trim()),
                  Convert.ToDateTime(txtFecha.Text), Convert.ToInt32(this.txvDiasPagar.Text), Convert.ToDateTime(txtFecha.Text), Convert.ToDateTime(txtFechaRetorno.Text), Convert.ToDecimal(txvValorBase.Text), Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()), Convert.ToInt32(ddlAño.SelectedValue));
                this.Session["vacaciones"] = vaca;
                gvSaludPension.DataSource = vaca;
                gvSaludPension.DataBind();
                this.Session["liquiConceptosBasicos"] = vaca;
            }
            else
            {
                DataView vaca = vacaciones.LiquidaSoloVacaciones(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlEmpleado.SelectedValue.Trim()),
                Convert.ToDateTime(txtFecha.Text), Convert.ToInt32(this.txvDiasPagar.Text), Convert.ToDateTime(txtFecha.Text), Convert.ToDateTime(txtFechaRetorno.Text), Convert.ToDecimal(txvValorBase.Text));
                this.Session["vacaciones"] = vaca;
                gvSaludPension.DataSource = vaca;
                gvSaludPension.DataBind();
                this.Session["liquiConceptosBasicos"] = vaca;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al liquidar vacaciones debido a: " + ex.Message, "C");
        }
    }


    protected void lbFechaIngreso_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaSalida.Visible = true;
        this.txtFecha.Visible = false;
        this.niCalendarFechaSalida.SelectedDate = Convert.ToDateTime(null);
    }


    protected void ddlEmpleado_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlAño.SelectedValue.Trim().Length > 0 && ddlPeriodo.SelectedValue.Trim().Length > 0)
            {
                manejoNuevo();
                RetornaDatosContrato();
                manejoVacaciones();
                RetornaDatosVacacionesPendientes();
                txvNoDiasCausados.Focus();
                txvNoDiasCausados.Enabled = true;
            }
            else
            {
                nilblInformacion.Text = "Debe seleccionar un año y periodo valido";
                return;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al carga datos del empleado debido a" + ex.Message, "C");
        }
    }

    protected void txvNoDiasCausados_TextChanged(object sender, EventArgs e)
    {
        nilblInformacion.Text = "";
        calculaFechaFinal();
        if (txtFecha.Text.Length > 0)
        {
            LiquidarBasicos();
            manejoConceptoDetalle();
            totalizar();
        }
    }
    private void totalizar()
    {
        decimal total = 0;

        foreach (GridViewRow gvp in gvSaludPension.Rows)
        {
            total += Convert.ToDecimal(gvp.Cells[4].Text) * Convert.ToDecimal(gvp.Cells[5].Text + "1");
        }
        txtValorVacaciones.Text = total.ToString();
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        try
        {
            bool ejectudado = false;

            foreach (Control c in gvLista.Rows[e.RowIndex].Cells[15].Controls)
            {
                if (c is CheckBox)
                    ejectudado = ((CheckBox)c).Checked;
            }

            if (ejectudado == true)
            {
                nilblInformacion.Text = "Registro ejecutado no se puede anular la transacción";
                return;
            }
            else
            {
                switch (vacaciones.verificaVacacionesLiquidadas(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(gvLista.Rows[e.RowIndex].Cells[8].Text),Convert.ToDateTime(gvLista.Rows[e.RowIndex].Cells[1].Text), Convert.ToDateTime(gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt32(gvLista.Rows[e.RowIndex].Cells[18].Text), this.Session["usuario"].ToString()))
                {
                    case 0:
                        switch (vacaciones.AnulaVacaciones(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(gvLista.Rows[e.RowIndex].Cells[8].Text), Convert.ToDateTime(gvLista.Rows[e.RowIndex].Cells[1].Text), Convert.ToDateTime(gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt32(gvLista.Rows[e.RowIndex].Cells[18].Text), this.Session["usuario"].ToString()))
                        {
                            case 0:
                                nilblInformacion.Text = "Registro anulado con exito";
                                break;
                            case 1:
                                nilblInformacion.Text = "Error al anular el registro";
                                break;
                        }
                        break;
                    case 1:
                        nilblInformacion.Text = "Vacación liquidada no es posible su anulación";
                        break;
                }

                
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al anular registro debido a: " + ex.Message, "I");
        }
    }

    protected void gvSaludPension_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            string concepto = gvSaludPension.Rows[e.RowIndex].Cells[1].Text.Trim();
            DataView dvVacaciones = (DataView)this.Session["vacaciones"];
            foreach (DataRowView dtv in dvVacaciones)
            {
                if (dtv.Row.ItemArray.GetValue(0).ToString() == concepto)
                    dtv.Row.Delete();
            }

            gvSaludPension.DataSource = dvVacaciones;
            gvSaludPension.DataBind();
            this.Session["vacaciones"] = dvVacaciones;
            totalizar();
        }

        catch (Exception ex)
        {
            ManejoError("Error al eliminar borrar la fila debido a : " + ex.Message, "E");
        }
    }

    protected void gvLista_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }


    protected void ddlTipoVacaciones_SelectedIndexChanged(object sender, EventArgs e)
    {
        txvNoDiasCausados.Enabled = true;
        if (txtFecha.Text.Length > 0)
            manejoLiquidaVaca();
    }

    protected void chkLiquiNomina_CheckedChanged(object sender, EventArgs e)
    {
        DataView dvVacaciones = (DataView)this.Session["vacaciones"];
        if (chkLiquiNomina.Checked == true)
        {
            foreach (DataRowView dtv in dvVacaciones)
            {
                if (Convert.ToBoolean(dtv.Row.ItemArray.GetValue(6)) == true)
                    dtv.Row.Delete();
                gvSaludPension.DataSource = dvVacaciones;
                gvSaludPension.DataBind();
                this.Session["vacaciones"] = dvVacaciones;
            }
        }
        else
            manejoLiquidaVaca();
        totalizar();
    }

    protected void ddlAño_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length > 0)
        {
            cargarPeriodos();
        }
    }


    protected void gvLista_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        try
        {

            bool ejectudado = false;

            foreach (Control c in gvLista.Rows[e.RowIndex].Cells[16].Controls)
            {
                if (c is CheckBox)
                    ejectudado = ((CheckBox)c).Checked;
            }

            if (ejectudado == true)
            {
                nilblInformacion.Text = "Registro anulado no se puede imprimir la transacción";
                return;
            }
             
            string periodoInicial =   gvLista.Rows[e.RowIndex].Cells[1].Text;
            string periodoFinal =   gvLista.Rows[e.RowIndex].Cells[2].Text;
            string empleado = gvLista.Rows[e.RowIndex].Cells[8].Text;
            string registro = gvLista.Rows[e.RowIndex].Cells[18].Text;


            string script = "<script language='javascript'>" +
                         "Visualizacion('VacacionesxEmpleado','" + periodoInicial + "','" + periodoFinal + "'," + empleado + ","+registro+");" +
                         "</script>";
            Page.RegisterStartupScript("Visualizacion", script);
        

        }
        catch (Exception ex)
        {
            ManejoError("Error al imprimir debido a:    " + ex.Message,"C");
        }


    }

    #endregion Eventos


}
