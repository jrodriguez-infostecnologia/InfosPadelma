<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Nivel.aspx.cs" Inherits="Laboratorio_Padministracion_Nivel" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div style="text-align: center">
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
                            <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="niimbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" Style="height: 21px" />
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
                            <asp:Label ID="Label2" runat="server" Text="Código" Visible="False"></asp:Label>
                        </td>
                        <td class="Campos">
                            <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" CssClass="input" onkeyprees="formato_numero(this)" OnTextChanged="txtConcepto_TextChanged" Visible="False" Width="150px" MaxLength="10"></asp:TextBox>
                        </td>
                        <td class="bordes"></td>
                    </tr>
                    <tr>
                        <td class="auto-style4"></td>
                        <td class="nombreCampos">
                            <asp:Label ID="Label3" runat="server" Text="Descripción" Visible="False"></asp:Label>
                        </td>
                        <td class="Campos">
                            <asp:TextBox ID="txtDescripcion" runat="server" CssClass="input" MaxLength="550" Visible="False" Width="350px"></asp:TextBox>
                        </td>
                        <td class="auto-style4"></td>
                    </tr>
                    <tr>
                        <td class="bordes"></td>
                        <td class="nombreCampos"></td>
                        <td class="Campos">
                            <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                        </td>
                        <td class="bordes"></td>
                    </tr>
                </table>
                <div style="text-align: center">
                    <div style="display: inline-block">
                        <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnPageIndexChanging="gvLista_PageIndexChanging" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1" PageSize="20" Width="800px">
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
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="70px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>

                                <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                    <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="40px" />
                                </asp:CheckBoxField>
                            </Columns>
                            <PagerStyle CssClass="pgr" />
                            <RowStyle CssClass="rw" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
