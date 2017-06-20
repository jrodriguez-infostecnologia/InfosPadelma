
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

/// <summary>
/// Summary description for CPeso
/// </summary>
public class CPeso
{
    public CPeso()
    {

    }

    #region Instancias

    CCom CComunicaciones = new CCom();

    #endregion Instancias

    #region Metodos

    public String LeerPeso()
    {
        String PesoLeido = "00Kg";
        SerialPort SerialBascula;
        switch (ConfigurationManager.AppSettings["Indicador"].ToString())
        {
            case "PRO2000":
                {
                   
                    SerialBascula = CComunicaciones.CrearPuerto();

                   

                    if (SerialBascula != null)
                    {
                        if (CComunicaciones.ConfigurarPuerto(SerialBascula, 1) == true)
                        {
                            if (CComunicaciones.AbrirPuerto(SerialBascula) == true)
                            {
                                try
                                {
                                    string tmp = "";
                                    PesoLeido = CComunicaciones.LeerTrama(SerialBascula);
                                    foreach (char var in PesoLeido.ToCharArray())
                                    {
                                        if (char.IsLetterOrDigit(var))
                                        {
                                            if (char.IsLetter(var))
                                            {
                                                if (var.Equals('K') || var.Equals('G') || var.Equals('M') || var.Equals('S') || var.Equals('T') || var.Equals('U') || var.Equals('N'))
                                                    tmp += var;
                                            }
                                            else
                                                tmp += var;
                                        }

                                    }
                                    PesoLeido = tmp;
                                    CComunicaciones.CerrarPuerto(SerialBascula);
                                }
                                catch (Exception Ex)
                                {
                                    PesoLeido = Ex.Message;
                                    CComunicaciones.CerrarPuerto(SerialBascula);
                                }
                            }
                            else {
                                CComunicaciones.CerrarPuerto(SerialBascula);
                            
                            }
                        }
                    }


                    break;
                }
            default:
                {

                    SerialBascula = CComunicaciones.CrearPuerto();

                    if (SerialBascula != null)
                    {
                        if (CComunicaciones.ConfigurarPuerto(SerialBascula, 1) == true)
                        {
                            if (CComunicaciones.AbrirPuerto(SerialBascula) == true)
                            {
                                try
                                {
                                    string tmp = "";
                                    PesoLeido = CComunicaciones.LeerTrama(SerialBascula);
                                    foreach (char var in PesoLeido.ToCharArray())
                                    {
                                        if (char.IsLetterOrDigit(var))
                                        {
                                            if (char.IsLetter(var))
                                            {
                                                if (var.Equals('K') || var.Equals('G') || var.Equals('M'))
                                                    tmp += var;
                                            }
                                            else
                                                tmp += var;
                                        }

                                    }
                                    PesoLeido = tmp;

                                    CComunicaciones.CerrarPuerto(SerialBascula);
                                }
                                catch (Exception Ex)
                                {
                                    PesoLeido = Ex.Message;
                                }
                            }
                        }
                    }
                    break;
                }

        }


        return PesoLeido;
    }

    public string EnviarTramaTablero(string Descripcion, string[] Argumentos, string[] Valores)
    {
        SerialPort SerialTablero;
        string Desplaza, Color = "";
        String Salida = "";
        String Cadena = Descripcion;
        char Caracter = '"';
        string Retorno = "";

        Desplaza = "b";
        Color = "1";

        SerialTablero = CComunicaciones.CrearPuerto();

        if (SerialTablero != null)
        {
            if (CComunicaciones.ConfigurarPuerto(SerialTablero, 2) == true)
            {
                if (CComunicaciones.AbrirPuerto(SerialTablero) == true)
                {
                    try
                    {
                        int i = 0;

                        foreach (string Trama in Argumentos)
                        {
                            Cadena = Cadena + " " + Trama + Valores.GetValue(i);

                            i++;
                        }

                        Salida = "TM]!Z00]" + Caracter + "AZ]; " + Desplaza + "]<" + Color + "]:H" + Cadena + "]$]$";

                        CComunicaciones.EnviarTrama(SerialTablero, Salida);
                        CComunicaciones.CerrarPuerto(SerialTablero);
                        Retorno = "Trama Enviada";
                    }
                    catch (Exception Ex)
                    {
                        Retorno = Ex.Message;
                    }
                }
            }
        }

        return Retorno;
    }

    public string EnviarGrabador(string Descripcion, string[] Argumentos, string[] Valores)
    {
        SerialPort SerialGrabador;
        string
            Cadena = "",
            Salida,
            Retorno = "",
            inicio_trama = "[;",
            fin_trama = ";]",
            salto_linea = "-";

        SerialGrabador = CComunicaciones.CrearPuerto();

        if (SerialGrabador != null)
        {
            if (CComunicaciones.ConfigurarPuerto(SerialGrabador, 3) == true)
            {
                if (CComunicaciones.AbrirPuerto(SerialGrabador) == true)
                {
                    try
                    {
                        int i = 0;
                        foreach (string Trama in Argumentos)
                        {
                            Cadena += Trama + Valores.GetValue(i) + salto_linea;
                            i++;
                        }
                        Salida = inicio_trama + Cadena + fin_trama;
                        CComunicaciones.EnviarTrama(SerialGrabador, Salida);
                        CComunicaciones.CerrarPuerto(SerialGrabador);
                        Retorno = "Trama Enviada";
                    }
                    catch (Exception Ex)
                    {
                        Retorno = Ex.Message;
                    }
                }
            }
        }

        return Retorno;
    }

    public string EnviarGrabadorSimple(string Descripcion, string Argumentos, string Valores)
    {

        SerialPort SerialGrabador;
        string
            Cadena = "",
            Salida,
            Retorno = "1",
            inicio_trama = "[;",
            fin_trama = ";]";

        try
        {
            SerialGrabador = CComunicaciones.CrearPuerto();
            Retorno = "2";
            if (SerialGrabador != null)
            {
                Retorno = "3";
                if (CComunicaciones.ConfigurarPuerto(SerialGrabador, 3) == true)
                {
                    Retorno = "4";
                    if (CComunicaciones.AbrirPuerto(SerialGrabador) == true)
                    {
                        Retorno = "5";

                        Cadena += Argumentos + Valores;
                        Salida = inicio_trama + Cadena + fin_trama;
                        CComunicaciones.EnviarTrama(SerialGrabador, Salida);
                        CComunicaciones.CerrarPuerto(SerialGrabador);
                        Retorno = "Trama Enviada";

                    }
                }
            }
        }
        catch (Exception Ex)
        {
            Retorno = Ex.Message;
        }
        return Retorno;
    }

    #endregion Metodos
}
