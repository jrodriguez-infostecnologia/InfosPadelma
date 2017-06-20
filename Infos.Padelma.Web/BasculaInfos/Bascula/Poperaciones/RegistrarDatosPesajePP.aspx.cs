using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO.Ports;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bascula_Poperaciones_RegitrarDatosPesajePP : System.Web.UI.Page
{
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    Cvehiculos vehiculos = new Cvehiculos();
    CtipoTransaccion tiposTransaccion = new CtipoTransaccion();
    Cbascula bascula = new Cbascula();
    CCom com = new CCom();

    private void EnviarVideoGrabador()
    {
        SerialPort puerto = com.CrearPuerto();

        com.AbrirPuerto(puerto);
        com.EnviarTrama(
            puerto,
            "< Sistema de Báscula " + Convert.ToString(DateTime.Now) + ". /n" +
            "Registro Peso Pesaje /n" +
            this.txtVehiculo.Text + Convert.ToString(this.ddlVehiculo.SelectedValue) + " - " +
                this.txtRemolque.Text + Convert.ToString(this.ddlRemolque.SelectedValue) + "/n" +
            "Conductor - " + this.txtNombreConductor.Text + "/n" +
            "Producto - " + Convert.ToString(this.ddlProducto.SelectedValue) + "/n" +
            "Peso Tara - " + this.txtPesoTara.Text + "/n" +
            "Peso Bruto - " + this.txtPesoBruto.Text + "/n" +
            "Peso Neto - " + this.txtPesoNeto.Text + ">");
        com.CerrarPuerto(puerto);
    }

    private void Guardar()
    {
        string tiquete = "";
        string numero = "";
        string estado = "PP";
        string vehiculo = "";
        string remolque = "";
        DateTime fechaNeto = DateTime.Now;
        DateTime fechaTara = DateTime.Now;
        decimal pesoTara = 0;
        decimal pesoNeto = 0;
        string codigoConductor = "", nombreConductor = "";

        try
        {


            if (this.chkPropio.Checked == true)
            {
                if (this.lblTransaccion.Text.Length == 0 ||
                Convert.ToString(this.ddlProducto.SelectedValue).Length == 0 ||
                Convert.ToString(this.ddlTercero.SelectedValue).Length == 0 ||
                this.txtPesoBruto.Text.Length == 0 || ddlConductor.SelectedValue.Trim().Length==0)
                {
                    this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                    return;
                }

                if (Convert.ToString(this.ddlVehiculo.SelectedValue).Trim().Length == 0 ||
                    Convert.ToString(this.ddlRemolque.SelectedValue).Trim().Length == 0)
                {
                    this.nilblInformacion.Text = "Debe seleccionar los datos del vehículo. Por favor corrija";
                    return;
                }

                if (this.txtPesoTara.Text.Length == 0 )
                {
                    this.nilblInformacion.Text = "Campos de peso vacio. Por favor corrija";
                    return;
                }

                codigoConductor = ddlConductor.SelectedValue;
                nombreConductor = ddlConductor.SelectedItem.ToString();
                vehiculo = ddlVehiculo.SelectedValue;
                remolque = ddlRemolque.SelectedValue;
                pesoTara = Convert.ToDecimal(this.txtPesoTara.Text);
                pesoNeto = 0;
             
            }
            else
            {
                if (this.txtVehiculo.Text.Trim().Length == 0 || this.txtRemolque.Text.Trim().Length == 0 || txtIdConductor.Text.Trim().Length ==0 ||  txtNombreConductor.Text.Trim().Length ==0)
                {
                    this.nilblInformacion.Text = "Campos de peso vacio. Por favor corrija";
                    return;
                }

                vehiculo = this.txtVehiculo.Text;
                remolque = this.txtRemolque.Text;
                pesoTara = Convert.ToDecimal(this.txtPesoTara.Text);
                pesoNeto = 0;
                codigoConductor = txtIdConductor.Text;
                    nombreConductor = txtNombreConductor.Text;
            }

            numero = tiposTransaccion.RetornaConsecutivo(
                this.Session["tipomovpes"].ToString(), (int)this.Session["empresa"]);


            object[] objValores = new object[]{
                0,//@analisisRegistrado
                null,//@bodega
                codigoConductor,//@codigoConductor
                Convert.ToInt16(Session["empresa"]),//@empresa
                estado,//@estado
                DateTime.Now,//@fecha
                DateTime.Now,//@fechaBruto
                fechaNeto,//@fechaNeto
                DateTime.Now,//@fechaProceso
                fechaTara,//@fechaTara
                null,//@finca
                ddlProducto.SelectedValue,//@item
                nombreConductor,//@nombreConductor
                numero,//@numero
                txtObservacion.Text,
                Convert.ToDecimal(this.txtPesoBruto.Text),//@pesoBruto                
                0,//@pesoDescuento
                pesoNeto,//@pesoNeto
                0,//@pesoSacos
                pesoTara,//@pesoTara
                null,//@procedencia
                0,//@racimos
                "",//@remision
                remolque,//@remolque
                0,//@sacos
                "",//@sellos
                ddlTercero.SelectedValue.Trim(),//@tercero
                this.Session["tipomovpes"].ToString(),//@tipo
                null,//@tipoDescargue
                null,//@tipoVehiculo
                tiquete,//@tiquete
                null,//@urlTiquete
                Convert.ToString(Session["usuario"]),//@usuario
                vehiculo,//@vehiculo
                chkPropio.Checked //VehiculoInterno
            };


            using (TransactionScope ts = new TransactionScope())
            {
                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "bRegistroBascula",
                    "inserta",
                    "ppa",
                    objValores))
                {
                    case 0:

                        switch (tiposTransaccion.ActualizaConsecutivo(
                            this.Session["tipomovpes"].ToString(),(int)this.Session["empresa"]))
                        {
                            case 0:

                                if (tiquete.Trim().Length == 0)
                                {
                                            ManejoExito();
                                            ts.Complete();
                                }
                                else
                                {
                                    switch (tiposTransaccion.ActualizaConsecutivo(
                                      ConfigurationManager.AppSettings["tipoTiquete"].ToString().Trim(),(int)this.Session["empresa"]))
                                    {
                                        case 0:
                                                    ManejoExito();
                                                    ts.Complete();

                                                    /*string script = "<script language='javascript'>" +
                                                        "Print('" + tiquete + "');" +
                                                        "</script>";

                                                    Page.RegisterStartupScript("Print", script);*/

                                                    string impresion = "ImprimeTiquete.aspx?tipoTiquete=tiqueteP&tiquete=" + tiquete;

                                                    this.Response.Redirect(impresion);

                                                    break;

                                                case 1:

                                                    this.nilblInformacion.Text = "Error al actualizar consecutivo de tiquete. Operación no realizada";
                                                    break;
                                            }
                                         
                                                                            
                                    }
                                break;

                                case 1:
                                this.nilblInformacion.Text = "Error al actualizar consecutivo de transacción. Operación no realizada";
                                        break;
                                }
                                break;

                            case 1:

                                this.nilblInformacion.Text = "Error al guardar el registro. Operación no realizada";
                                break;
                        }
                       
            
                }
            
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al guardar el registro. Correspondiente a: " + ex.Message;
        }
    }

    private void ManejoExito()
    {
        this.nilblInformacion.Text = "Registro insertado satisfactoriamente";
        this.lbRegistrar.Visible = false;
        this.lbNuevoPeso.Visible = true;
    }
    private void CargaVehiculosPropios()
    {
        try
        {
            this.ddlVehiculo.DataSource = vehiculos.GetVehiculosPropiosTipo(
                "V", (int)this.Session["empresa"]);
            this.ddlVehiculo.DataValueField = "codigo";
            this.ddlVehiculo.DataTextField = "descripcion";
            this.ddlVehiculo.DataBind();
            this.ddlVehiculo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al seleccionar vehículos propios. Correpondiente a: " + ex.Message;
        }

        try
        {
            this.ddlRemolque.DataSource = vehiculos.GetVehiculosPropiosTipo(
                "C", (int)this.Session["empresa"]);
            this.ddlRemolque.DataValueField = "codigo";
            this.ddlRemolque.DataTextField = "codigo";
            this.ddlRemolque.DataBind();
            this.ddlRemolque.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al seleccionar remolques propios. Correpondiente a: " + ex.Message;
        }

        try
        {
            DataView conductor = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
               "nFuncionario", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            conductor.RowFilter = "conductor=True";
            ddlConductor.DataSource = conductor;
            this.ddlConductor.DataValueField = "id";
            this.ddlConductor.DataTextField = "descripcion";
            this.ddlConductor.DataBind();
            this.ddlConductor.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
           this.nilblInformacion.Text = "Error al cargar  conductor. Correspondiente a: " + ex.Message;
        }
    }


    private void CargarDatosVehiculo()
    {
        try
        {
            this.txtPesoTara.Text = Convert.ToString(this.Session["peso"]);
            this.txtFecha.Text = Convert.ToString(DateTime.Now);
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar los datos de la transación seleccionada. Correspondiente a: " + ex.Message;
        }
    }

    private void RetornaConsecutivoTransaccion()
    {
        this.lblTransaccion.Text = tiposTransaccion.RetornaConsecutivo(
            this.Session["tipomovpes"].ToString(), (int)this.Session["empresa"]);
    }



    private void CargaCombos()
    {
        try
        {
            this.ddlProducto.DataSource = bascula.GetProductoTransaccion(
                this.Session["tipomovpes"].ToString(), (int)this.Session["empresa"]);
            this.ddlProducto.DataValueField = "producto";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();
            this.ddlProducto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar productos. Correspondiente a: " + ex.Message;
        }

        try
        {
            DataView terceros = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "cTercero", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));


            this.ddlTercero.DataSource = terceros;
            this.ddlTercero.DataValueField = "codigo";
            this.ddlTercero.DataTextField = "razonSocial";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar terceros. Correspondiente a: " + ex.Message;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (this.Session["peso"] == null)
            {
                Response.Redirect("CapturaPesoDescargue.aspx");
            }

            if (!IsPostBack)
            {
                this.txtPesoTara.Text = "0";
                this.txtPesoBruto.Text = "0";
                this.txtPesoNeto.Text = "0";
                CargarDatosVehiculo();
                RetornaConsecutivoTransaccion();
                CargaCombos();
                lblTipoTra.Text = ConfigurationManager.AppSettings["Pesaje"].ToString();

            }


            this.txtVehiculo.Focus();
        }

    }
    protected void chkPropio_CheckedChanged(object sender, EventArgs e)
    {
        if (((CheckBox)sender).Checked == true)
        {
            this.txtVehiculo.Visible = false;
            this.txtRemolque.Visible = false;
            this.ddlVehiculo.Visible = true;
            this.ddlRemolque.Visible = true;
            this.ddlConductor.Visible = true;
            this.lblCedula.Visible = false;
          //  this.txtPesoBruto.Text = Convert.ToString(this.Session["peso"]);
           // this.txtPeso.Text = "0";
           // this.txtPesoNeto.Text = "0";
            txtIdConductor.Visible = false;
            txtNombreConductor.Visible = false;

            CargaVehiculosPropios();
        }
        else
        {
            this.txtVehiculo.Visible = true;
            this.txtRemolque.Visible = true;
            this.ddlVehiculo.Visible = false;
            this.ddlRemolque.Visible = false;
            this.ddlConductor.Visible = false;
            this.lblCedula.Visible = true;
           // this.txtPeso.Text = Convert.ToString(this.Session["peso"]);
            //this.txtPesoBruto.Text = "0";
            //this.txtPesoNeto.Text = "0";
            txtIdConductor.Visible = true;
            txtNombreConductor.Visible = true;
        }
    }
    protected void txtIdConductor_TextChanged(object sender, EventArgs e)
    {

        this.nilblInformacion.Text = "";
        this.nilblInformacion.Text = "";

        try
        {
           
            this.txtNombreConductor.Text = vehiculos.RetornaNombreConductorBascula(
                this.txtIdConductor.Text, Convert.ToInt16(Session["empresa"]));
           
        }
        catch (Exception ex)
        {
            nilblInformacion.Text = "Error al retornar nombre de conductor debido a:  " + ex.Message;
        }
        
       
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("Pesajes.aspx");
    }
    protected void lbNuevoPeso_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("Pesajes.aspx");
    }
}