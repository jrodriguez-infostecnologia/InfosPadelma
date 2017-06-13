using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Porteria_Padministracion_Salidas : System.Web.UI.Page
{

    #region Instancias

    Cvehiculos vehiculos = new Cvehiculos();
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
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
           "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
           "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }

    private void GetEntidad()
    {
        try
        {
            this.gvLista.DataSource = vehiculos.GetVehiculosEnPlanta(Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar vehículos en planta" + ex.Message, "C");
        }
    }
    #endregion Metodos

    #region Eventos
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (!IsPostBack)
                GetEntidad();
        }

    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            switch (vehiculos.ActualizaFechaSalidaEstado(Server.HtmlDecode(Convert.ToString(this.gvLista.SelectedRow.Cells[1].Text)),
                Server.HtmlDecode(Convert.ToString(this.gvLista.SelectedRow.Cells[2].Text)), Convert.ToInt16(Session["empresa"]), ""))
            {
                case 0:
                    GetEntidad();
                    this.nilblInformacion.Text = "Vehículo registrado satisfactoriamente";
                    break;
                case 1:
                    this.nilblInformacion.Text = "Errores al dar salida al vehículo";
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al dar salida al vehículo. Correspondiente a: " + ex.Message, "A");
        }
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        GetEntidad();
    }
    #endregion Eventos
  
}