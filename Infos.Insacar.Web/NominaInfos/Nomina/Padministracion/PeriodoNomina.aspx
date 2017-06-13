<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PeriodoNomina.aspx.cs" Inherits="Nomina_Padministracion_PeriodoNomina" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />

</head>
<body style="text-align: center">
    <form id="form2" runat="server">
         <script type="text/javascript">
             Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
             function endReq(sender, args) {
                 $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true });
             }
        </script>
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: left;">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                    <td style="width: 100px; height: 25px; text-align: left">Busqueda</td>
                    <td style="width: 350px; height: 25px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: right; background-position-x: right;"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="nibtnBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                        <asp:ImageButton ID="nibtnNuevoDetalle" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" OnClick="btnNuevoDetalle_Click" />
                        <asp:ImageButton ID="btnCancelarDetalle" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" OnClick="btnCancelarDetalle_Click" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE2">
                <tr>
                    <td style="height: 15px;" colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label8" runat="server" Text="Año" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlAño" runat="server" AutoPostBack="True" CssClass="input" Visible="False" Width="100px" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        &nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Panel ID="upDetalle" runat="server" Visible="False">
                          
                                <div style="padding-top: 5px; padding-bottom: 5px">
                                    <div style="border: 1px solid silver; padding: 5px 50px 5px 50px; width: 800px; display:inline-block">
                                        <table cellpadding="0" cellspacing="0" style="width: 800px">
                                            <tr>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:Label ID="Label16" runat="server" Text="No. Periodo" Visible="False"></asp:Label>
                                                </td>
                                                <td class="Campos">
                                                    <asp:TextBox ID="txvPeriodoDetalle" runat="server" AutoPostBack="True" CssClass="input" Visible="False" Width="100px"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:Label ID="Label18" runat="server" Text="Mes" Visible="False"></asp:Label>
                                                </td>
                                                <td class="Campos">
                                                    <asp:DropDownList ID="ddlMes" runat="server" CssClass="input" Visible="False" Width="100px">
                                                        <asp:ListItem Value="1">Enero</asp:ListItem>
                                                        <asp:ListItem Value="2">Febrero</asp:ListItem>
                                                        <asp:ListItem Value="3">Marzo</asp:ListItem>
                                                        <asp:ListItem Value="4">Abril</asp:ListItem>
                                                        <asp:ListItem Value="5">Mayo</asp:ListItem>
                                                        <asp:ListItem Value="6">Junio</asp:ListItem>
                                                        <asp:ListItem Value="7">Julio</asp:ListItem>
                                                        <asp:ListItem Value="8">Agosto</asp:ListItem>
                                                        <asp:ListItem Value="9">Septiembre</asp:ListItem>
                                                        <asp:ListItem Value="10">Octubre</asp:ListItem>
                                                        <asp:ListItem Value="11">Noviembre</asp:ListItem>
                                                        <asp:ListItem Value="12">Diciembre</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:Label ID="Label19" runat="server" Text="Tipo Nomina" Visible="False"></asp:Label>
                                                </td>
                                                <td class="Campos">
                                                    <asp:DropDownList ID="ddlTipoNomina" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:Label ID="Label21" runat="server" Text="Dias nomina" Visible="False"></asp:Label>
                                                </td>
                                                <td class="Campos">
                                                    <asp:TextBox ID="txvDiasNomina" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:LinkButton ID="lbFechaIni" runat="server" ForeColor="#003366" Visible="False" OnClick="lbFechaIni_Click">Fecha inicial</asp:LinkButton>
                                                </td>
                                                <td class="Campos">
                                                    <asp:Calendar ID="CalendarFechaIni" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaIni_SelectionChanged" Visible="False" Width="150px">
                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                    </asp:Calendar>
                                                    <asp:TextBox ID="txtFechaIni" runat="server" class="input" Font-Bold="True" ReadOnly="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px"></asp:TextBox>
                                                    <asp:Label ID="Label20" runat="server" Text="(dd/MM/aaaa)" Visible="False"></asp:Label>
                                                </td>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:LinkButton ID="lbFechaFinal" runat="server" ForeColor="#003366" Visible="False" OnClick="lbFechaFinal_Click">Fecha final</asp:LinkButton>
                                                </td>
                                                <td class="Campos">
                                                    <asp:Calendar ID="CalendarFechaFinal" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Visible="False" Width="150px" OnSelectionChanged="CalendarFechaFinal_SelectionChanged">
                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                    </asp:Calendar>
                                                    <asp:TextBox ID="txtFechaFinal" runat="server" class="input" Font-Bold="True" ReadOnly="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px"></asp:TextBox>
                                                    (dd/MM/aaaa)</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:LinkButton ID="lbFechaCorte" runat="server" ForeColor="#003366" Visible="False" OnClick="lbFechaCorte_Click">Fecha de corte</asp:LinkButton>
                                                </td>
                                                <td class="Campos">
                                                    <asp:Calendar ID="CalendarFechaCorte" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Visible="False" Width="150px" OnSelectionChanged="CalendarFechaCorte_SelectionChanged">
                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                    </asp:Calendar>
                                                    <asp:TextBox ID="txtFechaCorte" runat="server" class="input" Font-Bold="True" ReadOnly="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px"></asp:TextBox>
                                                    (dd/MM/aaaa)</td>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:LinkButton ID="lbFechaPago" runat="server" ForeColor="#003366" Visible="False" OnClick="lbFechaPago_Click">Fecha de pago</asp:LinkButton>
                                                </td>
                                                <td class="Campos">
                                                    <asp:Calendar ID="CalendarFechaPago" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" Visible="False" Width="150px" OnSelectionChanged="CalendarFechaPago_SelectionChanged">
                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                    </asp:Calendar>
                                                    <asp:TextBox ID="txtFechaPago" runat="server" class="input" Font-Bold="True" ReadOnly="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px"></asp:TextBox>
                                                    (dd/MM/aaaa)</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:CheckBox ID="chkAgronomico" runat="server" Text="Agronomico" />
                                                </td>
                                                <td class="Campos">
                                                    <asp:CheckBox ID="chkCerrado" runat="server" Text="Cerrado" />
                                                </td>
                                                <td style="width: 150px; text-align: left;">&nbsp;</td>
                                                <td class="Campos">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 150px; text-align: left;">
                                                    &nbsp;</td>
                                                <td class="Campos"></td>
                                                <td style="width: 150px; text-align: left;">&nbsp;</td>
                                                <td class="Campos"></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                        </asp:Panel>
                    </td>
                </tr>
                </table>
            <div class="tablaGrilla">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="800px" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging1">
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
                            <asp:BoundField DataField="año" HeaderText="Año" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="mes" HeaderText="Mes" ReadOnly="True"
                                SortExpression="descripcion">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="noPeriodo" HeaderText="No periodo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaInicial" HeaderText="Fecha inicial" ReadOnly="True" DataFormatString="{0:dd/MM/yyy}">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaFinal" HeaderText="Fecha final" ReadOnly="True" DataFormatString="{0:dd/MM/yyy}">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaCorte" DataFormatString="{0:dd/MM/yyy}" HeaderText="Fecha corte">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaPago" DataFormatString="{0:dd/MM/yyy}" HeaderText="Fecha Pago">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipoNomina" HeaderText="Tipo nomina" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="diasNomina" HeaderText="Dias N">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="cerrado" HeaderText="Cerrado">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="agronomico" HeaderText="Agro.">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="15px" />
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
