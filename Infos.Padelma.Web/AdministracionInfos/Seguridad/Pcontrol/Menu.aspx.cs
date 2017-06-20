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

public partial class Admon_Padministracion_Menu : System.Web.UI.Page
{
    #region Instancias

    
    Cmenu menu = new Cmenu();
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
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", consulta);
                return;
            }

            this.gvLista.DataSource = menu.GetMenuSitio(
                Convert.ToString(this.niddlSitio.SelectedValue));

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
            this.niddlSitio.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresa(CentidadMetodos.EntidadGet(
                "sModulos", "ppa"), "descripcion");
            this.niddlSitio.DataValueField = "codigo";
            this.niddlSitio.DataTextField = "descripcion";
            this.niddlSitio.DataBind();
            this.niddlSitio.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar sitios web. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { 
            this.txtDescripcion.Text,
            Convert.ToString(this.niddlSitio.SelectedValue)
        };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "sMenu",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Menu " + this.txtDescripcion.Text + " ya se encuentra registrado";

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

        if (this.txtDescripcion.Text.Length == 0 || Convert.ToString(this.niddlSitio.SelectedValue).Length == 0 || this.txtPagina.Text.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
        }
        else
        {
            try
            {
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                }

                object[] objValores = new object[]{
                    chkActivo.Checked,
                    this.txtCodigo.Text,
                    this.txtDescripcion.Text,
                    Convert.ToString(this.niddlSitio.SelectedValue),
                    this.txtPagina.Text
                    
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "sMenu",
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
                if (this.txtDescripcion.Text.Length == 0)
                {
                    this.niddlSitio.Focus();
                }
                else
                {
                    this.txtPagina.Focus();
                }

                if (!IsPostBack)
                {
                    CargarCombos();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
            }
              
            
        }
    }

    protected void lbNuevo_Click(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                              this.Session["usuario"].ToString(),//usuario
                               ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                               nombrePaginaActual(),//pagina
                              insertar,//operacion
                             Convert.ToInt16(this.Session["empresa"]))//empresa
                             == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", insertar);
            return;
        }


        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.txtDescripcion.Enabled = true;
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

 protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Seguridad.aspx");
    }

    protected void niddlSitio_SelectedIndexChanged(object sender, EventArgs e)
    {
        GetEntidad();
        this.txtDescripcion.Focus();
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
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", eliminar);
                return;
            }


            object[] objValores = new object[] {
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text),
                Convert.ToString(this.niddlSitio.SelectedValue)
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "sMenu",
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


    #endregion Eventos


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
                            editar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n",editar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(
          this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.txtCodigo.Enabled = false;
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
                this.txtPagina.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            }
            else
            {
                this.txtDescripcion.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[5].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkActivo.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }
   
}