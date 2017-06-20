<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Inicio.aspx.cs" Inherits="Inicio" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="css/Formularios.css" rel="stylesheet" />
    <link href="css/chosen.css" rel="stylesheet" />
    <script src="js/Numero.js"></script>
   
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal" style="width: 350px; height: 220px">
            <table cellpadding="0" cellspacing="0" style=" border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                <tr>
                    <td style="background-image: url('Imagen/Fondos/barraGrilla.jpg'); color: #FFFFFF">Sistema de Información INFOS</td>
                </tr>
                <tr>
                    <td style="background-color: #F0F0F0" >
                        <table cellpadding="0" cellspacing="0" style="width: 350px">
                            <tr>
                                <td style="text-align: left; "><strong style="width: 60px">Empresa</strong></td>
                                <td style="text-align: left; width: 290px;">
                                    <asp:Label ID="lbEmpresa" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left; "><strong style="width: 60px">Módulo</strong></td>
                                <td style="text-align: left">
                                    <asp:Label ID="Label18" runat="server">Tarima</asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="background-image: url('Imagen/Fondos/barraGrilla.jpg'); color: #FFFFFF;" ><strong>Análisis de Fruta Recibida</strong></td>
                </tr>
            </table>
            <asp:Panel ID="pRemision" runat="server">
                <table cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
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
                            <asp:Label ID="lblIdProducto" runat="server"></asp:Label>
                            <asp:Label ID="lblNombreProducto" runat="server"></asp:Label>
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
                <table cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Bodega Recepción"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlBodega" runat="server" Width="350px" CssClass="chzn-select">
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
                                <asp:RadioButtonList ID="rblCooperativa" runat="server">
                                    <asp:ListItem Selected="True">Autovolteo</asp:ListItem>
                                    <asp:ListItem>Cooperativa</asp:ListItem>
                                    <asp:ListItem>Manual</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            <asp:Label ID="lblMensajeBodega" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            <asp:ImageButton ID="btnAtrasBodega" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" OnClick="btnAtrasBodega_Click" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" />
                            <asp:ImageButton ID="btnSiguienteBodega" runat="server" ImageUrl="~/Imagen/Bonotes/btnSiguiente.png" OnClick="btnSiguienteBodega_Click" onmouseout="this.src='Imagen/Bonotes/btnSiguiente.png'" onmouseover="this.src='Imagen/Bonotes/btnSiguienteN.png'" />
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: center">
                            &nbsp;</td>
                    </tr>
                </table>
            </asp:Panel>
            <asp:Panel ID="pSacos" runat="server" Visible="False">
                <table id="TABLE1" cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td style="height: 10px">
                            <asp:Label ID="Label5" runat="server" Text="Nro. Sacos"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtSacos" runat="server" Width="150px" CssClass="input"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="Label14" runat="server" Text="Peso Promedio Sacos"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:TextBox ID="txtPesoSacos" runat="server" Width="150px" CssClass="input"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style2">
                            <asp:CheckBox ID="chkSacos" runat="server" Text="Solo Sacos" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblSacos" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnAtrasSacos" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" OnClick="btnAtrasSacos_Click" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" />
                            <asp:ImageButton ID="btnSiguienteSacos" runat="server" ImageUrl="~/Imagen/Bonotes/btnSiguiente.png" OnClick="btnSiguienteSacos_Click" onmouseout="this.src='Imagen/Bonotes/btnSiguiente.png'" onmouseover="this.src='Imagen/Bonotes/btnSiguienteN.png'" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">&nbsp;</td>
                    </tr>
                </table>

            </asp:Panel>

            <asp:Panel ID="pVariedad" runat="server" Visible="False">
                <table id="TABLE2" cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td style="height: 10px">
                            <asp:Label ID="Label4" runat="server" Text="Variedad"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvVariedad" runat="server" AutoGenerateColumns="False" GridLines="None" Width="350px" CssClass="Grid">
                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                <Columns>
                                    <asp:BoundField DataField="movimiento" HeaderText="id " ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" CssClass="Items"  />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="10px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="descripcion" HeaderText="Variedad" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="umedida" HeaderText="UM">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtValor" runat="server" Width="30px" CssClass="input" onkeyup="formato_numero(this)">0</asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <FooterStyle BackColor="#FFFFC0" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblVariedad" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnAtrasVariedad" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" OnClick="btnAtrasVariedad_Click" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" />
                            <asp:ImageButton ID="btnSiguienteVariedades" runat="server" ImageUrl="~/Imagen/Bonotes/btnSiguiente.png" OnClick="btnSiguienteVariedades_Click" onmouseout="this.src='Imagen/Bonotes/btnSiguiente.png'" onmouseover="this.src='Imagen/Bonotes/btnSiguienteN.png'" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">
                            &nbsp;</td>
                    </tr>
                </table>

            </asp:Panel>
            <asp:Panel ID="pCaracteristca" runat="server" Visible="False">
                <table id="TABLE5" cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td style="height: 10px">
                            <asp:Label ID="Label6" runat="server" Text="Caracteristicas"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvCaracteristicas" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%" CssClass="Grid">
                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                <Columns>
                                    <asp:BoundField DataField="movimiento" HeaderText="id " ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="10px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="descripcion" HeaderText="Caracteristica" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="umedida" HeaderText="UM">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtValor" runat="server" Width="30px" CssClass="input" onkeyup="formato_numero(this)">0</asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <FooterStyle BackColor="#FFFFC0" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblCaracteristicas" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td class="auto-style4">
                            <asp:ImageButton ID="btnAtrasCaracteristica" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" OnClick="btnAtrasCaracteristica_Click" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" />
                            <asp:ImageButton ID="btnSiguienteCaracteristica" runat="server" ImageUrl="~/Imagen/Bonotes/btnSiguiente.png" OnClick="btnSiguienteCaracteristica_Click" onmouseout="this.src='Imagen/Bonotes/btnSiguiente.png'" onmouseover="this.src='Imagen/Bonotes/btnSiguienteN.png'" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">&nbsp;</td>
                    </tr>
                </table>

            </asp:Panel>

            <asp:Panel ID="pVariables" runat="server" Visible="False">
                <table id="TABLE3" cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td style="height: 10px">
                            <asp:Label ID="lblAnalisis" runat="server" Text="Análisis"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">
                            <asp:GridView ID="gvVariables" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%" CssClass="Grid">
                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                <Columns>
                                    <asp:BoundField DataField="movimiento" HeaderText="id " ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="10px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="descripcion" HeaderText="Análisis" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="umedida" HeaderText="UM">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtValor" runat="server" Width="30px" AutoPostBack="True" OnTextChanged="txtValor_TextChanged1" onkeyup="formato_numero(this)" CssClass="input">0</asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                                    </asp:TemplateField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:CheckBox ID="chkMostrar" runat="server" Checked='<%# Eval("mCalcular") %>' Visible="False" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <FooterStyle BackColor="#FFFFC0" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblVariables" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnAtrasAnalisis" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" OnClick="btnAtrasAnalisis_Click" Style="height: 21px" />
                            <asp:ImageButton ID="btnCalcular" runat="server" ImageUrl="~/Imagen/Bonotes/btnLiquidar.png" OnClick="btnCalcular_Click" onmouseout="this.src='Imagen/Bonotes/btnLiquidar.png'" onmouseover="this.src='Imagen/Bonotes/btnLiquidarN.png'" />
                            <asp:ImageButton ID="btnSiguienteAnalisis" runat="server" ImageUrl="~/Imagen/Bonotes/btnSiguiente.png" OnClick="btnSiguienteAnalisis_Click" onmouseout="this.src='Imagen/Bonotes/btnSiguiente.png'" onmouseover="this.src='Imagen/Bonotes/btnSiguienteN.png'" Visible="False" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">&nbsp;</td>
                    </tr>
                </table>

            </asp:Panel>
            <asp:Panel ID="pResultados" runat="server" Visible="False">
                <table id="TABLE4" cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
                    <tr>
                        <td style="height: 10px">
                            <asp:Label ID="Label7" runat="server" Text="Resultados"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px">
                            <asp:GridView ID="gvResultados" runat="server" AutoGenerateColumns="False" GridLines="None" Width="100%" CssClass="Grid">
                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                <Columns>
                                    <asp:BoundField DataField="movimiento" HeaderText="id " ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="10px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="descripcion" HeaderText="Análisis" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="umedida" HeaderText="UM">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                    </asp:BoundField>
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:TextBox ID="txtResultado" runat="server" Width="30px" Enabled="False" CssClass="input">0</asp:TextBox>
                                        </ItemTemplate>
                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="30px" />
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                <FooterStyle BackColor="#FFFFC0" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblResultados" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:ImageButton ID="btnAtrasResultado" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png" onmouseout="this.src='Imagen/Bonotes/btnAtras.png'" onmouseover="this.src='Imagen/Bonotes/btnAtrasN.png'" OnClick="btnAtrasResultado_Click" />
                            <asp:ImageButton ID="btnRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="btnRegistrar_Click" onmouseout="this.src='Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='Imagen/Bonotes/btnGuardarN.jpg'" />
                        </td>
                    </tr>
                </table>

            </asp:Panel>
            <asp:Panel ID="pFinal" runat="server" Visible="False">
                <table id="TABLE6" cellpadding="0" cellspacing="0" style="width: 350px; border-right: dimgray thin solid; border-top: dimgray thin solid; border-left: dimgray thin solid; border-bottom: dimgray thin solid;">
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
                            <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="lbNuevo_Click" ToolTip="Habilita el formulario para un nuevo registro" />
                        </td>
                    </tr>
                    <tr>
                        <td style="height: 10px"></td>
                    </tr>
                </table>
            </asp:Panel>

        </div>
    </form>
</body>
</html>
