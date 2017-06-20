<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImprimirTrn.aspx.cs" Inherits="Administracion_Caracterizacion" Theme="Entidades"%>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
        
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Impresión</title>     
        
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js" language="javascript" type="text/javascript"></script>
        
</head>
<body style="text-align: left">
    <form id="form1" runat="server">
    <div style="text-align: left">
    
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px;
                        background-repeat: no-repeat; height: 25px; text-align: left">
                        </td>
                    <td style="width: 500px; height: 25px; text-align: center; vertical-align: top;">
                        Impresión de Transacciones</td>
                    <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png);
                        width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">
                        </td>
                </tr>
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px;
                        background-repeat: no-repeat; text-align: left">
                    </td>
                    <td style="vertical-align: top; width: 500px; text-align: center">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label></td>
                    <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png);
                        width: 250px; background-repeat: no-repeat; text-align: left">
                    </td>
                </tr>
            </table>
        <table cellpadding="0" cellspacing="0" style="width: 1000px">
            <tr>
                <td style="width: 150px; height: 10px;">
                </td>
                <td style="width: 200px; height: 10px;">
                </td>
                <td style="width: 500px; height: 10px;">
                </td>
                <td style="width: 150px; height: 10px;">
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="width: 200px">
                    <asp:Label ID="Label1" runat="server" Text="Tipo de Transacción"></asp:Label></td>
                <td style="width: 500px">
                    <asp:DropDownList ID="ddlTipoTransaccion" runat="server" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoTransaccion_SelectedIndexChanged">
                    </asp:DropDownList></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="width: 200px">
                    <asp:Label ID="Label2" runat="server" Text="Número de Transacción"></asp:Label></td>
                <td style="width: 500px">
                    <asp:TextBox ID="txtNumero" runat="server" Width="200px"></asp:TextBox>&nbsp;
                    <asp:ImageButton ID="imbBuscar" runat="server" Height="17px" ImageUrl="~/Imagenes/Ver.png"
                        OnClick="imbBuscar_Click" Width="17px" /></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 19px">
                </td>
                <td style="width: 200px; height: 19px">
                </td>
                <td style="width: 500px; height: 19px">
                    <asp:RadioButtonList ID="rblFormato" runat="server" BorderStyle="None" RepeatDirection="Horizontal"
                        Visible="False">
                        <asp:ListItem Selected="True" Value="01">Pre Impreso</asp:ListItem>
                        <asp:ListItem Value="02">Formato Sistema</asp:ListItem>
                    </asp:RadioButtonList></td>
                <td style="width: 150px; height: 19px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 10px;">
                </td>
                <td style="width: 200px; height: 10px;">
                </td>
                <td style="width: 500px; height: 10px;">
                </td>
                <td style="width: 150px; height: 10px;">
                </td>
            </tr>
        </table>

        <table style="width: 1000px; height: 700px;" cellspacing="0">
            <tr>
                <td style="vertical-align: top; width: 1000px; text-align: left; height: 700px;">
                    <rsweb:ReportViewer ID="rvTransaccion" runat="server" Font-Names="Verdana" Font-Size="8pt"
                        Height="700px" ProcessingMode="Remote" Width="1000px" Visible="False">
                        <ServerReport ReportServerUrl="" />
                    </rsweb:ReportViewer>
                </td>
            </tr>
        </table>
        <br />

        </div>        
    </form>
</body>
</html>
