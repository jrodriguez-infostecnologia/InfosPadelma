using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using System.Data;

public partial class Nomina_PLiquidacion_Incapacidades : System.Web.UI.Page
{
    #region Instancias


    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cincapacidades incapacidad = new Cincapacidades();
    Cperiodos periodo = new Cperiodos();

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }
    private void verificaPeriodoCerrado(int año, int mes, int empresa)
    {
        if (periodo.RetornaPeriodoCerrado(año, mes, empresa) == 1)
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
            this.gvLista.DataSource = incapacidad.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C",
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

        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }


    private void CargarIncapacidades()
    {

        try
        {
            ddlProrroga.Enabled = true;
            this.ddlProrroga.DataSource = incapacidad.ProrrogaIncapacidadTercero(Convert.ToDateTime(txtFechaInicial.Text), Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue);
            this.ddlProrroga.DataValueField = "numero";
            this.ddlProrroga.DataTextField = "cadena";
            this.ddlProrroga.DataBind();
            this.ddlProrroga.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar diagnostico. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void CargarCombos()
    {

        try
        {
            this.ddlDiagnostico.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gDiagnostico", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlDiagnostico.DataValueField = "codigo";
            this.ddlDiagnostico.DataTextField = "descripcion";
            this.ddlDiagnostico.DataBind();
            this.ddlDiagnostico.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar diagnostico. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView dvConceptosFijos = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
               "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            dvConceptosFijos.RowFilter = "ControlaSaldo=0 and empresa =" + Convert.ToInt16(this.Session["empresa"]).ToString();

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
            this.ddlTipoIncapacidad.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nTipoIncapacidad", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlTipoIncapacidad.DataValueField = "codigo";
            this.ddlTipoIncapacidad.DataTextField = "descripcion";
            this.ddlTipoIncapacidad.DataBind();
            this.ddlTipoIncapacidad.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo incapacidad. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void CalcularValorIncapacidad()
    {
        object[] objRetono = new object[2];
        try
        {
            Convert.ToDateTime(txtFechaInicial.Text);
        }
        catch
        {
            nilblInformacion.Text = "Formato de fecha no valido por favor correjir";
            return;
        }

        if (ddlTipoIncapacidad.SelectedValue.ToString().Length != 0 && Convert.ToDecimal(txvNoDias.Text) != 0 && ddlEmpleado.SelectedValue.ToString().Length != 0)
        {
            objRetono = incapacidad.CalculaIncapacidad(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue, Convert.ToDecimal(txvNoDias.Text), ddlTipoIncapacidad.SelectedValue, Convert.ToDateTime(txtFechaInicial.Text), Convert.ToInt16(Convert.ToDecimal(txvDiasPagar.Text)), Convert.ToInt16(ddlDiasInicio.SelectedValue));
            txvValorIncapacidad.Text = objRetono[0].ToString();
            txvValorPagar.Text = objRetono[1].ToString();
            txtFechaFinal.Text = Convert.ToString((Convert.ToDateTime(txtFechaInicial.Text).AddDays(Convert.ToDouble(Convert.ToDecimal(txvNoDias.Text) - 1))).ToShortDateString());
        }
    }

    private void CargarEmpleados()
    {
        try
        {
            DataView dvTerceroCCosto = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nFuncionario", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
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
        string operacion = "inserta", numeroProrroga = null;
        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";
            else
                retornaConsecutivo();

            if (chkProrroga.Checked)
                numeroProrroga = ddlProrroga.SelectedValue;
            string diasnostico = null;

            if (ddlDiagnostico.SelectedValue.Length > 0)
                diasnostico = ddlDiagnostico.SelectedValue;

            object[] objValores = new object[]{
                ddlConcepto.SelectedValue,
                diasnostico,
                Convert.ToDecimal(ddlDiasInicio.SelectedValue),
                Convert.ToDecimal(txvDiasPagar.Text),
                  Convert.ToInt16(Session["empresa"]),      //@empresa	int
                  Convert.ToDateTime(txtFechaFinal.Text ) ,    //                fechaFinal              
                     Convert.ToDateTime(txtFechaInicial.Text ) , 	//@fechaInicial                  
                     DateTime.Now,
                     false,
                     Convert.ToDecimal(txvNoDias.Text),
                     txtCodigo.Text,
                     numeroProrroga,
                     txtObservacion.Text,
                     chkProrroga.Checked,
                     txtReferencia.Text,
                     Convert.ToDecimal(txvNoDias.Text),
                     ddlEmpleado.SelectedValue,
                     ddlTipoIncapacidad.SelectedValue,
                     Session["usuario"].ToString(),
                     Convert.ToDecimal(txvValorIncapacidad.Text),
                     Convert.ToDecimal(txvValorPagar.Text)
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("nIncapacidad", operacion, "ppa", objValores))
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
                this.txtCodigo.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
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

        manejoNuevo();
    }

    private void manejoNuevo()
    {
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
        CargarEmpleados();
        retornaConsecutivo();
        ddlProrroga.Enabled = false;
        txtCodigo.Enabled = false;
        txtFechaFinal.Enabled = false;
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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            bool liquidado = false;

            foreach (Control objControl in this.gvLista.Rows[e.RowIndex].Cells[2].Controls)
            {
                if (objControl is CheckBox)
                    liquidado = ((CheckBox)objControl).Checked;
            }

            if (liquidado == false)
            {

                object[] objValores = new object[] {
                             Convert.ToInt16(Session["empresa"]) , //@empresa	int
                                 Convert.ToInt32(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[4].Text)) ,               //@numero	int
                               Convert.ToInt32(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text))  ,           //@tercero	int
                               Session["usuario"].ToString()
              
              
            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nIncapacidad", "elimina", "ppa", objValores))
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

        if (txtCodigo.Text.Trim().ToString().Length == 0 || ddlTipoIncapacidad.SelectedValue.Length == 0 || ddlConcepto.SelectedValue.Length == 0
            || ddlEmpleado.SelectedValue.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

        if (Convert.ToDecimal(txvNoDias.Text) == 0)
        {
            nilblMensaje.Text = "Campos en cero (0), por favor corrija";
            return;
        }

        if (chkProrroga.Checked)
        {
            if (ddlDiagnostico.SelectedValue.Length == 0)
            {
                nilblMensaje.Text = "Debe seleccionar una prorroga por favor corrija";
                return;
            }
        }

        if (Convert.ToBoolean(this.Session["editar"]) == false)
        {
            if (incapacidad.validaRegistroIncapacidadFecha(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue, Convert.ToDateTime(txtFechaInicial.Text), Convert.ToDateTime(txtFechaFinal.Text)) == 1)
            {
                nilblMensaje.Text = "Ya existe un ausentismo para el funcionario seleccionado en el rango de fecha, por favor corrija";
                return;
            }
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
        lbFechaInicial.Enabled = false;
        ddlConcepto.Enabled = false;
        bool anulado = false;

        CargarCombos();
        CargarEmpleados();

        try
        {
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[21].Controls)
            {
                if (objControl is CheckBox)
                    anulado = ((CheckBox)objControl).Checked;
            }
            if (anulado == true)
            {
                ManejoError("Registro anulado no es posible la edición de la transacción", "A");
            }

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.ddlEmpleado.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                niCalendarFechaInicial.SelectedDate = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text));
                txtFechaInicial.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);
                niCalendarFechaInicial.Visible = false;
            }
            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                txtFechaFinal.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                this.txvNoDias.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text);
            else
                this.txvNoDias.Text = "0";

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.txtReferencia.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
            else
                this.txtReferencia.Text = "";

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                this.ddlTipoIncapacidad.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                this.ddlDiagnostico.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[10].Text);

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                this.txtObservacion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[11].Text);
            else
                this.txtObservacion.Text = "";


            bool liquidado = false;
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
            {
                if (objControl is CheckBox)
                    liquidado = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[13].Controls)
            {
                if (objControl is CheckBox)
                    chkProrroga.Checked = ((CheckBox)objControl).Checked;
            }

            if (this.gvLista.SelectedRow.Cells[14].Text != "&nbsp;")
            {
                if (chkProrroga.Checked)
                {
                    CargarIncapacidades();
                    if (Server.HtmlDecode(this.gvLista.SelectedRow.Cells[14].Text.Trim()) != "0")
                        ddlProrroga.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[14].Text.Trim());
                }
            }
            if (this.gvLista.SelectedRow.Cells[15].Text != "&nbsp;")
                this.txvValorIncapacidad.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[15].Text);
            else
                this.txvValorIncapacidad.Text = "0";

            if (this.gvLista.SelectedRow.Cells[16].Text != "&nbsp;")
                this.txvDiasPagar.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[16].Text);
            else
                this.txvDiasPagar.Text = "0";

            if (this.gvLista.SelectedRow.Cells[17].Text != "&nbsp;")
                this.ddlDiasInicio.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[17].Text);

            if (this.gvLista.SelectedRow.Cells[18].Text != "&nbsp;")
                this.txvValorPagar.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[18].Text);
            else
                this.txvValorPagar.Text = "0";

            if (this.gvLista.SelectedRow.Cells[19].Text != "&nbsp;")
                this.ddlConcepto.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[19].Text);



            if (liquidado == true)
            {
                txvNoDias.Enabled = false;
                txvValorPagar.Enabled = false;
                txvValorIncapacidad.Enabled = false;
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
        this.niCalendarFechaInicial.Visible = true;
        this.txtFechaInicial.Visible = false;
        this.niCalendarFechaInicial.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaInicial.Visible = false;
        this.txtFechaInicial.Visible = true;
        this.txtFechaInicial.Text = this.niCalendarFechaInicial.SelectedDate.ToString();
        // this.txtFechaInicial.Enabled = false;

        verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFechaInicial.SelectedDate.Year),
             Convert.ToInt32(this.niCalendarFechaInicial.SelectedDate.Month), Convert.ToInt16(Session["empresa"]));

    }
    protected void ddlCentroCosto_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarEmpleados();
    }

    private void retornaConsecutivo()
    {
        try
        {
            txtCodigo.Text = incapacidad.Consecutivo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue);
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar los datos del funcionario. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlEmpleado_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoEmpleado();
        retornaConsecutivo();
    }

    private void manejoEmpleado()
    {
        ddlTipoIncapacidad.SelectedValue = "";
        ddlProrroga.DataSource = null;
        ddlProrroga.DataBind();
        ddlDiagnostico.SelectedValue = "";
        txvNoDias.Text = "0";
        txtReferencia.Text = "";
        txvValorIncapacidad.Text = "0";
        txtObservacion.Text = "";
        txtFechaInicial.Text = "";
        txtFechaFinal.Text = "";
        niCalendarFechaInicial.Visible = false;
        lbFechaInicial.Visible = true;
        txtFechaInicial.Visible = true;
        txtFechaFinal.Visible = true;
        chkProrroga.Checked = false;
    }

    protected void btnCalcular_Click(object sender, EventArgs e)
    {
        CalcularValorIncapacidad();

    }

    protected void chkProrroga_CheckedChanged(object sender, EventArgs e)
    {
        if (txtFechaInicial.Text.Length == 0)
        {
            nilblMensaje.Text = "Debe seleccionar fecha Inicial para cargar prorrogas";
            return;
        }

        if (chkProrroga.Checked == true)
        {
            CargarIncapacidades();
            CalcularValorIncapacidad();
        }
        else
        {

            this.ddlProrroga.DataSource = null;
            this.ddlProrroga.DataBind();

        }
    }


    protected void txvNoDias_TextChanged(object sender, EventArgs e)
    {
        if (txvNoDias.Text.Trim().Length > 0 & txtFechaInicial.Text.Trim().Length > 0)
        {
            CalcularValorIncapacidad();
        }

        txtFechaFinal.Focus();
    }

    protected void txtFechaInicial_TextChanged(object sender, EventArgs e)
    {

        if (txvNoDias.Text.Trim().Length > 0 & txtFechaInicial.Text.Trim().Length > 0)
        {
            CalcularValorIncapacidad();
        }
        txvNoDias.Focus();
    }

    protected void ddlDiasInicio_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToDecimal(ddlDiasInicio.SelectedValue) > Convert.ToDecimal(txvDiasPagar.Text) || Convert.ToDecimal(ddlDiasInicio.SelectedValue) > Convert.ToDecimal(txvNoDias.Text))
        {
            nilblMensaje.Text = "Debe seleccionar un día inferior al número de días a pagar";
            return;
        }

        if (txvDiasPagar.Text.Trim().Length > 0 & txtFechaInicial.Text.Trim().Length > 0)
        {
            CalcularValorIncapacidad();
        }
        txvDiasPagar.Focus();
    }

    protected void txvDiasPagar_TextChanged(object sender, EventArgs e)
    {
        if (Convert.ToDecimal(ddlDiasInicio.SelectedValue) > Convert.ToDecimal(txvDiasPagar.Text) || Convert.ToDecimal(ddlDiasInicio.SelectedValue) > Convert.ToDecimal(txvNoDias.Text))
        {
            nilblMensaje.Text = "Debe seleccionar un día inferior al número de días a pagar";
            return;
        }

        if (txvDiasPagar.Text.Trim().Length > 0 & txtFechaInicial.Text.Trim().Length > 0)
        {
            CalcularValorIncapacidad();
        }
        txvDiasPagar.Focus();
    }
    #endregion Eventos
}