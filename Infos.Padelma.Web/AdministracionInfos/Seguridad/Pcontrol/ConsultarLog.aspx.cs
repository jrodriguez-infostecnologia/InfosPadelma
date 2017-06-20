using System;
using System.Configuration;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    Clog log = new Clog();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";

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
                            consulta,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", consulta);
                return;
            }


            this.gvLista.DataSource = log.GetLogFechaParametro(
               Convert.ToDateTime(txtFechaDesde.Text),
               Convert.ToDateTime(txtFechaHasta.Text),
                this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));

            this.DataBind();

            niLblMensaje.Text = this.gvLista.Rows.Count.ToString() + "Registros encontrados";

            seguridad.InsertaLog(
               this.Session["usuario"].ToString(),
               consulta,
                ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
               "ex",
               this.gvLista.Rows.Count.ToString() + " Registros encontrados",
               ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los datos. Correspondiente a: " + ex.Message, "C");
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
               error,
               ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
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

    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("~/Seguridad/Pcontrol/Seguridad.aspx");
    }


    #endregion Eventos


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(txtFechaDesde.Text).Length == 0 || Convert.ToString(txtFechaHasta.Text).Length==0)
        {
            niLblMensaje.Text = "Debe seleccionar un rango de fecha antes de buscar, por favor corrija";
            return;
        }

        imbImprimir.Visible = true;
        GetEntidad();
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    protected void lbFechaIngreso_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaDesde.Visible = true;
        this.txtFechaDesde.Visible = false;
        this.niCalendarFechaDesde.SelectedDate = Convert.ToDateTime(null);
    }
    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaDesde.Text);
        }
        catch
        {
            niLblMensaje.Text = "Formato de fecha no valido";
            txtFechaDesde.Text = "";
            txtFechaDesde.Focus();
            return;
        }
    }
    protected void niCalendarFechaSalida_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaDesde.Visible = false;
        this.txtFechaDesde.Visible = true;
        this.txtFechaDesde.Text = this.niCalendarFechaDesde.SelectedDate.ToShortDateString();
    }
    protected void lbFechaHasta_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaHasta.Visible = true;
        this.txtFechaHasta.Visible = false;
        this.niCalendarFechaHasta.SelectedDate = Convert.ToDateTime(null);
    }
    protected void txtFechaHasta_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaHasta.Text);
        }
        catch
        {
            niLblMensaje.Text = "Formato de fecha no valido";
            txtFechaHasta.Text = "";
            txtFechaHasta.Focus();
            return;
        }
    }
    protected void niCalendarFechaHasta_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaHasta.Visible = false;
        this.txtFechaHasta.Visible = true;
        this.txtFechaHasta.Text = this.niCalendarFechaHasta.SelectedDate.ToShortDateString();
    }
}
