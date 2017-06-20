<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProgramacionGeneral.aspx.cs" Inherits="Logistica_Pprogrmacion_ProgramacionGeneral" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td class="bordes" style="width: 250px">
                        <asp:ImageButton ID="nilblRegresar" runat="server" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="nilblRegresar_Click" style="width: 16px" ToolTip="Regresar" />
                    </td>
                    <td class="nombreCampos">Busqueda</td>
                    <td style="width: 150px; text-align: left;">
                        <asp:DropDownList ID="niddlAño" runat="server" AutoPostBack="True" CssClass="input" OnSelectedIndexChanged="niddlAño_SelectedIndexChanged" Width="100px">
                        </asp:DropDownList>
                        </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:DropDownList ID="niddlMes" runat="server" CssClass="input" Width="100px">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 250px" class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="5" style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="lbNuevo_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 100%; " id="TABLE1">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label11" runat="server" Text="Periodo Año" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlAño" runat="server" AutoPostBack="True" CssClass="input" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" Visible="False" Width="100px">
                        </asp:DropDownList>
                    </td>
                    <td style="vertical-align: top; width: 250px;"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label13" runat="server" Text="Periodo Mes" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlMes" runat="server" CssClass="input" Visible="False" Width="100px">
                        </asp:DropDownList>
                    </td>
                    <td style="vertical-align: top; width: 250px;"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label4" runat="server" Text="Mercado" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlMercado" runat="server" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td style="vertical-align: top; width: 250px;"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Producto" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlProducto" runat="server" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td style="vertical-align: top; width: 250px;"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label3" runat="server" Text="Cantidad TM" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvCantidad" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox></td>
                    <td style="vertical-align: top; width: 250px;"></td>
                </tr>
            </table>
            <div class="tablaGrilla">
                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" PageSize="20" Width="800px" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:ButtonField ButtonType="Image" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón" CommandName="Select">
                            <ItemStyle Width="20px" CssClass="Items" />
                        </asp:ButtonField>
                        <asp:TemplateField HeaderText="Elim">
                            <ItemTemplate>
                                <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                            </ItemTemplate>
                            <HeaderStyle BackColor="White" />
                            <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="programacion" HeaderText="Programaci&#243;n" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="año" HeaderText="Año" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mes" HeaderText="Mes" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mercado" HeaderText="Mercado" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="producto" HeaderText="Producto" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="cantidad"  HeaderText="Cantidad" DataFormatString="{0:N2}" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Right" BorderColor="Silver"  BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                    </Columns>
                    <PagerStyle CssClass="pgr" />
                    <RowStyle CssClass="rw" />
                </asp:GridView>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>


