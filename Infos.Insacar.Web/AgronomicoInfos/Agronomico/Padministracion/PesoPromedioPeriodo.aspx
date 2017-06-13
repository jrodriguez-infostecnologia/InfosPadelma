<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PesoPromedioPeriodo.aspx.cs" Inherits="Agronomico_Padministracion_PesoPromedioPeriodo" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <%-- Este es el estilo de combobox --%>

    <link href="../../css/chosen.css" rel="stylesheet" />
    <style type="text/css">
        a img {
            border: none;
        }

        ol li {
            list-style: decimal outside;
        }

        div#container {
            width: 780px;
            margin: 0 auto;
            padding: 1em 0;
        }

        div.side-by-side {
            width: 100%;
            margin-bottom: 1em;
        }

            div.side-by-side > div {
                float: left;
                width: 50%;
            }

                div.side-by-side > div > em {
                    margin-bottom: 10px;
                    display: block;
                }

        .clearfix:after {
            content: "\0020";
            display: block;
            height: 0;
            clear: both;
            overflow: hidden;
            visibility: hidden;
        }
    </style>

    <%-- Aqui termina el estilo es el estilo de combobox --%>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">

            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
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
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                    </td>
                </tr>
            </table>

            <table cellpadding="0" cellspacing="0" style="width: 100%; border-bottom-style: solid; border-top-style: solid; border-top-width: 1px; border-bottom-width: 1px; border-top-color: silver; border-bottom-color: silver;">
                <tr>
                    <td colspan="4" height="8">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label11" runat="server" Text="Año" Visible="False"></asp:Label>

                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlAño" runat="server" CssClass="input" Width="100px" Visible="False" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>

                        <asp:Label ID="Label12" runat="server" Text="Mes" Visible="False"></asp:Label>
                        <asp:DropDownList ID="ddlMes" runat="server" CssClass="input" Width="100px" Visible="False">
                        </asp:DropDownList>

                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label4" runat="server" Text="Finca" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList data-placeholder="Seleccione una opción..." ID="ddlFinca" runat="server" class="chzn-select" Width="350px" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlFinca_SelectedIndexChanged">
                        </asp:DropDownList>

                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lbSecion" runat="server" Text="Sección" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList data-placeholder="Seleccione una opción..." ID="ddlSecciones" runat="server" class="chzn-select" Width="350px" Visible="False" OnSelectedIndexChanged="ddlSecciones_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>

                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lbLote" runat="server" Text="Lote" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList data-placeholder="Seleccione una opción..." ID="ddlLote" runat="server" class="chzn-select" Width="350px" Visible="False">
                        </asp:DropDownList>

                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label14" runat="server" Text="Peso  Rac. Promedio(Kg)" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvPesoPromedio" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox>
                        <asp:CheckBox ID="chkAutomatico" runat="server" Text="Automatico" Visible="False" AutoPostBack="True" OnCheckedChanged="chkAutomatico_CheckedChanged" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes">&nbsp;</td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="lbFechaInicial" runat="server" ForeColor="#003366" OnClick="lbFechaInicial_Click" Visible="False">Fecha inicial</asp:LinkButton>
                    </td>
                    <td class="Campos">
                        <asp:Calendar ID="CalendarFechaInicial" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaInicial_SelectionChanged" Visible="False" Width="150px">
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaInicial" runat="server" class="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px" ReadOnly="True" AutoPostBack="True" OnTextChanged="txtFechaInicial_TextChanged"></asp:TextBox>
                    </td>
                    <td class="bordes">&nbsp;</td>
                </tr>
                <tr>
                    <td class="bordes">&nbsp;</td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="lbFechaFinal" runat="server" ForeColor="#003366" OnClick="lbFechaFinal_Click" Visible="False">Fecha final</asp:LinkButton>
                    </td>
                    <td class="Campos">
                        <asp:Calendar ID="CalendarFechaFinal" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaTiqueteI_SelectionChanged1" Visible="False" Width="150px">
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaFinal" runat="server" class="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px" ReadOnly="True" AutoPostBack="True" OnTextChanged="txtFechaFinal_TextChanged"></asp:TextBox>
                    </td>
                    <td class="bordes">&nbsp;</td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">&nbsp;</td>
                    <td style="text-align: right">

                        <asp:ImageButton ID="lbGenerar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGenerar.png" ToolTip="Genera el peso promedio del mes"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGenerar.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGenerarN.png'" OnClick="lbGenerar_Click" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
            </table>

            <div class="tablaGrilla">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" PageSize="20" Width="800px" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
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
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="mes" HeaderText="Mes" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="finca" HeaderText="Finca" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="seccion" HeaderText="Bloque">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="lote" HeaderText="Lote">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pesoRacimo" HeaderText="PesoRacPro (Kg) ">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="automatico" HeaderText="Automatico">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="fechaInicial" HeaderText="FechaInicial" DataFormatString="{0:d}">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaFinal" HeaderText="FechaFinal" DataFormatString="{0:d}">
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

    </form>
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: false }); </script>

</body>
</html>
