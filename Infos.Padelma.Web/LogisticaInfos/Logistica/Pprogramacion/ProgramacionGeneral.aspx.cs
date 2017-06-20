using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistica_Pprogrmacion_ProgramacionGeneral : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cprogramacion programacion = new Cprogramacion();
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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                    nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            int ano=DateTime.Now.Year;
            int mes =DateTime.Now.Month;

            if (this.niddlAño.SelectedValue.Length > 0) {
                ano = Convert.ToInt16(this.niddlAño.SelectedValue);
            }

            if (this.ddlMes.SelectedValue.Length > 0)
            {
                 mes = Convert.ToInt16(this.ddlMes.SelectedValue);
            }

            this.gvLista.DataSource = programacion.BuscarEntidad(ano,mes, Convert.ToInt16(Session["empresa"]));
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

        this.Response.Redirect("~/Logistica/Error.aspx", false);
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

    private void CargarCombos()
    {
        try
        {
            this.ddlMercado.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "fMercado", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlMercado.DataValueField = "codigo";
            this.ddlMercado.DataTextField = "descripcion";
            this.ddlMercado.DataBind();
            this.ddlMercado.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo mercado. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlAño.DataSource = programacion.PeriodoAñoAbierto(Convert.ToInt16(Session["empresa"]));
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
            DataView productosProduccion = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            productosProduccion.RowFilter = "tipo in('P','T') and empresa = " + Session["empresa"].ToString();
            this.ddlProducto.DataSource = productosProduccion;
            this.ddlProducto.DataValueField = "codigo";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar novedades. Correspondiente a: " + ex.Message, "C");
        }


    }

    private void cargarPeriodo()
    {
        try
        {
            this.niddlAño.DataSource = programacion.PeriodoAñoAbierto(Convert.ToInt16(Session["empresa"]));
            this.niddlAño.DataValueField = "año";
            this.niddlAño.DataTextField = "año";
            this.niddlAño.DataBind();
            this.niddlAño.Items.Insert(0, new ListItem("Año...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta";

        if (Convert.ToString(this.ddlMercado.SelectedValue).Length == 0 ||
            Convert.ToString(this.ddlProducto.SelectedValue).Length == 0 || this.txvCantidad.Text.Length == 0
            || ddlAño.SelectedValue.Length == 0 || ddlMes.SelectedValue.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";

            return;
        }

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }
            else
            {
                Session["programacion"] =
                Convert.ToString(Session["empresa"]).Trim() +
                    Convert.ToString(this.ddlAño.SelectedValue).Trim() +
                    Convert.ToString(this.ddlMes.SelectedValue).Trim() +
                    Convert.ToString(this.ddlMercado.SelectedValue).Trim() +
                    Convert.ToString(this.ddlProducto.SelectedValue).Trim();
            }

            object[] objValores = new object[]{
                ddlAño.SelectedValue,
                Convert.ToDecimal(this.txvCantidad.Text),
                Convert.ToInt16(Session["empresa"]),
                DateTime.Now,
                Convert.ToString(this.ddlMercado.SelectedValue),
                ddlMes.SelectedValue,
                Convert.ToString(this.ddlProducto.SelectedValue),
                Session["programacion"].ToString(),
                Session["usuario"].ToString()

            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "logProgramacionGeneral",
                operacion,
                "ppa",
                objValores))
            {
                case 0:

                    CcontrolesUsuario.InhabilitarControles(
                        this.Page.Controls);

                    GetEntidad();

                    ManejoExito("Datos insertados satisfactoriamente","I");
                    break;

                case 1:

                    ManejoError("Errores al insertar el registro. Operación no realizada","I");
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al insertar el registro. Correspondiente a: " + ex.Message,"I");
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
                    cargarPeriodo();
                }

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

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        CargarCombos();

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.ddlMercado.Focus();
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

            object[] objValores = new object[] {
                  Convert.ToInt16(Session["empresa"]),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text))
              
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "logProgramacionGeneral",
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

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(
          this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        try
        {
            CargarCombos();

            ddlAño.Enabled = false;
            ddlMes.Enabled = false;
            ddlMercado.Enabled = false;
            ddlProducto.Enabled = false;

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.Session["programacion"] = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            }
            else
            {
                this.Session["programacion"] = null;
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                ddlAño.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
                cargarMes();
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                ddlMes.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.ddlMercado.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text;
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                this.ddlProducto.SelectedValue = this.gvLista.SelectedRow.Cells[6].Text;
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                this.txvCantidad.Text = this.gvLista.SelectedRow.Cells[7].Text;
            }
            else
            {
                this.txvCantidad.Text = "";
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos. Correspondiente a: " + ex.Message, "A");
        }
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }



    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("~/Logistica/Pprogramacion/Programacion.aspx");
    }
    #endregion Eventos

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

    protected void cargarMes()
    {

        try
        {
            this.ddlMes.DataSource = programacion.PeriodoMesAbierto(Convert.ToInt16(ddlAño.SelectedValue), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
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

    protected void niddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (niddlAño.SelectedValue.Length != 0)
        {
            nicargarMes();
        }
        else
        {
            niddlMes.DataSource = null;
            niddlMes.DataBind();
        }
    }

    protected void nicargarMes()
    {

        try
        {
            this.niddlMes.DataSource = programacion.PeriodoMesAbierto(Convert.ToInt16(niddlAño.SelectedValue), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
            this.niddlMes.DataValueField = "mes";
            this.niddlMes.DataTextField = "descripcion";
            this.niddlMes.DataBind();
            this.niddlMes.Items.Insert(0, new ListItem("Mes...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar mes. Correspondiente a: " + ex.Message, "C");
        }
    }
}