using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nomina_Pliquidacion_GenerarPlano : System.Web.UI.Page
{
    CpagosNomina pagosNomina = new CpagosNomina();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");

        }
        else {

            if (!IsPostBack)
            {
               
                int periodo=Convert.ToInt32(this.Request.QueryString["periodo"].ToString());
                int año=Convert.ToInt32(this.Request.QueryString["año"].ToString());
                int empresa=Convert.ToInt32(this.Request.QueryString["empresa"].ToString());
                string texto = this.Session["textoPlano"].ToString();
                

                string nombre = pagosNomina.RetornaNombreArchivoPlano(empresa, año, periodo);             
                generarPlano(texto,nombre);

                string script = "<script language='javascript'>" +
                            "window.close();" +
                            "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
            }

        }
             

    }

    protected void generarPlano(string texto, string nombre)
    {
        StringBuilder sb = new StringBuilder();
        string output = texto;
        sb.Append(output);
        sb.Append("\r\n");

        string text = sb.ToString();

        Response.Clear();
        Response.ClearHeaders();

        Response.AddHeader("Content-Length", text.Length.ToString());
        Response.ContentType = "text/plain";
        Response.AppendHeader("content-disposition", "attachment;filename=\"PlanoBancoPerido" + nombre+ DateTime.Now.ToShortDateString() + ".txt\"");

        Response.Write(text);
        Response.End();
        
    }
}