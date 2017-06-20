using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Transactions;
using System.Configuration;
using System.Drawing;
using System.Globalization;

public partial class Produccion_ltransaccion_Transaccion : System.Web.UI.Page
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
    Cformulacion formulacion = new Cformulacion();


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
        this.tsHora.Visible = false;

        if (Convert.ToBoolean(this.Session["editar"]) == true)
        {
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
        this.lblCalcular.Visible = false;
        gvParametros.DataSource = null;
        gvParametros.DataBind();
    }


    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        this.Response.Redirect("~/Laboratorio/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        CcontrolesUsuario.InhabilitarControles(            this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(            this.upCabeza.Controls);
        InHabilitaEncabezado();
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.Session["transaccion"] = null;
        this.nilblInformacion.Text = mensaje;
        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
        this.lbRegistrar.Visible = false;
        lblHora.Visible = false;
        tsHora.Visible = false;
        this.lblCalcular.Visible = true;
    }

    private void ManejoEncabezado()
    {
        HabilitaEncabezado();
        CargarCombos();
        CargarTipoTransaccion();
        manejoEncabezadoT(true);
    }

    private void CargarTipoTransaccion()
    {
        try
        {
            this.ddlTipoDocumento.DataSource = tipoTransaccion.GetTipoTransaccionModuloFormulacion(Convert.ToInt16(Session["empresa"]));
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
            this.niddlCampo.DataSource = transacciones.GetCamposEntidades("lTransaccion", "");
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
            this.ddlFormulacion.DataSource = formulacion.formulacionTipoTransaccion(ddlTipoDocumento.SelectedValue.Trim(), Convert.ToInt16(this.Session["empresa"]));
            this.ddlFormulacion.DataValueField = "codigo";
            this.ddlFormulacion.DataTextField = "descripcion";
            this.ddlFormulacion.DataBind();
            this.ddlFormulacion.Items.Insert(0, new ListItem("", ""));
            this.ddlFormulacion.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
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
                Convert.ToString(this.ddlTipoDocumento.SelectedValue), (int)this.Session["empresa"]);
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

            string hora = tsHora.Hour.ToString();
            string minuto = tsHora.Minute.ToString();;

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                numerotransaccion = txtNumero.Text;
                this.Session["numerotransaccion"] = numerotransaccion;
            }
            else
            {
                numerotransaccion = transacciones.RetornaNumeroTransaccion(ddlTipoDocumento.SelectedValue, Convert.ToInt16(this.Session["empresa"]));
                this.Session["numerotransaccion"] = numerotransaccion;
            }

            using (TransactionScope ts = new TransactionScope())
            {
               // CultureInfo es = new CultureInfo("es-ES");

                //DateTime fecha = Convert.ToDateTime(txtFecha.Text, es);


                object[] objValores = new object[]{ 
                                                  Convert.ToDateTime( txtFecha.Text).Year,  //@año	int
                                                  false,  //@anulado	bit
                                                  Convert.ToInt16(this.Session["empresa"]),  //@empresa	int
                                                   Convert.ToDateTime( txtFecha.Text), //@fecha	date
                                                   null, //@fechaAnulado	datetime
                                                   DateTime.Now, //@fechaRegistro	datetime
                                                   hora, //@hora varchar
                                                    Convert.ToDateTime( txtFecha.Text).Month,  //@mes	int
                                                    minuto, //@minuto varchar
                                                    numerotransaccion, //@numero	varchar
                                                    txtObservacion.Text, //@Observacion	varchar
                                                    ddlFormulacion.Text, //@producto	int
                                                    ddlTipoDocumento.SelectedValue, //@tipo	varchar
                                                    this.Session["usuario"].ToString(), //@usuario	varchar
                                                    null//@usuarioAnulado	varchar
                                                    };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("lTransaccion", operacion, "ppa", objValores))
                {
                    case 0:
                        int x = 0;
                        int registro = 0;
                        foreach (GridViewRow cuerpo in this.gvLista.Rows)
                        {
                            if (x != 0)
                            {
                                CheckBox chekcBoxVacio = (CheckBox)cuerpo.FindControl("chkVacio");
                                foreach (DataListItem dli in ((DataList)cuerpo.FindControl("dtAnalisis")).Items)
                                {
                                    Label LabelAnalisis = ((Label)dli.FindControl("lblIdAnalisis"));
                                    TextBox TextBoxValor = ((TextBox)dli.FindControl("txvValorAnalisis"));

                                    object[] objValoresCuerpo = new object[]{
                                                          Convert.ToDateTime( txtFecha.Text).Year,   //@año	int
                                                          Convert.ToInt16(this.Session["empresa"]),  //@empresa	int
                                                          cuerpo.Cells[2].Text,  //@equipo	varchar
                                                          cuerpo.Cells[0].Text, //@grupo	varchar
                                                          Convert.ToDateTime( txtFecha.Text).Month, //@mes	int
                                                          LabelAnalisis.Text.Trim(),  //@movimiento	int
                                                          numerotransaccion,  //@numero	varchar
                                                          registro,  //@registro	int
                                                          ddlTipoDocumento.SelectedValue.Trim(),  //@tipo	varchar
                                                          chekcBoxVacio.Checked , //@vacio bit
                                                          Convert.ToDecimal(TextBoxValor.Text)  //@valor	float
                                                };

                                    switch (CentidadMetodos.EntidadInsertUpdateDelete("lTransaccionDetalle", operacion, "ppa", objValoresCuerpo))
                                    {
                                        case 1:
                                            verificacion = true;
                                            break;
                                    }
                                    registro++;
                                }
                                x++;
                            }
                            else
                            {
                                x++;
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
                {
                    transacciones.ActualizaConsecutivo(ddlTipoDocumento.SelectedValue, (int)this.Session["empresa"]);
                }
                ManejoExito("Transacción registrada satisfactoriamente número " + Session["numerotransaccion"].ToString(), "I");
                ts.Complete();
                this.gvLista.DataSource = null;
                this.gvLista.DataBind();
                this.lbRegistrar.Visible = false;
                this.lblCalcular.Visible = false;

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
                string where = operadores.FormatoWhere(
                    (List<Coperadores>)Session["operadores"]);

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
                (int)this.Session["empresa"],
                this.txtNumero.Text,
                 Convert.ToString(this.ddlTipoDocumento.SelectedValue)                 
                  };

            if (CentidadMetodos.EntidadGetKey(
                "lTransaccion",
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
            //if (this.txvValorAnalisis.Visible == true)
            //{
            //    if (CompruebaTransaccionExistente() == 1)
            //    {
            //        this.nilblInformacion.Text = "Transacción existente. Por favor corrija";

            //        return;
            //    }
            //    else
            //    {
            //        this.nilblInformacion.Text = "";
            //    }
            //}

            this.txtNumero.Enabled = false;

            CcontrolesUsuario.HabilitarControles(
                this.upCabeza.Controls);

            this.lblCalcular.Visible = false;
            this.nilbNuevo.Visible = false;
            //this.txvValorAnalisis.Visible = false;
            //this.txvValorAnalisis.Focus();
        }
    }

    #endregion Metodos

    #region Evento
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

                if (!IsPostBack)
                {
                    CargarCombos();
                    CargaCampos();

                    this.Session["transaccion"] = null;
                    this.Session["operadores"] = null;
                }
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


    #endregion Evento

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        InHabilitaEncabezado();

        CcontrolesUsuario.InhabilitarControles(
            this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upCabeza.Controls);


        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.niCalendarFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
        this.lbRegistrar.Visible = false;
        this.lbCancelar.Visible = false;
        this.lblCalcular.Visible = false;
        upCabeza.Visible = false;
        manejoEncabezadoT(true);


    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Calcular();
        nilblInformacion.Text = "Datos calculados...";
        Guardar();
    }


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void niimbRegistro_Click(object sender, ImageClickEventArgs e)
    {
        manejoConsulta();
        TabRegistro();
    }
    protected void niimbConsulta_Click(object sender, ImageClickEventArgs e)
    {
        TabRegistro();
        manejoConsulta();

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
        this.gvParametros.DataSource = null;
        this.gvParametros.DataBind();

        this.lblCalcular.Visible = false;
    }

    private void ComportamientoTransaccion()
    {
        upCabeza.Visible = true;
        CcontrolesUsuario.ComportamientoCampoEntidad(this.upCabeza.Controls, "lTransaccion", Convert.ToString(this.ddlTipoDocumento.SelectedValue), (int)this.Session["empresa"]);
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
            lblHora.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al comprobar transacción con referencia. Correspondiente a: " + ex.Message, "C");
        }

    }
    protected void txtNumero_TextChanged(object sender, EventArgs e)
    {

    }
    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = true;
        //this.txvValorAnalisis.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        CultureInfo es = new CultureInfo("es-ES");
        txtFecha.Text = niCalendarFecha.SelectedDate.ToShortDateString();
        //txtFecha.Text = fecha.ToString("dd/MM/yyyy hh:mm:ss tt");
        //this.txtFecha.Enabled = true;

        //verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
        //       Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), (int)this.Session["empresa"]);

    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {

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
        {
            this.txtValor2.Visible = true;
        }
        else
        {
            this.txtValor2.Visible = false;
            this.txtValor1.Text = "";
        }

        this.txtValor1.Focus();
    }
    protected void niimbAdicionar_Click(object sender, ImageClickEventArgs e)
    {
        foreach (GridViewRow registro in this.gvParametros.Rows)
        {
            if (Convert.ToString(this.niddlCampo.SelectedValue) == registro.Cells[1].Text &&
                Convert.ToString(this.niddlOperador.SelectedValue) == Server.HtmlDecode(registro.Cells[2].Text) &&
                this.txtValor1.Text == registro.Cells[3].Text)
            {
                return;
            }
        }

        operadores = new Coperadores(
            Convert.ToString(this.niddlCampo.SelectedValue),
            Server.HtmlDecode(Convert.ToString(this.niddlOperador.SelectedValue)),
            txtValor1.Text,
            txtValor2.Text);

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

                    switch (CentidadMetodos.EntidadInsertUpdateDelete("lTransaccionDetalle", "elimina", "ppa", objValores))
                    {
                        case 0:

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("lTransaccion", "elimina", "ppa", objValores))
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
        this.lblCalcular.Visible = true;
        string varObj = "";
        string hora = tsHora.Hour.ToString();
        string minuto = tsHora.Minute.ToString();

        try
        {
            gvLista.DataSource = null;
            gvLista.DataBind();

       //     CultureInfo es = new CultureInfo("es-ES");

         //   DateTime fecha = Convert.ToDateTime(txtFecha.Text, es);

            if (transacciones.VerificaRegistroFormulacion(Convert.ToInt16(this.Session["empresa"]), ddlTipoDocumento.SelectedValue.Trim(), Convert.ToDateTime(txtFecha.Text), ddlFormulacion.SelectedValue.Trim(), hora, minuto) == 1)
            {
                gvLista.DataSource = null;
                gvLista.DataBind();
                this.gvLista.Visible = false;
                nilblInformacion.Visible = true;
                ManejoError("Hay un registro con la fecha y el producto seleccionado, tiene que anular el registro anterior para continuar.", "I");
            }
            else
            {

                this.gvLista.DataSource = tipoTransaccion.SeleccionaFormulacion(Convert.ToInt16(Session["empresa"]), ddlTipoDocumento.SelectedValue.Trim(), ddlFormulacion.SelectedValue.Trim());
                this.gvLista.DataBind();

                DataView formulacioD = tipoTransaccion.SeleccionaFormulacionDetalle(Convert.ToInt16(Session["empresa"]), ddlTipoDocumento.SelectedValue.Trim(), ConfigurationManager.AppSettings["modulo"].ToString(), ddlFormulacion.SelectedValue.Trim());

                foreach (GridViewRow registro in gvLista.Rows)
                {
                    ((DataList)registro.FindControl("dtAnalisis")).DataSource = formulacioD;
                    ((DataList)registro.FindControl("dtAnalisis")).DataBind();
                }

                foreach (GridViewRow registro in gvLista.Rows)
                {


                    foreach (DataListItem dli in ((DataList)registro.FindControl("dtAnalisis")).Items)
                    {
                        foreach (DataRowView drv in formulacioD)
                        {

                            if (registro.RowIndex > 0)
                            {
                                ((Label)dli.FindControl("lblIdAnalisis")).Visible = false;
                                ((Label)dli.FindControl("lblAnalisis")).Visible = false;

                            }
                            else
                            {
                                ((Label)dli.FindControl("lblIdAnalisis")).Visible = false;
                                ((Label)dli.FindControl("lblAnalisis")).Visible = true;
                                ((TextBox)dli.FindControl("txvValorAnalisis")).Visible = false;
                                ((CheckBox)registro.FindControl("chkVacio")).Visible = false;

                                for (int y = 0; y < 6; y++)
                                {
                                    registro.Cells[y].BackColor = Color.White;
                                    registro.Cells[y].BorderColor = Color.White;
                                    registro.Cells[y].BorderStyle = BorderStyle.None;

                                }
                            }
                            if (drv.Row.ItemArray.GetValue(0).ToString().Trim() == ((Label)dli.FindControl("lblIdAnalisis")).Text)
                            {
                                ((TextBox)dli.FindControl("txvValorAnalisis")).Enabled = !Convert.ToBoolean(drv.Row.ItemArray.GetValue(2).ToString().Trim());
                            }

                        }
                    }
                }
            }



        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los movimientos. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void Calcular()
    {
        this.nilblInformacion.Text = "";
        this.lbRegistrar.Visible = false;
        upCabeza.Update();
        string varObj = "";

        if (this.txtFecha.Text.Length != 0)
        {
            string hora = tsHora.Hour.ToString();
            string minuto = tsHora.Minute.ToString();

            try
            {
                //gvLista.DataSource = null;
                //gvLista.DataBind();

               // CultureInfo es = new CultureInfo("es-ES");

//                DateTime fecha = Convert.ToDateTime(txtFecha.Text, es);

                if (transacciones.VerificaRegistroFormulacion(Convert.ToInt16(this.Session["empresa"]), ddlTipoDocumento.SelectedValue.Trim(), Convert.ToDateTime(txtFecha.Text), ddlFormulacion.SelectedValue.Trim(), hora, minuto) == 1 & Convert.ToBoolean(this.Session["editar"]) == false)
                {
                    gvLista.DataSource = null;
                    gvLista.DataBind();
                    this.gvLista.Visible = false;
                    nilblInformacion.Visible = true;
                    ManejoError("Hay un registro con la fecha y el producto seleccionado, tiene que anular el registro anterior para continuar.", "I");
                }
                else
                {
                    this.gvLista.Visible = true;

                    int x = 0;
                    foreach (GridViewRow gvr in gvLista.Rows)
                    {
                        if (x > 0)
                        {
                            if (((CheckBox)gvr.FindControl("chkVacio")).Checked == false)
                            {
                                foreach (DataRowView registro in transacciones.GetMovimientoResultadoFormulacion(ddlFormulacion.SelectedValue, Convert.ToInt16(Session["empresa"]), ConfigurationManager.AppSettings["Modulo"].ToString()))
                                {
                                    varObj = "";


                                    foreach (DataListItem dli in ((DataList)gvr.FindControl("dtAnalisis")).Items)
                                    {
                                        TextBox valorAnalisis = new TextBox();
                                        Label analisis = new Label();
                                        analisis = ((Label)dli.FindControl("lblIdAnalisis"));
                                        valorAnalisis = ((TextBox)dli.FindControl("txvValorAnalisis"));

                                        varObj = varObj + "|" + analisis.Text + "(" + valorAnalisis.Text + ")|";
                                    }

                                    foreach (DataRowView resultado in transacciones.EjecutaFormulaLaboratario(gvr.Cells[0].Text.Trim(), gvr.Cells[2].Text.Trim(), ddlFormulacion.SelectedValue, Convert.ToString(registro.Row.ItemArray.GetValue(0)), varObj, "R", Convert.ToDateTime(txtFecha.Text), Convert.ToInt16(Session["empresa"])))
                                    {
                                        foreach (DataListItem dli in ((DataList)gvr.FindControl("dtAnalisis")).Items)
                                        {
                                            if (((Label)dli.FindControl("lblIdAnalisis")).Text == resultado.Row.ItemArray.GetValue(2).ToString())
                                            {
                                                ((TextBox)dli.FindControl("txvValorAnalisis")).Text = Convert.ToString(resultado.Row.ItemArray.GetValue(0));
                                            }
                                        }

                                    }

                                }
                            }
                            x++;
                        }
                        else
                        {
                            x++;
                        }
                    }


                    lblCalcular.Visible = true;
                    lbRegistrar.Visible = true;

                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al calcular. Correspondiente a: " + ex.Message, "C");
            }
        }
        else
        {
            nilblInformacion.Text = "Por favor ingrese una fecha valida";
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
        try
        {

            //if (periodo.RetornaPeriodoCerrado(Convert.ToInt16(gvTransaccion.Rows[e.RowIndex].Cells[4].Text), Convert.ToInt16(gvTransaccion.Rows[e.RowIndex].Cells[5].Text), Convert.ToInt16(Session["empresa"])) == 1)
            //{
            //    ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
            //    return;
            //}
            CargarTipoTransaccion();
            upRegistro.Visible = true;
            CcontrolesUsuario.HabilitarControles(
                this.upRegistro.Controls);

            this.ddlTipoDocumento.SelectedValue = this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text;
            this.ddlTipoDocumento.Enabled = false;

            this.txtNumero.Enabled = false;
            this.nilbNuevo.Visible = false;
            this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(
                this.ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));

            CcontrolesUsuario.LimpiarControles(
                   this.upCabeza.Controls);
            CargarCombos();
            ComportamientoTransaccion();


            object[] objCab = new object[]{
                Convert.ToInt16(Session["empresa"]),
                this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text,
                this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text};

            foreach (DataRowView encabezado in CentidadMetodos.EntidadGetKey(
                "lTransaccion",
                "ppa",
                objCab).Tables[0].DefaultView)
            {
                this.niCalendarFecha.SelectedDate = Convert.ToDateTime(encabezado.Row.ItemArray.GetValue(5));
                this.niCalendarFecha.Visible = false;
            }


            this.nilblInformacion.Text = "";
            this.txtNumero.Text = this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text;
            this.ddlFormulacion.SelectedValue = this.gvTransaccion.Rows[e.RowIndex].Cells[7].Text;

            if (this.gvTransaccion.Rows[e.RowIndex].Cells[9].Text != "")
            {
                if (this.gvTransaccion.Rows[e.RowIndex].Cells[9].Text != "&nbsp;")
                {
                    this.txtObservacion.Text = this.gvTransaccion.Rows[e.RowIndex].Cells[9].Text;
                }
            }

            this.txtFecha.Text = Convert.ToDateTime(this.gvTransaccion.Rows[e.RowIndex].Cells[6].Text).ToString();

     
            this.niCalendarFecha.SelectedDate = Convert.ToDateTime(txtFecha.Text);
            
            int hora = 0;
            int minuto = 0;
            bool pm = false;

            if (this.gvTransaccion.Rows[e.RowIndex].Cells[11].Text != "")
            {
                if (this.gvTransaccion.Rows[e.RowIndex].Cells[11].Text != "&nbsp;")
                {
                    hora = Convert.ToInt32(this.gvTransaccion.Rows[e.RowIndex].Cells[11].Text);
                }
            }

            if (this.gvTransaccion.Rows[e.RowIndex].Cells[12].Text != "")
            {
                if (this.gvTransaccion.Rows[e.RowIndex].Cells[12].Text != "&nbsp;")
                {
                    minuto = Convert.ToInt32(this.gvTransaccion.Rows[e.RowIndex].Cells[12].Text);
                }
            }


            
            this.tsHora.Hour = hora;
            this.tsHora.Minute = minuto;
            this.gvLista.Visible = true;
           

            DataView grilla = tipoTransaccion.SeleccionalTransaccionDetalleG(Convert.ToInt16(Session["empresa"]),
                this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text, this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text);

            this.gvLista.DataSource = grilla;
            this.gvLista.DataBind();

            manejoEncabezadoT(false);

            DataView formulacionDetalle = new DataView();

            DataView formulacioD = tipoTransaccion.SeleccionaFormulacionDetalle(Convert.ToInt16(Session["empresa"]), ddlTipoDocumento.SelectedValue.Trim(), ConfigurationManager.AppSettings["modulo"].ToString(), ddlFormulacion.SelectedValue.Trim());

            foreach (GridViewRow registro in gvLista.Rows)
            {

                ((CheckBox)registro.FindControl("chkVacio")).Checked = Convert.ToBoolean(grilla[registro.RowIndex].Row.ItemArray.GetValue(4));
                ((DataList)registro.FindControl("dtAnalisis")).DataSource = formulacioD;
                ((DataList)registro.FindControl("dtAnalisis")).DataBind();
            }

            foreach (GridViewRow gvr in gvLista.Rows)
            {
                if (gvr.RowIndex > 0)
                {
                    formulacionDetalle = tipoTransaccion.SeleccionalTransaccionDetalleD(Convert.ToInt16(Session["empresa"]),
                          this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text, this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text, gvr.Cells[2].Text, gvr.Cells[0].Text);

                    ((DataList)gvr.FindControl("dtAnalisis")).DataSource = formulacionDetalle;
                    ((DataList)gvr.FindControl("dtAnalisis")).DataBind();

                    foreach (DataRowView drv in
                        formulacionDetalle)
                    {
                        foreach (DataListItem dli in ((DataList)gvr.FindControl("dtAnalisis")).Items)
                        {

                            if (gvr.RowIndex > 0)
                            {
                                ((Label)dli.FindControl("lblIdAnalisis")).Visible = false;
                                ((Label)dli.FindControl("lblAnalisis")).Visible = false;

                            }
                            else
                            {
                                ((Label)dli.FindControl("lblIdAnalisis")).Visible = false;
                                ((Label)dli.FindControl("lblAnalisis")).Visible = true;
                                ((TextBox)dli.FindControl("txvValorAnalisis")).Visible = false;
                                ((CheckBox)gvr.FindControl("chkVacio")).Visible = false;

                                for (int y = 0; y < 6; y++)
                                {
                                    gvr.Cells[y].BackColor = Color.White;
                                    gvr.Cells[y].BorderColor = Color.White;
                                    gvr.Cells[y].BorderStyle = BorderStyle.None;

                                }
                            }
                            if (drv.Row.ItemArray.GetValue(0).ToString().Trim() == ((Label)dli.FindControl("lblIdAnalisis")).Text)
                            {
                                ((TextBox)dli.FindControl("txvValorAnalisis")).Enabled = !Convert.ToBoolean(drv.Row.ItemArray.GetValue(4).ToString().Trim());
                            }
                        }
                    }
                }
                else
                {
                    foreach (DataListItem dli in ((DataList)gvr.FindControl("dtAnalisis")).Items)
                    {
                        ((Label)dli.FindControl("lblIdAnalisis")).Visible = false;
                        ((Label)dli.FindControl("lblAnalisis")).Visible = true;
                        ((TextBox)dli.FindControl("txvValorAnalisis")).Visible = false;
                        ((CheckBox)gvr.FindControl("chkVacio")).Visible = false;

                        for (int y = 0; y < 6; y++)
                        {
                            gvr.Cells[y].BackColor = Color.White;
                            gvr.Cells[y].BorderColor = Color.White;
                            gvr.Cells[y].BorderStyle = BorderStyle.None;

                        }
                    }
                }

            }

            manejoVacio();
            TabRegistro();
            lblCalcular.Visible = true;
            lbRegistrar.Visible = false;
            niimbConsulta.Enabled = true;
            niimbRegistro.Enabled = false;
            this.tsHora.Visible = true;

        }
        catch (Exception ex)
        {
            ManejoError("Error al verificar periodo. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void manejoEncabezadoT(bool manejo)
    {
        this.ddlFormulacion.Enabled = manejo;
        this.txtFecha.Enabled = manejo;
        this.lbFecha.Enabled = manejo;
        this.ddlTipoDocumento.Enabled = manejo;
        tsHora.Visible = manejo;
    }

    protected void niddlCampo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.txtValor1.Text.Length > 0 && Convert.ToString(this.niddlCampo.SelectedValue).Length > 0)
        {
            this.niimbAdicionar.Enabled = true;
            this.imbBusqueda.Enabled = true;
        }
        else
        {
            this.niimbAdicionar.Enabled = false;
            this.imbBusqueda.Enabled = false;
        }

        this.niimbAdicionar.Focus();
    }
    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            nilblInformacion.Text = "";
            Convert.ToDateTime(txtFecha.Text).ToString();
        }
        catch
        {

            nilblInformacion.Text = "Formato de fecha no valido..";
            txtFecha.Text = "";
            txtFecha.Focus();
            ScriptManager1.SetFocus(txtFecha);
            return;
        }

        //verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
        //      Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), (int)this.Session["empresa"]);

    }
    protected void ddlFormulacion_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {
            if (ddlFormulacion.SelectedValue.Trim().Length > 0)
                CargarGrid();
            else
                nilblInformacion.Text = "Debe seleccionar una formulacion valida";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los datos de formulación debido a:     " + ex.Message, "C");
        }
    }
    protected void chkVacio_CheckedChanged(object sender, EventArgs e)
    {

        manejoVacio();

    }

    private void manejoVacio()
    {
        try
        {


            foreach (GridViewRow gvr in gvLista.Rows)
            {
                CheckBox vacio = ((CheckBox)gvr.FindControl("chkVacio"));

                if (vacio.Checked == true)
                {
                    foreach (DataListItem dli in ((DataList)gvr.FindControl("dtAnalisis")).Items)
                    {
                        ((TextBox)dli.FindControl("txvValorAnalisis")).Enabled = false;
                        ((TextBox)dli.FindControl("txvValorAnalisis")).Text = "0";
                        gvr.Cells[4].Enabled = false;
                    }
                }
                else
                {
                    if (gvr.Cells[4].Enabled == false)
                    {
                        foreach (DataListItem dli in ((DataList)gvr.FindControl("dtAnalisis")).Items)
                        {
                            ((TextBox)dli.FindControl("txvValorAnalisis")).Enabled = true;
                            ((TextBox)dli.FindControl("txvValorAnalisis")).Text = "0";
                            gvr.Cells[4].Enabled = true;

                            DataView formulacioD = tipoTransaccion.SeleccionaFormulacionDetalle(Convert.ToInt16(Session["empresa"]), ddlTipoDocumento.SelectedValue.Trim(), ConfigurationManager.AppSettings["modulo"].ToString(), ddlFormulacion.SelectedValue.Trim());

                            foreach (DataRowView drv in formulacioD)
                            {
                                if (drv.Row.ItemArray.GetValue(0).ToString().Trim() == ((Label)dli.FindControl("lblIdAnalisis")).Text)
                                {
                                    ((TextBox)dli.FindControl("txvValorAnalisis")).Enabled = !Convert.ToBoolean(drv.Row.ItemArray.GetValue(2).ToString().Trim());
                                }
                            }

                        }
                    }

                }
                gvr.Cells[5].Enabled = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los datos de formulación debido a:     " + ex.Message, "C");
        }
    }

}

