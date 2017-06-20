using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CtransaccionAlmacen
/// </summary>
public class CtransaccionAlmacen
{
	public CtransaccionAlmacen()
	{
		//
		// TODO: Agregar aquí la lógica del constructor
		//
	}

    #region Instancias

    Citems item = new Citems();

    #endregion Instancias

    #region Atributos

    private string _bodega;
    private string _producto;
    private decimal _cantidad;
    private string _uMedida;
    private decimal _valorUnitario;
    private string _destino;
    private bool _inversion;
    private string _Cuenta;
    private string _cCosto;
    private decimal _valorTotal;
    private decimal _neto;
    private string _detalle;
    private string _papeleta;
    private int _registro;

    public int Registro
    {
        get { return _registro; }
        set { _registro = value; }
    }

    public string Papeleta
    {
        get { return _papeleta; }
        set { _papeleta = value; }
    }

    public string Detalle
    {
        get { return _detalle; }
        set { _detalle = value; }
    }

      public decimal Neto
    {
        get { return _neto; }
        set { _neto = value; }
    }

    public decimal ValorTotal
    {
        get { return _valorTotal; }
        set { _valorTotal = value; }
    }

    public string Ccosto
    {
        get { return _cCosto; }
        set { _cCosto = value; }
    }

    public string Cuenta
    {
        get { return _Cuenta; }
        set { _Cuenta = value; }
    }

    public bool Inversion
    {
        get { return _inversion; }
        set { _inversion = value; }
    }

    public string Destino
    {
        get { return _destino; }
        set { _destino = value; }
    }


     public decimal ValorUnitario
    {
        get { return _valorUnitario; }
        set { _valorUnitario = value; }
    }

    public string Umedida
    {
        get { return _uMedida; }
        set { _uMedida = value; }
    }

    public decimal Cantidad
    {
        get { return _cantidad; }
        set { _cantidad = value; }
    }

    public string Producto
    {
        get { return _producto; }
        set { _producto = value; }
    }

    public string Bodega
    {
        get { return _bodega; }
        set { _bodega = value; }
    }

    #endregion Atributos



    public CtransaccionAlmacen(string bodega, string producto, decimal cantidad, string uMedida, decimal valorUnitario, 
        string Cuenta, string destino, bool inversion, string cCosto, decimal valorTotal, decimal valorNeto, string detalle, int registro, int empresa)
    {
        _bodega = bodega;
        _producto = producto;
        _cantidad = cantidad;
        _uMedida = uMedida;
        _valorUnitario = valorUnitario;
      
        _destino = destino;
        _inversion = inversion;
        _cCosto = cCosto;
        _valorTotal = (_valorUnitario * _cantidad);
     
        _neto = (_valorTotal );
        _registro = registro;
        _Cuenta = Cuenta;

        if (producto.Trim().Length == 0)
        {
            _detalle = detalle;
        }
        else
        {
            _detalle = item.RetornaDescripcion(
                _producto, empresa);
        }
    }

    public CtransaccionAlmacen(decimal cantidad, decimal valorTotal,  decimal neto)
    {
        _cantidad = cantidad;
        _valorTotal = valorTotal;
       
        _neto = neto;
    }

    public CtransaccionAlmacen(string papeleta, string producto, decimal cantidad)
    {
        _papeleta = papeleta;
        _cantidad = cantidad;
        _producto = producto;
    }

    public List<CtransaccionAlmacen> TotalizaTransaccion(List<CtransaccionAlmacen> transaccionAlmacen)
    {
        List<CtransaccionAlmacen> listaTotal = new List<CtransaccionAlmacen>();

        decimal cantidadTotal = 0, valorTotal = 0,  netoTotal = 0;
        int i = 0;

        foreach (object registro in transaccionAlmacen.ToArray())
        {
            cantidadTotal += transaccionAlmacen[i].Cantidad;
            valorTotal += transaccionAlmacen[i].ValorTotal;
            netoTotal += transaccionAlmacen[i].Neto;

            i++;
        }

        CtransaccionAlmacen total = new CtransaccionAlmacen(
            cantidadTotal,
            valorTotal,
            netoTotal);

        listaTotal.Add(total);

        return listaTotal;
    }

}