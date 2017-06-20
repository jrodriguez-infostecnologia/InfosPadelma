<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TrasladoSaldos.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" Theme="Entidades" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Seguridad</title>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div style="vertical-align: top; width: 1000px; height: 600px; text-align: center">
        <table cellspacing="0" style="width: 1000px">
            <tr>
                <td style="background-image: url(../../Imagenes/botones/BotonIzq.png);
                    width: 250px; background-repeat: no-repeat; height: 25px; text-align: left;">
                    </td>
                <td style="width: 100px; height: 25px; text-align: left">
                    </td>
                <td style="width: 350px; height: 25px; text-align: left">
                    </td>
                <td style="width: 50px; height: 25px; text-align: left">
                    </td>
                <td style="background-image: url(../../Imagenes/botones/BotonDer.png);
                    width: 250px; background-repeat: no-repeat; height: 25px; text-align: right; background-position-x: right;">
                </td>
            </tr>
        </table>
        <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1" onclick="return TABLE1_onclick()">
            <tr>
                <td style="width: 230px; height: 15px; background-color: FloralWhite; text-align: right;">
                    <asp:LinkButton ID="nilbNuevo" runat="server" ForeColor="#404040" OnClick="lbNuevo_Click" ToolTip="Habilita el formulario para un nuevo registro">>> Nuevo Registro</asp:LinkButton><asp:LinkButton ID="lbCancelar" runat="server" ForeColor="#404040" Visible="False" OnClick="lbCancelar_Click" ToolTip="Cancela la operación"><< Cancelar</asp:LinkButton></td>
                <td style="width: 160px; height: 15px; text-align: left; background-color: FloralWhite;">
                    </td>
                <td style="width: 380px; height: 15px; text-align: left; background-color: FloralWhite; vertical-align: top;">
                    <asp:Label ID="nilblInformacion" runat="server" ForeColor="#404040"></asp:Label></td>
                <td style="width: 230px; height: 15px; background-color: FloralWhite; text-align: left">
                    <asp:LinkButton ID="lbRegistrar" runat="server" ForeColor="#404040" OnClick="lbRegistrar_Click"
                        onclientclick="if(!confirm('Desea insertar el registro ?')){return false;};"
                        Visible="False" ToolTip="Guarda el nuevo registro en la base de datos">>> Registrar</asp:LinkButton></td>
            </tr>
            <tr>
                <td style="width: 250px">
                </td>
                <td style="width: 140px; text-align: left">
                </td>
                <td style="width: 360px; text-align: left; vertical-align: top; background-color: transparent;">
                </td>
                <td style="width: 250px">
                </td>
            </tr>
            <tr>
                <td style="width: 250px">
                </td>
                <td style="width: 140px; text-align: left">
                    <asp:Label ID="lblPeriodo" runat="server" Visible="False">Año</asp:Label></td>
                <td style="vertical-align: top; width: 360px; background-color: transparent; text-align: left">
                    <asp:DropDownList ID="ddlAno" runat="server" OnSelectedIndexChanged="ddlAno_SelectedIndexChanged"
                        Visible="False" Width="200px">
                    </asp:DropDownList></td>
                <td style="width: 250px">
                </td>
            </tr>
            <tr>
                <td style="width: 250px">
                </td>
                <td style="width: 140px; text-align: left">
                    <asp:Label ID="lblMes" runat="server" Visible="False">Mes</asp:Label></td>
                <td style="vertical-align: top; width: 360px; background-color: transparent; text-align: left">
                    <asp:DropDownList ID="ddlMes" runat="server" Visible="False" Width="200px">
                        <asp:ListItem Value="1">Enero</asp:ListItem>
                        <asp:ListItem Value="2">Febrero</asp:ListItem>
                        <asp:ListItem Value="3">Marzo</asp:ListItem>
                        <asp:ListItem Value="4">Abril</asp:ListItem>
                        <asp:ListItem Value="5">Mayo</asp:ListItem>
                        <asp:ListItem Value="6">Junio</asp:ListItem>
                        <asp:ListItem Value="7">Julio</asp:ListItem>
                        <asp:ListItem Value="8">Agosto</asp:ListItem>
                        <asp:ListItem Value="9">Septiembre</asp:ListItem>
                        <asp:ListItem Value="10">Octubre</asp:ListItem>
                        <asp:ListItem Value="11">Noviembre</asp:ListItem>
                        <asp:ListItem Value="12">Diciembre</asp:ListItem>
                    </asp:DropDownList></td>
                <td style="width: 250px">
                </td>
            </tr>
            <tr>
                <td style="width: 250px;">
                </td>
                <td style="width: 140px; text-align: left">
                </td>
                <td style="width: 360px; text-align: left; vertical-align: top; background-color: transparent;">
                </td>
                <td style="width: 250px;">
                </td>
            </tr>
            <tr>
                <td style="width: 230px; background-color: FloralWhite; text-align: left; height: 15px;">
                </td>
                <td style="width: 160px; background-color: FloralWhite; text-align: left; height: 15px;">
                </td>
                <td style="width: 380px; background-color: FloralWhite; text-align: left; height: 15px; vertical-align: top;">
                    <asp:Label ID="nilblMensaje" runat="server"></asp:Label></td>
                <td style="width: 230px; background-color: FloralWhite; text-align: left; height: 15px;">
                    </td>
            </tr>
        </table><table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;">
            <tr>
                <td style="width: 1000px; text-align: center">
                </td>
            </tr>
            <tr>
                <td style="width: 1000px; text-align: left">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="width: 1000px; text-align: center">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
