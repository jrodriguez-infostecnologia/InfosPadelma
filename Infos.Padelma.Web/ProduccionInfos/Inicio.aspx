<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inicio.aspx.cs" Inherits="Inicio"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>InfoS</title>
    <link href="css/LoginInfos.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            text-align: left;
        }
    </style>
</head>
<body style="text-align: center;">
    <form id="form1" runat="server">
        <div class="container">
            <div class="box">
                <div class="controles">

                    <table cellpadding="0" cellspacing="0" class="auto-style1">
                        <tr>
                            <td style="text-align: left">Usuario</td>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <asp:TextBox ID="txtUsuario" CssClass="input" runat="server"  Width="120px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align: left">Contraseña</td>
                        </tr>
                        <tr>
                            <td style="text-align: left">
                                <asp:TextBox ID="txtClave" CssClass="input" runat="server" TextMode="Password" Width="120px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMensaje" runat="server" style="color: #171E75"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="padding: 5px 40px 5px 5px; text-align: right">
                                <asp:ImageButton ID="btnIniciarSesion" runat="server" BorderColor="#99CCFF" BorderStyle="None" BorderWidth="1px" 
                                    OnClick="imbIniciarSesion_Click" ImageUrl="~/Imagen/Bonotes/btnInisiarSesion.jpg" 
                                    onmouseout="this.src='Imagen/Bonotes/btnInisiarSesion.jpg'" 
                                    onmouseover="this.src='Imagen/Bonotes/btnIniciar.jpg'" TabIndex="3" />
                            </td>
                            
                        </tr>
                    </table>

                </div>
                <div class="derechos" >© 2014 Infos Tecnologia S.A.S. Todos los derechos reservados</div>

            </div>
        </div>

    </form>
</body>
</html> 
