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

public partial class Bascula_Poperaciones_RegistraDatosMPPP : System.Web.UI.Page
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
            "Registro Peso Materia Prima /n" +
            this.txtVehiculo.Text + " - " + this.txtRemolque.Text + "/n" +
            "Conductor - " + this.txtNombreConductor.Text + "/n" +
            "Producto - " + Convert.ToString(this.ddlProducto.SelectedValue) + "/n" +
            "Procedencia - " + Convert.ToString(this.ddlProcedencia.SelectedValue) + "/n" +
            "Peso Tara - " + this.txtPeso.Text + "/n" +
            "Peso Bruto - " + this.txtPesoBruto.Text + "/n" +
            "Peso Neto - " + this.txtPesoNeto.Text + ">");
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

    private void CargaCombos()
    {
        try
        {
            this.ddlProducto.DataSource = bascula.GetProductoTransaccion(
                this.Session["tipomovmp"].ToString(), Convert.ToInt16(this.Session["empresa"]));
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
            this.ddlProcedencia.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(
                CentidadMetodos.EntidadGet("bPRocedencia", "ppa"), "codigo", Convert.ToInt16(Session["empresa"]));
            this.ddlProcedencia.DataValueField = "codigo";
            this.ddlProcedencia.DataTextField = "codigo";
            this.ddlProcedencia.DataBind();
            this.ddlProcedencia.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar procedencias. Correspondiente a: " + ex.Message;
        }
    }

    private void Guardar()
    {

        string tiquete = "";
        string numero = "";
        string estado = "PP";
        DateTime fechaNeto = DateTime.Today;
        DateTime fechaTara = DateTime.Today;
        decimal pesoTara = 0;
        decimal pesoNeto = 0;

        try
        {
            if (this.lblTransaccion.Text.Length == 0 || this.txtVehiculo.Text.Length == 0 || this.txtIdConductor.Text.Length == 0 ||
                this.txtNombreConductor.Text.Length == 0 || Convert.ToString(this.ddlProducto.SelectedValue).Length == 0 ||
                Convert.ToString(this.ddlProcedencia.SelectedValue).Length == 0 || Convert.ToString(this.ddlFinca.SelectedValue).Length == 0 ||
                this.txtRacimos.Text.Length == 0 || this.txtPesoBruto.Text.Length == 0)
            {
                this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                return;
            }



            numero = tiposTransaccion.RetornaConsecutivo(
                this.Session["tipomovmp"].ToString(), Convert.ToInt16(Session["empresa"]));

            string codigoConductor = txtIdConductor.Text;
            string nombreConductor = txtNombreConductor.Text;

            if (codigoConductor.Trim().Length == 0)
            {
                codigoConductor = null;
                nombreConductor = null;

            }

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
                Convert.ToString(this.ddlFinca.SelectedValue),//@finca
                Convert.ToString(this.ddlProducto.SelectedValue),//@item
                nombreConductor,//@nombreConductor
                numero,//@numero
                  txtObservacion.Text,
                Convert.ToDecimal(this.txtPesoBruto.Text),//@pesoBruto
                0,//@pesoDescuento
                pesoNeto,//@pesoNeto
                0,//@pesoSacos
                pesoTara,//@pesoTara                
                Convert.ToString(this.ddlProcedencia.SelectedValue),//@procedencia
                Convert.ToDecimal(this.txtRacimos.Text),//@racimos
                this.Session["placamp"].ToString(),//@remision
                this.txtRemolque.Text,//@remolque
                0,//@sacos
                "",//@sellos
                null,//@tercero
                this.Session["tipomovmp"].ToString(),//@tipo
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
                switch (CentidadMetodos.EntidadInsertUpdateDelete("bRegistroBascula", "inserta", "ppa", objValores))
                {
                    case 0:

                        switch (tiposTransaccion.ActualizaConsecutivo(this.Session["tipomovmp"].ToString(), Convert.ToInt16(Session["empresa"])))
                        {
                            case 0:

                                if (tiquete.Trim().Length == 0)
                                {
                                    try
                                    {
                                        EnviarVideoGrabador();
                                    }
                                    catch
                                    {
                                    }

                                    ManejoExito();
                                    ts.Complete();
                                }
                                else
                                {
                                    switch (tiposTransaccion.ActualizaConsecutivo(
                                        ConfigurationManager.AppSettings["tipoTiquete"].ToString().Trim(), Convert.ToInt16(Session["empresa"])))
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

                                            string impresion = "ImprimeTiquete.aspx?tipoTiquete=tiqueteB&tiquete=" + tiquete;

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
            this.Session["tipomovmp"].ToString(), Convert.ToInt16(Session["empresa"]));
    }

    private void CargarDatosVehiculo()
    {
        try
        {
            this.txtPesoBruto.Text = Convert.ToString(this.Session["peso"]);
            this.txtFecha.Text = Convert.ToString(DateTime.Now);

            foreach (DataRowView registro in vehiculos.RetornaDatosVehiculoRemision(this.Session["placamp"].ToString(), Convert.ToInt16(Session["empresa"])))
            {
                this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
                this.txtIdConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(0));
                this.txtNombreConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(3));

                //if (vehiculos.GetVehiculosPropios(
                //    this.txtVehiculo.Text,
                //    "V").Count > 0 && parametros.RetornaValorParametro("destareAutomatico") == "1")
                //{
                //    this.txtPeso.Text = Convert.ToString(vehiculos.RetornaTaraVehiculoTipo(
                //        this.txtVehiculo.Text,
                //        "V") +
                //        vehiculos.RetornaTaraVehiculoTipo(
                //        this.txtRemolque.Text,
                //        "C"));

                //    this.txtPesoNeto.Text = Convert.ToString(
                //        Convert.ToDecimal(this.txtPesoBruto.Text) - Convert.ToDecimal(this.txtPeso.Text));

                //    if (Convert.ToDecimal(this.txtPesoNeto.Text) <= 0)
                //    {
                //        this.nilblInformacion.Text = "El peso Neto no puede ser negativo. Por favor corrija";
                //    }
                //}
                //else
                //{
                //    this.txtPeso.Text = "";
                //}
            }
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar los datos del vehículo seleccionado. Correspondiente a: " + ex.Message;
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
            if (this.Session["peso"] == null)
            {
                Response.Redirect("CapturaPesoDescargue.aspx");
            }

            if (!IsPostBack)
            {
                lblTipo.Text = ConfigurationManager.AppSettings["EntradaMateriaPrima"].ToString() + " Nro. ";
                CargarDatosVehiculo();
                RetornaConsecutivoTransaccion();
                CargaCombos();
            }
        }
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("CapturaPesoDescargue.aspx");
    }


    protected void ddlProcedencia_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.ddlProcedencia.Focus();

        try
        {
            this.ddlFinca.DataSource = bascula.GetFincasProcedencia(
                Convert.ToString(this.ddlProcedencia.SelectedValue), (int)this.Session["empresa"]);
            this.ddlFinca.DataValueField = "codigo";
            this.ddlFinca.DataTextField = "descripcion";
            this.ddlFinca.DataBind();
            this.ddlFinca.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar fincas - procedencia. Correspondiente a: " + ex.Message;
        }
    }

    protected void lbNuevoPeso_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("Entradas.aspx");
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("CapturaPesoMP.aspx");
    }

    #endregion Eventos

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();

    }


    protected void lbNuevoPeso_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Pesajes.aspx");
    }

}