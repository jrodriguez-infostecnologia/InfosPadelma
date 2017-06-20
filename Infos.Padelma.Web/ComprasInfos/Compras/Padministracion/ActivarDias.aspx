<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ActivarDias.aspx.cs" Inherits="Compras_Padministracion_ActivarDias" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" CssClass="input" ToolTip="Escriba el texto para la busqueda" Width="300px"></asp:TextBox>
                    </td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="niimbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="lbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                    </td>
                </tr>
            </table>
            <table id="TABLE1" cellspacing="0" style="width: 100%; border-top: silver thin solid; border-bottom: silver thin solid;">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Tipo Transacción" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlTipoTransaccion" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlFinca_SelectedIndexChanged" Visible="False" Width="350px">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td colspan="2" style="text-align: left">
                        <asp:CheckBox ID="chkLunes" runat="server" Text="Lunes" Visible="False" />
                        <asp:CheckBox ID="chkMartes" runat="server" Text="Martes" Visible="False" />
                        <asp:CheckBox ID="chkMiercoles" runat="server" Text="Miércoles" Visible="False" />
                        <asp:CheckBox ID="chkJueves" runat="server" Text="Jueves" Visible="False" />
                        <asp:CheckBox ID="chkViernes" runat="server" Text="Viernes" Visible="False" />
                        <asp:CheckBox ID="chkSabado" runat="server" Text="Sábado" Visible="False" />
                        <asp:CheckBox ID="chkDomingo" runat="server" Text="Domingo" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
            </table>
            <div class="tablaGrilla">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnPageIndexChanging="gvLista_PageIndexChanging" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1" PageSize="20" Width="500px">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón">
                                <ItemStyle CssClass="Items" Width="20px" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="tipo" HeaderText="Tipo" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="100px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="lunes" HeaderText="Lunes">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="martes" HeaderText="Martes">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="miercoles" HeaderText="Miércoles">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="jueves" HeaderText="Jueves">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="viernes" HeaderText="Viernes">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="sabado" HeaderText="Sábado">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="domingo" HeaderText="Domingo">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
