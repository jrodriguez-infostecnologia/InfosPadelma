using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using System.Data;

public partial class Nomina_PLiquidacion_Prestamo : System.Web.UI.Page
{
    #region Instancias


    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cprestamo prestamo = new Cprestamo();
    Cperiodos periodo = new Cperiodos();
    Cfuncionarios funcionario = new Cfuncionarios();
    Cgeneral general = new Cgeneral();
    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }
    private void verificaPeriodoCerrado(int año, int mes, int empresa, DateTime fecha)
    {
        if (periodo.RetornaPeriodoCerradoNomina(año, mes, empresa, fecha) == 1)
        {
            ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
        }

    }
    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }
            upCabeza.Visible = false;
            this.gvLista.DataSource = prestamo.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
                this.Session["usuario"].ToString(), "C",
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
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

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "er",
            error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        CcontrolesUsuario.InhabilitarControles(this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(this.upCabeza.Controls);

        Session["rangos"] = null;
        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }
    private void CargarCombos()
    {

        try
        {
            DataView ccosto = general.CentroCosto(true, Convert.ToInt16(Session["empresa"]));
            this.ddlCentroCosto.DataSource = ccosto;
            this.ddlCentroCosto.DataValueField = "codigo";
            this.ddlCentroCosto.DataTextField = "descripcion";
            this.ddlCentroCosto.DataBind();
            this.ddlCentroCosto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los centros de costo. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView dvTerceroCCosto = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nFuncionario", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            //  dvTerceroCCosto.RowFilter = "ccosto = '" + ddlCentroCosto.SelectedValue.ToString() + "'";
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


        try
        {
            DataView dvConceptosFijos = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            dvConceptosFijos.RowFilter = "ControlaSaldo=True and empresa =" + Convert.ToInt16(this.Session["empresa"]).ToString();
            this.ddlConcepto.DataSource = dvConceptosFijos;
            this.ddlConcepto.DataValueField = "codigo";
            this.ddlConcepto.DataTextField = "descripcion";
            this.ddlConcepto.DataBind();
            this.ddlConcepto.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar finca. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlFormaPago.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("gFormaPago", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlFormaPago.DataValueField = "codigo";
            this.ddlFormaPago.DataTextField = "descripcion";
            this.ddlFormaPago.DataBind();
            this.ddlFormaPago.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar forma de pago. Correspondiente a: " + ex.Message, "C");
        }



    }
    //protected void cargarPeriodo()
    //{
    //    try
    //    {
    //        this.ddlPeriodoInicial.DataSource = periodo.PeriodosAbiertoNominaAño(Convert.ToInt16(niCalendarFecha.SelectedDate.Year), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
    //        this.ddlPeriodoInicial.DataValueField = "noPeriodo";
    //        this.ddlPeriodoInicial.DataTextField = "descripcion";
    //        this.ddlPeriodoInicial.DataBind();
    //        this.ddlPeriodoInicial.Items.Insert(0, new ListItem("", ""));
    //    }
    //    catch (Exception ex)
    //    {
    //        ManejoError("Error al cargar periodo inicial. Correspondiente a: " + ex.Message, "C");
    //    }
    //}
    private void CargarEmpleados()
    {
        try
        {
            DataView dvTerceroCCosto = funcionario.RetornaFuncionarioCcosto(ddlCentroCosto.SelectedValue, Convert.ToInt16(Session["empresa"]));
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
    private void Guardar()
    {
        string operacion = "inserta";

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";

            }
            else
            {
                Consecutivo();
            }

            object[] objValores = new object[]{
                     Convert.ToDateTime(txtFecha.Text ).Year ,  //                @año	int
                      ddlCentroCosto.SelectedValue,          //@ccosto	varchar
                        txtCodigo.Text,         //@codigo	varchar
                         ddlConcepto.SelectedValue,        //@concepto	varchar
                         Convert.ToDecimal(txvCuotas.Text),       //@cuotas	int
                         Convert.ToDecimal(txvCuotasPendiente.Text),       //@cuotasPendiente	int
                         txtDocRef.Text,       //@docRef	varchar
                         Convert.ToInt32(ddlEmpleado.SelectedValue.Trim() ),     //@empleado	int                                
                  Convert.ToInt16(Session["empresa"]),      //@empresa	int
                        Convert.ToDateTime(txtFecha.Text ),        //@fecha	date
                           DateTime.Now,       //@fechaRegistro	datetime
                           ddlFormaPago.SelectedValue,     //@formaPago	varchar                                            
                  Convert.ToDecimal(ddlFrecuencia.SelectedValue),    //@frecuencia	int
                          false,       //@liquidado	bit
                          Convert.ToDateTime(txtFecha.Text ).Month,     //@mes	int
                              txtObservacion.Text,      //@observacion	varchar
                               Convert.ToDecimal(txvPeriodoInicial.Text), //@periodoInicial	int
                             Session["usuario"].ToString(),   //@usuarioRegistro	varchar
                               Convert.ToDecimal(txvValor.Text),  //@valor	money
                             Convert.ToDecimal(txvValorCuota.Text),   //@valorCuotas	money
                              Convert.ToDecimal(txvSaldo.Text)      //@valorSaldo	money
                                
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "nPrestamo",
                operacion,
                "ppa",
                objValores))
            {
                case 0:
                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                    break;

                case 1:

                    ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
            }


        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }
    }
    private void Consecutivo()
    {
        try
        {
            this.txtCodigo.Text = prestamo.Consecutivo(Convert.ToInt16(Session["empresa"]));
            txtCodigo.Enabled = false;
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el consecutivo. Correspondiente a: " + ex.Message, "C");
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
                this.txtCodigo.Focus();

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }
    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                             ConfigurationManager.AppSettings["Modulo"].ToString(),
                              nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        upCabeza.Visible = true;
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        CcontrolesUsuario.HabilitarControles(upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(upCabeza.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        Session["rangos"] = null;
        Session["rangoFinal"] = null;

        CargarCombos();
        Consecutivo();

        this.nilblInformacion.Text = "";
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        CcontrolesUsuario.HabilitarControles(upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(upCabeza.Controls);
        upCabeza.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";

    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            bool liquidado = false;

            foreach (Control objControl in this.gvLista.Rows[e.RowIndex].Cells[2].Controls)
            {
                if (objControl is CheckBox)
                {
                    liquidado = ((CheckBox)objControl).Checked;
                }
            }

            if (liquidado == false)
            {

                object[] objValores = new object[] {
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToInt16(Session["empresa"])
            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "nPrestamo",
                    "elimina",
                    "ppa",
                    objValores))
                {
                    case 0:

                        ManejoExito("Registro eliminado satisfactoriamente", "E");
                        break;

                    case 1:

                        ManejoError("Error al eliminar el registro. Operación no realizada", "E");
                        break;
                }
            }
            else
            {
                nilblInformacion.Text = "El registro no puede ser eliminado, ya fue liquidado";
            }
        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro.", "E");
            }
            else
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        if (txtCodigo.Text.Trim().ToString().Length == 0 || ddlConcepto.SelectedValue.Length == 0 || ddlEmpleado.SelectedValue.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

        if (Convert.ToDecimal(txvCuotas.Text) == 0 || Convert.ToDecimal(txvValor.Text) == 0 || Convert.ToDecimal(txvValorCuota.Text) == 0)
        {
            nilblMensaje.Text = "Campos en cero (0), por favor corrija";
            return;
        }
        Guardar();
    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
         ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(),
         "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        upCabeza.Visible = true;
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.HabilitarControles(this.upCabeza.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.txtCodigo.Enabled = false;
        ddlEmpleado.Enabled = false;
        ddlCentroCosto.Enabled = false;
        ddlConcepto.Enabled = false;
        lbFecha.Enabled = false;

        CargarCombos();


        try
        {


            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            else
                this.txtCodigo.Text = "";

            DataView dvPrestamos = prestamo.RetornaDatosPrestamo(txtCodigo.Text.Trim(), Convert.ToInt16(Session["empresa"]));

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {

                niCalendarFecha.SelectedDate = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text));
                txtFecha.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
                niCalendarFecha.Visible = false;
            }


            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.ddlConcepto.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);

            //cargarPeriodo();

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                this.ddlEmpleado.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);
            else
                this.ddlEmpleado.SelectedValue = "";

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.txvValor.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
            else
                this.txvValor.Text = "0";

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                this.txvCuotas.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);
            else
                this.txvCuotas.Text = "0";

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                this.txvValorCuota.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[10].Text);
            else
                this.txvValorCuota.Text = "0";

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                this.txvCuotasPendiente.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[11].Text);
            else
                this.txvCuotasPendiente.Text = "0";

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
                this.txvSaldo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[12].Text);
            else
                this.txvSaldo.Text = "0";


            bool liquidado = false;
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[13].Controls)
            {
                if (objControl is CheckBox)
                {
                    liquidado = ((CheckBox)objControl).Checked;
                }
            }

            foreach (DataRowView registro in dvPrestamos)
            {
                if (registro.Row.ItemArray.GetValue(3) != null)
                {
                    ddlCentroCosto.SelectedValue = registro.Row.ItemArray.GetValue(3).ToString().Trim();

                    CargarEmpleados();
                }

                if (registro.Row.ItemArray.GetValue(8) != null)
                {
                    txvPeriodoInicial.Text = registro.Row.ItemArray.GetValue(8).ToString().Trim();
                }

                if (registro.Row.ItemArray.GetValue(14) != null)
                {
                    ddlFrecuencia.SelectedValue = registro.Row.ItemArray.GetValue(14).ToString().Trim();
                }

                if (registro.Row.ItemArray.GetValue(15) != null)
                {
                    txtObservacion.Text = registro.Row.ItemArray.GetValue(15).ToString().Trim();
                }

                if (registro.Row.ItemArray.GetValue(19) != null)
                {
                    ddlFormaPago.SelectedValue = registro.Row.ItemArray.GetValue(19).ToString().Trim();
                }

                if (registro.Row.ItemArray.GetValue(20) != null)
                {
                    txtDocRef.Text = registro.Row.ItemArray.GetValue(20).ToString().Trim();
                }


            }

            if (liquidado == true)
            {
                txvPeriodoInicial.Enabled = false;
                txvValor.Enabled = false;
                txvCuotas.Enabled = false;
            }



        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.InhabilitarControles(upCabeza.Controls);


        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    protected void gvLista_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToString();
        verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
             Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), Convert.ToInt16(Session["empresa"]), niCalendarFecha.SelectedDate);
    }


    protected void ddlCentroCosto_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarEmpleados();
    }


    protected void txvCuotas_TextChanged(object sender, EventArgs e)
    {

    }
    #endregion Eventos


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

        verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
              Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), Convert.ToInt16(Session["empresa"]), Convert.ToDateTime(txtFecha.Text));
    }
}