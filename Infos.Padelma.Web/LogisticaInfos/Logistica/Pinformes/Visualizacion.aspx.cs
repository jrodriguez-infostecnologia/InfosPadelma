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
            case "Log01":

                script = "<script language='javascript'>" +
                    "Visualizacion('ProgramacionesFecha');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "Log02":

                script = "<script language='javascript'>" +
                    "Visualizacion('DespachosRango');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "Log03":

                script = "<script language='javascript'>" +
                    "Visualizacion('DespachoEstado');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Log04":
                script = "<script language='javascript'>Visualizacion('ProveedorCastigo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Log05":
                script = "<script language='javascript'>Visualizacion('ProveedorMaquila');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
        }
    }
}