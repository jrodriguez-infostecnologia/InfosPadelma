using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.WebControls.Adapters;
using System.IO.Ports;
using System.Net.Sockets;
using System.Text;
using System.IO;

public partial class Bascula_Poperaciones_CapturaPesaje : System.Web.UI.Page
{

    #region Instancias

    Cvehiculos vehiculos = new Cvehiculos();
    public TcpClient TcpCliente { get; private set; }
    CCom com = new CCom();

    #endregion Instancias

    #region Metodos

    private void EnviarVideoGrabador()
    {
        SerialPort puerto = com.CrearPuerto();

        com.AbrirPuerto(puerto);
        com.EnviarTrama(
            puerto,
            "< Sistema de Bascula " + Convert.ToString(DateTime.Now) + ". \n" +
            "Captura Peso Pesaje \n" +
            "Peso - " + this.Txt_Peso.Text + ">");
        com.CerrarPuerto(puerto);
    }

    protected void PRO()
    {
        string tmp = "";

        try
        {

            this.Session["PesoLeido"] =  Server.HtmlEncode(Servicios.LeerSerial());
        }

        catch (Exception ex) {
            this.Txt_Peso.Text = ex.Message;
        
        }
        

        foreach (char caracter in this.Session["PesoLeido"].ToString().ToCharArray())
        {
            if (char.IsDigit(caracter) || caracter == 'M' || caracter == 'U')
            {
                tmp = tmp + caracter;
            }
        }

        tmp = Convert.ToString(tmp.Replace('U', 'M')).Trim();

        if (tmp.IndexOf('M') != -1)
        {
            if (!tmp.StartsWith("M"))
            {

                tmp = tmp.Remove(0, tmp.IndexOf('M'));

            }
        }

        this.Txt_Peso.Text = tmp;

        if (tmp.Trim().Length > 0)
        {
            if (tmp.Length != 0 && !tmp.StartsWith("M"))
            {

                this.Txt_Peso.Text = Convert.ToString(Convert.ToInt32(tmp.Replace('M', ' '))).Trim();
                this.Txt_Peso.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                this.Txt_Peso.Text = Convert.ToString(Convert.ToInt32(tmp.Replace('M', ' '))).Trim();
                this.Txt_Peso.ForeColor = System.Drawing.Color.Red;
            }
        }

    }

    protected void IQIP()
    {

        string tmp = "";
        TcpCliente = new TcpClient();
        this.Session["IP"] = ConfigurationManager.AppSettings["IP"].ToString();
        this.Session["PUERTO"] = ConfigurationManager.AppSettings["PUERTO"].ToString();

        TcpCliente.Connect(this.Session["IP"].ToString(), Convert.ToInt16(this.Session["PUERTO"]));

        try
        {

            tmp = "";
            try
            {

                NetworkStream stream = TcpCliente.GetStream();
                byte[] buffer = new byte[256];

                stream.Read(buffer, 0, buffer.Length);

                this.Session["PesoLeido"] = Encoding.ASCII.GetString(buffer);
            }
            catch (Exception c)
            {

            }


            foreach (char caracter in this.Session["PesoLeido"].ToString().ToCharArray())
            {
                if (char.IsDigit(caracter) || caracter == 'M' || caracter == 'U')
                {
                    tmp = tmp + caracter;
                }
            }


            this.Txt_Peso.Text = tmp;

            if (tmp.Length != 0 && !tmp.EndsWith("M"))
            {
                try
                {
                    this.Txt_Peso.Text = Convert.ToString(Convert.ToInt32(tmp.Replace('M', ' '))).Trim();
                    this.Txt_Peso.ForeColor = System.Drawing.Color.Green;
                }
                catch (Exception a)
                {

                }
            }
            else
            {
                try
                {
                    this.Txt_Peso.Text = Convert.ToString(Convert.ToInt32(tmp.Replace('M', ' '))).Trim();
                    this.Txt_Peso.ForeColor = System.Drawing.Color.Red;
                }
                catch (Exception a)
                {

                }
            }

            try
            {
                TcpCliente.Close();
            }
            catch (Exception a)
            {

            }



        }
        catch (IOException a)
        {
            //Logic to reconnect
        }

    }

    protected void DEFAULT()
    {
        string tmp = "";
        this.Session["PesoLeido"] = Server.HtmlEncode(Servicios.LeerSerial());

        foreach (char caracter in this.Session["PesoLeido"].ToString().ToCharArray())
        {
            if (char.IsDigit(caracter) || caracter == 'M' || caracter == 'U')
            {
                tmp = tmp + caracter;
            }
        }


        this.Txt_Peso.Text = tmp;

        if (tmp.Length != 0 && !tmp.EndsWith("M"))
        {
            this.Txt_Peso.Text = Convert.ToString(Convert.ToInt32(tmp.Replace('M', ' '))).Trim();
            this.Txt_Peso.ForeColor = System.Drawing.Color.Green;
        }
        else
        {
            try
            {
                this.Txt_Peso.Text = Convert.ToString(Convert.ToInt32(tmp.Replace('M', ' '))).Trim();
                this.Txt_Peso.ForeColor = System.Drawing.Color.Red;
            }
            catch (Exception a)
            {

            }
        }


    }

    protected void Timer1_Tick(object sender, EventArgs e)
    {
      
        switch (ConfigurationManager.AppSettings["Indicador"].ToString())
        {

            case "PRO2000":
                PRO();

                break;

            case "IQ355IP":

                IQIP();

                break;


            default:
                DEFAULT();

                break;
        }

    }


    #endregion Metodos


    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["usuario"] != null)
        {
            try
            {
                Timer1.Interval = Convert.ToInt16(ConfigurationManager.AppSettings["TIME"]);

                if (this.Session["tipoPeso"].ToString() == "PP")
                {
                    this.lblTipoPeso.Text = "Primer Peso";
                }
                else
                {
                    this.lblTipoPeso.Text = "Segundo Peso";
                }

            }
            catch (Exception ex)
            {
                this.lblTipoPeso.Text = "Error al recuperar el tipo de peso. Correspondiente a: " + ex.Message;
            }
        }
        else
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(this.Session["entradapes"].ToString());
    }
    protected void Ibm_Aceptar_Click(object sender, ImageClickEventArgs e)
    {
        string PesoValidado = this.Txt_Peso.Text;
        string Pagina = this.Session["paginapes"].ToString();
        this.Session["peso"] = PesoValidado;

        if (PesoValidado != null && PesoValidado.Trim().Length != 0 && PesoValidado.Trim() != "0" &&
            this.Txt_Peso.ForeColor == System.Drawing.Color.Green)
        {
            try
            {
                EnviarVideoGrabador();
            }
            catch
            {
            }

            Response.Redirect(Pagina);
        }
    }
}