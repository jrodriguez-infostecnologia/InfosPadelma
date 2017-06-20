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
            case "tra001":
                script = "<script language='javascript'>" + "Visualizacion('DiferenciaLoteCorte');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran01":
                script = "<script language='javascript'>" + "Visualizacion('InformeGeneralLabores');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran02":
                script = "<script language='javascript'>" + "Visualizacion('TiquetesAgronomico');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran03":
                script = "<script language='javascript'>" + "Visualizacion('LaboresFechaTercero');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran04":
                script = "<script language='javascript'>" + "Visualizacion('LaboresFechaCentroCosto');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran05":
                script = "<script language='javascript'>" + "Visualizacion('LaboresDetalles');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran06":
                script = "<script language='javascript'>" + "Visualizacion('LaboresFechaLote');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran07":
                script = "<script language='javascript'>" + "Visualizacion('ProduccionFrutaLote');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran13":
                script = "<script language='javascript'>" + "Visualizacion('ProduccionFrutaLoteAnual');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran08":
                script = "<script language='javascript'>" + "Visualizacion('TiquetesFrutaFecha');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran09":
                script = "<script language='javascript'>" + "Visualizacion('LiquidacionContratista');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran10":
                script = "<script language='javascript'>" + "Visualizacion('LiquidacionContratistaLote');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran11":
                script = "<script language='javascript'>" + "Visualizacion('ResumenContratista');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran12":
                script = "<script language='javascript'>" + "Visualizacion('LaboresFechaLoteMes');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon01":
                script = "<script language='javascript'>" + "Visualizacion('LotesFincaSeccion');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon02":
                script = "<script language='javascript'>" + "Visualizacion('PesoPromedioLote');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon03":
                script = "<script language='javascript'>" + "Visualizacion('Labores');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon07":
                script = "<script language='javascript'>" + "Visualizacion('LotesFincaSeccionVariedad');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon08":
                script = "<script language='javascript'>" + "Visualizacion('LotesFincaSeccionSiembra');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon04":
                script = "<script language='javascript'>" + "Visualizacion('ListaPrecioLote');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon05":
                script = "<script language='javascript'>" + "Visualizacion('FincalLoteCanal');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran15":
                script = "<script language='javascript'>" + "Visualizacion('TiquetesFrutaFechaPendiente');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran16":
                script = "<script language='javascript'>" + "Visualizacion('IndicadorAgronomico');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran17":
                script = "<script language='javascript'>" + "Visualizacion('CiclosCorte');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "san01":
                script = "<script language='javascript'>" + "Visualizacion('GrupoCaracteristica');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "san02":
                script = "<script language='javascript'>" + "Visualizacion('SanidadDetallado');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "admon06":
                script = "<script language='javascript'>" + "Visualizacion('LotesLineaPalma');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "tran18":
                script = "<script language='javascript'>" + "Visualizacion('HVLotesNovedad');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "fer01":
                script = "<script language='javascript'>" + "Visualizacion('PlanFertilizacionSaldo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "fer02":
                script = "<script language='javascript'>" + "Visualizacion('LaboresFechaLoteFertilizacion');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "fer03":
                script = "<script language='javascript'>" + "Visualizacion('LaboresFertilizacionDetalle');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

        }
    }
}