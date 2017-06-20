<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Items.aspx.cs" Inherits="Compras_Padministracion_Items" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td class="bordes">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <script type="text/javascript">
                            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
                            function endReq(sender, args) {
                                $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true });
                            }
                        </script>
                    </td>
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
            <div style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
            </div>


            <asp:UpdatePanel ID="upCabeza" runat="server" UpdateMode="Conditional" Visible="False">
                <ContentTemplate>
                    <div style="padding: 3px 10px 3px 10px">
                        <div style="border: 1px solid silver; display: inline-block;">
                            <div style="padding:5px">
                            <table id="TABLE1" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid; border: thin none silver;">
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label2" runat="server" Text="Item" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" CssClass="input" Visible="False" Width="150px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label7" runat="server" Text="Referencia" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:TextBox ID="txtReferencia" runat="server" CssClass="input" MaxLength="550" Visible="False" Width="350px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label3" runat="server" Text="Descripción" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:TextBox ID="txtDescripcion" runat="server" CssClass="input" MaxLength="550" Visible="False" Width="350px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label5" runat="server" Text="Desc. corta" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:TextBox ID="txtDesCorta" runat="server" CssClass="input" MaxLength="50" Visible="False" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:CheckBox ID="chkGrupoIR" runat="server" AutoPostBack="True" OnCheckedChanged="chkGrupoIR_CheckedChanged" Text="Grupo IR" Visible="False" />
                                    </td>
                                    <td class="Campos">
                                        <asp:DropDownList ID="ddlGrupoIR" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: left; width: 170px;">
                                        <asp:Label ID="Label4" runat="server" Text="Formas" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:CheckBoxList ID="chklForma" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" RepeatDirection="Horizontal" Visible="False">
                                            <asp:ListItem Value="C">Compra</asp:ListItem>
                                            <asp:ListItem Value="V">Venta</asp:ListItem>
                                        </asp:CheckBoxList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label9" runat="server" Text="U. Medida Compra" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:DropDownList ID="ddlUmedidaCompra" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: left; width: 200px">
                                        <asp:Label ID="Label10" runat="server" Text="U. Medida Consumo" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:DropDownList ID="ddlUmedidaConsumo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label12" runat="server" Text="Minimo" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:TextBox ID="txvMinimo" runat="server" CssClass="input" MaxLength="50" Visible="False" Width="150px" onkeyup="formato_numero(this)"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label13" runat="server" Text="Reposición (dias)" Visible="False"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:TextBox ID="txvReposicion" runat="server" CssClass="input" MaxLength="50" Visible="False" Width="150px" onkeyup="formato_numero(this)"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label11" runat="server" Text="Maximo" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txvMaximo" runat="server" CssClass="input" MaxLength="50" Visible="False" Width="150px" onkeyup="formato_numero(this)"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label14" runat="server" Text="Orden (#)" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txvOrden" runat="server" CssClass="input" MaxLength="50" onkeyup="formato_numero(this)" Visible="False" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:CheckBox ID="chkPapeleta" runat="server" AutoPostBack="True" OnCheckedChanged="chkPapeleta_CheckedChanged" Text="Papeleta" Visible="False" />
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtPapeleta" runat="server" CssClass="input" MaxLength="20" Visible="False" Width="150px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 170px">
                                        <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" Checked="True" />
                                    </td>
                                    <td style="text-align: left">
                                        <asp:CheckBox ID="chkSello" runat="server" Checked="false" Text="mSello" Visible="False" />
                                        <asp:CheckBox ID="chkDescuento" runat="server" Checked="false" Text="mDescuento" Visible="False" />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 170px">
                                        <asp:Label ID="Label6" runat="server" Text="Tipo de item" Visible="False"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:RadioButtonList ID="rblTipo" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" RepeatColumns="6" RepeatDirection="Horizontal" Style="font-size: 12px" Visible="False" Width="100%">
                                            <asp:ListItem Selected="True" Value="I">Inventario</asp:ListItem>
                                            <asp:ListItem Value="S">Servicios</asp:ListItem>
                                            <asp:ListItem Value="P">Producción</asp:ListItem>
                                            <asp:ListItem Value="A">Concepto Agrícola</asp:ListItem>
                                            <asp:ListItem Value="M">Movimiento Producción</asp:ListItem>
                                            <asp:ListItem Value="V">Variedad</asp:ListItem>
                                            <asp:ListItem Value="C">Característica Fruto</asp:ListItem>
                                            <asp:ListItem Value="AN">Análisis</asp:ListItem>
                                            <asp:ListItem Value="CP">Caracteristica producción</asp:ListItem>
                                            <asp:ListItem Value="CC">Cadena Custodia</asp:ListItem>
                                            <asp:ListItem Value="SA">Saco</asp:ListItem>
                                            <asp:ListItem Value="VS">Variedad - Sacos</asp:ListItem>
                                            <asp:ListItem Value="CS">Característica saco</asp:ListItem>
 					    <asp:ListItem Value="FI">Fertilizante Inv.</asp:ListItem>
                                            <asp:ListItem Value="T">Todos</asp:ListItem>
					   
					    
                                        </asp:RadioButtonList>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="4">
                                        <div style="text-align: center; width: 100%">
                                            <div style="display: inline-block; text-align: left; width: 830px; height: 100%">
                                                <div style="padding: 5px; float: left">
                                                    <div style="border: 1px solid silver; padding: 5px; float: left">
                                                        <asp:GridView ID="gvPlanes" runat="server" AutoGenerateColumns="False" Style="font-size: 12px" Width="430px" CssClass="Grid">
                                                            <Columns>
                                                                <asp:BoundField DataField="codigo" HeaderText="Plan">
                                                                    <ItemStyle Width="30px" CssClass="Items" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="descripcion" HeaderText="Descripción">
                                                                    <ItemStyle CssClass="Items" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Mayor">
                                                                    <ItemTemplate>
                                                                        <asp:DropDownList ID="ddlCriterio" runat="server" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                                        </asp:DropDownList>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="200px" CssClass="Items" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                                <div style="padding: 5px; float: left; height: 100%">
                                                    <div style="border: 1px solid silver; padding: 5px; float: left; height: 100%">
                                                        <div>
                                                            <asp:Label ID="Label1" runat="server" Text="Notas" Visible="False"></asp:Label>
                                                        </div>
                                                        <asp:TextBox ID="txtNotas" runat="server" Height="160px" TextMode="MultiLine" Width="340px" CssClass="input" Visible="False"></asp:TextBox>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                                </div>
                        </div>
                    </div>
                </ContentTemplate>

            </asp:UpdatePanel>

            <div style="padding: 10px">
                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnPageIndexChanging="gvLista_PageIndexChanging" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1" PageSize="20" Width="990px">
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
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="descripcion" HeaderText="Descripcion" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="descripcionAbreviada" HeaderText="DesCorta" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="referencia" HeaderText="Referencia" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="manejaIR" HeaderText="ManIR">
                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="30px" />
                        </asp:CheckBoxField>
                        <asp:BoundField DataField="grupoIR" HeaderText="GrupoIR" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tipo" HeaderText="Tipo" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="compras" HeaderText="Comp">
                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                        </asp:CheckBoxField>
                        <asp:CheckBoxField DataField="ventas" HeaderText="Vent">
                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                        </asp:CheckBoxField>
                        <asp:BoundField DataField="uMedidaCompra" HeaderText="UmCP" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="uMedidaConsumo" HeaderText="UmCC" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="papeleta" HeaderText="Pap" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tiempoReposicion" HeaderText="Repo." ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="minimo" HeaderText="Min" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="maximo" HeaderText="Max" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="notas" HeaderText="Notas" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="activo" HeaderText="Act">
                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="10px" />
                        </asp:CheckBoxField>
                          <asp:CheckBoxField DataField="Sello" HeaderText="mSello">
                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="10px" />
                        </asp:CheckBoxField>
                         <asp:BoundField DataField="orden" HeaderText="Ord" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                        </asp:BoundField>
                          <asp:CheckBoxField DataField="descuento" HeaderText="mDes">
                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="10px" />
                        </asp:CheckBoxField>
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
