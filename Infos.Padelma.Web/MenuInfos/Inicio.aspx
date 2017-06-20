<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inicio.aspx.cs" Inherits="Inicio" Theme="Entidades" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>InfoS</title>
    <link href="css/LoginInfos.css" rel="stylesheet" />
</head>
<body style="text-align: center;">
    <form id="form1" runat="server">
        <div class="container">
            <div class="box">
                <div class="controles">
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td style="text-align: left; height: 10px;"></td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 30px; color: #003366; font-weight: 700;">Usuario</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 30px;" class="auto-style3">
                                <asp:TextBox ID="txtUsuario" CssClass="input" runat="server" Width="120px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 30px; color: #003366; font-weight: 700;">Contraseña</td>
                        </tr>
                        <tr>
                            <td style="text-align: left; padding-left: 30px;" class="auto-style3">
                                <asp:TextBox ID="txtClave" CssClass="input" runat="server" TextMode="Password" Width="120px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="auto-style3">
                                <asp:Label ID="lblMensaje" runat="server" Style="color: #171E75; font-size: 11px; font-weight: 700;"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 5px 40px 5px 5px; text-align: right">
                                <asp:ImageButton ID="btnIniciarSesion" runat="server" BorderColor="#99CCFF" BorderStyle="None" BorderWidth="1px"
                                    ImageUrl="~/Imagen/Bonotes/btnIniciarSesion.png" OnClick="imbIniciarSesion_Click"
                                    onmouseout="this.src='Imagen/Bonotes/btnIniciarSesion.png'"
                                    onmouseover="this.src='Imagen/Bonotes/btnIniciarSesionN.png'" TabIndex="3" />
                            </td>

                        </tr>
                    </table>
                </div>
                <div class="derechos">© 2015 InfoS. Todos los derechos reservados</div>

            </div>
        </div>

    </form>
</body>
</html>
