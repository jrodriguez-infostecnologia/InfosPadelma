using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bascula_Poperaciones_MateriaPrima : System.Web.UI.Page
{

    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
        CIP ip = new CIP();


    #endregion Instancias


    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er",
            error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Bascula/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else

        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
               ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                if (!IsPostBack)
                {
                    this.Session["tipomovmp"] = ConfigurationManager.AppSettings["EntradaMateriaPrima"];
                    this.ddlOperacion.Focus();
                }

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }

           
        }

    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(this.ddlOperacion.SelectedValue).Length == 0)
        {
            this.nilblInformacion.Text = "Debe seleccionar una operación para continuar";
        }
        else
        {
            if (Convert.ToString(this.ddlOperacion.SelectedValue) == "primerPeso")
            {
                this.Session["paginamp"] = "ValidaRemisionMPPP.aspx";
            }
            else
            {
                this.Session["paginamp"] = "ValidaRemisionMPSP.aspx";
            }

            this.Session["entradamp"] = "Entradas.aspx";
            this.Session["placamp"] = Convert.ToString(this.ddlOperacion.SelectedValue);
            Response.Redirect(this.Session["paginamp"].ToString(), false);
        }
    }

    #endregion Eventos
}