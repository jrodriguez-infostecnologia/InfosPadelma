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

public partial class Bascula_Poperaciones_RegistraDatoPesajeSP : System.Web.UI.Page
{
    Cvehiculos vehiculos = new Cvehiculos();
    CPeso peso = new CPeso();
    CtipoTransaccion tiposTransaccion = new CtipoTransaccion();
    Cbascula bascula = new Cbascula();
    CCom com = new CCom();

    private void EnviarVideoGrabador()
    {
        SerialPort puerto = com.CrearPuerto();

        com.AbrirPuerto(puerto);
        com.EnviarTrama(
                puerto,
                "< Sistema de Bascula " + Convert.ToString(DateTime.Now) + ". \n" +
                "Registro Peso Pesaje \n" +
                this.ddlVehiculo.SelectedValue + " - " + this.txtRemolque.Text + "\n" +
                "Producto - " + this.txtProducto.Text + "\n" +
                "Peso Tara - " + this.txtPesoTara.Text + "\n" +
                "Peso Bruto - " + this.txtPeso.Text + "\n" +
                "Peso Neto - " + this.txtPesoNeto.Text + ">");
        com.CerrarPuerto(puerto);
    }
    private void Guardar()
    {
        string tiquete = "";

        this.nilblInformacion.Text = "";

        try
        {
            tiquete = tiposTransaccion.RetornaConsecutivo(
                ConfigurationManager.AppSettings["tipoTiquete"].ToString(), (int)this.Session["empresa"]);

            using (TransactionScope ts = new TransactionScope())
            {
                switch (bascula.ActualizaBasculaPes(
                    this.Session["tipomovpes"].ToString(),
                    this.txtTransaccion.Text,
                    Convert.ToDecimal(this.txtPeso.Text),
                    Convert.ToDecimal(this.txtPesoNeto.Text),
                    tiquete,
                    (int)this.Session["empresa"]))
                {
                    case 0:

                        switch (tiposTransaccion.ActualizaConsecutivo(
                             ConfigurationManager.AppSettings["tipoTiquete"].ToString(),
                             (int)this.Session["empresa"]))
                        {
                            case 0:

                                //try
                                //{
                                //    EnviarVideoGrabador();
                                //}
                                //catch
                                //{
                                //}

                                this.lbCancelar.Visible = false;
                                this.lbRegistrar.Visible = false;
                                this.lbNuevoPeso.Visible = true;
                                this.nilblInformacion.Text = "Tiquete registrado satisfactoriamente";
                                ts.Complete();

                                /*string script = "<script language='javascript'>" +
                                    "Print('" + tiquete + "');" +
                                    "</script>";

                                Page.RegisterStartupScript("Print", script);*/

                                string impresion = "ImprimeTiquete.aspx?tipoTiquete=tiqueteP&tiquete=" + tiquete + "&empresa=" + Session["empresa"].ToString();

                                this.Response.Redirect(impresion);
                                break;

                            case 1:

                                this.nilblInformacion.Text = "Error al actualizar consecutivo. Operación no realizada";
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
    private void CargarDatosVehiculo()
    {
        try
        {
            this.nilblInformacion.Text = "";

            foreach (DataRowView registro in vehiculos.GetVehiculosSegundoPesajePesPlaca(
                this.Session["tipomovpes"].ToString(),
                Convert.ToString(this.ddlVehiculo.SelectedValue),
                (int)this.Session["empresa"]))
            {
                this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                this.txtProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
                this.txtPesoTara.Text = Convert.ToString(registro.Row.ItemArray.GetValue(3));
                this.txtDesProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(6));
                this.txtTransaccion.Text = Convert.ToString(registro.Row.ItemArray.GetValue(0));
            }

            this.txtFecha.Text = DateTime.Now.ToString();
            this.txtPeso.Text = Convert.ToString(this.Session["peso"]);

            double pesoNeto = peso.CalculaPesoNeto(
                Convert.ToDouble(this.txtPesoTara.Text),
                Convert.ToDouble(this.txtPeso.Text));

            if (pesoNeto == 0)
            {
                this.nilblInformacion.Text = "El peso bruto no puede ser igual o menor que el peso tara del vehículo";
                this.lbRegistrar.Visible = false;
            }
            else
            {
                this.lbRegistrar.Visible = true;
                this.txtPesoNeto.Text = Convert.ToString(pesoNeto);
                
            }
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar los datos para el segundo pesaje. Correspondiente a: " + ex.Message;
        }
    }

    private void GetVehiculos()
    {
        try
        {
            this.ddlVehiculo.DataSource = vehiculos.GetVehiculosSegundoPesajePes(
                this.Session["tipomovpes"].ToString(), (int)this.Session["empresa"]);
            this.ddlVehiculo.DataValueField = "vehiculo";
            this.ddlVehiculo.DataTextField = "vehiculo";
            this.ddlVehiculo.DataBind();
            this.ddlVehiculo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar los vahículos para realizar el segundo pesaje " + ex.Message;
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
                GetVehiculos();
            }
        }
    }

    protected void ddlVehiculo_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarDatosVehiculo();
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