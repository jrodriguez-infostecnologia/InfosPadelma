<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TiposTransaccion.aspx.cs" Inherits="Admon_Padministracion_TiposTransaccion" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Agronómico</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
    </style>
</head>


<body style="text-align: center">
    <form id="form1" runat="server">
        <div style="vertical-align: top; width: 1000px; height: 600px; text-align: center; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 12px; color: #003366;">
            <table  style="width: 1000px">
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td style="text-align: center" colspan="4">
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
            <table   style="BORDER-TOP: silver thin solid; WIDTH: 1000px; BORDER-BOTTOM: silver thin solid">
                <tr>
                    <td colspan="6">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 150px"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label1" runat="server" Text="Código" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txtConcepto_TextChanged" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td style="text-align: left; width: 200px">
                        <asp:Label ID="Label2" runat="server" Text="Descripción" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="input" Visible="False" Width="350px"></asp:TextBox>
                    </td>
                    <td style="width: 150px"></td>
                </tr>
                <tr>
                    <td style="width: 150px">&nbsp;</td>
                    <td style="text-align: left; " colspan="4">
                        <table  class="auto-style1">
                            <tr>
                                <td style="text-align: left">
                        <asp:CheckBox ID="chkActivo" runat="server" AutoPostBack="True" Text="Activo" Visible="False" />
                                </td>
                                <td style="text-align: left">
                        <asp:CheckBox ID="chkNumeracion" runat="server" Text="Numeración Automática" Visible="False" />
                                </td>
                                <td style="text-align: left">
                        <asp:Label ID="Label3" runat="server" Text="Nro. Actual" Visible="False"></asp:Label>
                                </td>
                                <td style="text-align: left">
                        <asp:TextBox ID="txtActual" runat="server" CssClass="input" Visible="False" Width="130px"></asp:TextBox>
                                </td>
                                <td style="text-align: left">
                        <asp:Label ID="Label5" runat="server" Text="Longitud" Visible="False"></asp:Label>
                                </td>
                                <td style="text-align: left">
                        <asp:TextBox ID="txtLongitud" runat="server" CssClass="input" Visible="False" Width="130px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: left">
                        <asp:Label ID="Label4" runat="server" Text="Prefijo" Visible="False"></asp:Label>
                                </td>
                                <td style="text-align: left">
                        <asp:TextBox ID="txtPrefijo" runat="server" CssClass="input" Visible="False" Width="150px"></asp:TextBox>
                                </td>
                                <td style="text-align: left">
                        <asp:Label ID="Label6" runat="server" Text="Naturaleza" Visible="False"></asp:Label>
                                </td>
                                <td style="text-align: left">
                        <asp:DropDownList ID="ddlNaturaleza" runat="server" CssClass="input" Visible="False" Width="130px">
                            <asp:ListItem Value="0">No Aplica</asp:ListItem>
                            <asp:ListItem Value="2">Resta</asp:ListItem>
                            <asp:ListItem Value="1">Suma</asp:ListItem>
                        </asp:DropDownList>
                                </td>
                                <td style="text-align: left">
                        <asp:Label ID="Label8" runat="server" Text="Modo Anulación" Visible="False"></asp:Label>
                                </td>
                                <td style="text-align: left">
                        <asp:DropDownList ID="ddlModoAnulacion" runat="server" CssClass="input" Visible="False" Width="130px">
                            <asp:ListItem Value="A">Anular</asp:ListItem>
                            <asp:ListItem Value="E">Eliminar</asp:ListItem>
                        </asp:DropDownList>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 150px">&nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 150px"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label7" runat="server" Text="Modulo" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlModulo" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left; width: 180px">
                        <asp:CheckBox ID="chkReferencia" runat="server" AutoPostBack="True" OnCheckedChanged="chkReferencia_CheckedChanged" Text="Maneja Referencia" Visible="False" />
                    </td>
                    <td class="nombreCampos">
                        <asp:TextBox ID="txtDataSet" runat="server" CssClass="input" Visible="False" Width="350px"></asp:TextBox>
                    </td>
                    <td style="width: 150px"></td>
                </tr>
                </table>

            <div style="margin: 10px">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" Width="960px" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="20">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Edit">
                                <HeaderStyle Width="20px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imbEliminar" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <HeaderStyle Width="20px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="codigo" HeaderText="Código">
                                <HeaderStyle Width="60px" />
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripción">
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="numeracion" HeaderText="Num">
                                <HeaderStyle Width="30px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="actual" HeaderText="NoAct">
                                <ItemStyle CssClass="Items" Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="prefijo" HeaderText="Prefijo">
                                <HeaderStyle Width="50px" />
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="longitud" HeaderText="Log">
                                <HeaderStyle Width="30px" />
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="naturaleza" HeaderText="Signo">
                                <HeaderStyle Width="30px" />
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="modulo" HeaderText="Modulo">
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="modoAnulacion" HeaderText="Modo">
                                <HeaderStyle HorizontalAlign="Center" Width="30px" />
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="referencia" HeaderText="Ref">
                                <HeaderStyle Width="30px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="vistaDs" HeaderText="Ds">
                                <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                <HeaderStyle Width="30px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
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
