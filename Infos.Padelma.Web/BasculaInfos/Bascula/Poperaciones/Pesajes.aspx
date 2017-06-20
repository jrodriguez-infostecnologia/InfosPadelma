<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Pesajes.aspx.cs" Inherits="Bascula_Poperaciones_Pesajes" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
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
                    <td style="VERTICAL-ALIGN: top; WIDTH: 500px; HEIGHT: 25px; TEXT-ALIGN: center">Por favor seleccione la operación que desea realizar&nbsp;</td>
                    <td style="BACKGROUND-POSITION-X: right; BACKGROUND-IMAGE: url('vid:Imagenes/botones/BotonDer.png'); WIDTH: 250px; BACKGROUND-REPEAT: no-repeat; HEIGHT: 25px; TEXT-ALIGN: right"></td>
                </tr>
            </table>
            <table cellspacing="0" style="BORDER-TOP: silver thin solid; WIDTH: 100%; BORDER-BOTTOM: silver thin solid">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Operación" Width="114px"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlOperacion" runat="server" Height="25px" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                            <asp:ListItem></asp:ListItem>
                            <asp:ListItem Value="primerPeso">Primer Peso</asp:ListItem>
                            <asp:ListItem Value="segundoPeso">Segundo Peso</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="bordes">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnAceptar.png" OnClick="lbRegistrar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnAceptar.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnAceptarN.png'" ToolTip="Continúa con la operación" />
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
