<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PermisosCompleto.aspx.cs" Inherits="Seguridad_Pcontrol_PermisosCompletos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div style="vertical-align: top; width: 800px; height: 100%; text-align: center; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 12px; color: #003366;">
            <div style="width: 100%; text-align: left;">
                <table cellpadding="0" cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="width: 10px"></td>
                        <td style="width: 90px">
                            <asp:Label ID="Label1" runat="server" Text="Empresa"></asp:Label>
                        </td>
                        <td style="width: 350px">
                            <asp:DropDownList ID="ddlEmpresa" runat="server" Width="320px" AutoPostBack="True" CssClass="input" OnSelectedIndexChanged="ddlEmpresa_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="lbCancelar_Click"
                                onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                                onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" />

                            <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                                onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                                onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click1" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center">
                            <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4" style="text-align: center; height: 10px;">&nbsp;</td>
                    </tr>
                </table>
            </div>
            <div style="width: 320px; height: 100%; float: left;">
                <div >
                    <fieldset class="cuadros">
                        <legend>Perfiles</legend>
                        <asp:GridView ID="gvPerfiles" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" Width="270px">
                            <AlternatingRowStyle CssClass="alt" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sel">
                                    <ItemTemplate>
                                        <asp:RadioButton ID="rbSeleccionar" runat="server" />
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" Width="20px" />
                                    <ItemStyle CssClass="items" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="codigo" HeaderText="Código">
                                    <ItemStyle Width="70px" CssClass="Items" />
                                </asp:BoundField>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripción">
                                    <ItemStyle CssClass="Items" />
                                </asp:BoundField>
                            </Columns>
                            <PagerStyle CssClass="pgr" />
                            <RowStyle CssClass="rw" />
                        </asp:GridView>
                    </fieldset>
                </div>
                <div >
                    <fieldset class="cuadros">
                        <legend>Usuarios</legend>
                        <asp:CheckBox ID="chkMarcarTUsuario" runat="server" Text="Marcar Todos" />
                        <asp:CheckBox ID="chkDesmarcarUsuario" runat="server" Text="Desmarcar Todos" />
                        <asp:GridView ID="gvUsuarios" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" PageSize="20" Width="270px">
                            <AlternatingRowStyle CssClass="alt" />
                            <Columns>
                                <asp:TemplateField HeaderText="Sel">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSeleccionar" runat="server" />
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" Width="20px" />
                                    <ItemStyle CssClass="items" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="usuario" HeaderText="Usuario">
                                    <ItemStyle Width="70px" CssClass="Items" />
                                </asp:BoundField>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripción">
                                    <ItemStyle CssClass="Items" />
                                </asp:BoundField>
                            </Columns>
                            <PagerStyle CssClass="pgr" />
                            <RowStyle CssClass="rw" />
                        </asp:GridView>
                    </fieldset>
                </div>
            </div>

            <div style="width: 350px; height: 100%; float: left;" >
                <fieldset class="cuadros">
                    <legend>Modulos</legend>
                    <asp:CheckBox ID="chkMarcarTModulos" runat="server" Text="Marcar Todos" />
                    <asp:CheckBox ID="chkDesmarcarModulos" runat="server" Text="Desmarcar Todos" />
                    <asp:TreeView ID="tvPermisos" runat="server" ShowLines="True" OnTreeNodePopulate="tvPermisos_TreeNodePopulate" OnSelectedNodeChanged="tvPermisos_SelectedNodeChanged" Width="300px">
                    </asp:TreeView>
                </fieldset>
            </div>

        </div>
    </form>
</body>
</html>
