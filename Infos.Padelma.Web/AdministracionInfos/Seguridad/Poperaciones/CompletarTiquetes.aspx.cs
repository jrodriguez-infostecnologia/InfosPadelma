using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
    private void CargaIncompletos()
    {
        try
        {
            this.niddlTransacciones.DataSource = bascula.GetIncompletos(Convert.ToInt16(Session["empresa"]));
            this.niddlTransacciones.DataValueField = "numero";
            this.niddlTransacciones.DataTextField = "cadena";
            this.niddlTransacciones.DataBind();
            this.niddlTransacciones.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar transacciones incompletas. Correspondiente a: " + ex.Message, "C");
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

            this.gvLista.DataSource = bascula.GetBasculaNumero(Convert.ToString(this.niddlTransacciones.SelectedValue), Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C",
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


        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        seguridad.InsertaLog(
        this.Session["usuario"].ToString(),
        operacion,
        ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
        "ex",
        mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }
    private void CargarCombos()
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

    private void Guardar()
    {
        string nuevoTiquete = "";
        string cargador = null;

        try 
        { 
            Convert.ToDecimal(txvPesoBruto.Text);
            Convert.ToDecimal(txvPesoTara.Text);
            Convert.ToDecimal(txvPneto.Text);
        }
        catch(Exception ex)
        {
            nilblInformacion.Text="Solo se permiten numeros";
        }

        this.nilblMensaje.Text = "";
        try
        {
            if (ddlTipoTransaccion.SelectedValue == "EPE")
            {
                cargador = rblDescargador.SelectedValue;
            }

            switch (Convert.ToString(this.ddlOperación.SelectedValue))
            {
                case "0":

                    if (bascula.AnulaTiqueteNumero(this.gvLista.SelectedRow.Cells[1].Text, Convert.ToInt16(Session["empresa"])) == 0)
                        ManejoExito("Transacción anulada satisfactoriamente", "E");
                    else
                        this.nilblMensaje.Text = "Error al anular la transacción. Operación no realizada";
                    break;

                case "1":

                    if ((Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text)) <= 0)
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


                    if (bascula.CompletaTiquete(
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
                        Convert.ToInt16(this.txvRacimos.Text),
                        Convert.ToInt16(this.txvSacos.Text),
                        Convert.ToDecimal(this.txvPesoSacos.Text),
                        this.txtSellos.Text,
                        this.Session["usuario"].ToString(),
                        out nuevoTiquete,
                        Convert.ToInt16(Session["empresa"]),
                        0) == 0)
                    {
                        ManejoExito("Tiquete creado satisfactoriamente con el número " + nuevoTiquete, "I");
                    }
                    else
                    {
                        this.nilblInformacion.Text = "Error al crear el nuevo tiquete. Operación no realizada";
                    }
                    break;

                case "2":


                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 || this.txtVehiculo.Text.Trim().Length == 0 || Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    if (this.txvRacimos.Text.Trim().Length == 0)
                        this.txvRacimos.Text = "0";

                    if (this.txvSacos.Text.Trim().Length == 0)
                        this.txvSacos.Text = "0";

                    if (this.txvPesoSacos.Text.Trim().Length == 0)
                        this.txvPesoSacos.Text = "0";

                    if (bascula.ModificaIncompleto(
                        this.gvLista.SelectedRow.Cells[1].Text,
                        this.CalendarFechaProceso.SelectedDate,
                        Convert.ToDecimal(txvPesoBruto.Text),
                        Convert.ToDecimal(txvPesoTara.Text),
                         Convert.ToDecimal(txvPneto.Text),
                        this.txtVehiculo.Text,
                        this.txtRemolque.Text,
                        Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlProcedencia.SelectedValue),
                        Convert.ToString(this.ddlFinca.SelectedValue),
                        Convert.ToInt16(this.txvRacimos.Text),
                        Convert.ToInt16(this.txvSacos.Text),
                        Convert.ToDecimal(this.txvPesoSacos.Text),
                        this.txtSellos.Text,
                        ddlBodega.SelectedValue,
                        cargador,
                        Convert.ToInt16(Session["empresa"]),
                        0) == 0)
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
                this.niddlTransacciones.Focus();
                //this.numPesoTara.cambioValor += new CambioValorHandler(numPesoTara_cambioValor);
                //this.numPesoBruto.cambioValor += new CambioValorHandler(numPesoBruto_cambioValor);

                if (!IsPostBack)
                {
                    CargaIncompletos();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
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

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilblInformacion.Text = "";
        this.ddlOperación.SelectedValue = "0";
        this.ddlProducto.SelectedValue = "";
        this.ddlFinca.SelectedValue = "";
        this.txvPneto.Text = "0";
        this.rblDescargador.Visible = false;

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
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();

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
        rblDescargador.Visible = true;
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

    }

    protected void ddlOperación_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblMensaje.Text = "";
        this.lbFechaProceso.Focus();
        string cargador = null;

        try
        {
            if (ddlTipoTransaccion.SelectedValue == "EPE")
            {
                cargador = rblDescargador.SelectedValue;            
            }

            switch (Convert.ToString(((DropDownList)sender).SelectedValue))
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
                    CargarCombos();
                    cargarProductos(this.gvLista.SelectedRow.Cells[2].Text);

                    ddlTipoTransaccion.SelectedValue = gvLista.SelectedRow.Cells[2].Text;
                    txtNumeroTransaccion.Text = gvLista.SelectedRow.Cells[3].Text;
                    foreach (DataRowView registro in bascula.GetBasculaNumero(this.gvLista.SelectedRow.Cells[1].Text, Convert.ToInt16(Session["empresa"])))
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
                        txvPesoBruto.Text = registro.Row.ItemArray.GetValue(6).ToString();
                        txvPesoTara.Text = registro.Row.ItemArray.GetValue(8).ToString();
                        txvPneto.Text = registro.Row.ItemArray.GetValue(9).ToString();
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
                            this.rblDescargador.Items[1].Selected = true;
                        else
                            this.rblDescargador.Items[0].Selected = true;

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
    }

    protected void txtVehiculo_TextChanged(object sender, EventArgs e)
    {
        this.txvPneto.Text = Convert.ToString(Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text));
    }
    protected void txtRemolque_TextChanged(object sender, EventArgs e)
    {
        this.txvPneto.Text = Convert.ToString(Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text));
    }
    protected void txvPesoDescuento_TextChanged(object sender, EventArgs e)
    {
        this.txvPneto.Text = Convert.ToString(Convert.ToDecimal(txvPesoBruto.Text) - Convert.ToDecimal(txvPesoTara.Text));
    }

    protected void niddlTransacciones_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    #endregion Eventos



}
