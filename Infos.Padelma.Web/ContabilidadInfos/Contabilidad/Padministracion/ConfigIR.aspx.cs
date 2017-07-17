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

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    CConfigClaseIR configimpret = new CConfigClaseIR();
    ADInfos.AccesoDatos accesodatos = new ADInfos.AccesoDatos();
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
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            this.gvLista.DataSource = configimpret.BuscarEntidad(
                this.nitxtBusqueda.Text, Convert.ToInt16(this.Session["empresa"]));

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              "C",
               ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex",
              this.gvLista.Rows.Count.ToString() + " Registros encontrados",
              ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, consulta);
        }
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        this.rbImpuestoRetencion.Visible = false;

        seguridad.InsertaLog(
                this.Session["usuario"].ToString(),
                operacion,
                ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
                "er",
                error,
                ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));

        this.Response.Redirect("~/Contabilidad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;
        this.rbImpuestoRetencion.Visible = false;

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
                ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));

        GetEntidad();
    }



    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(this.Session["empresa"]) };

        try
        {
            if (accesodatos.EntidadGetKey(
                "cClaseIR",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Centro de Costo " + this.txtCodigo.Text + " ya se encuentra registrado";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

                this.nilbNuevo.Visible = true;
                this.txtCodigo.Text = "";
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
        bool impuesto = false;
        bool retencion = false;
        bool libreimpuesto = false;
        bool autorretenedor = false;
        bool regimensimplificado = false;
        bool responsableImpuesto = false;
        string codigo = "";
        try
        {

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                codigo = txtCodigo.Text;
            }
            else
            {
                codigo = Cgeneral.RetornaConsecutivoAutomatico("cConfigClaseIR", "codigo", Convert.ToInt16(this.Session["empresa"]));
            }

            switch (rbCaracteristica.SelectedValue)
            {
                case "AU":
                    autorretenedor = true;
                    break;
                case "LI":
                    libreimpuesto = true;
                    break;
                case "RS":
                    regimensimplificado = true;
                    break;

                case "RI":
                    responsableImpuesto = true;
                    break;
            }

            retencion = rbImpuestoRetencion.Items[1].Selected;
            impuesto = rbImpuestoRetencion.Items[0].Selected;

            object[] objValores = new object[]{  
                    chkActivo.Checked,    //@activo
                    autorretenedor,   // @auretenedor	bit
                    codigo,   //@codigo	int
                    txtDescripcion.Text,    //@descripcion	varchar
                    Convert.ToInt32(this.Session["empresa"]),    //@empresa	int
                    impuesto,    //@impuesto	bit
                    libreimpuesto,   //@libre	bit
                    regimensimplificado,   //@regimensimplificado	bit
                    responsableImpuesto, //@responsableimpuesto
                    retencion   //@retencion	bit
            };

            switch (accesodatos.EntidadInsertUpdateDelete(
                "cConfigClaseIR",
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

                if (this.txtCodigo.Text.Length > 0)
                {
                    this.txtDescripcion.Focus();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

    protected void lbNuevo_Click(object sender, EventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(
               this.Session["usuario"].ToString(),
               ConfigurationManager.AppSettings["modulo"].ToString(),
               nombrePaginaActual(),
               insertar,
               Convert.ToInt32(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "I");
            return;
        }


        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.txtCodigo.Enabled = false;
        this.txtCodigo.Text = Cgeneral.RetornaConsecutivoAutomatico("cConfigClaseIR", "codigo", Convert.ToInt16(this.Session["empresa"]));
        this.txtDescripcion.Focus();
        this.nilblInformacion.Text = "";
        rbImpuestoRetencion.Visible = true;
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
        this.rbImpuestoRetencion.Visible = false;
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        this.nilblInformacion.Text = "";
        this.nilblMensaje.Text = "";

        this.nilbNuevo.Visible = true;
        rbImpuestoRetencion.Visible = false;

        GetEntidad();
    }



    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
               this.Session["usuario"].ToString(),
               ConfigurationManager.AppSettings["modulo"].ToString(),
               nombrePaginaActual(),
               editar,
               Convert.ToInt32(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        this.rbImpuestoRetencion.Visible = true;
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.txtCodigo.Enabled = false;
        this.txtDescripcion.Focus();

        try
        {

            if (this.gvLista.SelectedRow.Cells[2].Text != "")
            {
                this.txtCodigo.Text = this.gvLista.SelectedRow.Cells[2].Text;
                this.txtCodigo.Enabled = false;
            }
            else
            {
                this.txtCodigo.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "")
            {
                this.txtDescripcion.Text = this.gvLista.SelectedRow.Cells[3].Text;
            }
            else
            {
                this.txtDescripcion.Text = "";
            }


            foreach (Control c in gvLista.SelectedRow.Cells[4].Controls)
            {
                if (c is CheckBox)
                {
                    if (((CheckBox)c).Checked)
                    {
                        rbImpuestoRetencion.Items[0].Selected = ((CheckBox)c).Checked;

                    }
                }

            }

            foreach (Control c in gvLista.SelectedRow.Cells[5].Controls)
            {
                if (c is CheckBox)
                {
                    if (((CheckBox)c).Checked)
                    {
                        rbImpuestoRetencion.Items[1].Selected = ((CheckBox)c).Checked;

                    }
                }

            }


            foreach (Control c in gvLista.SelectedRow.Cells[6].Controls)
            {
                if (c is CheckBox)
                {
                    if (((CheckBox)c).Checked)
                    {
                        rbCaracteristica.SelectedValue = "AU";
                    }

                }

            }

            foreach (Control c in gvLista.SelectedRow.Cells[7].Controls)
            {
                if (c is CheckBox)
                {
                    if (((CheckBox)c).Checked)
                    {
                        rbCaracteristica.SelectedValue = "LI";
                    }

                }

            }


            foreach (Control c in gvLista.SelectedRow.Cells[8].Controls)
            {
                if (c is CheckBox)
                {
                    if (((CheckBox)c).Checked)
                    {
                        rbCaracteristica.SelectedValue = "RS";
                    }

                }

            }


            foreach (Control c in gvLista.SelectedRow.Cells[9].Controls)
            {
                if (c is CheckBox)
                {
                    if (((CheckBox)c).Checked)
                    {
                        rbCaracteristica.SelectedValue = "RI";
                    }

                }

            }

            foreach (Control c in gvLista.SelectedRow.Cells[10].Controls)
            {
                if (c is CheckBox)
                {
                    chkActivo.Checked = ((CheckBox)c).Checked;
                }

            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
            this.Session["usuario"].ToString(),
            ConfigurationManager.AppSettings["modulo"].ToString(),
            nombrePaginaActual(),
            eliminar,
            Convert.ToInt32(this.Session["empresa"].ToString())) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "E");
            return;
        }

        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToInt16(this.Session["empresa"])
     };

            if (accesodatos.EntidadInsertUpdateDelete(
                "cConfigClaseIR",
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

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        if (Convert.ToBoolean(this.Session["editar"]) == false)
            EntidadKey();
    }

    #endregion Eventos

    protected void lbRegistrar_Click1(object sender, ImageClickEventArgs e)
    {
        if (txtCodigo.Text.Length == 0 || txtDescripcion.Text.Length == 0
            )
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

        Guardar();
    }

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }


    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        gvLista.DataBind();
        GetEntidad();
    }
}
