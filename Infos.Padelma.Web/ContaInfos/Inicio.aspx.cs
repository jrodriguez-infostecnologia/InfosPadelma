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
using System.Configuration;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Net;

public partial class Inicio : System.Web.UI.Page
{
    #region Entidades

    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();

    #endregion Entidades

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string usuario = "", clave = "";
            int empresa;

            if (Request.QueryString["usuario"] != null && Request.QueryString["clave"] != null)
            {
                usuario = Convert.ToString(Request.QueryString["usuario"]);
                clave = Convert.ToString(Request.QueryString["clave"]);
                empresa = Convert.ToInt16(Request.QueryString["empresa"]);
                try
                {
                    switch (seguridad.ValidarUsuario(
                               usuario,
                               clave,
                               ConfigurationManager.AppSettings["Modulo"].ToString()))
                    {
                        case 0:

                            seguridad.InsertaLog(
                            usuario,
                            "IN",
                            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
                            "ex",
                            "Entro al Sistema Satisfactoriamente",
                            ObtenerIP(), empresa);

                            this.Session["usuario"] = usuario;
                            this.Session["clave"] = clave;
                            this.Session["empresa"] = empresa;
                            Response.Redirect("~/Contabilidad/MenuInfos.aspx", false);
                            break;


                        case 1:

                            seguridad.InsertaLog(
                             usuario,
                             "IN",
                             ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
                             "er",
                             "Error de usuario o contraseña",
                             ObtenerIP(), empresa);

                            if (usuario == "" && clave == "" && empresa == 0)
                            {
                                this.lblMensaje.Text = "";
                                break;

                            }
                            else
                            {

                                this.lblMensaje.Text = "Usuario / Contraseña errada";
                                break;
                            }
                    }
                }
                catch (Exception ex)
                {
                    seguridad.InsertaLog(
                             usuario,
                             "IN",
                             ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
                             "ex",
                             "Entro al Sistema Satisfactoriamente",
                             ObtenerIP(), empresa);

                    this.lblMensaje.Text = "!!Error del sistema " + ex.Message;
                }

            }
            else
                this.txtUsuario.Focus();
        }

    }

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


    protected void imbIniciarSesion_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (txtUsuario.Text.Length == 0 || txtClave.Text.Length == 0)
            {
                lblMensaje.Text = "Debe digitar un usuario y contraseña";
                return;
            }

            switch (seguridad.ValidarUsuario(                        this.txtUsuario.Text,                        this.txtClave.Text,                        ConfigurationManager.AppSettings["Modulo"].ToString()))
            {
                case 0:
                    seguridad.InsertaLog(                        this.txtUsuario.Text,                        "IN",                        ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
                        "ex",                        "Entro al Sistema Satisfactoriamente",                        ObtenerIP(), 0);
                    this.Session["usuario"] = this.txtUsuario.Text;
                    this.Session["clave"] = this.txtClave.Text;
                    Response.Redirect("~/Contabilidad/MenuInfos.aspx", false);
                    break;

                case 1:
                    seguridad.InsertaLog(                        this.txtUsuario.Text,                        "IN",                        ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
                        "er",                        "Error de usuario o contraseña",                        ObtenerIP(), 0);
                    this.lblMensaje.Text = "Error de usuario o contraseña";
                    break;
            }
        }
        catch (Exception ex)
        {
            seguridad.InsertaLog(this.txtUsuario.Text, "IN", this.Page.ToString(), "er", "!!Error del sistema " + ex.Message, ObtenerIP(), 0);
            this.lblMensaje.Text = "!!Error del sistema " + ex.Message;
        }
    }

    #endregion Eventos
}



