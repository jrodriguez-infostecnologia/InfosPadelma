using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CanalisisNegocio
/// </summary>
public class CanalisisNegocio
{
	private string _analisis;

    public string Analisis
    {
        get { return _analisis; }
        set { _analisis = value; }
    }

    private string _nombreAnalisis;

    public string NombreAnalisis
    {
        get { return _nombreAnalisis; }
        set { _nombreAnalisis = value; }
    }

    private int _registro;

    public int Registro
    {
        get { return _registro; }
        set { _registro = value; }
    }
    private decimal _porcentaje;

    public decimal Porcentaje
    {
        get { return _porcentaje; }
        set { _porcentaje = value; }
    }

       private bool _baseCalculo;

    public bool BaseCalculo
    {
        get { return _baseCalculo; }
        set { _baseCalculo = value; }
    }


    public CanalisisNegocio(string analisis,string nombreAnalisis, int registro, decimal porcentaje, bool baseCalculo)
	{
        _analisis = analisis;
        _nombreAnalisis = nombreAnalisis;
        _registro = registro;
        _porcentaje = porcentaje;
        _baseCalculo = baseCalculo;
	}
}