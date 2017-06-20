using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Compras_Ptransaccion_Transaccion : System.Web.UI.Page
{
    #region Instancias
    //--------------------------------------------------------------------------

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();

    //--------------------------------------------------------------------------

    Ctransacciones transacciones = new Ctransacciones();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Cperiodos periodo = new Cperiodos();
    Citems item = new Citems();
    Cdestinos destino = new Cdestinos();
    CtransaccionAlmacen transaccionAlmacen = new CtransaccionAlmacen();

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }
    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        this.Response.Redirect("~/Compras/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upCabeza.Controls);

        CcontrolesUsuario.InhabilitarControles(
            this.upDetalle.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upDetalle.Controls);

        InHabilitaEncabezado();

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.Session["transaccion"] = null;
        this.nilblInformacion.Text = mensaje;
        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
        this.lbRegistrar.Visible = false;

        this.lbImprimir.Visible = true;

    }
    private void InHabilitaEncabezado()
    {
        this.nilblInformacion.Text = "";
        this.lbCancelar.Visible = false;
        this.nilbNuevo.Visible = true;
        this.lblTipoDocumento.Visible = false;
        this.ddlTipoDocumento.Visible = false;
        this.lblNumero.Visible = false;
        this.txtNumero.Visible = false;
        this.txtNumero.Text = "";
        this.nilbNuevo.Focus();
    }
    private void CargaCampos()
    {
        try
        {
            this.niddlCampo.DataSource = transacciones.GetCamposEntidades("iTransaccion", "");
            this.niddlCampo.DataValueField = "name";
            this.niddlCampo.DataTextField = "name";
            this.niddlCampo.DataBind();
            this.niddlCampo.Items.Insert(0, new ListItem("Selección de campo", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos para edición. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void CargarCombos()
    {
        try
        {
            this.ddlDepartamento.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nDepartamento", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlDepartamento.DataValueField = "codigo";
            this.ddlDepartamento.DataTextField = "descripcion";
            this.ddlDepartamento.DataBind();
            this.ddlDepartamento.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de salida. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlUmedida.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gUnidadMedida", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlUmedida.DataValueField = "codigo";
            this.ddlUmedida.DataTextField = "descripcion";
            this.ddlUmedida.DataBind();
            this.ddlUmedida.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidades de medida. Correspondiente a: " + ex.Message, "C");
        }

    }
    private void ManejoEncabezado()
    {
        HabilitaEncabezado();
        CargarTipoTransaccion();
    }
    private void CargarTipoTransaccion()
    {
        try
        {
            this.ddlTipoDocumento.DataSource = tipoTransaccion.GetTipoTransaccionModulo(Convert.ToInt16(Session["empresa"]));
            this.ddlTipoDocumento.DataValueField = "codigo";
            this.ddlTipoDocumento.DataTextField = "descripcion";
            this.ddlTipoDocumento.DataBind();
            this.ddlTipoDocumento.Items.Insert(0, new ListItem("", ""));
            this.ddlTipoDocumento.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void HabilitaEncabezado()
    {
        this.nilblInformacion.Text = "";
        this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
        this.lbCancelar.Visible = true;
        this.nilbNuevo.Visible = false;
        this.lblTipoDocumento.Visible = true;
        this.ddlTipoDocumento.Visible = true;
        this.ddlTipoDocumento.Enabled = true;
        this.lblNumero.Visible = true;
        this.txtNumero.Visible = true;
        this.txtNumero.Text = "";
        this.ddlTipoDocumento.Focus();
        this.niCalendarFecha.Visible = false;
        this.lbRegistrar.Visible = true;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvReferencia.DataSource = null;
        this.gvReferencia.DataBind();
        //this.gvTotal.DataSource = null;
        //this.gvTotal.DataBind();
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.Session["transaccion"] = null;
        this.lbImprimir.Visible = false;
    }
    private string ConsecutivoTransaccion()
    {
        string numero = "";

        try
        {
            numero = transacciones.RetornaNumeroTransaccion(
                Convert.ToString(this.ddlTipoDocumento.SelectedValue), (int)this.Session["empresa"]);
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el número de transacción. Correspondiente a: " + ex.Message, "C");
        }

        return numero;
    }
    private object TipoTransaccionConfig(int posicion)
    {
        object retorno = null;
        string cadena;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            cadena = tipoTransaccion.TipoTransaccionConfig(ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"])).ToString();
            retorno = cadena.Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar posición de configuración de tipo de transacción. Correspondiente a: " + ex.Message, "C");

            return null;
        }
    }
    private int CompruebaTransaccionExistente()
    {
        try
        {
            object[] objkey = new object[]{ 
                (int)this.Session["empresa"],
                this.txtNumero.Text,
                 Convert.ToString(this.ddlTipoDocumento.SelectedValue)                 
                  };

            if (CentidadMetodos.EntidadGetKey(
                "iTransaccion",
                "ppa",
                objkey).Tables[0].DefaultView.Count > 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al comprobar transacción existente. Correspondiente a: " + ex.Message, "C");

            return 1;
        }
    }
    private void ComportamientoConsecutivo()
    {
        if (this.txtNumero.Text.Length == 0)
        {
            this.txtNumero.Enabled = true;
            this.txtNumero.ReadOnly = false;
            this.txtNumero.Focus();
        }
        else
        {
            if (this.txtFecha.Visible == true)
            {
                if (CompruebaTransaccionExistente() == 1)
                {
                    this.nilblInformacion.Text = "Transacción existente. Por favor corrija";

                    return;
                }
                else
                {
                    this.nilblInformacion.Text = "";
                }
            }

            this.txtNumero.Enabled = false;

            CcontrolesUsuario.HabilitarControles(
                this.upCabeza.Controls);

            this.lbImprimir.Visible = false;
            this.nilbNuevo.Visible = false;
            this.txtFecha.Visible = false;
            this.txtFecha.Focus();
        }
    }
    private void CargaProductos()
    {
        try
        {
            DataView dvProducto = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"),
              "descripcion", Convert.ToInt16(Session["empresa"]));
            dvProducto.RowFilter = "tipo in ('I','T')";
            this.ddlProducto.DataSource = dvProducto;
            this.ddlProducto.DataValueField = "codigo";
            this.ddlProducto.DataTextField = "cadena";
            this.ddlProducto.DataBind();
            this.ddlProducto.Items.Insert(0, new ListItem("", ""));
            this.ddlProducto.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar productos. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void CargaDestinos()
    {
        try
        {

            DataView dvDestino = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iDestino", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvDestino.RowFilter = "nivel = " + Convert.ToString(TipoTransaccionConfig(2));
            this.ddlDestino.DataSource = dvDestino;
            this.ddlDestino.DataValueField = "codigo";
            this.ddlDestino.DataTextField = "descripcion";
            this.ddlDestino.DataBind();
            this.ddlDestino.Items.Insert(0, new ListItem("", ""));
            this.ddlDestino.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar destinos. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void TabRegistro()
    {
        this.upRegistro.Visible = true;
        this.upConsulta.Visible = false;

        if (Convert.ToBoolean(this.Session["editar"]) == true)
        {
            this.upDetalle.Visible = true;
            this.upCabeza.Visible = true;
        }

        this.niimbRegistro.BorderStyle = BorderStyle.None;
        this.niimbConsulta.BorderStyle = BorderStyle.Solid;
        this.niimbConsulta.BorderColor = System.Drawing.Color.White;
        this.niimbConsulta.BorderWidth = Unit.Pixel(1);
        this.niimbConsulta.Enabled = true;
        this.niimbRegistro.Enabled = false;
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.nilblRegistros.Text = "Nro. Registros 0";
        this.nilblMensajeEdicion.Text = "";
        this.lbImprimir.Visible = false;
    }
    private void GetSaldo()
    {
        //try
        //{
        //    if (Convert.ToBoolean(this.Session["editar"]) == false)
        //    {

        //        this.gvSaldo.Visible = true;
        //        this.gvSaldo.DataSource = transacciones.GetSaldoTotalProductoFecha(
        //            Convert.ToString(this.ddlProducto.SelectedValue), this.niCalendarFecha.SelectedDate);
        //        this.gvSaldo.DataBind();

        //        foreach (GridViewRow registro in this.gvSaldo.Rows)
        //        {
        //            ((GridView)registro.FindControl("gvDetalleReque")).DataSource = transacciones.RequerimientoSaldos(
        //             Convert.ToString(this.ddlProducto.SelectedValue));
        //            ((GridView)registro.FindControl("gvDetalleReque")).DataBind();

        //            ((GridView)registro.FindControl("gvDetalleCompra")).DataSource = transacciones.CompraSaldos(
        //            Convert.ToString(this.ddlProducto.SelectedValue));
        //            ((GridView)registro.FindControl("gvDetalleCompra")).DataBind();

        //            ((GridView)registro.FindControl("gvDetalleRequi")).DataSource = transacciones.RequisicionSaldos(
        //            Convert.ToString(this.ddlProducto.SelectedValue));
        //            ((GridView)registro.FindControl("gvDetalleRequi")).DataBind();
        //        }
        //    }

        //}
        //catch (Exception ex)
        //{
        //    ManejoError("Error al cargar el saldo del producto seleccionado. Correspondiente a: " + ex.Message, "C");
        //}
    }
    private void UmedidaProducto()
    {
        try
        {
            this.ddlUmedida.SelectedValue = item.RetornaUmedida(
                Convert.ToString(this.ddlProducto.SelectedValue), Convert.ToInt16(Session["empresa"]));

            if (Convert.ToBoolean(TipoTransaccionConfig(21)) == true)
            {
                this.ddlUmedida.Enabled = false;
            }
            else
            {
                this.ddlUmedida.Enabled = true;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar unidad de medida producto. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void GetAjuste()
    {
        //try
        //{
        //    this.gvAjuste.Visible = true;
        //    this.gvAjuste.DataSource = transacciones.GetSaldosBodegaTotal(
        //        this.ddlProducto.SelectedValue, this.niCalendarFecha.SelectedDate.Year, this.niCalendarFecha.SelectedDate.Month);
        //    this.gvAjuste.DataBind();
        //}
        //catch (Exception ex)
        //{
        //    ManejoError("Error al cargar saldos en bodegas. Correspondiente a: " + ex.Message, "C");
        //}
    }
    private void CargarCuenta()
    {
        try
        {
            this.ddlCuenta.DataSource = destino.CuentasAuxiliares(this.ddlDestino.SelectedValue, this.chkInversion.Checked, Convert.ToInt16(Session["empresa"]));
            this.ddlCuenta.DataValueField = "codigo";
            this.ddlCuenta.DataTextField = "descripcion";
            this.ddlCuenta.DataBind();
            this.ddlCuenta.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar proveedores habilitados para orden directa. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void CargarCentroCosto()
    {
        try
        {
            this.ddlCcosto.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cCentrosCosto", "planta"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlCcosto.DataValueField = "codigo";
            this.ddlCcosto.DataTextField = "descripcion";
            this.ddlCcosto.DataBind();
            this.ddlCcosto.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidades de medida. Correspondiente a: " + ex.Message, "C");
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

                if (!IsPostBack)
                {
                    CargarCombos();
                    CargaCampos();

                    this.Session["transaccion"] = null;
                    this.Session["operadores"] = null;
                }

                this.nitxtTotalValorTotal.Text = "0";
                this.nitxtTotalValorNeto.Text = "0";

                //TotalizaGrillaReferencia();

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }
    protected void nilbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        this.Session["editar"] = false;

        ManejoEncabezado();
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        InHabilitaEncabezado();

        CcontrolesUsuario.InhabilitarControles(
            this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upCabeza.Controls);

        CcontrolesUsuario.InhabilitarControles(
            this.upDetalle.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upDetalle.Controls);

        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.niCalendarFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
        this.lbRegistrar.Visible = false;
        //this.gvTotal.DataSource = null;
        //this.gvTotal.DataBind();
        this.gvReferencia.DataSource = null;
        this.gvReferencia.DataBind();
        this.nilblValorNeto.Visible = false;
        this.nilblValorTotal.Visible = false;
        this.nitxtTotalValorNeto.Visible = false;
        this.nitxtTotalValorTotal.Visible = false;
        this.fuFoto.Visible = false;
        this.lbDocumento.Visible = false;

        this.lbCancelar.Visible = false;
        this.lbImprimir.Visible = false;
      

    }
    protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {


            CcontrolesUsuario.InhabilitarControles(
       this.UpdatePanelReferencia.Controls);
            CcontrolesUsuario.LimpiarControles(
                this.UpdatePanelReferencia.Controls);

            CcontrolesUsuario.InhabilitarControles(
                this.upCabeza.Controls);
            CcontrolesUsuario.LimpiarControles(
                this.upCabeza.Controls);

            CcontrolesUsuario.InhabilitarControles(
                this.upDetalle.Controls);
            CcontrolesUsuario.LimpiarControles(
                this.upDetalle.Controls);

            this.gvReferencia.DataSource = null;
            this.gvReferencia.DataBind();
            this.gvLista.DataSource = null;
            this.gvLista.DataBind();
            //this.gvTotal.DataSource = null;
            //this.gvTotal.DataBind();
            this.Session["transaccion"] = null;
            this.nilblValorNeto.Visible = false;
            this.nilblValorTotal.Visible = false;
            this.nitxtTotalValorNeto.Visible = false;
            this.nitxtTotalValorTotal.Visible = false;
            this.nigvTrnReferencia.Visible = false;
            this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
            this.txtNumero.Text = ConsecutivoTransaccion();
            this.lbImprimir.Visible = false;

            this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(
                this.ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));


            if (Convert.ToBoolean(TipoTransaccionConfig(17)) == true)
            {
                if (tipoTransaccion.RetornavalidacionRegistro(Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"])) == 1)
                {
                    this.nilblInformacion.Text = "No se puede realizar este tipo movimiento el día de hoy";
                    this.niCalendarFecha.Visible = false;
                    return;
                }

            }
            else
            {
                this.nilblInformacion.Text = "";
            }



            if (Convert.ToBoolean(TipoTransaccionConfig(15)) == false)
            {
                this.nilblInformacion.Text = "Transacción no habilitada para registro directo";
                return;
            }

            ComportamientoConsecutivo();
            CargaProductos();
            CargaDestinos();

            if (tipoTransaccion.RetornaReferenciaTipoTransaccion(
                Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.UpdatePanelReferencia.Visible = true;
                this.upDetalle.Visible = false;
                this.nilblValorNeto.Visible = true;
                this.nilblValorTotal.Visible = true;
                this.nitxtTotalValorNeto.Visible = true;
                this.nitxtTotalValorTotal.Visible = true;
                this.nigvTrnReferencia.Visible = true;
                this.nibtnCargar.Visible = true;


                switch (Convert.ToBoolean(TipoTransaccionConfig(6)))
                {
                    case false:

                        try
                        {
                            this.nigvTrnReferencia.DataSource = tipoTransaccion.GetReferencia(
                                Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"]), Convert.ToInt16(this.ddlTercero.SelectedValue));
                            this.nigvTrnReferencia.DataBind();

                        }
                        catch (Exception ex)
                        {
                            ManejoError("Error al cargar documentos referencia. Correspondiente a: " + ex.Message, "C");
                        }
                        break;
                }
            }
            else
            {
                this.UpdatePanelReferencia.Visible = false;
                this.upDetalle.Visible = true;
                this.nilblValorNeto.Visible = false;
                this.nilblValorTotal.Visible = false;
                this.nitxtTotalValorNeto.Visible = false;
                this.nitxtTotalValorTotal.Visible = false;

                this.nigvTrnReferencia.Visible = false;

            }

            if (Convert.ToBoolean(TipoTransaccionConfig(18)) == true)
            {
                this.fuFoto.Visible = true;
                this.lbDocumento.Visible = true;
            }
            else
            {
                this.fuFoto.Visible = false;
                this.lbDocumento.Visible = false;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al comprobar transacción con referencia. Correspondiente a: " + ex.Message, "C");
        }
    }
    protected void txtNumero_TextChanged(object sender, EventArgs e)
    {
        if (this.txtFecha.Visible == true)
        {
            if (CompruebaTransaccionExistente() == 1)
            {
                this.nilblInformacion.Text = "Transacción existente. Por favor corrija";

                return;
            }
            else
            {
                this.nilblInformacion.Text = "";
            }
        }

        CcontrolesUsuario.HabilitarControles(
            this.upCabeza.Controls);

        this.nilbNuevo.Visible = false;
        this.txtFecha.Visible = false;
        this.lbFecha.Focus();
    }
    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToString();
        this.txtFecha.Enabled = false;

        if (periodo.RetornaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
               Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), (int)this.Session["empresa"]) == 1)
        {
            ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
        }

        else
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                if (Convert.ToString(this.niCalendarFecha.SelectedDate.Year) +
                    Convert.ToString(this.niCalendarFecha.SelectedDate.Month).PadLeft(2, '0') != this.Session["periodo"].ToString())
                {
                    ManejoError("La fecha debe corresponder al periodo actual de la transacción", "A");
                }
            }
            else
            {
                if (CompruebaTransaccionExistente() == 1)
                {
                    this.nilblInformacion.Text = "Transacción existente. Por favor corrija";

                    return;
                }
                else
                {
                    this.nilblInformacion.Text = "";
                }

                CcontrolesUsuario.ComportamientoCampoEntidad(this.upCabeza.Controls, "iTransaccionDetalle",
                        Convert.ToString(this.ddlTipoDocumento.SelectedValue), (int)this.Session["empresa"]);


                if (Convert.ToBoolean(TipoTransaccionConfig(14)) == true)
                {
                    try
                    {
                        DataView dvProveedor = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cxpProveedor", "ppa"),
                                                                                "descripcion", Convert.ToInt16(Session["empresa"]));
                        dvProveedor.RowFilter = "entradaDirecta = 1";
                        this.ddlTercero.DataSource = dvProveedor;
                        this.ddlTercero.DataValueField = "codigo";
                        this.ddlTercero.DataTextField = "cadena";
                        this.ddlTercero.DataBind();
                        this.ddlTercero.Items.Insert(0, new ListItem("", ""));
                    }
                    catch (Exception ex)
                    {
                        ManejoError("Error al cargar proveedores habilitados para orden directa. Correspondiente a: " + ex.Message, "C");
                    }
                }

                try
                {

                    if (Convert.ToBoolean(TipoTransaccionConfig(16)) == true)
                    {
                        DataView dvBodega = CentidadMetodos.EntidadGet("iBodega", "ppa").Tables[0].DefaultView;
                        dvBodega.RowFilter = "tipo = 'V'";

                        this.ddlBodega.DataSource = dvBodega;
                        this.ddlBodega.DataValueField = "codigo";
                        this.ddlBodega.DataTextField = "descripcion";
                        this.ddlBodega.DataBind();
                        this.ddlBodega.Items.Insert(0, new ListItem("", ""));
                    }
                    else
                    {
                        this.ddlBodega.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(
                            CentidadMetodos.EntidadGet("iBodega", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
                        this.ddlBodega.DataValueField = "codigo";
                        this.ddlBodega.DataTextField = "descripcion";
                        this.ddlBodega.DataBind();
                        this.ddlBodega.Items.Insert(0, new ListItem("", ""));
                    }


                }
                catch (Exception ex)
                {
                    ManejoError("Error al cargar bodegas. Correspondiente a: " + ex.Message, "C");
                }

                this.txtObservacion.Focus();
                this.btnRegistrar.Visible = true;

                if (this.ddlProducto.Visible == true)
                {
                    this.txtProducto.Visible = true;
                    this.txtProducto.Enabled = true;
                    this.txtProducto.ReadOnly = false;
                }

                if (Convert.ToBoolean(TipoTransaccionConfig(1)) == true && Convert.ToBoolean(TipoTransaccionConfig(12)) == false)
                {
                    this.btnRegistrar.Visible = false;
                }

                if (Convert.ToBoolean(TipoTransaccionConfig(18)) == true)
                {
                    this.fuFoto.Visible = true;
                    this.lbDocumento.Visible = true;
                }
                else
                {
                    this.fuFoto.Visible = false;
                    this.lbDocumento.Visible = false;
                }
            }
        }
    }
    protected void niimbRegistro_Click(object sender, ImageClickEventArgs e)
    {
        TabRegistro();
    }
    protected void niimbConsulta_Click(object sender, ImageClickEventArgs e)
    {
        this.upRegistro.Visible = false;
        this.upDetalle.Visible = false;
        this.upCabeza.Visible = false;
        this.UpdatePanelReferencia.Visible = false;
        this.upConsulta.Visible = true;

        this.niimbConsulta.BorderStyle = BorderStyle.None;
        this.niimbRegistro.BorderStyle = BorderStyle.Solid;
        this.niimbRegistro.BorderColor = System.Drawing.Color.White;
        this.niimbRegistro.BorderWidth = Unit.Pixel(1);
        this.niimbConsulta.Enabled = false;
        this.niimbRegistro.Enabled = true;
        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        //this.gvTotal.DataSource = null;
        //this.gvTotal.DataBind();
        this.gvReferencia.DataSource = null;
        this.gvReferencia.DataBind();
        this.lbImprimir.Visible = false;

    }
    private bool CompruebaSaldo()
    {
        decimal saldo = 0;

        try
        {
            DataView dvSaldo = transacciones.GetSaldoTotalProducto(Convert.ToString(this.ddlProducto.SelectedValue), Convert.ToInt16(Session["empresa"]));

            foreach (DataRowView registro in dvSaldo)
            {
                saldo = Convert.ToDecimal(registro.Row.ItemArray.GetValue(0)) - Convert.ToDecimal(registro.Row.ItemArray.GetValue(1));
            }

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                saldo = saldo + Convert.ToDecimal(this.Session["cant"]);
            }

            if (Convert.ToDecimal(txtCantidad.Text) > saldo)
            {
                this.nilblInformacion.Text = "Saldo inferior a la cantidad solicitada. Por favor corrija";
                return false;
            }
            else
            {
                return true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al comprobar saldo. Correspondiente a: " + ex.Message, "C");
            return false;
        }
    }
    private void TotalizaTransaccion()
    {
        try
        {
            //this.gvTotal.DataSource = transaccionAlmacen.TotalizaTransaccion(
            //    (List<CtransaccionAlmacen>)Session["transaccion"]);
            //this.gvTotal.DataBind();
        }
        catch (Exception ex)
        {
            CcontrolesUsuario.MensajeError(
                "Error al totalizar la transacción. Correspondiente a: " + ex.Message,
                this.nilblInformacion);
        }
    }
    private void TotalizaGrillaReferencia()
    {
        try
        {
            this.nitxtTotalValorNeto.Text = "0";
            this.nitxtTotalValorTotal.Text = "0";

            foreach (GridViewRow registro in this.gvReferencia.Rows)
            {
                registro.Cells[10].Text = Convert.ToString(
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text) *
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtValorUnitario")).Text));

                registro.Cells[9].Text = Convert.ToString(
                    (Convert.ToDecimal(registro.Cells[10].Text) - Convert.ToDecimal(registro.Cells[11].Text)) *
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtPiva")).Text) / 100);
                registro.Cells[11].Text = Convert.ToString(
                    Convert.ToDecimal(registro.Cells[10].Text) *
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtPDes")).Text) / 100);
                registro.Cells[12].Text = Convert.ToString(
                    Convert.ToDecimal(registro.Cells[10].Text) + Convert.ToDecimal(registro.Cells[9].Text));

                this.nitxtTotalValorNeto.Text = Convert.ToString(Convert.ToDecimal(registro.Cells[12].Text) - Convert.ToDecimal(registro.Cells[11].Text) + Convert.ToDecimal(this.nitxtTotalValorNeto.Text));
                this.nitxtTotalValorTotal.Text = Convert.ToString(Convert.ToDecimal(registro.Cells[10].Text) + Convert.ToDecimal(this.nitxtTotalValorTotal.Text));
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al totalizar la grilla de referencia. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Eventos

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void ddlTercero_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToBoolean(TipoTransaccionConfig(6)) == true)
            {
                this.nigvTrnReferencia.DataSource = tipoTransaccion.GetReferencia(
                   Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"]), Convert.ToInt16(this.ddlTercero.SelectedValue));
                this.nigvTrnReferencia.DataBind();

                this.gvReferencia.DataSource = null;
                this.gvReferencia.DataBind();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar documentos referencia. Correspondiente a: " + ex.Message, "C");
        }

        this.ddlTercero.Focus();
    }
    protected void txtProducto_TextChanged(object sender, EventArgs e)
    {
        try
        {
            DataView dvProducto = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"),
              "descripcion", Convert.ToInt16(Session["empresa"]));
            dvProducto.RowFilter = "tipo in ('I','T') and codigo like '%" + this.txtProducto.Text.Trim() + "%' or descripcion like '%" +
        this.txtProducto.Text.Trim() + "%'";

            this.ddlProducto.DataSource = dvProducto;
            this.ddlProducto.DataBind();
            this.ddlProducto.Focus();

            if (Convert.ToBoolean(TipoTransaccionConfig(1)) == true && Convert.ToBoolean(TipoTransaccionConfig(12)) == false)
            {
                GetAjuste();
            }
            else
            {
                UmedidaProducto();
                GetSaldo();

            }
        }
        catch
        {
            this.ddlProducto.SelectedValue = "";
            this.txtProducto.Focus();
        }
    }
    protected void lbImprimir_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.ddlProducto.Focus();
        this.txtProducto.Text = this.ddlProducto.SelectedValue;

        if (Convert.ToBoolean(TipoTransaccionConfig(1)) == true && Convert.ToBoolean(TipoTransaccionConfig(12)) == false)
        {
            GetAjuste();
        }
        else
        {
            UmedidaProducto();
            GetSaldo();
        }
    }
    protected void ddlDestino_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.ddlDestino.Visible == true)
        {
            if (destino.ConsultaMostrarCuenta(this.ddlDestino.SelectedValue, this.chkInversion.Checked, Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.lblCuenta.Visible = true;
                this.ddlCuenta.Visible = true;
                this.ddlCuenta.Enabled = true;
                CargarCuenta();
            }
            else
            {
                this.lblCuenta.Visible = false;
                this.ddlCuenta.Visible = false;
                this.lblCcosto.Visible = false;
                this.ddlCcosto.Visible = false;
            }
        }
    }
    protected void ddlCuenta_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.ddlCuenta.Visible == true)
        {
            if (destino.ConsultaCuentaCentroCosto(this.ddlCuenta.SelectedValue, Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.lblCcosto.Visible = true;
                this.ddlCcosto.Visible = true;
                this.ddlCcosto.Enabled = true;
                CargarCentroCosto();
            }
            else
            {
                this.lblCcosto.Visible = false;
                this.ddlCcosto.Visible = false;
            }
        }
    }
    protected void chkInversion_CheckedChanged(object sender, EventArgs e)
    {
        if (this.chkInversion.Visible == true)
        {
            if (destino.ConsultaMostrarCuenta(this.ddlDestino.SelectedValue, this.chkInversion.Checked, Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.lblCuenta.Visible = true;
                this.ddlCuenta.Visible = true;
                this.ddlCuenta.Enabled = true;
                CargarCuenta();
            }
            else
            {
                this.lblCuenta.Visible = false;
                this.ddlCuenta.Visible = false;
            }
        }
    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        try
        {
            if (this.gvLista.Rows.Count >= 15)
            {
                this.nilblInformacion.Text = "El número de artículos no puede ser mayor a 15";
                return;
            }

            if (Convert.ToBoolean(TipoTransaccionConfig(4)) == true)
            {
                if (CompruebaSaldo() == false)
                {
                    return;
                }
            }

            foreach (GridViewRow registro in this.gvLista.Rows)
            {
                if (Convert.ToString(this.ddlProducto.SelectedValue) == registro.Cells[3].Text.Trim())
                {
                    this.nilblInformacion.Text = "El producto seleccionado ya se encuentra registrado. Por favor corrija";
                    return;
                }
            }

            if (Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim().Length == 0 ||
                this.txtNumero.Text.Trim().Length == 0)
            {
                CcontrolesUsuario.MensajeError(
                    "Debe ingresar tipo y número de transacción",
                    this.nilblInformacion);
                return;
            }



            if (CcontrolesUsuario.VerificaCamposRequeridos(
                this.upDetalle.Controls) == false)
            {
                CcontrolesUsuario.MensajeError(
                    "Campos vacios. Por favor corrija",
                    this.nilblInformacion);
                return;
            }

            if (this.ddlCuenta.Visible == true)
            {
                if (destino.ValidaCuentaMayor(this.ddlCuenta.SelectedValue, Convert.ToInt16(Session["empresa"])) != 0)
                {
                    CcontrolesUsuario.MensajeError(
                        "Debe seleccionar una cuenta Auxiliar",
                        this.nilblInformacion);
                    return;

                }
            }

            if (this.ddlDestino.Visible == true)
            {
                if (destino.ValidaDestinoInversion(this.ddlDestino.SelectedValue, this.chkInversion.Checked, Convert.ToInt16(Session["empresa"])) != 0)
                {
                    CcontrolesUsuario.MensajeError(
                        "El destino no tiene cuenta de inversión",
                        this.nilblInformacion);
                    return;

                }
            }

            if (Convert.ToDecimal(txtCantidad.Text) <= 0)
            {
                this.nilblInformacion.Text = "La cantidad no puede ser igual o menor que cero. Por favor corrija";
                return;
            }

            if (Convert.ToBoolean(TipoTransaccionConfig(15)) == false)
            {
                if (Convert.ToDecimal(txtCantidad.Text) > Convert.ToDecimal(this.hdCantidad.Value))
                {
                    this.nilblInformacion.Text = "La cantidad no puede ser mayor a la registrada inicialmente. Por favor Corrija";
                    txtCantidad.Text = this.hdCantidad.Value;
                }
            }

            if (Convert.ToBoolean(this.Session["editar"]) == false)
            {
                //decimal[] tributario = catalogo.RetornaTributario(
                //    Convert.ToString(this.ddlProducto.SelectedValue));

                //pIva = Convert.ToDecimal(tributario.GetValue(0));

                //if (this.numPiva.ValorActual() != 0)
                //{
                //    this.numPiva.ValorActual(pIva);
                //}
            }

            transaccionAlmacen = new CtransaccionAlmacen(
                Convert.ToString(this.ddlBodega.SelectedValue),
                Convert.ToString(this.ddlProducto.SelectedValue),
                Convert.ToDecimal(txtCantidad.Text),
                Convert.ToString(this.ddlUmedida.SelectedValue),
                Convert.ToDecimal(txtValorUnitario.Text),
                Convert.ToString(this.ddlCuenta.SelectedValue),
                Convert.ToString(this.ddlDestino.SelectedValue),
                this.chkInversion.Checked,
                Convert.ToString(this.ddlCcosto.SelectedValue),
                Convert.ToDecimal(txtValorUnitario.Text) * Convert.ToDecimal(txtCantidad.Text),
                0,
                Server.HtmlDecode(this.txtDetalle.Text.Trim()),
                Convert.ToInt16(this.hdRegistro.Value),
                Convert.ToInt16(Session["empresa"])
                );

            List<CtransaccionAlmacen> listaTransaccion = null;

            if (this.Session["transaccion"] == null)
            {
                listaTransaccion = new List<CtransaccionAlmacen>();
                listaTransaccion.Add(transaccionAlmacen);
            }
            else
            {
                listaTransaccion = (List<CtransaccionAlmacen>)Session["transaccion"];
                listaTransaccion.Add(transaccionAlmacen);
            }

            this.Session["transaccion"] = listaTransaccion;
            this.gvLista.DataSource = listaTransaccion;
            this.gvLista.DataBind();

            this.txtProducto.Focus();

            CargaProductos();
            TotalizaTransaccion();

            CcontrolesUsuario.LimpiarControles(
                this.upDetalle.Controls);
            CcontrolesUsuario.LimpiarCombos(
                this.upDetalle.Controls);

            //this.Session["editar"] = false;
        }
        catch (Exception ex)
        {
            CcontrolesUsuario.MensajeError(
                "Error al insertar el registro. Correspondiente a: " + ex.Message,
                this.nilblInformacion);
        }
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void nibtnCargar_Click(object sender, ImageClickEventArgs e)
    {
        this.nilblInformacion.Text = "";
        string requi = "";
        bool verifica = false;
        try
        {
            foreach (GridViewRow registro in this.nigvTrnReferencia.Rows)
            {
                if (((CheckBox)registro.FindControl("chbRequi")).Checked == true)
                {
                    verifica = true;
                }
            }

            if (verifica == false)
            {
                this.nilblInformacion.Text = "Debe seleccionar minimo una requisición";
                this.gvReferencia.DataSource = null;
                this.gvReferencia.DataBind();
                return;
            }

            foreach (GridViewRow registro in this.nigvTrnReferencia.Rows)
            {
                if (((CheckBox)registro.FindControl("chbRequi")).Checked == true)
                {
                    requi = registro.Cells[1].Text + "," + requi;
                }
            }

            this.gvReferencia.DataSource = tipoTransaccion.ExecReferenciaDetalle(
                Convert.ToString(TipoTransaccionConfig(8)),
                requi.Substring(0, requi.Length - 1), Convert.ToInt16(Session["empresa"]));
            this.gvReferencia.DataBind();



            foreach (GridViewRow registro in this.gvReferencia.Rows)
            {
                ((TextBox)registro.FindControl("txtCantidad")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(9));
                ((TextBox)registro.FindControl("txtValorUnitario")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(10));
                ((TextBox)registro.FindControl("txtPiva")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(11));
                ((TextBox)registro.FindControl("txtPDes")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(20));
            }


            TotalizaGrillaReferencia();


        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar detalle de Transacción. Correspondiente a: " + ex.Message, "C");
        }
    }
    protected void chbTotal_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.nigvTrnReferencia.Rows)
        {
            ((CheckBox)registro.Cells[0].FindControl("chbRequi")).Checked = ((CheckBox)sender).Checked;
        }
    }
    protected void txtCantidad_DataBinding(object sender, EventArgs e)
    {

    }
    protected void txtValorUnitario_DataBinding(object sender, EventArgs e)
    {

    }
    protected void txtPiva_DataBinding(object sender, EventArgs e)
    {

    }
    protected void txtPDes_DataBinding(object sender, EventArgs e)
    {

    }
    protected void niddlOperador_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void niimbAdicionar_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void nitxtValor1_TextChanged(object sender, EventArgs e)
    {

    }
    protected void gvParametros_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void imbBusqueda_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void gvTransaccion_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvTransaccion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

    }
}