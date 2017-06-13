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

            this.gvLista.DataSource = tipoTransaccion.BuscarEntidadConfig(
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
            this.ddlNivelDestino.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("iNivelDestino", "ppa"),
                                                        "codigo", Convert.ToInt16(Session["empresa"]));
            this.ddlNivelDestino.DataValueField = "codigo";
            this.ddlNivelDestino.DataTextField = "descripcion";
            this.ddlNivelDestino.DataBind();
            this.ddlNivelDestino.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar niveles de destino. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTipoTransaccion.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
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
        string operacion = "inserta", tipoNomino = null;

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            if (chkTipoLiquidacionNomina.Checked)
                tipoNomino = ddlTipoLiquidacionNomina.SelectedValue;

            object[] objValores = new object[]{                
                this.chkAjuste.Checked,
                this.chkCantidadEditable.Checked,
                this.chkConsignacion.Checked,
                this.chkDias.Checked,
                this.txtDsReferenciaDetalle.Text.Trim(),
                Convert.ToInt16(Session["empresa"]),
                this.chkEntradaDirecta.Checked,
                this.chkEstudioCompra.Checked,
                this.chkFecha.Checked,
                this.txtFormatoImpresion.Text.Trim(),
                this.chkLiberaReferencia.Checked,
                chkManejaBascula.Checked,
                this.chkManejaBodega.Checked,
                this.chkDocumento.Checked,
                this.chkManejaTalonario.Checked,
                chkTipoLiquidacionNomina.Checked,
                Convert.ToInt16(this.ddlNivelDestino.SelectedValue),
                this.chkPdesEditable.Checked,
                this.chkPivaEditable.Checked,
                this.chkReferenciaTercero.Checked,
                this.chkRegistroDirecto.Checked,
                this.chkRegistroProveedor.Checked,
                this.chkSalida.Checked,
                Convert.ToString(this.ddlTipoLiquidacionNomina.SelectedValue),
                Convert.ToString(this.ddlTipoTransaccion.SelectedValue),
                this.chkUmedidaEditable.Checked,
                this.chkValidaSaldo.Checked,
                this.chkVigencia.Checked,
                this.chkVunitarioEditable.Checked

            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("gTipoTransaccionConfig", operacion, "ppa", objValores))
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
                this.nitxtBusqueda.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
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

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();
        GetEntidad();
        this.ddlTipoTransaccion.Enabled = true;
        this.ddlTipoTransaccion.Focus();
        this.nilblInformacion.Text = "";
        this.nilblMensaje.Text = "";
        ValidaLiquidacion();
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

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlTipoTransaccion.SelectedValue.Length == 0 || ddlNivelDestino.SelectedValue.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

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
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text)
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "gTipoTransaccionConfig",
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
        this.ddlNivelDestino.Focus();

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.ddlTipoTransaccion.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.ddlNivelDestino.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.txtFormatoImpresion.Text = this.gvLista.SelectedRow.Cells[4].Text;
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.txtDsReferenciaDetalle.Text = this.gvLista.SelectedRow.Cells[5].Text;
            }


            foreach (Control objControl in this.gvLista.SelectedRow.Cells[6].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkAjuste.Checked = ((CheckBox)objControl).Checked;
                }
            }


            foreach (Control objControl in this.gvLista.SelectedRow.Cells[7].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkSalida.Checked = ((CheckBox)objControl).Checked;
                }
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkValidaSaldo.Checked = ((CheckBox)objControl).Checked;
                }
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[9].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkReferenciaTercero.Checked = ((CheckBox)objControl).Checked;
                }
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[10].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkCantidadEditable.Checked = ((CheckBox)objControl).Checked;
                }
            }


            foreach (Control objControl in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                if (objControl is CheckBox)
                    this.chkVunitarioEditable.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
            {
                if (objControl is CheckBox)
                    this.chkPivaEditable.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[13].Controls)
            {
                if (objControl is CheckBox)
                    this.chkManejaTalonario.Checked = ((CheckBox)objControl).Checked;
            }


            foreach (Control objControl in this.gvLista.SelectedRow.Cells[14].Controls)
            {
                if (objControl is CheckBox)
                    this.chkManejaBodega.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[15].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLiberaReferencia.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[16].Controls)
            {
                if (objControl is CheckBox)
                    this.chkEntradaDirecta.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[17].Controls)
            {
                if (objControl is CheckBox)
                    this.chkRegistroDirecto.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[18].Controls)
            {
                if (objControl is CheckBox)
                    this.chkConsignacion.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[19].Controls)
            {
                if (objControl is CheckBox)
                    this.chkDias.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[20].Controls)
            {
                if (objControl is CheckBox)
                    this.chkDocumento.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[20].Controls)
            {
                if (objControl is CheckBox)
                    this.chkDocumento.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[21].Controls)
            {
                if (objControl is CheckBox)
                    this.chkVigencia.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[22].Controls)
            {
                if (objControl is CheckBox)
                    this.chkPdesEditable.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[23].Controls)
            {
                if (objControl is CheckBox)
                    this.chkUmedidaEditable.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[24].Controls)
            {
                if (objControl is CheckBox)
                    this.chkEstudioCompra.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[25].Controls)
            {
                if (objControl is CheckBox)
                    this.chkRegistroProveedor.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[26].Controls)
            {
                if (objControl is CheckBox)
                    this.chkFecha.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[27].Controls)
            {
                if (objControl is CheckBox)
                    this.chkManejaBascula.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[28].Controls)
            {
                if (objControl is CheckBox)
                    this.chkTipoLiquidacionNomina.Checked = ((CheckBox)objControl).Checked;
            }

            ValidaLiquidacion();
            if (this.gvLista.SelectedRow.Cells[29].Text != "&nbsp;")
                ddlTipoLiquidacionNomina.SelectedValue = this.gvLista.SelectedRow.Cells[29].Text;


        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    #endregion Eventos


    protected void chkLiquidacion_CheckedChanged(object sender, EventArgs e)
    {
        ValidaLiquidacion();

    }

    private void ValidaLiquidacion()
    {
        if (chkTipoLiquidacionNomina.Checked)
            ddlTipoLiquidacionNomina.Enabled = true;
        else
            ddlTipoLiquidacionNomina.Enabled = false;
    }

}
