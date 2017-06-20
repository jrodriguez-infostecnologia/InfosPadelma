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
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Security.Principal;
using System.Transactions;

public partial class Administracion_Caracterizacion : System.Web.UI.Page
{
    #region Instancias

    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Ctransaccion transacciones = new Ctransaccion();
    Cdestinos destinos = new Cdestinos();
    Cperiodos periodos = new Cperiodos();
    Cdestinos destino = new Cdestinos();

    #endregion Instancias

    #region Metodos


    private void CargarCuenta()
    {
        try
        {
            this.ddlCuenta.DataSource = destino.CuentasAuxiliares(this.ddlDestino.SelectedValue, this.chkInversion.Checked);
            this.ddlCuenta.DataValueField = "codigo";
            this.ddlCuenta.DataTextField = "descripcion";
            this.ddlCuenta.DataBind();
            this.ddlCuenta.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar proveedores habilitados para orden directa. Correspondiente a: " + ex.Message;
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
            this.lblMensaje.Text ="Error al cargar unidades de medida. Correspondiente a: " + ex.Message;
        }
    }


    private void CargaPeriodos()
    {
        try
        {
            this.ddlPeriodo.DataSource = periodos.GetPeriodosActivos();
            this.ddlPeriodo.DataValueField = "periodo";
            this.ddlPeriodo.DataTextField = "periodo";
            this.ddlPeriodo.DataBind();
            this.ddlPeriodo.SelectedValue = DateTime.Today.Year.ToString() + DateTime.Today.Month.ToString().PadLeft(2, '0');
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar periodos correspondiente a: " + ex.Message;
        }
    }

    public DataView DvDestino()
    {
        try
        {
            DataView dvDestino = destinos.GetDestinoNivel(
                2);
            dvDestino.Sort = "descripcion";

            return dvDestino;
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar destinos. Correspondiente a: " + ex.Message;

            return null;
        }
    }

    private void GetEntidad()
    {        
        try
        {
		 this.gvLista.Visible = true;
            this.gvLista.DataSource = transacciones.GetSalidasEdicion(
                Convert.ToString(this.ddlTipoTransaccion.SelectedValue),
                this.niCalendarFechaInicial.SelectedDate,
                this.niCalendarFechaFinal.SelectedDate);
            this.gvLista.DataBind();

            //foreach (GridViewRow registro in this.gvLista.Rows)
            //{
            //    ((DropDownList)registro.FindControl("ddlDestino")).SelectedValue = transacciones.RetornaDestinoDetalle(
            //        registro.Cells[1].Text,
            //        registro.Cells[3].Text);
            //}
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar salidas. Correspondiente a: " + ex.Message;
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
            this.lblMensaje.Text ="Error al recuperar posición de configuración de tipo de transacción. Correspondiente a: " + ex.Message;

            return null;
        }
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
            this.lblMensaje.Text ="Error al cargar destinos. Correspondiente a: " + ex.Message;
        }
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlTipoTransaccion.DataSource = tipoTransaccion.GetTipoTransaccionModulo();
            this.ddlTipoTransaccion.DataValueField = "codigo";
            this.ddlTipoTransaccion.DataTextField = "descripcion";
            this.ddlTipoTransaccion.DataBind();
            this.ddlTipoTransaccion.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar periodos. Correspondiente a: " + ex.Message;
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
            if (Cseguridad.VerificaAccesoPagina(
                this.Session["usuario"].ToString(),
                System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString(),
                "EditarSalidas.aspx") != 0)
            {
                if (!IsPostBack)
                {
                    CargarCombos();
                }
            }
            else
            {
                this.lblMensaje.Text = "Usuario no autorizado para ingresar a esta página";
            }
        }
    }

    
    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaInicial.Visible = true;
        this.txtFechaInicial.Visible = false;
        this.niCalendarFechaInicial.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaInicial.Visible = false;
        this.txtFechaInicial.Visible = true;
        this.txtFechaInicial.Text = this.niCalendarFechaInicial.SelectedDate.ToString();
        this.txtFechaInicial.Enabled = false;
    }

    protected void lbFechaFinal_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaFinal.Visible = true;
        this.txtFechaFinal.Visible = false;
        this.niCalendarFechaFinal.SelectedDate = Convert.ToDateTime(null);
    }

    protected void niCalendarFechaFinal_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaFinal.Visible = false;
        this.txtFechaFinal.Visible = true;
        this.txtFechaFinal.Text = this.niCalendarFechaFinal.SelectedDate.ToString();
        this.txtFechaFinal.Enabled = false;
    }

    protected void imbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        this.lblMensaje.Text = "";
        this.lblPeriodo.Visible = false;
        this.ddlPeriodo.Visible = false;
        this.imbContabilizar.Visible = false;
        this.gvLista.Visible = false;

        GetEntidad();
        this.lbtnEditar.Visible = true;
    }

    protected void lbContabilizaSalidas_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        CargaPeriodos();

        this.lblPeriodo.Visible = true;
        this.ddlPeriodo.Visible = true;
        this.imbContabilizar.Visible = true;
    }

    protected void imbContabilizar_Click(object sender, ImageClickEventArgs e)
    {
        this.lblMensaje.Text = "";

        try
        {
            transacciones.ContabilizaAlmacen(
                this.ddlPeriodo.SelectedValue);

            this.lblPeriodo.Visible = false;
            this.ddlPeriodo.Visible = false;
            this.imbContabilizar.Visible = false;

            this.lblMensaje.Text = "Salidas contabilizadas correctamente";
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al contabilizar salidas de almacén. Correspondiente a: " + ex.Message;
        }
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        this.gvLista.PageIndex = e.NewPageIndex;

        GetEntidad();
    }

    #endregion Eventos       
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
    protected void lbtnEditar_Click(object sender, EventArgs e)
    {
        this.lbFechaFinal.Visible = false;
        this.lbFechaInicial.Visible = false;
        this.niCalendarFechaFinal.Visible = false;
        this.niCalendarFechaInicial.Visible = false;
        this.Label1.Visible = false;
        this.ddlTipoTransaccion.Visible = false;
        this.imbBuscar.Visible = false;
        this.txtFechaFinal.Visible = false;
        this.txtFechaInicial.Visible = false;
        this.lblDestino.Visible = true;
        this.ddlDestino.Visible = true;
        this.chkInversion.Visible = true;
        this.lbContabilizaSalidas.Visible = false;
        this.lbtnEditar.Visible = false;
        this.lbGuardar.Visible = true;
        this.lbCancelar.Visible = true;
        this.txtDetalle.Visible = true;
        this.lblDetalle.Visible = true;
        CargaDestinos();

    }
    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        this.lbFechaFinal.Visible = true;
        this.lbFechaInicial.Visible = true;
        this.niCalendarFechaFinal.Visible = false;
        this.niCalendarFechaInicial.Visible = false;
        this.Label1.Visible = true;
        this.ddlTipoTransaccion.Visible = true;
        this.imbBuscar.Visible = true;
        //this.txtFechaFinal.Visible = false;
        //this.txtFechaInicial.Visible = false;
        this.lblDestino.Visible = false;
        this.ddlDestino.Visible = false;
        this.chkInversion.Visible = false;
        this.lblDetalle.Visible = false;
        this.lblDetalle.Visible = false;
        this.lblCuenta.Visible = false;
        this.lblCcosto.Visible = false;
        this.ddlCcosto.Visible = false;
        this.ddlCuenta.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvLista.Visible = false;
        this.lbContabilizaSalidas.Visible = true;
        this.lbtnEditar.Visible = false;
        this.lbGuardar.Visible = false;
        this.lbCancelar.Visible = false;
        this.txtDetalle.Visible = false;
        this.lblDetalle.Visible = false;
    }
 
    protected void ddlTipoTransaccion_SelectedIndexChanged1(object sender, EventArgs e)
    {
        this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(
               this.ddlTipoTransaccion.SelectedValue);

    }

    protected void lbGuardar_Click(object sender, EventArgs e)
    {

        guardar();
    }

    void guardar()
    {
        this.lblMensaje.Text = "";
        bool verificacionCK = false;
        bool verificacion = false;
        string cuenta, destinoSalida, ccosto;

        if (Convert.ToString(this.ddlDestino.SelectedValue).Trim().Length == 0 )
        {
            this.lblMensaje.Text = "Campos vacios en el encabezado. Por favor corrija";
            return;
        }

        if (this.ddlCuenta.Visible == true)
        {
            if (destino.ValidaCuentaMayor(this.ddlCuenta.SelectedValue) != 0)
            {
                this.lblMensaje.Text = "Debe seleccionar una cuenta Auxiliar";
                return;

            }
        }

        using (TransactionScope ts = new TransactionScope())
        {
            foreach (GridViewRow registro in this.gvLista.Rows)
            {
                if (((CheckBox)registro.FindControl("chkSeleccion")).Checked == true)
                {
                    verificacionCK = true;
                }
            }

            if (verificacionCK == false)
            {
                this.lblMensaje.Text = "Debe seleccionar al menos un producto para guardar la transacción";
                return;
            }

            destinoSalida = this.ddlDestino.SelectedValue;

            if (this.ddlCuenta.SelectedValue.Length == 0)
            {
                cuenta = null;
            }
            else
            {
                cuenta = this.ddlCuenta.SelectedValue;
            }

            if (this.ddlCcosto.SelectedValue.Length == 0)
            {
                ccosto = null;
            }
            else
            {
                ccosto = this.ddlCcosto.SelectedValue;
            }


            foreach (GridViewRow registro in this.gvLista.Rows)
            {
                if (((CheckBox)registro.FindControl("chkSeleccion")).Checked == true)
                {

                    switch (transacciones.ActualizaDestinoSalidas(
                                registro.Cells[1].Text,
                                registro.Cells[3].Text,
                                destinoSalida,
                                this.chkInversion.Checked,  
                                this.txtDetalle.Text,
                                Convert.ToInt16(registro.Cells[11].Text),
                                cuenta,
                                ccosto))
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

            if (verificacion == false)
            {
                this.lblMensaje.Text = "Error al insertar el detalle de la transacción. Operación no realizada";
                return;
            }

           this.lblMensaje.Text = "Transacción registrada satisfactoriamente.";
            ts.Complete();
            this.lbFechaFinal.Visible = true;
            this.lbFechaInicial.Visible = true;
            this.niCalendarFechaFinal.Visible = false;
            this.niCalendarFechaInicial.Visible = false;
            this.Label1.Visible = true;
            this.ddlTipoTransaccion.Visible = true;
            this.imbBuscar.Visible = true;
            //this.txtFechaFinal.Visible = false;
            //this.txtFechaInicial.Visible = false;
            this.lblDestino.Visible = false;
            this.ddlDestino.Visible = false;
            this.chkInversion.Visible = false;
            this.lblDetalle.Visible = false;
            this.lblDetalle.Visible = false;
            this.lblCuenta.Visible = false;
            this.lblCcosto.Visible = false;
            this.ddlCcosto.Visible = false;
            this.ddlCuenta.Visible = false;
            this.gvLista.DataSource = null;
            this.gvLista.DataBind();
            this.gvLista.Visible = false;
            this.lbContabilizaSalidas.Visible = true;
            this.lbtnEditar.Visible = false;
            this.lbGuardar.Visible = false;
            this.lbCancelar.Visible = false;
            this.txtDetalle.Visible = false;
            this.lblDetalle.Visible = false;

           
        }
    
    }
}
