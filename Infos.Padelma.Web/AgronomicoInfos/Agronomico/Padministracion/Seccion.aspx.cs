using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_Seccion : System.Web.UI.Page
{
    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cseccion seccion = new Cseccion();
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
                                    nombrePaginaActual(), "C", Convert.ToInt32(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

            this.gvLista.DataSource = seccion.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt32(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
                this.Session["usuario"].ToString(), "C",
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt32(Session["empresa"]));

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
            error, ip.ObtenerIP(), Convert.ToInt32(Session["empresa"]));

        this.Response.Redirect("~/Agronomico/Error.aspx", false);
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
            mensaje, ip.ObtenerIP(), Convert.ToInt32(Session["empresa"]));

        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlFinca.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "aFinca", "ppa"), "descripcion", Convert.ToInt32(Session["empresa"]));
            this.ddlFinca.DataValueField = "codigo";
            this.ddlFinca.DataTextField = "descripcion";
            this.ddlFinca.DataBind();
            this.ddlFinca.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar usuarios. Correspondiente a: " + ex.Message, "C");
        }



    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text.Trim().ToString(), Convert.ToInt32(Session["empresa"]), ddlFinca.SelectedValue };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "aSecciones",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "C�digo " + this.txtCodigo.Text + " ya se encuentra registrado";

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

            object[] objValores = new object[]{
                    chkActivo.Checked,
                    this.txtCodigo.Text.Trim().ToString(),
                    this.txtDescripcion.Text,
                    Convert.ToInt32(Session["empresa"]),
                    ddlFinca.SelectedValue,
                    Convert.ToDecimal(txtHectareas.Text)
                   
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "aSecciones",
                operacion,
                "ppa",
                objValores))
            {
                case 0:

                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                    break;

                case 1:

                    ManejoError("Errores al insertar el registro. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
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
                ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt32(Session["empresa"])) != 0)
            {
                this.txtCodigo.Focus();

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
            }
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                    nombrePaginaActual(), "I", Convert.ToInt32(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        CargarCombos();

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
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
        txtDescripcion.Focus();
    }

    protected void ddlFinca_SelectedIndexChanged(object sender, EventArgs e)
    {
        EntidadKey();
        txtCodigo.Focus();
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                    nombrePaginaActual(), "E", Convert.ToInt32(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

            object[] objValores = new object[] {
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToInt32(Session["empresa"]),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[4].Text))
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "aSecciones",
                "elimina",
                "ppa",
                objValores))
            {
                case 0:

                    ManejoExito("Registro eliminado satisfactoriamente", "E");
                    break;

                case 1:

                    ManejoError("Error al eliminar el registro. Operaci�n no realizada", "E");
                    break;
            }
        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El c�digo ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociaci�n, no es posible eliminar el registro.", "E");
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
        if (this.txtDescripcion.Text.Length == 0 || this.txtCodigo.Text.Length == 0 || ddlFinca.SelectedValue.Length == 0 || Convert.ToDecimal(txtHectareas.Text) == 0 || txtHectareas.Text.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        Guardar();
    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(
          this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        CargarCombos();
        this.txtCodigo.Enabled = false;
        ddlFinca.Enabled = false;
        this.txtDescripcion.Focus();

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            }
            else
            {
                this.txtCodigo.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            }
            else
            {
                this.txtDescripcion.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                ddlFinca.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.txtHectareas.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);
            }
            else
            {
                this.txtHectareas.Text = "0";
            }


            foreach (Control objControl in this.gvLista.SelectedRow.Cells[6].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkActivo.Checked = ((CheckBox)objControl).Checked;
                }
            }


        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
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






}