using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_Lotes : System.Web.UI.Page
{
    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cseccion sesion = new Cseccion();
    Clotes lotes = new Clotes();
    CIP ip = new CIP();
    Clineas lineas;
    List<Ccanales> listaCanales = new List<Ccanales>();
    Ccanales canales;


    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    protected void cargarSesiones()
    {
        if (chkSession.Checked == true)
        {

            if (ddlFinca.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una finca";
                chkSession.Checked = false;
                return;

            }

            try
            {
                ddlSeccion.Enabled = true;

                this.ddlSeccion.DataSource = sesion.SeleccionaSesionesFinca(Convert.ToInt32(this.Session["empresa"]), ddlFinca.SelectedValue);
                this.ddlSeccion.DataValueField = "codigo";
                this.ddlSeccion.DataTextField = "descripcion";
                this.ddlSeccion.DataBind();
                this.ddlSeccion.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar secciones. Correspondiente a: " + ex.Message, "C");
            }

        }
        else
        {
            this.ddlSeccion.DataSource = null;
            this.ddlSeccion.DataBind();
            ddlSeccion.Enabled = false;
        }

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

            this.gvLista.DataSource = lotes.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt32(Session["empresa"]));
            this.gvLista.DataBind();
            gvLineas.DataSource = null;
            gvLineas.DataBind();
            gvCanal.DataSource = null;
            gvCanal.DataBind();

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
                "aFinca", "ppa"), "descripcion", Convert.ToInt32(this.Session["empresa"]));
            this.ddlFinca.DataValueField = "codigo";
            this.ddlFinca.DataTextField = "descripcion";
            this.ddlFinca.DataBind();
            this.ddlFinca.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar finca. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlVariedad.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "aVariedad", "ppa"), "descripcion", Convert.ToInt32(this.Session["empresa"]));

            this.ddlVariedad.DataValueField = "codigo";
            this.ddlVariedad.DataTextField = "descripcion";
            this.ddlVariedad.DataBind();
            this.ddlVariedad.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar variedad. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTipoCanal.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "aTipoCanal", "ppa"), "descripcion", Convert.ToInt32(this.Session["empresa"]));

            this.ddlTipoCanal.DataValueField = "codigo";
            this.ddlTipoCanal.DataTextField = "descripcion";
            this.ddlTipoCanal.DataBind();
            this.ddlTipoCanal.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo canales. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlA�o.DataSource = lotes.PeriodoA�oAbierto(Convert.ToInt32(Session["empresa"]));
            this.ddlA�o.DataValueField = "a�o";
            this.ddlA�o.DataTextField = "a�o";
            this.ddlA�o.DataBind();
            this.ddlA�o.Items.Insert(0, new ListItem("A�o...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�o. Correspondiente a: " + ex.Message, "C");
        }


    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text.Trim().ToString(), Convert.ToInt32(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey("aLotes", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                CcontrolesUsuario.MensajeError("C�digo " + this.txtCodigo.Text + " ya se encuentra registrado", nilblInformacion);
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                this.nilbNuevo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }

    protected void Guardar()
    {
        string operacion = "inserta", secciones = null;
        bool validar = false;

        try
        {
            using (TransactionScope ts = new TransactionScope())
            {
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                    operacion = "actualiza";

                if (chkSession.Checked)
                    secciones = ddlSeccion.SelectedValue;

                object[] objValores = new object[]{
                    chkActivo.Checked, //Activo
                    ddlA�o.SelectedValue,//@a�oSiembra
                    this.txtCodigo.Text.Trim().ToString(),//@codigo
                    Convert.ToDecimal(txvDensidad.Text),//@densidad
                                chkDesarrollo.Checked,//@desarrollo
                    this.txtDescripcion.Text,//@descripcion
                    Convert.ToDecimal( txvDistancia.Text),//@dSiembra        
                    Convert.ToInt32(Session["empresa"]),//@empresa
                    DateTime.Now,//@fechaRegistro
                    ddlFinca.SelectedValue,//@finca
                    null,//@foto
                    Convert.ToDecimal(txvHaBruta.Text),//@hBrutas
                    Convert.ToDecimal(txvHaNetas.Text),//@hNetas
                    chkSession.Checked,//@manejaSeccion
                    Convert.ToDecimal(ddlMes.SelectedValue),//@mesSiembra
                    Convert.ToDecimal(txtNoLinea.Text),//@NoLineas
                    Convert.ToDecimal(txvPalmasBruta.Text),//@palmasBrutas
                    Convert.ToDecimal(txvPalmasProduccion.Text),//@palmasProduccion
                    secciones,//@seccion
                    Convert.ToString(Session["usuario"]),//@usuario
                    ddlVariedad.SelectedValue//@variedad
                    
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("aLotes", operacion, "ppa", objValores))
                {
                    case 0:

                        if (Convert.ToBoolean(this.Session["editar"]) == true)
                        {
                            foreach (GridViewRow r2 in gvLineas.Rows)
                            {
                                object[] objValoresEliminaDetalle = new object[] { Convert.ToInt32(this.Session["empresa"]),txtCodigo.Text };

                                switch (CentidadMetodos.EntidadInsertUpdateDelete("aLotesDetalle", "elimina", "ppa", objValoresEliminaDetalle))
                                {
                                    case 1:
                                        validar = true;
                                        break;
                                }
                            }

                            object[] objValoresEliminaCanal = new object[] { Convert.ToInt32(this.Session["empresa"]), txtCodigo.Text };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("aLotesCanal", "elimina", "ppa", objValoresEliminaCanal))
                            {
                                case 1:
                                    validar = true;
                                    break;
                            }

                        }

                        foreach (GridViewRow r in gvLineas.Rows)
                        {
                            object[] objValoresDetalle = new object[]{
                                    Convert.ToInt32( this.Session["empresa"]),//@empresa
                                    Convert.ToInt32(((CheckBox)r.FindControl("chkOrden")).Checked) ,  //@Izq,
                                    Convert.ToInt32(r.Cells[1].Text), //@linea
                                    txtCodigo.Text, //@lote
                                    Convert.ToDecimal(((TextBox)r.FindControl("txtNoPalma")).Text)   //@noPalma
                                     };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("aLotesDetalle", "inserta", "ppa", objValoresDetalle))
                            {
                                case 1:
                                    validar = true;
                                    break;
                            }

                        }

                        foreach (GridViewRow r in gvCanal.Rows)
                        {
                            object[] objValoresDetalle = new object[]{
                                    Convert.ToInt32( this.Session["empresa"]),//@empresa
                                    txtCodigo.Text, //@lote
                                    Convert.ToDecimal(((TextBox)r.FindControl("txtMetros")).Text) ,  //@metros
                                    Convert.ToInt32(r.Cells[2].Text), //@linea
                                    r.Cells[1].Text.Trim(), //@linea
                                     };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("aLotesCanal", "inserta", "ppa", objValoresDetalle))
                            {
                                case 1:
                                    validar = true;
                                    break;
                            }
                        }
                        break;
                }

                if (validar == true)
                {
                    ManejoError("Error al insertar datos", operacion.Substring(0, 1).ToUpper());
                    return;
                }

                ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                ts.Complete();

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
                ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt32(Session["empresa"])) != 0)
                nitxtBusqueda.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
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
        gvLineas.DataSource = null;
        gvLineas.DataBind();
        nilblInformacion.Text = "";

        gvCanal.DataSource = null;
        gvCanal.DataBind();
        ddlSeccion.DataSource = null;
        ddlSeccion.DataBind();

        Session["canales"] = null;
        Session["linea"] = null;

        CargarCombos();

        ddlSeccion.Enabled = false;
        txvDensidad.Enabled = false;
        txvHaNetas.Enabled = false;

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {


        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.gvLineas.DataSource = null;
        this.gvLineas.DataBind();
        this.gvCanal.DataSource = null;
        this.gvCanal.DataBind();

        Session["canales"] = null;
        nilblInformacion.Text = "";
        gvCanal.Visible = false;
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
        txtDescripcion.Focus();
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            bool validar = false;

            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                    nombrePaginaActual(), "E", Convert.ToInt32(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }


            object[] objValoresEliminaDetalle = new object[]{
                                          Convert.ToInt32(this.Session["empresa"]),
                                             Server.HtmlDecode(gvLista.Rows[e.RowIndex].Cells[2].Text)                                                                          
                               
                                 };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                 "aLotesDetalle",
                 "elimina",
                 "ppa",
                 objValoresEliminaDetalle))
            {
                case 1:
                    validar = true;
                    break;
            }



            object[] objValoresEliminaCanales = new object[]{
                                          Convert.ToInt32(this.Session["empresa"]),
                                             Server.HtmlDecode(gvLista.Rows[e.RowIndex].Cells[2].Text )                                         
             };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                 "aLotesCanal",
                 "elimina",
                 "ppa",
                 objValoresEliminaCanales))
            {
                case 1:
                    validar = true;
                    break;
            }


            object[] objValores = new object[] {
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToInt32(Session["empresa"])
            };


            if (validar == false)
            {
                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "aLotes",
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
            else
            {

                ManejoError("Error al eliminar el registro. Operaci�n no realizada", "E");
            }
        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El c�digo ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociaci�n, no es posible eliminar el registro. " + ex.Message, "E");
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
        nilblInformacion.Text = "";
        if (gvLineas.Rows.Count == 0)
        {
            CcontrolesUsuario.MensajeError("Debe ingresar lineas para continuar", nilblInformacion);
            return;
        }

        if (gvCanal.Rows.Count == 0)
        {
            CcontrolesUsuario.MensajeError("Debe ingresar un canal para continuar", nilblInformacion);
            return;
        }

        if (this.txtDescripcion.Text.Trim().Length == 0 || this.txtCodigo.Text.Trim().Length == 0 || txvPalmasBruta.Text.Trim().Length == 0 || ddlFinca.SelectedValue.Trim().Length == 0 || ddlVariedad.SelectedValue.Trim().Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblInformacion);
            return;
        }

        if (Convert.ToDecimal(txvHaBruta.Text) == 0 || Convert.ToDecimal(txvDistancia.Text) == 0 || Convert.ToDecimal(txvDensidad.Text) == 0 || Convert.ToDecimal(txvPalmasProduccion.Text) == 0 || Convert.ToDecimal(txvPalmasBruta.Text) == 0)
        {
            CcontrolesUsuario.MensajeError("Campos en 0 por favor corrija", nilblInformacion);
            return;
        }

        if (Convert.ToDecimal(txvPalmasBruta.Text) < Convert.ToDecimal(txvPalmasProduccion.Text))
        {
            CcontrolesUsuario.MensajeError("EL area de producci�n no puede ser mayor al area bruto", nilblInformacion);
            return;

        }

         // este procedimiento verifica que no halla numero de palmas en 0, pero se solicito que se pudieran guardar registro de lineas con palmas con valor de 0 05/03/2016 
        //foreach (GridViewRow r in gvLineas.Rows)
        //{
        //    if (Convert.ToDecimal(((TextBox)r.FindControl("txtNoPalma")).Text.Trim()) <= 0)
        //    {
        //        CcontrolesUsuario.MensajeError("N�mero de palmas en 0 por favor corrija", nilblInformacion);
        //        return;
        //    }
        //}

        decimal noPalmas = 0;
        foreach (GridViewRow r in gvLineas.Rows)
        {
            noPalmas += Convert.ToDecimal(((TextBox)r.FindControl("txtNoPalma")).Text);
        }

        if (noPalmas != Convert.ToDecimal(txvPalmasBruta.Text))
        {
            CcontrolesUsuario.MensajeError("El n�mero palma brutas no es igual al linea-palma, por favor corrija", nilblInformacion);
            return;
        }

        foreach (GridViewRow r in gvCanal.Rows)
        {
            if (Convert.ToDecimal(((TextBox)r.FindControl("txtMetros")).Text.Trim()) <= 0)
            {
                CcontrolesUsuario.MensajeError("Metros de canales en 0 por favor corrija", nilblInformacion);
                return;
            }
        }

        if (chkSession.Checked)
        {
            if (ddlSeccion.SelectedValue.Length == 0)
            {
                CcontrolesUsuario.MensajeError("Debe seleccionar una secci�n", nilblInformacion);
                return;
            }
        }


        Guardar();
    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        //this.lbRegistrar.Visible = true;
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        CargarCombos();
        this.txtCodigo.Enabled = false;
        this.txtDescripcion.Focus();
        lblgvLineas.Text = "";
        nilblInformacion.Text = "";
       

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            else
                this.txtDescripcion.Text = "";

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                ddlFinca.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[19].Controls)
            {
                if (objControl is CheckBox)
                    this.chkSession.Checked = ((CheckBox)objControl).Checked;
            }

            if (chkSession.Checked == true)
            {
                cargarSesiones();
                ddlSeccion.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text.Trim());
            }
            else
            {
                this.ddlSeccion.DataSource = null;
                this.ddlSeccion.DataBind();
                ddlSeccion.Enabled = false;
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                ddlVariedad.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                this.txvPalmasBruta.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text);
            else
                this.txvPalmasBruta.Text = "0";

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.txvPalmasProduccion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
            else
                this.txvPalmasProduccion.Text = "0";

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
            {
                ddlA�o.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);
                cargarMes();
            }

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                ddlMes.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[10].Text);

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                this.txtNoLinea.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[11].Text);
            else
                this.txtNoLinea.Text = "0";

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
                this.txvPalmasBruta.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[12].Text);
            else
                this.txvPalmasBruta.Text = "0";

            if (this.gvLista.SelectedRow.Cells[13].Text != "&nbsp;")
                this.txvPalmasProduccion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[13].Text);
            else
                this.txvPalmasProduccion.Text = "0";

            if (this.gvLista.SelectedRow.Cells[14].Text != "&nbsp;")
                this.txvHaBruta.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[14].Text);
            else
                this.txvHaBruta.Text = "0";

            if (this.gvLista.SelectedRow.Cells[16].Text != "&nbsp;")
                this.txvDensidad.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[16].Text);
            else
                this.txvDensidad.Text = "0";

            if (this.gvLista.SelectedRow.Cells[17].Text != "&nbsp;")
                this.txvDistancia.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[17].Text);
            else
                this.txvDistancia.Text = "0";

            if (this.gvLista.SelectedRow.Cells[15].Text != "&nbsp;")
                this.txvHaNetas.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[15].Text);
            else
                this.txvHaNetas.Text = "0";

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[18].Controls)
            {
                if (objControl is CheckBox)
                    this.chkActivo.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[20].Controls)
            {
                if (objControl is CheckBox)
                    this.chkDesarrollo.Checked = ((CheckBox)objControl).Checked;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }

        cargarLotesDetalle();
        cargarLotesCanal();
    }

    protected void cargarLotesDetalle()
    {

        List<Clineas> listaTransaccion = null;
        this.Session["lineas"] = null;

        foreach (DataRowView dv in lotes.SeleccionaLoteDetalle(Convert.ToInt32(this.Session["empresa"]), txtCodigo.Text.Trim()))
        {

            lineas = new Clineas(Convert.ToInt32(dv.Row.ItemArray.GetValue(2)), dv.Row.ItemArray.GetValue(1).ToString(), Convert.ToInt32(dv.Row.ItemArray.GetValue(3)), Convert.ToBoolean(dv.Row.ItemArray.GetValue(4)));


            if (this.Session["lineas"] == null)
            {
                listaTransaccion = new List<Clineas>();
                listaTransaccion.Add(lineas);
                this.Session["lineas"] = listaTransaccion;
            }
            else
            {
                listaTransaccion = (List<Clineas>)Session["lineas"];
                listaTransaccion.Add(lineas);
            }

        }

        this.Session["lineas"] = listaTransaccion;

        gvLineas.DataSource = listaTransaccion;
        gvLineas.DataBind();
        gvLineas.Visible = true;


        if (gvLineas.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.lblgvLineas.Visible = true;
            this.lblgvLineas.Text = "no hay registros realizados";
        }
        else
        {
            this.lblgvLineas.Visible = false;
            this.lblgvLineas.Text = "";
            this.lbRegistrar.Visible = true;

        }

    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;
        nilblInformacion.Text = "";
        GetEntidad();
    }

    #endregion Eventos

    protected void chkSession_CheckedChanged(object sender, EventArgs e)
    {
        cargarSesiones();
    }

    protected void imbCargar_Click(object sender, ImageClickEventArgs e)
    {

        if (txtNoLinea.Text.Length == 0)
        {
            nilblInformacion.Text = "Debe ingresar un n�mero linea mayor a 0";
            return;
        }
        if (Convert.ToInt32(txtNoLinea.Text) <= 0)
        {
            nilblInformacion.Text = "Debe ingresar un n�mero linea mayor a 0";
            return;
        }

        List<Clineas> listaTransaccion = null;
        this.Session["lineas"] = null;

        for (int i = 1; i <= Convert.ToInt32(this.txtNoLinea.Text); i++)
        {
            lineas = new Clineas(i, txtCodigo.Text, 0, false);


            if (this.Session["lineas"] == null)
            {
                listaTransaccion = new List<Clineas>();
                listaTransaccion.Add(lineas);
                this.Session["lineas"] = listaTransaccion;
            }
            else
            {
                listaTransaccion = (List<Clineas>)Session["lineas"];
                listaTransaccion.Add(lineas);
            }

        }

        this.Session["lineas"] = listaTransaccion;

        gvLineas.DataSource = listaTransaccion;
        gvLineas.DataBind();
        gvLineas.Visible = true;


        if (gvLineas.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.lblgvLineas.Visible = true;
            this.lblgvLineas.Text = "no hay registros realizados";
        }
        else
        {
            this.lblgvLineas.Visible = false;
            this.lblgvLineas.Text = "";
            this.lbRegistrar.Visible = true;

        }

    }
    protected void ddlA�o_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlA�o.SelectedValue.Length != 0)
        {
            cargarMes();
        }
        else
        {
            ddlMes.DataSource = null;
            ddlMes.DataBind();
        }
    }

    protected void cargarMes()
    {

        try
        {
            this.ddlMes.DataSource = lotes.PeriodoMesAbierto(Convert.ToInt32(ddlA�o.SelectedValue), Convert.ToInt32(Session["empresa"])).Tables[0].DefaultView;
            this.ddlMes.DataValueField = "mes";
            this.ddlMes.DataTextField = "descripcion";
            this.ddlMes.DataBind();
            this.ddlMes.Items.Insert(0, new ListItem("Mes...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar mes. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvCanal_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        string tipo = Convert.ToString(this.gvCanal.Rows[e.RowIndex].Cells[1].Text.Trim());
        int numero = 1;

        listaCanales = null;
        listaCanales = (List<Ccanales>)this.Session["canales"];

        listaCanales.RemoveAt(e.RowIndex);

        foreach (Ccanales ca in listaCanales)
        {
            if (ca.TipoCanal == tipo)
            {
                ca.Numero = numero;
                numero++;
            }

        }

        gvCanal.DataSource = listaCanales;
        gvCanal.DataBind();

        Session["calales"] = listaCanales;

    }
    protected void imbCargarCanal_Click(object sender, ImageClickEventArgs e)
    {

        if (ddlTipoCanal.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un tipo canal";
            return;
        }

        int numero = 1;
        listaCanales = null;

        if (this.Session["canales"] == null)
        {
            listaCanales = new List<Ccanales>();
            canales = new Ccanales(ddlTipoCanal.SelectedValue, numero, 0);
            listaCanales.Add(canales);
            this.Session["canales"] = listaCanales;
        }
        else
        {

            listaCanales = (List<Ccanales>)this.Session["canales"];

            foreach (Ccanales ca in listaCanales)
            {
                if (ca.TipoCanal == ddlTipoCanal.SelectedValue)
                    numero++;

            }

            canales = new Ccanales(ddlTipoCanal.SelectedValue, numero, 0);
            listaCanales.Add(canales);
            this.Session["canales"] = listaCanales;


        }


        gvCanal.DataSource = listaCanales;
        gvCanal.DataBind();
        gvCanal.Visible = true;


        if (gvCanal.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.lblgvLineas.Visible = true;
            this.lblgvLineas.Text = "no hay registros realizados";
        }
        else
        {
            this.lblgvLineas.Visible = false;
            this.lblgvLineas.Text = "";
            this.lbRegistrar.Visible = true;
        }
    }


    protected void cargarLotesCanal()
    {

        List<Ccanales> listaCanales = null;
        this.Session["canales"] = null;

        foreach (DataRowView dv in lotes.SeleccionaLoteCanal(Convert.ToInt32(this.Session["empresa"]), txtCodigo.Text))
        {

            canales = new Ccanales(dv.Row.ItemArray.GetValue(3).ToString(), Convert.ToInt32(dv.Row.ItemArray.GetValue(2)), Convert.ToDecimal(dv.Row.ItemArray.GetValue(4)));


            if (this.Session["canales"] == null)
            {
                listaCanales = new List<Ccanales>();
                listaCanales.Add(canales);
                this.Session["canales"] = listaCanales;
            }
            else
            {
                listaCanales = (List<Ccanales>)Session["canales"];
                listaCanales.Add(canales);
            }

        }

        this.Session["canales"] = listaCanales;

        gvCanal.DataSource = listaCanales;
        gvCanal.DataBind();
        gvCanal.Visible = true;


        if (gvCanal.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.lblgvLineas.Visible = true;
            this.lblgvLineas.Text = "no hay registros realizados";
        }
        else
        {
            this.lblgvLineas.Visible = false;
            this.lblgvLineas.Text = "";
            this.lbRegistrar.Visible = true;

        }

    }

    protected void txvDistancia_TextChanged1(object sender, EventArgs e)
    {
        decimal densidad;

        densidad = Decimal.Round(Convert.ToDecimal(10000 / ((Convert.ToDecimal(txvDistancia.Text) * Convert.ToDecimal(txvDistancia.Text)) * Convert.ToDecimal(0.866))), 0);
        txvDensidad.Text = densidad.ToString();

        decimal haProduccion;
        if (Convert.ToDecimal(txvDensidad.Text) > 0)
        {
            haProduccion = Decimal.Round(Convert.ToDecimal(Convert.ToDecimal(txvPalmasProduccion.Text) / Convert.ToDecimal(txvDensidad.Text)), 2);
            txvHaNetas.Text = haProduccion.ToString();
        }

        txvPalmasBruta.Focus();
    }


    protected void txvPalmasBruta_TextChanged1(object sender, EventArgs e)
    {
        decimal haProduccion;
        haProduccion = Decimal.Round(Convert.ToDecimal(Convert.ToDecimal(txvPalmasProduccion.Text) / Convert.ToDecimal(txvDensidad.Text)), 2);
        txvHaNetas.Text = haProduccion.ToString();
    }
    protected void txvPalmasProduccion_TextChanged1(object sender, EventArgs e)
    {
        decimal haProduccion;
        haProduccion = Decimal.Round(Convert.ToDecimal(Convert.ToDecimal(txvPalmasProduccion.Text) / Convert.ToDecimal(txvDensidad.Text)), 2);
        txvHaNetas.Text = haProduccion.ToString();
    }
    protected void gvLineas_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        List<Clineas> listaLineas = null;
        try
        {
            listaLineas = (List<Clineas>)Session["lineas"];
            listaLineas.RemoveAt(e.RowIndex);
            this.gvLineas.DataSource = listaLineas;
            this.gvLineas.DataBind();
            this.Session["lineas"] = listaLineas;
        }
        catch
        {

        }
    }
}
