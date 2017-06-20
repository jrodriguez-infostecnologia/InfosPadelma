<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Despachos.aspx.cs" Inherits="Logistica_Pprogrmacion_ProgramacionGeneral" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
    <script type="text/javascript">

        function imprimirTabla() {

            var contenido = document.getElementById("Lista").innerHTML;

            ventana = window.open("about:blank", "ventana", "width=auto,height=auto,top=0;");
            ventana.title = "Imprimiendo..."
            ventana.document.open();
            ventana.document.write(contenido);
            ventana.document.close();
            ventana.print();
            ventana.onprint = ventana.close();
        }

    </script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td class="nombreCampos"></td>
                    <td colspan="4">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        Despachos de planta extractora</td>
                    <td style="width: 250px" class="bordes"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 200px"></td>
                    <td style="width: 150px">
                        <asp:LinkButton ID="niLbFechaInicial" runat="server" ForeColor="#404040" OnClick="niLbFechaInicial_Click">Consulta Desde</asp:LinkButton>
                    </td>
                    <td class="Campos">
                        <asp:Calendar ID="CalendarInicial" runat="server" BackColor="White" BorderColor="Silver" BorderWidth="1px" CellPadding="1" DayNameFormat="FirstTwoLetters" Font-Names="Trebuchet MS" Font-Size="10px" ForeColor="#003366" Height="180px" Visible="False" Width="180px" OnSelectionChanged="CalendarInicial_SelectionChanged">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        </asp:Calendar>
                        <asp:TextBox ID="niTxtFechaI" runat="server" Font-Bold="True" ForeColor="Gray" ReadOnly="True" CssClass="input"></asp:TextBox>
                    </td>
                    <td style="width: 80px">
                        <asp:LinkButton ID="niLbFechaFinal" runat="server" ForeColor="#404040" OnClick="niLbFechaFinal_Click">Hasta</asp:LinkButton>
                    </td>
                    <td class="Campos">
                        <asp:Calendar ID="CalendarFinal" runat="server" BackColor="White" BorderColor="Silver" BorderWidth="1px" CellPadding="1" DayNameFormat="FirstTwoLetters" Font-Names="Trebuchet MS" Font-Size="10px" ForeColor="#003366" Height="180px" Visible="False" Width="180px" OnSelectionChanged="CalendarFinal_SelectionChanged">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        </asp:Calendar>
                        <asp:TextBox ID="niTxtFechaF" runat="server" Font-Bold="True" ForeColor="Gray" ReadOnly="True" CssClass="input"></asp:TextBox>
                    </td>
                    <td style="width: 250px" class="bordes"></td>
                </tr>
                <tr>
                    <td class="nombreCampos"></td>
                    <td colspan="4">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                    </td>
                    <td style="width: 250px" class="bordes"></td>
                </tr>
                <tr>
                    <td class="nombreCampos"></td>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                    <td style="width: 250px" class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="6" style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                </tr>
            </table>
            <div style="text-align: center">
                <div style="display: inline-block">
                    <table id="Lista">
                        <tr>
                            <td>
                                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" PageSize="20" Width="700px" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged">
                                    <AlternatingRowStyle CssClass="alt" />
                                    <Columns>
                                        <asp:BoundField DataField="fecha" DataFormatString="{0:d}"
                                            HeaderText="Fecha" ReadOnly="True">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                HorizontalAlign="Left" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Size="Small" HorizontalAlign="Left" Width="100px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="descripcionProducto" HeaderText="Producto">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                HorizontalAlign="Left" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Size="Small" HorizontalAlign="Left" Width="200px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="vehiculo" HeaderText="Placa">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Size="Small" Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="remolque" HeaderText="Remolque">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                HorizontalAlign="Left" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                Font-Size="Small" HorizontalAlign="Left" Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="cantidad" HeaderText="Can. (tn)">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                                HorizontalAlign="Center" Width="50px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="tiquete" HeaderText="Tiquete">
                                            <ItemStyle Width="80px" />
                                        </asp:BoundField>
                                        <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/large_picture.png" Text="Botón">
                                            <ItemStyle CssClass="Items" Width="20px" />
                                        </asp:ButtonField>
                                        <asp:BoundField DataField="sellos" HeaderText="F.Sell.">
                                        <ItemStyle Width="20px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <PagerStyle CssClass="pgr" />
                                    <RowStyle CssClass="rw" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </div>
            </div>

        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>


