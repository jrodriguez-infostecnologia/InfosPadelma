using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Ccanales
/// </summary>
public class Ccanales
{

    private string _tipoCanal;

    public string TipoCanal
    {
        get { return _tipoCanal; }
        set { _tipoCanal = value; }
    }
    private int _numero;

    public int Numero
    {
        get { return _numero; }
        set { _numero = value; }
    }
    private decimal _metros;

    public decimal Metros
    {
        get { return _metros; }
        set { _metros = value; }
    }


	public Ccanales( string tipoCanal, int numero, decimal metros )
	{
        _tipoCanal = tipoCanal;
        _numero = numero;
        _metros = metros;
	}
}