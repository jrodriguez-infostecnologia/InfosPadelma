using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Transactions;
using System.Data;
using System.Net;

public partial class Infos_MenuInfos : System.Web.UI.Page
{
    #region Instancias

    cMenu menu = new cMenu();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    #endregion Instancias
    #region Metodos
    private string ObtenerIP()
    {
        IPHostEntry host;
        string localIP = "";
        host = Dns.GetHostEntry(Dns.GetHostName());
        foreach (IPAddress ip in host.AddressList)
        {
            if (ip.AddressFamily.ToString() == "InterNetwork")
                localIP = ip.ToString();
        }
        return localIP;
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        this.hpMenu.HRef = "#";
        this.hpMenu.Attributes.Add("OnClick", "javascript: document.location.href='../Inicio.aspx'");

        if (this.Session["usuario"] == null)
        {
            if (this.Parent != null)
                this.Parent.Page.Response.Redirect("~/Inicio.aspx");
            else
                this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            try
            {

                this.btnCambiarClave.Attributes.Add("OnClick", "javascript:return validarPasswd();");
                this.hpMenuPrincipal.HRef = "#";
                this.hpMenuPrincipal.Attributes.Add("OnClick", "javascript: document.location.href='" + menu.SeleccionaMenuPrincipal(this.Session["usuario"].ToString(), this.Session["clave"].ToString(), Convert.ToInt16(this.Session["empresa"])).ToString() + "'");

                this.gvLista.DataSource = menu.SeleccionaEmpresaUsuario(Convert.ToString(Session["usuario"]));
                this.gvLista.DataBind();

                this.lbUsuario.Text = this.Session["usuario"].ToString();
                this.lbNombreUsuario.Text = menu.RetornaNombreUsuario(this.Session["usuario"].ToString());
                if (Session["empresa"] == null)
                {
                    Session["empresa"] = menu.RetornaCodigoEmpresaUsuario(this.Session["usuario"].ToString());
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(Convert.ToInt16(this.Session["empresa"].ToString()));
                    lbIdEmpresa.Text = Session["empresa"].ToString();
                }
                else
                {
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(Convert.ToInt16(this.Session["empresa"]));
                    lbIdEmpresa.Text = Session["empresa"].ToString();
                    this.lbFecha.Text = DateTime.Now.ToString();
                }

            }
            catch (Exception ex)
            {
            }
        }
    }
    protected void btnIniciarSesion_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            switch (menu.ActualizaIdSysUsuario(
            this.Session["usuario"].ToString(),
            this.txtContrasenaAnterior.Text,
            this.txtContrasenaNueva.Text))
            {
                case 0:
                    this.Session["clave"] = txtContrasenaNueva.Text;
                    this.Clave.Value = this.Session["clave"].ToString();
                    this.ResolveUrl("~/Inicio.aspx?clave=" + this.Session["clave"].ToString() + "&usuario=" + this.Session["usuario"].ToString() + "'");
                    break;
            }
        }
        catch (Exception ex)
        {
        }
    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            Session["empresa"] = this.gvLista.SelectedRow.Cells[1].Text;
            this.lbIdEmpresa.Text = this.Session["empresa"].ToString();
            this.lbEmpresa.Text = menu.RetornaNombreEmpresa(Convert.ToInt16(this.Session["empresa"].ToString()));
            this.lbFecha.Text = DateTime.Now.ToString();
            this.gvLista.DataSource = menu.SeleccionaEmpresaUsuario(Convert.ToString(Session["usuario"]));
            this.gvLista.DataBind();

            seguridad.InsertaLog(Convert.ToString(Session["usuario"]), "IN", ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
                    "ex", "Cambio de empresa", ObtenerIP(), Convert.ToInt16(this.Session["empresa"].ToString()));
        }
        catch (Exception ex)
        {
        }
    }
    protected void imbPrincipal_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(menu.SeleccionaMenuPrincipal(this.Session["usuario"].ToString(), this.Session["clave"].ToString(), Convert.ToInt16(this.Session["empresa"])));
    }
    #endregion Metodos
}