﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nomina_Pliquidacion_GenerarPlano : System.Web.UI.Page
{
    Cperiodos periodos = new Cperiodos();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");

        }
        else {

            if (!IsPostBack)
            {
               
                string documento=this.Request.QueryString["documento"].ToString();
                string texto = this.Session["textoPlano"].ToString();
                generarPlano(texto,documento);
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
        string text = sb.ToString();

        Response.Clear();
        Response.ClearHeaders();

        Response.AddHeader("Content-Length", text.Length.ToString());
        Response.ContentType = "text/plain";
        Response.AppendHeader("content-disposition", "attachment;filename=\"Plano" + nombre+ DateTime.Now.ToShortDateString() + ".txt\"");

        Response.Write(text);
        Response.End();
        
    }
}