using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;

public partial class Nomina_Padministracion_PeriodoNomina : System.Web.UI.Page
{
    #region Instancias

    Cperiodos periodos = new Cperiodos();
    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    List<CperiodoDetalle> listaPeriodoDetalle = new List<CperiodoDetalle>();
    CperiodoDetalle periodoDetalle = new CperiodoDetalle();
    CIP ip = new CIP();

    #endregion Instancias

    #region Metodos

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
            if (seguridad.VerificaAccesoOperacion(
                this.Session["usuario"].ToString(),//usuario
                 ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                 nombrePaginaActual(),//pagina
                "C",//operacion
               Convert.ToInt16(this.Session["empresa"]))//empresa
               == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }


            this.gvLista.DataSource = periodos.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(this.Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              "C",
               ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex",
              this.gvLista.Rows.Count.ToString() + " Registros encontrados",
              ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, "C");
        }
    }
    private void ManejoError(string error, string operacion)
    {
        nilblInformacion.Text = "";
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
        nilblInformacion.Text = "";
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        CcontrolesUsuario.InhabilitarControles(
         this.upDetalle.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upDetalle.Controls);

        upDetalle.Visible = false;

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }
    private void CargarCombos()
    {
        nilblInformacion.Text = "";
        try
        {
            this.ddlAño.DataSource = periodos.PeriodoAñoAbierto(Convert.ToInt16(Session["empresa"]));
            this.ddlAño.DataValueField = "año";
            this.ddlAño.DataTextField = "año";
            this.ddlAño.DataBind();
            this.ddlAño.Items.Insert(0, new ListItem("Año...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            this.ddlTipoNomina.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nTipoNomina", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"])); ;
            this.ddlTipoNomina.DataValueField = "codigo";
            this.ddlTipoNomina.DataTextField = "descripcion";
            this.ddlTipoNomina.DataBind();
            this.ddlTipoNomina.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cargos. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void EntidadKey()
    {
        object[] objKey = new object[] { this.ddlAño.SelectedValue, Convert.ToInt16(this.Session["empresa"]) };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "nPeriodo",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "El año " + this.ddlAño.SelectedValue + " ya se encuentra registrado";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);


            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }



    private void GuardarDetalle()
    {

        string operacion = "inserta";
        int noPeriodo = 0;



        try
        {
            using (TransactionScope ts = new TransactionScope())
            {

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                    noPeriodo = Convert.ToInt16(txvPeriodoDetalle.Text);
                }
                else
                {
                    noPeriodo = periodos.consecutivoPeriodoAño(Convert.ToInt16(Session["empresa"]), Convert.ToInt16(ddlAño.SelectedValue));
                    //periodos.NoPeriodoAñoMes(Convert.ToInt16(ddlAño.SelectedValue), Convert.ToInt16(Session["empresa"]));
                }



                object[] objValores = new object[]{
                                chkAgronomico.Checked,//@agronomico
                               ddlAño.SelectedValue,        //                @año	int
                               chkCerrado.Checked,     //@cerrado	bit
                              Convert.ToInt32(txvDiasNomina.Text), //@diasNomina
                                  Convert.ToInt16(this.Session["empresa"]),    //@empresa	int
                                Convert.ToDateTime( txtFechaCorte.Text ),  //@fechaCorte	date
                               Convert.ToDateTime(txtFechaFinal.Text),     //@fechaFinal	date
                            Convert.ToDateTime(txtFechaIni.Text),        //@fechaInicial	date
                            Convert.ToDateTime(txtFechaPago.Text),        //@fechaPago	datetime
                                DateTime.Now,    //@fechaRegistro	datetime
                              Convert.ToInt16( ddlMes.SelectedValue ) ,  //@mes	int
                                noPeriodo,    //@noPeriodo	int
                                 ddlTipoNomina.SelectedValue.Trim(),   //@tipoNomina	varchar
                                (string)this.Session["usuario"]    //@usuario	varchar
            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "nPeriodoDetalle",
                    operacion,
                    "ppa",
                    objValores))
                {

                    case 0:
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        ts.Complete();
                        break;

                    case 1:

                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }


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
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {

            if (seguridad.VerificaAccesoPagina(
                this.Session["usuario"].ToString(),
                ConfigurationManager.AppSettings["Modulo"].ToString(),
               nombrePaginaActual(),
                Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
         this.Page.Controls);
        this.Session["editar"] = null;
        upDetalle.Visible = false;

        GetEntidad();
    }
    protected void lbFechaIni_Click(object sender, EventArgs e)
    {
        this.CalendarFechaIni.Visible = true;
        this.txtFechaIni.Visible = false;
        this.CalendarFechaIni.SelectedDate = Convert.ToDateTime(null);
    }
    protected void lbFechaFinal_Click(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = true;
        this.txtFechaFinal.Visible = false;
        this.CalendarFechaFinal.SelectedDate = Convert.ToDateTime(null);
    }
    protected void lbFechaCorte_Click(object sender, EventArgs e)
    {
        this.CalendarFechaCorte.Visible = true;
        this.txtFechaCorte.Visible = false;
        this.CalendarFechaCorte.SelectedDate = Convert.ToDateTime(null);
    }
    protected void lbFechaPago_Click(object sender, EventArgs e)
    {
        this.CalendarFechaPago.Visible = true;
        this.txtFechaPago.Visible = false;
        this.CalendarFechaPago.SelectedDate = Convert.ToDateTime(null);
    }
    protected void CalendarFechaIni_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaIni.Visible = false;
        this.txtFechaIni.Visible = true;
        this.txtFechaIni.Text = this.CalendarFechaIni.SelectedDate.ToShortDateString();
        this.txtFechaIni.Enabled = true;
    }
    protected void CalendarFechaFinal_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = false;
        this.txtFechaFinal.Visible = true;
        this.txtFechaFinal.Text = this.CalendarFechaFinal.SelectedDate.ToShortDateString();
        this.txtFechaFinal.Enabled = true;
    }
    protected void CalendarFechaCorte_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaCorte.Visible = false;
        this.txtFechaCorte.Visible = true;
        this.txtFechaCorte.Text = this.CalendarFechaCorte.SelectedDate.ToShortDateString();
        this.txtFechaCorte.Enabled = true;
    }
    protected void CalendarFechaPago_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaPago.Visible = false;
        this.txtFechaPago.Visible = true;
        this.txtFechaPago.Text = this.CalendarFechaPago.SelectedDate.ToShortDateString();
        this.txtFechaPago.Enabled = true;
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
        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        this.Session["editar"] = false;

        CargarCombos();

        nibtnNuevoDetalle.Visible = false;
        btnCancelarDetalle.Visible = false;
        lbRegistrar.Visible = false;

        this.ddlAño.Focus();
        this.nilblInformacion.Text = "";

    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
         this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();


        upDetalle.Visible = false;
    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
         this.Session["usuario"].ToString(),
         ConfigurationManager.AppSettings["Modulo"].ToString(),
          nombrePaginaActual(),
         "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }


        CcontrolesUsuario.HabilitarControles(
         this.Page.Controls);
        CcontrolesUsuario.HabilitarControles(
         this.upDetalle.Controls);
        upDetalle.Visible = true;
        this.Session["editar"] = true;

        this.ddlAño.Enabled = false;
        this.ddlTipoNomina.Enabled = false;
        this.txvPeriodoDetalle.Enabled = false;
       // this.ddlMes.Enabled = false;
        nilblInformacion.Text = "";


        CargarCombos();


        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.ddlAño.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                ddlMes.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text.Trim());

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                txvPeriodoDetalle.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text.Trim());

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                txtFechaIni.Text = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text)).ToShortDateString();

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                txtFechaFinal.Text = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text)).ToShortDateString();

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                txtFechaCorte.Text = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text)).ToShortDateString();

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                txtFechaPago.Text = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text)).ToShortDateString();

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                ddlTipoNomina.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text.Trim());

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
              txvDiasNomina.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[10].Text.Trim());

            foreach (Control con in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                if (con is CheckBox)
                    chkCerrado.Checked = ((CheckBox)con).Checked;
            }

            foreach (Control con in this.gvLista.SelectedRow.Cells[12].Controls)
            {
                if (con is CheckBox)
                    chkAgronomico.Checked = ((CheckBox)con).Checked;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }
    protected void gvista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvLista_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void txvAño_TextChanged(object sender, EventArgs e)
    {


    }

    protected void ddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlAño.SelectedValue.Trim().Length > 0)
            {
                txvPeriodoDetalle.Text = periodos.consecutivoPeriodoAño(Convert.ToInt16(Session["empresa"]), Convert.ToInt16(ddlAño.SelectedValue)).ToString();
                upDetalle.Visible = true;
                CcontrolesUsuario.HabilitarControles(upDetalle.Controls);
                txvPeriodoDetalle.Enabled = false;
            }
            else
            {
                nilblInformacion.Text = "Seleccione un año valido para continuar";
                upDetalle.Visible = false;
                CcontrolesUsuario.InhabilitarControles(upDetalle.Controls);
                return;

            }
        }
        catch (Exception ex)
        {

            ManejoError("Error al cargar consecutivo de periodo debido a:   " + ex.Message, "I");
        }
    }


    #endregion Eventos
    protected void btnGuardarDetalle_Click(object sender, ImageClickEventArgs e)
    {
        DateTime fechaInicial = new DateTime();
        DateTime fechaFinal = new DateTime();
        DateTime fechaPago = new DateTime();
        DateTime fechaCorte = new DateTime();

        try
        {
            

            fechaCorte = Convert.ToDateTime(txtFechaCorte.Text);
            fechaFinal = Convert.ToDateTime(txtFechaFinal.Text);
            fechaPago = Convert.ToDateTime(txtFechaPago.Text);
            fechaInicial = Convert.ToDateTime(txtFechaIni.Text);

        }
        catch
        {
            nilblInformacion.Text = "Formato de fecha no validas por favor corrija";
            return;

        }

        if (ddlTipoNomina.SelectedValue.Trim().Length == 0 || ddlAño.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Campos de selección vacios";
            return;
        }

        int messeleccionado = Convert.ToInt32(ddlMes.SelectedValue);
        int añoseleccionado = Convert.ToInt32(ddlAño.SelectedValue);

        if (fechaInicial > fechaFinal)
        {
            nilblInformacion.Text = "La fecha inicial debe ser menor  fecha final";
            return;
        }

        //if (fechaInicial.Year != añoseleccionado)
        //{
        //    nilblInformacion.Text = "La fecha inicial debe pertenecer al mismo año del seleccionado";
        //    return;
        //}

        //else if (fechaInicial.Month != messeleccionado)
        //{
        //    nilblInformacion.Text = "La fecha inicial debe pertenecer al mismo mes del seleccionado";
        //    return;
        //}

        //if (fechaCorte.Year != añoseleccionado || fechaPago.Year != añoseleccionado)
        //{

        //    nilblInformacion.Text = "La fecha de corte o de pago debe tener el mismo año seleccionado";
        //}

        GuardarDetalle();
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



            object[] objValores = new object[] {

                         Convert.ToInt32(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),//    @año	int
                                Convert.ToInt16(Session["empresa"]),    //@empresa	int
                               Convert.ToInt32(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) ,   //@mes	int
                               Convert.ToInt32(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[4].Text))      //@noPeriodo	int
              ,
                Convert.ToInt16(Session["empresa"])
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "nPeriodoDetalle",
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
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro, debido a: " + ex.Message, "E");
            }
            else
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }
    protected void btnCancelarDetalle_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
         this.upDetalle.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.upDetalle.Controls);

        CcontrolesUsuario.InhabilitarControles(
     this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        nibtnNuevoDetalle.Visible = true;
        lbRegistrar.Visible = false;
        btnCancelarDetalle.Visible = false;
        this.Session["editar"] = null;



        upDetalle.Visible = false;
    }

    protected void btnNuevoDetalle_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            this.Session["editar"] = null;
            CcontrolesUsuario.HabilitarControles(Page.Controls);
            CargarCombos();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los combos debido a :  " + ex.Message, "I");

        }
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        DateTime fechaInicial = new DateTime();
        DateTime fechaFinal = new DateTime();
        DateTime fechaPago = new DateTime();
        DateTime fechaCorte = new DateTime();

        try
        {


            fechaCorte = Convert.ToDateTime(txtFechaCorte.Text);
            fechaFinal = Convert.ToDateTime(txtFechaFinal.Text);
            fechaPago = Convert.ToDateTime(txtFechaPago.Text);
            fechaInicial = Convert.ToDateTime(txtFechaIni.Text);

        }
        catch
        {
            nilblInformacion.Text = "Formato de fecha no validas por favor corrija";
            return;

        }

        if (ddlTipoNomina.SelectedValue.Trim().Length == 0 || ddlAño.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Campos de selección vacios";
            return;
        }

        int messeleccionado = Convert.ToInt32(ddlMes.SelectedValue);
        int añoseleccionado = Convert.ToInt32(ddlAño.SelectedValue);

        if (fechaInicial > fechaFinal)
        {
            nilblInformacion.Text = "La fecha inicial debe ser menor  fecha final";
            return;
        }

        //if (fechaInicial.Year != añoseleccionado)
        //{
        //    nilblInformacion.Text = "La fecha inicial debe pertenecer al mismo año del seleccionado";
        //    return;
        //}

        //else if (fechaFinal.Month != messeleccionado)
        //{
        //    nilblInformacion.Text = "La fecha final debe pertenecer al mismo mes del seleccionado";
        //    return;
        //}

        //if (fechaCorte.Year != añoseleccionado || fechaPago.Year != añoseleccionado)
        //{

        //    nilblInformacion.Text = "La fecha de corte o de pago debe tener el mismo año seleccionado";
        //    return;
        //}


        if (txvDiasNomina.Text.Trim().Length == 0) {
            nilblInformacion.Text = "Ingrese dias de nomina por favor";
            return;
        }


        GuardarDetalle();
    }
}
