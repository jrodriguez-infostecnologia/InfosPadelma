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
            case "conta01":

                script = "<script language='javascript'>" +
                    "Visualizacion('ContabilizaciónNomina x Periodo');" +
                    "</script>";
                Page.RegisterStartupScript("ContabilizaciónNomina", script);
                break;

            case "para01":

                script = "<script language='javascript'>" +
                    "Visualizacion('ParametrizacionContabilizacion');" +
                    "</script>";
                Page.RegisterStartupScript("ParametrizacionContabilizacion", script);
                break;

            case "Cont02":

                script = "<script language='javascript'>" +
                    "Visualizacion('ConceptosFaltantesCont');" +
                    "</script>";
                Page.RegisterStartupScript("ConceptosFaltantesCont", script);
                break;

            case "Cont03":

                script = "<script language='javascript'>" +
                    "Visualizacion('InformexConceptos');" +
                    "</script>";
                Page.RegisterStartupScript("ConceptosFaltantesCont", script);
                break;


            case "Cont04":

                script = "<script language='javascript'>" +
                    "Visualizacion('ContabilizacionNominaPeriodoTercero');" +
                    "</script>";
                Page.RegisterStartupScript("ContabilizacionNominaPeriodoTercero", script);
                break;


  
                
        }
    }
}