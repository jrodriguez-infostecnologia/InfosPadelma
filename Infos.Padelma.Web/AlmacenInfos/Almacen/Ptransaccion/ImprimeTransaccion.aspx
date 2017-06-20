<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImprimeTransaccion.aspx.cs" Inherits="Administracion_Caracterizacion" Theme="Entidades"%>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>        

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Impresión</title>             
</head>
<body style="text-align: left">
    <form id="form1" runat="server">
    <div style="text-align: left">
    
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: none; width: 250px; height: 25px; text-align: left; background-color: transparent;">
                        <asp:LinkButton ID="lbRegresar" runat="server" ForeColor="#404040" OnClick="lbNuevoPeso_Click"
                            ToolTip="Clic aquí para regresar a las transacciones"><< Regresar</asp:LinkButton></td>
                    <td style="width: 500px; height: 25px; text-align: center; vertical-align: top;">
                        Impresión de Transacción</td>
                    <td style="background-image: none;
                        width: 250px; height: 25px; text-align: left">
                        </td>
                </tr>
            </table>

        <table style="width: 1000px; height: 700px;" cellspacing="0">
            <tr>
                <td style="vertical-align: top; width: 1000px; text-align: left; height: 700px;">
                                <rsweb:ReportViewer ID="rvTransaccion" runat="server" Height="1000px" Width="1000px" Font-Names="Verdana" Font-Size="8pt" ProcessingMode="Remote" ShowBackButton="True" ShowCredentialPrompts="False" ShowDocumentMapButton="False" ShowExportControls="False" ShowFindControls="False" ShowPageNavigationControls="False" ShowParameterPrompts="False" ShowPromptAreaButton="False" ShowRefreshButton="False" ShowZoomControl="False">
                                    <ServerReport ReportServerUrl="" />
                                </rsweb:ReportViewer>
                </td>
            </tr>
        </table>

        </div>        
    </form>
</body>
</html>
