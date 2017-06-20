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
                script = "<script language='javascript'>Visualizacion('Conceptos');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Nomi02":
                script = "<script language='javascript'>Visualizacion('Funcionarios');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Nomi03":
                script = "<script language='javascript'>Visualizacion('Contratos');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Nomi04":
                script = "<script language='javascript'>Visualizacion('TrabajadoresxCcosto');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui01":
                script = "<script language='javascript'>Visualizacion('Preliquidacion');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui02":
                script = "<script language='javascript'> Visualizacion('RegistroNovedades');</script>";
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
            case "liqui13":
                script = "<script language='javascript'> Visualizacion('LiquidacionHoras');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui14":
                script = "<script language='javascript'> Visualizacion('LiquidacionHorasTotales');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "liqui30":
                script = "<script language='javascript'> Visualizacion('IBCSeguridadSocialPeriodo');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "resu01":
                script = "<script language='javascript'>Visualizacion('ResumenGrupoConceptoxAño');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "des01":
                script = "<script language='javascript'>Visualizacion('DescuentosLiquidacionNomina');</script>";
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
            case "admon04":
                script = "<script language='javascript'>" + "Visualizacion('ListaPrecioLote');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Resu01":
                script = "<script language='javascript'>" + "Visualizacion('ResumeLaboresxFecha');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "Resu02":
                script = "<script language='javascript'>" + "Visualizacion('ResumeLaboresxFechaPagada');</script>";
                Page.RegisterStartupScript("Visualizacion", script);
                break;
            case "labo01":
                script = "<script language='javascript'>" + "Visualizacion('Labores');</script>";
                Page.RegisterStartupScript("Labores", script);
                break;
            case "conta01":
                script = "<script language='javascript'>Visualizacion('ContabilizaciónNomina x Periodo');</script>";
                Page.RegisterStartupScript("ContabilizaciónNomina", script);
                break;
            case "para01":
                script = "<script language='javascript'>Visualizacion('ParametrizacionContabilizacion');</script>";
                Page.RegisterStartupScript("ParametrizacionContabilizacion", script);
                break;
            case "Cont02":
                script = "<script language='javascript'>Visualizacion('ConceptosFaltantesCont');</script>";
                Page.RegisterStartupScript("ConceptosFaltantesCont", script);
                break;
            case "Cont03":
                script = "<script language='javascript'>Visualizacion('InformexConceptos');</script>";
                Page.RegisterStartupScript("ConceptosFaltantesCont", script);
                break;
            case "Cont04":
                script = "<script language='javascript'>Visualizacion('ContabilizacionNominaPeriodoTercero');</script>";
                Page.RegisterStartupScript("ContabilizacionNominaPeriodoTercero", script);
                break;

        }
    }
    }
