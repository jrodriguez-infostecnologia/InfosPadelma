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
using System.IO.Ports;

public partial class Bascula_Poperaciones_RegistraDatosDPTPP : System.Web.UI.Page
{

    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();

    Cvehiculos vehiculos = new Cvehiculos();
    CtipoTransaccion tiposTransaccion = new CtipoTransaccion();
    Cbascula bascula = new Cbascula();
    Cparametros parametros = new Cparametros();
    CCom com = new CCom();

    #endregion Instancias


    #region Metodos

    private void EnviarVideoGrabador()
    {
        SerialPort puerto = com.CrearPuerto();

        com.AbrirPuerto(puerto);
        com.EnviarTrama(
            puerto,
            "< Sistema de Báscula " + Convert.ToString(DateTime.Now) + ". /n" +
            "Registro Peso Despacho /n" +
            this.txtVehiculo.Text + " - " + this.txtRemolque.Text + "/n" +
            "Conductor - " + this.txtNombreConductor.Text + "/n" +
            "Producto - " + this.txtProducto.Text + "/n" +
            "Peso Tara - " + this.txtPeso.Text + ">");
        com.CerrarPuerto(puerto);
    }

    private void ManejoExito()
    {
        this.nilblInformacion.Text = "Registro insertado satisfactoriamente";
        this.lbRegistrar.Visible = false;

        if (vehiculos.GetVehiculosPropios(this.txtVehiculo.Text, "V", Convert.ToInt16(Session["empresa"])).Count > 0)
        {
            this.lbNuevoPeso.Visible = true;
            lbCancelar.Visible = false;
        }
        else
        {
            this.lbNuevoPeso.Visible = true;
            lbCancelar.Visible = false;
        }
    }

    private void Guardar()
    {
        bool verificacion = false;
        string tiquete = "";
        string numero = "";
        string estado = "PP";
        DateTime fechaNeto = DateTime.Today;
        DateTime fechaBruto = DateTime.Today;
        decimal pesoBruto = 0;
        decimal pesoNeto = 0;

        try
        {
            if (this.lblTransaccion.Text.Length == 0 || this.txtVehiculo.Text.Length == 0 || this.txtIdConductor.Text.Length == 0 ||
                this.txtNombreConductor.Text.Length == 0 || this.txtProducto.Text.Length == 0 ||
                this.txtPeso.Text.Length == 0)
            {
                this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                return;
            }

            numero = tiposTransaccion.RetornaConsecutivo(this.Session["tipomov"].ToString(), Convert.ToInt16(Session["empresa"]));


            object[] objValores = new object[]{
                0,//@analisisRegistrado
                null,//@bodega
                txtIdConductor.Text,//@codigoConductor
                Convert.ToInt16(Session["empresa"]),//@empresa
                estado,//@estado
                DateTime.Now,//@fecha
                fechaBruto,//@fechaBruto
                fechaNeto,//@fechaNeto
                DateTime.Now,//@fechaProceso
                DateTime.Now,//@fechaTara
                null,//@finca
                txtProducto.Text,//@item
                txtNombreConductor.Text,//@nombreConductor
                numero,//@numero
                txtObservacion.Text,
                pesoBruto,//@pesoBruto
                0,//@pesoDescuento
                pesoNeto,//@pesoNeto
                0,//@pesoSacos
                 Convert.ToDecimal(this.txtPeso.Text),//@pesoTara
                null,//@procedencia
                0,//@racimos
                this.Session["placa"].ToString(),//@remision
                this.txtRemolque.Text,//@remolque
                0,//@sacos
                "",//@sellos
                null,//@tercero
                this.Session["tipomov"].ToString(),//@tipo
                null,//@tipoDescargue
                null,//@tipoVehiculo
                tiquete,//@tiquete
                null,//@urlTiquete
                Convert.ToString(Session["usuario"]),//@usuario
                this.txtVehiculo.Text,//@vehiculo,
                false //@vehiculoInterno
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
                            this.Session["tipomov"].ToString(), Convert.ToInt16(Session["empresa"])))
                        {
                            case 0:

                                switch (vehiculos.CambiaEstadoCarnet(Convert.ToString(this.Session["carnet"]), "U", Convert.ToInt16(Session["empresa"])))
                                {
                                    case 0:

                                        switch (vehiculos.ActualizaNumeroEstadoLogistica(this.Session["placa"].ToString(), numero, "PP", Convert.ToInt16(Session["empresa"])))
                                        {
                                            case 0:

                                                try
                                                {
                                                    EnviarVideoGrabador();
                                                }
                                                catch
                                                {
                                                }

                                                ManejoExito();
                                                ts.Complete();
                                                break;

                                            case 1:

                                                this.nilblInformacion.Text = "Error al actualizar el estado de logística. Operación no realizada";
                                                break;
                                        }
                                        break;

                                    case 1:

                                        this.nilblInformacion.Text = "Error al actualizar el estado del carnet. Operación no realizada";
                                        break;
                                }
                                break;

                            case 1:

                                this.nilblInformacion.Text = "Error al actualizar consecutivo de transacción. Operación no realizada";
                                break;
                        }
                        break;

                    case 1:

                        this.nilblInformacion.Text = "Error al insertar el registro. operación no realizada";
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al guardar el registro. Correspondiente a: " + ex.Message;
        }
    }

    private void RetornaConsecutivoTransaccion()
    {
        this.lblTransaccion.Text = tiposTransaccion.RetornaConsecutivo(
            this.Session["tipomov"].ToString(), Convert.ToInt16(Session["empresa"]));
    }

    private void CargarDatosVehiculo()
    {
        try
        {
            foreach (DataRowView registro in vehiculos.GetProgramacionDespachos(Convert.ToString(this.Session["placa"]), Convert.ToInt16(Session["empresa"])))
            {
                this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(5));
                this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(11));
                this.txtIdConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(7));
                this.txtNombreConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(8));
                this.txtProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(12));
                this.lblObservaciones.Text = Convert.ToString(registro.Row.ItemArray.GetValue(16));
                txtProductoNombre.Text = Convert.ToString(registro.Row.ItemArray.GetValue(23));
                this.txtPeso.Text = Convert.ToString(this.Session["peso"]);
                this.txtFecha.Text = DateTime.Now.ToString();
            }
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar los datos de logística del vehículo seleccionado. Correspondiente a: " + ex.Message;
        }
    }

    #endregion Metodos



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
                Response.Redirect("CapturaPesoDPT.aspx");
            }

            if (!IsPostBack)
            {
                CargarDatosVehiculo();
                RetornaConsecutivoTransaccion();
            }
        }
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }
    protected void lbNuevoPeso_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("Despachos.aspx");
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("CapturaPesoDPT.aspx");
    }
}