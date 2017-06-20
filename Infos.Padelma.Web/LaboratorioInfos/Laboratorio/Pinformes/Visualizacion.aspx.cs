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
            case "Balance01":

                script = "<script language='javascript'>" +
                    "Visualizacion('BalancePerdidasPeriodo');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;


            case "Transacciones01":

                script = "<script language='javascript'>" +
                    "Visualizacion('TransaccionesLaboratorioporfecha');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "Ana01":

                script = "<script language='javascript'>" +
                    "Visualizacion('ControlAnalisisVolumetrico');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
        
        }
    }
}