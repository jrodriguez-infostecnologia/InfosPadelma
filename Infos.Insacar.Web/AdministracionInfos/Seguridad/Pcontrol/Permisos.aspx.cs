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

public partial class Seguridad_Pcontrol_Permisos : System.Web.UI.Page
{
    #region Instancias


    Cperfiles perfiles = new Cperfiles();
    Cmenu menu = new Cmenu();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";


    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void CargarMenuSitio()
    {
        try
        {
            this.ddlMenu.DataSource = menu.GetMenuSitio(
                Convert.ToString(this.ddlSitio.SelectedValue));

            this.ddlMenu.DataValueField = "codigo";
            this.ddlMenu.DataTextField = "descripcion";
            this.ddlMenu.DataBind();
            this.ddlMenu.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar menu. Correspondiente a: " + ex.Message, "C");
        }
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


            this.gvLista.DataSource = perfiles.GetPermisosPerfilCab(
                Convert.ToString(this.niddlPerfil.SelectedValue));

            this.gvLista.DataBind();

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
               error,
                ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

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
              mensaje,
              ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.niddlPerfil.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresayActivo(CentidadMetodos.EntidadGet(
                "sPerfiles", "ppa"), "descripcion");

            this.niddlPerfil.DataValueField = "codigo";
            this.niddlPerfil.DataTextField = "descripcion";
            this.niddlPerfil.DataBind();
            this.niddlPerfil.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar sitios web. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlOperacion.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresayActivo(CentidadMetodos.EntidadGet(
                "sOperaciones", "ppa"), "descripcion");

            this.ddlOperacion.DataValueField = "codigo";
            this.ddlOperacion.DataTextField = "descripcion";
            this.ddlOperacion.DataBind();
            this.ddlOperacion.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar operaciones. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlSitio.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresayActivo(CentidadMetodos.EntidadGet(
                "sModulos", "ppa"), "descripcion");

            this.ddlSitio.DataValueField = "codigo";
            this.ddlSitio.DataTextField = "descripcion";
            this.ddlSitio.DataBind();
            this.ddlSitio.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar sitios. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { 
            Convert.ToString(this.ddlMenu.SelectedValue),
            Convert.ToString(this.ddlOperacion.SelectedValue),
            Convert.ToString(this.niddlPerfil.SelectedValue),
            Convert.ToString(this.ddlSitio.SelectedValue)
        };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "sPerfilPermisos",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Permiso ya se encuentra registrado";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

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
        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                object[] objValores = new object[]{
                    this.chkPermitir.Checked,
                    Convert.ToString(this.ddlMenu.SelectedValue),
                    Convert.ToString(this.ddlOperacion.SelectedValue),
                    Convert.ToString(this.niddlPerfil.SelectedValue),
                    Convert.ToString(this.ddlSitio.SelectedValue)
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "sPerfilPermisos",
                    "actualiza",
                    "ppa",
                    objValores))
                {
                    case 0:

                        ManejoExito("Datos insertados satisfactoriamente", "A");
                        break;

                    case 1:

                        ManejoError("Error al modificar el registro", "A");
                        break;
                }
            }
            else
            {
                switch (perfiles.InsertaPerfilPermisos(
                    this.chkPermitir.Checked,
                    Convert.ToString(this.niddlPerfil.SelectedValue),
                    Convert.ToString(this.ddlSitio.SelectedValue),
                    Convert.ToString(this.ddlMenu.SelectedValue),
                    Convert.ToString(this.ddlOperacion.SelectedValue),
                    this.chkOperacion.Checked))
                {
                    case 0:

                        ManejoExito("Datos insertados satisfactoriamente", "I");
                        break;

                    case 1:

                        ManejoError("Errores al insertar el registro. Operación no realizada", "I");
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, "I");
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
            if (seguridad.VerificaAccesoPagina(
                    this.Session["usuario"].ToString(),
                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                    nombrePaginaActual(),
                    Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                this.niddlPerfil.Focus();

                if (!IsPostBack)
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

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(
                                 this.Session["usuario"].ToString(),//usuario
                                  ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                                  nombrePaginaActual(),//pagina
                                 insertar,//operacion
                                Convert.ToInt16(this.Session["empresa"]))//empresa
                                == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", insertar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.niddlPerfil.Enabled = true;
        this.ddlSitio.Enabled = true;
        this.ddlMenu.Enabled = true;
        this.ddlOperacion.Enabled = true;
        this.nilblInformacion.Text = "";
        this.chkOperacion.Enabled = true;
        this.ddlSitio.Focus();
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
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



    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void nilblRegresar_Click(object sender, EventArgs e)
    {
        Response.Redirect("Seguridad.aspx");
    }

    protected void niddlSitio_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEntidad();
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            eliminar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", eliminar);
                return;
            }

            switch (perfiles.EliminaPermisosPerfilSitioMenu(
                this.gvLista.Rows[e.RowIndex].Cells[2].Text,
                this.gvLista.Rows[e.RowIndex].Cells[3].Text,
                this.gvLista.Rows[e.RowIndex].Cells[4].Text))
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
            ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             editar,//operacion
                            Convert.ToInt16(this.Session["empresa"]))//empresa
                            == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }


        this.Session["editar"] = true;

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.niddlPerfil.Enabled = false;
        this.ddlSitio.Enabled = false;
        this.ddlMenu.Enabled = false;
        this.ddlOperacion.Enabled = false;
        this.chkOperacion.Enabled = false;
        this.chkPermitir.Focus();

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.niddlPerfil.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.ddlSitio.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
            }

            CargarMenuSitio();

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.ddlMenu.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.ddlOperacion.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text;
            }

            foreach (Control objControl in gvLista.SelectedRow.Cells[6].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkPermitir.Checked = ((CheckBox)objControl).Checked;
                }
            }
        }
        catch
        {
        }
    }

    protected void chkOperacion_CheckedChanged(object sender, EventArgs e)
    {
        if (this.chkOperacion.Checked == true)
        {
            this.ddlOperacion.Enabled = false;
            this.chkPermitir.Enabled = false;
        }
        else
        {
            this.ddlOperacion.Enabled = true;
            this.chkPermitir.Enabled = true;
        }
    }

    protected void ddlSitio_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarMenuSitio();
    }

    #endregion Eventos

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }


}