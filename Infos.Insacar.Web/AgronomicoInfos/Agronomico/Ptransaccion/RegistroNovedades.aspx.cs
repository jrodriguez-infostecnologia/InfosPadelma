using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Threading;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;



public partial class Agronomico_Ptransaccion_RegistroNovedades : System.Web.UI.Page
{

    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Coperadores operadores = new Coperadores();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    CtransaccionNovedad transaccionNovedad = new CtransaccionNovedad();
    Cperiodos periodo = new Cperiodos();
    Cseccion seccion = new Cseccion();
    Clotes lotes = new Clotes();
    string numerotransaccion = "";
    Ctransacciones transacciones = new Ctransacciones();
    Cnovedad novedades = new Cnovedad();
    Cnovedad novedad = new Cnovedad();
    CpromedioPeso peso = new CpromedioPeso();
    Ccuadrillas cuadrillas = new Ccuadrillas();
    List<Ctercero> listaTerceros = new List<Ctercero>();
    cNovedadTransaccion novedadTransaccion = new cNovedadTransaccion();
    List<cNovedadTransaccion> listaNovedadesTransaccion = new List<cNovedadTransaccion>();
    Ctercero terceros;

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
    private void TabRegistro()
    {
        this.upRegistro.Visible = true;
        this.upConsulta.Visible = false;

        if (Convert.ToBoolean(this.Session["editar"]) == true)
        {
            this.upDetalle.Visible = true;
            this.upCabeza.Visible = true;
        }


        this.niimbConsulta.Enabled = true;
        this.niimbRegistro.Enabled = false;

        this.niimbRegistro.BorderStyle = BorderStyle.None;
        this.niimbConsulta.BorderStyle = BorderStyle.Solid;
        this.niimbConsulta.BorderColor = System.Drawing.Color.White;
        this.niimbConsulta.BorderWidth = Unit.Pixel(1);
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.nilblRegistros.Text = "Nro. Registros 0";
        this.nilblMensajeEdicion.Text = "";
        this.lbImprimir.Visible = false;
    }
    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        CcontrolesUsuarios.InhabilitarControles(this.upCabeza.Controls);
        CcontrolesUsuarios.LimpiarControles(this.upCabeza.Controls);

        CcontrolesUsuarios.InhabilitarControles(this.upDetalle.Controls);
        CcontrolesUsuarios.LimpiarControles(this.upDetalle.Controls);

        InHabilitaEncabezado();

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.Session["transaccion"] = null;
        this.nilblInformacion.Text = mensaje;
        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
        this.lbRegistrar.Visible = false;

        this.lbImprimir.Visible = true;

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
            this.ddlTipoDocumento.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
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
            this.niddlCampo.DataSource = transacciones.GetCamposEntidades("nNovedades", "");
            this.niddlCampo.DataValueField = "name";
            this.niddlCampo.DataTextField = "name";
            this.niddlCampo.DataBind();
            this.niddlCampo.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos para edición. Correspondiente a: " + ex.Message, "C");
        }

    }

    protected void cargarCombosDetalle()
    {
        cargarSesiones();
        cargarLotes();
        ddlLoteD.Enabled = true;
        ddlNovedad.Enabled = true;
    }
    protected void cargarLotes()
    {
        try
        {
            if (ddlSeccionD.Visible == true)
            {
                this.ddlLoteD.DataSource = lotes.LotesSeccionFinca(this.ddlSeccionD.SelectedValue.ToString().Trim(), Convert.ToInt16(this.Session["empresa"]), ddlFinca.SelectedValue.ToString().Trim());
                this.ddlLoteD.DataValueField = "codigo";
                this.ddlLoteD.DataTextField = "descripcion";
                this.ddlLoteD.DataBind();
                this.ddlLoteD.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
            }

            if (ddlSeccion.Visible == true)
            {
                this.ddlLote.DataSource = lotes.LotesSeccionFinca(this.ddlSeccion.SelectedValue.ToString().Trim(), Convert.ToInt16(this.Session["empresa"]), ddlFinca.SelectedValue.ToString().Trim());
                this.ddlLote.DataValueField = "codigo";
                this.ddlLote.DataTextField = "descripcion";
                this.ddlLote.DataBind();
                this.ddlLote.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar lotes. Correspondiente a: " + ex.Message, "C");
        }
    }
    protected void cargarSesiones()
    {

        if (ddlFinca.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar una finca";
            return;
        }
        try
        {
            if (ddlSeccionD.Visible == true)
            {
                ddlSeccionD.Enabled = true;
                lblSeccionD.Enabled = true;
                this.ddlSeccionD.DataSource = seccion.SeleccionaSesionesFinca(Convert.ToInt16(this.Session["empresa"]), ddlFinca.SelectedValue);
                this.ddlSeccionD.DataValueField = "codigo";
                this.ddlSeccionD.DataTextField = "descripcion";
                this.ddlSeccionD.DataBind();
                this.ddlSeccionD.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
            }

            if (ddlSeccion.Visible == true)
            {
                ddlSeccion.Enabled = true;
                lblSeccion.Enabled = true;
                this.ddlSeccion.DataSource = seccion.SeleccionaSesionesFinca(Convert.ToInt16(this.Session["empresa"]), ddlFinca.SelectedValue);
                this.ddlSeccion.DataValueField = "codigo";
                this.ddlSeccion.DataTextField = "descripcion";
                this.ddlSeccion.DataBind();
                this.ddlSeccion.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar secciones. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void CargarCombos()
    {
        try
        {
            this.ddlNovedad.DataSource = tipoTransaccion.SeleccionaNovedadTipoDocumentos(ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));
            this.ddlNovedad.DataValueField = "codigo";
            this.ddlNovedad.DataTextField = "descripcion";
            this.ddlNovedad.DataBind();
            this.ddlNovedad.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar Novedades. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView fincas = CcontrolesUsuarios.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
               "aFinca", "ppa"), "descripcion", (int)this.Session["empresa"]);

            fincas.RowFilter = "interna=1 and empresa=" + ((int)this.Session["empresa"]).ToString();


            this.ddlFinca.DataSource = fincas;
            this.ddlFinca.DataValueField = "codigo";
            this.ddlFinca.DataTextField = "descripcion";
            this.ddlFinca.DataBind();
            this.ddlFinca.Items.Insert(0, new ListItem("Seleccione una opción...", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar Fincas. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView dvUmedida = CcontrolesUsuarios.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "gUnidadMedida", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvUmedida.RowFilter = "empresa=" + ((int)this.Session["empresa"]).ToString();
            this.ddlUmedida.DataSource = dvUmedida;

            this.ddlUmedida.DataValueField = "codigo";
            this.ddlUmedida.DataTextField = "descripcion";
            this.ddlUmedida.DataBind();
            this.ddlUmedida.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidades de medida. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlTercero.DataSource = transacciones.SelccionaTercernoNovedad((int)this.Session["empresa"]);
            this.ddlTercero.DataValueField = "id";
            this.ddlTercero.DataTextField = "cadena";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar terceros. Correspondiente a: " + ex.Message, "C");
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
        this.lbImprimir.Visible = false;


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
            object[] objkey = new object[]{(int)this.Session["empresa"],this.txtNumero.Text,Convert.ToString(this.ddlTipoDocumento.SelectedValue)                 
                  };

            if (CentidadMetodos.EntidadGetKey("aTransaccion", "ppa", objkey).Tables[0].DefaultView.Count > 0)
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
                {
                    this.nilblInformacion.Text = "";
                }
            }

            this.txtNumero.Enabled = false;

            CcontrolesUsuarios.HabilitarControles(
                this.upCabeza.Controls);

            this.lbImprimir.Visible = false;
            this.nilbNuevo.Visible = false;
            this.txtFecha.Visible = false;
            this.txtFecha.Focus();
        }
    }
    private void verificaPeriodoCerrado(int año, int mes, int empresa, DateTime fecha)
    {
        if (periodo.RetornaPeriodoCerradoNomina(año, mes, empresa, fecha) == 1)
        {
            ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
        }

    }

    private void Editar()
    {
        //bool verificacion = false;

        //foreach (GridViewRow registro in this.gvLista.Rows)
        //{
        //    if (((CheckBox)registro.FindControl("chkAnulado")).Checked == false)
        //    {
        //        verificacion = true;
        //    }
        //}

        //if (verificacion == false)
        //{
        //    this.nilblInformacion.Text = "La transacción debe contener por lo menos un registro válido para editar";
        //    return;
        //}

        //try
        //{
        //    using (TransactionScope ts = new TransactionScope())
        //    {

        //        DateTime fecha = Convert.ToDateTime(txtFecha.Text);

        //        string conceptos = null, empleado = null, ccosto = null;
        //        string remision = null;


        //        if (txtRemision.Visible == true)
        //        {
        //            remision = txtRemision.Text;
        //        }
        //        if (ddlLabor.Visible == true)
        //        {
        //            conceptos = ddlLabor.SelectedValue;
        //        }
        //        if (ddlTercero.Visible == true)
        //        {
        //            empleado = ddlTercero.SelectedValue;
        //        }

        //        if (ddlCentroCosto.Visible == true)
        //        {
        //            ccosto = ddlCentroCosto.SelectedValue;
        //        }


        //        switch (transacciones.EditaEncabezado(this.ddlTipoDocumento.SelectedValue.Trim(), this.txtNumero.Text.Trim(), fecha, empleado, conceptos, ccosto, remision,
        //            Server.HtmlDecode(this.txtObservacion.Text.Trim()), Convert.ToInt16(Session["empresa"])))
        //        {
        //            case 0:

        //                foreach (GridViewRow gv in this.gvLista.Rows)
        //                {
        //                    switch (transacciones.EditaDetalle(ddlTipoDocumento.SelectedValue.Trim(),//@tipo
        //                                         this.txtNumero.Text.Trim(),   //@numero	varchar
        //                                         Convert.ToInt16(gv.Cells[13].Text),//@registro
        //                                       Convert.ToDecimal(gv.Cells[6].Text), //@cantidad
        //                                       Convert.ToDecimal(gv.Cells[7].Text), //@valor
        //                                       gv.Cells[2].Text,    //@concepto
        //                                       gv.Cells[4].Text,    //@empleado
        //                                       gv.Cells[12].Text,    //@detalle
        //                                        Convert.ToInt16(gv.Cells[11].Text),  //frecuencia
        //                                        Convert.ToInt16(gv.Cells[9].Text),    //@periodoInicial
        //                                        Convert.ToInt16(gv.Cells[10].Text), //@periodoFinal
        //                                       Convert.ToInt16(gv.Cells[8].Text),  //@año
        //                                        Convert.ToInt16(this.Session["empresa"]),   //@empresa	int
        //                                        ((CheckBox)gv.FindControl("chkAnulado")).Checked))
        //                    {
        //                        case 1:

        //                            verificacion = false;
        //                            break;
        //                    }
        //                }

        //                if (verificacion == false)
        //                {
        //                    this.nilblInformacion.Text = "Error al editar el registro. Operación no realizada";
        //                }
        //                else
        //                {
        //                    ManejoExito("Transacción editada satisfactoriamente. Transacción número " + this.txtNumero.Text.Trim(), "A");
        //                    ts.Complete();
        //                }
        //                break;

        //            case 1:

        //                this.nilblInformacion.Text = "Error al editar el encabezado. Operación no realizada";
        //                break;
        //        }
        //    }
        //}
        //catch (Exception ex)
        //{
        //    ManejoError("Error al editar la transacción. Correspondiente a: " + ex.Message, "A");
        //}
    }


    protected void Guardar()
    {
        string operacion = "inserta";
        bool interno = false;
        bool verificaEncabezado = false;
        bool verificaDetalle = false;
        bool verificaBascula = false;
        upDetalle.Update();

        try
        {
            using (TransactionScope ts = new TransactionScope())
            {
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                }

                DateTime fecha = Convert.ToDateTime(txtFecha.Text);
                DateTime fechaF = Convert.ToDateTime(txtFecha.Text);
                string referencia = null;
                string remision = null;
                numerotransaccion = transacciones.RetornaNumeroTransaccion(ddlTipoDocumento.SelectedValue, (int)this.Session["empresa"]);
                this.Session["numerotransaccion"] = numerotransaccion;

                object[] objValo = new object[]{     
                                                       false, // @anulado	bit
                                                      Convert.ToUInt32(fecha.Year), //@año	int
                                                     decimal.Round(Convert.ToDecimal(txvCantidad.Text)),  //@cantidad	int
                                                     Convert.ToInt16(this.Session["empresa"]),   //@empresa	int
                                                     fecha,   //@fecha	date
                                                     fecha,  //@fechaAnulado	datetime
                                                     fechaF,  //@fechaFinal	date
                                                     DateTime.Now,   //@fechaRegistro	datetime
                                                     ddlFinca.SelectedValue.Trim(),   //@finca	char
                                                     decimal.Round(Convert.ToDecimal(txvJornal.Text),0),   //@jornal	int
                                                     Convert.ToUInt32(fecha.Month),  //@mes	int
                                                     numerotransaccion,   //@numero	varchar
                                                     txtObservacion.Text,   //@observacion	varchar
                                                     0,   //@precio	money
                                                     0,   //@racimos	int
                                                     referencia,   //@referencia	varchar
                                                     remision,   //@remision	varchar
                                                     ddlTipoDocumento.SelectedValue.Trim(),   //@tipo	varchar
                                                     null,   //@usuarioAnulado	varchar
                                                     this.Session["usuario"].ToString(),   //@usuarioRegistro	varchar
                                                     0   //@valorTotal	money
                              };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("aTransaccion", operacion, "ppa", objValo))
                {
                    case 0:
                        foreach (GridViewRow dl in gvLista.Rows)
                        {
                            DateTime fechaDetalle = new DateTime();
                            decimal cantidad = 0;
                            decimal jornales = 0;
                            decimal racimos = 0, pesoRacimo = 0;
                            string lote = null, novedad = null, seccion = null, umedida = null, tercero = null;
                            GridView gvTerceros = new GridView();

                            fechaDetalle = Convert.ToDateTime(dl.Cells[9].Text);
                            cantidad = Convert.ToDecimal(dl.Cells[10].Text);
                            jornales = Convert.ToDecimal(dl.Cells[11].Text);
                            lote = dl.Cells[8].Text;
                            pesoRacimo = 0;
                            novedad = dl.Cells[2].Text;
                            racimos = 0;
                            seccion = dl.Cells[7].Text;
                            umedida = dl.Cells[6].Text;
                            tercero = dl.Cells[4].Text;
                            if (lote.Trim().Length == 0)
                                lote = null;


                            object[] objValores1 = new object[]{
                                    Convert.ToInt16( fechaDetalle.Year.ToString()),   //@año
                                    cantidad, //@cantidad
                                    false,   //@ejecutado
                                    (int)this.Session["empresa"],     //@empresa
                                    fechaDetalle,    //@fecha
                                    jornales,  //@jornales
                                    lote,    //@lote
                                    Convert.ToInt16( fechaDetalle.Month.ToString()) ,  //@mes
                                    novedad,    //@novedad
                                    txtNumero.Text,    //@numero
                                    pesoRacimo, //@pesoRacimo
                                    racimos,    //@racimos
                                    dl.RowIndex,   //@registro
                                    cantidad,    //@saldo
                                    seccion,   //@seccion
                                    ddlTipoDocumento.SelectedValue.Trim(),    //@tipo
                                    umedida //@uMedida
                                 };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                "aTransaccionNovedad",
                                operacion,
                                "ppa",
                                objValores1))
                            {
                                case 0:
                                    object[] objValores2 = new object[]{
                                              Convert.ToInt16( fechaDetalle.Year.ToString()),  //@año
                                               cantidad, //@cantidad
                                               false, //@ejecutado
                                               (int)this.Session["empresa"], //@empresa
                                                jornales, //@jornales
                                                lote,//@lote
                                                Convert.ToInt16( fechaDetalle.Month.ToString()),//@mes
                                                novedad,//@novedad
                                                txtNumero.Text, //@numero
                                                dl.RowIndex,//@registro
                                                dl.RowIndex,//@registroNovedad
                                                cantidad,//@saldo
                                                seccion,//@seccion
                                                tercero,//@tercero
                                                ddlTipoDocumento.SelectedValue.Trim(),//@tipo
                                                null//@cuadrilla
                                         };

                                    switch (CentidadMetodos.EntidadInsertUpdateDelete("aTransaccionTercero", operacion, "ppa", objValores2))
                                    {
                                        case 1:
                                            ManejoError("Error al insertar el detalle de la transacción", "I");
                                            verificaDetalle = true;
                                            break;
                                    }

                                    break;
                                case 1:
                                    ManejoError("Error al insertar el encabezado de la transaccción", "I");
                                    break;
                            }
                        }
                        break;

                    case 1:
                        ManejoError("Error al insertar el detalle de la transaccción", "I");
                        break;
                }

                if (verificaEncabezado == false & verificaDetalle == false & verificaBascula == false)
                {
                    transacciones.ActualizaConsecutivo(ddlTipoDocumento.Text, (int)this.Session["empresa"]);
                    ts.Complete();
                    ManejoExito("Datos registrados satisfactoriamente", "I");
                }

            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
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
            if (!IsPostBack)
            {
                if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                        nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
                {
                    ManejoError("Usuario no autorizado para ejecutar esta operación", "I");
                    return;
                }
                CargarCombos();
                CargaCampos();
                this.Session["transaccion"] = null;
                this.Session["operadores"] = null;
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

        CcontrolesUsuarios.InhabilitarControles(this.upCabeza.Controls);
        CcontrolesUsuarios.LimpiarControles(this.upCabeza.Controls);

        CcontrolesUsuarios.InhabilitarControles(this.upDetalle.Controls);
        CcontrolesUsuarios.LimpiarControles(this.upDetalle.Controls);

        this.Session["editar"] = false;

        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.niCalendarFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
        this.lbRegistrar.Visible = false;

        this.lbCancelar.Visible = false;
        this.lbImprimir.Visible = false;
        upCabeza.Visible = false;
        upDetalle.Visible = false;

    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        if (gvLista.Rows.Count <= 0)
        {
            nilblInformacion.Text = "El detalle de la transacción debe tener por lo menos un registro";
            return;
        }

        bool validar = false;

        if (upCabeza.Visible == true)
        {
            if (txtFecha.Enabled == true)
            {
                if (txtFecha.Text.Trim().Length == 0)
                {
                    validar = true;
                }
            }

            if (ddlTercero.Visible == true)
            {
                if (ddlTercero.SelectedValue.Trim().Length == 0)
                {
                    validar = true;
                }
            }
            if (ddlNovedad.Visible == true)
            {
                if (ddlNovedad.SelectedValue.Trim().Length == 0)
                {
                    validar = true;
                }
            }

            if (ddlUmedida.Visible == true)
            {
                if (ddlUmedida.SelectedValue.Trim().Length == 0)
                {
                    validar = true;
                }
            }
        }

        if (Convert.ToBoolean(Session["editar"]) == false)
        {
            Guardar();
        }
        else
        {
            Editar();
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

        this.upConsulta.Visible = true;

        this.niimbConsulta.BorderStyle = BorderStyle.None;
        this.niimbRegistro.BorderStyle = BorderStyle.Solid;
        this.niimbRegistro.BorderColor = System.Drawing.Color.White;
        this.niimbRegistro.BorderWidth = Unit.Pixel(1);
        this.niimbConsulta.Enabled = false;
        this.niimbRegistro.Enabled = true;

        this.niimbAdicionar.Enabled = true;
        this.imbBusqueda.Enabled = true;

        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        CargaCampos();

        this.lbImprimir.Visible = false;

    }
    private void ComportamientoTransaccion()
    {
        upCabeza.Visible = true;
        upDetalle.Visible = true;

        CcontrolesUsuarios.ComportamientoCampoEntidad(this.upCabeza.Controls,
               "aTransaccion", Convert.ToString(this.ddlTipoDocumento.SelectedValue), (int)this.Session["empresa"]);
        CcontrolesUsuarios.ComportamientoCampoEntidad(this.upDetalle.Controls,
              "aTransaccionDetalle", Convert.ToString(this.ddlTipoDocumento.SelectedValue), (int)this.Session["empresa"]);
        this.imbCargar.Visible = true;

    }
    protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {

            CcontrolesUsuarios.InhabilitarControles(this.upCabeza.Controls);
            CcontrolesUsuarios.LimpiarControles(this.upCabeza.Controls);

            CcontrolesUsuarios.InhabilitarControles(this.upDetalle.Controls);
            CcontrolesUsuarios.LimpiarControles(this.upDetalle.Controls);

            this.gvLista.DataSource = null;
            this.gvLista.DataBind();

            this.Session["transaccion"] = null;

            this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
            this.txtNumero.Text = ConsecutivoTransaccion();
            this.lbImprimir.Visible = false;

            this.hdTransaccionConfig.Value = CcontrolesUsuarios.TipoTransaccionConfig(this.ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));


            ComportamientoConsecutivo();
            ComportamientoTransaccion();


            //this.UpdatePanelDetalle.Visible = true;



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

        CcontrolesUsuarios.HabilitarControles(this.upCabeza.Controls);

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
        //  this.txtFecha.Enabled = false;

        verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
             Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), (int)this.Session["empresa"], niCalendarFecha.SelectedDate);

    }
    protected void btnRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        try
        {

            nilblInformacion.Visible = true;
            nilblInformacion.Text = "";
            nilblInformacion.ForeColor = Color.Red;


            if (ddlTercero.SelectedValue.ToString().Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un tercero valido";
                return;
            }

            if (Convert.ToBoolean(NovedadConfig(12)) == true)
            {
                if (ddlLoteD.SelectedValue.Length == 0)
                {
                    nilblInformacion.Text = "Debe seleccionar un lote antes de continuar";
                    return;
                }
            }

            if (txvCantidadD.Enabled)
            {
                if (Convert.ToDecimal(txvCantidadD.Text.Trim()) == 0)
                {
                    nilblInformacion.Text = "La cantidad debe ser diferente de cero";
                    return;
                }
            }
            if (txtFechaD.Enabled)
            {
                if (txtFechaD.Text.Length == 0)
                {
                    nilblInformacion.Text = "debe ingresar una fecha para continuar";
                    return;

                }
            }

            decimal cantidadTotal = 0, subCantidad = 0;
            decimal jornalTotal = 0, subJornal = 0;
            decimal cantidad = 0;
            cantidadTotal = Convert.ToDecimal(txvCantidad.Text);
            jornalTotal = Convert.ToDecimal(txvJornal.Text);

            foreach (GridViewRow gv in gvLista.Rows)
            {
                if (ddlNovedad.SelectedValue.Trim() == gv.Cells[2].Text.Trim())
                {
                    subCantidad = Convert.ToDecimal(gv.Cells[10].Text);
                    subJornal = Convert.ToDecimal(gv.Cells[11].Text);
                }
            }


            cantidad = Convert.ToDecimal(txvCantidadD.Text);

            if (subJornal + Convert.ToDecimal(txvJornalesD.Text) > jornalTotal & Convert.ToDecimal(txvJornal.Text.Trim()) > 0 & txvJornalesD.Enabled == true)
            {
                this.nilblInformacion.Text = "Los jornales no pueden ser mayor al total de jornales";
                return;
            }
            if (subCantidad + Convert.ToDecimal(txvCantidadD.Text) > cantidadTotal & Convert.ToDecimal(txvCantidad.Text.Trim()) > 0 & txvCantidadD.Enabled == true)
            {
                this.nilblInformacion.Text = "La cantidad no pueden ser mayor a la cantidad total";
                return;
            }

            if (novedad.ManejaCanalNovedad(ddlNovedad.SelectedValue.Trim(), (int)this.Session["empresa"]) == true)
            {
                decimal cantidadcanal = novedad.SeleccionaMetrajeTipoCanalNovedad(ddlNovedad.SelectedValue.Trim(), ddlLoteD.SelectedValue.Trim(), (int)this.Session["empresa"]);
                if (Convert.ToDecimal(txvCantidadD.Text) > cantidadcanal)
                {
                    txvCantidadD.Text = cantidadcanal.ToString();
                    nilblInformacion.Text = "La cantidad para esta novedad no esta permitido debe elegir una cantidad menor";
                    return;
                }
            }

            if (this.gvLista.Rows.Count >= 20)
            {
                this.nilblInformacion.Text = "El número de artículos no puede ser mayor a 20";
                return;
            }


            if (this.Session["transaccion"] != null)
            {
                foreach (CtransaccionNovedad registro in (List<CtransaccionNovedad>)Session["transaccion"])
                {
                    if (ddlTercero.Visible == true)
                    {
                        if (Convert.ToString(this.ddlTercero.SelectedValue) == registro.Empleado && ddlLoteD.SelectedValue.ToString() == registro.Lote && ddlNovedad.SelectedValue.ToString() == registro.NombreLabor)
                        {
                            this.nilblInformacion.Text = "El concepto seleccionado ya se encuentra registrado. Por favor corrija";
                            this.gvLista.DataSource = (List<CtransaccionNovedad>)Session["transaccion"];
                            this.gvLista.DataBind();
                            return;
                        }
                    }

                }
            }

            if (Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim().Length == 0 ||
                this.txtNumero.Text.Trim().Length == 0)
            {
                CcontrolesUsuarios.MensajeError("Debe ingresar tipo y número de transacción", this.nilblInformacion);
                return;
            }

            if (CcontrolesUsuarios.VerificaCamposRequeridos(this.upDetalle.Controls) == false)
            {
                CcontrolesUsuarios.MensajeError("Campos vacios. Por favor corrija", this.nilblInformacion);
                return;
            }

            cantidad = 0;
            decimal jornal = 0;
            string lote = null, seccion = null;
            DateTime fecha;
            bool validaJornal;

            if (txvCantidadD.Visible == true)
                cantidad = Convert.ToDecimal(txvCantidadD.Text);
            else
                cantidad = Convert.ToDecimal(txvCantidadD.Text) / gvLista.Rows.Count;

            if (txvJornalesD.Visible == true)
                jornal = Convert.ToDecimal(txvJornalesD.Text);
            else
                jornal = Convert.ToDecimal(txvJornal.Text) / gvLista.Rows.Count;

            if (ddlLoteD.Visible == true)
                lote = ddlLoteD.SelectedValue;
            else
            {
                if (ddlLote.Visible == true)
                    lote = ddlLote.SelectedValue;
            }

            if (ddlSeccionD.Visible == true)
                seccion = ddlSeccionD.SelectedValue;
            else
            {
                if (ddlSeccion.Visible == true)
                    seccion = ddlSeccion.SelectedValue;
            }

            if (txtFechaD.Visible == true)
                fecha = Convert.ToDateTime(txtFechaD.Text);
            else
                fecha = Convert.ToDateTime(txtFecha.Text);

            if (chkValidaJornal.Visible == true)
                validaJornal = chkValidaJornal.Checked;
            else
                validaJornal = false;

            transaccionNovedad = new CtransaccionNovedad(ddlTercero.SelectedValue, ddlNovedad.SelectedValue, ddlNovedad.SelectedItem.ToString(), ddlTercero.SelectedItem.ToString(), cantidad, ddlUmedida.SelectedValue,
                lote, fecha, jornal, seccion, Convert.ToInt16(this.hdRegistro.Value), false, validaJornal);

            List<CtransaccionNovedad> listaTransaccion = null;

            if (this.Session["transaccion"] == null)
            {
                listaTransaccion = new List<CtransaccionNovedad>();
                listaTransaccion.Add(transaccionNovedad);
            }
            else
            {
                listaTransaccion = (List<CtransaccionNovedad>)Session["transaccion"];
                listaTransaccion.Add(transaccionNovedad);
            }

            this.Session["transaccion"] = listaTransaccion;
            this.gvLista.DataSource = listaTransaccion;
            this.gvLista.DataBind();

            CcontrolesUsuarios.LimpiarControles(this.upDetalle.Controls);
            CcontrolesUsuarios.LimpiarCombos(this.upDetalle.Controls);
            this.Session["editarRegistro"] = null;
            ddlNovedad.Enabled = true;
            ddlUmedida.Enabled = true;
            txvJornalesD.Enabled = true;
            ScriptManager1.SetFocus(ddlTercero);

        }
        catch (Exception ex)
        {
            CcontrolesUsuarios.MensajeError("Error al insertar el registro. Correspondiente a: " + ex.Message, this.nilblInformacion);
        }

    }
    private decimal ObtenerPesoPromedio(string lote, DateTime fecha)
    {
        //int año, mes;
        //if (fecha.Month == 1)
        //{
        //    año = Convert.ToInt16(fecha.Year) - 1;
        //    mes = 12;
        //}
        //else
        //{
        //    año = Convert.ToInt16(fecha.Year);
        //    mes = Convert.ToInt16(fecha.Month) - 1;
        //}

        try
        {
            decimal retorno = Convert.ToDecimal(peso.valorPesoPeriodo(Convert.ToInt16(Session["empresa"]), fecha, lote, ddlFinca.SelectedValue));
            return retorno;
        }
        catch (Exception ex)
        {
            return 0;
        }

    }



    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        this.nilblInformacion.Text = "";

        if (Convert.ToBoolean(Session["editar"]) == false)
        {
            try
            {
                List<CtransaccionNovedad> listaTransaccion = null;
                listaTransaccion = (List<CtransaccionNovedad>)Session["transaccion"];
                listaTransaccion.RemoveAt(e.RowIndex);

                this.gvLista.DataSource = listaTransaccion;
                this.gvLista.DataBind();

                if (gvLista.Rows.Count == 0)
                {
                    ddlNovedad.Enabled = true;
                    ddlUmedida.Enabled = true;
                }
            }
            catch (Exception ex)
            {
                this.nilblInformacion.Text = "Error al eliminar el registro. Correspondiente a: " + ex.Message;
            }
        }
        else
        {
            ((CheckBox)this.gvLista.Rows[e.RowIndex].FindControl("chkAnulado")).Checked = true;
            this.gvLista.Rows[e.RowIndex].BackColor = System.Drawing.Color.Red;
        }

    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            this.nilblInformacion.Text = "";

            this.hdCantidad.Value = this.gvLista.SelectedRow.Cells[6].Text;
            this.hdRegistro.Value = this.gvLista.SelectedRow.Cells[13].Text;


            cargarCombosDetalle();


            if (this.ddlNovedad.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                    this.ddlNovedad.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;
            }
            if (this.ddlTercero.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                    this.ddlTercero.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;
            }
            if (this.ddlUmedida.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                    this.ddlUmedida.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text;

            }

            if (this.ddlSeccionD.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                    this.ddlSeccionD.SelectedValue = this.gvLista.SelectedRow.Cells[6].Text;
            }
            if (this.ddlLoteD.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                    this.ddlLoteD.SelectedValue = this.gvLista.SelectedRow.Cells[7].Text;
            }

            if (this.txtFechaD.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                {
                    this.txtFechaD.Text = this.gvLista.SelectedRow.Cells[7].Text;
                    this.cldFechaD.SelectedDate = Convert.ToDateTime(this.gvLista.SelectedRow.Cells[8].Text);
                }
            }


            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
            {
                txvCantidadD.Text = this.gvLista.SelectedRow.Cells[10].Text;
                this.Session["cant"] = Convert.ToDecimal(this.gvLista.SelectedRow.Cells[10].Text);
            }
            else
                txvCantidadD.Text = "0";

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                txvCantidadD.Text = this.gvLista.SelectedRow.Cells[11].Text;
            else
                txvCantidadD.Text = "0";


            List<CtransaccionNovedad> listaTransaccion = null;

            listaTransaccion = (List<CtransaccionNovedad>)this.Session["transaccion"];
            listaTransaccion.RemoveAt(this.gvLista.SelectedRow.RowIndex);

            this.gvLista.DataSource = listaTransaccion;
            this.gvLista.DataBind();

        }
        catch (Exception ex)
        {
            CcontrolesUsuarios.MensajeError("Error al cargar los campos del registro en el formulario. Correspondiente a: " + ex.Message, this.nilblInformacion);
        }
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
            this.nitxtValor2.Visible = true;
        }
        else
        {
            this.nitxtValor2.Visible = false;
            this.nitxtValor1.Text = "";
        }

        this.nitxtValor1.Focus();
    }
    protected void niimbAdicionar_Click(object sender, ImageClickEventArgs e)
    {
        foreach (GridViewRow registro in this.gvParametros.Rows)
        {
            if (Convert.ToString(this.niddlCampo.SelectedValue) == registro.Cells[1].Text &&
                Convert.ToString(this.niddlOperador.SelectedValue) == Server.HtmlDecode(registro.Cells[2].Text) &&
                this.nitxtValor1.Text == registro.Cells[3].Text)
            {
                return;
            }
        }

        operadores = new Coperadores(
            Convert.ToString(this.niddlCampo.SelectedValue),
            Server.HtmlDecode(Convert.ToString(this.niddlOperador.SelectedValue)),
            this.nitxtValor1.Text,
            this.nitxtValor2.Text);

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
    protected void nitxtValor1_TextChanged(object sender, EventArgs e)
    {
        if (this.nitxtValor1.Text.Length > 0 && Convert.ToString(this.niddlCampo.SelectedValue).Length > 0)
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

                foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[7].Controls)
                {
                    anulado = ((CheckBox)objControl).Checked;
                }

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

                    switch (CentidadMetodos.EntidadInsertUpdateDelete("nNovedadesDetalle", "elimina", "ppa", objValores))
                    {
                        case 0:
                            switch (CentidadMetodos.EntidadInsertUpdateDelete("nNovedades", "elimina", "ppa", objValores))
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
                    switch (transacciones.AnulaTransaccion(this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text,
                        this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text, this.Session["usuario"].ToString().Trim(), Convert.ToInt16(Session["empresa"])))
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
    protected void gvTransaccion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        //decimal cantidad = 0;
        //string empleado, concepto, nombreEmpleado, nombreConcepto;
        //this.nilblMensajeEdicion.Text = "";
        //this.nilblInformacion.Text = "";
        //this.Session["editar"] = true;
        //this.Session["periodo"] = this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text;
        //this.Session["transaccion"] = null;


        //try
        //{
        //    this.hdTransaccionConfig.Value = CcontrolesUsuarios.TipoTransaccionConfig(this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text, Convert.ToInt16(Session["empresa"]));

        //    if (transacciones.VerificaEdicionBorrado(this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text, this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text, Convert.ToInt16(Session["empresa"])) != 0)
        //    {
        //        this.nilblMensajeEdicion.Text = "Transacción ejecutada no es posible su edición";
        //        return;
        //    }

        //    CargarTipoTransaccion();
        //    cargarCombosDetalle();
        //    CargarCombos();

        //    upCabeza.Visible = true;

        //    CcontrolesUsuarios.HabilitarControles(this.upCabeza.Controls);
        //    CcontrolesUsuarios.HabilitarControles(this.upRegistro.Controls);

        //    this.ddlTipoDocumento.SelectedValue = this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text;
        //    this.ddlTipoDocumento.Enabled = false;
        //    this.txtNumero.Text = this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text;
        //    this.txtNumero.Enabled = false;
        //    this.nilbNuevo.Visible = false;
        //    this.hdTransaccionConfig.Value = CcontrolesUsuarios.TipoTransaccionConfig(this.ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));

        //    CcontrolesUsuarios.LimpiarControles(this.upCabeza.Controls);
        //    CcontrolesUsuarios.ComportamientoCampoEntidad(this.upCabeza.Controls, "nNovedades", Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"]));
        //    CcontrolesUsuarios.LimpiarControles(this.upDetalle.Controls);
        //    CcontrolesUsuarios.ComportamientoCampoEntidad(this.upDetalle.Controls, "nNovedadesDetalle", Convert.ToString(this.ddlTipoDocumento.SelectedValue), Convert.ToInt16(Session["empresa"]));

        //    object[] objCab = new object[] { Convert.ToInt16(Session["empresa"]), this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text, this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text };

        //    foreach (DataRowView encabezado in CentidadMetodos.EntidadGetKey("nNovedades", "ppa", objCab).Tables[0].DefaultView)
        //    {
        //        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(encabezado.Row.ItemArray.GetValue(3));
        //        this.niCalendarFecha.Visible = false;
        //        this.txtFecha.Visible = true;
        //        this.txtFecha.Text = Convert.ToString(encabezado.Row.ItemArray.GetValue(3));
        //        ddlCentroCosto.SelectedValue = Convert.ToString(encabezado.Row.ItemArray.GetValue(5));

        //        this.txtObservacion.Text = Convert.ToString(encabezado.Row.ItemArray.GetValue(8));

        //        if (this.ddlTercero.Visible == true)
        //        {
        //            this.ddlTercero.SelectedValue = Convert.ToString(encabezado.Row.ItemArray.GetValue(6));
        //        }


        //        this.ddlLabor.SelectedValue = Convert.ToString(encabezado.Row.ItemArray.GetValue(7));

        //    }

        //    foreach (DataRowView detalle in transacciones.SeleccionanNovedadesDetalle(
        //        this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text, this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text, Convert.ToInt16(Session["empresa"])))
        //    {

        //        cantidad = Convert.ToDecimal(detalle.Row.ItemArray.GetValue(6));

        //        if (detalle.Row.ItemArray.GetValue(5) == null)
        //        {
        //            empleado = null;
        //            nombreEmpleado = null;
        //        }
        //        else
        //        {
        //            empleado = Convert.ToString(detalle.Row.ItemArray.GetValue(5));
        //            nombreEmpleado = Convert.ToString(detalle.Row.ItemArray.GetValue(17));
        //        }

        //        if (detalle.Row.ItemArray.GetValue(4) == null)
        //        {
        //            concepto = null;
        //            nombreConcepto = null;
        //        }
        //        else
        //        {
        //            concepto = Convert.ToString(detalle.Row.ItemArray.GetValue(4));
        //            nombreConcepto = Convert.ToString(detalle.Row.ItemArray.GetValue(18));
        //        }


        //        transaccionNovedad = new CtransaccionNovedad(empleado, concepto, nombreConcepto, nombreEmpleado, cantidad, Convert.ToInt16(detalle.Row.ItemArray.GetValue(8)),
        //            Convert.ToInt16(detalle.Row.ItemArray.GetValue(9)), Convert.ToInt16(detalle.Row.ItemArray.GetValue(10)), Convert.ToInt16(detalle.Row.ItemArray.GetValue(11)),
        //            Convert.ToDecimal(detalle.Row.ItemArray.GetValue(7)), Convert.ToString(detalle.Row.ItemArray.GetValue(12)), Convert.ToInt16(detalle.Row.ItemArray.GetValue(3)), false);

        //        List<CtransaccionNovedad> listaTransaccion = null;

        //        if (this.Session["transaccion"] == null)
        //        {
        //            listaTransaccion = new List<CtransaccionNovedad>();
        //            listaTransaccion.Add(transaccionNovedad);
        //        }
        //        else
        //        {
        //            listaTransaccion = (List<CtransaccionNovedad>)Session["transaccion"];
        //            listaTransaccion.Add(transaccionNovedad);
        //        }

        //        this.Session["transaccion"] = listaTransaccion;

        //        this.gvLista.DataSource = listaTransaccion;
        //        this.gvLista.DataBind();
        //        this.imbCargar.Visible = true;

        //    }

        //    TabRegistro();

        //}
        //catch (Exception ex)
        //{
        //    ManejoError("Error al cargar la transacción. Correspondiente a: " + ex.Message, "A");
        //}

    }

    protected void lbImprimir_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void lbFechaD_Click(object sender, EventArgs e)
    {
        this.cldFechaD.Visible = true;
        this.txtFechaD.Visible = false;
        this.cldFechaD.SelectedDate = Convert.ToDateTime(null);
    }
    protected void cldFechaD_SelectionChanged(object sender, EventArgs e)
    {
        this.cldFechaD.Visible = false;
        this.txtFechaD.Visible = true;
        this.txtFechaD.Text = this.cldFechaD.SelectedDate.ToString();
        ScriptManager1.SetFocus(txtFechaD);
    }

    #endregion Evento


    private object NovedadConfig(int posicion)
    {

        object retorno = null;
        string cadena;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            cadena = novedades.NovedadConfig(ddlNovedad.SelectedValue, Convert.ToInt16(Session["empresa"])).ToString();
            retorno = cadena.Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar posición de configuración del lote. Correspondiente a: " + ex.Message, "C");
            return null;
        }
    }
    private void ConfiguracionNovedad(string novedad)
    {
        try
        {
            ddlLoteD.Visible = Convert.ToBoolean(NovedadConfig(12));
            lblLoteD.Visible = Convert.ToBoolean(NovedadConfig(12));
            ddlSeccionD.Visible = Convert.ToBoolean(NovedadConfig(12));
            lblSeccionD.Visible = Convert.ToBoolean(NovedadConfig(12));
            lbFechaD.Enabled = true;

            if (Convert.ToBoolean(NovedadConfig(12)) == false)
            {
                ddlLoteD.DataSource = null;
                ddlLoteD.DataBind();
                ddlLoteD.SelectedIndex = -1;
                ddlSeccionD.DataSource = null;
                ddlSeccionD.DataBind();
                ddlSeccionD.SelectedIndex = -1;
            }

            ddlUmedida.SelectedValue = NovedadConfig(4).ToString().Trim();
            this.Session["manejalote"] = Convert.ToBoolean(NovedadConfig(12));
            txvCantidadD.Enabled = !Convert.ToBoolean(NovedadConfig(18));
            txvCantidadD.Enabled = !Convert.ToBoolean(NovedadConfig(18));
            txvJornalesD.Enabled = Convert.ToBoolean(NovedadConfig(19));
            lblJornal.Enabled = !Convert.ToBoolean(NovedadConfig(19));
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar el configuración de la novedad. Correspondiente a: " + ex.Message, "C");
        }
    }
    protected void ddlNovedad_SelectedIndexChanged(object sender, EventArgs e)
    {
        CcontrolesUsuarios.LimpiarControles(upDetalle.Controls);
        CcontrolesUsuarios.HabilitarControles(upDetalle.Controls);
        ConfiguracionNovedad(ddlNovedad.SelectedValue.ToString().Trim());
        nilblInformacion.Text = "";
        ScriptManager1.SetFocus(ddlNovedad);
    }
    protected void ddlFinca_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (txtFecha.Text.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar una fecha para continuar";
            return;
        }
        cargarCombosDetalle();
        ScriptManager1.SetFocus(ddlFinca);

    }

    protected void ddlSeccion_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarLotes();
        ScriptManager1.SetFocus(ddlSeccionD);
    }
    protected void ddlLote_SelectedIndexChanged(object sender, EventArgs e)
    {
        int desde = 0, hasta = 0, añoSiembra = 0, difAño = 0;

        if (Convert.ToBoolean(NovedadConfig(25)) == true)
        {
            desde = Convert.ToInt16(NovedadConfig(26));
            hasta = Convert.ToInt16(NovedadConfig(27));

            añoSiembra = Convert.ToInt16(LoteConfig(5, ddlLoteD.SelectedValue));

            difAño = Convert.ToInt16(cldFechaD.SelectedDate.Year) - añoSiembra;

            if (difAño > (hasta - desde))
            {
                nilblInformacion.Text = "El lote seleccionado esta fuera del rango de siembra de la novedad, por favor corrija ";
                imbCargar.Enabled = false;
                return;
            }
            else
            {
                imbCargar.Enabled = true;
                nilblInformacion.Text = "";

            }
        }
    }

    private object LoteConfig(int posicion, string lote)
    {
        object retorno = null;
        string cadena;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            cadena = lotes.LotesConfig(lote, Convert.ToInt16(Session["empresa"])).ToString();
            retorno = cadena.Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar posición de configuración del lote. Correspondiente a: " + ex.Message, "C");

            return null;
        }
    }

    protected void chkValidaJornal_CheckedChanged(object sender, EventArgs e)
    {
        if (chkValidaJornal.Checked)
        {
            txvJornalesD.Enabled = false;
            txvJornalesD.Text = "0";
        }
        else
            txvJornalesD.Enabled = true;

        ScriptManager1.SetFocus(chkValidaJornal);
    }
    protected void ddlSeccion_SelectedIndexChanged1(object sender, EventArgs e)
    {
        cargarLotes();
        ScriptManager1.SetFocus(ddlSeccionD);
    }
    protected void txtFechaD_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaD.Text);
        }
        catch
        {

            nilblInformacion.Text = "formato de fecha no valido..";
            txtFechaD.Text = "";
            txtFechaD.Focus();
            ScriptManager1.SetFocus(txtFechaD);
            return;
        }
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
    }
}