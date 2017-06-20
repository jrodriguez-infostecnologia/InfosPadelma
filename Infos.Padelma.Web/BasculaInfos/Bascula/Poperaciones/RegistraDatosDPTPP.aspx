<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistraDatosDPTPP.aspx.cs" Inherits="Bascula_Poperaciones_RegistraDatosDPTPP" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
     <script src="../../js/Numero.js" type="text/javascript"></script>
      <script type="text/javascript">
          javascript: window.history.forward(1);
    </script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div class="principal">
        <table cellspacing="0" style="width: 1000px">
            <tr>
                <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">
                </td>
                <td style="width: 500px; height: 25px; background-image: none;">
                    <asp:Label ID="Label8" runat="server" Text="DPT Nro."></asp:Label>&nbsp;
                    <asp:Label ID="lblTransaccion" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label></td>
                <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: right">
                </td>
            </tr>
        </table>
        <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1" >
            <tr>
                <td colspan="4">
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Continúa con la operación" />
                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Continúa con la operación" />
                        <asp:ImageButton ID="lbNuevoPeso" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevoPeso.png" OnClick="lbNuevoPeso_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevoPeso.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevoPesoN.png'" ToolTip="Continúa con la operación" Visible="False" />
                    </td>
            </tr>
            <tr>
                <td colspan="4">
                    <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label9" runat="server" Text="Fecha"></asp:Label></td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtFecha" runat="server" Enabled="False" Width="200px" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label1" runat="server" Text="Placa Vehículo"></asp:Label></td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtVehiculo" runat="server" Enabled="False" Width="200px" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label2" runat="server" Text="Remolque"></asp:Label></td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtRemolque" runat="server" Enabled="False" Width="200px" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label3" runat="server" Text="Código Conductor"></asp:Label></td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtIdConductor" runat="server" Enabled="False" Width="200px" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label4" runat="server" Text="Nombre Conductor"></asp:Label></td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtNombreConductor" runat="server" Enabled="False" Width="200px" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label6" runat="server" Text="Producto"></asp:Label></td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtProducto" runat="server" Enabled="False" Width="20px" CssClass="input"></asp:TextBox>
                    <asp:TextBox ID="txtProductoNombre" runat="server" Enabled="False" Width="172px" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                    &nbsp;</td>
                <td class="nombreCampos">
                    <asp:Label ID="Label14" runat="server" Text="Observación"></asp:Label>
                </td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Enabled="False" Height="69px" TextMode="MultiLine" Width="300px"></asp:TextBox>
                </td>
                <td class="bordes">
                    &nbsp;</td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label7" runat="server" Text="Peso Tara Kg."></asp:Label></td>
                <td class="nombreCampos">
                    <asp:TextBox ID="txtPeso" runat="server" Enabled="False" Font-Bold="True" Font-Size="Larger"
                        ForeColor="#004000" Height="30px" Width="200px" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td colspan="2">
                    <asp:Label ID="lblObservaciones" runat="server"></asp:Label>
                </td>
                <td class="bordes">
                </td>
            </tr>
            </table>
    
    </div>
    </form>
</body>
</html>
