using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO.Ports;
using System.Text;

/// <summary>
/// Summary description for CCom
/// </summary>
public class CCom
{
	public CCom()
    {
    
    }

    #region Metodos

    //Metodo para crear una instancia
    //de objeto SerialPort
    public SerialPort CrearPuerto()
    {
        SerialPort SerialBascula;

        SerialBascula = new SerialPort();

        return SerialBascula;
    }


    //Metodo para configurar propiedades
    //del objeto SerialPort
    public bool ConfigurarPuerto(SerialPort SerialBascula, int Device)
    {
        bool ConfigurarPuerto = true;

        try
        {
            if (Device == 1)
            {
                SerialBascula.PortName = Convert.ToString(ConfigurationManager.AppSettings["PortName"]);
                SerialBascula.BaudRate = Convert.ToInt16(ConfigurationManager.AppSettings["BaudRate"]);
                SerialBascula.Parity = (Parity)Enum.Parse(typeof(Parity), Convert.ToString(ConfigurationManager.AppSettings["Parity"]));
                SerialBascula.DataBits = Convert.ToInt16(ConfigurationManager.AppSettings["DataBits"]);
                SerialBascula.StopBits = (StopBits)Enum.Parse(typeof(StopBits), Convert.ToString(ConfigurationManager.AppSettings["StopBits"]));
                SerialBascula.Handshake = (Handshake)Enum.Parse(typeof(Handshake), Convert.ToString(ConfigurationManager.AppSettings["HandShake"]));
                SerialBascula.ReadTimeout = Convert.ToInt16(ConfigurationManager.AppSettings["ReadTimeOut"]);

                ConfigurarPuerto = true;
            }
            
            if (Device == 2)
            {
                SerialBascula.PortName = Convert.ToString(ConfigurationManager.AppSettings["PortNameBoard"]);
                SerialBascula.BaudRate = Convert.ToInt16(ConfigurationManager.AppSettings["BaudRateBoard"]);
                SerialBascula.Parity = (Parity)Enum.Parse(typeof(Parity), Convert.ToString(ConfigurationManager.AppSettings["ParityBoard"]));
                SerialBascula.DataBits = Convert.ToInt16(ConfigurationManager.AppSettings["DataBitsBoard"]);
                SerialBascula.StopBits = (StopBits)Enum.Parse(typeof(StopBits), Convert.ToString(ConfigurationManager.AppSettings["StopBitsBoard"]));
                SerialBascula.Handshake = (Handshake)Enum.Parse(typeof(Handshake), Convert.ToString(ConfigurationManager.AppSettings["HandShakeBoard"]));
                SerialBascula.ReadTimeout = Convert.ToInt16(ConfigurationManager.AppSettings["ReadTimeOutBoard"]);

                ConfigurarPuerto = true;
            }

            if (Device == 3)
            {
                SerialBascula.PortName = Convert.ToString(ConfigurationManager.AppSettings["PortNameRec"]);
                SerialBascula.BaudRate = Convert.ToInt16(ConfigurationManager.AppSettings["BaudRateRec"]);
                SerialBascula.Parity = (Parity)Enum.Parse(typeof(Parity), Convert.ToString(ConfigurationManager.AppSettings["ParityRec"]));
                SerialBascula.DataBits = Convert.ToInt16(ConfigurationManager.AppSettings["DataBitsRec"]);
                SerialBascula.StopBits = (StopBits)Enum.Parse(typeof(StopBits), Convert.ToString(ConfigurationManager.AppSettings["StopBitsRec"]));
                SerialBascula.Handshake = (Handshake)Enum.Parse(typeof(Handshake), Convert.ToString(ConfigurationManager.AppSettings["HandShakeRec"]));
                SerialBascula.ReadTimeout = Convert.ToInt16(ConfigurationManager.AppSettings["ReadTimeOutRec"]);

                ConfigurarPuerto = true;
            }

        }
        catch
        {
            ConfigurarPuerto = false;
        }

        return ConfigurarPuerto;
    }

    //Metodo para abrir 
    //comunicación para el 
    //objeto SerialPort
    public bool AbrirPuerto(SerialPort SerialBascula)
    {
        bool PuertoAbierto = false;        
        if (SerialBascula.IsOpen)
        {            
                SerialBascula.Close();
                PuertoAbierto = false;            
        }
        else
        {
            SerialBascula.Open();
            PuertoAbierto = true;           
        }
        return PuertoAbierto;
    }

    //Metodo para capturar la trama
    //en el buffer del objeto SerialPort
    public String LeerTrama(SerialPort SerialBascula)
    {
          return SerialBascula.ReadLine().ToString(); 
    }

    //Metodo para enviar la trama
    //en el buffer del objeto SerialPort
    public void EnviarTrama(SerialPort SerialBascula, String Trama)
    {
        SerialBascula.WriteLine(Trama);        
    }

    //Metodo para cerrar
    //comunicación para el 
    //objeto SerialPort
    public bool CerrarPuerto(SerialPort SerialBascula)
    {
        bool PuertoCerrado = true;

        if (SerialBascula.IsOpen)
        {
            try
            {
                SerialBascula.Close();
                PuertoCerrado = true;
            }
            catch
            {
                PuertoCerrado = false;
            }
        }
        else
        {
            PuertoCerrado = true;
        }

        return PuertoCerrado;
    }

    #endregion Metodos
}
