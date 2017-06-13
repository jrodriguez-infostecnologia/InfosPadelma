using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";

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
             error,
               ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
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
            if (seguridad.VerificaAccesoPagina(
                  this.Session["usuario"].ToString(),
                  ConfigurationManager.AppSettings["Modulo"].ToString(),
                  nombrePaginaActual(),
                  Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

    protected void niimbConsultarLog_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("ConsultarLog.aspx");
    }

    protected void niimbMenu_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Menu.aspx");
    }

    protected void imbPermisos_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Permisos.aspx");
    }

    protected void niimbUsuarioPerfil_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("UsuarioPerfil.aspx");
    }

    #endregion Eventos
}
