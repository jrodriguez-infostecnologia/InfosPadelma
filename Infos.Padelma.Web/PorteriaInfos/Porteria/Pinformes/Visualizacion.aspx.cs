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
            case "por01":
                script = "<script language='javascript'> Visualizacion('VehiculosPlanta');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "por02":
                script = "<script language='javascript'> Visualizacion('PersonalEnPlanta');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "por03":
                script = "<script language='javascript'> Visualizacion('ContratistasEnPlanta');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            
        }
    }
}