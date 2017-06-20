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
using System.Transactions;

public partial class Logistica_Pprogramacion_ProgramacionVehiculos : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cprogramacion programacion = new Cprogramacion();

    #endregion Instancias

    #region Metodos

    private void GetEntidad()
    {
        try
        {
            this.gvLista.DataSource = programacion.GetDespachosDiarios(Convert.ToDateTime(niTxtFechaI.Text), Convert.ToDateTime(niTxtFechaF.Text), Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Errora al cargar las programaciones" + ex.Message, "C");
        }
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Logistica/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (!IsPostBack)
                CargarCombos();
        }
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        if (niTxtFechaF.Text.Length == 0 || niTxtFechaI.Text.Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar rango de fecha para poder buscar";
            return;
        }


        GetEntidad();
    }

    protected void niLbFechaInicial_Click(object sender, EventArgs e)
    {
        this.CalendarInicial.Visible = true;
        this.niTxtFechaI.Visible = false;
        this.CalendarInicial.SelectedDate = Convert.ToDateTime(null);
    }

    protected void Calendar1_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarInicial.Visible = false;
        this.niTxtFechaI.Visible = true;
        this.niTxtFechaI.Text = this.CalendarInicial.SelectedDate.ToString();
    }

    protected void niLbFechaFinal_Click(object sender, EventArgs e)
    {
        this.CalendarFinal.Visible = true;
        this.niTxtFechaF.Visible = false;
        this.CalendarFinal.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFinal_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFinal.Visible = false;
        this.niTxtFechaF.Visible = true;
        this.niTxtFechaF.Text = this.CalendarFinal.SelectedDate.ToString();
    }

    protected void nilbRegresar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("~/Logistica/Pprogramacion/Programacion.aspx");
    }

    #endregion Eventos


    private void CargarCombos()
    {
        try
        {
            this.ddlPlanta.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet(
                "cTercero", "ppa"), "razonSocial", "extractora", Convert.ToInt16(Session["empresa"]));
            this.ddlPlanta.DataValueField = "id";
            this.ddlPlanta.DataTextField = "razonSocial";
            this.ddlPlanta.DataBind();
            this.ddlPlanta.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar terceros. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            this.ddlPlanta.Visible = true;
            this.lbExtractora.Visible = true;
            this.lbCancelar.Visible = true;
            this.lbRegistrar.Visible = true;
            CargarCombos();

            Session["numero"] = this.gvLista.SelectedRow.Cells[17].Text.Trim();
            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                this.ddlPlanta.SelectedValue = this.gvLista.SelectedRow.Cells[6].Text.Trim();
        }
        catch (Exception ex)
        {
            nilblInformacion.Text = "Error al cargar los campos correspondiente a: " + ex.Message;
        }
    }
    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        this.ddlPlanta.Visible = false;
        this.lbExtractora.Visible = false;
        this.lbCancelar.Visible = false;
        this.lbRegistrar.Visible = false;
    }

    void guardar()
    {
        try
        {
            if (programacion.ActualizaDespachosPlanta(Convert.ToString(Session["numero"]), ddlPlanta.SelectedValue, Convert.ToInt16(Session["empresa"])) == 1)
                nilblInformacion.Text = "Error al guardar el registro.";
            else
            {
                nilblInformacion.Text = "Registro guardado satisfactoriamente.";
                this.ddlPlanta.Visible = false;
                this.lbExtractora.Visible = false;
                this.lbCancelar.Visible = false;
                this.lbRegistrar.Visible = false;
                GetEntidad();
            }
        }
        catch (Exception ex)
        {
            nilblInformacion.Text = "Error al guardar el registro correspondiente a: " + ex.Message;
        }
    }


    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    protected void niTxtFechaI_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(niTxtFechaI.Text);
        }
        catch
        {

            nilblInformacion.Text = "formato de fecha no valido..";
            niTxtFechaI.Text = "";
            niTxtFechaI.Focus();
            return;
        }
    }
    protected void niTxtFechaF_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(niTxtFechaF.Text);
        }
        catch
        {

            nilblInformacion.Text = "formato de fecha no valido..";
            niTxtFechaF.Text = "";
            niTxtFechaF.Focus();
            return;
        }
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(this.ddlPlanta.SelectedValue) == "")
        {
            nilblInformacion.Text = "Seleccione una planta.";
            return;
        }

        guardar();
    }
}