<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transaccion.aspx.cs" Inherits="Produccion_ltransaccion_Transaccion" %>

<%@ Register Assembly="TimePicker" Namespace="MKB.TimePicker" TagPrefix="cc1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Transacción Producción</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <style type="text/css">
        .auto-style1 {
            height: 10px;
        }

        .auto-style2 {
            width: 125px;
            height: 10px;
        }

        .auto-style3 {
            height: 10px;
        }

        .auto-style4 {
            width: 100%;
        }
        .auto-style6 {
            height: 10px;
            width: 100px;
        }
        .auto-style7 {
            width: 100px;
        }
    </style>
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
                <div style="vertical-align: top; width: 1000px; height: 600px; text-align: left" class="principal">
                    <table cellspacing="0" style="width: 100%" cellpadding="0">
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
                                                <asp:ImageButton ID="lblCalcular" runat="server" ImageUrl="~/Imagen/Bonotes/btnCalcular.png" onmouseout="this.src='../../Imagen/Bonotes/btnCalcular.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCalcularN.png'" ToolTip="Haga clic aqui para realizar la busqueda" Visible="False" OnClick="lbICalcular_Click" />
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
                                                            <asp:TextBox ID="txtNumero" runat="server" AutoPostBack="True" OnTextChanged="txtNumero_TextChanged"
                                                                Visible="False" Width="150px" CssClass="input"></asp:TextBox></td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 200px"></td>
                                        </tr>
                                    </table>

                                    <asp:UpdatePanel ID="upCabeza" runat="server" UpdateMode="Conditional" Visible="False">
                                        <ContentTemplate>
                                            <table cellspacing="0" style="width: 100%; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid; border-color: silver; border-width: 1px;" id="datosCab">
                                                <tr>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                    <td style="width: 125px; height: 10px; text-align: left"></td>
                                                    <td style="width: 175px; height: 10px; text-align: left"></td>
                                                    <td style="width: 100px; height: 10px; text-align: left;"></td>
                                                    <td style="width: 400px; height: 10px; text-align: left;"></td>
                                                    <td style="text-align: left;" class="auto-style6"></td>
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
                                                        <asp:Label ID="lblHora" runat="server" Text="Hora muestra" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="vertical-align: middle; width: 400px; text-align: left">
                                                        <cc1:TimeSelector ID="tsHora" runat="server" SelectedTimeFormat="TwentyFour">
                                                        </cc1:TimeSelector>
                                                        <asp:HiddenField ID="hdTransaccionConfig" runat="server" />
                                                    </td>
                                                    <td style="text-align: left" class="auto-style7"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; text-align: left">&nbsp;</td>
                                                    <td style="vertical-align: top; width: 125px; text-align: left">
                                                        <asp:Label ID="lblFormulacion" runat="server" Text="Formulación" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="vertical-align: top; text-align: left" colspan="3">
                                                        <asp:DropDownList ID="ddlFormulacion" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlFormulacion_SelectedIndexChanged" ToolTip="Escoja la formulacion deseada" Visible="False" Width="300px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="text-align: left" class="auto-style7">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left" class="auto-style1"></td>
                                                    <td style="text-align: left" class="auto-style2">
                                                        <asp:Label ID="lblObservacion" runat="server" Text="Observaciones" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="text-align: left" colspan="3" class="auto-style3">
                                                        <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="40px" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox>
                                                    </td>
                                                    <td style="text-align: left" class="auto-style6"></td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style1" style="text-align: left">&nbsp;</td>
                                                    <td class="auto-style2" style="text-align: left">&nbsp;</td>
                                                    <td class="auto-style3" colspan="3" style="text-align: left">&nbsp;</td>
                                                    <td class="auto-style6" style="text-align: left">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="auto-style1" colspan="6" style="text-align: left">
                                                        <div style="display: inline-block; text-align: left;">
                                                            <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None">
                                                                <AlternatingRowStyle CssClass="alt" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="idGrupo" HeaderText="Id G.">
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="40px" Font-Names="Arial Narrow" Font-Size="8pt" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="grupo" HeaderText="Grupo">
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="130px" Font-Names="Arial Narrow" Font-Size="8pt" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="equipo" HeaderText="Id SG.">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Size="8pt" HorizontalAlign="Left" Width="40px" Font-Names="Arial Narrow" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="desEquipo" HeaderText="Subgrupo">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Size="8pt" Width="130px" Font-Names="Arial Narrow" />
                                                                    </asp:BoundField>
                                                                    <asp:TemplateField HeaderText="Variables">
                                                                        <ItemTemplate>
                                                                            <asp:DataList ID="dtAnalisis" runat="server" RepeatDirection="Horizontal">
                                                                                <ItemTemplate>
                                                                                    <table cellpadding="0" cellspacing="0" class="auto-style4" style="width: 80px;">
                                                                                        <tr>
                                                                                            <td></td>
                                                                                            <td style="text-align: center">
                                                                                                <asp:Label ID="lblIdAnalisis" runat="server" CssClass="auto-style5" Text='<%# Eval("id") %>' Visible="False"></asp:Label>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td></td>
                                                                                            <td style="text-align: center">
                                                                                                <asp:Label ID="lblAnalisis" runat="server" CssClass="auto-style5" Text='<%# Eval("analisis") %>' Font-Names="Arial Narrow" Font-Size="8pt"></asp:Label>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td></td>
                                                                                            <td style="text-align: center">
                                                                                                <asp:TextBox ID="txvValorAnalisis" runat="server" Width="50px" Text='<%# Eval("Valor") %>' style="font-size: x-small"></asp:TextBox>
                                                                                            </td>
                                                                                            <td></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                </ItemTemplate>
                                                                            </asp:DataList>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Vacio">
                                                                        <ItemTemplate>
                                                                            <asp:CheckBox ID="chkVacio" runat="server" AutoPostBack="True" OnCheckedChanged="chkVacio_CheckedChanged"  />
                                                                        </ItemTemplate>
                                                                        <ItemStyle BorderStyle="Dotted" BorderWidth="1px" />
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <PagerStyle CssClass="pgr" />
                                                                <RowStyle CssClass="rw" />
                                                            </asp:GridView>
                                                        </div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="6">
                                                        <div style="text-align: center">
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlTipoDocumento" EventName="SelectedIndexChanged" />
                                            <asp:AsyncPostBackTrigger ControlID="gvTransaccion" EventName="RowUpdating" />
                                        </Triggers>
                                    </asp:UpdatePanel>

                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="niCalendarFecha" EventName="SelectionChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="gvTransaccion" EventName="RowUpdating" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="upConsulta" runat="server" Visible="False" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="width: 100px; height: 25px;"></td>
                                            <td style="width: 280px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlCampo" runat="server" ToolTip="Selección de campo para busqueda"
                                                    Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="niddlCampo_SelectedIndexChanged">
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
                                                <asp:TextBox ID="txtValor2" runat="server" Visible="False" CssClass="input"></asp:TextBox>
                                                <asp:TextBox ID="txtValor1" runat="server" CssClass="input"></asp:TextBox>
                                            </td>
                                            <td style="width: 30px; height: 25px; text-align: center">
                                                <asp:ImageButton ID="niimbAdicionar"
                                                    runat="server" ImageUrl="~/Imagen/TabsIcon/filter.png" ToolTip="Clic aquí para adicionar parámetro a la busqueda" OnClick="niimbAdicionar_Click" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            </td>
                                            <td style="width: 30px; height: 25px; text-align: center">
                                                <asp:ImageButton ID="imbBusqueda" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Enabled="False" ImageUrl="~/Imagen/TabsIcon/search.png" OnClick="imbBusqueda_Click" ToolTip="Clic aquí para realizar la busqueda" Visible="False" />
                                            </td>
                                            <td style="width: 120px; height: 25px; text-align: left">
                                                <asp:Label ID="nilblRegistros" runat="server" Text="Nro. Registros 0"></asp:Label></td>
                                            <td style="width: 100px; height: 25px"></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="height: 10px; text-align: center;">
                                                <asp:Label ID="nilblMensajeEdicion" runat="server" ForeColor="Navy"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center;">
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
                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                        <tr>
                                            <td style="width: 100%; height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100%; text-align: left;">
                                                <asp:GridView ID="gvTransaccion" runat="server" Width="100%" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="gvTransaccion_RowDeleting" OnRowUpdating="gvTransaccion_RowUpdating" CssClass="Grid">
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
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="100px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="producto" HeaderText="Producto">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="nombreProducto" HeaderText="NombreProducto">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="200px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="nota" HeaderText="Observaciones" HtmlEncode="False" HtmlEncodeFormatString="False">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:CheckBoxField DataField="anulado" HeaderText="Anul">
                                                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                                                        </asp:CheckBoxField>
                                                        <asp:BoundField DataField="hora">
                                                        <HeaderStyle BackColor="White" BorderColor="White" BorderWidth="0px" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" Width="10px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="minuto">
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" Width="10px" />
                                                        </asp:BoundField>
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
