using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    Cusuarios usuario = new Cusuarios();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
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


            this.gvLista.DataSource = usuario.BuscarEntidadPerfil(
                this.nitxtBusqueda.Text);

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
               this.Session["usuario"].ToString(),
               "C",
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
              operacion,
              ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlUsuario.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresayActivo(CentidadMetodos.EntidadGet(
                "sUsuarios", "ppa"), "descripcion");

            this.ddlUsuario.DataValueField = "usuario";
            this.ddlUsuario.DataTextField = "descripcion";
            this.ddlUsuario.DataBind();
            this.ddlUsuario.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar usuarios. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPerfil.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresayActivo(CentidadMetodos.EntidadGet(
                "sperfiles", "ppa"), "descripcion");

            this.ddlPerfil.DataValueField = "codigo";
            this.ddlPerfil.DataTextField = "descripcion";
            this.ddlPerfil.DataBind();
            this.ddlPerfil.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar perfiles. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlEmpresa.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresayActivo(CentidadMetodos.EntidadGet(
                "gEmpresa", "ppa"), "razonSocial");

            this.ddlEmpresa.DataValueField = "id";
            this.ddlEmpresa.DataTextField = "razonSocial";
            this.ddlEmpresa.DataBind();
            this.ddlEmpresa.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar perfiles. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { 
            Convert.ToString(this.ddlEmpresa.SelectedValue),
            Convert.ToString(this.ddlUsuario.SelectedValue)
        };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "sUsuarioPerfiles",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Usuario - Perfil ya se encuentra registrado";

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
        string operacion = "inserta";

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }

            object[] objValores = new object[] {
                this.chkActivo.Checked,
                Convert.ToInt16(  ddlEmpresa.SelectedValue),
                Convert.ToString(this.ddlPerfil.SelectedValue),
                Convert.ToString(this.ddlUsuario.SelectedValue)                
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "sUsuarioPerfiles",
                operacion,
                "ppa",
                objValores))
            {
                case 0:

                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                    break;

                case 1:

                    ManejoError("Error al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
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
            if (seguridad.VerificaAccesoPagina(
                     this.Session["usuario"].ToString(),
                     ConfigurationManager.AppSettings["Modulo"].ToString(),
                     nombrePaginaActual(),
                     Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();

                if (Convert.ToString(this.ddlUsuario.SelectedValue).Length > 0)
                {
                    this.ddlPerfil.Focus();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
                
            }
           
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

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

  protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        Guardar();
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

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.ddlEmpresa.Enabled = false;
        this.ddlUsuario.Enabled = false;
        this.ddlPerfil.Focus();

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.ddlEmpresa.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;
            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.ddlUsuario.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.ddlPerfil.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[5].Controls)
            {
                if (objControl is CheckBox)
                    this.chkActivo.Checked = ((CheckBox)objControl).Checked;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
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

            object[] objValores = new object[] {
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[4].Text),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[3].Text)
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "sUsuarioPerfiles",
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
            ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

    protected void nilblRegresar_Click(object sender, EventArgs e)
    {
        Response.Redirect("Seguridad.aspx");
    }

    #endregion Eventos
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }


    protected void nilbNuevo_Click(object sender, ImageClickEventArgs e)
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

        CargarCombos();

        this.ddlUsuario.Enabled = true;
        this.ddlEmpresa.Focus();
        this.nilblInformacion.Text = "";
    }



    protected void ddlPerfil_SelectedIndexChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }
    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Seguridad.aspx");
    }
   
}
