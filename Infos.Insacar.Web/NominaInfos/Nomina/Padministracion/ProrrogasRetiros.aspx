<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProrrogasRetiros.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>

    <%-- Este es el estilo de combobox --%>

    <link href="../../css/chosen.css" rel="stylesheet" />
    <style type="text/css">
        .campos {
            text-align: left;
        }

        .auto-style1 {
            width: 100%;
        }

        .auto-style3 {
            text-align: left;
            width: 107px;
        }
    </style>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td></td>
                    <td style="width: 100px; height: 25px; text-align: left">Busqueda</td>
                    <td style="width: 350px; height: 25px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="lbNuevo_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td style="height: 15px;" colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label4" runat="server" Text="Empleado" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlEmpleado" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged"
                            Visible="False" Width="400px">
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label3" runat="server" Text="Contrato" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlContrato" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlContrato_SelectedIndexChanged"
                            Visible="False" Width="400px">
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label5" runat="server" Text="Tipo Movimieto" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlTipoRegistro" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select"
                            Visible="False" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoRegistro_SelectedIndexChanged">
                            <asp:ListItem Value="P">Prorroga</asp:ListItem>
                            <asp:ListItem Value="R">Retiro</asp:ListItem>
                        </asp:DropDownList></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td colspan="2">
                        <asp:Panel ID="pnProrroga" runat="server" Visible="False">
                            <fieldset>
                                <legend>Prorroga </legend>
                                <table cellpadding="0" cellspacing="0" class="auto-style1">
                                    <tr>
                                        <td class="nombreCampos">
                                            <asp:Label ID="Label6" runat="server" Text="Codigo" Visible="True"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtConcepto_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="nombreCampos">
                                            <asp:Label ID="Label7" runat="server" Text="No dias" Visible="True"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtDias" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" OnTextChanged="txtDias_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style3">
                                            <asp:Label ID="Label8" runat="server" Text="Fecha inicial" Visible="True"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtFechaInicial" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtConcepto_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style3">
                                            <asp:Label ID="Label9" runat="server" Text="Fecha final" Visible="True"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtFechaFinal" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtConcepto_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style3">
                                            <asp:Label ID="Label10" runat="server" Text="Ultima fecha final" Visible="True"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtUltimaFechaFinal" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtConcepto_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style3" valign="top">
                                            <asp:Label ID="Label11" runat="server" Text="Observación"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="100px" OnTextChanged="txtConcepto_TextChanged" TextMode="MultiLine" Visible="True" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </asp:Panel>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td colspan="2">
                        <asp:Panel ID="pnRetiro" runat="server" Visible="False">
                            <fieldset>
                                <legend>Retiro </legend>
                                <table cellpadding="0" cellspacing="0" class="auto-style1">
                                    <tr>
                                        <td class="nombreCampos">
                                            <asp:Label ID="Label12" runat="server" Text="Codigo" Visible="True"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtCodigoRetiro" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtConcepto_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="nombreCampos">
                                            <asp:Label ID="Label19" runat="server" Text="Fecha inicial" Visible="True"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtFechaInicialR" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtConcepto_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="nombreCampos">
                                            <asp:LinkButton ID="lbFechaFinal" runat="server" ForeColor="#003366" OnClick="lbFechaFinal_Click">Fecha Final</asp:LinkButton>
                                        </td>
                                        <td class="campos">
                                            <asp:Calendar ID="niCalendarFechaFinal" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaFinal_SelectionChanged" Visible="False" Width="150px">
                                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                <NextPrevStyle VerticalAlign="Bottom" />
                                                <OtherMonthDayStyle ForeColor="Gray" />
                                                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                <SelectorStyle BackColor="#CCCCCC" />
                                                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                <WeekendDayStyle BackColor="FloralWhite" />
                                            </asp:Calendar>
                                            <asp:TextBox ID="txtFechaFinalR" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtFechaFinalR_TextChanged" Visible="True" Width="100px"></asp:TextBox>
                                            <asp:Label ID="lblRL1" runat="server" Text="(dd/mm/aaaa)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style3">
                                            <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#003366" OnClick="lbFechaIngreso_Click">Fecha </asp:LinkButton>
                                        </td>
                                        <td class="campos">
                                            <asp:Calendar ID="niCalendarFecha" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFecha_SelectionChanged" Visible="False" Width="150px">
                                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                <NextPrevStyle VerticalAlign="Bottom" />
                                                <OtherMonthDayStyle ForeColor="Gray" />
                                                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                <SelectorStyle BackColor="#CCCCCC" />
                                                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                <WeekendDayStyle BackColor="FloralWhite" />
                                            </asp:Calendar>
                                            <asp:TextBox ID="txtFecha" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" OnTextChanged="txtFecha_TextChanged"></asp:TextBox>
                                            <asp:Label ID="lblRL0" runat="server" Text="(dd/mm/aaaa)"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style3">
                                            <asp:Label ID="Label18" runat="server" Text="Motivo retiro"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:DropDownList ID="ddlMotivo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="350px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="auto-style3" valign="top">
                                            <asp:Label ID="Label17" runat="server" Text="Observación"></asp:Label>
                                        </td>
                                        <td class="campos">
                                            <asp:TextBox ID="txtObservacionRetiro" runat="server" CssClass="input" Height="100px" TextMode="MultiLine" Visible="True" Width="100%"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                            </fieldset>
                        </asp:Panel>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td style="height: 15px;" colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div class="tablagrilla">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="860px" CssClass="Grid" GridLines="None" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" />
                                <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="id" HeaderText="Código">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="Pro / Ret" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="contrato" HeaderText="Contrato" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="codigo" HeaderText="id Empleado">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Empleado">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaInicial" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Ini">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaFinal" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Fin">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaFinalAnterior" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Fin Ant">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaRetiro" DataFormatString="{0:dd/MM/yyyy}" HeaderText="Fecha Ret">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="tercero" ShowHeader="False">
                                <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>
            </div>

        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
