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
                    "Visualizacion('BasculaVehiculos');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Bascula06":

                script = "<script language='javascript'>" +
                    "Visualizacion('BasculaProcedencia');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Bascula07":

                script = "<script language='javascript'>" +
                    "Visualizacion('BasculaProducto');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Bascula08":

                script = "<script language='javascript'>" +
                    "Visualizacion('BasculaDia');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Porteria01":

                script = "<script language='javascript'>" +
                    "Visualizacion('ConsultaPorteria');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "pro01":

                script = "<script language='javascript'>" +
                    "Visualizacion('ProduccionDiario');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "pro02":

                script = "<script language='javascript'>" +
                    "Visualizacion('ProduccionMensual');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "pro03":

                script = "<script language='javascript'>" +
                    "Visualizacion('ProduccionAnual');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "pro04":

                script = "<script language='javascript'>" +
                    "Visualizacion('ProduccionCorte');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "pro05":

                script = "<script language='javascript'>" +
                    "Visualizacion('FrutaDiferencial');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "pro06":

                script = "<script language='javascript'>" +
                    "Visualizacion('FrutaRango');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "pro07":

                script = "<script language='javascript'>" +
                    "Visualizacion('FrutaRangoResumen');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;


            case "pro08":

                script = "<script language='javascript'>" +
                    "Visualizacion('FrutaPeriodo');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "pro09":

                script = "<script language='javascript'>" +
                    "Visualizacion('FrutaAnual');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "calidad01":

                script = "<script language='javascript'>" +
                    "Visualizacion('AnalisisF');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "calidad02":

                script = "<script language='javascript'>" +
                    "Visualizacion('AnalisisFecha');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "calidad03":

                script = "<script language='javascript'>" +
                    "Visualizacion('AnalisisPonderado');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

	case "cer01":

                script = "<script language='javascript'>" +
                    "Visualizacion('InventarioCertificados');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
        }
    }
}