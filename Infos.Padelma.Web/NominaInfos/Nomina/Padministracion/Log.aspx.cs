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
using System.Drawing;

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();

    Clog log = new Clog();

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

            this.gvEncabezado.DataSource = log.RetornaEncabezadoSNominaLog( Convert.ToInt16(Session["empresa"]), Convert.ToDateTime(nitxtFechaIni.Text), Convert.ToDateTime(nitxtFechaFinal.Text));
            this.gvEncabezado.DataBind();

            this.nilblInformacion.Text = this.gvEncabezado.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
                this.Session["usuario"].ToString(), "C",
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                this.gvEncabezado.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

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

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

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


    private void EntidadKey()
    {
        object[] objKey = new object[] { "", Convert.ToInt16(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "nCargo",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Código " + ""+ " ya se encuentra registrado";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
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


                this.nitxtFechaIni.Focus();
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

        this.Session["editar"] = false;
        this.nilblInformacion.Text = "";
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvEncabezado.DataSource = null;
        this.gvEncabezado.DataBind();

        this.nilblInformacion.Text = "";
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
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
                Convert.ToString(Server.HtmlDecode(this.gvEncabezado.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToInt16(Session["empresa"])
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "nCargo",
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
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvEncabezado.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvEncabezado.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro.", "E");
            }
            else
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEncabezado.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvEncabezado.DataBind();
    }



    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        GetEntidad();
    }

    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Novedad.aspx");
    }
    protected void gvLista_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvEncabezado.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvEncabezado.DataBind();
    }

    protected void btnCancelarDetalle_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
      this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        CcontrolesUsuario.InhabilitarControles(
     this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        nibtnCancelarDetalle.Visible = false;
        this.Session["editar"] = null;

        gvDetalle.DataSource = null;
        gvDetalle.DataBind();

        gvEncabezado.DataSource = null;
        gvEncabezado.DataBind();

        

    }


    protected void CalendarFechaIni_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaIni.Visible = false;
        this.nitxtFechaIni.Visible = true;
        this.nitxtFechaIni.Text = this.CalendarFechaIni.SelectedDate.ToShortDateString();
        this.nitxtFechaIni.Enabled = true;
    }

    protected void CalendarFechaFinal_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = false;
        this.nitxtFechaFinal.Visible = true;
        this.nitxtFechaFinal.Text = this.CalendarFechaFinal.SelectedDate.ToShortDateString();
        this.nitxtFechaFinal.Enabled = true;
    }


    protected void lbFechaFinal_Click(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = true;
        this.nitxtFechaFinal.Visible = false;
        this.CalendarFechaFinal.SelectedDate = Convert.ToDateTime(null);
    }

    protected void lbFechaIni_Click(object sender, EventArgs e)
    {
        this.CalendarFechaIni.Visible = true;
        this.nitxtFechaIni.Visible = false;
        this.CalendarFechaIni.SelectedDate = Convert.ToDateTime(null);
    }

    protected void gvEncabezado_SelectedIndexChanged(object sender, EventArgs e)
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

            this.gvDetalle.DataSource = log.RetornaDetalleSNominaLog( Convert.ToInt16(Session["empresa"]),Convert.ToInt16(gvEncabezado.SelectedRow.Cells[1].Text) );
            this.gvDetalle.DataBind();

            gvDetalle.Visible = true;

            this.nilblInformacionDetalle.Text = this.gvDetalle.Rows.Count.ToString() + " Registros encontrados";

            foreach (GridViewRow gvr in gvDetalle.Rows)
            {
                if (gvr.Cells[1].Text.Trim() != gvr.Cells[2].Text)
                {
                    gvr.BackColor = Color.Red;
                }
            }

            seguridad.InsertaLog(
                this.Session["usuario"].ToString(), "C",
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                this.gvEncabezado.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, "C");
        }
    }



    protected void gvEncabezado_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvEncabezado.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvEncabezado.DataBind();
        gvDetalle.DataSource = null;
        gvDetalle.DataBind();
    }

    #endregion Eventos










   
}
