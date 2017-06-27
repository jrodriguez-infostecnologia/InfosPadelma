using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Net;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nomina_Pliquidacion_ModificacionPrimas : System.Web.UI.Page
{

    public List<LiquidacionPrimas> ListadoDetallePrimas
    {
        get
        {
            object o = ViewState["ListadoDetallePrimas"];
            return (o == null) ? null : (List<LiquidacionPrimas>)o;
        }
        set
        {
            ViewState["ListadoDetallePrimas"] = value;
        }
    }


    #region Instancias

    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cperiodos periodo = new Cperiodos();
    CModificacionPrimas modificacionPrima = new CModificacionPrimas();
    #endregion Instancias

    #region Metodos

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private void InitView()
    {
        CargarDetallePrima();
    }

    private void CargarDetallePrima()
    {
        string empresa = (Session["empresa"] ?? "").ToString();
        string tipo = (Request["tipo"] ?? "").ToString();
        string numero = (Request["numero"] ?? "").ToString();

        try
        {
            var ds = modificacionPrima.CargarDetallePrima(empresa, tipo, numero);
            ListadoDetallePrimas = new List<LiquidacionPrimas>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                var item = new LiquidacionPrimas();
                item.CodigoTercero = dr["codigoTercero"].ToString();
                item.IdentificacionTercero = dr["identificacionTercero"].ToString();
                item.NombreTercero = dr["nombreTercero"].ToString();
                item.FechaIngeso = dr["fechaIngeso"].ToString();
                item.FechaInicial = dr["fechaInicial"].ToString();
                item.FechaFinal = dr["fechaFinal"].ToString();
                item.Basico = dr["basico"].ToString();
                item.Transporte = dr["transporte"].ToString();
                item.ValorPromedio = dr["valorPromedio"].ToString();
                item.Base = dr["base"].ToString();
                item.DiasPromedio = dr["diasPromedio"].ToString();
                item.DiasPrima = dr["diasPrima"].ToString();
                item.ValorPrima = dr["valorPrima"].ToString();
                ListadoDetallePrimas.Add(item);
            }
            gvDetalleLiquidacion.DataSource = ListadoDetallePrimas;
            gvDetalleLiquidacion.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los detalles de la liquidación." + ex.ToString(), "IN");
        }
    }

    private string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {

        if (this.Session["usuario"] == null)
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
                return;
            }
            if (!IsPostBack)
            {
                InitView();
            }
        }
    }

    #endregion Eventos

    #region EventosFuncionario

    #endregion EventosFuncionario


}
