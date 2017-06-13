using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Agronomico_Padministracion_Labor : System.Web.UI.Page
{
    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cnovedad novedad = new Cnovedad();
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

    private void Consecutivo()
    {
        try
        {
            this.txtCodigo.Text = novedad.Consecutivo(Convert.ToString(this.ddlGrupo.SelectedValue), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el consecutivo. Correspondiente a: " + ex.Message, "C");
        }
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
            DataView dvLabor = novedad.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataSource = dvLabor;
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
        this.Response.Redirect("~/Agronomico/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {

        this.nilblInformacion.Text = mensaje;
        nilblInformacion.ForeColor = System.Drawing.Color.Green;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlGrupo.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("aGrupoNovedad", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlGrupo.DataValueField = "codigo";
            this.ddlGrupo.DataTextField = "descripcion";
            this.ddlGrupo.DataBind();
            this.ddlGrupo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar grupo de Novedad. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlUmedida.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gUnidadMedida", "ppa"), "desCorta", Convert.ToInt16(Session["empresa"]));
            this.ddlUmedida.DataValueField = "codigo";
            this.ddlUmedida.DataTextField = "desCorta";
            this.ddlUmedida.DataBind();
            this.ddlUmedida.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidad de medida. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlCanal.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("aTipoCanal", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlCanal.DataValueField = "codigo";
            this.ddlCanal.DataTextField = "descripcion";
            this.ddlCanal.DataBind();
            this.ddlCanal.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar canales. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlConcepto.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlConcepto.DataValueField = "codigo";
            this.ddlConcepto.DataTextField = "descripcion";
            this.ddlConcepto.DataBind();
            this.ddlConcepto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar canales. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "aNovedad",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Código " + this.txtCodigo.Text + " ya se encuentra registrado";

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
            string grupoIR = null, canal = null, codigo;
            bool hBruta = false;
            bool hNeta = false;
            bool hProduccion = false;
            int añoDesde, añoHasta;

            if (chkImpuesto.Checked)
                grupoIR = ddlGrupoIR.SelectedValue;

            if (chkCalnal.Checked)
                canal = ddlCanal.SelectedValue.Trim();

            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";
            else
                Consecutivo();

            codigo = txtCodigo.Text;

            if (chkRagoSiembra.Checked)
            {
                añoDesde = Convert.ToInt16(Convert.ToDecimal(txvDesde.Text));
                añoHasta = Convert.ToInt16(Convert.ToDecimal(txvHasta.Text));
            }
            else
            {
                añoDesde = 0;
                añoHasta = 0;
            }

            switch (rblTipoHa.SelectedValue.ToString().Trim())
            {
                case "HB":
                    hBruta = true;
                    hNeta = false;
                    hProduccion = false;
                    break;
                case "HN":
                    hBruta = false;
                    hNeta = true;
                    hProduccion = false;
                    break;

                case "HP":
                    hBruta = false;
                    hNeta = false;
                    hProduccion = true;
                    break;

                case "NA":
                    hBruta = false;
                    hNeta = false;
                    hProduccion = false;
                    break;
            }



            object[] objValores = new object[]{
                          chkActivo.Checked,  //            @activo	bit
                          añoDesde,   //@añoDesde	int
                           añoHasta,  //@añoHasta	int
                          Convert.ToDecimal(txvCiclos.Text),   //@ciclos	int
                          Convert.ToInt32(rblClaseLabor.SelectedValue),  //@claseLabor	int
                           codigo,   //@codigo	varchar
                           ddlConcepto.SelectedValue, //@concepto	varchar
                          txtDescripcionCorta.Text,  //@desCorta	varchar
                          this.txtDescripcion.Text,  //@descripcion	varchar
                          Convert.ToInt16(Session["empresa"]),  //@empresa	int
                            txtEquivalencia.Text, //@equivalencia	varchar
                           DateTime.Now, //@fechaRegistro	datetime
                           ddlGrupo.SelectedValue, //@grupo	varchar   
                        grupoIR,   //@grupoIR varchar
                    chkImpuesto.Checked,//@impuesto
                    chkBascula.Checked, //@manejaBascula
                    chkCalnal.Checked,//@manejaCanal
                    chkManejaCaracteristica.Checked, //@manejaCaracteristica bit
                    chkManejaDecimal.Checked,//manejaDecimal
                    chkFecha.Checked,//@manejaFecha
                    chkJornal.Checked,//@manejaJornal
                    chkLinea.Checked,//@manejaLinea
                    chkLote.Checked,//@manejaLote
                    chkPalma.Checked,//@manejaPalma
                    chkRacimos.Checked,//@manejaRacimo
                    chkRagoSiembra.Checked,//@manejaRango
                    chkSaldo.Checked,//@manejaSaldo
                    ddlNaturaleza.SelectedValue,//@naturaleza
                    chkLaborNoPrestacional.Checked,
                    hBruta,//@porHaBruta
                    hNeta,//@porHaNeta
                    hProduccion,//@porHaProduccion
                    Convert.ToDecimal(txvTarea.Text),//@tarea
                    canal, //@tipoCanal
                    ddlUmedida.SelectedValue, //@uMedida
                    Convert.ToString(Session["usuario"])//@usuario
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("aNovedad", operacion, "ppa", objValores))
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
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
                ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
                this.nitxtBusqueda.Focus();
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

        CargarCombos();

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        txtCodigo.Enabled = false;
        txvDesde.Visible = false;
        txvHasta.Visible = false;

        ddlGrupoIR.Visible = false;

        ddlCanal.Visible = false;
        this.txtDescripcion.Focus();
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

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
        chkActivo.Focus();
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

            object[] objValores = new object[] { Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(Session["empresa"]) };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("aNovedad", "elimina", "ppa", objValores))
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

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (this.txtDescripcion.Text.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campo de Descripción vacio por, favor corrija", this.nilblInformacion);
            return;
        }
        if (this.txtCodigo.Text.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campo de Código vacio, por favor corrija", this.nilblInformacion);
            return;
        }

        if (this.txvTarea.Text.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campo de Rendimiento vacio por lo menos (0), por favor corrija", this.nilblInformacion);
            return;
        }

        if (this.txvCiclos.Text.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campo de Ciclos vacio por lo menos (0), por favor corrija", this.nilblInformacion);
            return;
        }


        if (ddlGrupo.SelectedValue.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Debe seleccionar un Grupo de Labor, por favor corrija", this.nilblInformacion);
            return;
        }

        if (ddlGrupo.SelectedValue.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Debe seleccionar una Naturaleza, por favor corrija", this.nilblInformacion);
            return;
        }


        if (chkImpuesto.Checked)
        {
            if (ddlGrupoIR.SelectedValue.Length == 0)
            {
                CcontrolesUsuario.MensajeError("Debe seleccionar un grupo de Imp/Rete, favor corrija", this.nilblInformacion);
                return;
            }
        }

        if (chkRagoSiembra.Checked)
        {
            if (txvDesde.Text.Length == 0 || txvHasta.Text.Length == 0)
            {
                CcontrolesUsuario.MensajeError("Debe digitar un rango de años de siembra", this.nilblInformacion);
                return;
            }

            if (Convert.ToDecimal(txvHasta.Text) == 0)
            {
                CcontrolesUsuario.MensajeError("El rango de años debe ser mayor a 0", this.nilblInformacion);
                return;
            }
        }

        if (Convert.ToInt16(Convert.ToDecimal(txvDesde.Text)) > Convert.ToInt16(Convert.ToDecimal(txvHasta.Text)))
        {
            CcontrolesUsuario.MensajeError("El año hasta no puede ser menor al anterior", this.nilblInformacion);
            return;
        }

        Guardar();
    }

    protected void manejoGrilla(bool manejo)
    {
        for (int x = 0; x < gvLista.Columns.Count; x++)
        {
            if (x >= 6)
                gvLista.Columns[x].Visible = manejo;
        }

    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        CargarCombos();
        this.txtCodigo.Enabled = false;
        try
        {
            DataView dvLabores = null;
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
                dvLabores = novedad.RetornaDatosLabores(txtCodigo.Text, (int)this.Session["empresa"]);
            }
            else
                this.txtCodigo.Text = "";
            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            else
                this.txtDescripcion.Text = "";
            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.txtDescripcionCorta.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            else
                this.txtDescripcionCorta.Text = "";

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                ddlGrupo.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                ddlUmedida.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                this.txvCiclos.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text);
            else
                this.txvCiclos.Text = "0";
            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.txvTarea.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
            else
                this.txvTarea.Text = "0";

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                ddlNaturaleza.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                this.txtEquivalencia.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[10].Text);
            else
                this.txtEquivalencia.Text = "";

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                this.ddlConcepto.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[11].Text);

            foreach (DataRowView registro in dvLabores)
            {
                if (registro.Row.ItemArray.GetValue(9) != null)
                    chkImpuesto.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(9));

                if (chkImpuesto.Checked == true)
                {
                    CargarImpuesto();

                    if (registro.Row.ItemArray.GetValue(12) != null)
                        ddlGrupoIR.SelectedValue = registro.Row.ItemArray.GetValue(12).ToString();
                }
                else
                {
                    this.ddlGrupoIR.DataSource = null;
                    this.ddlGrupoIR.DataBind();
                    ddlGrupoIR.Visible = false;

                }

                if (registro.Row.ItemArray.GetValue(13) != null)
                    chkLote.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(13));

                if (registro.Row.ItemArray.GetValue(14) != null)
                    chkSaldo.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(14));

                if (registro.Row.ItemArray.GetValue(15) != null)
                    chkCalnal.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(15));

                if (chkCalnal.Checked == true)
                {
                    ddlCanal.Visible = true;

                    if (registro.Row.ItemArray.GetValue(18) != null)
                        ddlCanal.SelectedValue = registro.Row.ItemArray.GetValue(18).ToString();
                }
                else
                    ddlCanal.Visible = false;

                if (registro.Row.ItemArray.GetValue(16) != null)
                    chkLinea.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(16));

                if (registro.Row.ItemArray.GetValue(17) != null)
                    chkPalma.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(17));

                if (registro.Row.ItemArray.GetValue(19) != null)
                    chkRacimos.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(19));
                if (registro.Row.ItemArray.GetValue(20) != null)
                    chkJornal.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(20));

                if (Convert.ToBoolean(registro.Row.ItemArray.GetValue(21)) == true)
                    rblTipoHa.SelectedValue = "HN";

                if (Convert.ToBoolean(registro.Row.ItemArray.GetValue(22)) == true)
                    rblTipoHa.SelectedValue = "HB";

                if (Convert.ToBoolean(registro.Row.ItemArray.GetValue(23)) == true)
                    rblTipoHa.SelectedValue = "HP";

                if (Convert.ToBoolean(registro.Row.ItemArray.GetValue(23)) == false & Convert.ToBoolean(registro.Row.ItemArray.GetValue(22)) == false & Convert.ToBoolean(registro.Row.ItemArray.GetValue(21)) == false)
                    rblTipoHa.SelectedValue = "NA";

                if (registro.Row.ItemArray.GetValue(24) != null)
                    chkBascula.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(24));

                if (registro.Row.ItemArray.GetValue(25) != null)
                    chkFecha.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(25));

                if (registro.Row.ItemArray.GetValue(26) != null)
                    chkRagoSiembra.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(26));

                if (chkRagoSiembra.Checked)
                {
                    txvDesde.Enabled = true;
                    txvHasta.Enabled = true;
                    txvDesde.Text = Server.HtmlDecode(registro.Row.ItemArray.GetValue(27).ToString());
                    txvHasta.Text = Server.HtmlDecode(registro.Row.ItemArray.GetValue(28).ToString());
                }
                else
                {
                    txvDesde.Visible = false;
                    txvHasta.Visible = false;
                    txvDesde.Enabled = false;
                    txvHasta.Enabled = false;
                }

                if (registro.Row.ItemArray.GetValue(29) != null)
                    chkActivo.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(29));
                if (registro.Row.ItemArray.GetValue(32) != null)
                    rblClaseLabor.SelectedValue = registro.Row.ItemArray.GetValue(32).ToString();
                if (registro.Row.ItemArray.GetValue(33) != null)
                    chkManejaDecimal.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(33));
                if (registro.Row.ItemArray.GetValue(34) != null)
                    chkLaborNoPrestacional.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(34));
                if (registro.Row.ItemArray.GetValue(35) != null)
                    chkLaborNoPrestacional.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(35));
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

    protected void niImbGrupo_Click(object sender, ImageClickEventArgs e)
    {
        Session["Novedad"] = true;
        Response.Redirect("GrupoLabor.aspx");
    }
    protected void niimbUnidadMedida_Click(object sender, ImageClickEventArgs e)
    {
        Session["Novedad"] = true;
        Response.Redirect("UnidadMedida.aspx");
    }

    protected void chkImpuesto_CheckedChanged(object sender, EventArgs e)
    {
        CargarImpuesto();
    }

    private void CargarImpuesto()
    {
        if (chkImpuesto.Checked)
        {
            ddlGrupoIR.Visible = true;
            try
            {
                this.ddlGrupoIR.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cGrupoIR", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
                this.ddlGrupoIR.DataValueField = "codigo";
                this.ddlGrupoIR.DataTextField = "descripcion";
                this.ddlGrupoIR.DataBind();
                this.ddlGrupoIR.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar unidad de medida. Correspondiente a: " + ex.Message, "C");
            }

        }
        else
        {
            this.ddlGrupoIR.DataSource = null;
            this.ddlGrupoIR.DataBind();
            ddlGrupoIR.Visible = false;

        }
    }

    protected void chkCalnal_CheckedChanged(object sender, EventArgs e)
    {
        if (chkCalnal.Checked)
            ddlCanal.Visible = true;
        else
            ddlCanal.Visible = false;
    }


    protected void ddlGrupo_SelectedIndexChanged(object sender, EventArgs e)
    {
        Consecutivo();
        txtDescripcion.Focus();
    }

    #endregion Eventos

    protected void chkRagoSiembra_CheckedChanged(object sender, EventArgs e)
    {
        if (chkRagoSiembra.Checked)
        {
            txvDesde.Visible = true;
            txvHasta.Visible = true;
            txvDesde.Enabled = true;
            txvHasta.Enabled = true;

        }
        else
        {
            txvDesde.Visible = false;
            txvHasta.Visible = false;
        }
    }
    protected void nitxtBusqueda_TextChanged(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
        nitxtBusqueda.Focus();
    }
}