using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Ctercero
/// </summary>
public class CterceroTiquete
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
    //private string cuadrilla;

    //public string Cuadrilla
    //{
    //    get { return cuadrilla; }
    //    set { cuadrilla = value; }
    //}
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

    

	public CterceroTiquete()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    public CterceroTiquete(int codTercero, string desTercero, string lote, decimal jornal, decimal cantidad)
    {

        this.codtercero = codTercero;
        this.desTercero = desTercero;
        this.lote = lote;
        this.jornal = jornal;
        this.cantidad = cantidad;
      
    
    }

     
    
}