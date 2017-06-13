<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImprimeTrans.aspx.cs" Inherits="Bascula_Pinformes_ImprimeTrans" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="width: 100%" class="principal">

            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                    <td style="text-align: center;">Impresion de transacciones</td>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">&nbsp;</td>
                    <td style="text-align: center;">
                        <table cellpadding="0" cellspacing="0" style="WIDTH: 950px">
                            <tr>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                                <td style="WIDTH: 200px; text-align: left;">
                                    <asp:Label ID="Label1" runat="server" Text="Tipo de Transacción"></asp:Label>
                                </td>
                                <td style="WIDTH: 500px; text-align: left;">
                                    <asp:DropDownList ID="ddlTipoDocumento" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged" Width="350px">
                                    </asp:DropDownList>
                                </td>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                                <td style="WIDTH: 200px; text-align: left;">
                                    <asp:Label ID="Label2" runat="server" Text="Número de Transacción"></asp:Label>
                                </td>
                                <td style="WIDTH: 500px; text-align: left;">
                                    <asp:TextBox ID="txtNumero" runat="server" CssClass="input" Width="200px"></asp:TextBox>
                                    &nbsp;
                        <asp:ImageButton ID="imbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="imbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" />
                                </td>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="WIDTH: 200px; HEIGHT: 19px">&nbsp;</td>
                                <td style="WIDTH: 200px; HEIGHT: 19px"></td>
                                <td style="WIDTH: 500px; HEIGHT: 19px">
                                    <asp:RadioButtonList ID="rblFormato" runat="server" BorderStyle="None" RepeatDirection="Horizontal" Visible="False">
                                        <asp:ListItem Selected="True" Value="01">Despachos</asp:ListItem>
                                        <asp:ListItem Value="02">Entrada Materia Prima</asp:ListItem>
                                        <asp:ListItem Value="03">Pesajes</asp:ListItem>
                                    </asp:RadioButtonList>
                                </td>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="4">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">&nbsp;</td>
                </tr>
            </table>

            <table style="width: 100%; height: 700px;" cellspacing="0">
                <tr>
                    <td style="vertical-align: top; width: 100%; text-align: left; height: 700px;">

                        <rsweb:ReportViewer ID="rvTransaccion" runat="server" ProcessingMode="Remote" Width="100%">
                        </rsweb:ReportViewer>

                    </td>
                </tr>
            </table>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
