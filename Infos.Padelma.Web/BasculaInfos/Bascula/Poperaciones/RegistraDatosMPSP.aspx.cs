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

public partial class Bascula_Poperaciones_RegistraDatosMP : System.Web.UI.Page
{

    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    CPeso peso = new CPeso();
    Cvehiculos vehiculos = new Cvehiculos();
    CtipoTransaccion tiposTransaccion = new CtipoTransaccion();
    Cbascula bascula = new Cbascula();
    Cparametros parametros = new Cparametros();
    CCom com = new CCom();

    #endregion Instancias

    #region Metodos


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
                switch (bascula.ActualizaBasculaMp(
                    this.Session["tipomovmp"].ToString(),
                    this.txtTransaccion.Text,
                    Convert.ToDecimal(this.txtPesoTara.Text),
                    Convert.ToDecimal(this.txtPesoNeto.Text),
                    tiquete,
                    (int)this.Session["empresa"]))
                {
                    case 0:

                        switch (tiposTransaccion.ActualizaConsecutivo(
                              ConfigurationManager.AppSettings["tipoTiquete"].ToString(), (int)this.Session["empresa"]))
                        {
                            case 0:

                                try
                                {
                                    EnviarVideoGrabador();
                                }
                                catch
                                {
                                }

                                this.lbCancelar.Visible = false;
                                this.lbRegistrar.Visible = false;
                                this.lbNuevoPeso.Visible = true;
                                this.nilblInformacion.Text = "Tiquete registrado satisfactoriamente";

                                ts.Complete();

                                string impresion = "ImprimeTiquete.aspx?tipoTiquete=tiqueteB&tiquete=" + tiquete+ "&empresa=" + Session["empresa"].ToString();

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


    private void EnviarVideoGrabador()
    {
        SerialPort puerto = com.CrearPuerto();

        com.AbrirPuerto(puerto);
        com.EnviarTrama(
            puerto,
            "< Sistema de Bascula " + Convert.ToString(DateTime.Now) + ". \n" +
            "Registro Peso Materia Prima \n" +
            this.txtVehiculo.Text + " - " + this.txtRemolque.Text + "\n" +
            "Producto - " + this.txtDesProducto.Text + "\n" +
            "Peso Tara - " + this.txtPesoTara.Text + "\n" +
            "Peso Bruto - " + this.txtPesoBruto.Text + "\n" +
            "Peso Neto - " + this.txtPesoNeto.Text + ">");
        com.CerrarPuerto(puerto);
    }



    private void CargarDatosVehiculo()
    {
        try
        {
            foreach (DataRowView registro in vehiculos.GetBasculaRemision(
                this.Session["placamp"].ToString(), (int)this.Session["empresa"]))
            {
                this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(15));
                this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(16));
                this.txtProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(17));
                this.txtDesProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(34));
                this.txtPesoBruto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(6));
                this.txtTransaccion.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
            }

            this.txtFecha.Text = DateTime.Now.ToString();
            this.txtPesoTara.Text = Convert.ToString(this.Session["peso"]);

            double pesoNeto = peso.CalculaPesoNeto(
                Convert.ToDouble(this.txtPesoTara.Text),
                Convert.ToDouble(this.txtPesoBruto.Text));

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
            this.nilblInformacion.Text = "Error al cargar los datos de logística del vehículo seleccionado. Correspondiente a: " + ex.Message;
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
                Response.Redirect("CapturaPesoMP.aspx");
            }

            if (!IsPostBack)
            {

                CargarDatosVehiculo();
            }
        }

    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("CapturaPesoDescargue.aspx");
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
        Response.Redirect("MateriaPrima.aspx");
    }
}