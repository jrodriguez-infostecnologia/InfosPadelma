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
    Coperadores operadores = new Coperadores();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    CtransaccionNovedad transaccionNovedad = new CtransaccionNovedad();
    Cperiodos periodo = new Cperiodos();
    string numerotransaccion = "";
    Ctransacciones transacciones = new Ctransacciones();
    CliquidacionNomina liquidacion = new CliquidacionNomina();
    Cgeneral general = new Cgeneral();
    Cfuncionarios funcionario = new Cfuncionarios();

    #endregion Instancias

    #region Metodos
    private void Preliquidar()
    {
        string script = "", nombreTercero = "";
        int retorno = 0;
        liquidacion.LiquidacionCesantias(Convert.ToInt32(ddlAñoDesde.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"]),
            ddlccosto.SelectedValue.Trim(), ddlEmpleado.SelectedValue.Trim(), Convert.ToDateTime(txtFecha.Text), Convert.ToInt32(ddlOpcionLiquidacion.SelectedValue), chkSueldoActual.Checked,out retorno);
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
                            alerta('NO existen conceptos fijos parametrizados');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("", script);
                break;

            case 3:
                script = @"<script type='text/javascript'>
                            alerta('No existen parametros generales de nomina para esta empresa');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;

            case 4:
                script = @"<script type='text/javascript'>
                            alerta('Existen centros de costo no parametrizados para este tipo de liquidación ');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;

            case 20:
                script = "<script language='javascript'>Visualizacion('PreLiquidacionCesantias');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case 55:
                script = @"<script type='text/javascript'>
                            alerta('El etrabajado " + nombreTercero + " se le vencio el contrato, por favor ingrese una prorroga para su liquidación ');</script>";
                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;
        }

        if (retorno >= 1 & retorno <= 4)
        {
            switch (liquidacion.DeleteTmpLiquidacion(Convert.ToInt16(Session["empresa"])))
            {

                case 0:
                    nilblInformacion.Text = "Datos temporales de la liquidacion borrados";
                    if (!Page.IsClientScriptBlockRegistered("alerta"))
                        Page.RegisterStartupScript("alerta", script);
                    break;

                case 1:
                    nilblInformacion.Text = "Error al eliminar datos temporales de la liquidacion";


                    if (!Page.IsClientScriptBlockRegistered("alerta"))
                        Page.RegisterStartupScript("alerta", script);
                    break;
            }
        }
    }
    private void cargarCentroCosto(bool auxiliar)
    {
        try
        {
            this.ddlccosto.DataSource = general.CentroCosto(auxiliar, Convert.ToInt16(Session["empresa"]));
            this.ddlccosto.DataValueField = "codigo";
            this.ddlccosto.DataTextField = "descripcion";
            this.ddlccosto.DataBind();
            this.ddlccosto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los centros de costo. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void Liquidar()
    {
        string script = "", nombreTercero = "", numeroTransaccion = "";
        int retorno = 0;
        liquidacion.LiquidacionCesantiasDefinitiva(Convert.ToInt32(ddlAñoPago.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodoPago.SelectedValue.Trim()), Convert.ToInt32(ddlAñoDesde.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"]),
            ddlccosto.SelectedValue.Trim(), ddlEmpleado.SelectedValue.Trim(), Convert.ToDateTime(txtFecha.Text), Convert.ToInt32(ddlOpcionLiquidacion.SelectedValue),
            ConfigurationManager.AppSettings["TipoTransaccionCesa"].ToString(), Session["usuario"].ToString(), txtObservacion.Text,chkSueldoActual.Checked, out retorno, out numeroTransaccion);
        switch (retorno)
        {
            case 5:
                script = @"<script type='text/javascript'>
                            alerta('El periodo ya tiene primas liquidadas, por favor corrija');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;

            case 2:
                script = @"<script type='text/javascript'>
                            alerta('NO existen conceptos fijos parametrizados');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("", script);
                break;

            case 3:
                script = @"<script type='text/javascript'>
                            alerta('No existen parametros generales de nomina para esta empresa');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;

            case 4:
                script = @"<script type='text/javascript'>
                            alerta('Existen centros de costo no parametrizados para este tipo de liquidación ');
                        </script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;

            case 20:
                ManejoExito("Liquidación de primas realizadas satisfactoriamente.", "I");
                script = "<script language='javascript'>VisualizacionLiquidacion('LiquidacionCesantias','" + Convert.ToString(ddlAñoDesde.SelectedValue.Trim()) + "','" + numeroTransaccion + "');</script>";
                Page.RegisterStartupScript("VisualizacionLiquidacion", script);
                break;
            case 55:
                script = @"<script type='text/javascript'>
                            alerta('El etrabajado " + nombreTercero + " se le vencio el contrato, por favor ingrese una prorroga para su liquidación ');</script>";
                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;
        }

        if (retorno >= 1 & retorno <= 4)
        {
            switch (liquidacion.DeleteTmpLiquidacion(Convert.ToInt16(Session["empresa"])))
            {

                case 0:
                    nilblInformacion.Text = "Datos temporales de la liquidacion borrados";
                    if (!Page.IsClientScriptBlockRegistered("alerta"))
                        Page.RegisterStartupScript("alerta", script);
                    break;

                case 1:
                    nilblInformacion.Text = "Error al eliminar datos temporales de la liquidacion";


                    if (!Page.IsClientScriptBlockRegistered("alerta"))
                        Page.RegisterStartupScript("alerta", script);
                    break;
            }
        }
    }
    private void CargarEmpleados()
    {
        try
        {
            DataView dvTerceroCCosto = funcionario.RetornaFuncionarioCcosto(ddlccosto.SelectedValue, Convert.ToInt16(Session["empresa"]));
            this.ddlEmpleado.DataSource = dvTerceroCCosto;
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
    private void manejoLiquidacion()
    {
    }

    protected void cargarPeriodos()
    {



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

            this.gvLista.DataSource = liquidacion.BuscarEntidadPrima(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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

        seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              operacion,
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er",
              error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

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
            this.ddlAñoDesde.DataSource = periodo.PeriodoAñoAbiertoNomina(Convert.ToInt16(Session["empresa"]));
            this.ddlAñoDesde.DataValueField = "año";
            this.ddlAñoDesde.DataTextField = "año";
            this.ddlAñoDesde.DataBind();
            this.ddlAñoDesde.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }

       
    }
    private void EntidadKey()
    {
        object[] objKey = new object[] { ""
            //ddlAño.SelectedValue, ddlCentroCosto.SelectedValue, Convert.ToInt16(Session["empresa"]), ddlMes.SelectedValue, ddlPeriodo.SelectedValue
        };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "nConceptosFijos",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Ya se encuentra registrada la combinación";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

                this.nilbNuevo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }
    private void Guardar()
    {
        string operacion = "inserta";
        bool verificaEncabezado = false;
        bool verificaDetalle = false;
        bool verificaBascula = false;

        try
        {

            using (TransactionScope ts = new TransactionScope())
            {
                DateTime fecha = Convert.ToDateTime(txtFecha.Text);

                string conceptos = null, empleado = null, ccosto = null;
                string remision = null;

                int mes = liquidacion.RetornaMesPeriodoNomina(Convert.ToInt32(ddlAñoDesde.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodoPago.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"]));

                if (mes == 14)
                {
                    nilblInformacion.Text = "Error de parametro en el periodo por favor verificar periodos de nomina";
                    return;
                }

                numerotransaccion = ConsecutivoTransaccion();

                this.Session["numerotransaccion"] = numerotransaccion;



                object[] objValo = new object[]{   
                                        false,    //@anulado	bit
                                       Convert.ToInt32(ddlAñoDesde.SelectedValue),     //@año	int
                                        false,    //@cerrado	bit
                                        Convert.ToInt16(Session["empresa"]),    //@empresa	int
                                        0,    //@estado	int
                                        Convert.ToDateTime(txtFecha.Text),  //@fecha	datetime
                                          DateTime.Now,  //@fechaRegistro	datetime
                                          mes,  //@mes	int
                                         numerotransaccion,   //@numero	varchar
                                         txtObservacion.Text,
                                            "",   //@tipo	varchar
                                         this.Session["usuario"].ToString(),   //@usuario	varchar
                                         null   //@usuarioAnulado	bit                                                    
                              };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nLiquidacionNomina", operacion, "ppa", objValo))
                {
                    case 0:

                        break;

                    case 1:
                        ManejoError("Error al insertar el detalle de la transaccción", "I");
                        break;
                }

                if (verificaEncabezado == false & verificaDetalle == false & verificaBascula == false)
                {
                    transacciones.ActualizaConsecutivo(ConfigurationManager.AppSettings["TipoTransaccionNomina"].ToString(), Convert.ToInt16(Session["empresa"]));
                    ts.Complete();
                    ManejoExito("Datos registrados satisfactoriamente. Transacción número " + numerotransaccion, "I");
                }

            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }
    }

    private string ConsecutivoTransaccion()
    {
        string numero = "";

        try
        {
            numero = transacciones.RetornaNumeroTransaccion(ConfigurationManager.AppSettings["TipoTransaccionNomina"].ToString(), Convert.ToInt16(Session["empresa"]));
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
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
             ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
            }
            else
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
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = null;
        this.nilblInformacion.Text = "";
        this.txtFecha.Focus();
        ddlAñoPago.Visible = false;
        ddlPeriodoPago.Visible = false;
        lblañoPago.Visible = false;
        lblPeriodoPago.Visible = false;
        manejoOpcionLiquidacion();
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.Session["editar"] = null;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (liquidacion.VerificaTmpLiquidacion(Convert.ToInt16(Session["empresa"])) == 1)
        {

            if (Convert.ToBoolean(Session["editar"]) == false)
                Guardar();
        }
        else
        {
            nilblInformacion.Text = "Operación no realizada no existen registros de prenomina para registrar";
            return;
        }


    }

    protected void nilblListado_Click(object sender, EventArgs e)
    {
        Response.Redirect("ListadoDestinos.aspx");
    }


    protected void txtCodigo_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void nilbRegresar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("Programacion.aspx");
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
    }


    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToShortDateString();


        if (periodo.RetornaPeriodoCerradoNomina((Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year)),
            Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), Convert.ToInt16(Session["empresa"]), niCalendarFecha.SelectedDate) == 1)
        {
            ManejoError("Periodo cerrado de nomina. No es posible realizar s", "I");
            return;
        }
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


        if (periodo.RetornaPeriodoCerradoNomina((Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year)),
            Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), Convert.ToInt16(Session["empresa"]), Convert.ToDateTime(txtFecha.Text)) == 1)
        {
            ManejoError("Periodo cerrado de nomina. No es posible realizar s", "I");
            return;
        }
    }


  


    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoLiquidacion();
    }

    protected void ddlOpcionLiquidacion_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoOpcionLiquidacion();
    }

    private void manejoOpcionLiquidacion()
    {
        switch (Convert.ToInt16(ddlOpcionLiquidacion.SelectedValue))
        {
            case 1:
                lblCcosto.Visible = false;
                lblEmpleado.Visible = false;
                ddlccosto.Visible = false;
                ddlEmpleado.Visible = false;
                break;

            case 2:
                cargarCentroCosto(true);
                lblCcosto.Text = "Centro costo";
                ddlccosto.Visible = true;
                ddlccosto.Enabled = true;
                ddlEmpleado.Visible = false;
                lblCcosto.Visible = true;
                lblEmpleado.Visible = false;
                ddlccosto.SelectedValue = "";
                break;
            case 3:
                cargarCentroCosto(true);
                lblCcosto.Text = "Centro costo";
                ddlccosto.Visible = true;
                ddlEmpleado.Visible = true;
                ddlccosto.SelectedValue = "";
                ddlEmpleado.SelectedValue = "";
                ddlccosto.Enabled = true;
                ddlEmpleado.Enabled = true;
                lblCcosto.Visible = true;
                lblEmpleado.Visible = true;
                break;
            case 4:
                cargarCentroCosto(false);
                lblCcosto.Text = "Mayor centro costo";
                ddlccosto.Visible = true;
                ddlEmpleado.Visible = false;
                ddlccosto.SelectedValue = "";
                ddlEmpleado.SelectedValue = "";
                ddlccosto.Enabled = true;
                ddlEmpleado.Enabled = false;
                lblCcosto.Visible = true;
                lblEmpleado.Visible = false;

                break;
        }
    }



    protected void ddlccosto_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt16(ddlOpcionLiquidacion.SelectedValue.Trim()) == 3)
            CargarEmpleados();
        else
        {
            ddlEmpleado.DataSource = null;
            ddlEmpleado.DataBind();
            ddlEmpleado.Visible = false;
        }
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

            if (ddlAñoDesde.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un año para guardar liquidación";
                ddlAñoDesde.Focus();
                return;
            }

            if (ddlAñoDesde.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una forma de liquidación para seguir";
                txtFecha.Focus();
                return;
            }

            if (ddlccosto.SelectedValue.Trim().Length == 0 & ddlccosto.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlccosto.Focus();
                return;
            }


            if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlEmpleado.Focus();
                return;
            }

            Preliquidar();
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
            if (txtFecha.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una fecha para guardar liquidación";
                txtFecha.Focus();
                return;
            }

            if (ddlAñoDesde.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un año para guardar liquidación";
                ddlAñoDesde.Focus();
                return;
            }

            if (ddlAñoDesde.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una forma de liquidación para seguir";
                txtFecha.Focus();
                return;
            }

            if (ddlccosto.SelectedValue.Trim().Length == 0 & ddlccosto.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlccosto.Focus();
                return;
            }


            if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlEmpleado.Focus();
                return;
            }

            if (chkPagaNomina.Checked == false)
            {
                nilblInformacion.Text = "Debe chequear un periodo de pago";
                return;
            }

            if (ddlAñoPago.SelectedValue.Trim().Length == 0 || ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un año y periodo de pago";
                return;
            }


            Liquidar();

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
    protected void chkPagaNomina_CheckedChanged(object sender, EventArgs e)
    {
        if (chkPagaNomina.Checked)
        {
            ddlAñoPago.Visible = true;
            ddlPeriodoPago.Visible = true;
            lblañoPago.Visible = true;
            lblPeriodoPago.Visible = true;

            try
            {
                this.ddlAñoPago.DataSource = periodo.PeriodoAñoAbiertoNomina(Convert.ToInt16(Session["empresa"]));
                this.ddlAñoPago.DataValueField = "año";
                this.ddlAñoPago.DataTextField = "año";
                this.ddlAñoPago.DataBind();
                this.ddlAñoPago.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar año de pago. Correspondiente a: " + ex.Message, "C");
            }


        }
        else
        {
            ddlAñoPago.Visible = false;
            ddlPeriodoPago.Visible = false;
            lblañoPago.Visible = false;
            lblPeriodoPago.Visible = false;
        }
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.nilblMensaje.Text = "";
        using (TransactionScope ts = new TransactionScope())
        {
            try
            {
                if (transacciones.VerificaEdicionBorrado(this.gvLista.Rows[e.RowIndex].Cells[1].Text, this.gvLista.Rows[e.RowIndex].Cells[2].Text, Convert.ToInt16(Session["empresa"])) != 0)
                {
                    this.nilblMensaje.Text = "Transacción ejecutada / anulada no es posible su edición";
                    return;
                }

                switch (transacciones.AnulaLiquidacionPrima(this.gvLista.Rows[e.RowIndex].Cells[1].Text, this.gvLista.Rows[e.RowIndex].Cells[2].Text, this.Session["usuario"].ToString().Trim(), Convert.ToInt16(Session["empresa"]),
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
    protected void ddlAñoPago_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAñoPago.SelectedValue.Trim().Length > 0)
        {
            try
            {
                this.ddlPeriodoPago.DataSource = periodo.PeriodosAbiertoNominaAño(Convert.ToInt32(ddlAñoDesde.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
                this.ddlPeriodoPago.DataValueField = "noPeriodo";
                this.ddlPeriodoPago.DataTextField = "descripcion";
                this.ddlPeriodoPago.DataBind();
                this.ddlPeriodoPago.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar periodo pago. Correspondiente a: " + ex.Message, "C");
            }
        }
    }
  
}
