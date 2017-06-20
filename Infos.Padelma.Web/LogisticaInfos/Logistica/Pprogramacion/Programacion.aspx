<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Programacion.aspx.cs" Inherits="Logistica_Pprogrmacion_Programacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div style="text-align: center"><div class="principal">
            <table cellspacing="0" style="width: 950px">
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 100px; text-align: left; vertical-align: top;">Periodo</td>
                    <td style="width: 60px; text-align: left; vertical-align: top;">Año</td>
                    <td style="width: 150px; text-align: left; vertical-align: top;"><asp:DropDownList ID="niddlAño" runat="server" AutoPostBack="True" CssClass="input" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" Width="100px">
                    </asp:DropDownList>
                        </td>
                    <td style="width: 60px; text-align: left; vertical-align: top;">Mes</td>
                    <td style="width: 150px; text-align: left; vertical-align: top;"><asp:DropDownList ID="niddlMes" runat="server" CssClass="input" Width="100px">
                        </asp:DropDownList>
                    </td>
                    <td style="vertical-align: top; width: 150px; text-align: center">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                    </td>
                    <td class="bordes"></td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;">
                <tr>
                    <td style="vertical-align: middle; width: 900px; text-align: center">
                        <asp:Label ID="nilblMensaje" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 950px; text-align: left; vertical-align: top;">
                        <asp:ImageButton ID="imbComercializadora" runat="server" ImageUrl="~/Imagen/TabsIcon/Ir.png" OnClick="imbComercializadora_Click" ToolTip="Haga clic aqui para administrar programación comercializadora" Width="25px" />
                        Programación Despachos General Mes</td>
                </tr>
                <tr>
                    <td >
                        <div style="text-align:center; padding:10px;">
                            <div style="display:inline-block">
                            <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None" CssClass="Grid" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" Width="850px">
                                <AlternatingRowStyle CssClass="alt" />
                                <Columns>
                                    <asp:TemplateField HeaderText="Programar">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="imbProgramar" runat="server" CommandName="Select" ImageAlign="Middle" ImageUrl="~/Imagen/TabsIcon/Ir.png" OnClientClick="if(!confirm('Desea programar un vehículo ?')){return false;};" ToolTip="Registra la programación de un vehículo" Width="25px" />
                                        </ItemTemplate>
                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="programacion" HeaderText="Programación" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="año" HeaderText="Año" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="mes" HeaderText="Mes" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="descripcion" HeaderText="Mercado" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="producto" HeaderText="idProd" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="desProducto" HeaderText="Producto" ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad TM." ReadOnly="True">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Cantidadprogramada" DataFormatString="{0:N2}" HeaderText="Programado TM.">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cantidadDespachada" DataFormatString="{0:N2}" HeaderText="Despachado TM.">
                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                    </asp:BoundField>
                                </Columns>
                                <PagerStyle CssClass="pgr" />
                                <RowStyle CssClass="rw" />
                            </asp:GridView>
                        </div>
                            </div>
                    </td>
                </tr>
            </table>
        </div>
            
            </div>
    </form>
</body>
</html>
