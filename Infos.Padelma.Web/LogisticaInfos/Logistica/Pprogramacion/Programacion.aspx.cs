using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistica_Pprogrmacion_Programacion : System.Web.UI.Page
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

            this.gvLista.DataSource = programacion.GetProgramacionCab(Convert.ToInt16(this.niddlAño.SelectedValue), Convert.ToInt16(niddlMes.SelectedValue), Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

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
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

       
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

    protected void cargarMes()
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


    #endregion Metodos


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
               if(!IsPostBack)
               {
                   CargarCombos();
               }

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }
    protected void ddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (niddlAño.SelectedValue.Length != 0)
        {
            cargarMes();
        }
        else
        {
            niddlMes.DataSource = null;
            niddlMes.DataBind();
        }
    }


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(
           this.Page.Controls);

        this.nilblMensaje.Text = "";
        if (niddlAño.SelectedValue.Length == 0 || niddlMes.SelectedValue.Length == 0)
        {
            nilblMensaje.Text = "Debe seleccionar un año y mes antes de buscar";
            return;
        }

        GetEntidad();
    }
    protected void imbComercializadora_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("~/Logistica/Pprogramacion/ProgramacionGeneral.aspx");
    }
    protected void niimbDespachos_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void niimbProgramacion_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void imbTiempos_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            this.Session["programacion"] = this.gvLista.SelectedRow.Cells[1].Text;
            Session["año"] = this.gvLista.SelectedRow.Cells[2].Text;
            Session["mes"] = this.gvLista.SelectedRow.Cells[3].Text;
            this.nilblMensaje.Text = "";

            if (Convert.ToString(this.Session["programacion"]) != "&nbsp;")
            {
                if (programacion.ProgramacionValida(Convert.ToInt16(programacion.ValoresProgramacion(this.Session["programacion"].ToString(), Convert.ToInt16(Session["empresa"])).GetValue(0)),
                    Convert.ToInt16(programacion.ValoresProgramacion(this.Session["programacion"].ToString(), Convert.ToInt16(Session["empresa"])).GetValue(1))) == true)
                {
                    this.Response.Redirect("~/Logistica/Pprogramacion/ProgramacionVehiculos.aspx", false);
                }
                else
                {
                    this.nilblMensaje.Text = "!! Programación no vigente. No será posible registrar vehículos.";
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al programar vehículos. Correspondiente a: " + ex.Message,"I");
        }
    }
}