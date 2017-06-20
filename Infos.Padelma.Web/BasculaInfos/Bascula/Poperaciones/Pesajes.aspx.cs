using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bascula_Poperaciones_Pesajes : System.Web.UI.Page
{
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
                this.Session["tipomovpes"] = ConfigurationManager.AppSettings["Pesaje"];
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
                this.Session["paginapes"] = "RegistrarDatosPesajePP.aspx";
                this.Session["tipoPeso"] = "PP";
            }
            else
            {
                this.Session["paginapes"] = "RegistrarDatosPesajeSP.aspx";
                this.Session["tipoPeso"] = "SP";
            }

            this.Session["entradapes"] = "Pesajes.aspx";
           // this.Session["placapes"] = Convert.ToString(this.ddlOperacion.SelectedValue);
            Response.Redirect("CapturaPesoPES.aspx", false);
        }

    }
}