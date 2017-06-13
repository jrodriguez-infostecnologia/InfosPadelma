<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Sanidad.aspx.cs" Inherits="Agronomico_Ptransaccion_SanidadVegetal" %>

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
    <script src="../../js/Numero.js" type="text/javascript"></script>
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
                                            <asp:ImageButton ID="imbConsulta" runat="server"
                                                ImageUrl="~/Imagen/Bonotes/pConsulta.png" OnClick="niimbConsulta_Click"
                                                onmouseout="this.src='../../Imagen/Bonotes/pConsulta.png'" onmouseover="this.src='../../Imagen/Bonotes/pConsultaN.png'" />
                                        </div>

                                    </td>
                                </tr>
                            </table>
                            <asp:UpdatePanel ID="upRegistro" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div style="padding: 10px">
                                        <table id="encabezado" cellspacing="0" style="width: 1000px">
                                            <tr>
                                                <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); background-repeat: no-repeat; text-align: center;" colspan="3">
                                                    <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="nilbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                                                    <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                                                    <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                                                    <asp:ImageButton ID="niimbImprimir" runat="server" ImageUrl="~/Imagen/Bonotes/btnImprimir.png" onmouseout="this.src='../../Imagen/Bonotes/btnImprimir.png'" onmouseover="this.src='../../Imagen/Bonotes/btnImprimirN.png'" ToolTip="Haga clic aqui para realizar la busqueda" Visible="False" />
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
                                        <asp:UpdatePanel ID="upEncabezado" runat="server" UpdateMode="Conditional" Visible="False">
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
                                                    Visible="False" CssClass="input"></asp:TextBox></td>
                                            <td style="vertical-align: top; width: 100px; text-align: left">
                                                <asp:Label ID="lblReferencia" runat="server" Text="Referencia" Visible="False"></asp:Label>
                                            </td>
                                            <td style="vertical-align: top; width: 400px; text-align: left">
                                                <asp:DropDownList ID="ddlReferencia" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTercero_SelectedIndexChanged" Visible="False" Width="300px">
                                                </asp:DropDownList>
                                                <asp:HiddenField ID="hdTransaccionConfig" runat="server" />
                                                <asp:HiddenField ID="hdRegistro" runat="server" Value="0" />
                                            </td>
                                            <td style="width: 100px; text-align: left"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px; height: 10px; text-align: left"></td>
                                            <td style="width: 125px; height: 10px; text-align: left">
                                                <asp:Label ID="lblFinca" runat="server" Text="Finca" Visible="False"></asp:Label>
                                            </td>
                                            <td style="width: 175px; height: 10px; text-align: left">
                                                <asp:DropDownList ID="ddlFinca" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlTercero_SelectedIndexChanged" Visible="False" Width="300px">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 100px; height: 10px; text-align: left;">
                                                <asp:Label ID="lblSeccion" runat="server" Text="Sección" Visible="False"></asp:Label>
                                            </td>
                                            <td style="width: 400px; height: 10px; text-align: left;">
                                                <asp:DropDownList ID="ddlSeccion" runat="server" Visible="False" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" AutoPostBack="True" OnSelectedIndexChanged="ddlSeccion_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 100px; height: 10px; text-align: left;"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px; height: 10px; text-align: left"></td>
                                            <td style="width: 125px; height: 10px; text-align: left">
                                                <asp:Label ID="lblRemision" runat="server" Text="Remisión" Visible="False"></asp:Label>
                                            </td>
                                            <td style="width: 175px; height: 10px; text-align: left">
                                                <asp:TextBox ID="txtRemision" runat="server" CssClass="input" Visible="False" Width="160px"></asp:TextBox>
                                            </td>
                                            <td style="width: 100px; height: 10px; text-align: left"></td>
                                            <td style="width: 400px; height: 10px; text-align: left"></td>
                                            <td style="width: 100px; height: 10px; text-align: left"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px; height: 10px; text-align: left"></td>
                                            <td style="width: 125px; height: 10px; text-align: left">
                                                <asp:Label ID="lblObservacion" runat="server" Text="Notas" Visible="False"></asp:Label>
                                            </td>
                                            <td style="height: 10px; text-align: left" colspan="3">
                                                <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="40px" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox>
                                            </td>
                                            <td style="width: 100px; height: 10px; text-align: left"></td>
                                        </tr>
                                                    <tr>
                                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                                        <td style="width: 125px; height: 10px; text-align: left"></td>
                                                        <td colspan="3" style="height: 10px; text-align: left"></td>
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
                                                <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid; border: 1px solid silver;" id="datosDet">
                                                     <tr>
                                            <td style="width: 200px; text-align: left; vertical-align: top; ">
                                                </td>
                                            <td style="width: 756px; text-align: left; vertical-align: top;">
                                                <table id="TABLE1" cellspacing="0" style="width: 1000px; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid; border: 1px none #808080;">
                                                    <tr>
                                                        <td style="width: 200px; text-align: left">
                                                            </td>
                                                        <td style="width: 200px; text-align: left">
                                                            </td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            </td>
                                                        <td style="width: 200px; text-align: left">
                                                            </td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            </td>
                                                        <td style="width: 200px; text-align: left">
                                                            </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblConcepto" runat="server" Text="Concepto" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:DropDownList ID="ddlConcepto" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlConcepto_SelectedIndexChanged" Visible="False" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblUmedida" runat="server" Text="Und. Medida" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:DropDownList ID="ddlUmedida" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:LinkButton ID="lbFechaD" runat="server" OnClick="lbFechaD_Click" Style="color: #003366" Visible="False">Fecha</asp:LinkButton>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Calendar ID="cldFechaD" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" OnSelectionChanged="cldFechaD_SelectionChanged" Visible="False" Width="150px">
                                                                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                                <SelectorStyle BackColor="#CCCCCC" />
                                                                <WeekendDayStyle BackColor="FloralWhite" />
                                                                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                                <OtherMonthDayStyle ForeColor="Gray" />
                                                                <NextPrevStyle VerticalAlign="Bottom" />
                                                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                            </asp:Calendar>
                                                            <asp:TextBox ID="txtFechaD" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Visible="False"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblLote" runat="server" Text="Lote" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:DropDownList ID="ddlLote" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlLote_SelectedIndexChanged" Visible="False" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblLinea" runat="server" Text="Linea" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:DropDownList ID="ddlLinea" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblPalma" runat="server" Text="Palma" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:TextBox ID="txtPalma" runat="server" onkeyup="formato_numero(this)" CssClass="input" Visible="False"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblGrupoC" runat="server" Text="Grupo Carac." Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:DropDownList ID="ddlGrupoC" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlGrupoC_SelectedIndexChanged" Visible="False" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblCaracteristica" runat="server" Text="Caracteristica" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:DropDownList ID="ddlCaracteristica" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="200px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">&nbsp;</td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblCantidad" runat="server" Text="Cantidad" Visible="False"></asp:Label>
                                                        </td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:TextBox ID="txtCantidad" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Label ID="lblDetalle" runat="server" Text="Detalle" Visible="False"></asp:Label>
                                                        </td>
                                                        <td colspan="7" style="text-align: left">
                                                            <asp:TextBox ID="txtDetalle" runat="server" CssClass="input" Height="30px" TextMode="MultiLine" Visible="False" Width="90%"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left"></td>
                                                        <td style="width: 200px; text-align: left">
                                                            <asp:Button ID="btnRegistrar" runat="server" OnClick="btnRegistrar_Click" Text="Registrar" Visible="False" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                                     <tr>
                                                         <td style="text-align: left; vertical-align: top; "></td>
                                                         <td style="width: 756px; text-align: left; vertical-align: top;">
                                                             <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" OnSorting="gvLista_Sorting" RowHeaderColumn="cuenta" Width="1000px">
                                                                 <AlternatingRowStyle CssClass="alt" />
                                                                 <Columns>
                                                                     <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón">
                                                                         <ItemStyle CssClass="Items" Width="20px" />
                                                                     </asp:ButtonField>
                                                                     <asp:TemplateField HeaderText="Elim">
                                                                         <ItemTemplate>
                                                                             <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                                                         </ItemTemplate>
                                                                         <HeaderStyle BackColor="White" />
                                                                         <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                                                                     </asp:TemplateField>
                                                                     <asp:BoundField DataField="concepto" HeaderText="Concepto">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="conceptoNombre" HeaderText="NombreConcepto">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="120px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="gCaracteristica" HeaderText="G.C">
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="NGrupoCaracteristica" HeaderText="Nom. Gru.">
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="caracteristica" HeaderText="C.">
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="nCaracteristica" HeaderText="Nom. Cara.">
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="fecha" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="70px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="lote" HeaderText="Lote">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="60px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="linea" HeaderText="Linea">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="palma" HeaderText="Palma">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="20px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="uMedida" HeaderText="uMedida">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="detalle" HeaderText="Detalle" HtmlEncode="False" HtmlEncodeFormatString="False">
                                                                         <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                         <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="200px" />
                                                                     </asp:BoundField>
                                                                     <asp:BoundField DataField="registro">
                                                                         <HeaderStyle BackColor="White" />
                                                                         <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" Width="5px" />
                                                                     </asp:BoundField>
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
                                            <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 200px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                                            <td style="width: 150px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlCampo" runat="server" ToolTip="Selección de campo para busqueda" data-placeholder="Seleccione una opción..." CssClass="chzn-select"
                                                    Width="250px">
                                                </asp:DropDownList></td>
                                            <td style="width: 100px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlOperador" runat="server" ToolTip="Selección de operador para busqueda" data-placeholder="Seleccione una opción..." CssClass="chzn-select"
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
                                            <td style="width: 170px; height: 25px; text-align: left">
                                                <asp:Label ID="nilblRegistros" runat="server" Text="Nro. Registros 0"></asp:Label></td>
                                            <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png); width: 200px; background-repeat: no-repeat; height: 25px"></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                        <tr>
                                            <td style="width: 400px; height: 10px"></td>
                                            <td style="width: 10px; height: 10px"></td>
                                            <td style="width: 25px; height: 10px"></td>
                                            <td style="width: 10px; height: 10px"></td>
                                            <td style="width: 550px; height: 10px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 400px">
                                                <asp:GridView ID="gvParametros" runat="server" Width="400px" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="gvParametros_RowDeleting" CssClass="Grid">
                                                    <AlternatingRowStyle CssClass="alt" />
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imbEliminarParametro" runat="server" ImageUrl="~/Imagen/TabsIcon/cancel.png"
                                                                    ToolTip="Elimina el parámetro de la consulta" CommandName="Delete" />
                                                            </ItemTemplate>
                                                            <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                            <ItemStyle BackColor="White" HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                        </asp:TemplateField>
                                                        <asp:BoundField DataField="campo" HeaderText="Campo">
                                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="operador" HeaderText="Operador">
                                                            <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                            <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="valor" HeaderText="Valor">
                                                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
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
                                            <td style="width: 25px; vertical-align: top; text-align: left;">
                                                <asp:ImageButton ID="imbBusqueda"
                                                    runat="server" ImageUrl="~/Imagen/TabsIcon/search.png" ToolTip="Clic aquí para realizar la busqueda" Enabled="False" Visible="False" OnClick="imbBusqueda_Click" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" /></td>
                                            <td style="vertical-align: top; width: 10px; text-align: left"></td>
                                            <td style="vertical-align: top; width: 550px; text-align: left">
                                                <asp:Label ID="nilblMensajeEdicion" runat="server" ForeColor="Navy"></asp:Label></td>
                                        </tr>
                                    </table>
                                    <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                        <tr>
                                            <td style="width: 1000px; height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 1000px; text-align: left;">
                                                <asp:GridView ID="gvTransaccion" runat="server" Width="950px" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="gvTransaccion_RowDeleting" OnRowUpdating="gvTransaccion_RowUpdating" CssClass="Grid" OnRowCommand="gvTransaccion_RowCommand">
                                                    <AlternatingRowStyle CssClass="alt" />
                                                    <Columns>
                                                        <asp:TemplateField HeaderText="Edit">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imbEditar" runat="server" CommandName="Update" ImageUrl="~/Imagen/TabsIcon/pencil.png" OnClientClick="if(!confirm('Desea editar la transacción seleccionada ?')){return false;};" ToolTip="Clic aquí para editar la transacción seleccionada" Width="16px" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="20px" CssClass="Items" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Anu.">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imElimina0" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
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
                                                        <asp:BoundField DataField="nota" HeaderText="Observaciones">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:CheckBoxField DataField="anulado" HeaderText="Anul">
                                                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                                                        </asp:CheckBoxField>
                                                        <asp:CheckBoxField DataField="ejecutado" HeaderText="Eje.">
                                                            <ItemStyle Width="20px" />
                                                        </asp:CheckBoxField>
                                                        <asp:CheckBoxField DataField="aprobado" HeaderText="Apro.">
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                                        </asp:CheckBoxField>
                                                        <asp:TemplateField HeaderText="Aprobar">
                                                            <ItemTemplate>
                                                                <asp:ImageButton ID="imbAprobar" runat="server" CommandName="Insert" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>" ImageUrl="~/Imagen/TabsIcon/ok.png" OnClientClick="if(!confirm('Desea aprobar la transacción seleccionada ?')){return false;};" ToolTip="Clic aquí para editar la transacción seleccionada" Width="16px" />
                                                            </ItemTemplate>
                                                            <ItemStyle Width="30px" />
                                                        </asp:TemplateField>
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
