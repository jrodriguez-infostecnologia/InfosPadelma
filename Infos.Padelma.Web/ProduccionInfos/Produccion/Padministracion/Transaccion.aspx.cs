using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Transactions;
using System.Configuration;

public partial class Produccion_Ptransaccion_Transaccion : System.Web.UI.Page
{

    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();

    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Cperiodos periodo = new Cperiodos();
    Ctransacciones transacciones = new Ctransacciones();
    Coperadores operadores = new Coperadores();
    Ccaracteristica caracteristica = new Ccaracteristica();


    #endregion Instancias


    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void EstadoInicialGrillaTransacciones()
    {
        for (int i = 0; i < this.gvTransaccion.Columns.Count; i++)
        {
            this.gvTransaccion.Columns[i].Visible = true;
        }

        foreach (GridViewRow registro in this.gvTransaccion.Rows)
        {
            this.gvTransaccion.Rows[registro.RowIndex].Visible = true;
        }
    }

    private void verificaPeriodoCerrado(int año, int mes, int empresa)
    {
        if (periodo.RetornaPeriodoCerrado(año, mes, empresa) == 1)
        {
            ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
        }

    }

    private void TabRegistro()
    {
        this.upRegistro.Visible = true;
        this.upConsulta.Visible = false;

        if (Convert.ToBoolean(this.Session["editar"]) == true)
            this.upCabeza.Visible = true;

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
        this.lblCalcular.Visible = false;
    }


    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        this.Response.Redirect("~/Produccion/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        CcontrolesUsuario.InhabilitarControles(this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(this.upCabeza.Controls);
        InHabilitaEncabezado();
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.Session["transaccion"] = null;
        this.nilblInformacion.Text = mensaje;
        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
        this.lbRegistrar.Visible = false;

        this.lblCalcular.Visible = true;

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

    private void CargaCampos()
    {
        try
        {
            this.niddlCampo.DataSource = transacciones.GetCamposEntidades("pTransaccion", "");
            this.niddlCampo.DataValueField = "name";
            this.niddlCampo.DataTextField = "name";
            this.niddlCampo.DataBind();
            this.niddlCampo.Items.Insert(0, new ListItem("", ""));
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
            this.ddlProducto.DataSource = transacciones.GetProductoTransaccion(ddlTipoDocumento.SelectedValue, Convert.ToInt16(this.Session["empresa"]));
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

    private string ConsecutivoTransaccion()
    {
        string numero = "";

        try
        {
            numero = transacciones.RetornaNumeroTransaccion(
                Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el número de transacción. Correspondiente a: " + ex.Message, "C");
        }

        return numero;
    }

    private void Guardar()
    {
        bool verificacion = false;
        string numerotransaccion = "";
        string operacion = "inserta";
        try
        {

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                numerotransaccion = txtNumero.Text;
                this.Session["numerotransaccion"] = numerotransaccion;
            }
            else
            {
                numerotransaccion = transacciones.RetornaNumeroTransaccion(ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));
                this.Session["numerotransaccion"] = numerotransaccion;
            }

            using (TransactionScope ts = new TransactionScope())
            {



                object[] objValores = new object[]{ 
                                                    false,
                                                    Convert.ToDateTime(txtFecha.Text).Year,
                                                    Convert.ToInt16(Session["empresa"]),
                                                    Convert.ToDateTime(txtFecha.Text),
                                                    null,
                                                    DateTime.Now,
                                                    Convert.ToDateTime(txtFecha.Text).Month,
                                                    numerotransaccion,
                                                    txtObservacion.Text,
                                                    Convert.ToInt16(this.ddlProducto.SelectedValue),
                                                    ddlTipoDocumento.SelectedValue,
                                                    this.Session["usuario"].ToString(),
                                                    null
                                                    };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("pTransaccion", operacion, "ppa", objValores))
                {
                    case 0:
                        foreach (GridViewRow cuerpo in this.gvLista.Rows)
                        {
                            object[] objValoresCuerpo = new object[]{
                                                        Convert.ToInt16(Convert.ToDateTime(txtFecha.Text).Year),
                                                     Convert.ToInt16(Session["empresa"]),
                                                    Convert.ToInt16(Convert.ToDateTime(txtFecha.Text).Month),
                                                     Server.HtmlDecode(cuerpo.Cells[1].Text),
                                                    numerotransaccion,
                                                    Convert.ToInt16(cuerpo.Cells[0].Text),
                                                    ddlTipoDocumento.SelectedValue,
                                                    Convert.ToDecimal(((TextBox)cuerpo.FindControl("txtCantidad")).Text)
                                                };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("pTransaccionDetalle", operacion, "ppa", objValoresCuerpo))
                            {
                                case 1:
                                    verificacion = true;
                                    break;
                            }
                        }
                        break;
                    case 1:
                        verificacion = true;
                        break;
                }


                if (verificacion == true)
                {
                    ManejoError("Error al insertar el detalle de la transacción. Operación no realizada", "I");
                    return;
                }

                if (Convert.ToBoolean(this.Session["editar"]) != true)
                    transacciones.ActualizaConsecutivo(ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));
                ManejoExito("Transacción registrada satisfactoriamente número " + Session["numerotransaccion"].ToString(), "I");
                ts.Complete();
                this.gvLista.DataSource = null;
                this.gvLista.DataBind();
                this.lbRegistrar.Visible = false;
                this.lblCalcular.Visible = false;

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                    manejoConsulta();
                else
                    TabRegistro();
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al calcular: " + ex.Message, "I");
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

        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.Session["transaccion"] = null;
        this.lblCalcular.Visible = false;


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

    private void BusquedaTransaccion()
    {
        try
        {
            if (this.gvParametros.Rows.Count > 0)
            {
                string where = operadores.FormatoWhere((List<Coperadores>)Session["operadores"]);
                this.gvTransaccion.DataSource = transacciones.GetTransaccionCompleta(where, Convert.ToInt16(Session["empresa"]));
                this.gvTransaccion.DataBind();
                this.nilblRegistros.Text = "Nro. Registros " + Convert.ToString(this.gvTransaccion.Rows.Count);
                EstadoInicialGrillaTransacciones();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al procesar la consulta de transacciones. Correspondiente a: " + ex.Message, "C");
        }
    }

    private int CompruebaTransaccionExistente()
    {
        try
        {
            object[] objkey = new object[]{ 
                Convert.ToInt16(Session["empresa"]),
                this.txtNumero.Text,
                 Convert.ToString(this.ddlTipoDocumento.SelectedValue)                 
                  };

            if (CentidadMetodos.EntidadGetKey("pTransaccion", "ppa", objkey).Tables[0].DefaultView.Count > 0)
                return 1;
            else
                return 0;
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
                    this.nilblInformacion.Text = "";
            }

            this.txtNumero.Enabled = false;

            CcontrolesUsuario.HabilitarControles(this.upCabeza.Controls);
            this.lblCalcular.Visible = false;
            this.nilbNuevo.Visible = false;
            this.txtFecha.Visible = false;
            this.txtFecha.Focus();
        }
    }

    #endregion Metodos

    #region Evento
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
                    CargarCombos();
                    CargaCampos();
                    this.Session["transaccion"] = null;
                    this.Session["operadores"] = null;
                }
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }

    }
    protected void nilbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        this.Session["editar"] = false;

        ManejoEncabezado();
    }

    private void cancelarTodo()
    {
        InHabilitaEncabezado();
        CcontrolesUsuario.InhabilitarControles(this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(this.upCabeza.Controls);
        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.niCalendarFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
        this.lbRegistrar.Visible = false;
        this.lbCancelar.Visible = false;
        this.lblCalcular.Visible = false;
        upCabeza.Visible = false;
    }

    #endregion Evento


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        cancelarTodo();
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Calcular();
        nilblInformacion.Text = "Datos calculados...";
        try
        {

            if (periodo.RetornaPeriodoCerrado(Convert.ToDateTime(txtFecha.Text).Year, Convert.ToDateTime(txtFecha.Text).Month, Convert.ToInt16(Session["empresa"])) == 1)
            {
                ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
                return;
            }
            else
            {
                Guardar();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al verificar periodo. Correspondiente a: " + ex.Message, "C");
        }

    }

    protected void niimbRegistro_Click(object sender, ImageClickEventArgs e)
    {
        TabRegistro();
    }
    protected void niimbConsulta_Click(object sender, ImageClickEventArgs e)
    {
        manejoConsulta();
        cancelarTodo();
    }

    private void manejoConsulta()
    {
        this.upRegistro.Visible = false;
        this.upCabeza.Visible = false;
        this.upConsulta.Visible = true;

        this.niimbConsulta.BorderStyle = BorderStyle.None;
        this.niimbRegistro.BorderStyle = BorderStyle.Solid;
        this.niimbRegistro.BorderColor = System.Drawing.Color.White;
        this.niimbRegistro.BorderWidth = Unit.Pixel(1);
        this.niimbConsulta.Enabled = false;
        this.niimbRegistro.Enabled = true;

        this.Session["operadores"] = null;
        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        gvParametros.DataSource = null;
        gvParametros.DataBind();
        imbBusqueda.Visible = false;

        this.lblCalcular.Visible = false;
    }

    private void ComportamientoTransaccion()
    {
        upCabeza.Visible = true;
        CcontrolesUsuario.ComportamientoCampoEntidad(this.upCabeza.Controls, "pTransaccion", Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"]));

    }


    protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            CcontrolesUsuario.InhabilitarControles(this.upCabeza.Controls);
            CcontrolesUsuario.LimpiarControles(this.upCabeza.Controls);
            this.gvLista.DataSource = null;
            this.gvLista.DataBind();
            this.Session["transaccion"] = null;
            this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
            this.txtNumero.Text = ConsecutivoTransaccion();
            this.lblCalcular.Visible = false;

            this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(this.ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));
            CargarCombos();

            lbFecha.Enabled = true;
            ComportamientoConsecutivo();
            ComportamientoTransaccion();


        }
        catch (Exception ex)
        {
            ManejoError("Error al comprobar transacción con referencia. Correspondiente a: " + ex.Message, "C");
        }

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
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToShortDateString();
        verificaPeriodoCerrado(Convert.ToInt32(Convert.ToDateTime(txtFecha.Text).Year), Convert.ToInt32(Convert.ToDateTime(txtFecha.Text).Month), Convert.ToInt16(Session["empresa"]));
        CargarGrid();
    }

    protected void gvParametros_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        List<Coperadores> listaOperadores = null;
        try
        {
            listaOperadores = (List<Coperadores>)Session["operadores"];
            listaOperadores.RemoveAt(e.RowIndex);

            this.gvParametros.DataSource = listaOperadores;
            this.gvParametros.DataBind();
            this.gvTransaccion.DataSource = null;
            this.gvTransaccion.DataBind();
            this.nilblRegistros.Text = "Nro. registros 0";
            this.nilblMensajeEdicion.Text = "";

            if (this.gvParametros.Rows.Count == 0)
            {
                this.imbBusqueda.Visible = false;
            }

            EstadoInicialGrillaTransacciones();
        }
        catch
        {
        }

    }
    protected void niddlOperador_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.niddlOperador.SelectedValue.ToString() == "between")
            this.nitxtValor2.Visible = true;
        else
            this.nitxtValor2.Visible = false;


        this.nitxtValor1.Focus();
    }
    protected void niimbAdicionar_Click(object sender, ImageClickEventArgs e)
    {
        if (this.nitxtValor1.Text.Length == 0 && Convert.ToString(this.niddlCampo.SelectedValue).Length == 0)
        {
            nilblMensajeEdicion.Text = "Debe digitar y seleccionar minimo un filtro";
            return;
        }

        foreach (GridViewRow registro in this.gvParametros.Rows)
        {
            if (Convert.ToString(this.niddlCampo.SelectedValue) == registro.Cells[1].Text &&
                Convert.ToString(this.niddlOperador.SelectedValue) == Server.HtmlDecode(registro.Cells[2].Text) &&
                this.nitxtValor1.Text == registro.Cells[3].Text)
            {
                return;
            }
        }

        operadores = new Coperadores(Convert.ToString(this.niddlCampo.SelectedValue), Server.HtmlDecode(Convert.ToString(this.niddlOperador.SelectedValue)), this.nitxtValor1.Text, this.nitxtValor2.Text);
        List<Coperadores> listaOperadores = null;
        if (this.Session["operadores"] == null)
        {
            listaOperadores = new List<Coperadores>();
            listaOperadores.Add(operadores);
        }
        else
        {
            listaOperadores = (List<Coperadores>)Session["operadores"];
            listaOperadores.Add(operadores);
        }

        this.Session["operadores"] = listaOperadores;

        this.imbBusqueda.Visible = true;
        this.gvParametros.DataSource = listaOperadores;
        this.gvParametros.DataBind();
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.nilblRegistros.Text = "Nro. Registros 0";
        this.nilblMensajeEdicion.Text = "";
        EstadoInicialGrillaTransacciones();
        this.imbBusqueda.Visible = true;
        this.imbBusqueda.Enabled = true;
    }
    protected void nitxtValor1_TextChanged(object sender, EventArgs e)
    {
        this.niimbAdicionar.Focus();
    }
    protected void imbBusqueda_Click(object sender, ImageClickEventArgs e)
    {
        this.nilblMensajeEdicion.Text = "";

        BusquedaTransaccion();
    }
    protected void gvTransaccion_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.nilblMensajeEdicion.Text = "";

        using (TransactionScope ts = new TransactionScope())
        {
            try
            {
                bool anulado = false;

                foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[10].Controls)
                    anulado = ((CheckBox)objControl).Checked;

                if (anulado == true)
                {
                    this.nilblMensajeEdicion.Text = "Registro anulado no es posible su edición";
                    return;
                }

                if (tipoTransaccion.RetornaTipoBorrado(this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text, Convert.ToInt16(Session["empresa"])) == "E")
                {
                    object[] objValores = new object[]{
                         Convert.ToInt16(Session["empresa"]),
                        Convert.ToString(this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text).Trim(),
                        Convert.ToString(this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text).Trim()
                    };

                    switch (CentidadMetodos.EntidadInsertUpdateDelete("pTransaccionDetalle", "elimina", "ppa", objValores))
                    {
                        case 0:

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("pTransaccion", "elimina", "ppa", objValores))
                            {
                                case 0:
                                    this.nilblMensajeEdicion.Text = "Registro Eliminado Satisfactoriamente";
                                    BusquedaTransaccion();
                                    ts.Complete();
                                    break;

                                case 1:

                                    this.nilblMensajeEdicion.Text = "Error al eliminar el registro. Operación no realizada";
                                    break;
                            }
                            break;

                        case 1:

                            this.nilblMensajeEdicion.Text = "Error al eliminar el registro. Operación no realizada";
                            break;
                    }
                }
                else
                {
                    switch (transacciones.AnulaTransaccion(
                        this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text,
                        this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text,
                        this.Session["usuario"].ToString().Trim(),
                        Convert.ToInt16(Session["empresa"])
                        ))
                    {
                        case 0:

                            this.nilblMensajeEdicion.Text = "Registro Anulado Satisfactoriamente";
                            BusquedaTransaccion();
                            ts.Complete();
                            break;
                        case 1:
                            this.nilblMensajeEdicion.Text = "Error al anular la transacción. Operación no realizada";
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }


    protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarGrid();
    }


    private void CargarGrid()
    {
        this.nilblInformacion.Text = "";
        this.lbRegistrar.Visible = false;
        string varObj = "";

        if (this.txtFecha.Text.Length != 0 && this.ddlProducto.SelectedValue.Length != 0)
        {

            try
            {
                if (tipoTransaccion.ValidaRegistroProductoFecha(Convert.ToInt16(ddlProducto.SelectedValue), Convert.ToDateTime(txtFecha.Text), Convert.ToInt16(Session["empresa"])) == 1)
                {
                    gvLista.DataSource = null;
                    gvLista.DataBind();
                    this.gvLista.Visible = false;
                    nilblInformacion.Visible = true;
                    nilblInformacion.Text = "Hay un registro con la fecha y el producto seleccionado, tiene que anular el registro anterior para continuar.";
                }
                else
                {
                    this.nilblInformacion.Text = "";
                    this.gvLista.Visible = true;

                    this.gvLista.DataSource = tipoTransaccion.SeleccionaProductoMovimiento(Convert.ToInt16(ddlProducto.SelectedValue), Convert.ToInt16(Session["empresa"]), ConfigurationManager.AppSettings["Modulo"].ToString());
                    this.gvLista.DataBind();

                    foreach (GridViewRow fila in gvLista.Rows)
                    {
                        if (((CheckBox)fila.FindControl("chkResultado")).Checked == true)
                        {
                            ((TextBox)fila.FindControl("txtCantidad")).Enabled = false;
                        }
                    }

                    foreach (DataRowView registro in transacciones.GetMovimientoResultadoProductoMostrar(
                    Convert.ToInt16(ddlProducto.SelectedValue), Convert.ToInt16(Session["empresa"]), ConfigurationManager.AppSettings["Modulo"].ToString()))
                    {
                        varObj = "";

                        foreach (GridViewRow fila in gvLista.Rows)
                        {
                            if (((CheckBox)fila.FindControl("chkResultado")).Checked == false)
                                varObj = varObj + "|" + fila.Cells[1].Text + "(" + Convert.ToDecimal(((TextBox)fila.FindControl("txtCantidad")).Text) + ")|";
                        }

                        foreach (GridViewRow filaResultado in gvLista.Rows)
                        {
                            if (((CheckBox)filaResultado.FindControl("chkResultado")).Checked == true)
                                varObj = varObj + "|" + filaResultado.Cells[1].Text.Trim() + "(" + Convert.ToDecimal(((TextBox)filaResultado.FindControl("txtCantidad")).Text) + ")|";
                        }

                        foreach (DataRowView resultado in transacciones.EjecutaFormulaA(ddlProducto.SelectedValue, Convert.ToString(registro.Row.ItemArray.GetValue(0)), varObj, "R",
                            Convert.ToDateTime(txtFecha.Text), Convert.ToInt16(Session["empresa"])))
                        {
                            foreach (GridViewRow filaResultado in gvLista.Rows)
                            {

                                if (filaResultado.Cells[1].Text == resultado.Row.ItemArray.GetValue(2).ToString())
                                    ((TextBox)filaResultado.FindControl("txtCantidad")).Text = Convert.ToString(resultado.Row.ItemArray.GetValue(0));

                            }

                        }

                    }
                    lblCalcular.Visible = true;
                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar los movimientos. Correspondiente a: " + ex.Message, "C");
            }
        }
    }

    void Calcular()
    {
        this.nilblInformacion.Text = "";
        this.lbRegistrar.Visible = false;
        string varObj = "";
        if (this.txtFecha.Text.Length != 0 && this.ddlProducto.SelectedValue.Length != 0)
        {
            try
            {
                this.gvLista.Visible = true;
                foreach (DataRowView registro in transacciones.GetMovimientoResultadoProducto(Convert.ToInt16(ddlProducto.SelectedValue), Convert.ToInt16(Session["empresa"]), ConfigurationManager.AppSettings["Modulo"].ToString()))
                {
                    varObj = "";
                    foreach (GridViewRow fila in gvLista.Rows)
                    {
                        if (((CheckBox)fila.FindControl("chkResultado")).Checked == false)
                        {
                            varObj = varObj + "|" + fila.Cells[1].Text + "(" + Convert.ToDecimal(((TextBox)fila.FindControl("txtCantidad")).Text) + ")|";
                        }
                    }
                    foreach (GridViewRow filaResultado in gvLista.Rows)
                    {
                        if (((CheckBox)filaResultado.FindControl("chkResultado")).Checked == true)
                        {
                            varObj = varObj + "|" + filaResultado.Cells[1].Text.Trim() + "(" + Convert.ToDecimal(((TextBox)filaResultado.FindControl("txtCantidad")).Text) + ")|";
                        }
                    }
                    foreach (DataRowView resultado in transacciones.EjecutaFormulaA(ddlProducto.SelectedValue, Convert.ToString(registro.Row.ItemArray.GetValue(0)), varObj, "R", Convert.ToDateTime(txtFecha.Text), Convert.ToInt16(Session["empresa"])))
                    {
                        foreach (GridViewRow filaResultado in gvLista.Rows)
                        {
                            if (filaResultado.Cells[1].Text == resultado.Row.ItemArray.GetValue(2).ToString())
                            {
                                ((TextBox)filaResultado.FindControl("txtCantidad")).Text = Convert.ToString(resultado.Row.ItemArray.GetValue(0));
                            }
                        }
                    }
                }

                lblCalcular.Visible = true;
                lbRegistrar.Visible = true;

            }
            catch (Exception ex)
            {
                ManejoError("Error al calcular. Correspondiente a: " + ex.Message, "C");
            }
        }
    }
    protected void lbICalcular_Click(object sender, ImageClickEventArgs e)
    {
        Calcular();
    }

    protected void gvTransaccion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        this.nilblInformacion.Text = "";
        this.Session["editar"] = true;
        CargarTipoTransaccion();
        upRegistro.Visible = true;
        CcontrolesUsuario.HabilitarControles(this.upRegistro.Controls);

        this.ddlTipoDocumento.SelectedValue = this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text;
        this.ddlTipoDocumento.Enabled = false;
        this.txtNumero.Text = this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text;
        this.txtNumero.Enabled = false;
        this.nilbNuevo.Visible = false;
        this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(this.ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));

        CcontrolesUsuario.LimpiarControles(this.upCabeza.Controls);
        CargarCombos();
        ComportamientoTransaccion();


        object[] objCab = new object[]{
                Convert.ToInt16(Session["empresa"]),
                this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text,
                this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text};

        foreach (DataRowView encabezado in CentidadMetodos.EntidadGetKey("pTransaccion", "ppa", objCab).Tables[0].DefaultView)
        {
            this.niCalendarFecha.SelectedDate = Convert.ToDateTime(encabezado.Row.ItemArray.GetValue(5));
            this.niCalendarFecha.Visible = false;
            this.txtFecha.Visible = true;
            this.txtFecha.Text = Convert.ToString(encabezado.Row.ItemArray.GetValue(5));
            this.txtObservacion.Text = Convert.ToString(encabezado.Row.ItemArray.GetValue(12));
            this.ddlProducto.SelectedValue = Convert.ToString(encabezado.Row.ItemArray.GetValue(6));

            lbFecha.Enabled = false;
            ddlProducto.Enabled = false;

        }


        this.nilblInformacion.Text = "";
        this.gvLista.Visible = true;

        this.gvLista.DataSource = tipoTransaccion.SeleccionapTransaccionDetalle(Convert.ToInt16(Session["empresa"]),
            this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text, this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text);
        this.gvLista.DataBind();

        foreach (GridViewRow fila in gvLista.Rows)
        {
            if (((CheckBox)fila.FindControl("chkResultado")).Checked == true)
            {
                ((TextBox)fila.FindControl("txtCantidad")).Enabled = false;
            }
        }
        TabRegistro();
        lblCalcular.Visible = true;
        lbRegistrar.Visible = false;
        niimbConsulta.Enabled = true;
        niimbRegistro.Enabled = false;

    }


    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFecha.Text);
        }
        catch
        {

            nilblInformacion.Text = "formato de fecha no valido..";
            txtFecha.Text = "";
            txtFecha.Focus();
            ScriptManager1.SetFocus(txtFecha);
            return;
        }

        verificaPeriodoCerrado(Convert.ToInt32(Convert.ToDateTime(txtFecha.Text).Year),
              Convert.ToInt32(Convert.ToDateTime(txtFecha.Text).Month), Convert.ToInt16(Session["empresa"]));

        CargarGrid();

    }
}