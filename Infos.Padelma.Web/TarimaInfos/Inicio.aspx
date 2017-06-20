<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inicio.aspx.cs" Inherits="Inicio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/Formularios.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            height: 10px;
        }
    </style>
    </head>
<body>
    <form id="form1" runat="server">
        <div class="principal" style="width: 300px; height: 250px">
            <table cellpadding="0" cellspacing="0" style="width: 300px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                <tr>
                    <td style="background-image: url('Imagen/Fondos/barraGrilla.jpg'); color: #FFFFFF">Sistema de Información INFOS<asp:ImageButton ID="imbPrincipal" runat="server" ImageUrl="~/Imagen/Bonotes/menuPrincipal.png" OnClick="imbPrincipal_Click" Width="20px" />
                    </td>
                </tr>
                <tr>
                    <td style="background-color: #F0F0F0">
                        <table cellpadding="0" cellspacing="0" style="width: 297px">
                            <tr>
                                <td style="text-align: left"><strong>Usuario</strong></td>
                                <td style="text-align: left">
                                    <asp:Label ID="lbUsuario" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left"><strong>Nombre Usuario</strong></td>
                                <td style="text-align: left">
                                    <asp:Label ID="lbNombreUsuario" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left"><strong>Empresa</strong></td>
                                <td style="text-align: left">
                                    <asp:Label ID="lbEmpresa" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left"><strong>Modulo</strong></td>
                                <td style="text-align: left">
                                    <asp:Label ID="Label18" runat="server">Tarima</asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="background-image: url('Imagen/Fondos/barraGrilla.jpg'); color: #FFFFFF;"><strong>Análisis de Fruta Recibida</strong></td>
                </tr>
            </table>
            <asp:Panel ID="pRemision" runat="server">
                <table cellpadding="0" cellspacing="0" style="width: 300px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td>
                            <asp:Label ID="Label19" runat="server" Text="Producto"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlProducto" runat="server"  Width="250px" CssClass="input">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Nro. Remisión"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtRemision" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txtRemision_TextChanged1" Width="150px"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblVehiculo" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblConductor" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblFinca" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnSiguienteRemision" runat="server" ImageUrl="~/Imagen/Bonotes/btnSiguiente.png" OnClick="btnSiguiente_Click" 
                                onmouseout="this.src='Imagen/Bonotes/btnSiguiente.png'" onmouseover="this.src='Imagen/Bonotes/btnSiguienteN.png'" />
                            
                        </td>
                    </tr>
                </table>
                
            </asp:Panel>

            <asp:Panel ID="pBodega" runat="server" Visible="False">
                <table cellpadding="0" cellspacing="0" style="width: 300px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnAtrasBodega" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" OnClick="btnAtrasBodega_Click" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" />
                            <asp:ImageButton ID="btnSiguienteBodega" runat="server" ImageUrl="~/Imagen/Bonotes/btnSiguiente.png" OnClick="btnSiguienteBodega_Click" onmouseout="this.src='Imagen/Bonotes/btnSiguiente.png'" onmouseover="this.src='Imagen/Bonotes/btnSiguienteN.png'" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMensajeBodega" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Bodega Recepción"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlBodega" runat="server" Width="250px" CssClass="input">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label3" runat="server" Text="Tipo Descargue" Visible="False"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            <div style="display: inline-block">
                                <asp:RadioButtonList ID="rblCooperativa" runat="server" RepeatDirection="Horizontal">
                                    <asp:ListItem>Autovolteo</asp:ListItem>
                                    <asp:ListItem>Cooperativa</asp:ListItem>
                                    <asp:ListItem>Manual</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pTotal" runat="server" Visible="False">
                <table id="TABLE3" cellpadding="0" cellspacing="0" style="width: 300px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td style="height: 10px">
                            <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%">
                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                <Columns>
                                    <asp:BoundField DataField="analisis" HeaderText="id Análisis" ReadOnly="True">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="50px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:TemplateField HeaderText="%">
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtResultado" runat="server" Width="50px">0</asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <FooterStyle BackColor="#FFFFC0" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            &nbsp;</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMensajeTotal" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnTotalAtras" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" OnClick="btnTotalAtras_Click" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" />
                            <asp:ImageButton ID="btnRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="btnRegistrar_Click" onmouseout="this.src='Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='Imagen/Bonotes/btnGuardarN.jpg'" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">&nbsp;</td>
                    </tr>
                </table>
                
            </asp:Panel>
            <asp:Panel ID="pFinal" runat="server" Visible="False">
                    <table id="TABLE4" cellpadding="0" cellspacing="0" style="width: 300px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                        <tr>
                            <td class="auto-style1"></td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Label ID="lblMensajeFinal" runat="server" ForeColor="Red"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="lbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 10px">&nbsp;</td>
                        </tr>
                    </table>
                </asp:Panel>
        </div>

    </form>
</body>
</html>
