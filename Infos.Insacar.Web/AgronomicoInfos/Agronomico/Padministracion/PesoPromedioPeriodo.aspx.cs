using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_PesoPromedioPeriodo : System.Web.UI.Page
{

    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cseccion sesion = new Cseccion();
    CpromedioPeso promedio = new CpromedioPeso();
    CIP ip = new CIP();
    Clineas lineas;
    Cnovedad novedad = new Cnovedad();
    Clotes lotes = new Clotes();
    Cseccion sesionesFinca = new Cseccion();
    Cfinca finca = new Cfinca();


    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    protected void cargarMes()
    {

        try
        {
            this.ddlMes.DataSource = lotes.PeriodoMesAbierto(Convert.ToInt16(ddlAño.SelectedValue), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
            this.ddlMes.DataValueField = "mes";
            this.ddlMes.DataTextField = "descripcion";
            this.ddlMes.DataBind();
            this.ddlMes.Items.Insert(0, new ListItem("Mes...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar mes. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void CargarLote()
    {

        try
        {
            DataView Lote = lotes.LotesSeccionFinca(ddlSecciones.SelectedValue.ToString().Trim(), Convert.ToInt32(this.Session["empresa"]), ddlFinca.SelectedValue.ToString().Trim());
            this.ddlLote.DataSource = Lote;
            this.ddlLote.DataValueField = "codigo";
            this.ddlLote.DataTextField = "descripcion";
            this.ddlLote.DataBind();
            this.ddlLote.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar lotes. Correspondiente a: " + ex.Message, "C");
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

            this.gvLista.DataSource = promedio.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(this.Session["empresa"]));
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

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er",
            error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Agronomico/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void CargarPesoPromedio()
    {
        try
        {
            txvPesoPromedio.Text = Convert.ToString(decimal.Round(promedio.valorPromedioPeriodo(Convert.ToInt16(Session["empresa"]), Convert.ToInt16(ddlAño.SelectedValue),
                Convert.ToInt16(ddlMes.SelectedValue), ddlLote.SelectedValue, ConfigurationManager.AppSettings["RegistroBascula"].ToString()), 2));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar el precio promedio. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void CargarCombos()
    {

        try
        {
            this.ddlFinca.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "aFinca", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlFinca.DataValueField = "codigo";
            this.ddlFinca.DataTextField = "descripcion";
            this.ddlFinca.DataBind();
            this.ddlFinca.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar finca. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlAño.DataSource = lotes.PeriodoAñoAbierto(Convert.ToInt16(Session["empresa"]));
            this.ddlAño.DataValueField = "año";
            this.ddlAño.DataTextField = "año";
            this.ddlAño.DataBind();
            this.ddlAño.Items.Insert(0, new ListItem("Año...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }


    }


    #endregion

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
                ddlFinca.Focus();

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

        this.nilbNuevo.Visible = true;

        GetEntidad();
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

        CargarCombos();

        ddlSecciones.Visible = false;
        lbSecion.Visible = false;
        lbGenerar.Visible = false;


        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.nilblInformacion.Text = "";
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.Session["editar"] = false;
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlFinca.SelectedValue.ToString().Trim().Length == 0 || ddlLote.SelectedValue.Length == 0 || txvPesoPromedio.Text.Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar una finca";
            return;
        }

        if (Convert.ToDecimal(txvPesoPromedio.Text) <= 0)
        {
            nilblInformacion.Text = "El peso debe ser diferente a cero";
            return;
        }

        if (txtFechaInicial.Text.Length == 0 || txtFechaFinal.Text.Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar fecha inicial y fecha final";
            return;
        }

        Guardar();

    }


    private void Guardar()
    {

        string operacion = "inserta", seccion = null;
        try
        {


            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            if (ddlSecciones.SelectedValue.Length == 0)
                seccion = null;
            else
                seccion = ddlSecciones.SelectedValue;

            object[] objValores = new object[]{
                    ddlAño.SelectedValue,
                    chkAutomatico.Checked,
                   Convert.ToInt16(Session["empresa"]),
                   Convert.ToDateTime(txtFechaFinal.Text),
                   Convert.ToDateTime(txtFechaInicial.Text),
                   ddlFinca.SelectedValue,
                   ddlLote.SelectedValue,
                   ddlMes.SelectedValue,
                   Convert.ToDecimal(txvPesoPromedio.Text),
                   seccion                    
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("aLotePesosPeriodo", operacion, "ppa", objValores))
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

    protected void ddlFinca_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlFinca.SelectedValue.Length != 0)
        {
            manejoSecciones();
            CargarLote();
        }
    }

    protected void manejoSecciones()
    {

        if (ddlFinca.SelectedValue.ToString().Trim().Length == 0)
        {
            nilblInformacion.Text = "Finca no valida";
            return;

        }

        DataView parametrizacion = finca.SeleccionaParametrizacionLotes(ddlFinca.SelectedValue.ToString().Trim(), Convert.ToInt32(this.Session["empresa"]));

        if (parametrizacion.Table.Rows.Count > 0)
        {
            try
            {
                this.ddlSecciones.DataSource = sesionesFinca.SeleccionaSesionesFinca(Convert.ToInt32(this.Session["empresa"]), ddlFinca.SelectedValue.ToString().Trim());
                this.ddlSecciones.DataValueField = "codigo";
                this.ddlSecciones.DataTextField = "descripcion";
                this.ddlSecciones.DataBind();
                this.ddlSecciones.Items.Insert(0, new ListItem("", ""));

            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar secciones. Correspondiente a: " + ex.Message, "C");
            }

            ddlSecciones.Visible = true;
            lbSecion.Visible = true;
        }
        else
        {
            this.ddlSecciones.DataSource = null;
            ddlSecciones.DataBind();
            ddlSecciones.Visible = false;
            lbSecion.Visible = false;
        }


    }

    protected void manejoControles()
    {

        ddlFinca.SelectedValue = "";
        ddlSecciones.Visible = false;
        lbSecion.Visible = false;
        ddlSecciones.DataSource = null;
        ddlSecciones.DataBind();


    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {

        try
        {

            CcontrolesUsuario.HabilitarControles(this.Page.Controls);
            this.nilbNuevo.Visible = false;
            this.Session["editar"] = true;
            CargarCombos();
            ddlAño.Enabled = false;

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.ddlAño.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
                this.ddlAño.Enabled = false;
                cargarMes();
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.ddlMes.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
                this.ddlMes.Enabled = false;
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.ddlFinca.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
                this.ddlFinca.Enabled = false;
                manejoSecciones();
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.ddlSecciones.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text.Trim());
                this.ddlSecciones.Enabled = false;
                CargarLote();
            }
            else
                CargarLote();

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                this.ddlLote.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);
                this.ddlLote.Enabled = false;
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                txvPesoPromedio.Text = this.gvLista.SelectedRow.Cells[7].Text;
            else
                txvPesoPromedio.Text = "0";

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
            {
                if (objControl is CheckBox)
                    this.chkAutomatico.Checked = ((CheckBox)objControl).Checked;
            }

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                txtFechaInicial.Text = this.gvLista.SelectedRow.Cells[9].Text;
            else
                txtFechaInicial.Text = "";
            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                txtFechaFinal.Text = this.gvLista.SelectedRow.Cells[10].Text;
            else
                txtFechaFinal.Text = "";

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }


    }


    protected void ddlSecciones_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlSecciones.SelectedValue.Length != 0 & ddlFinca.SelectedValue.Length != 0)
        {
            CargarLote();
        }
    }

    protected void ddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Length != 0)
        {
            cargarMes();
        }
        else
        {
            ddlMes.DataSource = null;
            ddlMes.DataBind();
        }
    }

    protected void lbGenerar_Click(object sender, ImageClickEventArgs e)
    {
        CargarPesoPromedio();
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
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToInt16(Session["empresa"]),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[4].Text)),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[6].Text)),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text))
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "aLotePesosPeriodo",
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
    protected void chkAutomatico_CheckedChanged(object sender, EventArgs e)
    {
        if (chkAutomatico.Checked)
        {
            txvPesoPromedio.Enabled = false;
            lbGenerar.Visible = true;
        }
        else
        {
            txvPesoPromedio.Enabled = true;
            lbGenerar.Visible = false;
        }
    }
    protected void lbFechaInicial_Click(object sender, EventArgs e)
    {
        this.CalendarFechaInicial.Visible = true;
        this.txtFechaInicial.Visible = false;
        this.CalendarFechaInicial.SelectedDate = Convert.ToDateTime(null);
        this.CalendarFechaInicial.Enabled = true;
    }
    protected void lbFechaFinal_Click(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = true;
        this.txtFechaFinal.Visible = false;
        this.CalendarFechaFinal.SelectedDate = Convert.ToDateTime(null);
        this.CalendarFechaFinal.Enabled = true;
    }
    protected void niCalendarFechaInicial_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaInicial.Visible = false;
        this.txtFechaInicial.Visible = true;
        this.txtFechaInicial.Text = this.CalendarFechaInicial.SelectedDate.ToShortDateString();
        this.txtFechaInicial.Enabled = false;
    }
    protected void txtFechaInicial_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaInicial.Text);
        }
        catch
        {

            nilblInformacion.Text = "formato de fecha no valido..";
            txtFechaInicial.Text = "";
            txtFechaInicial.Focus();
            return;
        }
    }
    protected void txtFechaFinal_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaFinal.Text);
        }
        catch
        {

            nilblInformacion.Text = "formato de fecha no valido..";
            txtFechaFinal.Text = "";
            txtFechaFinal.Focus();
            return;
        }
    }
    protected void niCalendarFechaTiqueteI_SelectionChanged1(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = false;
        this.txtFechaFinal.Visible = true;
        this.txtFechaFinal.Text = this.CalendarFechaFinal.SelectedDate.ToShortDateString();
        this.txtFechaFinal.Enabled = false;
    }
}