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
            case "Nomi01":

                script = "<script language='javascript'>" +
                    "Visualizacion('Conceptos');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "Nomi02":

                script = "<script language='javascript'>" +
                    "Visualizacion('Funcionarios');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "ingre01":

                script = "<script language='javascript'>" +
                    "Visualizacion('IngresoReteDetalle');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "Nomi03":

                script = "<script language='javascript'>" +
                    "Visualizacion('Contratos');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Nomi04":

                script = "<script language='javascript'>" +
                    "Visualizacion('TrabajadoresxCcosto');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui01":
                script = "<script language='javascript'>" +
                    "Visualizacion('Preliquidacion');" +
                    "</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui02":
               script = "<script language='javascript'> Visualizacion('RegistroNovedades');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui45":
               script = "<script language='javascript'> Visualizacion('NovedadDetalle');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
	   case "liqui46":
               script = "<script language='javascript'> Visualizacion('FormatoIR');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui03":
                script = "<script language='javascript'> Visualizacion('NovedadesPeriodicas');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui04":
                script = "<script language='javascript'> Visualizacion('NovedadesTrabajadorFecha');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui05":
                script = "<script language='javascript'> Visualizacion('ResumenPrenomina');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "liqui06":
                script = "<script language='javascript'> Visualizacion('liquidacionNomina');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui07":
                script = "<script language='javascript'> Visualizacion('ResumenLiquidacion');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui08":
                script = "<script language='javascript'> Visualizacion('PagoNominaPeriodo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui09":
                script = "<script language='javascript'> Visualizacion('DesprendibleNomina');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui10":
                script = "<script language='javascript'> Visualizacion('ResumenDescuentos');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui11":
                script = "<script language='javascript'> Visualizacion('SeguridadSocialPeriodo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui12":
                script = "<script language='javascript'> Visualizacion('AcumuladosTerceroPeriodo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui50":
                script = "<script language='javascript'> Visualizacion('AcumuladosTerceroAño');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui13":
                script = "<script language='javascript'> Visualizacion('LiquidacionHoras');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui14":
                script = "<script language='javascript'> Visualizacion('LiquidacionHorasTotales');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui15":
                script = "<script language='javascript'> Visualizacion('Laboresnopagadasfecha');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui16":
                script = "<script language='javascript'> Visualizacion('RelacionNovedadesPeriodo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui17":
                script = "<script language='javascript'> Visualizacion('RelacionDescuentosTercero');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Nomi05":
                script = "<script language='javascript'> Visualizacion('VencerContratos');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui18":
                script = "<script language='javascript'> Visualizacion('IBCTrabajador');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui20":
                script = "<script language='javascript'> Visualizacion('liquidacionNominaTrabajador');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui21":
                script = "<script language='javascript'> Visualizacion('ResumenLiquidacionMes');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui22":
                script = "<script language='javascript'> Visualizacion('SeguridadSocialEntidades');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui23":
                script = "<script language='javascript'> Visualizacion('VacacionesxPeriodo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui24":
                script = "<script language='javascript'> Visualizacion('LiquidacionNominaInforme');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui25":
                script = "<script language='javascript'> Visualizacion('ConsolidadoVacaciones');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "liqui30":
                script = "<script language='javascript'> Visualizacion('IBCSeguridadSocialPeriodo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "liqui31":
                script = "<script language='javascript'> Visualizacion('InformeSeguridadSocialNomina');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;

            case "presta01":
                script = "<script language='javascript'> Visualizacion('AcumuladosPrestaciones');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "presta02":
                script = "<script language='javascript'> Visualizacion('PreLiquidacionPrimas');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "presta05":
                script = "<script language='javascript'> Visualizacion('liquidacionContratoInforme');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "nove01":
                script = "<script language='javascript'> Visualizacion('Prestamos');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui28":
                script = "<script language='javascript'> Visualizacion('Ausentismos');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui29":
                script = "<script language='javascript'> Visualizacion('DescuentosLiquidacionNomina');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Cont01":
                script = "<script language='javascript'> Visualizacion('ContratosDestajos');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
        }
    }
}