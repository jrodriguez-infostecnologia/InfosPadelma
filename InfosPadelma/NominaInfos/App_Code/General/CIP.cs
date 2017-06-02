﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;

/// <summary>
/// Descripción breve de CIP
/// </summary>
public class CIP
{
	public CIP()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}
    public string ObtenerIP()
    {
        IPHostEntry host;
        string localIP = "";
        host = Dns.GetHostEntry(Dns.GetHostName());
        foreach (IPAddress ip in host.AddressList)
        {
            if (ip.AddressFamily.ToString() == "InterNetwork")
            {
                localIP = ip.ToString();
            }
        }

        return localIP;
    }
}