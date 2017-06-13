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

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
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
    private void ComportamientoNuevoEditar(bool nuevo)
    {


        if (nuevo == true)
        {
            try
            {
                this.ddlTipoTransaccion.DataSource = tipoTransaccion.GetTipoTransaccionModulo();
                this.ddlTipoTransaccion.DataValueField = "codigo";
                this.ddlTipoTransaccion.DataTextField = "descripcion";
                this.ddlTipoTransaccion.DataBind();
                this.ddlTipoTransaccion.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
            }

            this.lblTipoTransaccion.Visible = true;
            this.ddlTipoTransaccion.Visible = true;
            this.lblBodegaDescargue.Visible = true;
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
            this.lblTipoTransaccion.Visible = false;
            this.ddlTipoTransaccion.Visible = false;
            this.lblBodegaDescargue.Visible = false;
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
            ManejoError("Error al cargar fincas. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                      ConfigurationManager.AppSettings["Modulo"].ToString(),
                                      nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            gvAnalisis.Visible = false;

            this.gvLista.DataSource = bascula.GetBasculaTiquete(
                this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(                 this.Session["usuario"].ToString(), "C",
               ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
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

        this.nilblMensaje.Text = mensaje;
        this.txvPneto.Text = "0";
        this.rblDescargador.Visible = false;
        this.nilbNuevo.Visible = true;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        this.nilbNuevo.Visible = true;
        gvAnalisis.Visible = false;

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }
    private void CargarCombos(string tipo)
    {



        try
        {
            this.ddlProcedencia.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(
                CentidadMetodos.EntidadGet("bPRocedencia", "ppa"), "codigo", Convert.ToInt16(Session["empresa"]));
            this.ddlProcedencia.DataValueField = "codigo";
            this.ddlProcedencia.DataTextField = "codigo";
            this.ddlProcedencia.DataBind();
            this.ddlProcedencia.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar procedencias. Correspondiente a: " + ex.Message;
        }


    }

    private void GuardarTiquete()
    {
        bool resultados = true;
        string tiquete = "", numero = "", remision = "";

        this.nilblMensaje.Text = "";
        try
        {
            if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text) - Convert.ToDecimal(txvPesoDescuento.Text)) <= 0)
            {
                this.nilblMensaje.Text = "El peso tara no puede ser igual o mayor que el peso bruto. Por favor corrija";
                return;
            }

            if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || Convert.ToDecimal(txvPesoBruto.Text) == 0 ||
                Convert.ToDecimal(txvPesoTara.Text) == 0 || this.txtVehiculo.Text.Trim().Length == 0 ||
                Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
            {
                this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
                return;
            }

            if (this.txvRacimos.Text.Trim().Length == 0)
            {
                this.txvRacimos.Text = "0";
            }

            if (this.txvSacos.Text.Trim().Length == 0)
            {
                this.txvSacos.Text = "0";
            }

            if (this.txvPesoSacos.Text.Trim().Length == 0)
            {
                this.txvPesoSacos.Text = "0";
            }

            foreach (GridViewRow registro in this.gvAnalisis.Rows)
            {
                if (((TextBox)registro.FindControl("txtResultado")).Text.Length == 0)
                {
                    resultados = false;
                }
            }

            if (resultados == false)
            {
                this.nilblMensaje.Text = "Debe digitar los análisis completos";
                return;
            }

            if (txtRemision.Visible == true)
                remision = txtRemision.Text;
            else
                remision = txtProgramacion.Text;

            tiquete = bascula.RetornaConsecutivo(
               ConfigurationManager.AppSettings["tiqueteBascula"].ToString(), (int)this.Session["empresa"]);
            numero = bascula.RetornaConsecutivo(ddlTipoTransaccion.SelectedValue.ToString(), (int)this.Session["empresa"]);

            object[] objValores = new object[]{
                1,//@analisisRegistrado
                ddlBodega.SelectedValue,//@bodega
                txtCodigoConductor.Text,//@codigoConductor
                Convert.ToInt16(Session["empresa"]),//@empresa
                "FP",//@estado
                CalendarFechaProceso.SelectedDate,//@fecha
               CalendarFechaProceso.SelectedDate,//@fechaBruto
                CalendarFechaProceso.SelectedDate,//@fechaNeto
                CalendarFechaProceso.SelectedDate,//@fechaProceso
                CalendarFechaProceso.SelectedDate,//@fechaTara
                Convert.ToString(this.ddlFinca.SelectedValue),//@finca
                Convert.ToString(this.ddlProducto.SelectedValue),//@item
                txtNombreConductor.Text,//@nombreConductor
                numero,//@numero
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
                 this.rblDescargador.SelectedItem.Value,//@tipoDescargue
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
                                                ((TextBox)registro.FindControl("txtResultado")).Text
                                                };

                                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "inserta", "ppa",
                                                objValoresAnalisis) == 1)
                                            {
                                                this.nilblMensaje.Text = "Error al insertar los análisis. Operación no realizada";
                                                return;
                                            }
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
        this.nilblMensaje.Text = "";

    
        try
        {
            switch (Convert.ToString(this.ddlOperación.SelectedValue))
            {
                case "0":

                    if (bascula.AnulaTiquete(this.gvLista.SelectedRow.Cells[1].Text, Convert.ToInt16(Session["empresa"])) == 0)
                    {
                        ManejoExito("Tiquete anulado satisfactoriamente", "E");
                    }
                    else
                    {
                        this.nilblMensaje.Text = "Error al anular el tiquete. Operación no realizada";
                    }
                    break;

                case "1":

                    if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text) - Convert.ToDecimal(txvPesoDescuento.Text)) <= 0)
                    {
                        this.nilblMensaje.Text = "El peso tara no puede ser igual o mayor que el peso bruto. Por favor corrija";
                        return;
                    }

                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || Convert.ToDecimal(txvPesoBruto.Text) == 0 ||
                        Convert.ToDecimal(txvPesoTara.Text) == 0 || this.txtVehiculo.Text.Trim().Length == 0 ||
                        Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    if (this.txvRacimos.Text.Trim().Length == 0)
                    {
                        this.txvRacimos.Text = "0";
                    }

                    if (this.txvSacos.Text.Trim().Length == 0)
                    {
                        this.txvSacos.Text = "0";
                    }

                    if (this.txvPesoSacos.Text.Trim().Length == 0)
                    {
                        this.txvPesoSacos.Text = "0";
                    }


                    if (bascula.AnulaCreaTiquete(
                        this.gvLista.SelectedRow.Cells[1].Text,
                        ConfigurationManager.AppSettings["tiqueteBascula"].ToString(),
                        this.gvLista.SelectedRow.Cells[2].Text,
                        this.CalendarFechaProceso.SelectedDate,
                        Convert.ToDecimal(txvPesoBruto.Text),
                        Convert.ToDecimal(txvPesoTara.Text),
                        this.txtVehiculo.Text,
                        this.txtRemolque.Text,
                        Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlProcedencia.SelectedValue),
                        Convert.ToString(this.ddlFinca.SelectedValue),
                        Convert.ToDecimal(this.txvRacimos.Text),
                        Convert.ToDecimal(this.txvSacos.Text),
                        Convert.ToDecimal(this.txvPesoSacos.Text),
                        this.txtSellos.Text,
                        this.Session["usuario"].ToString(),
                        out nuevoTiquete,
                        Convert.ToInt16(Session["empresa"]),
                        Convert.ToDecimal(txvPesoDescuento.Text)) == 0)
                    {
                        ManejoExito("Tiquete creado satisfactoriamente con el número " + nuevoTiquete, "I");
                    }
                    else
                    {
                        this.nilblInformacion.Text = "Error al crear el nuevo tiquete. Operación no realizada";
                    }
                    break;

                case "2":

                    if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text) - Convert.ToDecimal(txvPesoDescuento.Text)) <= 0)
                    {
                        this.nilblMensaje.Text = "El peso tara no puede ser igual o mayor que el peso bruto. Por favor corrija";
                        return;
                    }

                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || Convert.ToDecimal(txvPesoBruto.Text) == 0 ||
                        Convert.ToDecimal(txvPesoTara.Text) == 0 || this.txtVehiculo.Text.Trim().Length == 0 ||
                        Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    if (this.txvRacimos.Text.Trim().Length == 0)
                    {
                        this.txvRacimos.Text = "0";
                    }

                    if (this.txvSacos.Text.Trim().Length == 0)
                    {
                        this.txvSacos.Text = "0";
                    }

                    if (this.txvPesoSacos.Text.Trim().Length == 0)
                    {
                        this.txvPesoSacos.Text = "0";
                    }

                    if (bascula.ModificaTiquete(
                        this.gvLista.SelectedRow.Cells[1].Text,
                        this.CalendarFechaProceso.SelectedDate,
                        Convert.ToDecimal(txvPesoBruto.Text),
                        Convert.ToDecimal(txvPesoTara.Text),
                        this.txtVehiculo.Text,
                        this.txtRemolque.Text,
                        Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlProcedencia.SelectedValue),
                        Convert.ToString(this.ddlFinca.SelectedValue),
                        Convert.ToDecimal(this.txvRacimos.Text),
                        Convert.ToDecimal(this.txvSacos.Text),
                        Convert.ToDecimal(this.txvPesoSacos.Text),
                        this.txtSellos.Text,
                        ddlBodega.SelectedValue,
                        this.rblDescargador.SelectedItem.Value,
                        Convert.ToInt16(Session["empresa"]),
                        Convert.ToDecimal(txvPesoDescuento.Text)) == 0)
                    {
                        ManejoExito("Tiquete modificado satisfactoriamente " + nuevoTiquete, "A");
                    }
                    else
                    {
                        this.nilblInformacion.Text = "Error al modificar el tiquete. Operación no realizada";
                    }
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
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
              ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();
                //this.numPesoTara.cambioValor += new CambioValorHandler(numPesoTara_cambioValor);
                //this.numPesoBruto.cambioValor += new CambioValorHandler(numPesoBruto_cambioValor);
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
        //this.numPesoBruto.ValorActual = 0;
        //this.numPesoTara.ValorActual = 0;
        //this.numPesoBruto.Visible = false;
        //this.numPesoTara.Visible = false;
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
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        //this.numPesoBruto.ValorActual = 0;
        //this.numPesoTara.ValorActual = 0;
        //this.numPesoBruto.Visible = false;
        //this.numPesoTara.Visible = false;
        this.nilblInformacion.Text = "";
        this.ddlOperación.SelectedValue = "0";
        this.ddlProducto.SelectedValue = "";
        this.ddlProcedencia.SelectedValue = "";
        this.ddlFinca.SelectedValue = "";
        this.txvPneto.Text = "0";

        GetEntidad();
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToBoolean(this.Session["editar"]) == true)
        {
            Guardar();
        }
        else
        {
            GuardarTiquete();
        }
    }
    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
            ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(),
                "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);

        ComportamientoNuevoEditar(false);

        this.nilbNuevo.Visible = false;
        this.nilblInformacion.Text = "";
        this.ddlOperación.Focus();
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
        //foreach (Control objControl in this.numPesoBruto.Controls)
        //{
        //    if (objControl is TextBox)
        //    {
        //        objControl.Focus();
        //    }
        //}
    }

    protected void ddlOperación_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblMensaje.Text = "";
        this.lbFechaProceso.Focus();
        txvPneto.Enabled = false;
        try
        {
            switch (Convert.ToString(((DropDownList)sender).SelectedValue))
            {

                case "0":

                    //this.numPesoBruto.ValorActual = 0;
                    //this.numPesoTara.ValorActual = 0;
                    this.nilblInformacion.Text = "";
                    this.ddlOperación.SelectedValue = "0";
                    this.ddlProducto.SelectedValue = "";
                    this.ddlProcedencia.SelectedValue = "";
                    this.ddlFinca.SelectedValue = "";
                    this.txvPneto.Text = "0";
                    break;

                default:

                    CargarCombos(this.gvLista.SelectedRow.Cells[2].Text);
                    cargarProductos(this.gvLista.SelectedRow.Cells[2].Text);

                    foreach (DataRowView registro in bascula.GetBasculaTiquete(
                        this.gvLista.SelectedRow.Cells[1].Text, Convert.ToInt16(Session["empresa"])))
                    {
                        if (Convert.ToString(this.gvLista.SelectedRow.Cells[2].Text) == ConfigurationManager.AppSettings["tipoEMP"].ToString())
                        {
                            this.ddlProcedencia.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(18));

                            CargaFincas();
                            this.lblBodegaDescargue.Visible = true;
                            this.ddlBodega.Visible = true;
                            this.rblDescargador.Visible = true;



                            this.ddlFinca.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(19));
                        }

                        this.CalendarFechaProceso.SelectedDate = Convert.ToDateTime(registro.Row.ItemArray.GetValue(21));
                        this.txtFechaProceso.Text = Convert.ToString(registro.Row.ItemArray.GetValue(21));
                        //this.numPesoBruto.Visible = true;
                        //this.numPesoTara.Visible = true;
                        txvPesoBruto.Text = registro.Row.ItemArray.GetValue(6).ToString();
                        txvPesoDescuento.Text = registro.Row.ItemArray.GetValue(7).ToString();
                        txvPesoTara.Text = registro.Row.ItemArray.GetValue(8).ToString();
                        txvPneto.Text = registro.Row.ItemArray.GetValue(9).ToString();
                        this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(15));
                        this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(16));
                        this.ddlProducto.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(17));
                        this.txvRacimos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(22));
                        this.txvSacos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(24));
                        this.txvPesoSacos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(27));
                        this.txtSellos.Text = Convert.ToString(registro.Row.ItemArray.GetValue(28));

                        try
                        {
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

                        this.ddlBodega.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(23));
                        if (Convert.ToString(registro.Row.ItemArray.GetValue(29)) == "Cooperativa")
                        {
                            this.rblDescargador.Items[1].Selected = true;
                        }
                        else
                        {
                            this.rblDescargador.Items[0].Selected = true;
                        }

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
        if (Convert.ToString(((DropDownList)sender).SelectedValue) == "EMP")
        {
            this.lblBodegaDescargue.Visible = true;
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
            this.lblBodegaDescargue.Visible = true;
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

        txtNumeroTransaccion.Text = bascula.RetornaConsecutivo(ddlTipoTransaccion.SelectedValue.ToString(), (int)this.Session["empresa"]);
        cargarProductos(ddlTipoTransaccion.SelectedValue);
    }

    private void cargarProductos(string tipo)
    {
        try
        {
            this.ddlProducto.DataSource = bascula.GetProductoTransaccion(tipo, (int)this.Session["empresa"]);
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
        {
            AnalisisProducto();
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



    #endregion Eventos




    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                    nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
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
        this.nilblMensaje.Text = "";
    }
}
