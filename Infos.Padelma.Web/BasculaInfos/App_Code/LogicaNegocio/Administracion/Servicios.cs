using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Servicios
/// </summary>
public static class Servicios
{
    public static string LeerSerial()
    {
        string Lectura = "0";

        ServicioBascula.Service ServicioBascula = new ServicioBascula.Service();

        try
        {
            Lectura = ServicioBascula.LeerPeso();
        }
        catch (Exception Ex)
        {
            Lectura = "Error al leer el peso" + Ex.Message;
        }

        return Lectura;
    }
}