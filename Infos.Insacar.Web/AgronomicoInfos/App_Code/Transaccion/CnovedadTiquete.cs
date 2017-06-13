using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de CnovedadTiquete
/// </summary>
public class CnovedadTiquete
{
    private string codnovedad;

    public string Codnovedad
    {
        get { return codnovedad; }
        set { codnovedad = value; }
    }
    private string desnovedad;
    public string Desnovedad
    {
        get { return desnovedad; }
        set { desnovedad = value; }
    }
    private string codnovedadCargue;
    public string CodnovedadCargue
    {
        get { return codnovedadCargue; }
        set { codnovedadCargue = value; }
    }
    private string desnovedadCargue;
    public string DesnovedadCargue
    {
        get { return desnovedadCargue; }
        set { desnovedadCargue = value; }
    }
    private string codnovedadTransporte;
    public string CodnovedadTransporte
    {
        get { return codnovedadTransporte; }
        set { codnovedadTransporte = value; }
    }
    private string desnovedadTransporte;
    public string DesnovedadTransporte
    {
        get { return desnovedadTransporte; }
        set { desnovedadTransporte = value; }
    }
    private string codlote;
    public string Codlote
    {
        get { return codlote; }
        set { codlote = value; }
    }
    private string deslote;
    public string Deslote
    {
        get { return deslote; }
        set { deslote = value; }
    }
    private string codseccion;
    public string Codseccion
    {
        get { return codseccion; }
        set { codseccion = value; }
    }
    private string desseccion;
    public string Desseccion
    {
        get { return desseccion; }
        set { desseccion = value; }
    }
    private decimal racimos;
    public decimal Racimos
    {
        get { return racimos; }
        set { racimos = value; }
    }
    private decimal jornales;
    public decimal Jornales
    {
        get { return jornales; }
        set { jornales = value; }
    }
    private decimal cantidad;
    public decimal Cantidad
    {
        get { return cantidad; }
        set { cantidad = value; }
    }
    private int registro;
    public int Registro
    {
        get { return registro; }
        set { registro = value; }
    }
    private List<Ctercero> terceros;
    public List<Ctercero> Terceros
    {
        get { return terceros; }
        set { terceros = value; }
    }
    private List<Ctercero> tercerosCargue;
    public List<Ctercero> TercerosCargue
    {
        get { return tercerosCargue; }
        set { tercerosCargue = value; }
    }

    private List<Ctercero> tercerosTransporte;

    public List<Ctercero> TercerosTransporte
    {
        get { return tercerosTransporte; }
        set { tercerosTransporte = value; }
    }

    private string umedida;

    public string Umedida
    {
        get { return umedida; }
        set { umedida = value; }
    }

    private string umedidaCargue;

    public string UmedidaCargue
    {
        get { return umedidaCargue; }
        set { umedidaCargue = value; }
    }
    private string umedidaTransporte;

    public string UmedidaTransporte
    {
        get { return umedidaTransporte; }
        set { umedidaTransporte = value; }
    }

    private string fechaD;
    private string fechaCargue;
    private string fechaTransporte;

    public string FechaD
    {
        get { return fechaD; }
        set { fechaD = value; }
    }

    public string FechaCargue
    {
        get { return fechaCargue; }
        set { fechaCargue = value; }
    }

    public string FechaTransporte
    {
        get { return fechaTransporte; }
        set { fechaTransporte = value; }
    }

    private decimal pesoRacimo;

    public decimal PesoRacimo
    {
        get { return pesoRacimo; }
        set { pesoRacimo = value; }
    }

    private decimal jornal;

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

    private decimal precioLaborCargue;

    public decimal PrecioLaborCargue
    {
        get { return precioLaborCargue; }
        set { precioLaborCargue = value; }
    }

    private decimal precioLaborTransporte;

    public decimal PrecioLaborTransporte
    {
        get { return precioLaborTransporte; }
        set { precioLaborTransporte = value; }
    }

    public CnovedadTiquete()
    {
    }

    public CnovedadTiquete(string codnovedad, string desnovedad, string codnovedadCargue, string desnovedadCargue, string codnovedadTransporte, string desnovedadTransporte, string codlote, string deslote, string codseccion, string desseccion,
        decimal racimos, decimal cantidad, List<Ctercero> terceros, List<Ctercero> tercerosCargue, List<Ctercero> tercerosTransporte, int registro, string umedida, string umedidaCargue, string umedidaTransporte, decimal pesoRacimo,
        string fechaD, string fechaCargue, string fechaTransporte, decimal jornal, decimal precioLabor, decimal precioLaborCargue, decimal precioLaborTransporte)
    {
        this.codnovedad = codnovedad;
        this.desnovedad = desnovedad;
        this.codnovedadCargue = codnovedadCargue;
        this.desnovedadCargue = desnovedadCargue;
        this.codnovedadTransporte = codnovedadTransporte;
        this.desnovedadTransporte = desnovedadTransporte;
        this.codlote = codlote;
        this.deslote = deslote;
        this.racimos = racimos;
        this.terceros = terceros;
        this.tercerosCargue = tercerosCargue;
        this.tercerosTransporte = tercerosTransporte;
        this.registro = registro;
        this.codseccion = codseccion;
        this.desseccion = desseccion;
        this.umedida = umedida;
        this.umedidaCargue = umedidaCargue;
        this.umedidaTransporte = umedidaTransporte;
        this.cantidad = cantidad;
        this.fechaD = fechaD;
        this.pesoRacimo = pesoRacimo;
        this.jornal = jornal;
        this.precioLabor = precioLabor;
        this.precioLaborCargue = precioLaborCargue;
        this.precioLaborTransporte = precioLaborTransporte;

    }
}