<%@ Page MaintainScrollPositionOnPostback="true" Language="C#" AutoEventWireup="true" CodeFile="Parametrizacion.aspx.cs" Inherits="Administracion_Caracterizacion" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Parametrización</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">

            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                    <td style="height: 20px; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;">&nbsp;</td>
                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                </tr>
            </table>

            <table style="width: 1000px; height: 1%;" cellspacing="0">
                <tr>
                    <td style="width: 700px; text-align: center; vertical-align: top;">
                        <div style="padding-right: 20px; padding-left: 20px">
                            <table cellspacing="0" style="width: 700px">
                                <tr>
                                    <td style="border-left-color: dimgray; border-bottom-color: dimgray; vertical-align: top; width: 679px; border-top-color: dimgray; height: 10px; text-align: left; border-right-color: dimgray">
                                        <table cellspacing="0" style="width: 800px; height: 1px">
                                            <tr>
                                                <td style="vertical-align: top; width: 200px; text-align: left">
                                                    <asp:Label ID="nilblProducto" runat="server" Text="Formulación"></asp:Label>
                                                </td>
                                                <td style="vertical-align: top; width: 300px; text-align: left">
                                                    <asp:DropDownList ID="niddlFormulacion" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="vertical-align: top; width: 300px; text-align: center">
                                                    <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="niimbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" />
                                                </td>
                                                <td style="vertical-align: top; width: 300px; text-align: center">
                                                    <asp:ImageButton ID="nilbAsociarVariable" runat="server" ImageUrl="~/Imagen/Bonotes/btnAsociar.png" OnClick="nilbAsociarCaracteristica_Click"
                                                        onmouseout="this.src='../../Imagen/Bonotes/btnAsociar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnAsociarN.png'" ToolTip="Asociar movimientos al producto seleccionado" Visible="False" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center;">
                                        <asp:Label ID="nilblMensaje" runat="server" Font-Bold="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td style="text-align:left;">
                                        <div>
                                            <div style="display: inline-block">
                                                <asp:Panel ID="pAsociacion" runat="server" Visible="False">
                                                    <table cellpadding="0" cellspacing="0" width="700">
                                                        <tr>
                                                            <td style="width: 100px; height: 10px;"></td>
                                                            <td style="width: 450px;"></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 100px">
                                                                <asp:Label ID="Label1" runat="server" Text="Movimientos"></asp:Label></td>
                                                            <td style="width: 600px">
                                                                <asp:DropDownList ID="ddlMovimientos" runat="server" Width="300px" AutoPostBack="True" OnSelectedIndexChanged="ddlVariable_SelectedIndexChanged" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                                </asp:DropDownList></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 100px">
                                                                <asp:Label ID="Label10" runat="server" Text="Orden"></asp:Label>
                                                            </td>
                                                            <td style="width: 600px">
                                                                <asp:TextBox ID="txtOrden" runat="server" Width="50px" CssClass="input"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 100px">
                                                                <asp:CheckBox ID="chkResultado" runat="server" AutoPostBack="True" OnCheckedChanged="chkResultadoProduccion_CheckedChanged" Text="Es Resultado" />
                                                            </td>
                                                            <td style="width: 600px">
                                                                <asp:CheckBox ID="chkAlmacena" runat="server" OnCheckedChanged="chkResultadoProduccion_CheckedChanged" Text="Calcular en informe" />
                                                                <asp:CheckBox ID="chkMostrarInforme" runat="server" OnCheckedChanged="chkResultadoProduccion_CheckedChanged" Text="Mostrar Informe" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 100px">
                                                                <asp:CheckBox ID="chkActivo" runat="server" OnCheckedChanged="chkResultadoProduccion_CheckedChanged" Text="Activo" Checked="True" />
                                                            </td>
                                                            <td style="width: 600px">

                                                                <asp:CheckBox ID="chkCalcular" runat="server" OnCheckedChanged="chkResultadoProduccion_CheckedChanged" Text="Mostrar antes de calcular" />
                                                                <asp:CheckBox ID="chkDecimal" runat="server" OnCheckedChanged="chkResultadoProduccion_CheckedChanged" Text="Maneja Decimales" />

                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">&nbsp;</td>
                                                        </tr>
                                                    </table>
                                                    <table cellpadding="0" cellspacing="0" style="width: 700px">
                                                        <tr>
                                                            <td style="width: 3px; height: 14px"></td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 3px">
                                                                <asp:Panel ID="pFormula" runat="server" Visible="False" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px">
                                                                    <div style="padding: 10px">
                                                                        <table cellpadding="0" cellspacing="0" style="width: 700px">
                                                                            <tr>
                                                                                <td style="width: 100px">
                                                                                    <asp:Label ID="Label9" runat="server" Text="Prioridad"></asp:Label></td>
                                                                                <td style="width: 600px">
                                                                                    <asp:TextBox ID="txtPrioridad" runat="server" Width="50px" CssClass="input"></asp:TextBox></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px">
                                                                                    <asp:Label ID="Label3" runat="server" Text="Sentencia"></asp:Label></td>
                                                                                <td style="width: 600px">
                                                                                    <asp:DropDownList ID="ddlSentencia" runat="server" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                                                        <asp:ListItem Value=" ">Seleccione una opci&#243;n</asp:ListItem>
                                                                                        <asp:ListItem>,</asp:ListItem>
                                                                                        <asp:ListItem>(</asp:ListItem>
                                                                                        <asp:ListItem>)</asp:ListItem>
                                                                                        <asp:ListItem>+</asp:ListItem>
                                                                                        <asp:ListItem>-</asp:ListItem>
                                                                                        <asp:ListItem>*</asp:ListItem>
                                                                                        <asp:ListItem>/</asp:ListItem>
                                                                                        <asp:ListItem Value="ABS(">ABS</asp:ListItem>
                                                                                        <asp:ListItem Value="ACOS(">ACOS</asp:ListItem>
                                                                                        <asp:ListItem Value="ASIN(">ASIN</asp:ListItem>
                                                                                        <asp:ListItem Value="ATAN(">ATAN</asp:ListItem>
                                                                                        <asp:ListItem Value="CEILING(">CEILING</asp:ListItem>
                                                                                        <asp:ListItem Value="COS(">COS</asp:ListItem>
                                                                                        <asp:ListItem Value="COT(">COT</asp:ListItem>
                                                                                        <asp:ListItem Value="EXP(">EXP</asp:ListItem>
                                                                                        <asp:ListItem Value="FLOOR(">FLOOR</asp:ListItem>
                                                                                        <asp:ListItem Value="LOG(">LOG</asp:ListItem>
                                                                                        <asp:ListItem Value="LOG10(">LOG10</asp:ListItem>
                                                                                        <asp:ListItem Value="PI()">PI</asp:ListItem>
                                                                                        <asp:ListItem Value="POWER(">POWER</asp:ListItem>
                                                                                        <asp:ListItem>ROUND</asp:ListItem>
                                                                                        <asp:ListItem Value="SIN(">SIN</asp:ListItem>
                                                                                        <asp:ListItem Value="SQRT(">SQRT</asp:ListItem>
                                                                                        <asp:ListItem Value="SQUARE(">SQUARE</asp:ListItem>
                                                                                        <asp:ListItem Value="TAN(">TAN</asp:ListItem>
                                                                                        <asp:ListItem Value="NULLIF(">NULLIF</asp:ListItem>
                                                                                        <asp:ListItem Value="ISNULL(">ISNULL</asp:ListItem>
                                                                                        <asp:ListItem Value=",0)">Cerrar NULLIF</asp:ListItem>
                                                                                        <asp:ListItem Value=",0)">cerrar ISNULL</asp:ListItem>
                                                                                        <asp:ListItem Value="dbo.fRetornaDatos(">dbo.fRetornaDatos</asp:ListItem>
                                                                                        <asp:ListItem Value="dbo.fRetornaDatosLaboratorio(">dbo.fRetornaDatosLaboratorio</asp:ListItem>
                                                                                        <asp:ListItem Value="dbo.fRetornaDeTabla(">dbo.fRetornaDeTabla</asp:ListItem>
                                                                                    </asp:DropDownList><asp:ImageButton ID="imbAddSentencia" runat="server"
                                                                                        ImageUrl="~/Imagen/TabsIcon/edit_add.png" ToolTip="Clic aquí para adicionar sentencia a la fórmula" OnClick="imbAddSentencia_Click" style="height: 16px" /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px">
                                                                                    <asp:Label ID="Label5" runat="server" Text="Movimiento"></asp:Label></td>
                                                                                <td style="width: 600px">
                                                                                    <asp:DropDownList ID="ddlAnalisisF" runat="server" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                                                    </asp:DropDownList><asp:ImageButton ID="imbAddVariable" runat="server"
                                                                                        ImageUrl="~/Imagen/TabsIcon/edit_add.png" ToolTip="Clic aquí para adicionar variable a la fórmula" OnClick="imbAddVariable_Click" /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px">
                                                                                    <asp:Label ID="Label7" runat="server" Text="Constante"></asp:Label></td>
                                                                                <td style="width: 600px">
                                                                                    <asp:TextBox ID="txtConstante" runat="server" CssClass="input"></asp:TextBox><asp:ImageButton ID="imbAddConstante"
                                                                                        runat="server" ImageUrl="~/Imagen/TabsIcon/edit_add.png" ToolTip="Clic aquí para adicionar constante a la fórmula" OnClick="imbAddConstante_Click" /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 100px">
                                                                                    <asp:Label ID="Label2" runat="server" Text="Items RetornaDatos"></asp:Label></td>
                                                                                <td style="vertical-align: top; width: 600px">
                                                                                    <asp:DropDownList ID="ddlItemsRetornaDatos" runat="server" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                                                    </asp:DropDownList><asp:ImageButton ID="imbItems"
                                                                                        runat="server" ImageUrl="~/Imagen/TabsIcon/edit_add.png" ToolTip="Clic aquí para adicionar item a la sentencia fRetornaDatos" OnClick="imbItems_Click" /><asp:HiddenField ID="hdConteoItems" runat="server" Value="0" />
                                                                                    <asp:HiddenField ID="hdRetornaDatos" runat="server" Value="0" />
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="vertical-align: top; width: 100px">
                                                                                    <asp:Label ID="Label6" runat="server" Text="Fórmula"></asp:Label></td>
                                                                                <td style="width: 600px">
                                                                                    <asp:TextBox ID="txtFormula" runat="server" Enabled="False" Height="50px" TextMode="MultiLine"
                                                                                        Width="500px" ForeColor="Navy" CssClass="input"></asp:TextBox><asp:ImageButton ID="imbValidarFormula" runat="server" ImageUrl="~/Imagen/TabsIcon/ok.png" ToolTip="Clic aquí para validar la fórmula" OnClick="imbValidarFormula_Click" /><asp:ImageButton ID="imbUndo" runat="server" ImageUrl="~/Imagen/TabsIcon/undo.png" ToolTip="Clic aquí para borrar" OnClick="imbUndo_Click" /></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="vertical-align: top; width: 100px">
                                                                                    <asp:Label ID="Label8" runat="server" Text="Expresión"></asp:Label></td>
                                                                                <td style="width: 600px">
                                                                                    <asp:Label ID="lblExpresion" runat="server"></asp:Label></td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="vertical-align: top; width: 100px"></td>
                                                                                <td style="width: 600px">
                                                                                    <asp:Label ID="lblResultadoFormula" runat="server"></asp:Label></td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </asp:Panel>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width: 3px; height: 10px"></td>
                                                        </tr>
                                                    </table>
                                                    <table cellpadding="0" cellspacing="0" style="width: 700px">
                                                        <tr>
                                                            <td style="width: 100px; text-align: right">
                                                                <asp:ImageButton ID="btnCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                                                            </td>
                                                            <td style="width: 450px"></td>
                                                            <td style="width: 150px">
                                                                <asp:ImageButton ID="btnRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="btnRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top; width: 679px; text-align: left">
                                        <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnPageIndexChanging="gvLista_PageIndexChanging" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" PageSize="20" Width="900px">
                                            <AlternatingRowStyle CssClass="alt" />
                                            <Columns>
                                                <asp:TemplateField HeaderText="Edit">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imbEditar" runat="server" CommandName="Select" ImageUrl="~/Imagen/TabsIcon/pencil.png"
                                                            ToolTip="Edita el registro seleccionado" ImageAlign="Middle" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" BackColor="White" />
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" Width="20px" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Elim">
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="imbEliminar" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png"
                                                            ToolTip="Elimina el registro seleccionado" ImageAlign="Middle"
                                                            OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" />
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" BackColor="White" />
                                                    <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" Width="20px" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="movimiento" HeaderText="CodMov">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="80px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="Descripcion" HeaderText="DesMovimiento">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="prioridad" HeaderText="Prioridad">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="40px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="orden" HeaderText="Orden">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" VerticalAlign="Middle" Width="40px" />
                                                </asp:BoundField>
                                                <asp:CheckBoxField DataField="resultado" HeaderText="EsResultado">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                                </asp:CheckBoxField>
                                                <asp:CheckBoxField DataField="almacena" HeaderText="Almcena">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                                </asp:CheckBoxField>
                                                <asp:CheckBoxField DataField="mInforme" HeaderText="Informe">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                                </asp:CheckBoxField>
                                                <asp:CheckBoxField DataField="mCalcular" HeaderText="Calcular">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                                </asp:CheckBoxField>
                                                <asp:CheckBoxField DataField="mDecimal" HeaderText="Decimal">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                                </asp:CheckBoxField>
                                                <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                                                </asp:CheckBoxField>
                                                <asp:BoundField DataField="modulo" HeaderText="Modulo">
                                                    <ItemStyle Width="5px" />
                                                </asp:BoundField>
                                            </Columns>
                                            <PagerStyle CssClass="pgr" />
                                            <RowStyle CssClass="rw" />
                                        </asp:GridView>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="vertical-align: top; width: 679px; text-align: left"></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script src="../../js/jquery.min.js" type="text/javascript"></script>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
</body>
</html>
