<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConsultarLog.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Logística y Programación</title>
    <link href="../../css/Calendarios.css" rel="stylesheet" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/CalendarioMin.js" type="text/javascript"></script>
    <script src="../../js/CalendarioUiMin.js" type="text/javascript"></script>
    <script language="javascript" type="text/javascript">

        function imprimirTabla() {

            var contenido = document.getElementById("Lista").innerHTML;

            ventana = window.open("about:blank", "ventana", "width=auto,height=auto,top=0;");
            ventana.title = "Imprimiendo..."
            ventana.document.open();
            ventana.document.write(contenido.replace("style", " "));
            ventana.document.close();
            ventana.print();
            ventana.onprint = ventana.close();
        }

    </script>

    <script type="text/javascript">
        $(function () {
            $("[id$=txtDesde]").datepicker({
                showOn: 'button',
                buttonImageOnly: true,
                buttonImage: '../../Imagen/TabsIcon/Google-Calendar-icon.png'
            });
        });
    </script>

    <script type="text/javascript">
        $(function () {
            $("[id$=txtHasta]").datepicker({
                showOn: 'button',
                buttonImageOnly: true,
                buttonImage: '../../Imagen/TabsIcon/Google-Calendar-icon.png'
            });
        });
    </script>
    <style type="text/css">
        .input {
            padding: 0px 3px 0px 3px;
            border-width: 1px;
            border-color: silver;
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            font-size: 12px;
            color: #003366;
            height: 20px;
            border-style: solid;
            border-radius: 2px 2px 2px 2px;
            box-shadow: 0 2px 2px rgba(0, 0, 0, 0.080) inset;
        }
    </style>


</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">

            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); width: 250px; background-repeat: no-repeat; height: 25px; text-align: center; vertical-align: top;">
                        <asp:ImageButton ID="nilblRegresar" runat="server" ToolTip="Regresar" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="nilblRegresar_Click" />
                    </td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="lbFechaDesde" runat="server" ForeColor="#003366" OnClick="lbFechaIngreso_Click">Desde</asp:LinkButton>
                    </td>
                    <td style="text-align: left">
                        <asp:Calendar ID="niCalendarFechaDesde" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaSalida_SelectionChanged" Visible="False" Width="150px">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaDesde" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" OnTextChanged="txtFecha_TextChanged" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px"></asp:TextBox>
                    </td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="lbFechaHasta" runat="server" ForeColor="#003366" OnClick="lbFechaHasta_Click">Hasta</asp:LinkButton>
                    </td>
                    <td style="text-align: left">
                        <asp:Calendar ID="niCalendarFechaHasta" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaHasta_SelectionChanged" Visible="False" Width="150px">
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaHasta" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" OnTextChanged="txtFechaHasta_TextChanged" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px"></asp:TextBox>
                    </td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: right; background-position-x: right;"></td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;" id="Lista">
                <tr>
                    <td style="vertical-align: middle; width: 100%; text-align: center">
                        <table cellspacing="0" style="width: 100%">
                            <tr>
                                <td class="bordes"></td>
                                <td class="nombreCampos">Texto para busqueda</td>
                                <td class="Campos">
                                    <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" CssClass="input"></asp:TextBox>
                                </td>
                                <td class="bordes"></td>
                            </tr>
                            <tr>
                                <td style="text-align: center" colspan="4">
                                    <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                                        onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                                        onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                                    <asp:ImageButton ID="imbImprimir" runat="server" ImageUrl="~/Imagen/Bonotes/btnImprimir.png" ToolTip="Haga clic aqui para imprimir la consulta"
                                        onmouseout="this.src='../../Imagen/Bonotes/btnImprimir.png'"
                                        onmouseover="this.src='../../Imagen/Bonotes/btnImprimirN.png'" OnClientClick="javascript:imprimirTabla();return false;" />
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td style="height: 8px;">
                        <asp:Label ID="niLblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%; text-align: center;">
                        <div style="text-align: center">
                            <div style="display: inline-block">
                                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" PageSize="30" Width="960px" OnPageIndexChanging="gvLista_PageIndexChanging">
                                    <AlternatingRowStyle CssClass="alt" />
                                    <Columns>
                                        <asp:BoundField DataField="usuario" HeaderText="Usuario">
                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="fecha" HeaderText="Fecha">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="descripcion" HeaderText="Operaci&#243;n">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="entidad" HeaderText="Entidad">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="estado" HeaderText="Estado">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="mensajeSistema" HeaderText="Mensaje Sistema">
                                            <HeaderStyle HorizontalAlign="Left" />
                                            <ItemStyle HorizontalAlign="Left" />
                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="ip" HeaderText="Ip">
                                            <HeaderStyle HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" />
                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                        </asp:BoundField>
                                    </Columns>
                                    <PagerStyle CssClass="pgr" />
                                    <RowStyle CssClass="rw" />
                                </asp:GridView>

                            </div>
                        </div>

                    </td>
                </tr>
                <tr>
                    <td style="text-align: center"></td>
                </tr>
            </table>

        </div>
       
    </form>
</body>
</html>
