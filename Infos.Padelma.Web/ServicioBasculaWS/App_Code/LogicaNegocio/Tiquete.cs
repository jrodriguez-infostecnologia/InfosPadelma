using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess;


/// <summary>
/// Summary description for Tiquete
/// </summary>
public class Tiquete
{

    static public string ImprimirTiqueteEMP(string usuario, string impresora, string tipo, string[] datos_tiquete)
    {
        try
        {
            Ticket ticket = new Ticket();
                       
            ticket.AddHeaderLine("REGISTRO DE PESAJE EN BASCULA - EMP");

            completar_cabeza_tiquete(tipo, ticket, usuario, datos_tiquete);
            
            ticket.AddHeaderLine("Procedencia :" + datos_tiquete[9]);
            ticket.AddHeaderLine("Cantidad Sacos: " + datos_tiquete[13] + "                                  Cantidad racimos: " + datos_tiquete[14]);
            ticket.AddHeaderLine("Destino: " + datos_tiquete[15] + "                             CONTROL CALIDAD");

            if (tipo.Equals("almendra"))
            {
                ticket.AddHeaderLine("Descargador :" + datos_tiquete[17] + "                            ACIDEZ: " + datos_tiquete[19]);
                ticket.AddHeaderLine("Tercero: " + datos_tiquete[18] + "                                  ALM QUEBRADA: " + datos_tiquete[22]);
                ticket.AddHeaderLine("                                                  IMPUREZAS: " + datos_tiquete[21]);
                ticket.AddHeaderLine("                                                  HUMEDAD: " + datos_tiquete[20]);
                ticket.AddHeaderLine("");
                ticket.AddHeaderLine("");
            }
            if (tipo.Equals("fruta"))
            {
                ticket.AddHeaderLine("Descargador :" + datos_tiquete[17] + "                            F.MADURA: " + datos_tiquete[19]);
                ticket.AddHeaderLine("Tercero: " + datos_tiquete[18] + "                                  F.VERDE: " + datos_tiquete[20]);
                ticket.AddHeaderLine("                                                F.SOBREMADURA: " + datos_tiquete[21]);
                ticket.AddHeaderLine("                                                   R.PODRIDOS: " + datos_tiquete[22]);
                ticket.AddHeaderLine("                                                   R.ENFERMOS: " + datos_tiquete[23]);
                ticket.AddHeaderLine("                                                     P.LARGOS: " + datos_tiquete[24]);
                ticket.AddHeaderLine("                                                     F.TENERA: " + datos_tiquete[25]);
                ticket.AddHeaderLine("                                                       F.DURA: " + datos_tiquete[26]);
            }

            ticket.AddHeaderLine("");
            ticket.AddHeaderLine("BASCULA________________________________[SISTEMAS " + DateTime.Now.Year + "]");
            ticket.AddHeaderLine(usuario);
            ticket.PrintTicket(impresora);
            return "exito";
        }
        catch(Exception ex)
        {
            return ex.Message;
        }
    }

    static public void ImprimirTiquetePES(string usuario, string impresora, string[] datos_tiquete)
    {
        Ticket ticket = new Ticket();

        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("REGISTRO DE PESAJE EN BASCULA - PES");

        completar_cabeza_tiquete("", ticket, usuario, datos_tiquete);


        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("BASCULA___________________________________[SISTEMAS " + DateTime.Now.Year + "]");
        ticket.AddHeaderLine(usuario);
        ticket.PrintTicket(impresora);
        
    }


    static public void ImprimirTiqueteDES(string usuario, string impresora, string[] datos_tiquete)
    {
        Ticket ticket = new Ticket();

        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("REGISTRO DE PESAJE EN BASCULA - DES");

        completar_cabeza_tiquete("", ticket, usuario, datos_tiquete);

        ticket.AddHeaderLine("Cantidad Sacos: " + datos_tiquete[13] );
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("BASCULA___________________________________[SISTEMAS " + DateTime.Now.Year + "]");
        ticket.AddHeaderLine(usuario);
        ticket.PrintTicket(impresora);
        
    }

    static private void completar_cabeza_tiquete(string tipo, Ticket ticket, string usuario, string[] datos_tiquete)
    {
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("                                            Tiquete Nro.: " + datos_tiquete[0]);
        ticket.AddHeaderLine("                                                 Fecha..: " + datos_tiquete[1]);
        ticket.AddHeaderLine("");
        switch (tipo)
        {
            case "fruta":
            case "almendra":
                ticket.AddHeaderLine("Hora Entrada:" + datos_tiquete[2] + "                        Peso Bruto.: " + datos_tiquete[3] + "KG");
                ticket.AddHeaderLine("Hora Salida : " + datos_tiquete[4] + "                       Peso tara..: " + datos_tiquete[5] + "KG");
                break;

            case "":
                ticket.AddHeaderLine("Hora Entrada:" + datos_tiquete[4] + "                         Peso Tara.: " + datos_tiquete[5] + "KG");
                ticket.AddHeaderLine("Hora Salida : " + datos_tiquete[2] + "                      Peso Bruto..: " + datos_tiquete[3] + "KG");
                break;

            default:
                break;
        }       
        ticket.AddHeaderLine("                                                  Sub total..: " + datos_tiquete[6] + "KG");
        ticket.AddHeaderLine("                                                  Neto.......: " + datos_tiquete[6] + "KG");
        ticket.AddHeaderLine("Tipo Movimiento :" + datos_tiquete[7]);
        ticket.AddHeaderLine("Producto: " + datos_tiquete[8]);
        ticket.AddHeaderLine("Conductor: " + datos_tiquete[10] + "        Cedula: " + datos_tiquete[11]);
        ticket.AddHeaderLine("Vehiculo: " + datos_tiquete[12]);
        ticket.AddHeaderLine("");
        ticket.AddHeaderLine("Gondola/Caja: " + datos_tiquete[16]);        
    }


}