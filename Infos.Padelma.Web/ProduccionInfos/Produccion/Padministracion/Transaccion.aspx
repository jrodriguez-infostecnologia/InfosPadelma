<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transaccion.aspx.cs" Inherits="Produccion_Ptransaccion_Transaccion" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Transacción Producción</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js"></script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <script type="text/javascript">
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
            function endReq(sender, args) {
                $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true });
            }
        </script>
        <div style="text-align: center">
            <div style="display: inline-block">
                <div style="vertical-align: top; width: 900px; height: 600px; text-align: left" class="principal">
                    <table cellspacing="0" style="width: 900px" cellpadding="0">
                        <tr>
                            <td style="text-align: left; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver; vertical-align: bottom;">
                                <div style="padding-left: 5px">
                                    <asp:ImageButton ID="niimbRegistro" runat="server" ImageUrl="~/Imagen/Bonotes/pRegistro.png" OnClick="niimbRegistro_Click"
                                        onmouseout="this.src='../../Imagen/Bonotes/pRegistro.png'" onmouseover="this.src='../../Imagen/Bonotes/pRegistroN.png'" Enabled="False" />
                                    <asp:ImageButton ID="niimbConsulta" runat="server"
                                        ImageUrl="~/Imagen/Bonotes/pConsulta.png" OnClick="niimbConsulta_Click"
                                        onmouseout="this.src='../../Imagen/Bonotes/pConsulta.png'" onmouseover="this.src='../../Imagen/Bonotes/pConsultaN.png'" />
                                </div>

                            </td>
                        </tr>
                    </table>

                    <asp:UpdatePanel ID="upGeneral" runat="server">
                        <ContentTemplate>
                            <asp:UpdatePanel ID="upRegistro" runat="server">
                                <ContentTemplate>

                                    <table id="encabezado" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); background-repeat: no-repeat; text-align: center;" colspan="3">
                                                <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="nilbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                                                <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                                                <asp:ImageButton ID="lblCalcular" runat="server" ImageUrl="~/Imagen/Bonotes/btnCalcular.png" onmouseout="this.src='../../Imagen/Bonotes/btnCalcular.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCalcularN.png'" ToolTip="Haga clic aqui para realizar la busqueda" Visible="False" OnClick="lbICalcular_Click" style="height: 21px" />
                                                <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;" colspan="3">
                                                <asp:Label ID="nilblInformacion" runat="server" ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 200px; background-repeat: no-repeat; text-align: right;"></td>
                                            <td style="width: 600px; text-align: center;">
                                                <table cellspacing="0" style="width: 600px">
                                                    <tr>
                                                        <td style="width: 125px; height: 25px; text-align: left">
                                                            <asp:Label ID="lblTipoDocumento" runat="server" Text="Tipo Transacción" Visible="False"></asp:Label></td>
                                                        <td style="width: 260px; height: 25px; text-align: left">
                                                            <asp:DropDownList ID="ddlTipoDocumento" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged"
                                                                Visible="False" Width="250px">
                                                            </asp:DropDownList></td>
                                                        <td style="width: 65px; height: 25px; text-align: left">
                                                            <asp:Label ID="lblNumero" runat="server" Text="Numero" Visible="False"></asp:Label></td>
                                                        <td style="width: 150px; height: 25px; text-align: left">
                                                            <asp:TextBox ID="txtNumero" runat="server"
                                                                Visible="False" Width="150px" CssClass="input"></asp:TextBox></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 200px"></td>
                                        </tr>
                                    </table>

                                    <asp:UpdatePanel ID="upCabeza" runat="server" UpdateMode="Conditional" Visible="False">
                                        <ContentTemplate>
                                            <table cellspacing="0" style="width: 900px; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid; border-color: silver; border-width: 1px;" id="datosCab">
                                                <tr>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                    <td style="width: 125px; height: 10px; text-align: left"></td>
                                                    <td style="width: 175px; height: 10px; text-align: left"></td>
                                                    <td style="width: 100px; height: 10px; text-align: left;"></td>
                                                    <td style="width: 400px; height: 10px; text-align: left;"></td>
                                                    <td style="width: 100px; height: 10px; text-align: left;"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; text-align: left"></td>
                                                    <td style="vertical-align: top; width: 125px; text-align: left">
                                                        <asp:LinkButton ID="lbFecha" runat="server" OnClick="lbFecha_Click"
                                                            Visible="False" Style="color: #003366">Fecha transacción</asp:LinkButton></td>
                                                    <td style="vertical-align: top; width: 175px; text-align: left">
                                                        <asp:Calendar ID="niCalendarFecha" runat="server" BackColor="White" BorderColor="#999999"
                                                            CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                                                            ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged"
                                                            Visible="False" Width="150px">
                                                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                            <SelectorStyle BackColor="#CCCCCC" />
                                                            <WeekendDayStyle BackColor="FloralWhite" />
                                                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                            <OtherMonthDayStyle ForeColor="Gray" />
                                                            <NextPrevStyle VerticalAlign="Bottom" />
                                                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                        </asp:Calendar>
                                                        <asp:TextBox ID="txtFecha" runat="server" Font-Bold="True" ForeColor="Gray" ReadOnly="True"
                                                            Visible="False" CssClass="input" AutoPostBack="True" OnTextChanged="txtFecha_TextChanged" Width="150px"></asp:TextBox></td>
                                                    <td style="vertical-align: top; width: 100px; text-align: left">
                                                        <asp:Label ID="lblProducto" runat="server" Text="Producto" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="vertical-align: top; width: 400px; text-align: left">
                                                        <asp:DropDownList ID="ddlProducto" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged">
                                                        </asp:DropDownList>
                                                        <asp:HiddenField ID="hdTransaccionConfig" runat="server" />
                                                    </td>
                                                    <td style="width: 100px; text-align: left"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                    <td style="width: 125px; height: 10px; text-align: left">
                                                        <asp:Label ID="lblObservacion" runat="server" Text="Observaciones" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="height: 10px; text-align: left" colspan="3">
                                                        <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="40px" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; height: 10px; text-align: left">&nbsp;</td>
                                                    <td style="width: 125px; height: 10px; text-align: left">&nbsp;</td>
                                                    <td colspan="3" style="height: 10px; text-align: left">&nbsp;</td>
                                                    <td style="width: 100px; height: 10px; text-align: left">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <div style="text-align: center">
                                                            <div style="display: inline-block">

                                                                <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None" Width="700px" CssClass="Grid">
                                                                    <AlternatingRowStyle CssClass="alt" />
                                                                    <Columns>
                                                                        <asp:BoundField DataField="registro" HeaderText="NoReg">
                                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="40px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="movimiento" HeaderText="CodMov">
                                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="40px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="descripcion" HeaderText="Movimiento">
                                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="500px" />
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                        </asp:BoundField>
                                                                        <asp:TemplateField HeaderText="Valor">
                                                                            <ItemTemplate>
                                                                                <asp:TextBox ID="txtCantidad" runat="server" onkeyup="formato_numero(this)" Text='<%# Eval("valor") %>' Width="120px" CssClass="input"></asp:TextBox>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" Width="100px" />
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" Width="100px" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Selt">
                                                                            <ItemTemplate>
                                                                                <asp:CheckBox ID="chkResultado" runat="server" Checked='<%# Eval("resultado") %>' Enabled="False" />
                                                                            </ItemTemplate>
                                                                            <HeaderStyle BorderColor="White" BorderStyle="None" />
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
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
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlTipoDocumento" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="ddlProducto" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="gvTransaccion" EventName="RowUpdating" />
                                        </Triggers>
                                    </asp:UpdatePanel>

                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlProducto" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="niCalendarFecha" EventName="SelectionChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="gvTransaccion" EventName="RowUpdating" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="upConsulta" runat="server" Visible="False" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table cellpadding="0" cellspacing="0" style="width: 900px">
                                        <tr>
                                            <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 100px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                                            <td style="width: 150px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlCampo" runat="server" ToolTip="Selección de campo para busqueda"
                                                    Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                </asp:DropDownList></td>
                                            <td style="width: 100px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlOperador" runat="server" ToolTip="Selección de operador para busqueda"
                                                    Width="95px" AutoPostBack="True" OnSelectedIndexChanged="niddlOperador_SelectedIndexChanged" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                    <asp:ListItem Value="like">Contiene</asp:ListItem>
                                                    <asp:ListItem Value="&lt;&gt;">Diferente</asp:ListItem>
                                                    <asp:ListItem Value="between">Entre</asp:ListItem>
                                                    <asp:ListItem Selected="True" Value="=">Igual</asp:ListItem>
                                                    <asp:ListItem Value="&gt;=">Mayor o Igual</asp:ListItem>
                                                    <asp:ListItem Value="&gt;">Mayor que</asp:ListItem>
                                                    <asp:ListItem Value="&lt;=">Menor o Igual</asp:ListItem>
                                                    <asp:ListItem Value="&lt;">Menor</asp:ListItem>
                                                </asp:DropDownList></td>
                                            <td style="width: 110px; height: 25px; text-align: left">
                                                <asp:TextBox ID="nitxtValor1" runat="server" Width="95px" CssClass="input"></asp:TextBox><asp:TextBox
                                                    ID="nitxtValor2" runat="server" Visible="False" Width="95px" CssClass="input"></asp:TextBox></td>
                                            <td style="width: 30px; height: 25px; text-align: center">
                                                <asp:ImageButton ID="niimbAdicionar"
                                                    runat="server" ImageUrl="~/Imagen/TabsIcon/filter.png" ToolTip="Clic aquí para adicionar parámetro a la busqueda" OnClick="niimbAdicionar_Click" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" /></td>
                                            <td style="width: 30px; height: 25px; text-align: center">
                                                <asp:ImageButton ID="imbBusqueda" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Enabled="False" ImageUrl="~/Imagen/TabsIcon/search.png" OnClick="imbBusqueda_Click" ToolTip="Clic aquí para realizar la busqueda" Visible="False" />
                                            </td>
                                            <td style="width: 120px; height: 25px; text-align: left">
                                                <asp:Label ID="nilblRegistros" runat="server" Text="Nro. Registros 0"></asp:Label></td>
                                            <td style="background-position-x: right; width: 100px; background-repeat: no-repeat; height: 25px"></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 900px">
                                        <tr>
                                            <td style="height: 10px; text-align: center;">
                                                <asp:Label ID="nilblMensajeEdicion" runat="server" ForeColor="Navy"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div style="text-align: center">
                                                    <div style="display: inline-block">
                                                        <asp:GridView ID="gvParametros" runat="server" Width="400px" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="gvParametros_RowDeleting" CssClass="Grid">
                                                            <AlternatingRowStyle CssClass="alt" />
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="imbEliminarParametro" runat="server" ImageUrl="~/Imagen/TabsIcon/cancel.png"
                                                                            ToolTip="Elimina el parámetro de la consulta" CommandName="Delete" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                                    <ItemStyle BackColor="White" HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="campo" HeaderText="Campo">
                                                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="operador" HeaderText="Operador">
                                                                    <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                    <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valor" HeaderText="Valor">
                                                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valor2" HeaderText="Valor 2">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <PagerStyle CssClass="pgr" />
                                                            <RowStyle CssClass="rw" />
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 900px">
                                        <tr>
                                            <td style="width: 900px; text-align: left;">
                                                <asp:GridView ID="gvTransaccion" runat="server" Width="900px" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="gvTransaccion_RowDeleting" OnRowUpdating="gvTransaccion_RowUpdating" CssClass="Grid">
                                                    <AlternatingRowStyle CssClass="alt" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Edit">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imbEditar" runat="server" CommandName="Update" ImageUrl="~/Imagen/TabsIcon/pencil.png" OnClientClick="if(!confirm('Desea editar la transacción seleccionada ?')){return false;};" ToolTip="Clic aquí para editar la transacción seleccionada" />
                                                            </ItemTemplate>
                                                            <ItemStyle CssClass="Items" Width="20px" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Elim">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="White" />
                                                            <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="30px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="numero" HeaderText="Numero">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="70px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="año" HeaderText="Año">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="mes" HeaderText="Mes">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="producto" HeaderText="Producto">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="nombreProducto" HeaderText="NombreProducto">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="nota" HeaderText="Observaciones">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:CheckBoxField DataField="anulado" HeaderText="Anul">
                                                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                                                        </asp:CheckBoxField>
                                                    </Columns>
                                                    <PagerStyle CssClass="pgr" />
                                                    <RowStyle CssClass="rw" />
                                                </asp:GridView>
                                            </td>
                                        </tr>
                                    </table>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
