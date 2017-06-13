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

public partial class Nomina_Paminidtracion_SubTipoCotizante : System.Web.UI.Page
{
    #region Instancias

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();

    CparametroTipoCotizante parametro = new CparametroTipoCotizante();

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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            this.gvLista.DataSource = parametro.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C", ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
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

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }
    private void CargarCombos()
    {
        try
        {
            this.ddlTipoCotizante.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nTipoCotizante", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlTipoCotizante.DataValueField = "codigo";
            this.ddlTipoCotizante.DataTextField = "descripcion";
            this.ddlTipoCotizante.DataBind();
            this.ddlTipoCotizante.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo cotizante. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlSubtipoCotizante.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nSubTipoCotizante", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSubtipoCotizante.DataValueField = "codigo";
            this.ddlSubtipoCotizante.DataTextField = "descripcion";
            this.ddlSubtipoCotizante.DataBind();
            this.ddlSubtipoCotizante.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar subtipo cotizante. Correspondiente a: " + ex.Message, "C");
        }

    }
    private void EntidadKey()
    {
        object[] objKey = new object[] { Convert.ToInt16(Session["empresa"]), ddlSubtipoCotizante.SelectedValue, ddlTipoCotizante.SelectedValue };
        try
        {
            if (CentidadMetodos.EntidadGetKey("nParametrosTipoCotizante", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = " tipo cotizante con el subtipo ya se encuentra registrado";
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                this.nilbNuevo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta";
        if (ddlTipoCotizante.SelectedValue.Length == 0 || ddlSubtipoCotizante.SelectedValue.Length == 0)
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
        else
        {
            try
            {
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                    operacion = "actualiza";


                object[] objValores = new object[]{
                    chkARP.Checked,
                    chkCaja.Checked,
                   Convert.ToInt16(Session["empresa"]),
                   chkICBF.Checked,
                   chkPension.Checked,
                   chkPension.Checked,
                   chkSalud.Checked,
                   chkSena.Checked,
                   ddlSubtipoCotizante.SelectedValue,
                   ddlTipoCotizante.SelectedValue
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nParametrosTipoCotizante", operacion, "ppa", objValores))
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
                ddlTipoCotizante.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                              nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();
        ddlTipoCotizante.Focus();
        this.nilblInformacion.Text = "";
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
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

            object[] objValores = new object[] { Convert.ToInt16(Session["empresa"]), Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)), Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("nParametrosTipoCotizante", "elimina", "ppa", objValores))
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

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
          nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.ddlTipoCotizante.Enabled = false;
        this.ddlSubtipoCotizante.Enabled = false;
        CargarCombos();
        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.ddlTipoCotizante.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.ddlSubtipoCotizante.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[4].Controls)
            {
                if (objControl is CheckBox)
                    this.chkSalud.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[5].Controls)
            {
                if (objControl is CheckBox)
                    this.chkPension.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[6].Controls)
            {
                if (objControl is CheckBox)
                    this.chkFondoSolidaridad.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[7].Controls)
            {
                if (objControl is CheckBox)
                    this.chkARP.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
            {
                if (objControl is CheckBox)
                    this.chkCaja.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[9].Controls)
            {
                if (objControl is CheckBox)
                    this.chkSena.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[10].Controls)
            {
                if (objControl is CheckBox)
                    this.chkICBF.Checked = ((CheckBox)objControl).Checked;
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
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }

    protected void gvLista_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void ddlTipoCotizante_SelectedIndexChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void ddlSubtipoCotizante_SelectedIndexChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    #endregion Eventos

}
