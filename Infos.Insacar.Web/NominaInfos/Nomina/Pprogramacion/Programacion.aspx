<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Programacion.aspx.cs" Inherits="Nomina_Pprogramacion_Programacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js"></script>
    <script language="javascript" type="text/javascript">

        var x = null
        var y = null
        var z = null
        function Visualizacion(informe) {

            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width = 1300, height = 800, top = 0, left = 5";
            sTransaccion = "../Pinformes/ImprimeInforme.aspx?informe=" + informe;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }
        function AutorizaPermiso(funcionario, nombre, turno) {
            sTransaccion = "AutorizaPermiso.aspx?funcionario=" + funcionario + "&nombre=" + nombre + "&turno=" + turno;

            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width = 600, height = 600, top = 0, left = 20";
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }
        function Programacion() {
            sTransaccion = "ImprimeProgramacion.aspx";

            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width = 1000, height = 600, top = 0, left = 20";
            y = window.open(sTransaccion, "", opciones);
            y.focus();
        }
        function Registro() {
            sTransaccion = "ImprimeRegistro.aspx";

            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width = 1000, height = 600, top = 0, left = 20";
            z = window.open(sTransaccion, "", opciones);
            z.focus();
        }

    </script>

    </head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: left;"></td>
                    <td style="width: 500px; height: 25px; text-align: center">Programación de Funcionarios</td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: right; background-position-x: right;"></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                <tr>
                    <td>
                        <asp:ImageButton ID="imbCuadrilla" runat="server" Height="35px" ImageUrl="~/Imagen/Iconos/User_casco.png"
                            OnClick="imbCuadrilla_Click" ToolTip="Clic para la administración de las cuadrillas"
                            Width="35px" />
                        Administrar Cuadrillas<asp:ImageButton ID="imbTurnos" runat="server"
                            Height="35px" ImageUrl="~/Imagen/Iconos/Reloj.png" ToolTip="Clic para la administración de turnos"
                            Width="35px" OnClick="imbTurnos_Click" />
                        Administrar Turnos<asp:ImageButton ID="imbCuadrilla0" runat="server" Height="35px" ImageUrl="~/Imagen/Iconos/clock-add-icon.png"
                            OnClick="imbCuadrilla0_Click" ToolTip="Clic para la autorizar horas extras adicionales"
                            Width="35px" />
                        Autorizar Horas Extras Adicionales
                    <asp:ImageButton ID="imbInformeProgramacion" runat="server"
                        Height="35px" ImageUrl="~/Imagen/Iconos/Folder-Clock-icon.png" ToolTip="Clic para ver el informe de programación por fecha"
                        Width="35px" OnClick="imbInformeProgramacion_Click" />
                        Informe Programación<asp:ImageButton ID="imbInformeEntradas" runat="server"
                            Height="35px" ImageUrl="~/Imagen/Iconos/Personas3535.png" ToolTip="Clic para ver el informe de registro en portería"
                            Width="35px" OnClick="imbInformeEntradas_Click" />
                        Informe Portería</td>
                </tr>
                <tr>
                    <td style="height: 10px"></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 500px; text-align: left;"><table cellpadding="0" cellspacing="0" >
                        <tr>
                            <td style="width: 100px">Turno</td>
                            <td>
                    <asp:DropDownList ID="niddlTurno" runat="server" Width="350px" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="niddlTurno_SelectedIndexChanged">
                    </asp:DropDownList></td>
                        </tr>
                        </table>
                    </td>
                    <td style="width: 250px"></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="width: 50px; height: 10px; text-align: left"></td>
                    <td style="width: 200px; height: 10px; text-align: left"></td>
                    <td style="width: 170px; height: 10px"></td>
                    <td style="width: 70px; height: 10px"></td>
                    <td style="width: 460px; height: 10px"></td>
                    <td style="width: 50px; height: 10px"></td>
                </tr>
                <tr>
                    <td style="width: 50px; text-align: left"></td>
                    <td style="vertical-align: top; width: 200px; text-align: left">
                        <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#404040" OnClick="lbFecha_Click">Programación para la semana</asp:LinkButton></td>
                    <td style="width: 170px; text-align: left">
                        <asp:Calendar ID="CalendarFecha" runat="server" BackColor="White" BorderColor="#999999"
                            CellPadding="4" DayNameFormat="Shortest" FirstDayOfWeek="Monday" Font-Names="Verdana"
                            Font-Size="8pt" ForeColor="Black" Height="180px" Visible="False" Width="150px" OnSelectionChanged="CalendarFecha_SelectionChanged">
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <WeekendDayStyle BackColor="FloralWhite" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFecha" runat="server" Enabled="False" Font-Bold="True" ForeColor="Gray"
                            ReadOnly="True"></asp:TextBox></td>
                    <td style="vertical-align: top; width: 70px; text-align: left">
                        <asp:Label ID="Label1" runat="server">Cuadrilla</asp:Label></td>
                    <td style="vertical-align: top; width: 460px; text-align: left">
                        <asp:DropDownList ID="ddlCuadrilla" runat="server" Width="350px" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlCuadrilla_SelectedIndexChanged">
                        </asp:DropDownList></td>
                    <td style="width: 50px"></td>
                </tr>
                <tr>
                    <td style="width: 50px; height: 10px; text-align: left"></td>
                    <td style="width: 200px; height: 10px; text-align: left"></td>
                    <td style="width: 170px; height: 10px"></td>
                    <td style="width: 70px; height: 10px"></td>
                    <td style="width: 460px; height: 10px"></td>
                    <td style="width: 50px; height: 10px"></td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="width: 250px; text-align: right">
                        <asp:ImageButton ID="lbAsignar" runat="server" ImageUrl="~/Imagen/Bonotes/btnAsignar.png" ToolTip="Habilita el formulario para un nuevo registro" OnClick="lbAsignar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnAsignar.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnAsignarN.png'" />
                    </td>
                    <td style="width: 500px"></td>
                    <td style="width: 250px; text-align: left">

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea registrar la programación ?')){return false;};" />
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                <tr>
                    <td>
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="height: 10px"></td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" Width="950px" GridLines="None" CssClass="Grid">
                            <Columns>
                                <asp:BoundField DataField="funcionario" HeaderText="Código">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"  Width="50px"/>
                                </asp:BoundField>
                                <asp:BoundField DataField="descripcion" HeaderText="Nombre">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="cargo" HeaderText="Cargo">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Programado">
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkAsignacion" runat="server" AutoPostBack="True" OnCheckedChanged="chkAsignacion_CheckedChanged" />
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Lun">
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkLun" runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkLunT" runat="server" Text="Lun" TextAlign="Left" AutoPostBack="True" OnCheckedChanged="chkLunT_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mar">
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkMar" runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkMarT" runat="server" Text="Mar" TextAlign="Left" AutoPostBack="True" OnCheckedChanged="chkMarT_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mie">
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkMie" runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkMieT" runat="server" Text="Mie" TextAlign="Left" AutoPostBack="True" OnCheckedChanged="chkMieT_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Jue">
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkJue" runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkJueT" runat="server" Text="Jue" TextAlign="Left" AutoPostBack="True" OnCheckedChanged="chkJueT_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vie">
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkVie" runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkVieT" runat="server" Text="Vie" TextAlign="Left" AutoPostBack="True" OnCheckedChanged="chkVieT_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sab">
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkSab" runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkSabT" runat="server" Text="Sab" TextAlign="Left" AutoPostBack="True" OnCheckedChanged="chkSabT_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Dom">
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                    <ItemTemplate>
                                        <asp:CheckBox ID="chkDom" runat="server" />
                                    </ItemTemplate>
                                    <HeaderTemplate>
                                        <asp:CheckBox ID="chkDomT" runat="server" Text="Dom" TextAlign="Left" AutoPostBack="True" OnCheckedChanged="chkDomT_CheckedChanged" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="pgr" />
                            <RowStyle CssClass="rw" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px; text-align: left"></td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <asp:ImageButton ID="lbRegistrarExtras" runat="server" ImageUrl="~/Imagen/Bonotes/btnRegistrarExtras.png" ToolTip="Clic aquí para registrar la programación de horas extras adicionales" OnClick="lbRegistrarExtras_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnRegistrarExtras.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnRegistrarExtrasN.png'" OnClientClick="if(!confirm('Desea registrar la programación de horas extras ?')){return false;};" />
                    </td>
                </tr>
                <tr>
                    <td style="height: 10px; text-align: left"></td>
                </tr>
                <tr>
                    <td style="text-align: left">
                        <asp:GridView ID="gvExtras" runat="server" AutoGenerateColumns="False" Width="950px" GridLines="None" Visible="False" CssClass="Grid">
                            <Columns>
                                <asp:BoundField DataField="funcionario" HeaderText="Funcionario">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="descripcion" HeaderText="Nombre">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="cargo" HeaderText="Cargo">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Lun">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtExtrasLun" runat="server" Visible="False" Width="30px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" BackColor="#E0E0E0" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mar">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtExtrasMar" runat="server" Visible="False" Width="30px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" BackColor="#E0E0E0" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mie">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtExtrasMie" runat="server" Visible="False" Width="30px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" BackColor="#E0E0E0" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Jue">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtExtrasJue" runat="server" Visible="False" Width="30px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" BackColor="#E0E0E0" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Vie">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtExtrasVie" runat="server" Visible="False" Width="30px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" BackColor="#E0E0E0" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Sab">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtExtrasSab" runat="server" Visible="False" Width="30px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" BackColor="#E0E0E0" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Dom">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtExtrasDom" runat="server" Visible="False" Width="30px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"
                                        HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" BackColor="#E0E0E0" />
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="pgr" />
                            <RowStyle CssClass="rw" />
                        </asp:GridView>
                    </td>
                </tr>
            </table>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
