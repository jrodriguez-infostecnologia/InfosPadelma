<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ValidaRemisionMPPP.aspx.cs" Inherits="Bascula_Poperaciones_ValidaRemisionMPPP" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="WIDTH: 100%">
                <tr>
                    <td style="BACKGROUND-IMAGE: url('vid:Imagenes/botones/BotonIzq.png'); WIDTH: 250px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 25px; TEXT-ALIGN: left"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 500px; HEIGHT: 25px; TEXT-ALIGN: center">Por favor lea la remisión para registrar el primer peso&nbsp;</td>
                    <td style="BACKGROUND-POSITION-X: right; BACKGROUND-IMAGE: url('vid:Imagenes/botones/BotonDer.png'); WIDTH: 250px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 25px; TEXT-ALIGN: right"></td>
                </tr>
            </table>
            <table cellspacing="0" style="BORDER-TOP: silver thin solid; WIDTH: 1000px; BORDER-BOTTOM: silver thin solid">
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" OnClientClick="if(!confirm('Desea cancelar la operación ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" />
                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnAceptar.png" OnClick="lbRegistrar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnAceptar.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnAceptarN.png'" ToolTip="Continúa con la captura del peso" OnClientClick="if(!confirm('Desea continuar con la captura de peso ?')){return false;};" Visible="False" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label1" runat="server" Text="Número Remisión" Width="114px"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:TextBox ID="txtRemision" runat="server" AutoPostBack="True" Font-Bold="True" Font-Size="16pt" Height="25px" OnTextChanged="txtRemision_TextChanged" Width="200px" CssClass="input"></asp:TextBox>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td style="HEIGHT: 10px; " colspan="4"></td>
                </tr>
            </table>
            <table cellspacing="0" style="BORDER-TOP-WIDTH: thin; BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: black; BORDER-BOTTOM-WIDTH: thin; BORDER-BOTTOM-COLOR: black; WIDTH: 1000px; BORDER-TOP-COLOR: black; BORDER-RIGHT-WIDTH: thin; BORDER-RIGHT-COLOR: black">
                <tr>
                    <td style="height: 10px;" colspan="4"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                    <td style="WIDTH: 175px; TEXT-ALIGN: left">
                        <asp:Label ID="lblVehiculoL" runat="server" Font-Bold="True" Text="Placa Vehículo"></asp:Label>
                    </td>
                    <td style="WIDTH: 300px; TEXT-ALIGN: left">
                        <asp:Label ID="lblVehiculo" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                    <td style="BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: black; WIDTH: 175px; TEXT-ALIGN: left">
                        <asp:Label ID="lblIdConductorL" runat="server" Font-Bold="True" Text="Id. Conductor"></asp:Label>
                    </td>
                    <td style="WIDTH: 300px; TEXT-ALIGN: left">
                        <asp:Label ID="lblConductor" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                    <td style="BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: black; WIDTH: 175px; TEXT-ALIGN: left">
                        <asp:Label ID="lblNombreL" runat="server" Font-Bold="True" Text="Nombre Conductor"></asp:Label>
                    </td>
                    <td style="WIDTH: 300px; TEXT-ALIGN: left">
                        <asp:Label ID="lblNombre" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                    <td style="BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: black; WIDTH: 175px; TEXT-ALIGN: left">
                        <asp:Label ID="lblFechaHoraL" runat="server" Font-Bold="True" Text="Fecha y Hora de Entrada"></asp:Label>
                    </td>
                    <td style="WIDTH: 300px; TEXT-ALIGN: left">
                        <asp:Label ID="lblFechaHora" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                    <td style="BORDER-LEFT-WIDTH: thin; BORDER-LEFT-COLOR: black; WIDTH: 175px; TEXT-ALIGN: left">
                        <asp:Label ID="lblRemolqueL" runat="server" Font-Bold="True" Text="Remolque"></asp:Label>
                    </td>
                    <td style="WIDTH: 300px; TEXT-ALIGN: left">
                        <asp:Label ID="lblRemolque" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                    <td style="WIDTH: 175px; TEXT-ALIGN: left">
                        <asp:Label ID="lblOperacionL" runat="server" Font-Bold="True" Text="Operación"></asp:Label>
                    </td>
                    <td style="WIDTH: 300px; TEXT-ALIGN: left">
                        <asp:Label ID="lblOperacion" runat="server" Font-Bold="True"></asp:Label>
                    </td>
                    <td style="WIDTH: 250px; TEXT-ALIGN: left"></td>
                </tr>
            </table>
        </div>
    </form>
</body>
</html>
