<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImpresionRemision.aspx.cs" Inherits="Seguridad_Poperaciones_ImpresionRemision" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>



<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Calendarios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <table  style="width: 950px;" cellspacing="0" >
                <tr>
                    <td class="bordes">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                    <td>Impresión de Remisiones Materia Prima</td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes">
                        <asp:ImageButton ID="nilblRegresar" runat="server" ToolTip="Regresar" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="nilblRegresar_Click" />
                    </td>
                    <td>
                        <asp:LinkButton ID="lbActivar" runat="server" ForeColor="#003366" OnClick="lbActivar_Click">Activar remisiones en estado generado</asp:LinkButton>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td>
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td></td>
                    <td class="bordes"></td>
                </tr>
            </table>
            <div style="text-align: center; width: 950px">
                <div style="display: inline-block">
                    <rsweb:ReportViewer ID="rvRemision" runat="server" Width="950px">
                    </rsweb:ReportViewer>
                </div>
            </div>

        </div>
    </form>
</body>
</html>
