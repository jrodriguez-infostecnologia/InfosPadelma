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

public partial class Admon_Padministracion_TiposTransaccion : System.Web.UI.Page
{
    #region Instancias

    CtiposTransaccion tipoTransaccion = new CtiposTransaccion();
    AccesoDatos.AccesoDatos accesodatos = new AccesoDatos.AccesoDatos();
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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                              nombrePaginaActual(), consulta, Convert.ToInt16(this.Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", consulta);
                return;
            }
            this.gvLista.DataSource = tipoTransaccion.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), consulta, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex", this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
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
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
                       ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;
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
            this.ddlModulo.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresayActivo(
                accesodatos.EntidadGet("sModulos", "ppa"), "descripcion");
            this.ddlModulo.DataValueField = "codigo";
            this.ddlModulo.DataTextField = "descripcion";
            this.ddlModulo.DataBind();
            this.ddlModulo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar modulos. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(Session["empresa"]) };

        try
        {
            if (accesodatos.EntidadGetKey("gTipoTransaccion", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Tipo de transacción " + this.txtCodigo.Text + " ya se encuentra registrada";
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

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            object[] objValores = new object[]{                
                chkActivo.Checked,
                Convert.ToInt32(this.txtActual.Text),
                this.txtCodigo.Text,
                this.txtDescripcion.Text,
                Convert.ToInt16(Session["empresa"]),
                DateTime.Now,
                Convert.ToInt16(this.txtLongitud.Text),
                Convert.ToString(this.ddlModoAnulacion.SelectedValue),
                Convert.ToString(this.ddlModulo.SelectedValue),
                Convert.ToString(this.ddlNaturaleza.SelectedValue),
                this.chkNumeracion.Checked,
                this.txtPrefijo.Text,
                this.chkReferencia.Checked,
                this.txtDataSet.Text
            };

            switch (accesodatos.EntidadInsertUpdateDelete(
                "gTipoTransaccion",
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
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                    nombrePaginaActual(), Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();

                if (this.txtCodigo.Text.Length > 0)
                    this.txtDescripcion.Focus();
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                             nombrePaginaActual(), insertar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", insertar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();
        this.txtCodigo.Enabled = true;
        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
        this.txtDataSet.Enabled = false;
        this.txtDataSet.Text = "";
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }


    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                             nombrePaginaActual(), editar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.txtCodigo.Enabled = false;
        this.txtDescripcion.Focus();
        this.txtDataSet.Enabled = false;
        this.txtDataSet.Text = "";

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txtCodigo.Text = this.gvLista.SelectedRow.Cells[2].Text;
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            else
                this.txtDescripcion.Text = "";

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[4].Controls)
            {
                if (objControl is CheckBox)
                    this.chkNumeracion.Checked = ((CheckBox)objControl).Checked;
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                this.txtActual.Text = this.gvLista.SelectedRow.Cells[5].Text;
            else
                this.txtActual.Text = "";

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                this.txtPrefijo.Text = this.gvLista.SelectedRow.Cells[6].Text;
            else
                this.txtPrefijo.Text = "";

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                this.txtLongitud.Text = this.gvLista.SelectedRow.Cells[7].Text;
            else
                this.txtLongitud.Text = "";

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.ddlNaturaleza.SelectedValue = this.gvLista.SelectedRow.Cells[8].Text;

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                this.ddlModulo.SelectedValue = this.gvLista.SelectedRow.Cells[9].Text;

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                this.ddlModoAnulacion.SelectedValue = this.gvLista.SelectedRow.Cells[10].Text;

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                if (objControl is CheckBox)
                    this.chkReferencia.Checked = ((CheckBox)objControl).Checked;
            }

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
                this.txtDataSet.Text = this.gvLista.SelectedRow.Cells[12].Text;
            else
                this.txtDataSet.Text = "";

            if (this.chkReferencia.Checked == true)
                this.txtDataSet.Enabled = true;

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                if (objControl is CheckBox)
                    this.chkReferencia.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[13].Controls)
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

    protected void chkReferencia_CheckedChanged(object sender, EventArgs e)
    {
        if (((CheckBox)sender).Checked == true)
        {
            this.txtDataSet.Enabled = true;
            this.txtDataSet.Focus();
        }
        else
        {
            this.txtDataSet.Enabled = false;
            ((CheckBox)sender).Focus();
        }
    }

    #endregion Eventos


    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (txtCodigo.Text.Length == 0 || txtDescripcion.Text.Length == 0 || txtActual.Text.Length == 0 || txtLongitud.Text.Length == 0 || txtPrefijo.Text.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        if (chkReferencia.Checked)
        {
            if (txtDataSet.Text.Length == 0)
            {
                nilblInformacion.Text = "Campos vacios por favor corrija";
                return;
            }
        }
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
            object[] objValores = new object[] { Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)), Convert.ToInt16(Session["empresa"]) };

            if (accesodatos.EntidadInsertUpdateDelete("gTipoTransaccion", operacion, "ppa", objValores) == 0)
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            else
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro.", "E");
            }
            else
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();


    }
}
