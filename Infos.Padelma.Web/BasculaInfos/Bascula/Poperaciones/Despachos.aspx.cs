using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bascula_Poperaciones_Despachos : System.Web.UI.Page
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

    protected void Page_Load(object sender, EventArgs e)
    {

        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                this.Session["tipomov"] = ConfigurationManager.AppSettings["DespachoProductoTerminado"];
                this.ddlOperacion.Focus();
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
                this.Session["pagina"] = "ValidaRemisionDPTPP.aspx";
            }
            else
            {
                this.Session["pagina"] = "ValidaRemisionDPTSP.aspx";
            }

            this.Session["entrada"] = "Despachos.aspx";
            this.Session["placa"] = Convert.ToString(this.ddlOperacion.SelectedValue);
            Response.Redirect(this.Session["pagina"].ToString(), false);
        }
    }
}