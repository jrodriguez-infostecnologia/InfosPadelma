﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Ctercero
/// </summary>
public class Ctercero
{

    private int codtercero;

    public int Codtercero
    {
        get { return codtercero; }
        set { codtercero = value; }
    }


    private string desTercero;

    public string DesTercero
    {
        get { return desTercero; }
        set { desTercero = value; }
    }
    private string lote;

    public string Lote
    {
        get { return lote; }
        set { lote = value; }
    }
    private string cuadrilla;

    public string Cuadrilla
    {
        get { return cuadrilla; }
        set { cuadrilla = value; }
    }
    private decimal precio;

    public decimal Precio
    {
        get { return precio; }
        set { precio = value; }
    }
    private decimal cantidad;

    public decimal Cantidad
    {
        get { return cantidad; }
        set { cantidad = value; }
    }
    private decimal  jornal;

    public decimal Jornal
    {
        get { return jornal; }
        set { jornal = value; }
    }

    private decimal precioLabor;

    public decimal PrecioLabor
    {
        get { return precioLabor; }
        set { precioLabor = value; }
    }

    

	public Ctercero()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    public Ctercero(int codTercero, string desTercero, string lote, string cuadrilla, decimal jornal, decimal cantidad, decimal precioLabor ) {

        this.codtercero = codTercero;
        this.desTercero = desTercero;
        this.cuadrilla = cuadrilla;
        this.lote = lote;
        this.jornal = jornal;
        this.cantidad = cantidad;
        this.precioLabor = precioLabor;
      
    
    }

     
    
}