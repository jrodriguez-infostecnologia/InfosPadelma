using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Laboratorio_Padministracion_Jerarquias : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cnivel nivel = new Cnivel();
    Cjerarquia jerarquia = new Cjerarquia();
    CIP ip = new CIP();

    #endregion Instancias

    #region Metodos

    private void limpiarDdl()
    {
        ddlItem.DataSource = null;
        ddlItem.DataBind();
        ddlNivel.DataSource = null;
        ddlNivel.DataBind();
        ddlNivelPadre.DataSource = null;
        ddlNivelPadre.DataBind();
        ddlPadre.DataSource = null;
        ddlPadre.DataBind();
  
    }

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

            this.gvLista.DataSource = jerarquia.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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

        this.Response.Redirect("~/Laboratorio/Error.aspx", false);
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
            DataView dsNivel = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("lNivel", "ppa"),
                 "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlNivel.DataSource = dsNivel;
            this.ddlNivel.DataValueField = "codigo";
            this.ddlNivel.DataTextField = "descripcion";
            this.ddlNivel.DataBind();
            this.ddlNivel.Items.Insert(0, new System.Web.UI.WebControls.ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar niveles. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView dsNivel = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("lNivel", "ppa"),
         "descripcion", Convert.ToInt16(Session["empresa"]));

            this.ddlNivelPadre.DataSource = dsNivel;
            this.ddlNivelPadre.DataValueField = "codigo";
            this.ddlNivelPadre.DataTextField = "descripcion";
            this.ddlNivelPadre.DataBind();
            this.ddlNivelPadre.Items.Insert(0, new System.Web.UI.WebControls.ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar niveles padre. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView dsItems = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iitems", "ppa"),
         "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlItem.DataSource = dsItems;
            this.ddlItem.DataValueField = "codigo";
            this.ddlItem.DataTextField = "descripcion";
            this.ddlItem.DataBind();
            this.ddlItem.Items.Insert(0, new System.Web.UI.WebControls.ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar niveles padre. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.ddlItem.SelectedValue, Convert.ToInt16(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "lJerarquia",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Código " + this.ddlItem.SelectedValue + " ya se encuentra registrado";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

                this.nilbNuevo.Visible = true;
            }
            else
            {
                ddlItem.Focus();
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


        if (ddlItem.SelectedValue.Trim().Length==0 || ddlNivel.SelectedValue.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        try
        {

            string id ="";
            string padre = "";
            int nivelPadre = 0;
           

            if (ddlNivelPadre.SelectedValue.Trim().Length > 0 & ddlNivelPadre.Enabled==true)
            {
                nivelPadre = Convert.ToInt16(ddlNivelPadre.SelectedValue.Trim());   
            }

            if (ddlPadre.SelectedValue.Trim().Length > 0 & ddlPadre.Enabled == true)
            {
                padre = ddlPadre.SelectedValue.Trim();
            }
            
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                id = lblId.Text;
            }

            object[] objValores = new object[]{
                              chkActivo.Checked,      // @activo	bit
                              Convert.ToInt16(this.Session["empresa"]), //@empresa
                               id ,//@id
                               ddlItem.SelectedValue.Trim(),     //@item	int
                               ddlNivel.SelectedValue.Trim(),     //@nivel	int
                               ddlNivelPadre.SelectedValue.Trim() ,   //@nivelSuperior	int
                               ddlPadre.SelectedValue.Trim() //@padre
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "lJerarquia",
                operacion,
                "ppa",
                objValores))
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

                this.nitxtBusqueda.Focus();

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
        limpiarDdl();

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.lblId.Text = "";
        CargarCombos();
        this.nilblInformacion.Text = "";
        this.lblId.Visible = false;
        this.lbid.Visible = false;
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
        limpiarDdl();
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
                Convert.ToInt16(Session["empresa"]),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[1].Text))
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "lJerarquia",
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
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) + "') tiene una asociación, no es posible eliminar el registro.", "E");
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

        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            "A",//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
           this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;


        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[1].Text != "&nbsp;")
            {
                this.lblId.Text = this.gvLista.SelectedRow.Cells[2].Text;
            }
            else
            {
                this.lblId.Text = "";
            }


            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                foreach (Control control in this.gvLista.SelectedRow.Cells[7].Controls)
                {
                    if (control is CheckBox)
                    {
                        this.chkActivo.Checked = ((CheckBox)control).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.ddlNivel.SelectedValue = this.gvLista.SelectedRow.Cells[6].Text;
            }

            if (Convert.ToInt16(this.ddlNivel.SelectedValue) > 1)
            {
                this.ddlNivelPadre.SelectedValue = Convert.ToString(jerarquia.RetornaNiveljerarquia(
                    Convert.ToInt32(this.gvLista.SelectedRow.Cells[1].Text), (int)this.Session["empresa"]));

                this.ddlPadre.DataSource = jerarquia.GetJerarquiaNivel(
                    Convert.ToInt16(this.ddlNivelPadre.SelectedValue), (int)this.Session["empresa"]);
                this.ddlPadre.DataValueField = "hijo";
                this.ddlPadre.DataTextField = "descripcion";
                this.ddlPadre.DataBind();

                if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                {
                    this.ddlPadre.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
                }
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



    #endregion Eventos

    protected void ddlNivel_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt16(this.ddlNivel.SelectedValue) == 1)
        {
            this.ddlNivelPadre.Enabled = false;
            this.ddlPadre.Enabled = false;
        }
        else
        {
            this.ddlNivelPadre.Enabled = true;
            this.ddlPadre.Enabled = true;
        }
    }
    protected void ddlNivelPadre_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlNivelPadre.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Seleccione un nivel padre valido";
            return;
        }
        else
        {
            try
            {
                this.ddlPadre.DataSource = jerarquia.GetJerarquiaNivel(
                    Convert.ToInt16(this.ddlNivelPadre.SelectedValue), (int)this.Session["empresa"]);
                this.ddlPadre.DataValueField = "id";
                this.ddlPadre.DataTextField = "cadena";
                this.ddlPadre.DataBind();
                this.ddlPadre.Items.Insert(0, new System.Web.UI.WebControls.ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar jerarquías. Correspondiente a :" + ex.Message, "C");
            }

        }
    }
    protected void txtCodigo_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }
}