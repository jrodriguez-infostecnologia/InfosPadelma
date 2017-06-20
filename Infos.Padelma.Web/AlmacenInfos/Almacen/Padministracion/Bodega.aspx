<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Bodega.aspx.cs" Inherits="Almacen_Padministracion_Bodega" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <style type="text/css">
        
    </style>
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
                    <td colspan="4" class="auto-style1">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="text-align: left; width: 170px" class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Código" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" CssClass="input" Visible="False" Width="150px" MaxLength="5" OnTextChanged="txtCodigo_TextChanged"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="text-align: left; width: 170px" class="nombreCampos">
                        <asp:Label ID="Label3" runat="server" Text="Descripción" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="input" MaxLength="550" Visible="False" Width="350px"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bordes">&nbsp;</td>
                    <td style="text-align: left; width: 170px" class="nombreCampos">
                        <asp:Label ID="Label5" runat="server" Text="Desc. corta" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtDesCorta" runat="server" CssClass="input" MaxLength="50" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="text-align: left; width: 170px" class="nombreCampos">
                        <asp:CheckBox ID="chkCcosto" runat="server" Text="Maneja Centro de Costo" Visible="False" AutoPostBack="True" OnCheckedChanged="chkCcosto_CheckedChanged" />
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlCcosto" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px" Enabled="False">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bordes">&nbsp;</td>
                    <td style="text-align: left; width: 170px" class="nombreCampos">
                        <asp:CheckBox ID="chkProveedor" runat="server" Text="Maneja Proveedor" Visible="False" AutoPostBack="True" OnCheckedChanged="chkProveedor_CheckedChanged" />
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px" Enabled="False">
                        </asp:DropDownList>
                    </td>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="text-align: left; width: 170px" class="nombreCampos">
                        <asp:CheckBox ID="chkCuenta" runat="server" Text="Maneja Cuenta" Visible="False" AutoPostBack="True" OnCheckedChanged="chkCuenta_CheckedChanged" />
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlCuenta" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px" Enabled="False">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bordes">&nbsp;</td>
                    <td style="text-align: left; width: 170px" class="nombreCampos">&nbsp;</td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkProduccion" runat="server" Text="Producción" Visible="False" />
                        <asp:CheckBox ID="chkManejaExistencia" runat="server" Text="Maneja Existencia" Visible="False" />
                        <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                    </td>
                    <td>&nbsp;</td>
                </tr>
            </table>
            <div style="padding: 10px 35px 10px 35px; text-align:center">
                <div style="display:inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnPageIndexChanging="gvLista_PageIndexChanging" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1" PageSize="20" Width="600px">
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
                            <asp:BoundField DataField="codigo" HeaderText="Código" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripcion" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desCorta" HeaderText="DesCorta" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="100px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="validaCcosto" HeaderText="mCcosto">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="30px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="validaProveedor" HeaderText="mProveedor">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="30px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="validaCuenta" HeaderText="mCuenta">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="30px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="mExistencia" HeaderText="mExistencia">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="30px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="produccion" HeaderText="Produccion">
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="30px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Activo">
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

