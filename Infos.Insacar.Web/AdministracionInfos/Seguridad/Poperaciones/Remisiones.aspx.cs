using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seguridad_Poperaciones_Remisiones : System.Web.UI.Page
{

    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cremision remisiones = new Cremision();

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


            if (this.nitxtBusqueda.Text.Trim().Length == 0)
            {
                this.gvLista.DataSource = remisiones.ConteoEstado("", Convert.ToInt16(Session["empresa"]));
                this.gvLista.DataBind();
            }
            else
            {
                this.gvBusqueda.DataSource = remisiones.BuscarEntidad(
                    this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
                this.gvBusqueda.DataBind();

                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = this.gvBusqueda.Rows.Count.ToString() + " Registros encontrados";
            }
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

    private void Guardar()
    {
        try
        {
            if (Convert.ToDecimal(numRegistros.Text) == 0)
            {
                this.nilblInformacion.Text = "El número de remisiones a generar no puede ser igual a cero";
                return;
            }

            switch (remisiones.GeneraRemision(
               Convert.ToInt16( Convert.ToDecimal(this.numRegistros.Text)),
                this.Session["usuario"].ToString(),
                Convert.ToInt16(Session["empresa"])))
            {
                case 0:

                    ManejoExito("Remisiones generadas satisfactoriamente","I");
                    break;

                case 1:

                    ManejoError("Error al generar las remisiones. Operación no realizada","I");
                    break;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al generar las remisiones. Correspondiente a: " + ex.Message,"I");
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
                this.nitxtBusqueda.Focus();
               GetEntidad();
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }

        }

    }
    protected void gvBusqueda_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvBusqueda.PageIndex = e.NewPageIndex;
        // GetEntidad();
        gvBusqueda.DataBind();
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        //GetEntidad();
        gvLista.DataBind();
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
        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;


        this.numRegistros.Visible = true;
        this.numRegistros.Text = "0";

        foreach (Control objControl in numRegistros.Controls)
        {
            if (objControl is TextBox)
            {
                objControl.Focus();
            }
        }

        this.nilblInformacion.Text = "";

    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvBusqueda.DataSource = null;
        this.gvBusqueda.DataBind();
        this.numRegistros.Text = "0";
        this.numRegistros.Visible = false;
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }
    protected void lbAsignar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("AsignacionRemisiones.aspx");
    }
    protected void nilbImprimir_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("ImpresionRemision.aspx");
    }
}