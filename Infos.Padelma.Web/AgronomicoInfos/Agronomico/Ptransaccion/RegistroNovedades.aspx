<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegistroNovedades.aspx.cs" Inherits="Agronomico_Ptransaccion_RegistroNovedades" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ OutputCache Location="None" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Registro Novedades</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/jquery.js" type="text/javascript"></script>
    <link href="../../css/prueba.css" rel="stylesheet" type="text/css" />
    <link href="../../css/chosen.css" rel="stylesheet" />
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <asp:ScriptManager runat="server" ID="ScriptManager1">
        </asp:ScriptManager>
        <script type="text/javascript">
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
            function endReq(sender, args) {
                $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true });
            }
        </script>
        <div style="text-align: center">
            <div style="display: inline-block">
                <div style="vertical-align: top; width: 1000px; height: 600px; text-align: left" class="principal">
                    <asp:UpdatePanel ID="upGeneral" runat="server">
                        <ContentTemplate>
                            <table cellspacing="0" style="width: 1000px" cellpadding="0">
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
                            <asp:UpdatePanel ID="upRegistro" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div style="padding: 10px">
                                        <table id="encabezado" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); background-repeat: no-repeat; text-align: center;" colspan="3">
                                                    <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="nilbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                                                    <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                                                    <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                                                    <asp:ImageButton ID="lbImprimir" runat="server" ImageUrl="~/Imagen/Bonotes/btnImprimir.png" OnClick="lbImprimir_Click" onmouseout="this.src='../../Imagen/Bonotes/btnImprimir.png'" onmouseover="this.src='../../Imagen/Bonotes/btnImprimirN.png'" ToolTip="Haga clic aqui para realizar la busqueda" Visible="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;" colspan="3">
                                                    <asp:Label ID="nilblInformacion" runat="server" ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px; background-repeat: no-repeat; text-align: right;"></td>
                                                <td style="width: 600px; text-align: center;">
                                                    <table cellspacing="0" style="width: 800px">
                                                        <tr>
                                                            <td style="width: 125px; height: 25px; text-align: left">
                                                                <asp:Label ID="lblTipoDocumento" runat="server" Text="Tipo Transacción" Visible="False"></asp:Label></td>
                                                            <td style="width: 260px; height: 25px; text-align: left">
                                                                <asp:DropDownList ID="ddlTipoDocumento" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged"
                                                                    Visible="False" Width="350px">
                                                                </asp:DropDownList></td>
                                                            <td style="width: 65px; height: 25px; text-align: left">
                                                                <asp:Label ID="lblNumero" runat="server" Text="Numero" Visible="False"></asp:Label></td>
                                                            <td style="width: 150px; height: 25px; text-align: left">
                                                                <asp:TextBox ID="txtNumero" runat="server" AutoPostBack="True" OnTextChanged="txtNumero_TextChanged"
                                                                    Visible="False" Width="150px" CssClass="input"></asp:TextBox></td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 100px"></td>
                                            </tr>
                                        </table>
                                        <asp:UpdatePanel ID="upCabeza" runat="server" UpdateMode="Conditional" Visible="False">
                                            <ContentTemplate>
                                                <table cellspacing="0" style="width: 1000px; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid; border-color: silver; border-width: 1px;" id="datosCab">
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
                                                                Visible="False" CssClass="input" AutoPostBack="True" OnTextChanged="txtFecha_TextChanged"></asp:TextBox></td>
                                                        <td style="vertical-align: top; width: 100px; text-align: left">
                                                            <asp:Label ID="lblFinca" runat="server" Text="Finca" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="vertical-align: top; width: 400px; text-align: left">
                                                            <asp:DropDownList ID="ddlFinca" runat="server" AutoPostBack="True" CssClass="input" OnSelectedIndexChanged="ddlFinca_SelectedIndexChanged" Visible="False" Width="300px">
                                                            </asp:DropDownList>
                                                            <asp:HiddenField ID="hdTransaccionConfig" runat="server" />
                                                            <asp:HiddenField ID="hdRegistro" runat="server" Value="0" />
                                                            <asp:HiddenField ID="hdCantidad" runat="server" Value="0" />
                                                        </td>
                                                        <td style="width: 100px; text-align: left"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                                        <td style="width: 125px; height: 10px; text-align: left">
                                                            <asp:Label ID="lblNovedad" runat="server" Text="Novedad"></asp:Label>
                                                        </td>
                                                        <td style="width: 175px; height: 10px; text-align: left">
                                                            <asp:DropDownList ID="ddlNovedad" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlNovedad_SelectedIndexChanged" Width="300px" CssClass="input">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 100px; height: 10px; text-align: left;">
                                                            <asp:Label ID="lblUmedida" runat="server" Text="Unidad medida" Visible="False" Width="90px"></asp:Label>
                                                        </td>
                                                        <td style="width: 400px; height: 10px; text-align: left;">
                                                            <asp:DropDownList ID="ddlUmedida" runat="server" CssClass="input" data-placeholder="Seleccione una opción..." Visible="False" Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 100px; height: 10px; text-align: left;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                                        <td style="width: 125px; height: 10px; text-align: left">
                                                            <asp:Label ID="lblSeccion" runat="server" Text="Seccion/Bloque" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 175px; height: 10px; text-align: left">
                                                            <asp:DropDownList ID="ddlSeccion" runat="server" AutoPostBack="True" CssClass="input" OnSelectedIndexChanged="ddlSeccion_SelectedIndexChanged1" Visible="False" Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 100px; height: 10px; text-align: left;">
                                                            <asp:Label ID="lblLote" runat="server" Text="Lote" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 400px; height: 10px; text-align: left;">
                                                            <asp:DropDownList ID="ddlLote" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlLote_SelectedIndexChanged" Visible="False" Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 100px; height: 10px; text-align: left;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                                        <td colspan="4" style="height: 10px; text-align: left">
                                                            <table cellpadding="0" cellspacing="0" class="ui-accordion">
                                                                <tr>
                                                                    <td style="padding-right: 4px; padding-left: 4px">
                                                                        <asp:Label ID="lblCantidad" runat="server" Text="Cantidad" Visible="False"></asp:Label>
                                                                    </td>
                                                                    <td style="padding-right: 4px; padding-left: 4px">
                                                                        <asp:TextBox ID="txvCantidad" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="110px">0</asp:TextBox>
                                                                    </td>
                                                                    <td style="padding-right: 4px; padding-left: 4px">
                                                                        <asp:Label ID="lblJornal" runat="server" Text="Jornales" Visible="False"></asp:Label>
                                                                    </td>
                                                                    <td style="padding-right: 4px; padding-left: 4px">
                                                                        <asp:TextBox ID="txvJornal" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="110px">0</asp:TextBox>
                                                                    </td>
                                                                    <td style="padding-right: 4px; padding-left: 4px"></td>
                                                                    <td style="padding-right: 4px; padding-left: 4px"></td>
                                                                    <td style="padding-right: 4px; padding-left: 4px"></td>
                                                                    <td style="padding-right: 4px; padding-left: 4px; width: 300px;"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="width: 100px; height: 10px; text-align: left;"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                                        <td style="width: 125px; height: 10px; text-align: left">
                                                            <asp:Label ID="lblObservacion" runat="server" Text="Observación" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="height: 10px; text-align: left" colspan="3">
                                                            <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="40px" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlTipoDocumento" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="gvLista" EventName="RowDeleting" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                        <asp:UpdatePanel ID="upDetalle" runat="server" UpdateMode="Conditional" Visible="False">
                                            <ContentTemplate>
                                                <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="datosDet">
                                                    <tr>
                                                        <td style="width: 200px; text-align: left; vertical-align: top; height: 199px;">
                                                            <table cellspacing="0" style="width: 200px; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid; border-width: 1px; border-color: silver;" id="TABLE1">
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblTercero" runat="server" Text="Tercero" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:DropDownList ID="ddlTercero" runat="server" data-placeholder="Seleccione una opción..." Visible="False" Width="200px" CssClass="chzn-select">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:LinkButton ID="lbFechaD" runat="server" OnClick="lbFechaD_Click" Style="color: #003366" Visible="False">Fecha labor</asp:LinkButton>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Calendar ID="cldFechaD" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="cldFechaD_SelectionChanged" Visible="False" Width="150px">
                                                                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                                            <SelectorStyle BackColor="#CCCCCC" />
                                                                            <WeekendDayStyle BackColor="FloralWhite" />
                                                                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                                            <OtherMonthDayStyle ForeColor="Gray" />
                                                                            <NextPrevStyle VerticalAlign="Bottom" />
                                                                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                                        </asp:Calendar>
                                                                        <asp:TextBox ID="txtFechaD" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Visible="False" AutoPostBack="True" OnTextChanged="txtFechaD_TextChanged"></asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblSeccionD" runat="server" Text="Seccion/Bloque" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:DropDownList ID="ddlSeccionD" runat="server" CssClass="input" Visible="False" Width="200px" OnSelectedIndexChanged="ddlSeccion_SelectedIndexChanged" AutoPostBack="True">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblLoteD" runat="server" Text="Lote" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:DropDownList ID="ddlLoteD" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px" OnSelectedIndexChanged="ddlLote_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left" class="auto-style1">
                                                                        <asp:Label ID="lblCantidadD" runat="server" Text="Cantidad"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txvCantidadD" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="110px">0</asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblJornalesD" runat="server" Text="Jornales"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txvJornalesD" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="110px">0</asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:CheckBox ID="chkValidaJornal" runat="server" AutoPostBack="True" OnCheckedChanged="chkValidaJornal_CheckedChanged" Text="No aplica jornal" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: center">
                                                                        <asp:ImageButton ID="imbCargar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="btnRegistrar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="width: 756px; text-align: left; vertical-align: top;">
                                                            <asp:GridView ID="gvLista" runat="server" Width="900px" AutoGenerateColumns="False" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" GridLines="None" RowHeaderColumn="cuenta" CssClass="Grid">
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
                                                                    <asp:BoundField DataField="labor" HeaderText="Labor">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="nombreLabor" HeaderText="NombreLabor">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="180px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="empleado" HeaderText="Id">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="nombreEmpleado" HeaderText="NombreEmpleado">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="180px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="uMedida" HeaderText="uMedida">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="seccion" HeaderText="S/B">
                                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="lote" HeaderText="Lote">
                                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyyy}">
                                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="40px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cant">
                                                                        <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="jornales" DataFormatString="{0:N2}" HeaderText="Jor">
                                                                        <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="registro" HeaderText="Reg">
                                                                        <HeaderStyle BackColor="White" />
                                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="5px" />
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Anul">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkAnulado" runat="server" Enabled="False" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="10px" />
                                                                    </asp:TemplateField>
                                                                    <asp:CheckBoxField DataField="noAplicaJornal" HeaderText="NAJ">
                                                                        <HeaderStyle Width="10px" />
                                                                    </asp:CheckBoxField>
                                                                </Columns>
                                                                <PagerStyle CssClass="pgr" />
                                                                <RowStyle CssClass="rw" />
                                                            </asp:GridView>
                                                            <br />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ContentTemplate>
                                            <Triggers>
                                                <asp:AsyncPostBackTrigger ControlID="ddlSeccion" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>

                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="upConsulta" runat="server" Visible="False" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                        <tr>
                                            <td style="width: 100px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                                            <td style="width: 350px;">
                                                <asp:DropDownList ID="niddlCampo" runat="server" data-placeholder="Selección de campo para busqueda..." CssClass="chzn-select"
                                                    Width="300px">
                                                </asp:DropDownList></td>
                                            <td style="width: 130px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlOperador" runat="server" data-placeholder="Seleccione operador para busqueda..." CssClass="chzn-select"
                                                    Width="95px" AutoPostBack="True" OnSelectedIndexChanged="niddlOperador_SelectedIndexChanged">
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
                                                <asp:TextBox ID="nitxtValor1" runat="server" Width="95px" AutoPostBack="True" OnTextChanged="nitxtValor1_TextChanged" CssClass="input"></asp:TextBox><asp:TextBox
                                                    ID="nitxtValor2" runat="server" Visible="False" Width="95px" CssClass="input"></asp:TextBox></td>
                                            <td style="width: 70px; height: 25px; text-align: center">
                                                <asp:ImageButton ID="niimbAdicionar"
                                                    runat="server" ImageUrl="~/Imagen/TabsIcon/filter.png" ToolTip="Clic aquí para adicionar parámetro a la busqueda" Enabled="False" OnClick="niimbAdicionar_Click" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" /></td>
                                            <td style="width: 70px; height: 25px; text-align: center">
                                                <asp:ImageButton ID="imbBusqueda" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Enabled="False" ImageUrl="~/Imagen/TabsIcon/search.png" OnClick="imbBusqueda_Click" ToolTip="Clic aquí para realizar la busqueda" Visible="False" />
                                            </td>
                                            <td style="width: 170px; height: 25px; text-align: left">
                                                <asp:Label ID="nilblRegistros" runat="server" Text="Nro. Registros 0"></asp:Label>
                                            </td>
                                            <td style="width: 100px;"></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                        <tr>
                                            <td style="height: 10px; text-align: center;">
                                                <asp:Label ID="nilblMensajeEdicion" runat="server" ForeColor="Navy"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="height: 10px;">
                                                <div style="text-align: center">
                                                    <div style="display: inline-block">
                                                        <asp:GridView ID="gvParametros" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" OnRowDeleting="gvParametros_RowDeleting" Width="400px">
                                                            <AlternatingRowStyle CssClass="alt" />
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="imbEliminarParametro" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" ToolTip="Elimina el parámetro de la consulta" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                                    <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="campo" HeaderText="Campo">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="operador" HeaderText="Operador">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valor" HeaderText="Valor">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
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
                                    <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                        <tr>
                                            <td style="width: 1000px; height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 1000px; text-align: left;">
                                                <asp:GridView ID="gvTransaccion" runat="server" Width="950px" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="gvTransaccion_RowDeleting" OnRowUpdating="gvTransaccion_RowUpdating" CssClass="Grid">
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
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="numero" HeaderText="Numero">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="150px" />

                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="50px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="ccosto" HeaderText="cCosto">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
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
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="gvTransaccion" EventName="RowUpdating" />
                        </Triggers>
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
