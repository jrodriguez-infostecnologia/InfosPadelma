<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Salidas.aspx.cs" Inherits="Porteria_Padministracion_Salidas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
</head>
<body class="principalBody">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 950px">
                <tr>
                    <td class="bordes">
                        </td>
                    <td>Clic aquí para buscar vehículos en planta</td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="3">
                    <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click" 
                        onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" 
                        onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" style="height: 21px"/>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;">
            <tr>
                <td>
                    <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                </td>
            </tr>
            </table>
            <div class="tablaGrilla">
                <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False"  CssClass="Grid" GridLines ="None" Height="1px" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" Width="800px">
                   <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="Salir">
                            <ItemTemplate>
                                <asp:ImageButton ID="imbSalida" runat="server" CommandName="Select" ImageUrl="~/Imagen/TabsIcon/undo.png" OnClientClick="if(!confirm('Desea dar salida al vehículo ?')){return false;};" ToolTip="Clic aqui para dar salida al vehículo seleccionado" />
                            </ItemTemplate>
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="30px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="vehiculo" HeaderText="Vehículo" ReadOnly="True">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="60px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="remolque" HeaderText="Remolque">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha Ingreso" ReadOnly="True">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="codigoConductor" HeaderText="Cédula">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="70px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="nombreConductor" HeaderText="Nombre">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                    </Columns>
                   <PagerStyle CssClass="pgr" />
                    <RowStyle CssClass="rw" />
                </asp:GridView>
            </div>
        </div>

    </form>
</body>
</html>
