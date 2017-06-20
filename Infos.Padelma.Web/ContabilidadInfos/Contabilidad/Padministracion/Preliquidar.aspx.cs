using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_Liquidacion : System.Web.UI.Page
{

    #region Instancias


    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    //Coperadores operadores = new Coperadores();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    //CtransaccionNovedad transaccionNovedad = new CtransaccionNovedad();
    Cperiodos periodo = new Cperiodos();
    string numerotransaccion = "";
    //Ctransacciones transacciones = new Ctransacciones();
    //CliquidacionNomina liquidacion = new CliquidacionNomina();
    Cgeneral general = new Cgeneral();
    //Cfuncionarios funcionario = new Cfuncionarios();
    Ccontabilizacion contabilizacion = new Ccontabilizacion();

    #endregion Instancias

    #region Metodos

    private void manejoTipo()
    {

        if (ddlTipo.SelectedValue.Trim() == "SS")
        {
            try
            {
                this.ddlPeriodo.DataSource = periodo.PeriodosSeguridadSocial(Convert.ToInt32(ddlA�o.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
                this.ddlPeriodo.DataValueField = "mes";
                this.ddlPeriodo.DataTextField = "nombreMes";
                this.ddlPeriodo.DataBind();
                this.ddlPeriodo.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar periodo inicial. Correspondiente a: " + ex.Message, "C");
            }
        }
    }

    private void Preliquidar()
    {
        string script = "", nombreTercero = "";
        int retorno = 0;
        retorno = contabilizacion.PrecontabilizaNominaTipoPeriodo(Convert.ToInt32(ddlA�o.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()), ddlTipo.SelectedValue.Trim(), Convert.ToInt16(Session["empresa"]), Convert.ToDateTime(txtFecha.Text), this.Session["usuario"].ToString(), ddlEmpleado.SelectedValue.Trim());
        switch (retorno)
        {
            case 1:
                script = @"<script type='text/javascript'>
                            alerta('Error al generar preliquidacion');
                        </script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case 2:
                script = @"<script type='text/javascript'>
                            alerta('El periodo ya fue contabilizado');
                        </script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case 0:

                   script = "<script language='javascript'>Visualizacion('Precontabilizacion', '"+ddlA�o.SelectedValue.ToString()+"','"+ ddlPeriodo.SelectedValue.Trim()+"','"+ ddlTipo.SelectedValue.Trim()+"');</script>";
                Page.RegisterStartupScript("Visualizacion", script);

                script = "<script language='javascript'>VisualizacionResumen('ResumenPrecontabilizacion', '" + ddlA�o.SelectedValue.ToString() + "','" + ddlPeriodo.SelectedValue.Trim() + "','" + ddlTipo.SelectedValue.Trim() + "');</script>";
                 Page.RegisterStartupScript("VisualizacionResumen", script);

                this.nilblMensaje.Text = "Generado con exito";
                break;
        }
    }

    private void CargarEmpleados()
    {
        try
        {
            //DataView dvTerceroCCosto = funcionario.RetornaFuncionarioCcosto(ddlccosto.SelectedValue.ToString(), Convert.ToInt16(Session["empresa"]));
            //this.ddlEmpleado.DataSource = dvTerceroCCosto;
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
        if (ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlA�o.SelectedValue.Trim().Length > 0)
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
            this.ddlPeriodo.DataSource = periodo.PeriodosCeradoNominaA�o(Convert.ToInt32(ddlA�o.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"]), ddlTipo.SelectedValue.Trim()).Tables[0].DefaultView;
            this.ddlPeriodo.DataValueField = "noPeriodo";
            this.ddlPeriodo.DataTextField = "descripcion";
            this.ddlPeriodo.DataBind();
            this.ddlPeriodo.Items.Insert(0, new ListItem("", ""));
            manejoTipo();
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

        this.Response.Redirect("~/Contabilidad/Error.aspx", false);
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
            this.ddlA�o.DataSource = periodo.PeriodoA�oCerradoNomina(Convert.ToInt16(Session["empresa"]));
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
                    ddlEmpleado.Visible = false;
                    lblEmpleado.Visible = false;
                    CargarCombos();
                    this.Session["editar"] = null;
                    this.nilblInformacion.Text = "";
                    this.txtFecha.Focus();
                    //manejoOpcionLiquidacion();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
            }
        }
    }


    #endregion Eventos

    #region MetodosFuncionario




    #endregion MetodosFuncionario

    #region EventosFuncionario

    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToString();
        this.txtFecha.Enabled = false;


        //if (periodo.RetornaPeriodoCerradoNomina((Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year)),
        //    Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), Convert.ToInt16(Session["empresa"]), niCalendarFecha.SelectedDate) == 1)
        //{
        //    ManejoError("Periodo cerrado de nomina. No es posible realizar s", "I");
        //    return;
        //}

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


    protected void ddlA�o_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlA�o.SelectedValue.Trim().Length > 0)
        {
            cargarPeriodos();
            manejoLiquidacion();
        }
    }


    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            manejoLiquidacion();

            if (ddlTipo.SelectedValue.Trim() == "PS")
            {
                this.ddlEmpleado.Visible = true;
                this.lblEmpleado.Visible = true;
                this.ddlEmpleado.DataSource = contabilizacion.RetornaEmpleadosLiquidacionContratos(Convert.ToInt32(this.Session["empresa"]), Convert.ToInt32(ddlA�o.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()));
                this.ddlEmpleado.DataValueField = "numero";
                this.ddlEmpleado.DataTextField = "cadena";
                this.ddlEmpleado.DataBind();
                this.ddlEmpleado.Items.Insert(0, new ListItem("", ""));

            }
            else
            {
                this.ddlEmpleado.Visible = false;
                this.lblEmpleado.Visible = false;
                this.ddlEmpleado.DataSource = null;
                this.ddlEmpleado.DataBind();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleado debido a: " + ex.Message,"C");
        }
    }

    protected void lbPreLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            nilblInformacion.Text = "";
            nilblMensaje.Text = "";
            if (txtFecha.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una fecha para guardar liquidaci�n";
                txtFecha.Focus();
                return;
            }

            if (ddlA�o.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un a�o para guardar liquidaci�n";
                ddlA�o.Focus();
                return;
            }

            if (ddlA�o.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una forma de liquidaci�n para seguir";
                txtFecha.Focus();
                return;
            }


            //if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            //{
            //    nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
            //    ddlEmpleado.Focus();
            //    return;
            //}

            Preliquidar();
        }
        catch (Exception ex)
        {
            ManejoError("Error al liquidar el documento debido a :" + ex.Message, "I");
        }
    }


    protected void btnLiquidar_Click(object sender, ImageClickEventArgs e)
    {

    }

    #endregion EventosFuncionario



    protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
