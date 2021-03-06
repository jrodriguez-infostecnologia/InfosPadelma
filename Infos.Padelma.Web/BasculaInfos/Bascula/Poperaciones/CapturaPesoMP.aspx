﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CapturaPesoMP.aspx.cs" Inherits="Bascula_Poperaciones_CapturaPesoMP" %>
<%@ OutputCache Location="None" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
      <script type="text/javascript">
          javascript: window.history.forward(1);
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <div class="principal">
            <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="True" EnableScriptGlobalization="True"/>                                       
            <asp:Timer ID="Timer1" runat="server" Interval="2000" OnTick="Timer1_Tick">
            </asp:Timer>
        
            <table cellspacing="0" style="width: 1000px; height: 600px">
                <tr>
                    <td>
                        </td>
                    <td style="vertical-align: top; width: 500px; height: 25px; text-align: center">
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" 
                            OnClientClick="if(!confirm('Desea cancelar la operación ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" 
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" />
                    </td>
                    <td>
                    </td>
                </tr>
            <tr>
                <td style="width: 250px; height: 600px">
                </td>
                <td style="vertical-align: top; width: 500px; height: 600px; text-align: center">
                <div>
                    <asp:Label ID="lblVehiculo" runat="server" Font-Names="Arial" Font-Size="XX-Large"></asp:Label><br />
                    <br />
                    <table cellspacing="0" style="border-right: black thin solid; border-top: black thin solid;
                        border-left: black thin solid; width: 500px; border-bottom: black thin solid; border-color: silver;">
                        <tr>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                            </td>
                            <td style="width: 150px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 150px; text-align: right;">
                                    <asp:Label id="Label1" runat="server" Text="PESO" Font-Size="XX-Large" Font-Names="Arial"></asp:Label></td>
                            <td style="width: 200px">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server" ChildrenAsTriggers="False" RenderMode="Inline" UpdateMode="Conditional">
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="Timer1" EventName="Tick" />
                        </Triggers>                    
                        <ContentTemplate>
                                    <asp:TextBox id="Txt_Peso" runat="server" Font-Bold="True" Font-Size="XX-Large" Font-Names="Arial" Width="100px" ReadOnly="True" CausesValidation="True" BorderStyle="None" ForeColor="Green"></asp:TextBox>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                            </td>
                            <td style="width: 150px; text-align: left;">
                                <asp:Label ID="Label2" runat="server" Font-Names="Arial" Font-Size="XX-Large" Text="Kg"></asp:Label></td>
                        </tr>
                        <tr>
                            <td style="width: 150px">
                            </td>
                            <td style="width: 200px">
                    </td>
                            <td style="width: 150px">
                            </td>
                        </tr>
                    </table>
                </div><table cellspacing="0" style="border-right: black thin solid; border-top: black thin solid;
                        border-left: black thin solid; width: 500px; border-bottom: black thin solid; border-color: silver;">
                    <tr>
                        <td style="width: 25px; height: 10px">
                        </td>
                        <td style="width: 175px; height: 10px;">
                        </td>
                        <td style="width: 300px; height: 10px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 25px; text-align: left">
                        </td>
                        <td style="width: 175px; text-align: left;">
                            <asp:Label ID="lblremisionL" runat="server" Font-Bold="True" Text="Nro. Remisión"></asp:Label></td>
                        <td style="width: 300px; text-align: left;">
                            <asp:Label ID="lblRemision" runat="server" Font-Bold="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 25px; text-align: left">
                        </td>
                        <td style="width: 175px; text-align: left">
                            <asp:Label ID="lblIdConductorL" runat="server" Font-Bold="True" Text="Id. Conductor"></asp:Label></td>
                        <td style="width: 300px; text-align: left">
                            <asp:Label ID="lblConductor" runat="server" Font-Bold="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 25px; text-align: left">
                        </td>
                        <td style="width: 175px; text-align: left">
                            <asp:Label ID="lblNombreL" runat="server" Font-Bold="True" Text="Nombre Conductor"></asp:Label></td>
                        <td style="width: 300px; text-align: left">
                            <asp:Label ID="lblNombre" runat="server" Font-Bold="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 25px; text-align: left">
                        </td>
                        <td style="width: 175px; text-align: left">
                            <asp:Label ID="lblFechaHoraL" runat="server" Font-Bold="True" Text="Fecha y Hora de Entrada"></asp:Label></td>
                        <td style="width: 300px; text-align: left">
                            <asp:Label ID="lblFechaHora" runat="server" Font-Bold="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 25px; text-align: left">
                        </td>
                        <td style="width: 175px; text-align: left">
                            <asp:Label ID="lblRemolqueL" runat="server" Font-Bold="True" Text="Remolque"></asp:Label></td>
                        <td style="width: 300px; text-align: left">
                            <asp:Label ID="lblRemolque" runat="server" Font-Bold="True"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 25px; text-align: left">
                        </td>
                        <td style="width: 175px; text-align: left">
                            <asp:Label ID="lblOperacionL" runat="server" Font-Bold="True" Text="Operación"></asp:Label></td>
                        <td style="width: 300px; text-align: left">
                            <asp:Label ID="lblOperacion" runat="server" Font-Bold="True"></asp:Label></td>
                    </tr>
                </table>
                    <br />
                    <asp:ImageButton ID="Ibm_Aceptar" runat="server" ImageUrl="~/Imagen/Bonotes/btnAceptar.png"
                            OnClick="Ibm_Aceptar_Click" /><br />
                    </td>
                <td style="width: 250px; height: 600px">
                </td>
            </tr>
        </table>
             
        
    </div>
    </form>
</body>
</html>
