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
        liquidacion.LiquidacionNomina(Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"]), ddlccosto.SelectedValue.Trim(), ddlEmpleado.SelectedValue.Trim(), Convert.ToInt32(Convert.ToDateTime(txtFecha.Text).Month), Convert.ToDateTime(txtFecha.Text), Convert.ToInt32(ddlOpcionLiquidacion.SelectedValue), out retorno, out nombreTercero);
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
            case 55:
                script = @"<script type='text/javascript'>
                            alerta('El etrabajado " + nombreTercero + " se le vencio el contrato, por favor ingrese una prorroga para su liquidación ');</script>";

                if (!Page.IsClientScriptBlockRegistered("alerta"))
                    Page.RegisterStartupScript("alerta", script);
                break;

            case 20:
                script = "<script language='javascript'>Visualizacion('Preliquidacion');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
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
            DataView dvTerceroCCosto = funcionario.RetornaFuncionarioCcosto(ddlccosto.SelectedValue.ToString(), Convert.ToInt16(Session["empresa"]));
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
        if (ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlAño.SelectedValue.Trim().Length > 0)
        {
            lbPreLiquidar.Visible = true;
        }
        else
        {
            lbPreLiquidar.Visible = false;
        }
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

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

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
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
             ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {

                if (!IsPostBack)
                {
                    CcontrolesUsuario.HabilitarControles(this.Page.Controls);
                    CcontrolesUsuario.LimpiarControles(Page.Controls);
                    CargarCombos();
                    this.Session["editar"] = null;
                    this.nilblInformacion.Text = "";
                    this.txtFecha.Focus();
                    manejoOpcionLiquidacion();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }


    #endregion Eventos

    #region MetodosFuncionario




    #endregion MetodosFuncionario

    #region EventosFuncionario

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
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToString();
        this.txtFecha.Enabled = false;


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


    protected void ddlAño_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length > 0)
        {
            cargarPeriodos();
            manejoLiquidacion();
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

    #endregion EventosFuncionario


}
