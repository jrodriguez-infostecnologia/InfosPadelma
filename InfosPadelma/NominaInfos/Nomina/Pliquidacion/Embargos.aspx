<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Embargos.aspx.cs" Inherits="Facturacion_Padministracion_Embargos" MaintainScrollPositionOnPostback="true" %>

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
                    <td style="height: 15px;" colspan="6">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td width="50px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label4" runat="server" Text="Empleado" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlEmpleado" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged"
                            Visible="False" Width="300px">
                        </asp:DropDownList></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label6" runat="server" Text="Tipo embargo" Visible="False"></asp:Label></td>
                    <td class="campos">
                        <asp:DropDownList ID="ddlTipoEmbargo" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged"
                            Visible="False" Width="300px">
                        </asp:DropDownList>
                        <br />
                        <asp:CheckBox ID="chkSalarioMinimo" runat="server" Text="Salario Minimo" OnCheckedChanged="chkManejaSaldo_CheckedChanged" Visible="False" />
                    </td>
                    <td width="50px">&nbsp;</td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label7" runat="server" Text="Código" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="input" Enabled="False" OnTextChanged="txtConcepto_TextChanged" Visible="False" Width="100px"></asp:TextBox>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label8" runat="server" Text="No mandato judicial" Visible="False"></asp:Label></td>
                    <td class="campos">
                        <asp:TextBox ID="txtNumeroMandato" runat="server" CssClass="input" OnTextChanged="txtConcepto_TextChanged" Visible="False" Width="300px"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#003366" OnClick="lbFechaIngreso_Click" Visible="False">Fecha embargo</asp:LinkButton>
                    </td>
                    <td class="Campos">
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
                        <asp:TextBox ID="txtFecha" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" AutoPostBack="True" Visible="False" OnTextChanged="txtFecha_TextChanged"></asp:TextBox>
                        <asp:Label ID="lblRL0" runat="server" Text="(dd/mm/aaaa)" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label9" runat="server" Text="Año -  No periodo" Visible="False"></asp:Label></td>
                    <td class="campos">
                        <asp:TextBox ID="txtAñoInicial" runat="server" CssClass="input" OnTextChanged="txtPeriodoCobro_TextChanged" Visible="False" Width="80px" AutoPostBack="True" MaxLength="4"></asp:TextBox>
                        <asp:Label ID="Label30" runat="server" Text="(aaaa)" Visible="False"></asp:Label>
                        <asp:TextBox ID="txtPeriodoInicial" runat="server" CssClass="input" OnTextChanged="txtPeriodoCobro_TextChanged" Visible="False" Width="30px" AutoPostBack="True" MaxLength="3"></asp:TextBox>
                        <asp:Label ID="Label31" runat="server" Text="(No periodo)" Visible="False"></asp:Label>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label21" runat="server" Text="Empresa embargante" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlEmpresaEmbarga" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged"
                            Visible="False" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label22" runat="server" Text="Tercero embargante" Visible="False"></asp:Label></td>
                    <td class="campos">
                        <asp:DropDownList ID="ddlTerceroEmbargo" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged"
                            Visible="False" Width="300px">
                        </asp:DropDownList></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:CheckBox ID="chkCuotas" runat="server" Text="Maneja cuotas" AutoPostBack="True" OnCheckedChanged="chkCuotas_CheckedChanged" Visible="False" />
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvCuotas" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label26" runat="server" Text="Valor cuota" Visible="False"></asp:Label>
                    </td>
                    <td class="campos">
                        <asp:TextBox ID="txvValorEmbargo" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False">0</asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label27" runat="server" Text="Valor %" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos" valign="middle">
                        <asp:TextBox ID="txvValorPorcentaje" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False">0</asp:TextBox>
                    </td>
                    <td class="nombreCampos" valign="middle">
                        <asp:Label ID="Label23" runat="server" Text="Valor final embargo" Visible="False"></asp:Label></td>
                    <td class="campos" valign="middle">
                        <asp:TextBox ID="txvValorFinalEmbargo" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False">0</asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:CheckBox ID="chkCobroPosterior" runat="server" Text="Cobro posterior" OnCheckedChanged="chkCobroPosterior_CheckedChanged" Visible="False" AutoPostBack="True" />
                    </td>
                    <td class="Campos"></td>
                    <td class="nombreCampos">
                        <asp:CheckBox ID="chkCuotasPosteriores" runat="server" Text="Cuotas posteriores" Enabled="False" OnCheckedChanged="chkCuotasPosteriores_CheckedChanged" Visible="False" AutoPostBack="True" />
                    </td>
                    <td class="campos">
                        <asp:TextBox ID="txvCuotasPosteriores" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False"></asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label28" runat="server" Text="Valor cuota pos." Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvValorEmbargoPosterior" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False">0</asp:TextBox></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label29" runat="server" Text="Valor % pos." Visible="False"></asp:Label>
                    </td>
                    <td class="campos">
                        <asp:TextBox ID="txvValorPorPosterior" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False">0</asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label25" runat="server" Text="Valor final posterior" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvValorFinalPos" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False">0</asp:TextBox></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label24" runat="server" Text="Valor base" Visible="False"></asp:Label>
                    </td>
                    <td class="campos">
                        <asp:TextBox ID="txvValorBase" runat="server" Visible="False" Width="100px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Enabled="False">0</asp:TextBox></td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblDepartamento30" runat="server" Text="Forma de pago" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblDepartamento37" runat="server" Text="Tipo de cuenta" Visible="False"></asp:Label>
                    </td>
                    <td class="campos">
                        <asp:DropDownList ID="ddlTipoCuenta" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblDepartamento32" runat="server" Text="Banco" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlBanco" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblDepartamento36" runat="server" Text="Número cuenta" Visible="False"></asp:Label>
                    </td>
                    <td class="campos">
                        <asp:TextBox ID="txtNumeroCuenta" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" Visible="False"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:CheckBox ID="chkManejaSaldo" runat="server" Text="Maneja Saldo" OnCheckedChanged="chkManejaSaldo_CheckedChanged" Visible="False" AutoPostBack="True" />
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvSaldo" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" Visible="False"></asp:TextBox>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblDepartamento38" runat="server" Text="Fiscal" Visible="False"></asp:Label>
                    </td>
                    <td class="campos">
                        <asp:TextBox ID="txtFiscal" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="300px" Visible="False"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos"></td>
                    <td class="nombreCampos"></td>
                    <td class="campos">
                        <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" OnCheckedChanged="chkManejaSaldo_CheckedChanged" Visible="False" Checked="True" />
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td style="height: 15px;" colspan="6">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div class="tablaGrilla">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="800px" CssClass="Grid" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging">
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
                            <asp:BoundField DataField="codigo" HeaderText="Código Em">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="Tipo " ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="codEmpleado" HeaderText="id Empleado">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="80px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desEmpleado" HeaderText="Empleado">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="300px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="salarioMinimo" HeaderText="S.M">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="empleado" ShowHeader="False">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
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
