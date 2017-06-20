<%@ Page Language="C#" AutoEventWireup="true" CodeFile="NegocioMaquila.aspx.cs" Inherits="Agronomico_Padministracion_NegocioMaquila" MaintainScrollPositionOnPostback="True" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script charset="utf-8" type="text/javascript">
        var contador = 0;
    </script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div style="text-align: center">
            <div class="principal">

                <table cellspacing="0" style="width: 950px">
                    <tr>
                        <td width="250px">
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                        </td>
                        <td class="nombreCampos">Busqueda</td>
                        <td class="Campos">
                            <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                        <td width="250px"></td>
                    </tr>
                    <tr>
                        <td colspan="4">
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
                                onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" Style="height: 21px" />
                        </td>
                    </tr>
                </table>
                <table cellpadding="0" cellspacing="0" style="width: 950px; border-bottom-style: solid; border-top-style: solid; border-top-width: 1px; border-bottom-width: 1px; border-top-color: silver; border-bottom-color: silver;">
                    <tr>
                        <td colspan="6" height="8">
                            <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="width: 20px"></td>
                        <td style="width: 100px; text-align: left">
                            <asp:Label ID="Label11" runat="server" Text="Proveedor" Visible="False"></asp:Label>

                        </td>
                        <td class="nombreCampos">
                            <asp:DropDownList ID="ddlProveedor" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px">
                            </asp:DropDownList>

                        </td>
                        <td style="width: 100px; text-align: left;">
                            <asp:Label ID="Label2" runat="server" Text="Número" Visible="False"></asp:Label>
                        </td>
                        <td class="nombreCampos">
                            <asp:TextBox ID="txtNumero" runat="server" Visible="False" Width="150px" AutoPostBack="True" OnTextChanged="txtNumero_TextChanged" CssClass="input" MaxLength="5" ToolTip="Campo de cinco (5) caracteres"></asp:TextBox>
                        </td>
                        <td style="width: 20px"></td>
                    </tr>
                    <tr>
                        <td style="width: 20px"></td>
                        <td style="width: 100px; text-align: left">
                            <asp:Label ID="Label3" runat="server" Text="Procedencia" Visible="False"></asp:Label>
                        </td>
                        <td class="nombreCampos">
                            <asp:DropDownList ID="ddlProcedencia" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="250px">
                            </asp:DropDownList>

                        </td>
                        <td style="width: 100px; text-align: left;">
                            <asp:Label ID="Label4" runat="server" Text="Producto" Visible="False"></asp:Label>
                        </td>
                        <td class="nombreCampos">
                            <asp:DropDownList data-placeholder="Seleccione una opción..." ID="ddlProduccto" runat="server" class="chzn-select" Width="350px" Visible="False">
                            </asp:DropDownList>

                        </td>
                        <td style="width: 20px"></td>
                    </tr>
                    <tr>
                        <td style="width: 20px"></td>
                        <td style="width: 100px; text-align: left">
                            <asp:LinkButton ID="lbFechaInicio" runat="server" OnClick="lbFecha_Click" Visible="False" Style="color: #003366">Fecha Inicio</asp:LinkButton>
                        </td>
                        <td class="nombreCampos">
                            <asp:Calendar ID="CalendarFechaInicio" runat="server" BackColor="White" BorderColor="Silver" BorderWidth="1px" CellPadding="1" DayNameFormat="FirstTwoLetters" Font-Names="Trebuchet MS" Font-Size="10px" ForeColor="#003366" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged" Visible="False" Width="180px">
                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <WeekendDayStyle BackColor="#CCCCFF" />
                                <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            </asp:Calendar>
                            <asp:TextBox ID="txtFechaInicio" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Visible="False" Width="150px" OnTextChanged="txtFechaInicio_TextChanged"></asp:TextBox>

                        </td>
                        <td style="width: 100px; text-align: left;">
                            <asp:Label ID="Label85" runat="server" Text="Tolerancia" Visible="False"></asp:Label>

                        </td>
                        <td class="nombreCampos">
                            <asp:TextBox ID="txvTolerancia" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox>

                        </td>
                        <td style="width: 20px"></td>
                    </tr>
                    <tr>
                        <td style="width: 20px"></td>
                        <td style="width: 100px; text-align: left">
                            <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />

                        </td>
                        <td class="nombreCampos">
                            <asp:CheckBox ID="chkMaquila" runat="server" Text="Maneja maquila" Visible="False" AutoPostBack="True" OnCheckedChanged="chkSession_CheckedChanged" ToolTip="Habilitar si el negocio maneja maquila" />

                        </td>
                        <td style="width: 100px; text-align: left;"></td>
                        <td class="nombreCampos">
                            <asp:CheckBox ID="chkPorRecibido" runat="server" Text="Aplica por lo recibido" Visible="False" ToolTip="Habilitar si el negocio maneja maquila" />

                        </td>
                        <td style="width: 20px"></td>
                    </tr>
                    <tr>
                        <td style="width: 10px" colspan="6"></td>
                    </tr>
                    <tr>
                        <td colspan="6" height="8">
                            <asp:UpdatePanel ID="upAnalisis" runat="server" UpdateMode="Conditional" Visible="False">
                                <ContentTemplate>
                                    <div style="text-align: center">
                                        <div style="width: 900px; display: inline-block">
                                            <fieldset>
                                                <legend>Analisis de Negocio (%)</legend>
                                                <div style="text-align: center">
                                                    <div style="display: inline-block">
                                                        <table cellpadding="0" cellspacing="0" style="width: 850px">
                                                            <tr>
                                                                <td style="width: 100px; text-align: left">
                                                                    <asp:Label ID="Label1" runat="server" Text="Analisis" Visible="False"></asp:Label>
                                                                </td>
                                                                <td style="width: 250px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlAnalisis" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 100px; text-align: left;">
                                                                    <asp:Label ID="Label82" runat="server" Text="Porcentaje (%)" Visible="False"></asp:Label>
                                                                </td>
                                                                <td style="width: 200px; text-align: left;">
                                                                    <asp:TextBox ID="txvProcentaleAnalisis" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; text-align: left">
                                                                    <asp:CheckBox ID="chkBaseCalculo" runat="server" Text="Base Calcúlo" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="btnCargarAnalisis" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="btnCargar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" />
                                                                </td>
                                                                <td style="text-align: left"></td>
                                                                <td style="text-align: left"></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" style="text-align: center; height: 8px;">
                                                                    <asp:Label ID="nilblMensajeAnalisis" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" style="text-align: left">
                                                                    <div style="text-align: center">
                                                                        <div style="display: inline-block">
                                                                            <asp:GridView ID="gvAnalisis" runat="server" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvCanal_RowDeleting" PageSize="30" Visible="False" Width="600px">
                                                                                <AlternatingRowStyle CssClass="alt" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Elim">
                                                                                        <ItemTemplate>
                                                                                            <asp:ImageButton ID="imEliminaCanal" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" ToolTip="Elimina el registro seleccionado" />
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="registro" HeaderText="No." ReadOnly="True">
                                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="30px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="analisis" HeaderText="IdAnalisis" ReadOnly="True">
                                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="30px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="nombreAnalisis" HeaderText="Nombre Analisis" ReadOnly="True">
                                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                                    </asp:BoundField>
                                                                                    <asp:TemplateField HeaderText="Porcentaje(%)">
                                                                                        <ItemTemplate>
                                                                                            <asp:TextBox ID="txvPorAnalisis" runat="server" CssClass="input" onkeyup="formato_numero(this)" Text='<%# Eval("porcentaje") %>' Width="80px"></asp:TextBox>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="100px" />
                                                                                    </asp:TemplateField>

                                                                                    <asp:TemplateField HeaderText="BC">
                                                                                        <ItemTemplate>
                                                                                            <asp:CheckBox ID="chkAnalisis" runat="server" Checked='<%# Eval("baseCalculo") %>' />
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                                <PagerStyle CssClass="pgr" />
                                                                                <RowStyle CssClass="rw" />
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" height="8px"></td>
                    </tr>
                    <tr>
                        <td colspan="6" height="8">
                            <asp:UpdatePanel ID="upMaquila" runat="server" UpdateMode="Conditional" Visible="False">
                                <ContentTemplate>
                                    <div style="text-align: center">
                                        <div style="width: 900px; display: inline-block">
                                            <fieldset>
                                                <legend>Producctos de Negocio Maquila (%)</legend>
                                                <div style="text-align: center">
                                                    <div style="display: inline-block">
                                                        <table cellpadding="0" cellspacing="0" style="width: 850px">
                                                            <tr>
                                                                <td style="width: 100px; text-align: left">
                                                                    <asp:Label ID="Label83" runat="server" Text="Productos" Visible="False"></asp:Label>
                                                                </td>
                                                                <td style="width: 250px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlProductosMaquila" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="width: 100px">
                                                                    <asp:Label ID="Label84" runat="server" Text="Porcentaje (%)" Visible="False"></asp:Label>
                                                                </td>
                                                                <td style="width: 200px; text-align: left;">
                                                                    <asp:TextBox ID="txvProcentajeMaquila" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; text-align: left">
                                                                    <asp:CheckBox ID="chkActivoMaquila" runat="server" Style="text-align: left" Text="Activo" />
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="btnCargarProductos" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="btnCargarProductos_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" />
                                                                </td>
                                                                <td style="text-align: left"></td>
                                                                <td></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" style="text-align: center; height: 8px;">
                                                                    <asp:Label ID="nilblMensajeMaquila" runat="server"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4" style="text-align: left">
                                                                    <div style="text-align: center">
                                                                        <div style="display: inline-block">
                                                                            <asp:GridView ID="gvMaquila" runat="server" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvMaquila_RowDeleting" PageSize="30" Visible="False" Width="600px">
                                                                                <AlternatingRowStyle CssClass="alt" />
                                                                                <Columns>
                                                                                    <asp:TemplateField HeaderText="Elim">
                                                                                        <ItemTemplate>
                                                                                            <asp:ImageButton ID="imEliminaCanal0" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" ToolTip="Elimina el registro seleccionado" />
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:BoundField DataField="registro" HeaderText="No." ReadOnly="True">
                                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="30px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="producto" HeaderText="IdProducto" ReadOnly="True">
                                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="30px" />
                                                                                    </asp:BoundField>
                                                                                    <asp:BoundField DataField="nombreProducto" HeaderText="Nombre Producto" ReadOnly="True">
                                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                                    </asp:BoundField>
                                                                                    <asp:TemplateField HeaderText="Porcentaje(%)">
                                                                                        <ItemTemplate>
                                                                                            <asp:TextBox ID="txvPorMaquila" runat="server" CssClass="input" onkeyup="formato_numero(this)" Text='<%# Eval("porcentaje") %>' Width="80px"></asp:TextBox>
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="100px" />
                                                                                    </asp:TemplateField>

                                                                                    <asp:TemplateField HeaderText="Act">
                                                                                        <ItemTemplate>
                                                                                            <asp:CheckBox ID="chkActivoM" runat="server" Checked='<%# Eval("activo") %>' />
                                                                                        </ItemTemplate>
                                                                                        <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                                    </asp:TemplateField>
                                                                                </Columns>
                                                                                <PagerStyle CssClass="pgr" />
                                                                                <RowStyle CssClass="rw" />
                                                                            </asp:GridView>
                                                                        </div>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </div>
                                            </fieldset>
                                        </div>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" height="8"></td>
                    </tr>
                </table>

                <div style="text-align: center">
                    <div style="display: inline-block">
                        <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" PageSize="20" Width="950px" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
                            <AlternatingRowStyle CssClass="alt" />
                            <Columns>
                                <asp:ButtonField ButtonType="Image" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón" CommandName="Select">
                                    <ItemStyle Width="20px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:ButtonField>
                                <asp:TemplateField HeaderText="Elim">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" />
                                    <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="numero" HeaderText="Número" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="proveedor" HeaderText="Proveedor" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="nombreProveedor" HeaderText="NombreProveedor">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="procedencia" HeaderText="Procedencia">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="130px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="producto" HeaderText="IdProducto">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="referenciaProducto" HeaderText="RefProducto">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="fechaInicio" HeaderText="FechaInicial" DataFormatString="{0:dd/MM/yyy}">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="tolerancia" HeaderText="Tolerancia" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                                </asp:BoundField>
                                <asp:CheckBoxField DataField="maquila" HeaderText="Maq">
                                    <ItemStyle HorizontalAlign="Center" Width="10px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:CheckBoxField>
                                <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                    <ItemStyle HorizontalAlign="Center" Width="10px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:CheckBoxField>
                                <asp:CheckBoxField DataField="anulado" HeaderText="Anul">
                                    <ItemStyle HorizontalAlign="Center" Width="10px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:CheckBoxField>
                                <asp:CheckBoxField DataField="porRecibido" HeaderText="Recb">
                                    <ItemStyle HorizontalAlign="Center" Width="10px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
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
