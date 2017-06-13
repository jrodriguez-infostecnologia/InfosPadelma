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
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <script type="text/javascript">
            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
            function endReq(sender, args) {
                $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true });
            }
        </script>

        <div style="text-align: center">
            <div style="display: inline-block; width: 1000px;">
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
                                        <table id="encabezado" cellspacing="0" style="width: 980px">
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
                                                <table cellspacing="0" style="width: 980px; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid; border-color: silver; border-width: 1px;" id="datosCab">
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
                                                            <asp:Label ID="lblCentroCosto" runat="server" Text="Centro costo" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="vertical-align: top; width: 400px; text-align: left">
                                                            <asp:DropDownList ID="ddlCentroCosto" runat="server" AutoPostBack="True" Visible="False" Width="300px" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlCentroCosto_SelectedIndexChanged">
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
                                                            <asp:Label ID="lblEmpleado" runat="server" Text="Empleado" Visible="False"></asp:Label>
                                                            <asp:Label ID="lblConcepto" runat="server" Text="Concepto" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 175px; height: 10px; text-align: left">
                                                            <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px">
                                                            </asp:DropDownList>
                                                            <asp:DropDownList ID="ddlConcepto" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="ddlConcepto_SelectedIndexChanged" >
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 100px; height: 10px; text-align: left;">
                                                            <asp:Label ID="lblRemision" runat="server" Text="Remisión" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 400px; height: 10px; text-align: left;">
                                                            <asp:TextBox ID="txtRemision" runat="server" CssClass="input" Visible="False" Width="160px"></asp:TextBox>
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
                                                                        <asp:Label ID="lblEmpleadoDetalle" runat="server" Text="Empleado" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:DropDownList ID="ddlEmpleadoDetalle" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblConceptoDetalle" runat="server" Text="Concepto" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left" >
                                                                        <asp:DropDownList ID="ddlConceptoDetalle" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px" AutoPostBack="True" OnSelectedIndexChanged="ddlConceptoDetalle_SelectedIndexChanged">
                                                                        </asp:DropDownList>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblCantidad" runat="server" Text="Cantidad" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txvCantidad" runat="server" CssClass="input" Visible="False">0</asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblValor" runat="server" Text="Valor" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txvValor" runat="server" CssClass="input" Visible="False" Width="180px">0</asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblAñoInicial" runat="server" Text="Año Inicial" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left" class="auto-style1">
                                                                        <asp:TextBox ID="txtAñoInicial" runat="server" CssClass="input" MaxLength="4" Visible="False" Width="70px"></asp:TextBox>
                                                                        <asp:Label ID="lblAñoL" runat="server" Text="(aaaa)"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblPeriodoInicial" runat="server" Text="Periodo inicial" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txtPeriodoInicial" runat="server" CssClass="input" MaxLength="2" Visible="False" Width="70px"></asp:TextBox>
                                                                        <asp:Label ID="lblperiodoL" runat="server" Text="(No periodo inicial)"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblAñoFinal" runat="server" Text="Año final" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txtAñoFinal" runat="server" CssClass="input" MaxLength="4" Visible="False" Width="70px"></asp:TextBox>
                                                                        <asp:Label ID="lblAñoFl" runat="server" Text="(aaaa)"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblPeriodoFinal" runat="server" Text="Periodo final" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txtPeriodoFinal" runat="server" CssClass="input" MaxLength="2" Visible="False" Width="70px"></asp:TextBox>
                                                                        <asp:Label ID="lblPeriodoFl" runat="server" Text="(No periodo final)"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="text-align: left">
                                                                        <asp:Label ID="lblFrecuencia" runat="server" Text="Frecuencia" Visible="False"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txvFrecuencia" runat="server" CssClass="input" Visible="False" ToolTip="Número de intervalos de periodos a ejecutar en liquidación">0</asp:TextBox>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:Label ID="lblDetalle" runat="server" Text="Detalle" Visible="False"></asp:Label></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left">
                                                                        <asp:TextBox ID="txtDetalle" runat="server" TextMode="MultiLine" Visible="False"
                                                                            Width="200px" CssClass="input" Height="50px"></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: center">
                                                                        <asp:ImageButton ID="btnRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="btnRegistrar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" Visible="False" />
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td style="width: 200px; text-align: left"></td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="width: 756px; text-align: left; vertical-align: top;">
                                                            <asp:GridView ID="gvLista" runat="server" Width="1000px" AutoGenerateColumns="False" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" GridLines="None" RowHeaderColumn="cuenta" CssClass="Grid" AllowSorting="True" OnSorting="gvLista_Sorting">
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
                                                                    <asp:BoundField DataField="concepto" HeaderText="Concepto">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="nombreConcepto" HeaderText="NombreConcepto">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="180px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="empleado" HeaderText="IdEmpleado">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="nombreEmpleado" HeaderText="NombreEmpleado">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="180px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad">
                                                                        <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="valor" DataFormatString="{0:N2}" HeaderText="Valor">
                                                                        <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="añoInicial" HeaderText="AñoI">
                                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="40px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="añoFinal" HeaderText="AñoF">
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="40px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="pInicial" HeaderText="pInicial">
                                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="pFinal" HeaderText="pFinal">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="FR" HeaderText="FR">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="detalle" HeaderText="detalle">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="registro" HeaderText="Reg">
                                                                        <HeaderStyle BackColor="White" />
                                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="10px" />
                                                                    </asp:BoundField>
                                                                    <asp:CheckBoxField DataField="anulado" HeaderText="Anul" >
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
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
                                                <asp:AsyncPostBackTrigger ControlID="ddlCentroCosto" EventName="SelectedIndexChanged" />
                                                <asp:AsyncPostBackTrigger ControlID="ddlConceptoDetalle" EventName="SelectedIndexChanged" />
                                            </Triggers>
                                        </asp:UpdatePanel>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="upConsulta" runat="server" Visible="False" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table cellpadding="0" cellspacing="0" style="width: 980px">
                                        <tr>
                                            <td style=" width: 100px; height: 10px; text-align: left"></td>
                                            <td >
                                                </td>
                                            <td>
                                                </td>
                                            <td>
                                                </td>
                                            <td>
                                                </td>
                                            <td>
                                                </td>
                                            <td style=" width: 100px;"></td>
                                        </tr>
                                        <tr>
                                            <td></td>
                                            <td style=" text-align: left">
                                                <asp:DropDownList ID="niddlCampo" runat="server" CssClass="chzn-select" data-placeholder="Selección de campo para busqueda..." Width="300px">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 100px; text-align: center">
                                                <asp:DropDownList ID="niddlOperador" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione operador para busqueda..." OnSelectedIndexChanged="niddlOperador_SelectedIndexChanged" Width="95px">
                                                    <asp:ListItem Value="like">Contiene</asp:ListItem>
                                                    <asp:ListItem Value="&lt;&gt;">Diferente</asp:ListItem>
                                                    <asp:ListItem Value="between">Entre</asp:ListItem>
                                                    <asp:ListItem Selected="True" Value="=">Igual</asp:ListItem>
                                                    <asp:ListItem Value="&gt;=">Mayor o Igual</asp:ListItem>
                                                    <asp:ListItem Value="&gt;">Mayor que</asp:ListItem>
                                                    <asp:ListItem Value="&lt;=">Menor o Igual</asp:ListItem>
                                                    <asp:ListItem Value="&lt;">Menor</asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="text-align: center">
                                                <asp:TextBox ID="nitxtValor1" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="nitxtValor1_TextChanged" Width="180px"></asp:TextBox>
                                                <asp:TextBox ID="nitxtValor2" runat="server" CssClass="input" Visible="False" Width="180px"></asp:TextBox>
                                            </td>
                                            <td style="width: 70px;  text-align: center">
                                                <asp:ImageButton ID="niimbAdicionar" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Enabled="False" ImageUrl="~/Imagen/TabsIcon/filter.png" OnClick="niimbAdicionar_Click" ToolTip="Clic aquí para adicionar parámetro a la busqueda" />
                                                <asp:ImageButton ID="imbBusqueda" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Enabled="False" ImageUrl="~/Imagen/TabsIcon/search.png" OnClick="imbBusqueda_Click" ToolTip="Clic aquí para realizar la busqueda" Visible="False" />
                                            </td>
                                            <td style="width: 100px;  text-align: left">
                                                <asp:Label ID="nilblRegistros" runat="server" Text="Nro. Registros 0"></asp:Label>
                                            </td>
                                            <td></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 980px">
                                        <tr>
                                            <td style="height: 10px; text-align: center;" colspan="5">
                                                <asp:Label ID="nilblMensajeEdicion" runat="server" ForeColor="Navy"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="width: 400px"></td>
                                            <td style="vertical-align: top; width: 10px; text-align: left"></td>
                                            <td style="width: 25px; vertical-align: top; text-align: left;">
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
                                            </td>
                                            <td style="vertical-align: top; width: 10px; text-align: left"></td>
                                            <td style="vertical-align: top; width: 400px; text-align: left"></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 980px">
                                        <tr>
                                            <td style="width: 980px; height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 980px; text-align: left;">
                                                <div style="text-align: center">
                                                    <div style="display: inline-block">
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
                                                    </div>
                                                </div>
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
