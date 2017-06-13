using System;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;

public partial class Administracion_Poperacion_Despachos : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cbascula bascula = new Cbascula();
    CtiposTransaccion tipoTransaccion = new CtiposTransaccion();

    #endregion Instancias

    #region Metodos

    private void CargarCombos()
    {
        try
        {
            this.ddlProducto.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("iItems", "ppa"),
                "descripcion", (int)this.Session["empresa"]);
            this.ddlProducto.DataValueField = "codigo";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();
            this.ddlProducto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar productos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlCliente.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet(
                "cTercero", "ppa"), "razonSocial", "cliente", Convert.ToInt16(Session["empresa"]));
            this.ddlCliente.DataValueField = "id";
            this.ddlCliente.DataTextField = "razonSocial";
            this.ddlCliente.DataBind();
            this.ddlCliente.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar clientes. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            DataView comercializadora = CcontrolesUsuario.OrdenarEntidad(
                     CentidadMetodos.EntidadGet("cTercero", "ppa"),
                     "descripcion",
                     (int)this.Session["empresa"]);
            comercializadora.RowFilter = "accionista=1";
            this.ddlComercializadora.DataSource = comercializadora;
            this.ddlComercializadora.DataValueField = "id";
            this.ddlComercializadora.DataTextField = "razonSocial";
            this.ddlComercializadora.DataBind();
            this.ddlComercializadora.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar comercializadoras. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPlanta.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet(
                "cTercero", "ppa"), "razonSocial", "extractora", Convert.ToInt16(Session["empresa"]));
            this.ddlPlanta.DataValueField = "id";
            this.ddlPlanta.DataTextField = "razonSocial";
            this.ddlPlanta.DataBind();
            this.ddlPlanta.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar plantas. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
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

                 this.gvLista.DataSource = bascula.GetBasculaTiquete(
                this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));

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


        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);


        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void Guardar()
    {
        string nuevoDespacho = "", tipo = "";

        this.nilblMensaje.Text = "";
        try
        {
            switch (Convert.ToString(this.ddlOperación.SelectedValue))
            {
                case "0":

                    if (bascula.AnulaDespacho(
                        this.gvLista.SelectedRow.Cells[1].Text, (int)this.Session["empresa"]) == 0)
                    {
                        ManejoExito("Despacho anulado satisfactoriamente", "E");
                    }
                    else
                    {
                        this.nilblMensaje.Text = "Error al anular el despacho. Operación no realizada";
                    }
                    break;

                case "1":

                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 ||
                        this.txtRemision.Text.Trim().Length == 0 ||
                        this.txtVehiculo.Text.Trim().Length == 0 ||
                        this.txtRemolque.Text.Trim().Length == 0 ||
                        Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlCliente.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlLugarEntrega.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlComercializadora.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlPlanta.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    tipo = rblTipoImpresion.SelectedValue;

                    if (bascula.AnulaCreaDespacho(
                        this.CalendarFechaProceso.SelectedDate,
                        tipo,
                        "",
                        this.txtRemision.Text.Trim(),
                        "",
                        this.txtVehiculo.Text.Trim(),
                        this.txtRemolque.Text.Trim(),
                        Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlCliente.SelectedValue),
                        Convert.ToString(this.ddlLugarEntrega.SelectedValue),
                        Convert.ToString(this.ddlComercializadora.SelectedValue),
                        Convert.ToString(this.ddlPlanta.SelectedValue),
                        Convert.ToString(this.gvLista.SelectedRow.Cells[1].Text),
                        out nuevoDespacho,(int)this.Session["empresa"]) == 0)
                    {
                        ManejoExito("Despacho creado satisfactoriamente con la remisión " + nuevoDespacho, "I");
                    }
                    else
                    {
                        this.nilblInformacion.Text = "Error al crear el nuevo despacho. Operación no realizada";
                    }
                    break;

                case "2":

                    if (Convert.ToString(this.CalendarFechaProceso.SelectedDate).Trim().Length == 0 ||
                        this.txtVehiculo.Text.Trim().Length == 0 ||
                        this.txtRemolque.Text.Trim().Length == 0 ||
                        Convert.ToString(this.ddlProducto.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlCliente.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlLugarEntrega.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlComercializadora.SelectedValue).Trim().Length == 0 ||
                        Convert.ToString(this.ddlPlanta.SelectedValue).Trim().Length == 0)
                    {
                        this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
                        return;
                    }

                    if (bascula.ModificaDespacho(
                        this.CalendarFechaProceso.SelectedDate,
                        this.txtRemision.Text.Trim(),
                        "",
                        this.txtVehiculo.Text.Trim(),
                        this.txtRemolque.Text.Trim(),
                        Convert.ToString(this.ddlProducto.SelectedValue),
                        Convert.ToString(this.ddlCliente.SelectedValue),
                        Convert.ToString(this.ddlLugarEntrega.SelectedValue),
                        Convert.ToString(this.ddlComercializadora.SelectedValue),
                        Convert.ToString(this.ddlPlanta.SelectedValue),
                        Convert.ToString(this.gvLista.SelectedRow.Cells[1].Text),(int)this.Session["empresa"]) == 0)
                    {
                        
                        ManejoExito("Despacho modificado satisfactoriamente.", "I");
                    }
                    else
                    {
                        this.nilblInformacion.Text = "Error al modificar el despacho. Operación no realizada";
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
            this.rblTipoImpresion.Visible=false;


    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
          this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilblInformacion.Text = "";
        this.ddlOperación.SelectedValue = "0";
        this.ddlProducto.SelectedValue = "";
        this.ddlCliente.SelectedValue = "";
        this.ddlLugarEntrega.SelectedValue = "";
        this.lblPesoNeto.Text = "";

        rblTipoImpresion.Visible = false;


        GetEntidad();
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

        //foreach (Control objControl in this.numPesoBruto.Controls)
        //{
        //    if (objControl is TextBox)
        //    {
        //        objControl.Focus();
        //    }
        //}
    }

    private void CargaLugarEntrega()
    {
        try
        {
            this.ddlLugarEntrega.DataSource = bascula.GetLugarEntregaCliente(
                Convert.ToString(this.ddlCliente.SelectedValue),
                (int)this.Session["empresa"]);
            this.ddlLugarEntrega.DataValueField = "codigo";
            this.ddlLugarEntrega.DataTextField = "descripcion";
            this.ddlLugarEntrega.DataBind();
            this.ddlLugarEntrega.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar lugares de entrega. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void ddlOperación_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblMensaje.Text = "";
        this.lbFechaProceso.Focus();
        this.txtRemision.Enabled = false;
        this.nilblMensaje.Text = "";
        this.lbFechaProceso.Focus();

        try
        {
            switch (Convert.ToString(((DropDownList)sender).SelectedValue))
            {

                case "0":

                    this.nilblInformacion.Text = "";
                    this.ddlOperación.SelectedValue = "0";
                    this.ddlProducto.SelectedValue = "";
                    this.ddlCliente.SelectedValue = "";
                    this.ddlLugarEntrega.SelectedValue = "";
                    this.lblPesoNeto.Text = "";
                  
                    rblTipoImpresion.Visible = false;
                   
                    break;

                case "1":

                    CargarCombos();

                    foreach (DataRowView registro in bascula.GetDespachoTiquete(
                        this.gvLista.SelectedRow.Cells[1].Text, (int)this.Session["empresa"]))
                    {
                        this.ddlCliente.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(14));

                        CargaLugarEntrega();
                        this.ddlLugarEntrega.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(15));
                        this.CalendarFechaProceso.SelectedDate = Convert.ToDateTime(registro.Row.ItemArray.GetValue(5));
                        this.txtFechaProceso.Text = Convert.ToString(registro.Row.ItemArray.GetValue(5));
                        this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(9));
                        this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(10));
                        this.ddlProducto.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(12));
                        this.lblPesoNeto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(11));
                        this.ddlComercializadora.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(16));
                        this.ddlPlanta.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(17));
                        this.txtRemision.Text = Convert.ToString(registro.Row.ItemArray.GetValue(7));                   
                        this.rblTipoImpresion.Visible = true;
                        rblTipoImpresion.Visible = true;

                    }
                  
                        break;

                default:

                    CargarCombos();

                    foreach (DataRowView registro in bascula.GetDespachoTiquete(
                        this.gvLista.SelectedRow.Cells[1].Text, (int)this.Session["empresa"]))
                    {
                        this.ddlCliente.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(14));

                        CargaLugarEntrega();

                        this.ddlLugarEntrega.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(15));
                        this.CalendarFechaProceso.SelectedDate = Convert.ToDateTime(registro.Row.ItemArray.GetValue(5));
                        this.txtFechaProceso.Text = Convert.ToString(registro.Row.ItemArray.GetValue(5));
                        this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(9));
                        this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(10));
                        this.ddlProducto.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(12));
                        this.lblPesoNeto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(11));
                        this.ddlComercializadora.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(16));
                        this.ddlPlanta.SelectedValue = Convert.ToString(registro.Row.ItemArray.GetValue(17));
                        this.txtRemision.Text = Convert.ToString(registro.Row.ItemArray.GetValue(7));     
               
                        rblTipoImpresion.Visible = false;
                       
                    }

                  
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar datos del tiquete. Correspondiente a: " + ex.Message, "C");
        }
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

        this.lbRegistrar.Visible = true;
        this.lbCancelar.Visible = true;

        this.nilblMensaje.Text = "";
    }

    protected void ddlProcedencia_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargaLugarEntrega();
    }
}
