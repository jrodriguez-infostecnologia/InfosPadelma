using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

public partial class Infos_MenuInfos : System.Web.UI.Page
{

    #region Instancias

    cMenu menu = new cMenu();
    #endregion Instancias


    protected void Page_Load(object sender, EventArgs e)
    {
              

        if (this.Session["usuario"] == null)
        {
            if (this.Parent != null)
            {
                this.Parent.Page.Response.Redirect("~/Inicio.aspx");
            }
            else
            {
                this.Response.Redirect("~/Inicio.aspx");
            }
        }
        else
        {
            try
            {
                this.lbUsuario.Text = this.Session["usuario"].ToString();
                this.lbNombreUsuario.Text = menu.RetornaNombreUsuario(this.Session["usuario"].ToString());

                if (Session["empresa"] == null)
                {
                    Session["empresa"] = menu.RetornaCodigoEmpresaUsuario(this.Session["usuario"].ToString());
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(Convert.ToInt16(this.Session["empresa"].ToString()));
                }
                else
                {
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(
                       Convert.ToInt16(this.Session["empresa"]));
                    this.lbFecha.Text = DateTime.Now.ToString();
                }


            }
            catch (Exception ex)
            {
                //lblInformacion.Text = "Error al cargar el menu. Correspondiente a: " + ex.Message;
            }
        }


    }
    protected void btnIniciarSesion_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            //switch (menu.ActualizaIdSysUsuario(
            //this.Session["usuario"].ToString(),
            //this.txtContrasenaAnterior.Text,
            //this.txtContrasenaNueva.Text))
            //{
            //    case 0:
            //        this.Session["clave"] = txtContrasenaNueva.Text;
            //        this.Clave.Value = this.Session["clave"].ToString();
            //        this.ResolveUrl("~/Inicio.aspx?clave=" + this.Session["clave"].ToString() + "&usuario=" + this.Session["usuario"].ToString() + "'");
            //        break;

            //    //case 1:
            //    //    //ScriptManager.RegisterStartupScript(Page, this.GetType(), "msg", "(alert('Contraseña incorrecta intentelo nuevamente'));", true);
            //    //    //lblInformacion.Text = "Contraseña incorrecta intentelo nuevamente";
            //    //    break;

            //}
        }
        catch (Exception ex)
        {
            // lblInformacion.Text = "Error al cambiar la contraseña. Correspondiente a: " + ex.Message;
        }
    }
    protected void imbPrincipal_Click(object sender, ImageClickEventArgs e)
    {
 		 Response.Redirect( menu.SeleccionaMenuPrincipal( this.Session["usuario"].ToString() , this.Session["clave"].ToString(), Convert.ToInt16(this.Session["empresa"])));
    }
}