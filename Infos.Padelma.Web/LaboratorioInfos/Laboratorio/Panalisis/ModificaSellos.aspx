<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModificaSellos.aspx.cs" Inherits="Laboratorio_Panalisis_RegistroAnalisis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <div class="principal">

                <table cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="width: 250px; background-repeat: no-repeat; text-align: left; height: 25px;"></td>
                        <td style="width: 500px; text-align: center; vertical-align: middle; height: 25px;" class="auto-style1">Modificación de análisis y sellos de producto</td>
                        <td style="width: 250px; background-repeat: no-repeat; text-align: left; background-position-x: right; height: 25px;">
                                        <asp:HiddenField ID="hdfRemision" runat="server" />
                                    </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td>
                            <asp:Label ID="lblRemision" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label>
                        </td>
                        <td>
                                        <asp:HiddenField ID="hdfVehiculo" runat="server" />
                                    </td>
                    </tr>
                </table>
                <table cellspacing="0" style="width: 100%; border-top: silver thin solid; border-bottom: silver thin solid;">
                    <tr>
                        <td style="vertical-align: middle; width: 100%; text-align: center">
                            <asp:Label ID="nilblMensaje" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 100%; text-align: center; vertical-align: top;">
                            <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="lbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                            <asp:ImageButton ID="nilbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click"
                                onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                            <asp:ImageButton ID="nilbRegistrar0" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="vertical-align: top; width: 100%; text-align: center">
                            <table cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="width: 50px"></td>
                                    <td style="text-align: left" class="auto-style2">
                                        <asp:Label ID="lblVehiculo" runat="server" Text="Placa Vehículo" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left">
                                        <asp:DropDownList ID="ddlVehiculo" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVehiculo_SelectedIndexChanged"
                                            data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="250px">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 130px" class="nombreCampos">
                                        <asp:Label ID="Label6" runat="server" Text="Tipo de Transacción" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left;">
                                        <asp:TextBox ID="txtTipoTransaccion" runat="server" Enabled="False" Visible="False" Width="200px" CssClass="input"></asp:TextBox>
                                    </td>
                                    <td style="width: 50px"></td>
                                </tr>
                                <tr>
                                    <td style="width: 50px"></td>
                                    <td style="text-align: left" class="auto-style2">
                                        <asp:Label ID="Label1" runat="server" Text="Peso Tara Kg." Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left">
                                        <asp:TextBox ID="txtPesoTara" runat="server" Enabled="False" Visible="False" Width="200px" CssClass="input"></asp:TextBox>
                                    </td>
                                    <td style="width: 130px" class="nombreCampos">
                                        <asp:Label ID="Label2" runat="server" Text="Cliente" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left;">
                                        <asp:TextBox ID="txtCliente" runat="server" Enabled="False" Visible="False" Width="280px" CssClass="input"></asp:TextBox>
                                    </td>
                                    <td style="width: 50px"></td>
                                </tr>
                                <tr>
                                    <td style="width: 50px"></td>
                                    <td style="text-align: left" class="auto-style2">
                                        <asp:Label ID="Label4" runat="server" Text="Producto" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left">
                                        <asp:DropDownList ID="ddlProducto" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlVehiculo_SelectedIndexChanged"
                                            data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="250px">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 130px" class="nombreCampos">
                                        <asp:Label ID="Label5" runat="server" Text="Cantidad Programada" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left;">
                                        <asp:TextBox ID="txtCantidadProgramada" runat="server" Enabled="False" Visible="False" Width="150px" CssClass="input"></asp:TextBox>
                                    </td>
                                    <td style="width: 50px">
                                        </td>
                                </tr>
                                <tr>
                                    <td style="width: 50px"></td>
                                    <td style="text-align: left" class="auto-style2">
                                        <asp:Label ID="Label7" runat="server" Text="Remolque" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left">
                                        <asp:TextBox ID="txtRemolque" runat="server" Enabled="False" Visible="False" Width="150px" CssClass="input"></asp:TextBox>
                                    </td>
                                    <td style="width: 130px" class="nombreCampos">
                                        <asp:Label ID="Label8" runat="server" Text="Conductor" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 280px; text-align: left;">
                                        <asp:TextBox ID="txtConductor" runat="server" Enabled="False" Visible="False" Width="280px" CssClass="input"></asp:TextBox>
                                    </td>
                                    <td style="width: 50px">
                                        </td>
                                </tr>
                                <tr>
                                    <td class="auto-style3"></td>
                                    <td style="text-align: left" class="auto-style4">
                                        <asp:Label ID="lblSellos" runat="server" Text="Sellos" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left" colspan="3" class="auto-style5">
                                        <asp:TextBox ID="txtSellos" runat="server" Visible="False" Width="150px" CssClass="input" AutoPostBack="True" OnTextChanged="txtSellos_TextChanged"></asp:TextBox>
                                        <asp:ImageButton ID="imgAgregarSello" runat="server" ImageUrl="~/Imagen/TabsIcon/filesave.png" OnClick="txtSellos_TextChanged" Visible="False" />
                                    </td>
                                    <td class="auto-style3"></td>
                                </tr>
                                <tr>
                                    <td style="width: 50px"></td>
                                    <td style="text-align: left" class="auto-style2">
                                        </td>
                                    <td style="text-align: left" colspan="3">
                                        <asp:DataList ID="dtSellos" runat="server" HorizontalAlign="Justify" OnItemCommand="dtSellos_ItemCommand" RepeatColumns="8" RepeatDirection="Horizontal">
                                            <ItemTemplate>
                                                <table class="auto-style6">
                                                    <tr>
                                                        <td>
                                                            <asp:ImageButton ID="imgAgregarSello" runat="server" CommandArgument="delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" />
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblSello" runat="server" Text='<%# Eval("Sello") %>'></asp:Label>
                                                        </td>
                                                        <td></td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </td>
                                    <td style="width: 50px"></td>
                                </tr>
                                </table>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="width: 100%; text-align: center;">
                            <table cellspacing="0" style="width: 100%">
                                <tr>
                                    <td style="vertical-align: top; width: 200px">
                                        &nbsp;</td>
                                    <td style="vertical-align: top; width: 10px"></td>
                                    <td style="vertical-align: top; width: 500px">
                                        <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None" Width="500px" CssClass="Grid">
                                            <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <AlternatingRowStyle BackColor="#E0E0E0" />
                                            <Columns>
                                                <asp:BoundField DataField="movimiento" HeaderText="CódAnálisis" ReadOnly="True">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="30px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Resultado">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtResultado" runat="server" Width="100px" onkeyup="formato_numero(this)" CssClass="input" Text='<%# Eval("Valor") %>'></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="110px" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <FooterStyle BackColor="#FFFFC0" />
                                        </asp:GridView>
                                    </td>
                                    <td style="vertical-align: top; width: 100px"></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
