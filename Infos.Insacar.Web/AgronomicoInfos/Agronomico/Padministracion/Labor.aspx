<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Labor.aspx.cs" Inherits="Agronomico_Padministracion_Labor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
</head>
<body>
    <form id="form1" runat="server">
     <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td class="bordes">
                        <asp:ImageButton ID="niImbGrupo" runat="server" ImageUrl="~/Imagen/Bonotes/pGrupoLabor.png" OnClick="niImbGrupo_Click" />
                        </td>
                    <td class="nombreCampos" >Busqueda</td>
                    <td class="Campos" >
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input" AutoPostBack="True" OnTextChanged="nitxtBusqueda_TextChanged"></asp:TextBox></td>
                    <td class="bordes">
                        <asp:ImageButton ID="niimbUnidadMedida" runat="server" ImageUrl="~/Imagen/Bonotes/pUnidadMedida.png" OnClick="niimbUnidadMedida_Click" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="lbNuevo_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" style="height: 21px" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td colspan="6">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="auto-style1" width="50px"></td>
                    <td style="text-align: left; width: 100px;">
                        <asp:Label ID="Label4" runat="server" Text="Grupo Novedad" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlGrupo" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="300px" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlGrupo_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left;" colspan="2">
                        <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                        <asp:CheckBox ID="chkLaborNoPrestacional" runat="server" Text="Labor no prestacional" Visible="False" />
                    </td>
                    <td class="auto-style1"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label2" runat="server" Text="Código" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="150px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input"></asp:TextBox>
                    </td>
                    <td style="text-align: left; width: 120px">
                        <asp:Label ID="Label8" runat="server" Text="Descripción corta" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 300px">
                        <asp:TextBox ID="txtDescripcionCorta" runat="server" Visible="False" Width="150px" CssClass="input"></asp:TextBox>
                    </td>
                    <td class="bordesPeque"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label3" runat="server" Text="Descripción" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtDescripcion" runat="server" Visible="False" Width="300px" CssClass="input"></asp:TextBox>
                    </td>
                    <td style="text-align: left; width: 120px">
                        <asp:Label ID="Label9" runat="server" Text="Unidad Medida" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 300px">
                        <asp:DropDownList ID="ddlUmedida" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="150px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td class="bordesPeque"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label6" runat="server" Text="Ciclos (días)" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvCiclos" runat="server" Visible="False" Width="150px" CssClass="input" TextMode="Number" ValidateRequestMode="Enabled" ViewStateMode="Enabled" onkeyup="formato_numero(this)"></asp:TextBox></td>
                    <td style="text-align: left; width: 120px">
                        <asp:Label ID="Label10" runat="server" Text="Rendimiento" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 300px">
                        <asp:TextBox ID="txvTarea" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)" TextMode="Number" ValidateRequestMode="Enabled" ViewStateMode="Enabled"></asp:TextBox></td>
                    <td class="bordesPeque"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label5" runat="server" Text="Naturaleza" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlNaturaleza" runat="server" CssClass="input" Width="150px" Visible="False">
                            <asp:ListItem Value="0">No aplica</asp:ListItem>
                            <asp:ListItem Value="1">Suma</asp:ListItem>
                            <asp:ListItem Value="2">Resta</asp:ListItem>
                            <asp:ListItem Value="3">Erradica</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left; width: 120px">
                        <asp:CheckBox ID="chkRagoSiembra" runat="server" Text="Rango Siembra" Visible="False" AutoPostBack="True" OnCheckedChanged="chkRagoSiembra_CheckedChanged" />
                    </td>
                    <td style="text-align: left; width: 300px">
                        <asp:TextBox ID="txvDesde" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this)" ToolTip="Año desde"></asp:TextBox>
                        <asp:TextBox ID="txvHasta" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this)" ToolTip="Año hasta" ></asp:TextBox>
                        </td>
                    <td class="bordesPeque"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label7" runat="server" Text="Concepto" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlConcepto" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="300px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left; width: 120px">
                        <asp:CheckBox ID="chkCalnal" runat="server" Text="Tipo Canal" Visible="False" AutoPostBack="True" OnCheckedChanged="chkCalnal_CheckedChanged" />
                    </td>
                    <td style="text-align: left; width: 300px">
                        <asp:DropDownList ID="ddlCanal" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="300px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td class="bordesPeque"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: left; width: 100px">
                        <asp:Label ID="Label11" runat="server" Text="Equivalencia" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtEquivalencia" runat="server" Visible="False" Width="150px" CssClass="input"></asp:TextBox></td>
                    <td style="text-align: left; width: 120px">
                        <asp:CheckBox ID="chkImpuesto" runat="server" Text="Grupo Impuesto" Visible="False" OnCheckedChanged="chkImpuesto_CheckedChanged" AutoPostBack="True" />
                    </td>
                    <td style="text-align: left; width: 300px">
                        <asp:DropDownList ID="ddlGrupoIR" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="300px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td class="bordesPeque"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: left; " colspan="2">
                        <asp:RadioButtonList ID="rblTipoHa" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" RepeatDirection="Horizontal" Visible="False" CssClass="input">
                            <asp:ListItem Selected="True" Value="NA">No Aplica</asp:ListItem>
                            <asp:ListItem Value="HN">Por (ha) Netas</asp:ListItem>
                            <asp:ListItem Value="HB">Por (ha) Brutas</asp:ListItem>
                            <asp:ListItem Value="HP">Por Palmas Netas</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style="text-align: left; " colspan="2">
                        <asp:RadioButtonList ID="rblClaseLabor" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" RepeatDirection="Horizontal" Visible="False" CssClass="input">
                            <asp:ListItem  Value="1">Mantenimiento</asp:ListItem>
                            <asp:ListItem Value="2">Cosecha</asp:ListItem>
                            <asp:ListItem Value="3">Cargue</asp:ListItem>
                            <asp:ListItem Value="4">Transporte</asp:ListItem>
                            <asp:ListItem Value="0" Selected="True">Sanidad</asp:ListItem>
                        </asp:RadioButtonList>
                        </td>
                    <td class="bordesPeque"></td>
                </tr>
                <tr>
                    <td class="bordesPeque"></td>
                    <td style="text-align: center; " colspan="4">
                        <asp:CheckBox ID="chkFecha" runat="server" Text="Maneja Fecha" Visible="False" AutoPostBack="True" />
                        <asp:CheckBox ID="chkSaldo" runat="server" Text="Maneja Saldo" Visible="False" />
                        <asp:CheckBox ID="chkLote" runat="server" Text="Maneja Lote" Visible="False" />
                        <asp:CheckBox ID="chkLinea" runat="server" Text="Maneja Linea" Visible="False" />
                        <asp:CheckBox ID="chkPalma" runat="server" Text="Maneja Palma" Visible="False" />
                        <br />
                        <asp:CheckBox ID="chkRacimos" runat="server" Text="Maneja Racimos" Visible="False" />
                        <asp:CheckBox ID="chkJornal" runat="server" Text="Maneja Jornales" Visible="False" />
                        <asp:CheckBox ID="chkBascula" runat="server" Text="Agregar Bascula" Visible="False" />
                        <asp:CheckBox ID="chkManejaDecimal" runat="server" Text="Maneja Decimal" Visible="False" />
                        <asp:CheckBox ID="chkManejaCaracteristica" runat="server" Text="Maneja Caracteristica" Visible="False" />
                    </td>
                    <td class="bordesPeque"></td>
                </tr>
                </table>
            <div style="text-align: center; padding-top: 10px; padding-left:10px;">
                <div style="display: inline-block;">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1" Width="900px">
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
                            <asp:BoundField DataField="codigo" HeaderText="Código" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desCorta" HeaderText="desCorta">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="grupo" HeaderText="Grupo">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="uMedida" HeaderText="uMedida">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ciclos" HeaderText="Ciclos">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tarea" HeaderText="Tarea">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="naturaleza" HeaderText="Signo">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50" />
                            </asp:BoundField>
                            <asp:BoundField DataField="equivalencia" HeaderText="Equi">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="concepto" HeaderText="Concep">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
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
