<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DespachosDiarios.aspx.cs" Inherits="Logistica_Pprogramacion_ProgramacionVehiculos" %>

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
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td style="width: 200px">
                        &nbsp;</td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="niLbFechaInicial" runat="server" OnClick="niLbFechaInicial_Click" Style="color: #003366">Consulta Desde</asp:LinkButton>
                    </td>
                    <td style="text-align: left">
                        <asp:Calendar ID="CalendarInicial" runat="server" BackColor="White" BorderColor="Silver" BorderWidth="1px" CellPadding="1" DayNameFormat="FirstTwoLetters" Font-Names="Trebuchet MS" Font-Size="10px" ForeColor="#003366" Height="180px" OnSelectionChanged="Calendar1_SelectionChanged" Width="180px" Visible="False">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        </asp:Calendar>
                        <asp:TextBox ID="niTxtFechaI" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" OnTextChanged="niTxtFechaI_TextChanged"></asp:TextBox>
                    </td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="niLbFechaFinal" runat="server" OnClick="niLbFechaFinal_Click" Style="color: #003366">Hasta</asp:LinkButton>
                    </td>
                    <td style="text-align: left">
                        <asp:Calendar ID="CalendarFinal" runat="server" BackColor="White" BorderColor="Silver" BorderWidth="1px" CellPadding="1" DayNameFormat="FirstTwoLetters" Font-Names="Trebuchet MS" Font-Size="10px" ForeColor="#003366" Height="180px" OnSelectionChanged="CalendarFinal_SelectionChanged" Width="180px" Visible="False">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        </asp:Calendar>
                        <asp:TextBox ID="niTxtFechaF" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" OnTextChanged="niTxtFechaF_TextChanged"></asp:TextBox>
                    </td>
                    <td style="width: 200px"></td>
                </tr>
                <tr>
                    <td colspan="6">
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 100%; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lbExtractora" runat="server" Text="Planta Extractora" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlPlanta" runat="server" Visible="False" Width="350px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos" style="vertical-align: top"></td>
                    <td style="text-align: left; height: 10px;"></td>
                    <td style="width: 40px"></td>
                </tr>
            </table>
            <div >
                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" PageSize="20" Width="1300px" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:ButtonField ButtonType="Image" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón" CommandName="Select">
                            <ItemStyle Width="20px" CssClass="Items" />
                        </asp:ButtonField>
                        <asp:BoundField DataField="fechaDespacho" DataFormatString="{0:d}" HeaderText="Fecha" >
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="remision" HeaderText="NoDespacho">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="remisionComercializadora" HeaderText="RemBiocosta">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tiquete" HeaderText="NoTiquete">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cliente" HeaderText="Cliente" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                        <asp:BoundField DataField="planta" HeaderText="IdPlanta" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                        <asp:BoundField DataField="nombrePlanta" HeaderText="NombrePlanta" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cantidad" DataFormatString="{0:N0}" HeaderText="Cantidad" >
                                <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="producto" HeaderText="Producto" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vehiculo" HeaderText="Veh&#237;culo" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="remolque" HeaderText="Remolque" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="idConductor" HeaderText="CC.Conductor">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nombreConductor" HeaderText="Conductor" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="agl" DataFormatString="{0:N2}" HeaderText="AGL">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="h" DataFormatString="{0:N2}" HeaderText="H">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="i" DataFormatString="{0:N2}" HeaderText="I">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="20px" />
                            </asp:BoundField>
                        <asp:BoundField DataField="programacion"  HeaderText="Programacón">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="20px" />
                            </asp:BoundField>
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



