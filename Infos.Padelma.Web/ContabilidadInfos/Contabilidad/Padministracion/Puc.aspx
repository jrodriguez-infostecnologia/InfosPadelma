<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Puc.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" %>

<%@ OutputCache Location="None" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Facturación y Logística</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
</head>
<body class="principalBody">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 950px; padding-bottom: 1px;">
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 100px; text-align: left">Busqueda</td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="nilbNuevo_Click"
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
            <table style="border-top: silver thin solid; border-bottom: silver thin solid; width: 950px;" cellspacing="0">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label1" runat="server" Text="No Cuenta" Visible="False"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="200px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input"></asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label2" runat="server" Text="Raiz" Visible="False"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtRaiz" runat="server" Visible="False" Width="200px" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label3" runat="server" Text="Nombre " Visible="False"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtNombre" runat="server" Visible="False" Width="100%" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label6" runat="server" Text="Tipo Cta." Visible="False"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:DropDownList ID="ddlTipo" runat="server" Visible="False" Width="120px" AutoPostBack="True" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged" CssClass="chzn-select">
                            <asp:ListItem Value="A">Auxiliar</asp:ListItem>
                            <asp:ListItem Value="M">Mayor</asp:ListItem>
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label4" runat="server" Text="Naturaleza" Visible="False"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:DropDownList ID="ddlNaturaleza" runat="server" Visible="False" Width="120px" AutoPostBack="True" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged" CssClass="chzn-select">
                            <asp:ListItem Value="D">Debito</asp:ListItem>
                            <asp:ListItem Value="C">Credito</asp:ListItem>
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label5" runat="server" Text="Nivel" Visible="False"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtNivel" runat="server" Visible="False" Width="50px" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label7" runat="server" Text="Clase" Visible="False"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:DropDownList ID="ddlClase" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td colspan="2" style="text-align: left">
                        <asp:CheckBox
                            ID="chkCcosto" runat="server" Text="Solicita Centro Costo" Visible="False" />
                        <asp:CheckBox ID="chkTercero" runat="server" Text="Solicita Tercero" Visible="False" />
                        <asp:CheckBox ID="chkBase" runat="server" Text="Solicita Base." Visible="False" />
                        <asp:CheckBox
                            ID="chkActio" runat="server" Text="Cta. Activa" Visible="False" Checked="True" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div style="text-align: center">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" PageSize="20" Width="900px" OnPageIndexChanging="gvLista_PageIndexChanging">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Edit">
                                <HeaderStyle BackColor="White" />
                                <ItemStyle Width="20px" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" BackColor="White" Width="10px" />
                                <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="codigo" HeaderText="C&#243;digo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="raiz" HeaderText="Raiz" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="40px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nombre" HeaderText="Nombre" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="naturaleza" HeaderText="Natza.">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nivel" HeaderText="Nivel">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="tercero" HeaderText="Tercero">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="cCosto" HeaderText="Ccosto">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="base" HeaderText="Base">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Activa">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="clase" HeaderText="Clase">
                                <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
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
