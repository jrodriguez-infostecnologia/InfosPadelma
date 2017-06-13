using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bascula_Pinformes_Visualizacion : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void tvInformes_SelectedNodeChanged(object sender, EventArgs e)
    {
        string script = "";

        switch (((TreeView)sender).SelectedNode.Value.ToString())
        {
            case "Bascula01":

                script = "<script language='javascript'>" +
                    "Visualizacion('EstadoRemision');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Bascula02":

                script = "<script language='javascript'>" +
                    "Visualizacion('BasculaDetalle');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Bascula03":

                script = "<script language='javascript'>" +
                    "Visualizacion('BasculaFecha');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Bascula04":

                script = "<script language='javascript'>" +
                    "Visualizacion('ProduccionDiario');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Bascula05":

                script = "<script language='javascript'>" +
                    "Visualizacion('RemisionMp');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Porteria01":

                script = "<script language='javascript'>" +
                    "Visualizacion('ConsultaPorteria');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

        }
    }
}