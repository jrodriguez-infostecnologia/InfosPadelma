<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EditarSalidas.aspx.cs" Inherits="Administracion_Caracterizacion" Theme="Entidades"%>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
        
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Edición de Salidas</title>     
        
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js" language="javascript" type="text/javascript"></script>
        
</head>
<body style="text-align: left">
    <form id="form1" runat="server">
    <div style="text-align: left">
    
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px;
                        background-repeat: no-repeat; height: 25px; text-align: left">
                        </td>
                    <td style="width: 500px; height: 25px; text-align: center; vertical-align: top;">
                        Edición de Salidas</td>
                    <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png);
                        width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">
                        </td>
                </tr>
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px;
                        background-repeat: no-repeat; text-align: left">
                    </td>
                    <td style="vertical-align: top; width: 500px; text-align: center">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label></td>
                    <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png);
                        width: 250px; background-repeat: no-repeat; text-align: left">
                    </td>
                </tr>
            </table>
        <table cellpadding="0" cellspacing="0" width="1000">
            <tr>
                <td style="width: 250px; height: 10px">
                </td>
                <td style="width: 500px; height: 10px">
                </td>
                <td style="width: 250px; height: 10px">
                </td>
            </tr>
            <tr>
                <td style="width: 250px; text-align: right;">
                    <asp:LinkButton ID="lbCancelar" runat="server" ForeColor="#404040" OnClick="lbCancelar_Click"
                        Visible="False">>>Cancelar</asp:LinkButton></td>
                <td style="width: 500px">
                    <asp:LinkButton ID="lbContabilizaSalidas" runat="server" ForeColor="#404040" OnClick="lbContabilizaSalidas_Click"
                        ToolTip="Clic aquí para contabilizar salidas de almacén">ContabilizarSalidas</asp:LinkButton>&nbsp;
                    <asp:Label ID="lblPeriodo" runat="server" Text="Periodo" Visible="False"></asp:Label>&nbsp;
                    <asp:DropDownList ID="ddlPeriodo" runat="server" Visible="False" Width="150px">
                    </asp:DropDownList>&nbsp;
                    <asp:ImageButton ID="imbContabilizar" runat="server" Height="17px" ImageUrl="~/Imagenes/botones/Asignar1.png"
                        OnClick="imbContabilizar_Click" ToolTip="Clic aquí para ejecutar la contabilización de las salidas de almacén"
                        Visible="False" Width="17px" /></td>
                <td style="width: 250px">
                    <asp:LinkButton ID="lbtnEditar" runat="server" ForeColor="#404040" OnClick="lbtnEditar_Click"
                        Visible="False">>>Editar</asp:LinkButton>
                    <asp:LinkButton ID="lbGuardar" runat="server" ForeColor="#404040" OnClick="lbGuardar_Click"
                        Visible="False">>>Guardar</asp:LinkButton></td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" style="width: 1000px">
            <tr>
                <td style="width: 150px; height: 10px;">
                </td>
                <td style="width: 200px; height: 10px;">
                </td>
                <td style="width: 500px; height: 10px;">
                </td>
                <td style="width: 150px; height: 10px;">
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="width: 200px">
                    <asp:Label ID="Label1" runat="server" Text="Tipo Transacción"></asp:Label></td>
                <td style="width: 500px">
                    <asp:DropDownList ID="ddlTipoTransaccion" runat="server"
                        Width="400px" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoTransaccion_SelectedIndexChanged1">
                    </asp:DropDownList></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="vertical-align: top; width: 200px">
                    <asp:LinkButton ID="lbFechaInicial" runat="server" ForeColor="#404040" OnClick="lbFecha_Click">Desde</asp:LinkButton></td>
                <td style="vertical-align: top; width: 500px; text-align: left">
                    <asp:Calendar ID="niCalendarFechaInicial" runat="server" BackColor="White" BorderColor="#999999"
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
                    <asp:TextBox ID="txtFechaInicial" runat="server" Font-Bold="True" ForeColor="Gray"
                        ReadOnly="True"></asp:TextBox></td>
                <td style="width: 150px">
                    <asp:HiddenField ID="hdTransaccionConfig" runat="server" />
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="vertical-align: top; width: 200px">
                    <asp:LinkButton ID="lbFechaFinal" runat="server" ForeColor="#404040" OnClick="lbFechaFinal_Click">Hasta</asp:LinkButton></td>
                <td style="vertical-align: top; width: 500px; text-align: left">
                    <asp:Calendar ID="niCalendarFechaFinal" runat="server" BackColor="White" BorderColor="#999999"
                        CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaFinal_SelectionChanged"
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
                    <asp:TextBox ID="txtFechaFinal" runat="server" Font-Bold="True" ForeColor="Gray"
                        ReadOnly="True"></asp:TextBox>&nbsp;
                    <asp:ImageButton ID="imbBuscar" runat="server" Height="17px" ImageUrl="~/Imagenes/Ver.png"
                        OnClick="imbBuscar_Click" ToolTip="Clic aquí para realizar la busqueda" Width="17px" /></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="vertical-align: top; width: 200px">
                    <asp:Label ID="lblDestino" runat="server" Text="Destino" Visible="False"></asp:Label></td>
                <td style="vertical-align: top; width: 500px; text-align: left">
                    <asp:DropDownList ID="ddlDestino" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDestino_SelectedIndexChanged"
                        Visible="False" Width="450px">
                    </asp:DropDownList></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="vertical-align: top; width: 200px">
                    <asp:Label ID="lblCuenta" runat="server" Text="Cuenta" Visible="False"></asp:Label></td>
                <td style="vertical-align: top; width: 500px; text-align: left">
                    <asp:DropDownList ID="ddlCuenta" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCuenta_SelectedIndexChanged"
                        Visible="False" Width="200px">
                    </asp:DropDownList></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px">
                </td>
                <td style="vertical-align: top; width: 200px">
                    <asp:Label ID="lblCcosto" runat="server" Text="C. Costo" Visible="False"></asp:Label></td>
                <td style="vertical-align: top; width: 500px; text-align: left">
                    <asp:DropDownList ID="ddlCcosto" runat="server" Visible="False" Width="200px">
                    </asp:DropDownList></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 10px">
                </td>
                <td style="width: 200px; height: 10px">
                </td>
                <td style="width: 500px; height: 10px">
                    <asp:CheckBox ID="chkInversion" runat="server" OnCheckedChanged="chkInversion_CheckedChanged"
                        Text="Inversión" Visible="False" /></td>
                <td style="width: 150px; height: 10px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 10px">
                </td>
                <td style="width: 200px; height: 10px">
                    <asp:Label ID="lblDetalle" runat="server" Text="Observación" Visible="False"></asp:Label></td>
                <td style="width: 500px; height: 10px">
                    <asp:TextBox ID="txtDetalle" runat="server" Height="48px" TextMode="MultiLine" Visible="False"
                        Width="376px"></asp:TextBox></td>
                <td style="width: 150px; height: 10px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 10px">
                </td>
                <td style="width: 200px; height: 10px">
                </td>
                <td style="width: 500px; height: 10px">
                </td>
                <td style="width: 150px; height: 10px">
                </td>
            </tr>
        </table>

        </div>        
                    <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None" Width="1600px" AllowPaging="True" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="50">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSeleccion" runat="server" />&nbsp;
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="numero" HeaderText="N&#250;mero">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="Fecha">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="producto" HeaderText="Producto">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="detalle" HeaderText="Detalle">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="destino" HeaderText="Destino">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Cuenta" HeaderText="Cuenta">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Ccosto" HeaderText="Ccosto">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="inversion" HeaderText="Inversi&#243;n">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="Observacion" HeaderText="Observaci&#243;n">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="registro">
                                <HeaderStyle BackColor="White" BorderColor="White" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                            </asp:BoundField>
                        </Columns>
                        <HeaderStyle BackColor="FloralWhite" />
                    </asp:GridView>
    </form>
</body>
</html>
