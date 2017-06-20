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

public partial class Bascula_Poperaciones_RegistraDatosDPTSP : System.Web.UI.Page
{

    #region Instancias

    Cvehiculos vehiculos = new Cvehiculos();
    CtipoTransaccion tiposTransaccion = new CtipoTransaccion();
    CPeso peso = new CPeso();
    Cbascula bascula = new Cbascula();
    CCom com = new CCom();

    #endregion Instancias

    #region Metodos

    private void EnviarVideoGrabador()
    {
        //SerialPort puerto = com.CrearPuerto();

        //com.AbrirPuerto(puerto);
        //com.EnviarTrama(
        //    puerto,
        //    "< Sistema de Bascula " + Convert.ToString(DateTime.Now) + ". \n" +
        //    "Registro Peso Despacho \n" +
        //    this.txtVehiculo.Text + " - " + this.txtRemolque.Text + "\n" +
        //    "Producto - " + this.txtProducto.Text + "\n" +
        //    "Peso Tara - " + this.txtPesoTara.Text + "\n" +
        //    "Peso Bruto - " + this.txtPeso.Text + "\n" +
        //    "Peso Neto - " + this.txtPesoNeto.Text + ">");
        //com.CerrarPuerto(puerto);
    }

    private void Guardar()
    {
        string tiquete = "";

        this.nilblInformacion.Text = "";

        if (this.txtNroSacos.Text.Trim().Length == 0)
        {
            this.nilblInformacion.Text = "Por favor ingrese el número de sacos despachado. Si no aplica digite 0";
            this.lbRegistrar.Visible = true;
            return;
        }

        try
        {
            tiquete = tiposTransaccion.RetornaConsecutivo(
                ConfigurationManager.AppSettings["tipoTiquete"].ToString(), Convert.ToInt16(Session["empresa"]));

            using (TransactionScope ts = new TransactionScope())
            {
                switch (bascula.ActualizaBasculaDes(
                    this.Session["tipomov"].ToString(),
                    this.txtTransaccion.Text,
                    Convert.ToDecimal(this.txtPeso.Text),
                    Convert.ToDecimal(this.txtPesoNeto.Text),
                    tiquete,
                  Convert.ToInt16(Convert.ToDecimal(this.txtNroSacos.Text)), 
                    Convert.ToInt16(Session["empresa"])))
                {
                    case 0:

                        switch (tiposTransaccion.ActualizaConsecutivo(
                            ConfigurationManager.AppSettings["tipoTiquete"].ToString(), Convert.ToInt16(Session["empresa"])))
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

                                /*string script = "<script language='javascript'>" +
                                    "Print('" + tiquete + "');" +
                                    "</script>";

                                Page.RegisterStartupScript("Print", script);*/

                                string impresion = "ImprimeTiquete.aspx?tipoTiquete=tiqueteD&tiquete=" + tiquete +  "&empresa=" + Session["empresa"].ToString();

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
            foreach (DataRowView registro in vehiculos.GetBasculaRemision(
                this.Session["placa"].ToString(), Convert.ToInt16(Session["empresa"])))
            {
          
                this.txtVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(15));
                this.txtRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(16));
                this.txtProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(17));
                this.txtProductoNombre.Text = Convert.ToString(registro.Row.ItemArray.GetValue(34));
                this.txtPesoTara.Text = Convert.ToString(registro.Row.ItemArray.GetValue(8));
                this.txtTransaccion.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
            }

            this.txtFecha.Text = DateTime.Now.ToString();
            this.txtPeso.Text = Convert.ToString(this.Session["peso"]);
            this.txtNroSacos.Enabled = true;

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
                Response.Redirect("CapturaPeso.aspx");
            }

            if (!IsPostBack)
            {
                CargarDatosVehiculo();
            }
        }
    }

     protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
      {

        this.Response.Redirect("CapturaPesoDPT.aspx");
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {


        this.lbRegistrar.Visible = false;

        Guardar();
    }

      protected void lbNuevoPeso_Click(object sender, ImageClickEventArgs e)
    {

    
        Response.Redirect("Despachos.aspx");
    }



    #endregion Eventos


    
}
