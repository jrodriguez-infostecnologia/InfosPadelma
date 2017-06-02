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

public partial class Facturacion_Error : System.Web.UI.Page
{
    #region Eventos

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.Session["usuario"] == null)
            {
                this.Response.Redirect("~/Inicio.aspx");
            }
            else
            {
                this.lblError.Text = this.Session["error"].ToString();
            }
        }

        
        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            this.Response.Redirect(this.Session["paginaAnterior"].ToString());
        }

    #endregion Eventos

       
}
