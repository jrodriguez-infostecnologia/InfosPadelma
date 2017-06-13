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

public partial class Admon_Padministracion_TiposTransaccionCampos : System.Web.UI.Page
{

    #region Instancias

    CtiposTransaccion tipoTransaccion = new CtiposTransaccion();
    Centidades entidades = new Centidades();
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

            this.gvLista.DataSource = tipoTransaccion.BuscarEntidadCampo(
                this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

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
              mensaje,
               ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlEntidad.DataSource = entidades.BuscarEntidad();
            this.ddlEntidad.DataValueField = "name";
            this.ddlEntidad.DataTextField = "name";
            this.ddlEntidad.DataBind();
            this.ddlEntidad.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar entidades. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTipoTransaccion.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlTipoTransaccion.DataValueField = "codigo";
            this.ddlTipoTransaccion.DataTextField = "descripcion";
            this.ddlTipoTransaccion.DataBind();
            this.ddlTipoTransaccion.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo de transacción. Correspondiente a: " + ex.Message, "C");
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
                this.chkAplicaCliente.Checked,
                this.chkAplicaProveedor.Checked,
                this.chkAplicaTercero.Checked,
                Convert.ToString(this.ddlCampo.SelectedValue),
                Convert.ToInt16(Session["empresa"]),
                Convert.ToString(ddlEntidad.SelectedValue),
                this.chkTercero.Checked,
                this.chkTerceroDefecto.Checked,
                Convert.ToString(this.ddlTipoCampo.SelectedValue),
                Convert.ToString(this.ddlTipoTransaccion.SelectedValue)
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "gTipoTransaccionCampo",
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


    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
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
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();
        GetEntidad();

        this.ddlTipoTransaccion.Enabled = true;
        this.ddlTipoTransaccion.Focus();
        this.ddlEntidad.Enabled = true;
        this.ddlCampo.Enabled = true;
        this.nilblInformacion.Text = "";
        this.nilblMensaje.Text = "";
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

    protected void lbRegistrar_Click(object sender, EventArgs e)
    {
        this.nilblMensaje.Text = "";
        Guardar();
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
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

        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[4].Text),
                Convert.ToInt16(Session["empresa"]),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[3].Text),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text)
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "gTipoTransaccionCampo",
                operacion,
                "ppa",
                objValores) == 0)
            {
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
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
        this.ddlTipoTransaccion.Enabled = false;
        this.ddlEntidad.Enabled = false;
        this.ddlCampo.Enabled = false;
        this.ddlTipoCampo.Focus();

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.ddlTipoTransaccion.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.ddlEntidad.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.ddlCampo.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.ddlTipoCampo.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text;
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[6].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkTercero.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[7].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkAplicaCliente.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkAplicaProveedor.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[9].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkAplicaTercero.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[10].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkTerceroDefecto.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlEntidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.ddlCampo.Focus();

        try
        {
            this.ddlCampo.DataSource = entidades.GetEntidadCampoEntidad(
                Convert.ToString(((DropDownList)sender).SelectedValue));
            this.ddlCampo.DataValueField = "campo";
            this.ddlCampo.DataTextField = "campo";
            this.ddlCampo.DataBind();
            this.ddlCampo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar campos de la entidad. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Eventos

}
