using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for CtransaccionProduccion
/// </summary>
public class CtransaccionProduccion
{
    #region Atributos

    private decimal _valor;
    private string _variable;
    private string _codigo;
    private string _uMedida;

    public string UMedida
    {
        get { return _uMedida; }
        set { _uMedida = value; }
    }

    public string Codigo
    {
        get { return _codigo; }
        set { _codigo = value; }
    }

    public string Variable
    {
        get { return _variable; }
        set { _variable = value; }
    }

    public decimal Valor
    {
        get { return _valor; }
        set { _valor = value; }
    }

    #endregion Atributos

    public CtransaccionProduccion()
	{
	}

    public CtransaccionProduccion(decimal resultado, string variable, string codigo, string uMedida)
    {
        _valor = resultado;
        _variable = variable;
        _codigo = codigo;
        _uMedida = uMedida;
    }
}
