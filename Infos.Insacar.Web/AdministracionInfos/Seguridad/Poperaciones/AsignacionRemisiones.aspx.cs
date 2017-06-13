using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seguridad_Poperaciones_AsignacionRemisiones : System.Web.UI.Page
{

    #region Instancias

    Cremision remisiones = new Cremision();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();


    #endregion Instancias

    #region Metodos

    private void GetEntidad()
    {
        try
        {
            this.gvLista.DataSource = remisiones.ConteoEstado("I", Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla. Correspondiente a: " + ex.Message, "C");
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

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

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

    private void CargarCombos()
    {
        try
        {
            this.ddlOperadorLogistico.DataSource =  remisiones.OperadoresLogistico(Convert.ToInt16(Session["empresa"]));
            this.ddlOperadorLogistico.DataValueField = "tercero";
            this.ddlOperadorLogistico.DataTextField = "descripcion";
            this.ddlOperadorLogistico.DataBind();
            this.ddlOperadorLogistico.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar funcionarios. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void Guardar()
    {
        try
        {
            if (this.ddlOperadorLogistico.Text.Length == 0)
            {
                this.nilblInformacion.Text = "El número de identificación del funcionario asignado, requiere valor";
                this.ddlOperadorLogistico.Focus();
                return;
            }

            switch (remisiones.CambiaEstadoRemisiones(
                "I",
                "A",
                this.ddlOperadorLogistico.SelectedValue,
                Convert.ToInt16(Session["empresa"])))
            {
                case 0:

                    ManejoExito("Remisiones asignadas satisfactoriamente", "I");
                    break;

                case 1:

                    ManejoError("Error al asignar las remisiones. Operación no realizada", "I");
                    break;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al asignar las remisiones. Correspondiente a: " + ex.Message, "I");
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
            GetEntidad();
        }
    }
    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("Remisiones.aspx");
    }
    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(
           this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();

        this.nilblInformacion.Text = "";
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
           this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlOperadorLogistico.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }
        
        Guardar();
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    #endregion Eventos

}