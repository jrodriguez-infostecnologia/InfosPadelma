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
                this.lbNombreUsuario.Text = menu.RetornaNombreUsuario(
                    this.Session["usuario"].ToString());

                if (Session["empresa"] == null)
                {
                    Session["empresa"] = menu.RetornaCodigoEmpresaUsuario(
                    this.Session["usuario"].ToString());
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(
                       Convert.ToInt16(this.Session["empresa"].ToString()));
                }
                else
                {
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(
                       Convert.ToInt16(this.Session["empresa"]));
                    this.lbFecha.Text = DateTime.Now.ToString();
                }


                //this.imgUser.ImageUrl = ConfigurationManager.AppSettings["urlFoto"] + menu.SeleccionaFoto(this.Session["usuario"].ToString()) + ".png";
                //int NewWidth = (int)(50);
                //int NewHeight = (int)(50);
                //System.Drawing.Bitmap bmpOut = new System.Drawing.Bitmap(NewWidth, NewHeight);
                //System.Drawing.Graphics g = System.Drawing.Graphics.FromImage(bmpOut);
                //g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
                //g.FillRectangle(System.Drawing.Brushes.White, 0, 0, NewWidth, NewHeight);
                //g.DrawImage(new System.Drawing.Bitmap(ConfigurationManager.AppSettings["urlFoto"] + menu.SeleccionaFoto(this.Session["usuario"].ToString()) + ".png"), 0, 0, NewWidth, NewHeight);
                //String saveImagePath = ConfigurationManager.AppSettings["UrlFotoMin"] + menu.SeleccionaFoto(this.Session["usuario"].ToString()) + ".png";
                //bmpOut.Save(saveImagePath);
                //this.imgUser.ImageUrl = ConfigurationManager.AppSettings["UrlFotoMin"] + menu.SeleccionaFoto(this.Session["usuario"].ToString()) + ".png";

            }
            catch (Exception ex)
            {
                //lblInformacion.Text = "Error al cargar el menu. Correspondiente a: " + ex.Message;
            }
        }


    }

    protected void imbPrincipal_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(menu.SeleccionaMenuPrincipal(this.Session["usuario"].ToString(), this.Session["clave"].ToString(), Convert.ToInt16(this.Session["empresa"])));
    }
}