<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModificacionPrimas.aspx.cs" Inherits="Nomina_Pliquidacion_ModificacionPrimas" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link rel="stylesheet" href="../../css/common.css" type="text/css" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/jquery-ui.css" rel="stylesheet" />
    <link type="text/css" href="../../css/ui.multiselect.css" rel="stylesheet" />

    <script type="text/javascript" src="../../js/lib/jquery/dist/jquery.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui1.8.10.min.js"></script>
    <script type="text/javascript" src="../../js/plugins/localisation/jquery.localisation-min.js"></script>
    <script type="text/javascript" src="../../js/plugins/scrollTo/jquery.scrollTo-min.js"></script>
    <script type="text/javascript" src="../../js/ui.multiselect.js"></script>
    <script type="text/javascript" src="../../js/lib/cleave.js/dist/cleave.min.js"></script>
    <script type="text/javascript" src="../../js/Liquidación/ModificacionPrima.js?v=20170704"></script>


    <link href="../../css/chosen.css" rel="stylesheet" />

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td>Modificación de liquidación de primas</td>
                </tr>
            </table>
            <hr />
            <table cellspacing="0" style="width: 100%;" id="Table2">
                <tr>
                    <td colspan="6"></td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblFecha" runat="server" Text="Fecha"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 120px; text-align: left;"></td>
                    <td style="width: 300px; text-align: left;"></td>
                    <td style="width: 80px"></td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblTipo" runat="server" Text="Tipo"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtTipo" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblNumero" runat="server" Text="Numero"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtNumero" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 80px"></td>
                </tr>

                <tr>
                    <td style="width: 80px"></td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblaño" runat="server" Text="Año primas desde"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtAñoDesde" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblPeriodo" runat="server" Text="Desde perido"></asp:Label>
                    </td>
                    <td style="width: 300px; text-align: left;">
                        <asp:TextBox ID="txtPeriodoDesde" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 80px"></td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblaño1" runat="server" Text="Año primas hasta"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtAñoHasta" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblPeriodo1" runat="server" Text="Hasta perido"></asp:Label>
                    </td>
                    <td style="width: 300px; text-align: left;">
                        <asp:TextBox ID="txtPeriodoHasta" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 80px"></td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblañoPago" runat="server" Text="Año pago primas"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtAñoPago" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblPeriodoPago" runat="server" Text="Periodo pago primas"></asp:Label>
                    </td>
                    <td style="width: 300px; text-align: left;">
                        <asp:TextBox ID="txtPeriodoPago" runat="server" CssClass="input" Enabled="false"></asp:TextBox>
                    </td>
                    <td style="width: 80px"></td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblObservacion" runat="server" Text="Observación"></asp:Label>
                    </td>
                    <td class="Campos" colspan="3">
                        <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="40px" TextMode="MultiLine" Enabled="false" Width="100%"></asp:TextBox>
                    </td>
                    <td style="width: 80px"></td>
                </tr>
            </table>
            <hr />
            <span>Registrar tercero</span>
            <hr />
            <table style="width: 100%;">
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 100px; text-align: left;">
                        <asp:Label ID="lblTercero" runat="server" Text="Tercero"></asp:Label>
                    </td>
                    <td style="width: 350px; text-align: left;">
                        <asp:DropDownList ID="ddlTercero" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="100%"></asp:DropDownList>
                        <asp:Label ID="ddlTerceroVal" runat="server" ForeColor="Red" Style="display:block"></asp:Label>
                    </td>
                    <td style="width: 120px; text-align: left;">
                        <asp:LinkButton ID="lblFechaIngreso" runat="server" OnClick="lblFechaIngreso_Click" Style="color: #003366">Fecha Ingreso</asp:LinkButton>
                    </td>
                    <td class="Campos">
                        <asp:Calendar ID="niCalendarFechaIngreso" runat="server" BackColor="White" BorderColor="#999999"
                            CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaIngreso_SelectionChanged" Width="150px" Visible="false">
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaIngreso" runat="server" Font-Bold="True" ForeColor="Gray"
                            CssClass="input" AutoPostBack="True" OnTextChanged="txtFechaIngreso_TextChanged"></asp:TextBox>
                        <asp:Label ID="txtFechaIngresoVal" runat="server" ForeColor="Red" Style="display:block"></asp:Label>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 120px; text-align: left;">
                        <asp:LinkButton ID="lblFechaInicio" runat="server" OnClick="lblFechaInicio_Click"
                            Style="color: #003366">Fecha Inicio</asp:LinkButton>
                    </td>
                    <td class="Campos">
                        <asp:Calendar ID="CalendarFechaInicio" runat="server" BackColor="White" BorderColor="#999999"
                            CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaInicio_SelectionChanged" Width="150px" Visible="false">
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaInicio" runat="server" Font-Bold="True" ForeColor="Gray"
                            CssClass="input" AutoPostBack="True" OnTextChanged="txtFechaInicio_TextChanged"></asp:TextBox>
                        <asp:Label ID="txtFechaInicioVal" runat="server" ForeColor="Red" Style="display:block"></asp:Label>
                    </td>
                    <td style="width: 120px; text-align: left;">
                        <asp:LinkButton ID="lblFechaFin" runat="server" OnClick="lblFechaFin_Click"
                            Style="color: #003366">Fecha Fin</asp:LinkButton>
                    </td>
                    <td class="Campos">
                        <asp:Calendar ID="CalendarFechaFin" runat="server" BackColor="White" BorderColor="#999999"
                            CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                            ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaFin_SelectionChanged" Width="150px" Visible="false">
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaFin" runat="server" Font-Bold="True" ForeColor="Gray"
                            CssClass="input" AutoPostBack="True" OnTextChanged="txtFechaFin_TextChanged"></asp:TextBox>
                        <asp:Label ID="txtFechaFinVal" runat="server" ForeColor="Red" Style="display:block"></asp:Label>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="text-align: center;" colspan="4">
                        <asp:ImageButton ID="btnCargar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" ToolTip="Cargar nuevo tercero" Style="height: 21px" OnClick="btnCargar_Click" />
                        <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClientClick="if(!confirm('Desea guardar los cambios ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guardar Cambios" OnClick="btnGuardar_Click" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" OnClick="lbCancelar_Click" />
                    </td>
                    <td style="width: 80px"></td>
                </tr>
            </table>
            <hr />
            <table style="width: 100%;">
                <tr>
                    <td colspan="6" style="text-align: center;" class="auto-style3">
                        <div>
                            <asp:Label ID="successMessage" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label>
                            <asp:Label ID="failMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                        </div>
                        <div style="text-align: center">
                            <div style="display: inline-block" id="detalleLiqidacion" runat="server">
                                <asp:GridView ID="gvDetalleLiquidacion" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" RowHeaderColumn="cuenta" Width="100%" OnRowDeleting="gvDetalleLiquidacion_RowDeleting">
                                    <AlternatingRowStyle CssClass="alt" />
                                    <Columns>
                                        <asp:TemplateField HeaderText="Anul">
                                            <ItemTemplate>
                                                <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                            </ItemTemplate>
                                            <HeaderStyle BackColor="White" />
                                            <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="CodigoTercero" HeaderText="Cod.">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IdentificacionTercero" HeaderText="Indent.">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NombreTercero" HeaderText="Nombre">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="200px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaIngreso" HeaderText="Fecha Ingreso">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaInicial" HeaderText="Fecha Inicial">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaFinal" HeaderText="Fecha Final">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Basico" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvBasico" runat="server" ClientIDMode="Static" CssClass="input numeric-field" Text='<%#Eval("Basico") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="80px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transporte" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvTransporte" runat="server" ClientIDMode="Static" CssClass="input numeric-field" Text='<%#Eval("Transporte") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="80px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Valor Promedio" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvValorPromedio" runat="server" ClientIDMode="Static" CssClass="input numeric-field" Text='<%#Eval("ValorPromedio") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dias Promedio" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvDiasPromedio" runat="server" ClientIDMode="Static" CssClass="input numeric-field" Text='<%#Eval("DiasPromedio") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="80px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Valor Base" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvBase" runat="server" ClientIDMode="Static" CssClass="input numeric-field" Text='<%#Eval("Base") %>' Enabled="false" Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dias Prima" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvDiasPrima" runat="server" ClientIDMode="Static" CssClass="input numeric-field" Text='<%#Eval("DiasPrimas") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="80px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Valor Prima" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvValorPrima" runat="server" ClientIDMode="Static" CssClass="input numeric-field" Enabled="false" Text='<%#Eval("ValorPrima") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="pgr" />
                                    <RowStyle CssClass="rw" />
                                </asp:GridView>
                            </div>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="6" style="text-align: center"></td>
                </tr>
            </table>
            <hr />
        </div>
    </form>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
</body>
</html>
