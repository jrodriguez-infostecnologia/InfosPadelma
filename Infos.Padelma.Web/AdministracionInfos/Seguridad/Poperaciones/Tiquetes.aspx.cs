using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;

public partial class Administracion_Poperacion_Tiquetes : System.Web.UI.Page
{
    #region Instancias

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cbascula bascula = new Cbascula();
    CtiposTransaccion tipoTransaccion = new CtiposTransaccion();

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }
    private void CargarTipoTransaccion()
    {
        try
        {
            this.ddlTipoTransaccion.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "codigo", Convert.ToInt16(Session["empresa"]));
            this.ddlTipoTransaccion.DataValueField = "codigo";
            this.ddlTipoTransaccion.DataTextField = "descripcion";
            this.ddlTipoTransaccion.DataBind();
            this.ddlTipoTransaccion.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void ComportamientoNuevoEditar(bool nuevo)
    {
        if (nuevo == true)
        {
            CargarTipoTransaccion();

            this.lblTipoTransaccion.Visible = true;
            this.ddlTipoTransaccion.Visible = true;
            this.lblBodega.Visible = true;
            this.ddlBodega.Visible = true;
            this.lblDescargador.Visible = true;
            this.rblDescargador.Visible = true;
            this.lblOperacion.Visible = false;
            this.ddlOperación.Visible = false;
            this.lblProgramacion.Visible = true;
            this.txtProgramacion.Visible = true;
            this.Session["editar"] = false;
            gvAnalisis.Visible = true;
            lblRemision.Visible = true;
            txtRemision.Visible = true;
            gvAnalisis.DataSource = null;
            gvAnalisis.DataBind();
        }
        else
        {
            this.lblTipoTransaccion.Visible = true;
            this.ddlTipoTransaccion.Visible = true;
            this.ddlTipoTransaccion.Enabled = false;
            txtNumeroTransaccion.Enabled = false;
            this.lblBodega.Visible = false;
            this.ddlBodega.Visible = false;
            this.lblDescargador.Visible = false;
            this.rblDescargador.Visible = false;
            this.lblOperacion.Visible = true;
            this.ddlOperación.Visible = true;
            this.lblProgramacion.Visible = false;
            this.txtProgramacion.Visible = false;
            this.Session["editar"] = true;
            gvAnalisis.Visible = false;
            lblRemision.Visible = false;
            txtRemision.Visible = false;
        }
    }
    private void CargaFincas()
    {
        this.ddlFinca.Focus();

        try
        {
            this.ddlFinca.DataSource = bascula.GetFincasProcedencia(Convert.ToString(this.ddlProcedencia.SelectedValue), Convert.ToInt16(Session["empresa"]));
            this.ddlFinca.DataValueField = "codigo";
            this.ddlFinca.DataTextField = "descripcion";
            this.ddlFinca.DataBind();
            this.ddlFinca.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar fincas - procedencia. Correspondiente a: " + ex.Message;
        }
    }
    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }
            gvAnalisis.Visible = false;
            this.gvLista.DataSource = bascula.GetBasculaTiquete(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er",
            error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;
        this.txvPneto.Text = "0";
        this.rblDescargador.Visible = false;
        this.nilbNuevo.Visible = true;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        gvAnalisis.Visible = false;
        rblTipoImpresion.Visible = false;

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }
    private void CargarCombos(string tipo)
    {
        try
        {
            this.ddlProcedencia.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("bPRocedencia", "ppa"), "codigo", Convert.ToInt16(Session["empresa"]));
            this.ddlProcedencia.DataValueField = "codigo";
            this.ddlProcedencia.DataTextField = "codigo";
            this.ddlProcedencia.DataBind();
            this.ddlProcedencia.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar procedencias. Correspondiente a: " + ex.Message;
        }

        try
        {
            this.ddlTiquete.DataSource = bascula.SeleccionaTipoTiquete(Convert.ToInt16(Session["empresa"]));
            this.ddlTiquete.DataValueField = "codigo";
            this.ddlTiquete.DataTextField = "descripcion";
            this.ddlTiquete.DataBind();
            this.ddlTiquete.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar bodega. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void GuardarTiquete()
    {
        bool resultados = true;
        string cargador = null;
        string tiquete = "", numero = "", remision = "";



        this.nilblInformacion.Text = "";
        try
        {
            if (ddlTipoTransaccion.SelectedValue == "EPP")
            {
                cargador = rblDescargador.SelectedValue;
            }

            if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text) - Convert.ToDecimal(txvPesoDescuento.Text)) <= 0)
            {
                this.nilblInformacion.Text = "El peso tara no puede ser igual o mayor que el peso bruto. Por favor corrija";
                return;
            }

            if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || Convert.ToDecimal(txvPesoBruto.Text) == 0 ||
                Convert.ToDecimal(txvPesoTara.Text) == 0 || this.txtVehiculo.Text.Trim().Length == 0 ||
                Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
            {
                this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                return;
            }

            if (this.txvRacimos.Text.Trim().Length == 0)
                this.txvRacimos.Text = "0";

            if (this.txvSacos.Text.Trim().Length == 0)
                this.txvSacos.Text = "0";

            if (this.txvPesoSacos.Text.Trim().Length == 0)
                this.txvPesoSacos.Text = "0";

            foreach (GridViewRow registro in this.gvAnalisis.Rows)
            {
                if (((TextBox)registro.FindControl("txtCantidad")).Text.Length == 0)
                    resultados = false;
            }

            if (resultados == false)
            {
                this.nilblInformacion.Text = "Debe digitar los análisis completos";
                return;
            }

            if (txtRemision.Visible == true)
                remision = txtRemision.Text;
            else
                remision = txtProgramacion.Text;

            tiquete = bascula.RetornaConsecutivo(ddlTiquete.SelectedValue, Convert.ToInt16(Session["empresa"]));
            numero = bascula.RetornaConsecutivo(ddlTipoTransaccion.SelectedValue.ToString(), Convert.ToInt16(Session["empresa"]));

            object[] objValores = new object[]{
                1,//@analisisRegistrado
                ddlBodega.SelectedValue,//@bodega
                txtCodigoConductor.Text,//@codigoConductor
                Convert.ToInt16(Session["empresa"]),//@empresa
                "SP",//@estado
                CalendarFechaProceso.SelectedDate,//@fecha
               CalendarFechaProceso.SelectedDate,//@fechaBruto
                CalendarFechaProceso.SelectedDate,//@fechaNeto
                CalendarFechaProceso.SelectedDate,//@fechaProceso
                CalendarFechaProceso.SelectedDate,//@fechaTara
                Convert.ToString(this.ddlFinca.SelectedValue),//@finca
                Convert.ToString(this.ddlProducto.SelectedValue),//@item
                txtNombreConductor.Text,//@nombreConductor
                numero,//@numero
                txtObservacion.Text,//@observacion
                Convert.ToDecimal(this.txvPesoBruto.Text),//@pesoBruto
                Convert.ToDecimal(this.txvPesoDescuento.Text),//@pesoDescuento
                Convert.ToDecimal(this.txvPneto.Text),//@pesoNeto
                Convert.ToDecimal(txvPesoSacos.Text),//@pesoSacos
                Convert.ToDecimal(this.txvPesoTara.Text),//@pesoTara
                Convert.ToString(this.ddlProcedencia.SelectedValue),//@procedencia
                Convert.ToDecimal(this.txvRacimos.Text),//@racimos
                remision,//@remision
                this.txtRemolque.Text,//@remolque
                Convert.ToDecimal(this.txvSacos.Text),//@sacos
                txtSellos.Text,//@sellos
                null,//@tercero
                ddlTipoTransaccion.SelectedValue,//@tipo
                 cargador,//@tipoDescargue
                null,//@tipoVehiculo
                tiquete,//@tiquete
                null,//@urlTiquete
                Convert.ToString(Session["usuario"]),//@usuario
                this.txtVehiculo.Text,//@vehiculo,
                false //@vehiculoInterno
            };

            using (TransactionScope ts = new TransactionScope())
            {
                switch (CentidadMetodos.EntidadInsertUpdateDelete("bRegistroBascula", "inserta", "ppa", objValores))
                {
                    case 0:

                        switch (bascula.ActualizaConsecutivo(ddlTipoTransaccion.SelectedValue.ToString(), Convert.ToInt16(Session["empresa"])))
                        {
                            case 0:

                                switch (bascula.ActualizaConsecutivo(ConfigurationManager.AppSettings["tiqueteBascula"].ToString().Trim(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 0:
                                        foreach (GridViewRow registro in this.gvAnalisis.Rows)
                                        {
                                            object[] objValoresAnalisis = new object[] {                           
                                                registro.Cells[0].Text,
                                                Convert.ToInt16(Session["empresa"]),
                                                CalendarFechaProceso.SelectedDate,
                                                numero,
                                                ddlTipoTransaccion.SelectedValue,
                                                this.Session["usuario"],
                                                ((TextBox)registro.FindControl("txtCantidad")).Text
                                                };

                                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "inserta", "ppa",
                                                objValoresAnalisis) == 1)
                                            {
                                                this.nilblInformacion.Text = "Error al insertar los análisis. Operación no realizada";
                                                return;
                                            }
                                        }

                                        switch (tipoTransaccion.InsertaDespacho(Convert.ToString(numero),
                                                Convert.ToString(this.rblTipoImpresion.SelectedValue),
                                                        Convert.ToInt16(Session["empresa"])))
                                        {
                                            case 1:
                                                this.nilblInformacion.Text = "Error al insertar el despacho. Operación no realizada";
                                                return;
                                        }

                                        break;

                                    case 1:

                                        this.nilblInformacion.Text = "Error al actualizar consecutivo de tiquete. Operación no realizada";
                                        break;
                                }
                                break;

                            case 1:

                                this.nilblInformacion.Text = "Error al actualizar consecutivo de transacción. Operación no realizada";
                                break;
                        }

                        break;

                    case 1:

                        this.nilblInformacion.Text = "Error al actualizar consecutivo de transacción. Operación no realizada";
                        break;
                }

                ManejoExito("Tiquete creado satisfactoriamente con el número " + tiquete, "I");
            }
        }

        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, "A");
        }
    }

    private void Guardar()
    {
        string nuevoTiquete = "";
        string cargador = null;

        this.nilblInformacion.Text = "";
        try
        {

            if (ddlTipoTransaccion.SelectedValue == ConfigurationManager.AppSettings["tipoEMP"].ToString())
            {
                cargador = this.rblDescargador.SelectedItem.Value;
            }


            switch (Convert.ToString(this.ddlOperación.SelectedValue))
            {
                case "0":

                    if (bascula.AnulaTiquete(this.gvLista.SelectedRow.Cells[1].Text, Convert.ToInt16(Session["empresa"])) == 0)
                        ManejoExito("Tiquete anulado satisfactoriamente", "E");
                    else
                        this.nilblInformacion.Text = "Error al anular el tiquete. Operación no realizada";
                    break;

                case "1":

                    if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text)) <= 0)
                    {
                        this.nilblInformacion.Text = "El peso tara no puede ser igual o mayor que el peso bruto. Por favor corrija";
                        return;
                    }

                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || Convert.ToDecimal(txvPesoBruto.Text) == 0 ||
                        Convert.ToDecimal(txvPesoTara.Text) == 0 || this.txtVehiculo.Text.Trim().Length == 0 ||
                        Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    if (this.txvRacimos.Text.Trim().Length == 0)
                        this.txvRacimos.Text = "0";

                    if (this.txvSacos.Text.Trim().Length == 0)
                        this.txvSacos.Text = "0";

                    if (this.txvPesoSacos.Text.Trim().Length == 0)
                        this.txvPesoSacos.Text = "0";

                    if (ddlTiquete.SelectedValue.Trim().Length == 0)
                    {
                        nilblInformacion.Text = "Seleccione un tipo tiquete valido";
                        return;
                    }

                    if (bascula.AnulaCreaTiquete(this.gvLista.SelectedRow.Cells[1].Text, ddlTiquete.SelectedValue, this.gvLista.SelectedRow.Cells[2].Text,
                        this.CalendarFechaProceso.SelectedDate, Convert.ToDecimal(txvPesoBruto.Text), Convert.ToDecimal(txvPesoTara.Text),
                        this.txtVehiculo.Text, this.txtRemolque.Text, Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlProcedencia.SelectedValue), Convert.ToString(this.ddlFinca.SelectedValue), Convert.ToDecimal(this.txvRacimos.Text),
                        Convert.ToDecimal(this.txvSacos.Text), Convert.ToDecimal(this.txvPesoSacos.Text), this.txtSellos.Text,
                        this.Session["usuario"].ToString(), out nuevoTiquete, Convert.ToInt16(Session["empresa"]), 0, txtCodigoConductor.Text, txtNombreConductor.Text, txtRemision.Text, txtRemisionComer.Text, true, rblTipoImpresion.SelectedValue, txtObservacion.Text.Trim()) == 0)
                        ManejoExito("Tiquete creado satisfactoriamente con el número " + nuevoTiquete, "I");
                    else
                        this.nilblInformacion.Text = "Error al crear el nuevo tiquete. Operación no realizada";
                    break;

                case "2":

                    if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoDescuento.Text) - Convert.ToDecimal(txvPesoTara.Text)) <= 0)
                    {
                        this.nilblInformacion.Text = "El peso tara no puede ser igual o mayor que el peso bruto. Por favor corrija";
                        return;
                    }

                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || Convert.ToDecimal(txvPesoBruto.Text) == 0 ||
                        Convert.ToDecimal(txvPesoTara.Text) == 0 || this.txtVehiculo.Text.Trim().Length == 0 ||
                        Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    if (this.txvRacimos.Text.Trim().Length == 0)
                        this.txvRacimos.Text = "0";

                    if (this.txvSacos.Text.Trim().Length == 0)
                        this.txvSacos.Text = "0";

                    if (this.txvPesoSacos.Text.Trim().Length == 0)
                        this.txvPesoSacos.Text = "0";

                    if (ddlTiquete.SelectedValue.Trim().Length == 0)
                    {
                        nilblInformacion.Text = "Seleccione un tipo tiquete valido";
                        return;
                    }

                    if (bascula.ModificaTiquete(this.gvLista.SelectedRow.Cells[1].Text, this.CalendarFechaProceso.SelectedDate, Convert.ToDecimal(txvPesoBruto.Text),
                        Convert.ToDecimal(txvPesoTara.Text), this.txtVehiculo.Text, this.txtRemolque.Text, Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlProcedencia.SelectedValue), Convert.ToString(this.ddlFinca.SelectedValue), Convert.ToDecimal(this.txvRacimos.Text),
                        Convert.ToDecimal(this.txvSacos.Text), Convert.ToDecimal(this.txvPesoSacos.Text), this.txtSellos.Text, ddlBodega.SelectedValue,
                        cargador, Convert.ToInt16(Session["empresa"]), Convert.ToDecimal(txvPesoDescuento.Text), txtCodigoConductor.Text, txtNombreConductor.Text,
                        txtObservacion.Text, ddlCliente.SelectedValue, ddlTercero.SelectedValue) == 0)
                    {
                        foreach (GridViewRow registro in this.gvAnalisis.Rows)
                        {
                            object[] objValoresAnalisis = new object[] {                           
                                                registro.Cells[0].Text,
                                                Convert.ToInt16(Session["empresa"]),
                                                CalendarFechaProceso.SelectedDate,
                                                txtNumeroTransaccion.Text,
                                                ddlTipoTransaccion.SelectedValue,
                                                this.Session["usuario"],
                                                ((TextBox)registro.FindControl("txtCantidad")).Text
                                                };

                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "actualiza", "ppa",
                                objValoresAnalisis) == 1)
                            {
                                this.nilblInformacion.Text = "Error al insertar los análisis. Operación no realizada";
                                return;
                            }
                        }
                        ManejoExito("Tiquete modificado satisfactoriamente " + nuevoTiquete, "A");
                    }
                    else
                        this.nilblInformacion.Text = "Error al modificar el tiquete. Operación no realizada";
                    break;

                case "3":

                    if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text)) <= 0)
                    {
                        this.nilblInformacion.Text = "El peso tara no puede ser igual o mayor que el peso bruto. Por favor corrija";
                        return;
                    }

                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || Convert.ToDecimal(txvPesoBruto.Text) == 0 ||
                        Convert.ToDecimal(txvPesoTara.Text) == 0 || this.txtVehiculo.Text.Trim().Length == 0 ||
                        Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    if (this.txvRacimos.Text.Trim().Length == 0)
                        this.txvRacimos.Text = "0";

                    if (this.txvSacos.Text.Trim().Length == 0)
                        this.txvSacos.Text = "0";

                    if (this.txvPesoSacos.Text.Trim().Length == 0)
                        this.txvPesoSacos.Text = "0";


                    if (bascula.AnulaCreaTiquete(this.gvLista.SelectedRow.Cells[1].Text,
                       ddlTiquete.SelectedValue, this.gvLista.SelectedRow.Cells[2].Text,
                        this.CalendarFechaProceso.SelectedDate, Convert.ToDecimal(txvPesoBruto.Text), Convert.ToDecimal(txvPesoTara.Text),
                        this.txtVehiculo.Text, this.txtRemolque.Text, Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlProcedencia.SelectedValue), Convert.ToString(this.ddlFinca.SelectedValue), Convert.ToDecimal(this.txvRacimos.Text),
                        Convert.ToDecimal(this.txvSacos.Text), Convert.ToDecimal(this.txvPesoSacos.Text), this.txtSellos.Text,
                        this.Session["usuario"].ToString(), out nuevoTiquete, Convert.ToInt16(Session["empresa"]), 0, txtCodigoConductor.Text, txtNombreConductor.Text, txtRemision.Text, txtRemisionComer.Text, false, rblTipoImpresion.SelectedValue, txtObservacion.Text) == 0)
                        ManejoExito("Tiquete creado satisfactoriamente con el número " + nuevoTiquete, "I");
                    else
                        this.nilblInformacion.Text = "Error al crear el nuevo tiquete. Operación no realizada";
                    break;

            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, "A");
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
            {
                if (!IsPostBack)
                {
                    this.nitxtBusqueda.Focus();
                    rblDescargador.Visible = false;
                }
                else

                {
                    txvPneto.Enabled = false;
                }
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }
    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.rblDescargador.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        gvAnalisis.Visible = false;
        rblTipoImpresion.Visible = false;
        this.nilblInformacion.Text = "";
        this.ddlOperación.SelectedValue = "0";
        this.ddlProducto.SelectedValue = "";
        this.ddlFinca.SelectedValue = "";
        this.txvPneto.Text = "0";
        this.rblDescargador.Visible = false;
        this.nilbNuevo.Visible = true;
        this.ddlTipoTransaccion.SelectedValue = "";
    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);

        this.rblDescargador.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilblInformacion.Text = "";
        this.ddlOperación.SelectedValue = "0";
        this.ddlProducto.SelectedValue = "";
        this.ddlProcedencia.SelectedValue = "";
        this.ddlFinca.SelectedValue = "";
        this.txvPneto.Text = "0";
        GetEntidad();
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        rblTipoImpresion.Visible = false;
        txtRemisionComer.Visible = false;
        lblRemisionComercializadora.Visible = false;
        btnRemisiones.Visible = false;
        lblRemisionComercializadora.Visible = false;
        btnRemisiones.Visible = false;
        nilbNuevo.Visible = true;
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        if (ddlOperación.SelectedValue.Trim() != "0")
        {
            if (Convert.ToDecimal(txvPesoTara.Text) > Convert.ToDecimal(txvPesoBruto.Text))
            {
                nilblInformacion.Text = "Peso tara mayor al neto";
                return;
            }

            try
            {
                Convert.ToDecimal(txvPesoTara.Text);
                Convert.ToDecimal(txvPesoBruto.Text);
                Convert.ToDecimal(txvPneto.Text);
            }
            catch
            {
                nilblInformacion.Text = "Solo se permiten numeros";
                return;
            }
        }

        if (Convert.ToBoolean(this.Session["editar"]) == true)
            Guardar();
        else
            GuardarTiquete();
    }
    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        ComportamientoNuevoEditar(false);
        this.nilbNuevo.Visible = false;
        this.nilblInformacion.Text = "";
        this.ddlOperación.Focus();
        txtRemisionComer.Visible = false;
        lblRemisionComercializadora.Visible = false;
        btnRemisiones.Visible = false;
        lblRemisionComercializadora.Visible = false;
        manejoTipo();
    }

    protected void lbFechaProceso_Click(object sender, EventArgs e)
    {
        this.CalendarFechaProceso.Visible = true;
        this.txtFechaProceso.Visible = false;
        this.CalendarFechaProceso.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFechaProceso_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaProceso.Visible = false;
        this.txtFechaProceso.Visible = true;
        this.txtFechaProceso.Text = this.CalendarFechaProceso.SelectedDate.ToString();
        txvPesoBruto.Focus();
    }

    protected void ddlOperación_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        this.lbFechaProceso.Focus();

        manejoTipo();
    }

    private void manejoTipo()
    {
        try
        {
            switch (ddlOperación.SelectedValue.ToString())
            {

                case "0":
                    this.nilblInformacion.Text = "";
                    this.ddlOperación.SelectedValue = "0";
                    this.ddlProducto.SelectedValue = "";
                    this.ddlProcedencia.SelectedValue = "";
                    this.ddlFinca.SelectedValue = "";
                    this.txvPneto.Text = "0";
                    break;
                default:

                    CargarTipoTransaccion();
                    CargarCombos(this.gvLista.SelectedRow.Cells[2].Text);
                    cargarProductos(this.gvLista.SelectedRow.Cells[2].Text);

                    ddlTipoTransaccion.SelectedValue = gvLista.SelectedRow.Cells[2].Text;
                    txtNumeroTransaccion.Text = gvLista.SelectedRow.Cells[3].Text;
                    foreach (DataRowView registro in bascula.GetBasculaTiquete(this.gvLista.SelectedRow.Cells[1].Text, Convert.ToInt16(Session["empresa"])))
                    {
                        if (Convert.ToString(this.gvLista.SelectedRow.Cells[2].Text) != ConfigurationManager.AppSettings["tipoDPT"].ToString())
                        {
                            this.ddlProcedencia.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(18));
                            CargaFincas();
                            this.lblBodega.Visible = true;
                            this.ddlBodega.Visible = true;
                            this.rblDescargador.Visible = true;
                            try
                            {
                                this.ddlFinca.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(19));
                            }
                            catch (Exception ex)
                            {
                                CargaFincas();
                                this.ddlFinca.SelectedValue = "";
                            }
                        }

                        if (Convert.ToString(this.gvLista.SelectedRow.Cells[2].Text) == ConfigurationManager.AppSettings["tipoDPT"].ToString())
                        {
                            txtRemision.Visible = true;
                            txtRemisionComer.Visible = true;
                            lblRemisionComercializadora.Visible = true;
                            lblRemision.Visible = true;
                            rblTipoImpresion.Visible = true;
                            txtProgramacion.Text = Convert.ToString(registro.Row.ItemArray.GetValue(5));
                            txtRemision.Text = registro.Row.ItemArray.GetValue(34).ToString().Trim();
                            txtRemisionComer.Enabled = false;
                            txtRemision.Enabled = false;
                            txtProgramacion.Visible = true;
                            txtProgramacion.Enabled = false;
                            txtRemisionComer.Text = registro.Row.ItemArray.GetValue(35).ToString().Trim();
                            btnRemisiones.Visible = true;
                            ddlCliente.Visible = true;
                            ddlTercero.Visible = true;

                            try
                            {
                                DataView dvTercero = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cTercero", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
                                dvTercero.RowFilter = "activo=1 and cliente=1 and empresa=" + Session["empresa"].ToString();
                                this.ddlTercero.DataSource = dvTercero;
                                this.ddlTercero.DataValueField = "id";
                                this.ddlTercero.DataTextField = "descripcion";
                                this.ddlTercero.DataBind();
                                this.ddlTercero.Items.Insert(0, new ListItem("", ""));
                            }
                            catch (Exception ex)
                            {
                                ManejoError("Error al cargar tercero. Correspondiente a: " + ex.Message, "C");
                            }

                            ddlTercero.SelectedValue = registro.Row.ItemArray.GetValue(50).ToString().Trim();
                            cargarCliente();
                            ddlCliente.SelectedValue = registro.Row.ItemArray.GetValue(51).ToString().Trim();

                            lblBodega.Visible = true;
                            lblProgramacion.Visible = true;
                            lblPesoSacos.Visible = false;
                            lblSacos.Visible = false;
                            txvSacos.Visible = false;
                            txvPesoSacos.Visible = false;
                        }


                        this.CalendarFechaProceso.SelectedDate = Convert.ToDateTime(registro.Row.ItemArray.GetValue(21));
                        this.txtFechaProceso.Text = Convert.ToString(registro.Row.ItemArray.GetValue(21));
                        txvPesoBruto.Text = registro.Row.ItemArray.GetValue(6).ToString();
                        txvPesoTara.Text = registro.Row.ItemArray.GetValue(8).ToString();
                        txvPneto.Text = registro.Row.ItemArray.GetValue(9).ToString();
                        txvPesoDescuento.Text = registro.Row.ItemArray.GetValue(7).ToString();
                        this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(15));
                        this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(16));
                        this.ddlProducto.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(17));
                        this.txvRacimos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(22));
                        this.txvSacos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(24));
                        this.txvPesoSacos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(27));
                        this.txtSellos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(28));
                        txtCodigoConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(30));
                        txtNombreConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(31));
                        try
                        {
                            ddlBodega.Visible = true;
                            this.ddlBodega.DataSource = bascula.SeleccionaBodegaProducto(Convert.ToString(registro.Row.ItemArray.GetValue(17)), Convert.ToInt16(Session["empresa"]));
                            this.ddlBodega.DataValueField = "codigo";
                            this.ddlBodega.DataTextField = "descripcion";
                            this.ddlBodega.DataBind();
                            this.ddlBodega.Items.Insert(0, new ListItem("", ""));
                        }
                        catch (Exception ex)
                        {
                            ManejoError("Error al cargar bodega. Correspondiente a: " + ex.Message, "C");
                        }

                        try
                        {
                            this.ddlTiquete.DataSource = bascula.SeleccionaTipoTiquete(Convert.ToInt16(Session["empresa"]));
                            this.ddlTiquete.DataValueField = "codigo";
                            this.ddlTiquete.DataTextField = "descripcion";
                            this.ddlTiquete.DataBind();
                            this.ddlTiquete.Items.Insert(0, new ListItem("", ""));
                        }
                        catch (Exception ex)
                        {
                            ManejoError("Error al cargar bodega. Correspondiente a: " + ex.Message, "C");
                        }


                        if (Convert.ToString(registro.Row.ItemArray.GetValue(29)) == "Cooperativa")
                            this.rblDescargador.Items[1].Selected = true;
                        else
                            this.rblDescargador.Items[0].Selected = true;

                        CargarAnalisis(ddlTipoTransaccion.SelectedValue, txtNumeroTransaccion.Text);
                        ddlTiquete.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(49));
                        ddlBodega.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(23));
                    }
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar datos del tiquete. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlProcedencia_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargaFincas();
    }

    protected void ddlTipoTransaccion_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToString(((DropDownList)sender).SelectedValue) == ConfigurationManager.AppSettings["tipoDPT"].ToString())
        {
            txtRemision.Visible = true;
            txtRemisionComer.Visible = true;
            lblRemisionComercializadora.Visible = true;
            lblRemision.Visible = true;
            rblTipoImpresion.Visible = true;
            txtRemisionComer.Enabled = false;
            txtRemision.Enabled = false;
            txtProgramacion.Visible = true;
            txtProgramacion.Enabled = false;
            btnRemisiones.Visible = true;
        }


        if (Convert.ToString(((DropDownList)sender).SelectedValue) == ConfigurationManager.AppSettings["tipoEMP"].ToString())
        {
            this.lblBodega.Visible = true;
            this.lblDescargador.Visible = true;
            this.lblFinca.Visible = true;
            this.lblPesoSacos.Visible = true;
            this.lblProcedencia.Visible = true;
            this.lblRacimos.Visible = true;
            this.lblSellos.Visible = false;
            this.lblProgramacion.Visible = false;
            this.ddlBodega.Visible = true;
            this.rblDescargador.Visible = true;
            this.ddlFinca.Visible = true;
            this.txvPesoSacos.Visible = true;
            this.ddlProcedencia.Visible = true;
            this.txvRacimos.Visible = true;
            this.txtSellos.Visible = false;
            this.txtProgramacion.Visible = false;
        }
        else
        {
            this.lblBodega.Visible = true;
            this.lblDescargador.Visible = false;
            this.lblFinca.Visible = false;
            this.lblPesoSacos.Visible = false;
            this.lblProcedencia.Visible = false;
            this.lblRacimos.Visible = false;
            this.lblSellos.Visible = true;
            this.lblProgramacion.Visible = true;
            this.ddlBodega.Visible = true;
            this.rblDescargador.Visible = true;
            this.ddlFinca.Visible = false;
            this.txvPesoSacos.Visible = false;
            this.ddlProcedencia.Visible = false;
            this.txvRacimos.Visible = false;
            this.txtSellos.Visible = true;
            this.txtProgramacion.Visible = true;
            txtRemision.Visible = false;
            lblRemision.Visible = false;
        }
        this.txvPneto.Enabled = false;
        this.txvPesoDescuento.Text = "0";
        txtNumeroTransaccion.Text = bascula.RetornaConsecutivo(ddlTipoTransaccion.SelectedValue.ToString(), Convert.ToInt16(Session["empresa"]));
        cargarProductos(ddlTipoTransaccion.SelectedValue);
    }

    private void cargarProductos(string tipo)
    {
        try
        {
            this.ddlProducto.DataSource = bascula.GetProductoTransaccion(tipo, Convert.ToInt16(Session["empresa"]));
            this.ddlProducto.DataValueField = "producto";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();
            this.ddlProducto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar productos. Correspondiente a: " + ex.Message;
        }
    }
    protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            this.ddlBodega.DataSource = bascula.SeleccionaBodegaProducto(ddlProducto.SelectedValue, Convert.ToInt16(Session["empresa"]));
            this.ddlBodega.DataValueField = "codigo";
            this.ddlBodega.DataTextField = "descripcion";
            this.ddlBodega.DataBind();
            this.ddlBodega.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar bodega. Correspondiente a: " + ex.Message, "C");
        }


        if (Convert.ToBoolean(this.Session["editar"]) == false)
            AnalisisProducto();
    }

    private void CargarAnalisis(string tipo, string numero)
    {
        try
        {
            if (bascula.CargarAnalisisProducto(tipo, numero, Convert.ToInt16(Session["empresa"])).Count > 0)
            {
                gvAnalisis.Visible = true;
                this.gvAnalisis.DataSource = bascula.CargarAnalisisProducto(tipo, numero, Convert.ToInt16(Session["empresa"]));
                this.gvAnalisis.DataBind();

            }
            else
                gvAnalisis.Visible = false;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los análisis asociados al producto. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void AnalisisProducto()
    {
        try
        {
            this.gvAnalisis.DataSource = bascula.GetAnalisisProducto(ddlProducto.SelectedValue, Convert.ToInt16(Session["empresa"]));
            this.gvAnalisis.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los análisis asociados al producto. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        ComportamientoNuevoEditar(true);
        CargarCombos(ddlTipoTransaccion.SelectedValue);
        this.lbRegistrar.Visible = true;
        this.lbCancelar.Visible = true;
        this.nilbNuevo.Visible = false;
        this.nilblInformacion.Text = "";
        lblRemisionComercializadora.Visible = false;
        btnRemisiones.Visible = false;
        lblRemisionComercializadora.Visible = false;
        rblDescargador.Visible = true;
        this.txvPneto.Enabled = false;
    }


    protected void btnRemisiones_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (ddlOperación.Visible == true)
            {
                string remisionPlanta = null;
                string remisionComer = null;
                bascula.SeleccionaRemisionesTiquete(Convert.ToInt16(Session["empresa"]), rblTipoImpresion.SelectedValue, this.gvLista.SelectedRow.Cells[1].Text, out remisionPlanta, out remisionComer);
                txtRemisionComer.Text = remisionPlanta;
            }
            else
                txtRemisionComer.Text = bascula.RetornaConsecutivo(rblTipoImpresion.SelectedValue, Convert.ToInt16(Session["empresa"]));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar remisiones debido a: " + ex.Message, "I");
        }
    }

    #endregion Eventos




    protected void ddlTercero_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarCliente();
    }

    private void cargarCliente()
    {
        try
        {
            DataView dvTercero = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cxcCliente", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvTercero.RowFilter = "activo = 1 and empresa = " + Session["empresa"].ToString() + " and idTercero = " + ddlTercero.SelectedValue.ToString();
            this.ddlCliente.DataSource = dvTercero;
            this.ddlCliente.DataValueField = "codigo";
            this.ddlCliente.DataTextField = "descripcion";
            this.ddlCliente.DataBind();
            this.ddlCliente.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cliente. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void txvPesoBruto_TextChanged(object sender, EventArgs e)
    {
        calcularNeto();
        txvPesoTara.Focus();
    }

    private void calcularNeto()
    {
        try
        {
                if (txvPesoBruto.Text.Trim().Length > 0 & txvPesoTara.Text.Trim().Length > 0 & txvPesoDescuento.Text.Trim().Length > 0)
            {
                if (Convert.ToDecimal(txvPesoBruto.Text.Trim()) > 0 & Convert.ToDecimal(txvPesoTara.Text.Trim()) > 0)
                {
                    txvPneto.Text = (Convert.ToDecimal(txvPesoBruto.Text.Trim()) - Convert.ToDecimal(txvPesoTara.Text.Trim()) - Convert.ToDecimal(txvPesoDescuento.Text)).ToString();
                }
            }
        }
        catch (Exception ex)
        {
            nilblInformacion.Text = "Error al calcular el peso neto";
            return;
        }
    }
    protected void txvPesoTara_TextChanged(object sender, EventArgs e)
    {
        calcularNeto();
        txvPesoDescuento.Focus();
    }
    protected void txvPesoDescuento_TextChanged(object sender, EventArgs e)
    {
        calcularNeto();
        txtCodigoConductor.Focus();
    }
}
