<%@ Page Language="C#" AutoEventWireup="true" CodeFile="UsuarioPerfil.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 950px">
                <tr>
                    <td class="bordes">
                        <asp:ImageButton ID="nilblRegresar" runat="server" ToolTip="Regresar" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="nilblRegresar_Click" />
                    </td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); background-repeat: no-repeat; height: 25px; text-align: center;"
                        colspan="4">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" OnClick="niimbBuscar_Click" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" OnClick="nilbNuevo_Click" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" OnClick="lbCancelar_Click" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" OnClick="lbRegistrar_Click" />
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos"></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label3" runat="server" Text="Empresa" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlEmpresa" runat="server" Width="300px" Visible="False"
                            data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label1" runat="server" Text="Usuario" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlUsuario" runat="server" OnSelectedIndexChanged="txtConcepto_TextChanged"
                            Width="300px" Visible="False"
                            data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Perfil" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlPerfil" runat="server" Width="300px" Visible="False"
                            data-placeholder="Seleccione una opción..." CssClass="chzn-select" AutoPostBack="True">
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkActivo" runat="server" Text="Perfil Activo" Visible="False" /></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos"></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;">
                <tr>
                    <td style="width: 150px; text-align: center"></td>
                    <td style="width: 700px; text-align: center"></td>
                    <td style="width: 150px; text-align: center"></td>
                </tr>
                <tr>
                    <td style="width: 150px; text-align: center"></td>
                    <td style="width: 700px; text-align: center">
                        <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" PageSize="20" Width="600px" OnPageIndexChanging="gvLista_PageIndexChanging">
                            <AlternatingRowStyle CssClass="alt" />
                            <Columns>
                                <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Edit">
                                    <HeaderStyle BackColor="White" />
                                    <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                                </asp:ButtonField>
                                <asp:TemplateField HeaderText="Elim">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" />
                                    <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="empresa" HeaderText="Empresa">
                                    <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="usuario" HeaderText="Usuario" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="perfil" HeaderText="Perfil" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:CheckBoxField DataField="activo" HeaderText="Activo">
                                    <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <FooterStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:CheckBoxField>
                            </Columns>
                            <PagerStyle CssClass="pgr" />
                            <RowStyle CssClass="rw" />
                        </asp:GridView>
                    </td>
                    <td style="width: 150px; text-align: center"></td>
                </tr>
                <tr>
                    <td style="width: 150px; text-align: center"></td>
                    <td style="width: 700px; text-align: center"></td>
                    <td style="width: 150px; text-align: center"></td>
                </tr>
            </table>

        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>


    </form>
</body>
</html>
