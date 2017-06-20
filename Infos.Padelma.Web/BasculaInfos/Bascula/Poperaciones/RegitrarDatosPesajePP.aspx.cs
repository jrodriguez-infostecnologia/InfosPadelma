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
            "Peso Tara - " + this.txtPeso.Text + "/n" +
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
        DateTime fechaNeto = DateTime.Today;
        DateTime fechaTara = DateTime.Today;
        decimal pesoTara = 0;
        decimal pesoNeto = 0;

        try
        {
            if (this.lblTransaccion.Text.Length == 0 ||
                this.txtNombreConductor.Text.Length == 0 ||
                Convert.ToString(this.ddlProducto.SelectedValue).Length == 0 ||
                Convert.ToString(this.ddlTercero.SelectedValue).Length == 0 ||
                this.txtPesoBruto.Text.Length == 0)
            {
                this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                return;
            }

            if (this.chkPropio.Checked == true)
            {
                if (Convert.ToString(this.ddlVehiculo.SelectedValue).Trim().Length == 0 ||
                    Convert.ToString(this.ddlRemolque.SelectedValue).Trim().Length == 0)
                {
                    this.nilblInformacion.Text = "Debe seleccionar los datos del vehículo. Por favor corrija";
                    return;
                }

                if (this.txtPeso.Text.Length == 0 || this.txtPesoNeto.Text.Length == 0)
                {
                    this.nilblInformacion.Text = "Campos de peso vacio. Por favor corrija";
                    return;
                }
                else
                {
                    if (Convert.ToDecimal(this.txtPesoNeto.Text) <= 0)
                    {
                        this.nilblInformacion.Text = "El peso Neto no puede ser negativo o igual a cero. Por favor corrija";
                        return;
                    }
                    else
                    {
                        tiquete = tiposTransaccion.RetornaConsecutivo(
                        ConfigurationManager.AppSettings["tipoTiquete"].ToString(), (int)this.Session["empresa"]);

                        fechaNeto = DateTime.Now;
                        fechaTara = DateTime.Now;
                        pesoTara = Convert.ToDecimal(this.txtPeso.Text);
                        pesoNeto = Convert.ToDecimal(this.txtPesoNeto.Text);
                        estado = "SP";
                        vehiculo = Convert.ToString(this.ddlVehiculo.SelectedValue);
                        remolque = Convert.ToString(this.ddlRemolque.SelectedValue);
                    }
                }
            }
            else
            {
                if (this.txtVehiculo.Text.Trim().Length == 0 || this.txtRemolque.Text.Trim().Length == 0)
                {
                    this.nilblInformacion.Text = "Debe seleccionar los datos del vehículo. Por favor corrija";
                    return;
                }

                vehiculo = this.txtVehiculo.Text;
                remolque = this.txtRemolque.Text;
                pesoTara = Convert.ToDecimal(this.txtPeso.Text);
                pesoNeto = 0;
            }

            numero = tiposTransaccion.RetornaConsecutivo(
                this.Session["tipomovpes"].ToString(), (int)this.Session["empresa"]);

            string codigoConductor = txtIdConductor.Text;
            string nombreConductor = txtNombreConductor.Text;

            if (codigoConductor.Trim().Length == 0)
            {
                codigoConductor = null;
                nombreConductor = null;

            }

            object[] objValores = new object[]{
                 0,
                "",
                codigoConductor,
                null,
                "",
                estado,
                DateTime.Now,
                DateTime.Now,
                fechaNeto,
                DateTime.Now,
                fechaTara,
                this.Session["usuario"].ToString(),
                "",
                numero,
                pesoTara,
                Convert.ToDecimal(this.txtPesoBruto.Text),
                pesoNeto,
                0,
                Convert.ToString(this.ddlTercero.SelectedValue),
                Convert.ToString(this.ddlProducto.SelectedValue),
                0,
                "",
                remolque,
                0,
                "",
                "",
                this.Session["tipomovpes"].ToString(),
                "",
                tiquete,
                "",
                vehiculo
            
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
                            this.Session["tipomovpes"].ToString(), (int)this.Session["empresa"]))
                        {
                            case 0:

                                if (tiquete.Trim().Length == 0)
                                {
                                    object[] objConductor = new object[]{
                                        this.txtIdConductor.Text,
                                        this.txtNombreConductor.Text,
                                        numero,
                                        this.Session["tipomovpes"].ToString()};

                                    switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                        "bRegistroBasculaConductorPesaje",
                                        "inserta",
                                        "ppa",
                                        objConductor))
                                    {
                                        case 0:

                                            ManejoExito();
                                            ts.Complete();
                                            break;

                                        case 1:

                                            this.nilblInformacion.Text = "Error al registrar el conductor. operación no realizada";
                                            break;
                                    }
                                }
                                else
                                {
                                    switch (tiposTransaccion.ActualizaConsecutivo(
                                       ConfigurationManager.AppSettings["tipoTiquete"].ToString().Trim(), (int)this.Session["empresa"]))
                                    {
                                        case 0:

                                            object[] objConductor = new object[]{
                                                this.txtIdConductor.Text,
                                                this.txtNombreConductor.Text,
                                                numero,
                                                this.Session["tipomovpes"].ToString()};

                                            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                                "bRegistroBasculaConductorPesaje",
                                                "inserta",
                                                "ppa",
                                                objConductor))
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

                                                    /*string script = "<script language='javascript'>" +
                                                        "Print('" + tiquete + "');" +
                                                        "</script>";

                                                    Page.RegisterStartupScript("Print", script);*/

                                                    string impresion = "ImprimeTiquete.aspx?tipoTiquete=tiqueteP&tiquete=" + tiquete;

                                                    this.Response.Redirect(impresion);

                                                    break;

                                                case 1:

                                                    this.nilblInformacion.Text = "Error al insertar conductor. Operación no realizada";
                                                    break;
                                            }
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
            this.ddlRemolque.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al seleccionar remolques propios. Correpondiente a: " + ex.Message;
        }
    }


    private void CargarDatosVehiculo()
    {
        try
        {
            this.txtPeso.Text = Convert.ToString(this.Session["peso"]);
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
            this.ddlProducto.Items.Insert(0, new ListItem("Seleccione una opción", ""));
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
            this.ddlTercero.Items.Insert(0, new ListItem("Seleccione una opción", ""));
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
                this.txtPeso.Text = "0";
                this.txtPesoBruto.Text = "0";
                this.txtPesoNeto.Text = "0";
            }
            lblTipoTra.Text = ConfigurationManager.AppSettings["Pesaje"].ToString();

            CargarDatosVehiculo();
            RetornaConsecutivoTransaccion();
            CargaCombos();

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
            this.txtPesoBruto.Text = Convert.ToString(this.Session["peso"]);
            this.txtPeso.Text = "0";
            this.txtPesoNeto.Text = "0";

            CargaVehiculosPropios();
        }
        else
        {
            this.txtVehiculo.Visible = true;
            this.txtRemolque.Visible = true;
            this.ddlVehiculo.Visible = false;
            this.ddlRemolque.Visible = false;
            this.txtPeso.Text = Convert.ToString(this.Session["peso"]);
            this.txtPesoBruto.Text = "0";
            this.txtPesoNeto.Text = "0";
        }
    }
    protected void txtIdConductor_TextChanged(object sender, EventArgs e)
    {

        this.nilblInformacion.Text = "";

        if (this.chkPropio.Checked == true)
        {
            if (vehiculos.GetConductoresPropios(
                this.txtIdConductor.Text,
                1, (int)this.Session["empresa"]).Count == 0)
            {
                this.txtIdConductor.Text = "";
                this.txtNombreConductor.Text = "";
                this.txtIdConductor.Focus();
                this.nilblInformacion.Text = "El conductor seleccionado, no corresponde a un vehiculo propio.";
                return;
            }
            else
            {
                this.txtNombreConductor.Enabled = true;

                foreach (DataRowView registro in vehiculos.GetConductoresPropios(
                    this.txtIdConductor.Text,
                    1, (int)this.Session["empresa"]))
                {
                    this.txtNombreConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                }
            }
        }
        else
        {
            this.txtNombreConductor.Enabled = true;
            this.txtNombreConductor.Text = "";
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