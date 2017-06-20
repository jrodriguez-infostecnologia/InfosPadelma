using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
public class CproductoMaquila
{
	private string _producto;

    public string Producto
    {
        get { return _producto; }
        set { _producto = value; }
    }

    private string _nombreProducto;

    public string NombreProducto
    {
        get { return _nombreProducto; }
        set { _nombreProducto = value; }
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

       private bool _activo;

    public bool Activo
    {
        get { return _activo; }
        set { _activo = value; }
    }


    public CproductoMaquila(string producto, string nombreProducto, int registro, decimal porcentaje, bool activo)
	{
        _producto = producto;
        _nombreProducto = nombreProducto;
        _registro = registro;
        _porcentaje = porcentaje;
        _activo = activo;
	}
}