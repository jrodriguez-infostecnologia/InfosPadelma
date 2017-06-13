using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nomina_Pliquidacion_PagosNomina : System.Web.UI.Page
{
    #region Instancias
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    
    Ctransacciones transacciones = new Ctransacciones();
    CformaPago formaPago = new CformaPago();
    Cperiodos periodo = new Cperiodos();
    CpagosNomina pagosNomina = new CpagosNomina();
    #endregion

    #region Metodos
    private void verificaSiCheques(DataView dv)
    {

    }

    private void liquidarInformacionPago()
    {   
      DataView dvLiquidacionPagos=pagosNomina.RetornaDatosDePagosxFormaPago(Convert.ToInt16(Session["empresa"]), ddlDocumento.SelectedValue.Trim(),
                Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue));
      int pagos = dvLiquidacionPagos.Count;

      List<string> formaPago = new List<string>();
      bool existe = true;

      foreach (DataRowView trv in dvLiquidacionPagos)
      {      

          for(int x=0;x<formaPago.Count;x++)
          {              
              if (trv.Row.ItemArray.GetValue(18).ToString().Trim() != formaPago[x])
              {
                  existe = false;
                  break;
              }
          }

          if (existe == false)
          {
              formaPago.Add(trv.Row.ItemArray.GetValue(18).ToString());
              existe = true;
          }
          
          if (formaPago.Count == 0)
          {
              formaPago.Add(trv.Row.ItemArray.GetValue(18).ToString());

          }
      }

      string cadena = " Usted va realizar la transacción de: " + "\\n \\n";

      List<int> contadores = new List<int>();

    
      for (int x = 0; x < formaPago.Count; x++)
      {
          int contador = 0;
          foreach (DataRowView trv in dvLiquidacionPagos)
          {
              if (trv.Row.ItemArray.GetValue(18).ToString() == formaPago[x])
              { 
                contador++;
              }
          }
          contadores.Add(contador);
      }
      for (int x = 0; x < formaPago.Count; x++)
      {
          cadena += contadores[x].ToString() + " pagos por " + formaPago[x] + "\\n \\n";
      }

        
        decimal total = 0;       
        foreach(DataRowView trv in dvLiquidacionPagos)  
        {
            total += Convert.ToDecimal(trv.Row.ItemArray.GetValue(9));
        }

        cadena += "Total: " + total.ToString()+"\\r \\n";
        txtValorPago.Text = total.ToString();
        ScriptManager.RegisterClientScriptBlock(this, this.GetType(), "Cargando datos..", "alert('"+cadena+"')", true);
    }

    private string cargarPlano()
    {
        string plano = "";
        try
        {
            foreach (DataRowView r in pagosNomina.GeneraPlanoPagoNominaDefenitiva(Convert.ToInt16(Session["empresa"]), ddlDocumento.SelectedValue
                 , Convert.ToInt32(ddlAño.SelectedValue), Convert.ToInt32(ddlPeriodo.SelectedValue))
                 )
            {
                plano += r.Row.ItemArray.GetValue(0).ToString().Trim() + "\r\n";
            }

            return plano;
        }
        catch (Exception ex)
        {
            ManejoError("Error al generar el plano debido a: " + ex.Message, "A");
            return "";
        }
    }

    private void manejoDocumento()
    {
        if (ddlAño.SelectedValue.Trim().Length > 0 & ddlPeriodo.SelectedValue.Trim().Length > 0)
        {
            ddlDocumento.DataSource = transacciones.SeleccionaDocumentosNominaxPeriodo(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()));
            ddlDocumento.DataValueField = "numero";
            ddlDocumento.DataTextField = "documento";
            ddlDocumento.DataBind();
            this.ddlDocumento.Items.Insert(0, new ListItem("", ""));
        }
        else
        {
            nilblInformacion.Text = "Debe seleccionar periodo y año valido";
            ddlDocumento.DataSource = null;
            ddlDocumento.DataBind();
        }
    }



    private void Guardar()
    {
        string operacion = "inserta";
        string periodo = "";
        string año = "";
        string numero = "''";

        this.Session["textoPlano"] = "";
        this.Session["periodoPagado"] = "";

        periodo = Convert.ToString(ddlPeriodo.SelectedValue);
        año = Convert.ToString( ddlAño.SelectedValue);
        numero = "'"+ddlDocumento.SelectedValue+"'";

        if (numero.Trim().Length==0)
            numero="''";
       

        try
        {


            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";

                object[] objValores = new object[]{                
                                 false,   // @anulado	bit
                              Convert.ToInt32(ddlAño.SelectedValue),  //@año	int
                                 ddlBanco.SelectedValue.Trim(),   //@Banco	varchar
                                 Convert.ToInt16(Session["empresa"]),   //@empresa	int
                                 Convert.ToDateTime(txtFecha.Text),//fecha
                                 null,   //@fechaAnualado	datetime
                                 DateTime.Now,   //@fechaRegistro	datetime
                                 0,   //@mes	nchar
                                 txtNoCheque.Text.Trim(),   //@NoChequeInicial	varchar
                                 txtNoCuenta.Text.Trim(),   //@noCuenta	varchar
                                 ddlDocumento.SelectedValue.Trim(),//@numero documento
                                 Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()),   //@periodoNomina	int
                                  Convert.ToInt32(this.Session["registro"]),  //@registro int
                                 ddlTipoCuenta.SelectedValue.Trim(),   //@TipoCuenta	varchar
                                 this.Session["usuario"].ToString(),   //@usuario	varchar
                                 null  ,//@usuarioAnulado	varchar
                              Convert.ToDecimal(txtValorPago.Text) //´@valorPago
            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "nPagosNomina",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:
                        this.Session["textoPlano"] = cargarPlano();
                        this.Session["periodoPagado"] = ddlAño.SelectedValue+ ddlPeriodo.SelectedValue.Trim();
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        break;

                    case 1:

                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }

            }
            else
            {

                if (pagosNomina.VerificaPeridoPagadoNomina(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlPeriodo.SelectedValue),
                   Convert.ToInt32(ddlAño.SelectedValue), ddlDocumento.SelectedValue) == 1)
                {
                    nilblInformacion.Text = "Este periodo ya se encuentra pago";
                    return;

                }

                object[] objValores = new object[]{                
                                 false,   // @anulado	bit
                              Convert.ToInt32(ddlAño.SelectedValue),  //@año	int
                                 ddlBanco.SelectedValue.Trim(),   //@Banco	varchar
                                 Convert.ToInt16(Session["empresa"]),   //@empresa	int
                                 Convert.ToDateTime(txtFecha.Text),//fecha
                                 null,   //@fechaAnualado	datetime
                                 DateTime.Now,   //@fechaRegistro	datetime
                                 0,   //@mes	nchar
                                 txtNoCheque.Text.Trim(),   //@NoChequeInicial	varchar
                                 txtNoCuenta.Text.Trim(),   //@noCuenta	varchar
                                 ddlDocumento.SelectedValue.Trim(),//@numero documento
                                 Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()),   //@periodoNomina	int
                                 0,  //@registro int
                                 ddlTipoCuenta.SelectedValue.Trim(),   //@TipoCuenta	varchar
                                 this.Session["usuario"].ToString(),   //@usuario	varchar
                                 null  ,//@usuarioAnulado	varchar
                              Convert.ToDecimal(txtValorPago.Text) //´@valorPago
            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "nPagosNomina",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:
                        this.Session["textoPlano"]= cargarPlano();
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        break;

                    case 1:

                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }

        if (this.Session["textoPlano"] != null)
        {
            string script = "<script language='javascript'>" +
                             "Visualizacion(" + Convert.ToString(this.Session["empresa"]) + "," + Convert.ToString(año) + "," + Convert.ToString(periodo) + ")" +
                              "</script>";
            Page.RegisterStartupScript("Visualizacion", script);

            string script2 = "<script language='javascript'>" +
                            "VisualizacionInforme('PagoNominaPeriodo',"+ Convert.ToString(año) + "," + Convert.ToString(periodo) + "," + numero + ")" +
                            "</script>";
            Page.RegisterStartupScript("VisualizacionInforme", script2);

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

            this.gvLista.DataSource = pagosNomina.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));// vacaciones.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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


    protected void cargarPeriodos()
    {
        try
        {
            this.ddlPeriodo.DataSource = periodo.PeriodosAbiertoNominaAño(Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
            this.ddlPeriodo.DataValueField = "noPeriodo";
            this.ddlPeriodo.DataTextField = "descripcion";
            this.ddlPeriodo.DataBind();
            this.ddlPeriodo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar periodo inicial. Correspondiente a: " + ex.Message, "C");
        }
    }
    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlAño.DataSource = periodo.PeriodoAñoAbiertoNomina(Convert.ToInt16(Session["empresa"]));
            this.ddlAño.DataValueField = "año";
            this.ddlAño.DataTextField = "año";
            this.ddlAño.DataBind();
            this.ddlAño.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }



        try
        {
            this.ddlBanco.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("gBanco", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlBanco.DataValueField = "codigo";
            this.ddlBanco.DataTextField = "descripcion";
            this.ddlBanco.DataBind();
            this.ddlBanco.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar bancos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTipoCuenta.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("gTipoCuenta", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlTipoCuenta.DataValueField = "codigo";
            this.ddlTipoCuenta.DataTextField = "descripcion";
            this.ddlTipoCuenta.DataBind();
            this.ddlTipoCuenta.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar bancos. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        GetEntidad();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

    }

    #endregion
    #region Eventos
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }


    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToString();
        this.txtFecha.Enabled = false;

        verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
             Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), Convert.ToInt16(Session["empresa"]), niCalendarFecha.SelectedDate);

    }
    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFecha.Text);
        }
        catch
        {

            nilblInformacion.Text = "Formato de fecha no valido";
            txtFecha.Text = "";
            txtFecha.Focus();
            return;

        }

        verificaPeriodoCerrado(Convert.ToInt32(this.niCalendarFecha.SelectedDate.Year),
       Convert.ToInt32(this.niCalendarFecha.SelectedDate.Month), Convert.ToInt16(Session["empresa"]), Convert.ToDateTime(txtFecha.Text));

    }

    private void verificaPeriodoCerrado(int año, int mes, int empresa, DateTime fecha)
    {
        if (periodo.RetornaPeriodoCerradoNomina(año, mes, empresa, fecha) == 1)
        {
            ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
        }

    }
    protected void ddlAño_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length > 0)
        {
            ddlDocumento.DataSource = null;
            ddlDocumento.DataBind();

            cargarPeriodos();
        }
    }
    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlDocumento.DataSource = null;
        ddlDocumento.DataBind();
      

        try
        {
           // liquidarInformacionPago();
            manejoDocumento();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar el documento debido a: " + ex.Message, "C");
        }
    }


    protected void ddlOpcionLiquidacion_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (ddlAño.SelectedValue.Trim().Length > 0 & ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlDocumento.SelectedValue.Trim().Length > 0)
            {
                ddlDocumento.DataSource = transacciones.SeleccionaDocumentosNominaxPeriodo(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue.Trim()));
                ddlDocumento.DataValueField = "numero";
                ddlDocumento.DataTextField = "documento";
                ddlDocumento.DataBind();
            }
            else
            {
                nilblInformacion.Text = "Debe seleccionar periodo y año valido";
                ddlDocumento.DataSource = null;
                ddlDocumento.DataBind();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar el documento debido a: " + ex.Message, "C");
        }
    }


    protected void lbPreLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlAño.SelectedValue.Trim().Length == 0 & ddlPeriodo.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar año y periodo valido";
            return;
        }

        if (ddlBanco.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar banco valido";
            return;
        }

    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(
              this.Session["usuario"].ToString(),
              ConfigurationManager.AppSettings["modulo"].ToString(),
              nombrePaginaActual(),
              "A",
              Convert.ToInt32(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

     

        try
        {

            this.Session["editar"] = true;
            bool anulado = false;
            foreach (Control c in gvLista.SelectedRow.Cells[9].Controls)
            {

                if (c is CheckBox)
                {
                    anulado = ((CheckBox)c).Checked;
                }
            }

            if (anulado == true)
            {
                nilblInformacion.Text = "Transaccion anulada no es posible su edición";
                return;
            }
            CcontrolesUsuario.HabilitarControles(
         this.Page.Controls);

            manejoNuevo();
            CargarCombos();

            foreach (DataRowView r in pagosNomina.RetornaDatosPagosNomina(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(gvLista.SelectedRow.Cells[5].Text),
                Convert.ToInt32(gvLista.SelectedRow.Cells[3].Text), Convert.ToInt32(gvLista.SelectedRow.Cells[4].Text), gvLista.SelectedRow.Cells[7].Text.Trim())
                )
            {

                if (r.Row.ItemArray.GetValue(1) != null)
                {
                    ddlAño.SelectedValue = r.Row.ItemArray.GetValue(1).ToString();
                    cargarPeriodos();
                    ddlAño.Enabled = false;
                }

                if (r.Row.ItemArray.GetValue(3) != null)
                {
                    ddlPeriodo.SelectedValue = r.Row.ItemArray.GetValue(3).ToString();
                    manejoDocumento();
                    ddlPeriodo.Enabled = false;

                }


                if (r.Row.ItemArray.GetValue(4) != null)
                {
                    this.Session["registro"] = r.Row.ItemArray.GetValue(4).ToString();
                }

                if (r.Row.ItemArray.GetValue(5) != null)
                {
                    ddlDocumento.SelectedValue = r.Row.ItemArray.GetValue(5).ToString().Trim();
                    ddlDocumento.Enabled = false;
                }

                if (r.Row.ItemArray.GetValue(6) != null)
                {
                    txtFecha.Text = Convert.ToDateTime(r.Row.ItemArray.GetValue(6).ToString()).ToShortDateString();
                }

                if (r.Row.ItemArray.GetValue(7) != null)
                {
                    ddlBanco.SelectedValue = r.Row.ItemArray.GetValue(7).ToString();
                }


                if (r.Row.ItemArray.GetValue(8) != null)
                {
                    ddlTipoCuenta.SelectedValue = r.Row.ItemArray.GetValue(8).ToString();
                }


                if (r.Row.ItemArray.GetValue(9) != null)
                {
                    txtNoCuenta.Text = r.Row.ItemArray.GetValue(9).ToString();
                }

                if (r.Row.ItemArray.GetValue(10) != null)
                {
                    txtNoCheque.Text = r.Row.ItemArray.GetValue(10).ToString();
                }

                if (r.Row.ItemArray.GetValue(16) != null)
                {
                    txtValorPago.Text = decimal.Round(Convert.ToDecimal(r.Row.ItemArray.GetValue(16).ToString()),0).ToString();
                }

            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al editar la transacción debido a :  " + ex.Message, "A");
        }


    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
             this.Session["usuario"].ToString(),
             ConfigurationManager.AppSettings["modulo"].ToString(),
             nombrePaginaActual(),
             "E",
             Convert.ToInt32(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        try
        {
            switch (pagosNomina.AnulaPeridoPagadoNomina(
                Convert.ToInt16(Session["empresa"]),
              Convert.ToInt32(gvLista.Rows[e.RowIndex].Cells[5].Text),
              Convert.ToInt32(gvLista.Rows[e.RowIndex].Cells[3].Text),
                this.Session["usuario"].ToString(),
                gvLista.Rows[e.RowIndex].Cells[7].Text
              ))
            {
                case 0:
                    ManejoExito("Pago anulado satisfactoriamente", "A");
                    break;
                case 1:
                    ManejoError("Error al anular Pago", "A");
                    break;
            }

        }
        catch (Exception ex) { 
            ManejoError("Erro al anular registro debido a:  "+ex.Message,"A");

        }

    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
	  gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        this.Session["textoPlano"] = null;
        gvLista.DataSource = null;
        gvLista.DataBind();
        GetEntidad();

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
        this.Session["editar"] = null;
        this.Session["registro"] = null;
        this.Session["textoPlano"] = null;
        CargarCombos();
        manejoNuevo();

    }

    private void manejoNuevo()
    {
        lblCheque.Visible = false;
        txtNoCheque.Visible = false;
        ddlAño.Enabled = true;
        ddlPeriodo.Enabled = true;
        ddlDocumento.Enabled = true;
        txtValorPago.Enabled = false;
        ddlDocumento.Enabled = true;
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        ddlPeriodo.DataSource = null;
        ddlPeriodo.DataBind();
        ddlAño.DataSource = null;
        ddlAño.DataBind();

    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        if (ddlAño.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Seleccione un año valido";
            return;
        }

        if (txtFecha.Text.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe ingresar una fecha";
        }


        if (ddlBanco.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un banco  valido";
            return;
        }

        if (ddlTipoCuenta.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un tipo de cuenta  valido";
            return;
        }

        if (txtNoCheque.Visible == true & txtNoCheque.Text.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un numero de inicio de cheque valido";
            return;
        }

        if (ddlDocumento.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un numero de documento valido valido";
            return;
        }

        DataView dvLiquidacionPagos = pagosNomina.RetornaDatosDePagosxFormaPago(Convert.ToInt16(Session["empresa"]), ddlDocumento.SelectedValue.Trim(),
            Convert.ToInt32(ddlAño.SelectedValue.Trim()), Convert.ToInt32(ddlPeriodo.SelectedValue));
        int pagos = dvLiquidacionPagos.Count;

        bool verificaCheques = false;

        foreach (DataRowView trv in dvLiquidacionPagos)
        {
            if (formaPago.VerificaChequeFormaPago(Convert.ToInt16(Session["empresa"]), trv.Row.ItemArray.GetValue(18).ToString()) == 1)
            {
                verificaCheques = true;
            }
        }

        if (verificaCheques == true & txtNoCheque.Visible == false)
        {
            lblCheque.Visible = true;
            txtNoCheque.Visible = true;
            nilblInformacion.Text = "Hay transacciones con cheque por favor ingrese el no inicial del cheque a pagar";
            return;
        }
      
        Guardar();


    }




    protected void txtNoCheque_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDecimal(txtNoCheque.Text);
        }
        catch
        {
            nilblInformacion.Text = "No de cheque no valido";
            txtNoCheque.Text = "0";
            return;
        }

    }

    protected void ddlDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {

            if (ddlAño.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un año valido";
                ddlAño.Focus();

                return;
            }

            if (ddlPeriodo.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un periodo de nomina valido";
                ddlPeriodo.Focus();

                return;
            }

            if (txtFecha.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una fecha valida";
                txtFecha.Focus();

                return;
            }

            liquidarInformacionPago();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la forma de pago debido a: " + ex.Message, "C");
        }

    }

    #endregion




    
}