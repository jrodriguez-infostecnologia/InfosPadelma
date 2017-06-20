<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transaccion.aspx.cs" Inherits="Compras_Ptransaccion_Transaccion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
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
            <div style="display: inline-block">
                <div style="vertical-align: top; width: 1000px; height: 600px; text-align: left" class="principal">
                    <table style="width: 1000px; padding: 0; border-collapse: collapse;">
                        <tr>
                            <td style="text-align: left; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver; vertical-align: bottom;">
                                <asp:ImageButton ID="niimbRegistro" runat="server" Enabled="False" ImageUrl="~/Imagen/Bonotes/pRegistro.png" OnClick="niimbRegistro_Click" onmouseout="this.src='../../Imagen/Bonotes/pRegistro.png'" onmouseover="this.src='../../Imagen/Bonotes/pRegistroN.png'" />
                                <asp:ImageButton ID="niimbConsulta" runat="server" ImageUrl="~/Imagen/Bonotes/pConsulta.png" OnClick="niimbConsulta_Click" onmouseout="this.src='../../Imagen/Bonotes/pConsulta.png'" onmouseover="this.src='../../Imagen/Bonotes/pConsultaN.png'" />

                            </td>
                        </tr>
                    </table>
                    <asp:UpdatePanel ID="upGeneral" runat="server">
                        <ContentTemplate>
                            <asp:UpdatePanel ID="upRegistro" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table id="encabezado" style="width: 100%; padding: 0; border-collapse: collapse;">
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
                                            <td style="width: 200px; background-repeat: no-repeat; text-align: right;"></td>
                                            <td style="width: 600px; text-align: center; padding: 0; border-collapse: collapse;">
                                                <table style="width: 600px; padding: 0; border-collapse: collapse;">
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
                                            <table style="width: 1000px; border-right: gray thin solid; padding: 0; border-collapse: collapse; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid; border-color: silver; border-width: 1px;" id="datosCab">
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
                                                        <asp:Label ID="lblDocref" runat="server" Text="Referencia" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="vertical-align: top; width: 400px; text-align: left">
                                                        <asp:TextBox ID="txtDocref" runat="server" Visible="False" Width="160px"></asp:TextBox>
                                                        <asp:HiddenField ID="hdValorTotalRef" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdValorNetoRef" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdTransaccionConfig" runat="server" />
                                                        <asp:HiddenField ID="hdCantidad" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdRegistro" runat="server" Value="0" />
                                                    </td>
                                                    <td style="width: 100px; text-align: left"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                    <td style="width: 125px; height: 10px; text-align: left">
                                                        <asp:Label ID="lblTercero" runat="server" Text="Tercero" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="width: 175px; height: 10px; text-align: left">
                                                        <asp:DropDownList ID="ddlTercero" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTercero_SelectedIndexChanged" Visible="False" Width="350px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 100px; height: 10px; text-align: left;">
                                                        <asp:Label ID="lblVigencia" runat="server" Text="Días Vigencia" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="width: 400px; height: 10px; text-align: left;">
                                                        <asp:TextBox ID="txtVigencia" runat="server" CssClass="input" Visible="False" Width="60px"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 100px; height: 10px; text-align: left;"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                    <td style="width: 125px; height: 10px; text-align: left">
                                                        <asp:Label ID="lblDepartamento" runat="server" Text="Departamento" Visible="False"></asp:Label>
                                                    </td>
                                                    <td style="width: 175px; height: 10px; text-align: left">
                                                        <asp:DropDownList ID="ddlDepartamento" runat="server" Visible="False" Width="350px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 100px; height: 10px; text-align: left">&nbsp;</td>
                                                    <td style="width: 400px; height: 10px; text-align: left">&nbsp;</td>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; height: 10px; text-align: left"></td>
                                                    <td style="width: 125px; height: 10px; text-align: left">
                                                        <asp:Label ID="lblObservacion" runat="server" Text="Observaciones" Visible="False"></asp:Label>
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
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="upDetalle" runat="server" UpdateMode="Conditional" Visible="False">
                                        <ContentTemplate>
                                            <table style="width: 1000px; padding: 0; border-collapse: collapse;">
                                                <tr>
                                                    <td style="width: 75px; height: 10px;"></td>
                                                    <td style="width: 175px; height: 10px;"></td>
                                                    <td style="width: 750px; height: 10px;"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 75px">
                                                        <asp:Label ID="lblProducto" runat="server" Text="Producto" Visible="False"></asp:Label></td>
                                                    <td style="width: 175px">
                                                        <asp:TextBox ID="txtProducto" runat="server" Width="150px" Visible="False" AutoPostBack="True" OnTextChanged="txtProducto_TextChanged" CssClass="input"></asp:TextBox></td>
                                                    <td style="width: 750px">
                                                        <asp:DropDownList ID="ddlProducto" runat="server" Width="650px" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 75px; height: 10px;"></td>
                                                    <td style="width: 175px; height: 10px;"></td>
                                                    <td style="width: 750px; height: 10px;"></td>
                                                </tr>
                                            </table>
                                            <table style="width: 1000px; padding: 0; border-collapse: collapse; border-top: silver thin solid; border-bottom: silver thin solid;" id="datosDet">
                                                <tr>
                                                    <td style="width: 200px; text-align: left; vertical-align: top; height: 199px;">
                                                        <table id="TABLE1" style="BORDER-RIGHT: gray thin solid; padding: 0; border-collapse: collapse; BORDER-TOP: gray thin solid; BORDER-LEFT: gray thin solid; WIDTH: 200px; BORDER-BOTTOM: gray thin solid">
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left"></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblBodega" runat="server" Text="Bodega" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:DropDownList ID="ddlBodega" runat="server" Visible="False" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblUmedida" runat="server" Text="Und. Medida" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:DropDownList ID="ddlUmedida" runat="server" Visible="False" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblCantidad" runat="server" Text="Cantidad" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <numericii id="numCantidad" runat="server" ancho="150" disponible="true" visible="false">
                                                            </numericii>
                                                                    <asp:TextBox ID="txtCantidad" runat="server" CssClass="input" Width="150px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblValorUnitario" runat="server" Text="Valor Unitario" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">

                                                                    <asp:TextBox ID="txtValorUnitario" runat="server" CssClass="input" Width="150px"></asp:TextBox>

                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblDestino" runat="server" Text="Destino" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:DropDownList ID="ddlDestino" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlDestino_SelectedIndexChanged" Visible="False" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblCuenta" runat="server" Text="Cuenta" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:DropDownList ID="ddlCuenta" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlCuenta_SelectedIndexChanged" Visible="False" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblCcosto" runat="server" Text="C. Costo" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:DropDownList ID="ddlCcosto" runat="server" Visible="False" Width="200px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:CheckBox ID="chkInversion" runat="server" OnCheckedChanged="chkInversion_CheckedChanged" Text="Inversión" Visible="False" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:Label ID="lblDetalle" runat="server" Text="Detalle" Visible="False"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left">
                                                                    <asp:TextBox ID="txtDetalle" runat="server" TextMode="MultiLine" Visible="False" Width="200px"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: center">
                                                                    <asp:Button ID="btnRegistrar" runat="server" OnClick="btnRegistrar_Click" Text="Registrar" Visible="False" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="WIDTH: 200px; TEXT-ALIGN: left"></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td style="width: 756px; text-align: left; vertical-align: top;">
                                                        <asp:GridView ID="gvLista" runat="server" Width="900px" AutoGenerateColumns="False" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" CssClass="Grid" GridLines="None" RowHeaderColumn="cuenta">
                                                            <AlternatingRowStyle CssClass="alt" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Edit">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="imbEditar" runat="server" CommandName="Select" ImageUrl="~/Imagen/TabsIcon/pencil.png"
                                                                            ToolTip="Edita el registro seleccionado" ImageAlign="Middle" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                                    <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                                        HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Elim">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="imbEliminar" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png"
                                                                            ToolTip="Elimina el registro seleccionado" ImageAlign="Middle"
                                                                            OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="bodega" HeaderText="Bodega">
                                                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="producto" HeaderText="Producto">
                                                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="detalle" HeaderText="Detalle">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="uMedida" HeaderText="U. Medida">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad">
                                                                    <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                    <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valorUnitario" DataFormatString="{0:N2}" HeaderText="Vl. Unitario">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valorTotal" DataFormatString="{0:N2}" HeaderText="Vl. Total">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Cuenta" HeaderText="Cuenta">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="destino" HeaderText="Destino">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Ccosto" HeaderText="C. Costo">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:CheckBoxField DataField="inversion" HeaderText="Inversi&#243;n">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                </asp:CheckBoxField>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkAnulado" runat="server" Enabled="False" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="White" />
                                                                    <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                                        HorizontalAlign="Center" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="registro">
                                                                    <HeaderStyle BackColor="White" />
                                                                    <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                                        HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <FooterStyle BackColor="LightYellow" Font-Bold="True" />
                                                            <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="False" />
                                                            <AlternatingRowStyle BackColor="#E0E0E0" />
                                                        </asp:GridView>
                                                        <br />
                                                    </td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                        <Triggers>
                                        </Triggers>
                                    </asp:UpdatePanel>
                                    <asp:UpdatePanel ID="UpdatePanelReferencia" runat="server" Visible="False">
                                        <ContentTemplate>
                                            <table style="width: 1000px; padding: 0; border-collapse: collapse;">
                                                <tr>
                                                    <td style="width: 1000px; height: 10px;"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1000px; vertical-align: top; text-align: left;">
                                                        <table style="width: 1000px; padding: 0; border-collapse: collapse;">
                                                            <tr>
                                                                <td colspan="2">
                                                                    <asp:GridView ID="nigvTrnReferencia" runat="server" AutoGenerateColumns="False" CellPadding="4" GridLines="Vertical" Visible="False" Width="850px" CssClass="Grid">
                                                                        <AlternatingRowStyle CssClass="alt" />
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="chbRequi" runat="server" />
                                                                                </ItemTemplate>
                                                                                <HeaderStyle BackColor="White" BorderStyle="None" HorizontalAlign="Center" VerticalAlign="Middle" Width="25px" />
                                                                                <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                                <HeaderTemplate>
                                                                                    <asp:CheckBox ID="chbTotal" runat="server" AutoPostBack="True" OnCheckedChanged="chbTotal_CheckedChanged" />
                                                                                </HeaderTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="numero" HeaderText="Requisición">
                                                                                <HeaderStyle Width="50px" />
                                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="observacion" HeaderText="Observacion">
                                                                                <HeaderStyle Width="700px" />
                                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                                                            </asp:BoundField>
                                                                            <asp:BoundField DataField="NoCotizacion" HeaderText="#Cotizac.">
                                                                                <HeaderStyle Width="50px" />
                                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                                                            </asp:BoundField>
                                                                        </Columns>
                                                                        <FooterStyle BackColor="#CCCC99" />
                                                                        <PagerStyle BackColor="#F7F7DE" ForeColor="Black" HorizontalAlign="Right" />
                                                                        <SelectedRowStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                                                        <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                                                        <AlternatingRowStyle BackColor="White" />
                                                                    </asp:GridView>
                                                                    <asp:ImageButton ID="nibtnCargar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="nibtnCargar_Click" ToolTip="Cargar las requisiciones" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 10px"></td>
                                                                <td style="width: 900px; height: 10px"></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px">
                                                                    <asp:Label ID="lbDocumento" runat="server" ForeColor="#404040" Text="Documento" Visible="False"></asp:Label></td>
                                                                <td style="width: 900px">
                                                                    <asp:FileUpload ID="fuFoto" runat="server" ToolTip="Haga clic para cargar la foto del funcionario seleccionado"
                                                                        Visible="False" Width="360px" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td style="width: 100px; height: 24px;">
                                                                    <asp:Label ID="nilblValorTotal" runat="server" Text="Valor Total "></asp:Label></td>
                                                                <td style="width: 900px; height: 24px;">
                                                                    <asp:TextBox ID="nitxtTotalValorTotal" runat="server" Width="100px" Enabled="False"></asp:TextBox>&nbsp;
                                                                <asp:Label ID="nilblValorNeto" runat="server" Text="Valor Neto"></asp:Label>&nbsp;
                                                                    <asp:TextBox ID="nitxtTotalValorNeto" runat="server" Enabled="False" Width="100px"></asp:TextBox></td>
                                                            </tr>
                                                        </table>
                                                        <asp:GridView ID="gvReferencia" runat="server" AutoGenerateColumns="False" Font-Size="Small" GridLines="None" Width="1000px" CssClass="Grid">
                                                            <AlternatingRowStyle CssClass="alt" />
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox ID="chkSeleccion" runat="server" Checked="True" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BackColor="White" BorderColor="White" BorderStyle="None" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="producto" HeaderText="Producto">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="cadena" HeaderText="Descripci&#243;n">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Cantidad">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtCantidad" runat="server" onchange="formato(this)" OnDataBinding="txtCantidad_DataBinding"
                                                                            onkeyup="formato(this)" Text='<%# Eval("saldo") %>' Width="70px"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="SaldoProducto" HeaderText="Saldo">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="uMedida" HeaderText="U. Med">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:TemplateField HeaderText="Vlr. Unitario">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtValorUnitario" runat="server" onchange="formato(this)" OnDataBinding="txtValorUnitario_DataBinding"
                                                                            onkeyup="formato(this)" Text='<%# Eval("valorUnitario") %>' Width="100px"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="% I.V.A">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtPiva" runat="server" onchange="formato(this)" OnDataBinding="txtPiva_DataBinding"
                                                                            onkeyup="formato(this)" Text='<%# Eval("pIva") %>' Width="50px"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="%Dsto.">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="txtPDes" runat="server" onchange="formato(this)" OnDataBinding="txtPDes_DataBinding"
                                                                            onkeyup="formato(this)" Text='<%# Eval("pDescuento") %>' Width="50px"></asp:TextBox>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="valorIva" HeaderText="I.V.A">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valorTotal" DataFormatString="{0:N2}" HeaderText="Total">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valorDescuento" HeaderText="Dsto.">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="valorNeto" DataFormatString="{0:N2}" HeaderText="Neto">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="registro">
                                                                    <HeaderStyle BackColor="White" />
                                                                    <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                                        HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <PagerStyle CssClass="pgr" />
                                                            <RowStyle CssClass="rw" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 1000px"></td>
                                                </tr>
                                            </table>
                                        </ContentTemplate>
                                        <Triggers>
                                            <asp:AsyncPostBackTrigger ControlID="ddlTipoDocumento" EventName="SelectedIndexChanged" />
                                        </Triggers>
                                    </asp:UpdatePanel>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="btnRegistrar" EventName="Click" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlTipoDocumento" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="ddlProducto" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="gvTransaccion" EventName="RowUpdating" />
                                </Triggers>
                            </asp:UpdatePanel>
                            <asp:UpdatePanel ID="upConsulta" runat="server" Visible="False" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <table style="width: 1000px; padding: 0; border-collapse: collapse;">
                                        <tr>
                                            <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 200px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                                            <td style="width: 150px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlCampo" runat="server" ToolTip="Selección de campo para busqueda"
                                                    Width="145px">
                                                </asp:DropDownList></td>
                                            <td style="width: 100px; height: 25px; text-align: left">
                                                <asp:DropDownList ID="niddlOperador" runat="server" ToolTip="Selección de operador para busqueda"
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
                                    <table style="width: 1000px; padding: 0; border-collapse: collapse;">
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
                                    <table style="width: 1000px; padding: 0; border-collapse: collapse;">
                                        <tr>
                                            <td style="width: 1000px; height: 5px"></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 1000px; text-align: left;">
                                                <asp:GridView ID="gvTransaccion" runat="server" Width="950px" AutoGenerateColumns="False" GridLines="None" OnRowDeleting="gvTransaccion_RowDeleting" OnRowUpdating="gvTransaccion_RowUpdating" CssClass="Grid">
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
                                                        <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="numero" HeaderText="Numero">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />

                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="finca" HeaderText="Finca">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        </asp:BoundField>
                                                        <asp:BoundField DataField="nota" HeaderText="Observaciones">
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
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

