<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FotosSellos.aspx.cs" Inherits="Laboratorio_Panalisis_FotosSellos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />

    <style type="text/css">
        .auto-style1 {
            font-size: medium;
        }

        .auto-style2 {
            font-size: medium;
            font-weight: bold;
        }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
            <div class="principal">


                <table cellpadding="0" cellspacing="0" class="auto-style1" style="width: 800px">
                    <tr>
                        <td style="width: 100px"></td>
                        <td colspan="4">Fotos para remisiones de despacho</td>
                        <td style="width: 100px"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td colspan="4"></td>
                        <td style="width: 100px"></td>
                    </tr>
                    <tr>
                        <td style="width: 100px"></td>
                        <td colspan="4">
                            <asp:Label ID="nilblMensaje" runat="server" ForeColor="#CC3300"></asp:Label>
                        </td>
                        <td style="width: 100px"></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="4">
                            <fieldset>
                                <legend>Datos de despacho</legend>
                                <table cellpadding="0" cellspacing="0" style="width: 100%">
                                    <tr>
                                        <td></td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblTipo" runat="server" CssClass="auto-style2"></asp:Label>
                                        </td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblNumero" runat="server" CssClass="auto-style2"></asp:Label>
                                        </td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblTiquete" runat="server" CssClass="auto-style2"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblFecha" runat="server"></asp:Label>
                                        </td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblProducto" runat="server"></asp:Label>
                                        </td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblPlaca" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblOrdenEnvio" runat="server"></asp:Label>
                                        </td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblCantidad" runat="server"></asp:Label>
                                        </td>
                                        <td class="nombreCampos">
                                            <asp:Label ID="lblRemolque" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td></td>
                                        <td class="nombreCampos"></td>
                                        <td></td>
                                        <td></td>
                                    </tr>
                                </table>
                            </fieldset>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td colspan="2">
                            <fieldset>
                                <legend>Sellos</legend>
                                <div style="text-align: center">
                                    <div style="display: inline-block">
                                        <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None" Width="200px" CssClass="Grid" Font-Size="XX-Large" ShowHeader="False">
                                            <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <AlternatingRowStyle BackColor="#E0E0E0" />
                                            <Columns>
                                                <asp:BoundField DataField="sello" HeaderText="Sello" ReadOnly="True">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="30px" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="Foto">
                                                    <ItemTemplate>
                                                        <asp:FileUpload ID="fuSello" runat="server" AllowMultiple="True" />
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="80px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <a href="/index.htm" target="popup" style="font-size:small" onClick="window.open('<%# Eval("url") %>', this.target, 'width=720,height=auto,top=150,left=400,scrollbars=NO,resizable:false,menubar=NO,titlebar= NO,status=NO,toolbar=NO'); return false;">Foto</a>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                                            <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                                            <FooterStyle BackColor="#FFFFC0" />
                                        </asp:GridView>
                            </fieldset>
                            <div>
                            </div>
                        </td>
                        <td>
                           </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td style="text-align: center">
                                                                <asp:ImageButton ID="btnCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" />
                        </td>
                        <td>
                                                                <asp:ImageButton ID="btnRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="btnRegistrar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                        </td>
                        <td>
                           </td>
                        <td>&nbsp;</td>
                    </tr>
                </table>

            </div>
        </div>
    </form>
</body>
</html>
