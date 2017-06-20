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
using System.Collections.Generic;
using System.Transactions;

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    Ctransaccion transacciones = new Ctransaccion();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Cperiodos periodo = new Cperiodos();
    Centidades entidades = new Centidades();
    Coperadores operadores = new Coperadores();
    CtransaccionAlmacen transaccionAlmacen = new CtransaccionAlmacen();
    Cterceros terceros = new Cterceros();
    Ccatalogo catalogo = new Ccatalogo();
    Crequisicion requisiciones = new Crequisicion();
    CordenCompra ordenCompra = new CordenCompra();
    Cusuario usuario = new Cusuario();
    Cdestinos destino = new Cdestinos();

    #endregion Instancias

    #region Metodos    

    private void Editar()
    {
        bool verificacion = false;

        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            if (((CheckBox)registro.FindControl("chkAnulado")).Checked == false)
            {
                verificacion = true;
            }
        }

        if (verificacion == false)
        {
            this.nilblInformacion.Text = "La transacción debe contener por lo menos un registro válido para editar";
            return;
        }

        try
        {
            using (TransactionScope ts = new TransactionScope())
            {
                switch (transacciones.EditaEncabezado(
                    this.niCalendarFecha.SelectedDate.Year.ToString() + this.niCalendarFecha.SelectedDate.Month.ToString().PadLeft(2, '0'),
                    this.ddlTipoDocumento.SelectedValue.Trim(),
                    this.txtNumero.Text.Trim(),
                    this.niCalendarFecha.SelectedDate,
                    Server.HtmlDecode(this.txtObservacion.Text.Trim())))
                {
                    case 0:

                        foreach (GridViewRow registro in this.gvLista.Rows)
                        {
                            switch (transacciones.EditaDetalle(
                                this.niCalendarFecha.SelectedDate.Year.ToString() + this.niCalendarFecha.SelectedDate.Month.ToString().PadLeft(2, '0'),
                                this.ddlTipoDocumento.SelectedValue.Trim(),
                                this.txtNumero.Text.Trim(),
                                Convert.ToInt16(registro.Cells[18].Text),
                                Convert.ToDecimal(registro.Cells[5].Text),
                                ((CheckBox)registro.FindControl("chkAnulado")).Checked))
                            {
                                case 1:

                                    verificacion = false;
                                    break;
                            }
                        }

                        if (verificacion == false)
                        {
                            this.nilblInformacion.Text = "Error al editar el registro. Operación no realizada";
                        }
                        else
                        {
                            ManejoExito("Transacción editada satisfactoriamente. Transacción número " + this.txtNumero.Text.Trim(), "A");
                            ts.Complete();
                        }
                        break;

                    case 1:

                        this.nilblInformacion.Text = "Error al editar el encabezado. Operación no realizada";
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al editar la transacción. Correspondiente a: " + ex.Message, "A");
        }
    }

    private object TipoTransaccionConfig(int posicion)
    {        
        object retorno = null;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            retorno = this.hdTransaccionConfig.Value.Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar posición de configuración de tipo de transacción. Correspondiente a: " + ex.Message, "C");

            return null;
        }
    }

    private void GetAjuste()
    {
        try
        {
            this.gvAjuste.Visible = true;
            this.gvAjuste.DataSource = transacciones.GetSaldosBodegaTotal(
                this.ddlProducto.SelectedValue, this.niCalendarFecha.SelectedDate.Year, this.niCalendarFecha.SelectedDate.Month);
            this.gvAjuste.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar saldos en bodegas. Correspondiente a: " + ex.Message, "C");
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
                registro.Cells[10].Text = CcontrolesUsuario.FormatoCifras(
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text) *
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtValorUnitario")).Text));

                registro.Cells[9].Text = CcontrolesUsuario.FormatoCifras(
                    (Convert.ToDecimal(registro.Cells[10].Text) - Convert.ToDecimal(registro.Cells[11].Text)) *
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtPiva")).Text) / 100);
                registro.Cells[11].Text = CcontrolesUsuario.FormatoCifras(
                    Convert.ToDecimal(registro.Cells[10].Text) *
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtPDes")).Text) / 100);
                registro.Cells[12].Text = CcontrolesUsuario.FormatoCifras(
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

    private bool VerificaSaldos(GridView transaccion, string bodega, DateTime fecha)
    {
        foreach (GridViewRow registro in transaccion.Rows)
        {
            if (((CheckBox)registro.FindControl("chkSeleccion")).Checked == true)
            {
                if (Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text) > transacciones.RetornaSaldoProductoBodega(
                    registro.Cells[1].Text,
                    bodega,fecha))
                {
                    this.nilblInformacion.Text = "Producto " + registro.Cells[1].Text + " con saldo insuficiente en la bodega" + bodega  + ". No es posible generar la salida";
                    return false;
                }
            }
        }

        return true;
    }

    private void CargaDestinos()
    {
        try
        {
                       
            DataView dvDestino = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("iDestino", "ppa"),
                "descripcion");

            dvDestino.RowFilter = "nivel = " + Convert.ToString(TipoTransaccionConfig(2));

            this.ddlDestino.DataSource = dvDestino;
            this.ddlDestino.DataValueField = "codigo";
            this.ddlDestino.DataTextField = "descripcion";
            this.ddlDestino.DataBind();
            this.ddlDestino.Items.Insert(0, new ListItem("Seleccione una opción", ""));
            this.ddlDestino.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar destinos. Correspondiente a: " + ex.Message, "C");
        }
    }

    private bool CompruebaSaldo()
    {
        decimal saldo = 0;

        try
        {
            DataView dvSaldo = transacciones.GetSaldoTotalProductoFecha(
                Convert.ToString(this.ddlProducto.SelectedValue),this.niCalendarFecha.SelectedDate);

            foreach (DataRowView registro in dvSaldo)
            {
                saldo = Convert.ToDecimal(registro.Row.ItemArray.GetValue(0)) - Convert.ToDecimal(registro.Row.ItemArray.GetValue(1));
            }

             if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
             saldo=saldo+Convert.ToDecimal( this.Session["cant"]);
            }

            if (this.numCantidad.ValorActual() > saldo)
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

    private void GetSaldo()
    {
        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == false)
            {
                                
            this.gvSaldo.Visible = true;
            this.gvSaldo.DataSource = transacciones.GetSaldoTotalProductoFecha(
                Convert.ToString(this.ddlProducto.SelectedValue),this.niCalendarFecha.SelectedDate);
            this.gvSaldo.DataBind();

            foreach (GridViewRow registro in this.gvSaldo.Rows)
            {
                ((GridView)registro.FindControl("gvDetalleReque")).DataSource = transacciones.RequerimientoSaldos(
                 Convert.ToString(this.ddlProducto.SelectedValue));
                ((GridView)registro.FindControl("gvDetalleReque")).DataBind();

                ((GridView)registro.FindControl("gvDetalleCompra")).DataSource = transacciones.CompraSaldos(
                Convert.ToString(this.ddlProducto.SelectedValue));
                ((GridView)registro.FindControl("gvDetalleCompra")).DataBind();

                ((GridView)registro.FindControl("gvDetalleRequi")).DataSource = transacciones.RequisicionSaldos(
                Convert.ToString(this.ddlProducto.SelectedValue));
                ((GridView)registro.FindControl("gvDetalleRequi")).DataBind();
            }
            }
            
         }
        catch (Exception ex)
        {
            ManejoError("Error al cargar el saldo del producto seleccionado. Correspondiente a: " + ex.Message, "C");
        }
    }

    public DataView DvBodega()
    {

        if (Convert.ToBoolean(TipoTransaccionConfig(16)) == true)
        {
            DataView dvBodega = CentidadMetodos.EntidadGet(
          "iBodega", "ppa").Tables[0].DefaultView;
            dvBodega.RowFilter = "tipo = 'V'";
            return dvBodega;
        }
        else
        {
            DataView dvBodega = CentidadMetodos.EntidadGet(
           "iBodega", "ppa").Tables[0].DefaultView;
            dvBodega.RowFilter = "tipo <> 'V'";
            return dvBodega;
        }
        
        
    }

    private void GuardaReferencia()
    {
        this.nilblInformacion.Text = "";

        bool verificacion = false;
        string numero = "", tercero = "", periodo, bodega = null, numeroT = "",
            tipoSalida = "", departamento = "";
        decimal valorIva = 0, valorDes = 0;
        bool verificacionCK = false;
        int naturaleza=0, vigencia=0, ano, mes;
        DateTime fecha;


        try
        {
            if (this.gvReferencia.Rows.Count == 0)
            {
                this.nilblInformacion.Text = "Debe seleccionar un registro para guardar la transacción";
                return;
            }

            if (Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim().Length == 0 ||
                Server.HtmlDecode(this.txtNumero.Text.Trim()).Length == 0 ||
                Server.HtmlDecode(this.txtFecha.Text.Trim()).Length == 0)
            {
                this.nilblInformacion.Text = "Campos vacios en el encabezado. Por favor corrija";
                return;
            }

            if (this.ddlTercero.Enabled == true)
            {
                if (Convert.ToString(this.ddlTercero.SelectedValue).Trim().Length == 0)
                {
                    this.nilblInformacion.Text = "Debe seleccionar un tercero para guardar la transacción";
                    return;
                }
            }

            if (Convert.ToBoolean(TipoTransaccionConfig(3)) != true)
            {
                foreach (GridViewRow registro in this.gvReferencia.Rows)
                {
                    if (Convert.ToDecimal(registro.Cells[10].Text) != 0)
                    {
                        verificacion = true;
                    }
                }

                if (verificacion == false)
                {
                    this.nilblInformacion.Text = "Debe ingresar el valor unitario de por lo menos un artículo para continuar";
                    return;
                }
            }
            else
            {
                verificacion = true;
            }

            using (TransactionScope ts = new TransactionScope())
            {

                if (Convert.ToBoolean(TipoTransaccionConfig(24)) == true)
                {
                    fecha = DateTime.Now;
                    periodo = Convert.ToString(fecha.Year) + Convert.ToString(fecha.Month).PadLeft(2, '0').Trim();
                    ano = Convert.ToInt16(fecha.Year);
                    mes = Convert.ToInt16(fecha.Month);
                }
                else
                {
                    fecha = this.niCalendarFecha.SelectedDate;
                    periodo = Convert.ToString(this.niCalendarFecha.SelectedDate.Year) +
                Convert.ToString(this.niCalendarFecha.SelectedDate.Month).PadLeft(2, '0').Trim();
                    ano = Convert.ToInt16(this.niCalendarFecha.SelectedDate.Year);
                    mes = Convert.ToInt16(this.niCalendarFecha.SelectedDate.Month);
                }

                if (this.txtNumero.Enabled == false)
                {
                    numero = tipoTransaccion.RetornaConsecutivo(
                        Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim());
                }
                else
                {
                    numero = this.txtNumero.Text.Trim();
                }

                if (Convert.ToBoolean(TipoTransaccionConfig(18)) == true)
                {
                    if (this.fuFoto.HasFile)
                    {
                        this.fuFoto.SaveAs(Convert.ToString(System.Configuration.ConfigurationSettings.AppSettings["UrlCotizacion"]) + numero + ".pdf");
                    }
                    else
                    {
                        this.nilblInformacion.Text = "Debe seleccionar un documento de cotización";
                        return;

                    }
                }


                foreach (GridViewRow registro in this.gvReferencia.Rows)
                {
                    if (((CheckBox)registro.FindControl("chkSeleccion")).Checked == true )
                    {
                        if (Convert.ToBoolean(TipoTransaccionConfig(10)) == true)
                        {
                            if (Convert.ToDecimal(registro.Cells[10].Text) != 0)
                            {
                                verificacionCK = true;
                            }
                        }
                        else
                        {
                            verificacionCK = true;
                        }
                       
                                            
                    }
                }

                if (verificacionCK == false)
                {
                    this.nilblInformacion.Text = "Debe seleccionar al menos un producto o un valor para guardar la transacción";
                    return;
                }


                if (this.ddlTercero.Enabled == false)
                {
                    tercero = tipoTransaccion.RetornaTerceroUsuario(
                        Convert.ToString(this.Session["usuario"]));
                }
                else
                {
                    tercero = Convert.ToString(this.ddlTercero.SelectedValue);
                }

                if (this.txtVigencia.Visible == true)
                {
                    if (this.txtVigencia.Text.Length == 0)
                    {
                        this.nilblInformacion.Text = "Debe digitar una vigencia para continuar";
                        return;
                    }
                }
                
                if (Convert.ToBoolean(TipoTransaccionConfig(4)) == true)
                {
                    if (VerificaSaldos(
                        this.gvReferencia,
                        this.niddlBodega.SelectedValue, fecha) == false)
                    {
                        return;
                    }

                    if (this.ddlTipoSalida.Visible == true)
                    {
                        if (this.ddlTipoSalida.SelectedValue.Trim().Length == 0)
                        {
                            this.nilblInformacion.Text = "Debe seleccionar un tipo de salida para continuar";
                            return;
                        }

                        tipoSalida = this.ddlTipoSalida.SelectedValue;
                    }
                }

                if (Convert.ToBoolean(TipoTransaccionConfig(5)) == true)
                {
                    numeroT = tipoTransaccion.RetornaConsecutivo(
                        "TAL");
                }
                else
                {
                    numeroT = "";
                }

                if (this.txtVigencia.Visible == true)
                {
                    if (this.txtVigencia.Text.Length == 0)
                    {
                        this.nilblInformacion.Text = "Debe digitar una vigencia para continuar";
                        return;
                    }
                }

                if (Convert.ToBoolean(TipoTransaccionConfig(19)) == true)
                {
                    vigencia = Convert.ToInt32(this.txtVigencia.Text);
                }
                else
                {
                    vigencia = tipoTransaccion.RetornaVigenciaTransaccion(
                   Convert.ToString(this.ddlTipoDocumento.SelectedValue));
                }

                if (Convert.ToBoolean(TipoTransaccionConfig(12)) == true)
                {
                    bodega = Convert.ToString(this.niddlBodega.SelectedValue);
                }
                

                if (Convert.ToBoolean(TipoTransaccionConfig(23)) == true)
                {
                    if (tipoTransaccion.ValidaCantidadRegistros(Convert.ToString(this.niddlTrnReferencia.SelectedValue), Convert.ToString(this.ddlTercero.SelectedValue)) > 1)
                    {
                        this.nilblInformacion.Text = "Hay un registro con el tercero o proveedor seleccionado, por favor corrija";
                        return;

                    }
                }

                if (this.ddlDepartamento.Visible == true)
                {
                    departamento = ddlDepartamento.SelectedValue;
                }
                else
                {
                    departamento = usuario.RetornaDepartamentoUsuario(
                     this.Session["usuario"].ToString().Trim());
                }

                naturaleza = tipoTransaccion.RetornaNaturalezaTransaccion(
                    Convert.ToString(this.ddlTipoDocumento.SelectedValue));

                object[] objValores = new object[]{
                                    departamento,
                                    this.txtDocref.Text.Trim(),
                                    fecha,
                                    DateTime.Now,
                                    naturaleza,
                                    numero,
                                    Server.HtmlDecode(this.txtObservacion.Text.Trim()),
                                    periodo,
                                    numeroT,
                                    tercero,
                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                    Convert.ToString(this.ddlTipoSalida.SelectedValue),
                                    this.Session["usuario"].ToString(),
                                    vigencia
                                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "iTransaccion",
                    "inserta",
                    "ppa",
                    objValores))
                {
                    case 0:

                            foreach (GridViewRow registro in this.gvReferencia.Rows)
                            {
                                if (((CheckBox)registro.FindControl("chkSeleccion")).Checked == true)
                                {
                                if (Convert.ToBoolean(TipoTransaccionConfig(3)) != true)
                                {
                                    if (Convert.ToBoolean(TipoTransaccionConfig(25)) == true)
                                    {
                                        if (Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text) > tipoTransaccion.ValidaCantidadMaximaRegistro(registro.Cells[13].Text, Convert.ToString(this.niddlTrnReferencia.SelectedValue), Convert.ToInt16(registro.Cells[14].Text)))
                                        {
                                            this.nilblInformacion.Text = "La cantidad del producto " + registro.Cells[1].Text + " no puede ser superior al saldo del movimiento de referencia, por favor corrija";
                                            return;

                                        }
                                    }

                                        if (Convert.ToDecimal(registro.Cells[10].Text) != 0 &&
                                            Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text) > 0)
                                        {
                                            valorDes = Convert.ToDecimal(registro.Cells[10].Text) *
                                                Convert.ToDecimal(((TextBox)registro.FindControl("txtPDes")).Text) / 100;

                                            valorIva = (Convert.ToDecimal(registro.Cells[10].Text) - valorDes) *
                                                Convert.ToDecimal(((TextBox)registro.FindControl("txtPiva")).Text) / 100;
                                                                                                                                

                                            switch (transacciones.InsertaReferencia(
                                                registro.Cells[13].Text,
                                                this.niddlTrnReferencia.SelectedValue,
                                                Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                                numero,
                                                ano,
                                                mes,
                                                registro.RowIndex,
                                                registro.Cells[1].Text,
                                                Convert.ToDecimal(((TextBox)registro.FindControl("txtValorUnitario")).Text),
                                                Convert.ToDecimal(((TextBox)registro.FindControl("txtPiva")).Text),
                                                Convert.ToDecimal(((TextBox)registro.FindControl("txtPDes")).Text),
                                                valorIva,
                                                valorDes,
                                                Convert.ToDecimal(registro.Cells[10].Text),
                                                Convert.ToDecimal(registro.Cells[12].Text),
                                                Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text),
                                                bodega,
                                                Convert.ToInt16(registro.Cells[14].Text)))
                                            {
                                                case 0:
                                                    verificacion = true;
                                                    break;
                                                case 1:
                                                    verificacion = false;
                                                    break;
                                            }
                                        }
                                    
                                }
                                else
                                {
                                    switch (transacciones.InsertaSalida(
                                         ano,
                                         mes,
                                        Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                        numero,
                                        Server.HtmlDecode(registro.Cells[1].Text.Trim()),
                                        Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text),
                                        Server.HtmlDecode(registro.Cells[5].Text.Trim()),
                                        bodega,
                                        this.niddlTrnReferencia.SelectedValue))
                                    {
                                        case 0:
                                                                                        verificacion = true;
                                            
                                            break;
                                        case 1:
                                            verificacion = false;
                                            
                                            break;
                                        case 2:
                                            verificacion = true;
                                                                                break;
                                    }
                                }
                            }
                            }


                   
                        if (verificacion == false)
                        {
                            this.nilblInformacion.Text = "Error al insertar el detalle de la transacción. Operación no realizada";
                            return;
                        }

                        if (this.txtNumero.Enabled == false)
                        {
                            if (tipoTransaccion.ActualizaConsecutivo(
                                Convert.ToString(this.ddlTipoDocumento.SelectedValue)) != 0)
                            {
                                this.nilblInformacion.Text = "Error al actualizar el consecutivo. Operación no realizada";
                                return;
                            }
                        }

                        if (Convert.ToBoolean(TipoTransaccionConfig(5)) == true)
                        {
                            if (tipoTransaccion.ActualizaConsecutivo(
                                "TAL") != 0)
                            {
                                this.nilblInformacion.Text = "Error al actualizar el consecutivo. Operación no realizada";
                                return;
                            }
                        }

                        this.Session["numero"] = numero;
                        this.Session["tipo"] = this.ddlTipoDocumento.SelectedValue;
                        transacciones.EnviaCorreo(txtNumero.Text.ToString().Trim());
                         ManejoExito("Transacción registrada satisfactoriamente. Transacción número " + numero, "I");
                         ts.Complete();
                                
                        break;

                    case 1:

                        ManejoError("Error al insertar el encabezado de la transacción. Operación no realizada", "I");
                      
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar la transacción. Correspondiente a: " + ex.Message, "I");
        }
    }

    private void UmedidaProducto()
    {
        try
        {
            this.ddlUmedida.SelectedValue = catalogo.RetornaUmedida(
                Convert.ToString(this.ddlProducto.SelectedValue));

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

    private void TotalizaTransaccion()
    {
        try
        {
            this.gvTotal.DataSource = transaccionAlmacen.TotalizaTransaccion(
                (List<CtransaccionAlmacen>)Session["transaccion"]);
            this.gvTotal.DataBind();
        }
        catch (Exception ex)
        {
            CcontrolesUsuario.MensajeError(
                "Error al totalizar la transacción. Correspondiente a: " + ex.Message,
                this.nilblInformacion);
        }
    }

    private void CargaProductos()
    {
        try
        {
            this.ddlProducto.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("iCatalogo", "ppa"),
                "cadena");
            this.ddlProducto.DataValueField = "codigo";
            this.ddlProducto.DataTextField = "cadena";
            this.ddlProducto.DataBind();
            this.ddlProducto.Items.Insert(0, new ListItem("Seleccione una opción", ""));
            this.ddlProducto.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar productos. Correspondiente a: " + ex.Message, "C");
        }
    }

    private int CompruebaTransaccionExistente()
    {
        try
        {
            object[] objkey = new object[]{
                this.txtNumero.Text,
                this.niCalendarFecha.SelectedDate.Year.ToString() + this.niCalendarFecha.SelectedDate.Month.ToString().PadLeft(2,'0'),
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

    private void Guardar()
    {
        string numero = "", bodega, cuenta, ccosto, periodo, tercero = "", talonario = "", departamento = "";
        bool verificacion = true, inversion = false;
        decimal cantidadAprobada = 0;
        int naturaleza = 0, vigencia = 0;
        int ano, mes;
        DateTime fecha;

        if (gvLista.Rows.Count == 0 && Convert.ToBoolean(TipoTransaccionConfig(1)) == false && Convert.ToBoolean(TipoTransaccionConfig(12)) == false)
        {
            this.nilblInformacion.Text = "Detalle de la transacción vacio. No es posible registrar la transacción";
        }
        else
        {
            if (Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim().Length == 0)
            {
                this.nilblInformacion.Text = "Por favor seleccione un tipo de movimiento. No es posible registrar la transacción";
            }
            else
            {
                if (this.txtNumero.Text.Trim().Length == 0)
                {
                    this.nilblInformacion.Text = "El número de transacción no puede estar vacio. No es posible registrar la transacción";
                }
                else
                {
                    if (Convert.ToString(this.niCalendarFecha.SelectedDate).Trim().Length == 0)
                    {
                        this.nilblInformacion.Text = "Debe seleccionar una fecha. No es posible registrar la transacción";
                    }
                    else
                    {
                        if (this.ddlTercero.Enabled == true)
                        {
                            if (this.ddlTercero.SelectedValue.Trim().Length == 0)
                            {
                                this.nilblInformacion.Text = "Debe seleccionar el tercero para continuar";
                                return;
                            }
                        }

                        using (TransactionScope ts = new TransactionScope())
                        {
                            try
                            {
                                if (Convert.ToBoolean(TipoTransaccionConfig(24)) == true)
                                {
                                    fecha = DateTime.Now;
                                    periodo = Convert.ToString(fecha.Year) + Convert.ToString(fecha.Month).PadLeft(2, '0').Trim();
                                    ano = Convert.ToInt16(fecha.Year);
                                    mes = Convert.ToInt16(fecha.Month);
                                }
                                else
                                {
                                    fecha = this.niCalendarFecha.SelectedDate;
                                    periodo = Convert.ToString(this.niCalendarFecha.SelectedDate.Year) +
                                Convert.ToString(this.niCalendarFecha.SelectedDate.Month).PadLeft(2, '0').Trim();
                                    ano = Convert.ToInt16(this.niCalendarFecha.SelectedDate.Year);
                                    mes = Convert.ToInt16(this.niCalendarFecha.SelectedDate.Month);
                                }

                                if (Convert.ToBoolean(this.Session["editar"]) == true)
                                {
                                    this.txtNumero.Enabled = false;

                                    numero = this.txtNumero.Text.Trim();

                                    object[] objKey = new object[]{
                                        numero,
                                        this.ddlTipoDocumento.SelectedValue};

                                    CentidadMetodos.EntidadInsertUpdateDelete(
                                        "iTransaccionDetalle",
                                        "elimina",
                                        "ppa",
                                        objKey);

                                    CentidadMetodos.EntidadInsertUpdateDelete(
                                        "iTransaccion",
                                        "elimina",
                                        "ppa",
                                        objKey);
                                }
                                else
                                {
                                    if (this.txtNumero.Enabled == false)
                                    {
                                        numero = tipoTransaccion.RetornaConsecutivo(
                                            Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim());
                                    }
                                    else
                                    {
                                        numero = this.txtNumero.Text.Trim();
                                    }
                                }

                                if (this.ddlTercero.Enabled == false)
                                {
                                    tercero = tipoTransaccion.RetornaTerceroUsuario(
                                        Convert.ToString(this.Session["usuario"]));
                                }
                                else
                                {
                                    tercero = Convert.ToString(this.ddlTercero.SelectedValue);
                                }


                                if (Convert.ToBoolean(TipoTransaccionConfig(5)) == true)
                                {
                                    talonario = tipoTransaccion.RetornaConsecutivo(
                                        "TAL");
                                }
                                else
                                {
                                    talonario = "";
                                }

                                if (Convert.ToBoolean(TipoTransaccionConfig(19)) == true)
                                {
                                    vigencia = Convert.ToInt32(this.txtVigencia.Text);
                                }
                                else
                                {
                                    vigencia = tipoTransaccion.RetornaVigenciaTransaccion(
                                   Convert.ToString(this.ddlTipoDocumento.SelectedValue));
                                }

                                if (this.ddlDepartamento.Visible == true)
                                {
                                    departamento = ddlDepartamento.SelectedValue;
                                }
                                else
                                {
                                    departamento = usuario.RetornaDepartamentoUsuario(
                                     this.Session["usuario"].ToString().Trim());
                                }

                                naturaleza = tipoTransaccion.RetornaNaturalezaTransaccion(
                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue));

                                object[] objValores = new object[]{
                                    departamento,
                                    this.txtDocref.Text.Trim(),
                                    fecha,
                                    DateTime.Now,
                                    naturaleza,
                                    numero,
                                    Server.HtmlDecode(this.txtObservacion.Text.Trim()),
                                    periodo,
                                    talonario,
                                    tercero,
                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                    Convert.ToString(this.ddlTipoSalida.SelectedValue),
                                    this.Session["usuario"].ToString(),
                                    vigencia
                                };

                                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                    "iTransaccion",
                                    "inserta",
                                    "ppa",
                                    objValores))
                                {
                                    case 0:

                                        if (Convert.ToBoolean(TipoTransaccionConfig(1)) == false && Convert.ToBoolean(TipoTransaccionConfig(16)) == false)
                                        {
                                            foreach (GridViewRow cuerpo in this.gvLista.Rows)
                                            {
                                                foreach (Control objControl in cuerpo.Cells[11].Controls)
                                                {
                                                    if (objControl is CheckBox)
                                                    {
                                                        inversion = ((CheckBox)objControl).Checked;
                                                    }
                                                }


                                                if (cuerpo.Cells[2].Text == "&nbsp;")
                                                {
                                                    bodega = null;
                                                }
                                                else
                                                {
                                                    bodega = Server.HtmlDecode(cuerpo.Cells[2].Text);
                                                }

                                                if (cuerpo.Cells[10].Text == "&nbsp;")
                                                {
                                                    cuenta = null;
                                                }
                                                else
                                                {
                                                    cuenta = Server.HtmlDecode(cuerpo.Cells[10].Text);
                                                }

                                                if (cuerpo.Cells[13].Text == "&nbsp;")
                                                {
                                                    ccosto = null;
                                                }
                                                else
                                                {
                                                    ccosto = Server.HtmlDecode(cuerpo.Cells[13].Text);
                                                }

                                                object[] objValoresCuerpo = new object[]{
                                                    false,
                                                    false,
                                                    bodega,
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    ccosto,
                                                    0,
                                                    cuenta,
                                                    Server.HtmlDecode(cuerpo.Cells[11].Text),
                                                    Server.HtmlDecode(cuerpo.Cells[4].Text),
                                                    this.txtDocref.Text.Trim(),
                                                    0,
                                                    null,
                                                    null,
                                                    null,
                                                    inversion,
                                                    0,
                                                    numero,
                                                    0,
                                                    periodo,
                                                    Convert.ToDecimal(cuerpo.Cells[9].Text),
                                                    0,
                                                    Server.HtmlDecode(cuerpo.Cells[3].Text),
                                                    cuerpo.RowIndex,
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                                    Server.HtmlDecode(cuerpo.Cells[6].Text),
                                                    null,
                                                    null,
                                                    null,
                                                    0,
                                                    Server.HtmlDecode(cuerpo.Cells[14].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[15].Text),                                                
                                                    Convert.ToDecimal(cuerpo.Cells[8].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[7].Text)
                                                };

                                                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                                    "iTransaccionDetalle",
                                                    "inserta",
                                                    "ppa",
                                                    objValoresCuerpo))
                                                {
                                                    case 0:
                                                        if (Convert.ToBoolean(TipoTransaccionConfig(15)) == true)
                                                        {
                                                            transacciones.CalculaSaldoProductoBodega(
                                                               ano, mes,
                                                               Server.HtmlDecode(cuerpo.Cells[3].Text),
                                                               Server.HtmlDecode(cuerpo.Cells[2].Text),
                                                               Convert.ToDecimal(cuerpo.Cells[7].Text));
                                                        }
                                                        break;
                                                    case 1:

                                                        verificacion = false;
                                                        break;
                                                }
                                            }
                                        }
                                        else
                                        {

                                            if (Convert.ToBoolean(TipoTransaccionConfig(1)) == true && Convert.ToBoolean(TipoTransaccionConfig(12)) == false)
                                            {
                                                foreach (GridViewRow cuerpo in this.gvAjuste.Rows)
                                                {
                                                    decimal cantidad = 0, costo = 0;

                                                    if (((TextBox)cuerpo.FindControl("txtCantidadAjuste")).Text.Trim().Length != 0)
                                                    {
                                                        cantidad = Convert.ToDecimal(((TextBox)cuerpo.FindControl("txtCantidadAjuste")).Text);

                                                    }
                                                    costo = Convert.ToDecimal(cuerpo.Cells[1].Text);

                                                    if (cantidad != 0)
                                                    {
                                                    object[] objValoresCuerpo = new object[]{
                                                    false,
                                                    false,
                                                    Server.HtmlDecode(cuerpo.Cells[0].Text),
                                                    Convert.ToDecimal(cantidad),
                                                    Convert.ToDecimal(cantidad),
                                                    null,
                                                    0,
                                                    null,
                                                    null,
                                                    Server.HtmlDecode(this.ddlProducto.Text),
                                                    "",
                                                    0,
                                                    null,
                                                    null,
                                                    null,
                                                    0,
                                                    0,
                                                    numero,
                                                    0,
                                                    periodo,
                                                    0,
                                                    0,
                                                    Convert.ToString(this.ddlProducto.SelectedValue),
                                                    cuerpo.RowIndex,
                                                    Convert.ToDecimal(cantidad),
                                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                                    Server.HtmlDecode(cuerpo.Cells[3].Text),
                                                    null,
                                                    null,
                                                    null,
                                                    0,
                                                    0,
                                                    Convert.ToDecimal(cantidad * costo),                                                
                                                    Convert.ToDecimal(cantidad * costo),                                                                   
                                                    Convert.ToDecimal(costo)
                                                    };


                                                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                                            "iTransaccionDetalle",
                                                            "inserta",
                                                            "ppa",
                                                            objValoresCuerpo))
                                                        {
                                                            case 0:

                                                                transacciones.CalculaSaldoProductoBodega(
                                                                    ano,
                                                                    mes,
                                                                    Server.HtmlDecode(this.ddlProducto.SelectedValue),
                                                                    Server.HtmlDecode(cuerpo.Cells[0].Text),
                                                                    costo);
                                                                break;

                                                            case 1:

                                                                verificacion = false;
                                                                break;
                                                        }
                                                    }
                                                }
                                            }
                                            else
                                            {
                                                if (Convert.ToBoolean(TipoTransaccionConfig(16)) == true)
                                                {
                                                    foreach (GridViewRow cuerpo in this.gvLista.Rows)
                                                    {
                                                        foreach (Control objControl in cuerpo.Cells[11].Controls)
                                                        {
                                                            if (objControl is CheckBox)
                                                            {
                                                                inversion = ((CheckBox)objControl).Checked;
                                                            }
                                                        }

                                                        if (Convert.ToBoolean(TipoTransaccionConfig(14)) == true)
                                                        {
                                                            cantidadAprobada = Convert.ToDecimal(cuerpo.Cells[5].Text);
                                                        }
                                                        else
                                                        {
                                                            cantidadAprobada = 0;
                                                        }

                                                        object[] objValoresCuerpo = new object[]{
                                                    Server.HtmlDecode(cuerpo.Cells[2].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Server.HtmlDecode(cuerpo.Cells[13].Text),
                                                    "",
                                                    Convert.ToDecimal(cuerpo.Cells[7].Text),
                                                    "",
                                                    Server.HtmlDecode(cuerpo.Cells[11].Text),
                                                    Server.HtmlDecode(cuerpo.Cells[4].Text),
                                                    this.txtDocref.Text.Trim(),
                                                    0,
                                                    inversion,
                                                    0,
                                                    numero,
                                                    0,
                                                    periodo,
                                                    Convert.ToDecimal(cuerpo.Cells[9].Text),
                                                    0,
                                                    Server.HtmlDecode(cuerpo.Cells[3].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[10].Text),
                                                    0,
                                                    cuerpo.RowIndex,
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                                    Server.HtmlDecode(cuerpo.Cells[6].Text),
                                                    0,
                                                    Convert.ToDecimal(cuerpo.Cells[14].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[16].Text),                                                
                                                    Convert.ToDecimal(cuerpo.Cells[15].Text),
                                                    0,
                                                    Convert.ToDecimal(cuerpo.Cells[8].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[7].Text)
                                                };

                                                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                                            "iTransaccionDetalle",
                                                            "inserta",
                                                            "ppa",
                                                            objValoresCuerpo))
                                                        {

                                                            case 0:
                                                                transacciones.CalculaSaldoProductoBodega(
                                                                ano,mes,
                                                                Server.HtmlDecode(cuerpo.Cells[3].Text),
                                                                Server.HtmlDecode(cuerpo.Cells[2].Text),
                                                                Convert.ToDecimal(cuerpo.Cells[7].Text));
                                                                break;

                                                            case 1:

                                                                verificacion = false;
                                                                break;

                                                        }
                                                    }
                                                }

                                                else
                                                {
                                                    foreach (GridViewRow cuerpo in this.gvLista.Rows)
                                                    {
                                                        //aqui son los ajustes
                                                        foreach (Control objControl in cuerpo.Cells[11].Controls)
                                                        {
                                                            if (objControl is CheckBox)
                                                            {
                                                                inversion = ((CheckBox)objControl).Checked;
                                                            }
                                                        }


                                                        if (cuerpo.Cells[2].Text == "&nbsp;")
                                                        {
                                                            bodega = null;
                                                        }
                                                        else
                                                        {
                                                            bodega = Server.HtmlDecode(cuerpo.Cells[2].Text);
                                                        }

                                                        if (cuerpo.Cells[10].Text == "&nbsp;")
                                                        {
                                                            cuenta = null;
                                                        }
                                                        else
                                                        {
                                                            cuenta = Server.HtmlDecode(cuerpo.Cells[10].Text);
                                                        }

                                                        if (cuerpo.Cells[13].Text == "&nbsp;")
                                                        {
                                                            ccosto = null;
                                                        }
                                                        else
                                                        {
                                                            ccosto = Server.HtmlDecode(cuerpo.Cells[13].Text);
                                                        }

                                                        object[] objValoresCuerpo = new object[]{
                                                    false,
                                                    false,
                                                    bodega,
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    ccosto,
                                                    0,
                                                    cuenta,
                                                    Server.HtmlDecode(cuerpo.Cells[11].Text),
                                                    Server.HtmlDecode(cuerpo.Cells[4].Text),
                                                    this.txtDocref.Text.Trim(),
                                                    0,
                                                    null,
                                                    null,
                                                    null,
                                                    inversion,
                                                    0,
                                                    numero,
                                                    0,
                                                    periodo,
                                                    Convert.ToDecimal(cuerpo.Cells[9].Text),
                                                    0,
                                                    Server.HtmlDecode(cuerpo.Cells[3].Text),
                                                    cuerpo.RowIndex,
                                                    Convert.ToDecimal(cuerpo.Cells[5].Text),
                                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                                                    Server.HtmlDecode(cuerpo.Cells[6].Text),
                                                    null,
                                                    null,
                                                    null,
                                                    0,
                                                    Server.HtmlDecode(cuerpo.Cells[14].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[15].Text),                                                
                                                    Convert.ToDecimal(cuerpo.Cells[8].Text),
                                                    Convert.ToDecimal(cuerpo.Cells[7].Text)
                                                };

                                                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                                            "iTransaccionDetalle",
                                                            "inserta",
                                                            "ppa",
                                                            objValoresCuerpo))
                                                        {

                                                            case 0:
                                                                transacciones.CalculaSaldoProductoBodega(
                                                                ano,
                                                                mes,
                                                                Server.HtmlDecode(cuerpo.Cells[3].Text),
                                                                Server.HtmlDecode(cuerpo.Cells[2].Text),
                                                                Convert.ToDecimal(cuerpo.Cells[7].Text));
                                                                break;

                                                            case 1:

                                                                verificacion = false;
                                                                break;

                                                        }
                                                    }
                                                }
                                            }
                                        }

                                        if (verificacion == true)
                                        {
                                            if (this.txtNumero.Enabled == false && Convert.ToBoolean(this.Session["editar"]) == false)
                                            {
                                                if (tipoTransaccion.ActualizaConsecutivo(
                                                    Convert.ToString(this.ddlTipoDocumento.SelectedValue)) != 0)
                                                {
                                                    this.nilblInformacion.Text = "Error al actualizar el consecutivo. Operación no realizada";
                                                    return;
                                                }
                                            }

                                            if (Convert.ToBoolean(TipoTransaccionConfig(5)) == true)
                                            {
                                                if (tipoTransaccion.ActualizaConsecutivo(
                                                    "TAL") != 0)
                                                {
                                                    this.nilblInformacion.Text = "Error al actualizar el consecutivo. Operación no realizada";
                                                    return;
                                                }
                                            }
                                            transacciones.EnviaCorreo(txtNumero.Text.ToString().Trim());
                                            ManejoExito("Transacción registrada satisfactoriamente. Transacción número " + numero, "A");
                                            ts.Complete();
                                            
                                        }
                                        else
                                        {
                                            this.nilblInformacion.Text = "Error al insertar detalle de transacción. Operación no realizada";
                                        }
                                        break;

                                    case 1:

                                        this.nilblInformacion.Text = "Error al insertar la transacción. Operación no realizada";
                                        break;
                                }
                            }
                            catch (Exception ex)
                            {
                                this.nilblInformacion.Text = "Error al registrar la transacción. Correspondiente a: " + ex.Message;
                            }
                        }
                    }
                }
            }
        }
    }

    private void ManejoEncabezado()
    {
        HabilitaEncabezado();
        CargarTipoTransaccion();
    }

    private void TabRegistro()
    {
        this.UpdatePanelRegistro.Visible = true;
        this.UpdatePanelConsulta.Visible = false;

        if (Convert.ToBoolean(this.Session["editar"]) == true)
        {
            this.UpdatePanelDetalle.Visible = true;
            this.UpdatePanelEncabezado.Visible = true;         
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

    private void CargarCombos()
    {
        try
        {
            this.ddlTipoSalida.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("gTipoSalida", "ppa"),
                "descripcion");
            this.ddlTipoSalida.DataValueField = "codigo";
            this.ddlTipoSalida.DataTextField = "descripcion";
            this.ddlTipoSalida.DataBind();
            this.ddlTipoSalida.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de salida. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlDepartamento.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nDepartamento", "ppa"),
                "descripcion");
            this.ddlDepartamento.DataValueField = "codigo";
            this.ddlDepartamento.DataTextField = "descripcion";
            this.ddlDepartamento.DataBind();
            this.ddlDepartamento.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de salida. Correspondiente a: " + ex.Message, "C");
        }
           
        

        try
        {
            this.ddlUmedida.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("gUnidadMedida", "ppa"),
                "descripcion");
            this.ddlUmedida.DataValueField = "codigo";
            this.ddlUmedida.DataTextField = "descripcion";
            this.ddlUmedida.DataBind();
            this.ddlUmedida.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidades de medida. Correspondiente a: " + ex.Message, "C");
        }

      

    }

    private void CargarCentroCosto()
    {
        try
        {
            this.ddlCcosto.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("cCentrosCosto", "ppa"),
                "descripcion");
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

    private void CargarCuenta()
    {
        try
        {
            this.ddlCuenta.DataSource = destino.CuentasAuxiliares(this.ddlDestino.SelectedValue,this.chkInversion.Checked);
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
        }

        this.UpdatePanelEncabezado.Visible = true;

        CcontrolesUsuario.ComportamientoCampoEntidad(
            this.UpdatePanelEncabezado.Controls,
            "iTransaccion",
            Convert.ToString(this.ddlTipoDocumento.SelectedValue),
            this.lbFecha);
    }

    private string ConsecutivoTransaccion()
    {
        string numero = "";

        try
        {
            numero = tipoTransaccion.RetornaConsecutivo(
                Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim());
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el número de transacción. Correspondiente a: " + ex.Message, "C");
        }

        return numero;
    }

    private void CargarTipoTransaccion()
    {
        try
        {
            this.ddlTipoDocumento.DataSource = tipoTransaccion.GetTipoTransaccionModulo();
            this.ddlTipoDocumento.DataValueField = "codigo";
            this.ddlTipoDocumento.DataTextField = "descripcion";
            this.ddlTipoDocumento.DataBind();
            this.ddlTipoDocumento.Items.Insert(0,new ListItem("Seleccione una opción",""));
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
        this.gvSaldo.DataSource = null;
        this.gvSaldo.DataBind();
        this.gvTotal.DataSource = null;
        this.gvTotal.DataBind();
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.Session["transaccion"] = null;
        this.lbImprimir.Visible = false;
        this.gvAjuste.DataSource = null;
        this.gvAjuste.DataBind();
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

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        this.Response.Redirect("~/Almacen/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.UpdatePanelEncabezado.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.UpdatePanelEncabezado.Controls);

        CcontrolesUsuario.InhabilitarControles(
            this.UpdatePanelDetalle.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.UpdatePanelDetalle.Controls);
        
        InHabilitaEncabezado();

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.Session["transaccion"] = null;
        this.nilblInformacion.Text = mensaje;
        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
        this.lbRegistrar.Visible = false;
        this.gvTotal.DataSource = null;
        this.gvTotal.DataBind();
        this.gvReferencia.DataSource = null;
        this.gvReferencia.DataBind();
        this.nilblValorNeto.Visible = false;
        this.nilblValorTotal.Visible = false;
        this.nilblDocReferencia.Visible = false;
        this.niddlTrnReferencia.Visible = false;
        this.nitxtTotalValorNeto.Visible = false;
        this.nitxtTotalValorTotal.Visible = false;
        this.gvSaldo.DataSource = null;
        this.gvSaldo.DataBind();
        this.lbImprimir.Visible = true;
        this.nilblBodega.Visible = false;
        this.niddlBodega.Visible = false;
        this.gvAjuste.DataSource = null;
        this.gvAjuste.DataBind();
        this.fuFoto.Visible = false;
        this.lbDocumento.Visible = false;
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
            if (!IsPostBack)
            {
                CargarCombos();
                CargaCampos();

                this.Session["transaccion"] = null;
                this.Session["operadores"] = null;
            }

            this.nitxtTotalValorTotal.Text = "0";// this.hdValorTotalRef.Value.ToString();
            this.nitxtTotalValorNeto.Text = "0";// this.hdValorNetoRef.Value.ToString();

            TotalizaGrillaReferencia();
        }        
    }

    protected void nilbNuevo_Click(object sender, EventArgs e)
    {
        this.Session["editar"] = false;

        ManejoEncabezado();
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        InHabilitaEncabezado();

        CcontrolesUsuario.InhabilitarControles(
            this.UpdatePanelEncabezado.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.UpdatePanelEncabezado.Controls);

        CcontrolesUsuario.InhabilitarControles(
            this.UpdatePanelDetalle.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.UpdatePanelDetalle.Controls);
        
        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.niCalendarFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
        this.lbRegistrar.Visible = false;
        this.gvTotal.DataSource = null;
        this.gvTotal.DataBind();
        this.gvReferencia.DataSource = null;
        this.gvReferencia.DataBind();
        this.nilblValorNeto.Visible = false;
        this.nilblValorTotal.Visible = false;
        this.nitxtTotalValorNeto.Visible = false;
        this.nitxtTotalValorTotal.Visible = false;
        this.nilblDocReferencia.Visible = false;
        this.niddlTrnReferencia.Visible = false;
        this.fuFoto.Visible = false;
        this.lbDocumento.Visible = false;
        this.gvSaldo.DataSource = null;
        this.gvSaldo.DataBind();
        this.lbCancelar.Visible = false;
        this.lbImprimir.Visible = false;
        this.nilblBodega.Visible = false;
        this.niddlBodega.Visible = false;
        this.gvAjuste.DataSource = null;
        this.gvAjuste.DataBind();
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
                this.UpdatePanelEncabezado.Controls);
            CcontrolesUsuario.LimpiarControles(
                this.UpdatePanelEncabezado.Controls);

            CcontrolesUsuario.InhabilitarControles(
                this.UpdatePanelDetalle.Controls);
            CcontrolesUsuario.LimpiarControles(
                this.UpdatePanelDetalle.Controls);


            

            this.gvReferencia.DataSource = null;
            this.gvReferencia.DataBind();
            this.gvLista.DataSource = null;
            this.gvLista.DataBind();
            this.gvSaldo.DataSource = null;
            this.gvSaldo.DataBind();
            this.gvTotal.DataSource = null;
            this.gvTotal.DataBind();
            this.Session["transaccion"] = null;
            this.nilblValorNeto.Visible = false;
            this.nilblValorTotal.Visible = false;
            this.nitxtTotalValorNeto.Visible = false;
            this.nitxtTotalValorTotal.Visible = false;
            this.nilblDocReferencia.Visible = false;
            this.niddlTrnReferencia.Visible = false;
            this.nilblBodega.Visible = false;
            this.niddlBodega.Visible = false;
            this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
            this.txtNumero.Text = ConsecutivoTransaccion();
            this.lbImprimir.Visible = false;
            this.gvAjuste.DataSource = null;
            this.gvAjuste.DataBind();
            this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(
                this.ddlTipoDocumento.SelectedValue);


            if (Convert.ToBoolean(TipoTransaccionConfig(17)) == true)
            {
                if (tipoTransaccion.RetornavalidacionRegistro(Convert.ToString(this.ddlTipoDocumento.SelectedValue)) == 1)
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
                Convert.ToString(this.ddlTipoDocumento.SelectedValue)) == 1)
            {
                this.UpdatePanelReferencia.Visible = true;
                this.UpdatePanelDetalle.Visible = false;
                this.nilblValorNeto.Visible = true;
                this.nilblValorTotal.Visible = true;
                this.nitxtTotalValorNeto.Visible = true;
                this.nitxtTotalValorTotal.Visible = true;
                this.nilblDocReferencia.Visible = true;
                this.niddlTrnReferencia.Visible = true;
                this.nilblBodega.Visible = true;
                this.niddlBodega.Visible = true;

                switch (Convert.ToBoolean(TipoTransaccionConfig(6)))
                {
                    case false:

                        try
                        {
                            this.niddlTrnReferencia.DataSource = tipoTransaccion.GetReferencia(
                                Convert.ToString(this.ddlTipoDocumento.SelectedValue));
                            this.niddlTrnReferencia.DataValueField = "numero";
                            this.niddlTrnReferencia.DataTextField = "cadena";
                            this.niddlTrnReferencia.DataBind();
                            this.niddlTrnReferencia.Items.Insert(0, new ListItem("Seleccione una opción", ""));
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
                this.UpdatePanelDetalle.Visible = true;
                this.nilblValorNeto.Visible = false;
                this.nilblValorTotal.Visible = false;
                this.nitxtTotalValorNeto.Visible = false;
                this.nitxtTotalValorTotal.Visible = false;
                this.nilblDocReferencia.Visible = false;
                this.niddlTrnReferencia.Visible = false;
                this.nilblBodega.Visible = false;
                this.niddlBodega.Visible = false;
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
            this.UpdatePanelEncabezado.Controls);

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

        if (periodo.RetornaPeriodoCerrado(
            Convert.ToString(this.niCalendarFecha.SelectedDate.Year) +
            Convert.ToString(this.niCalendarFecha.SelectedDate.Month).PadLeft(2, '0')) == 1)
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

                CcontrolesUsuario.ComportamientoCampoEntidad(
                    this.UpdatePanelDetalle.Controls,
                    "iTransaccionDetalle",
                    Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                    this.lbFecha);

                if (Convert.ToBoolean(TipoTransaccionConfig(14)) == true)
                {
                    try
                    {
                        DataView dvProveedor = CentidadMetodos.EntidadGet(
                            "cxpProveedor",
                            "ppa").Tables[0].DefaultView;
                        dvProveedor.RowFilter = "entradaDirecta = 1";

                        this.ddlTercero.DataSource = dvProveedor;
                        this.ddlTercero.DataValueField = "codigo";
                        this.ddlTercero.DataTextField = "cadena";                        
                        this.ddlTercero.DataBind();
                        this.ddlTercero.Items.Insert(0, new ListItem("Seleccione una opción", ""));
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
                        DataView dvBodega = CentidadMetodos.EntidadGet(
                      "iBodega",
                      "ppa").Tables[0].DefaultView;
                        dvBodega.RowFilter = "tipo = 'V'";

                        this.ddlBodega.DataSource = dvBodega;
                        this.ddlBodega.DataValueField = "codigo";
                        this.ddlBodega.DataTextField = "descripcion";
                        this.ddlBodega.DataBind();
                        this.ddlBodega.Items.Insert(0, new ListItem("Seleccione una opción", ""));
                    }
                    else
                    {
                        this.ddlBodega.DataSource = CcontrolesUsuario.OrdenarEntidad(
                            CentidadMetodos.EntidadGet("iBodega", "ppa"),
                            "descripcion");
                        this.ddlBodega.DataValueField = "codigo";
                        this.ddlBodega.DataTextField = "descripcion";
                        this.ddlBodega.DataBind();
                        this.ddlBodega.Items.Insert(0, new ListItem("Seleccione una opción", ""));
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
                //else
                //{
                //    this.txtProducto.Visible = false;
                //}

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

    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        decimal pIva = 0;

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
            if (this.Session["transaccion"] != null)
            {
                foreach (CtransaccionAlmacen registro in (List<CtransaccionAlmacen>)Session["transaccion"])
                {
                    if (Convert.ToString(this.ddlProducto.SelectedValue) == registro.Producto)
                    {
                        this.nilblInformacion.Text = "El producto seleccionado ya se encuentra registrado. Por favor corrija";
                        this.gvLista.DataSource = (List<CtransaccionAlmacen>)Session["transaccion"];
                        this.gvLista.DataBind();
                        return;
                    }
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
                this.UpdatePanelDetalle.Controls) == false)
            {
                CcontrolesUsuario.MensajeError(
                    "Campos vacios. Por favor corrija",
                    this.nilblInformacion);
                return;
            }

            if (this.ddlCuenta.Visible == true)
            {
                if (destino.ValidaCuentaMayor(this.ddlCuenta.SelectedValue) != 0)
                {
                    CcontrolesUsuario.MensajeError(
                        "Debe seleccionar una cuenta Auxiliar",
                        this.nilblInformacion);
                    return;

                }
            }

            if (this.ddlDestino.Visible == true)
            {
                if (destino.ValidaDestinoInversion(this.ddlDestino.SelectedValue, this.chkInversion.Checked) != 0)
                {
                    CcontrolesUsuario.MensajeError(
                        "El destino no tiene cuenta de inversión",
                        this.nilblInformacion);
                    return;

                }
            }

            if (this.numCantidad.ValorActual() <= 0)
            {
                this.nilblInformacion.Text = "La cantidad no puede ser igual o menor que cero. Por favor corrija";
                return;
            }

            if (Convert.ToBoolean(TipoTransaccionConfig(15)) == false)
            {
                if (this.numCantidad.ValorActual() > Convert.ToDecimal(this.hdCantidad.Value))
                {
                    this.nilblInformacion.Text = "La cantidad no puede ser mayor a la registrada inicialmente. Por favor Corrija";
                    this.numCantidad.ValorActual(Convert.ToDecimal(this.hdCantidad.Value));
                }
            }

            if (Convert.ToBoolean(this.Session["editar"]) == false)
            {
                decimal[] tributario = catalogo.RetornaTributario(
                    Convert.ToString(this.ddlProducto.SelectedValue));

                pIva = Convert.ToDecimal(tributario.GetValue(0));

                if (this.numPiva.ValorActual() != 0)
                {
                    this.numPiva.ValorActual(pIva);
                }
            }

            transaccionAlmacen = new CtransaccionAlmacen(
                Convert.ToString(this.ddlBodega.SelectedValue),
                Convert.ToString(this.ddlProducto.SelectedValue),
                Convert.ToDecimal(this.numCantidad.ValorActual()),
                Convert.ToString(this.ddlUmedida.SelectedValue),
                this.numValorUnitario.ValorActual(),
                this.numPiva.ValorActual(),
                Convert.ToString(this.ddlCuenta.SelectedValue),
                Convert.ToString(this.ddlDestino.SelectedValue),
                this.chkInversion.Checked,
                Convert.ToString(this.ddlCcosto.SelectedValue),
                this.numValorUnitario.ValorActual() * this.numCantidad.ValorActual(),
                0,
                0,
                Server.HtmlDecode(this.txtDetalle.Text.Trim()),
                Convert.ToInt16(this.hdRegistro.Value)
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
            this.gvSaldo.DataSource = null;
            this.gvSaldo.DataBind();
            this.txtProducto.Focus();

            CargaProductos();
            TotalizaTransaccion();

            CcontrolesUsuario.LimpiarControles(
                this.UpdatePanelDetalle.Controls);
            CcontrolesUsuario.LimpiarCombos(
                this.UpdatePanelDetalle.Controls);

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
        this.nilblInformacion.Text = "";

        if (Convert.ToBoolean(TipoTransaccionConfig(15)) == true)
        {
            List<CtransaccionAlmacen> listaTransaccion = null;

            try
            {
                listaTransaccion = (List<CtransaccionAlmacen>)Session["transaccion"];
                listaTransaccion.RemoveAt(e.RowIndex);

                this.gvLista.DataSource = listaTransaccion;
                this.gvLista.DataBind();

                TotalizaTransaccion();
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

            this.hdCantidad.Value = this.gvLista.SelectedRow.Cells[5].Text;
            this.hdRegistro.Value = this.gvLista.SelectedRow.Cells[17].Text;

            //this.Session["editar"] = true;



            if (this.ddlBodega.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                {
                    this.ddlBodega.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;
                }
            }

            if (this.ddlProducto.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                {
                    this.ddlProducto.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
                    this.txtProducto.Text = this.gvLista.SelectedRow.Cells[3].Text;
                }
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.numCantidad.ValorActual(Convert.ToDecimal(this.gvLista.SelectedRow.Cells[5].Text));
                this.Session["cant"] = Convert.ToDecimal(this.gvLista.SelectedRow.Cells[5].Text);
            }
            else
            {
                this.numCantidad.ValorActual(0);
            }

            if (this.ddlUmedida.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                {
                    this.ddlUmedida.SelectedValue = Convert.ToString(this.gvLista.SelectedRow.Cells[6].Text);
                }
                else
                {
                    this.ddlUmedida.SelectedValue = "";
                }
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                this.numValorUnitario.ValorActual(Convert.ToDecimal(this.gvLista.SelectedRow.Cells[7].Text));
            }
            else
            {
                this.numValorUnitario.ValorActual(0);
            }

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
            {
                this.numPiva.ValorActual(Convert.ToDecimal(this.gvLista.SelectedRow.Cells[9].Text));
            }
            else
            {
                this.numPiva.ValorActual(0);
            }

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
            {
                this.numRteFte.ValorActual(Convert.ToDecimal(this.gvLista.SelectedRow.Cells[10].Text));
            }
            else
            {
                this.numRteFte.ValorActual(0);
            }

            if (this.ddlDestino.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                {
                    this.ddlDestino.SelectedValue = Convert.ToString(this.gvLista.SelectedRow.Cells[11].Text);
                }
                else
                {
                    this.ddlDestino.SelectedValue = "";
                }
            }

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
                {
                    this.chkInversion.Checked = ((CheckBox)objControl).Checked;
                }
            }
            else
            {
                this.chkInversion.Checked = false;
            }

            if (this.gvLista.SelectedRow.Cells[13].Text != "&nbsp;")
            {
                this.ddlCcosto.SelectedValue = Convert.ToString(this.gvLista.SelectedRow.Cells[13].Text);
            }
            else
            {
                this.ddlCcosto.SelectedValue = "";
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.txtDetalle.Text = Server.HtmlDecode(Convert.ToString(this.gvLista.SelectedRow.Cells[4].Text));
            }
            else
            {
                this.txtDetalle.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
            {
                this.ddlCuenta.SelectedValue = Convert.ToString(this.gvLista.SelectedRow.Cells[10].Text);
            }
            else
            {
                this.ddlCuenta.SelectedValue = "";
            }

            List<CtransaccionAlmacen> listaTransaccion = null;

            listaTransaccion = (List<CtransaccionAlmacen>)this.Session["transaccion"];
            listaTransaccion.RemoveAt(this.gvLista.SelectedRow.RowIndex);

            this.gvLista.DataSource = listaTransaccion;
            this.gvLista.DataBind();

            TotalizaTransaccion();
            GetSaldo();
        }
        catch (Exception ex)
        {
            CcontrolesUsuario.MensajeError(
                "Error al cargar los campos del registro en el formulario. Correspondiente a: " + ex.Message,
                this.nilblInformacion);
        }
    }

    protected void lbRegistrar_Click(object sender, EventArgs e)
    {
        if (Convert.ToBoolean(TipoTransaccionConfig(15)) == true)
        {
            if (tipoTransaccion.RetornaReferenciaTipoTransaccion(
                Convert.ToString(this.ddlTipoDocumento.SelectedValue)) == 0)
            {
                Guardar();
            }
            else
            {
                GuardaReferencia();
            }
        }
        else
        {
            Editar();
        }
    }

    protected void niimbConsulta_Click(object sender, ImageClickEventArgs e)
    {                
        this.UpdatePanelRegistro.Visible = false;
        this.UpdatePanelDetalle.Visible = false;
        this.UpdatePanelEncabezado.Visible = false;
        this.UpdatePanelReferencia.Visible = false;
        this.UpdatePanelConsulta.Visible = true;
        
        this.niimbConsulta.BorderStyle = BorderStyle.None;
        this.niimbRegistro.BorderStyle = BorderStyle.Solid;
        this.niimbRegistro.BorderColor = System.Drawing.Color.White;
        this.niimbRegistro.BorderWidth = Unit.Pixel(1);
        this.niimbConsulta.Enabled = false;
        this.niimbRegistro.Enabled = true;

        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvTotal.DataSource = null;
        this.gvTotal.DataBind();
        this.gvReferencia.DataSource = null;
        this.gvReferencia.DataBind();
        this.gvSaldo.DataSource = null;
        this.gvSaldo.DataBind();
        this.lbImprimir.Visible = false;
        this.gvAjuste.DataSource = null;
        this.gvAjuste.DataBind();
    }

    protected void niimbRegistro_Click(object sender, ImageClickEventArgs e)
    {
        TabRegistro();
    }

    protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.ddlProducto.Focus();
        this.txtProducto.Text = this.ddlProducto.SelectedValue;

        if (Convert.ToBoolean(TipoTransaccionConfig(1)) == true && Convert.ToBoolean(TipoTransaccionConfig(12)) == false )
        {
            GetAjuste();
        }
        else
        {
            UmedidaProducto();
            GetSaldo();
        }
    }

    protected void lbImprimir_Click1(object sender, EventArgs e)
    {
        string impresion = "";

        impresion = "ImprimeTransaccion.aspx?tipoTransaccion=" + Convert.ToString(TipoTransaccionConfig(7)) + "&numero=" + this.Session["numero"].ToString();
        this.Response.Redirect(impresion);
    }

    protected void txtCantidad_DataBinding(object sender, EventArgs e)
    {
        ((TextBox)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((TextBox)sender).Text));
    }

    protected void txtValorUnitario_DataBinding(object sender, EventArgs e)
    {
        ((TextBox)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((TextBox)sender).Text));
    }

    protected void niddlTrnReferencia_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
                this.niddlTrnReferencia.Focus();

        try        
        {
           
                this.niddlBodega.DataSource = DvBodega();
                this.niddlBodega.DataValueField = "codigo";
                this.niddlBodega.DataTextField = "descripcion";
                this.niddlBodega.DataBind();

          
            

            this.nilblBodega.Visible = Convert.ToBoolean(TipoTransaccionConfig(12));
            this.niddlBodega.Visible = Convert.ToBoolean(TipoTransaccionConfig(12));
            this.gvReferencia.DataSource = tipoTransaccion.ExecReferenciaDetalle(
                Convert.ToString(TipoTransaccionConfig(8)),
                this.niddlTrnReferencia.SelectedValue);
            this.gvReferencia.DataBind();

            

            foreach (GridViewRow registro in this.gvReferencia.Rows)
            {
                ((TextBox)registro.FindControl("txtCantidad")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(9));
                ((TextBox)registro.FindControl("txtValorUnitario")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(10));
                ((TextBox)registro.FindControl("txtPiva")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(11));
                ((TextBox)registro.FindControl("txtPDes")).Enabled = Convert.ToBoolean(TipoTransaccionConfig(20));
            }


            //this.nitxtTotalValorTotal.Text = this.hdValorTotalRef.Value.ToString();
            //this.nitxtTotalValorNeto.Text = this.hdValorNetoRef.Value.ToString();

            TotalizaGrillaReferencia();
                                      
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar detalle de la transacción. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void txtProducto_TextChanged(object sender, EventArgs e)
    {
        try
        {
            DataView dvProducto = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("iCatalogo", "ppa"),
                "cadena");
            dvProducto.RowFilter = "codigo like '%" + this.txtProducto.Text.Trim() + "%' or descripcion like '%" +
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

    #endregion Eventos  

    #region MetodosEdicion

    private void BusquedaTransaccion()
    {
        try
        {
            if (this.gvParametros.Rows.Count > 0)
            {
                string where = operadores.FormatoWhere(
                    (List<Coperadores>)Session["operadores"]);

                this.gvTransaccion.DataSource = transacciones.GetTransaccionCompleta(
                    where);
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

    private void CargaCampos()
    {
        try
        {
            this.niddlCampo.DataSource = entidades.GetCamposEntidades(
                "iTransaccion",
                "");
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

    #endregion MetodosEdicion

    #region EventosEdicion

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

    protected void imbBusqueda_Click(object sender, ImageClickEventArgs e)
    {
        this.nilblMensajeEdicion.Text = "";

        BusquedaTransaccion();
    }

    protected void gvTransaccion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        decimal cantidad = 0;
        string bodega, cuenta, ccosto;
        this.nilblMensajeEdicion.Text = "";
        this.nilblInformacion.Text = "";
        this.Session["editar"] = true;
        this.Session["periodo"] = this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text;
        this.Session["transaccion"] = null;

        try
        {
            if (periodo.RetornaPeriodoCerrado(
                this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text) == 1)
            {
                ManejoError("Periodo cerrado. No es posible editar transacciones", "A");
                return;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al verificar periodo. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(
                this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text);

            if (tipoTransaccion.RetornaReferenciaTipoTransaccion(
                this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text) == 1)
            {
                this.nilblMensajeEdicion.Text = "Transacción con referencia no es posible su edición";
                return;
            }

            if (transacciones.VerificaEdicionBorrado(
                this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text,
                this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text) != 0)
            {
                this.nilblMensajeEdicion.Text = "Transacción ejecutada no es posible su edición";
                return;
            }

            CargarTipoTransaccion();
            CargaProductos();
            CargarCombos();

            UpdatePanelRegistro.Visible = true;

            CcontrolesUsuario.HabilitarControles(
                this.UpdatePanelRegistro.Controls);

            this.ddlTipoDocumento.SelectedValue = this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text;
            this.ddlTipoDocumento.Enabled = false;
            this.txtNumero.Text = this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text;
            this.txtNumero.Enabled = false;
            this.nilbNuevo.Visible = false;
            this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(
                this.ddlTipoDocumento.SelectedValue);

            CargaDestinos();

            CcontrolesUsuario.LimpiarControles(
                this.UpdatePanelEncabezado.Controls);

            CcontrolesUsuario.ComportamientoCampoEntidad(
                this.UpdatePanelEncabezado.Controls,
                "iTransaccion",
                Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                this.lbFecha);

            CcontrolesUsuario.LimpiarControles(
                this.UpdatePanelDetalle.Controls);

            CcontrolesUsuario.ComportamientoCampoEntidad(
                this.UpdatePanelDetalle.Controls,
                "iTransaccionDetalle",
                Convert.ToString(this.ddlTipoDocumento.SelectedValue),
                this.lbFecha);

            object[] objCab = new object[]{
                this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text,
                this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text};

            foreach (DataRowView encabezado in CentidadMetodos.EntidadGetKey(
                "iTransaccion",
                "ppa",
                objCab).Tables[0].DefaultView)
            {
                this.niCalendarFecha.SelectedDate = Convert.ToDateTime(encabezado.Row.ItemArray.GetValue(1));
                this.niCalendarFecha.Visible = false;
                this.txtFecha.Visible = true;
                this.txtFecha.Text = Convert.ToString(encabezado.Row.ItemArray.GetValue(1));
                this.txtObservacion.Text = Convert.ToString(encabezado.Row.ItemArray.GetValue(6));
                this.txtDocref.Text = Convert.ToString(encabezado.Row.ItemArray.GetValue(8));

                if (this.ddlTercero.Enabled == true)
                {
                    this.ddlTercero.SelectedValue = Convert.ToString(encabezado.Row.ItemArray.GetValue(7));
                }
            }

            foreach (DataRowView detalle in transacciones.SeleccionaiTransaccionDetalle(
                this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text,
                this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text))
            {
                
                cantidad = Convert.ToDecimal(detalle.Row.ItemArray.GetValue(6));

                if (detalle.Row.ItemArray.GetValue(8) == null)
                {
                    bodega = "";
                }
                else
                {
                    bodega = Convert.ToString(detalle.Row.ItemArray.GetValue(8));
                }

                if (detalle.Row.ItemArray.GetValue(19) == null)
                {
                    cuenta = "";
                }
                else
                {
                    cuenta = Convert.ToString(detalle.Row.ItemArray.GetValue(19));
                }

                if (detalle.Row.ItemArray.GetValue(18) == null)
                {
                    ccosto = "";
                }
                else
                {
                    ccosto = Convert.ToString(detalle.Row.ItemArray.GetValue(18));
                }

                
                
                transaccionAlmacen = new CtransaccionAlmacen(
                    Convert.ToString(detalle.Row.ItemArray.GetValue(8)),
                    Convert.ToString(detalle.Row.ItemArray.GetValue(4)),
                    cantidad,
                    Convert.ToString(detalle.Row.ItemArray.GetValue(7)),
                    Convert.ToDecimal(detalle.Row.ItemArray.GetValue(9)),
                    Convert.ToDecimal(detalle.Row.ItemArray.GetValue(15)),
                    cuenta,
                    Convert.ToString(detalle.Row.ItemArray.GetValue(16)),
                    Convert.ToBoolean(detalle.Row.ItemArray.GetValue(17)),
                    ccosto,
                    Convert.ToDecimal(detalle.Row.ItemArray.GetValue(10)),
                    Convert.ToDecimal(detalle.Row.ItemArray.GetValue(15)),
                    Convert.ToDecimal(detalle.Row.ItemArray.GetValue(14)),
                    Convert.ToString(detalle.Row.ItemArray.GetValue(25)),
                    Convert.ToInt16(detalle.Row.ItemArray.GetValue(3))
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
                this.btnRegistrar.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la transacción. Correspondiente a: " + ex.Message, "A");
        }

        TabRegistro();

        if (Convert.ToBoolean(TipoTransaccionConfig(15)) == true)
        {
            this.txtProducto.Visible = true;
            this.txtProducto.ReadOnly = false;
        }
    }

    protected void gvTransaccion_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.nilblMensajeEdicion.Text = "";

        using (TransactionScope ts = new TransactionScope())
        {
            try
            {
                if (transacciones.VerificaEdicionBorrado(
                    this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text,
                    this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text) != 0)
                {
                    this.nilblMensajeEdicion.Text = "Transacción ejecutada no es posible su edición";
                    return;
                }

                if (tipoTransaccion.RetornaTipoBorrado(
                    this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text) == "E")
                {
                    object[] objValores = new object[]{
                        Convert.ToString(this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text).Trim(),
                        Convert.ToString(this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text).Trim()
                    };

                    switch (CentidadMetodos.EntidadInsertUpdateDelete(
                        "iTransaccionDetalle",
                        "elimina",
                        "ppa",
                        objValores))
                    {
                        case 0:

                            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                "iTransaccion",
                                "elimina",
                                "ppa",
                                objValores))
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
                        this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text,
                        this.Session["usuario"].ToString().Trim()))
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

    #endregion EventosEdicion

    #region EventosReferencia

    protected void txtPiva_DataBinding(object sender, EventArgs e)
    {
        ((TextBox)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((TextBox)sender).Text.Trim()));
    }

    protected void txtPDes_DataBinding(object sender, EventArgs e)
    {
        ((TextBox)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((TextBox)sender).Text.Trim()));
    }

    protected void ddlTercero_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (Convert.ToBoolean(TipoTransaccionConfig(6)) == true)
            {
                this.niddlTrnReferencia.DataSource = tipoTransaccion.GetReferencia(
                    Convert.ToString(this.ddlTercero.SelectedValue),
                    Convert.ToString(this.ddlTipoDocumento.SelectedValue));
                this.niddlTrnReferencia.DataValueField = "numero";
                this.niddlTrnReferencia.DataTextField = "cadena";
                this.niddlTrnReferencia.DataBind();
                this.niddlTrnReferencia.Items.Insert(0, new ListItem("Seleccione una opción", ""));

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

    #endregion EventosReferencia

    protected void ddlDestino_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.ddlDestino.Visible == true)
        {
            if (destino.ConsultaMostrarCuenta(this.ddlDestino.SelectedValue, this.chkInversion.Checked) != 0)
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
            if (destino.ConsultaCuentaCentroCosto(this.ddlCuenta.SelectedValue) != 0)
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
            if (destino.ConsultaMostrarCuenta(this.ddlDestino.SelectedValue, this.chkInversion.Checked) != 0)
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

 
 
}
