<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImprimeTiquete.aspx.cs" Inherits="Bascula_Poperaciones_ImprimeTiquete" %>

<%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>

</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: left">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: none; width: 250px; height: 25px; text-align: left; background-color: transparent;">
                        <asp:ImageButton ID="lbNuevoPeso" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevoPeso.png" OnClick="lbNuevoPeso_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevoPeso.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevoPesoN.png'" ToolTip="Continúa con la operación" Visible="False" />
                    </td>
                    <td style="width: 500px; height: 25px; text-align: center; vertical-align: top; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; color: #003366;" class="auto-style1"><strong>Impresión de Tiquete</strong></td>
                    <td style="background-image: none; width: 250px; height: 25px; text-align: left">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 1000px; height: 700px;">
                <tr>
                    <td style="vertical-align: top; width: 1000px; text-align: left; height: 700px;" >
                              <rsweb:ReportViewer ID="rvTiquete" runat="server" Width="100%" Height="100%" ProcessingMode="Remote" ShowBackButton="False" ShowCredentialPrompts="False" ShowExportControls="False" ShowFindControls="False" ShowPageNavigationControls="False" ShowParameterPrompts="False" ShowZoomControl="False">
                    </rsweb:ReportViewer>
                    

                        <%--ID="rvTiquete" runat="server" Font-Names="Verdana" Font-Size="8pt" Height="1000px" ProcessingMode="Remote" ShowBackButton="True" ShowCredentialPrompts="False" ShowDocumentMapButton="False" ShowExportControls="False" ShowFindControls="False" ShowPageNavigationControls="False" ShowParameterPrompts="False" ShowPromptAreaButton="False" ShowRefreshButton="False" ShowZoomControl="False" Width="1000px">
                                    <ServerReport ReportServerUrl=""  />
                                </rsweb:ReportViewer>--%>
                    </td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
