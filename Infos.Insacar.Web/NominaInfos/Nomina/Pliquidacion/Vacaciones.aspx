<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Vacaciones.aspx.cs" Inherits="Facturacion_Padministracion_Embargos" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>

    <%-- Este es el estilo de combobox --%>

    <link href="../../css/chosen.css" rel="stylesheet" />
    <script language="javascript" type="text/javascript">

        var x = null;

        function Visualizacion(informe, periodoInicial, periodoFinal,empleado, registro) {
            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + screen.availWidth + ", height =" + screen.availHeight + ", top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe + "&empleado=" + empleado + "&periodoInicial=" + periodoInicial + "&periodoFinal=" + periodoFinal + "&registro=" + registro;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }
    </script>

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

            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE2">
                <tr>
                    <td style="height: 15px;" colspan="7">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td width="50px">&nbsp;</td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblaño" runat="server" Text="Año" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left" colspan="2">
                        <asp:DropDownList ID="ddlAño" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="130px" AutoPostBack="True" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged1">
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left">
                        <asp:Label ID="lblPeriodo0" runat="server" Text="Periodo Nomina" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlPeriodo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="320px" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <td width="50px">&nbsp;</td>
                </tr>
                <tr>
                    <td width="50px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label4" runat="server" Text="Empleado" Visible="False"></asp:Label></td>
                    <td style="text-align: left" colspan="4">
                        <asp:DropDownList ID="ddlEmpleado" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select"
                            Visible="False" Width="90%" AutoPostBack="True" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged">
                        </asp:DropDownList></td>
                    <td width="50px"></td>
                </tr>
                <tr>
                    <td width="50px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblECcosto" runat="server" Text="Centro de costo" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:Label ID="lblCodCcosto" runat="server" Visible="False"></asp:Label>
                        <asp:Label ID="lblCentroCosto" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="lblEUltimaLiquidacion" runat="server" Text="Ultimas vacaciones" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:Label ID="lblUltimaLiquidación" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td width="50px"></td>
                </tr>
                <tr>
                    <td width="50px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblESueldo" runat="server" Text="Sueldo" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:Label ID="lblSueldo" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="lblEUltimaLiquidacion0" runat="server" Text="Periodo" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblPeriodoIUvacaciones" runat="server" Visible="False"></asp:Label>
                        <asp:Label ID="lblEguion" runat="server" Text="-" Visible="False"></asp:Label>
                        <asp:Label ID="lblPeriodoFUVacaciones" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td width="50px"></td>
                </tr>
                <tr>
                    <td width="50px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblEDepartamento" runat="server" Text="Departamento" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:Label ID="lblCodDepartamento" runat="server" Visible="False"></asp:Label>
                        <asp:Label ID="lblDepartamento" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="lblEDiasPendientes" runat="server" Text="Dias pendientes" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblDiasPendientes" runat="server" Visible="False"></asp:Label>
                    </td>
                    <td width="50px"></td>
                </tr>
                <tr>
                    <td width="50px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblPeriodo" runat="server" Text="Periodo vacaciones" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 250px;">
                        <asp:Label ID="lblPeriodoVacaciones" runat="server" Visible="False"></asp:Label></td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="Label6" runat="server" Text="Tipo vacacion" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:DropDownList ID="ddlTipoVacaciones" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select"
                            Visible="False" OnSelectedIndexChanged="ddlTipoVacaciones_SelectedIndexChanged">
                            <asp:ListItem Value="1">Disfrutada</asp:ListItem>
                            <asp:ListItem Value="2">Compensada</asp:ListItem>
                            <asp:ListItem Value="3">Compensadas 8/7</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td width="50px"></td>
                </tr>
                <tr>
                    <td width="50px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label32" runat="server" Text="Periodo Inicial" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txtPeriodoInicial" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" AutoPostBack="True" Visible="False" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="Label33" runat="server" Text="Periodo Final" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txtPeriodoFinal" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" AutoPostBack="True" Visible="False" Enabled="False"></asp:TextBox>
                    </td>
                    <td width="50px"></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label34" runat="server" Text="Registro" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txtCodigo" runat="server" CssClass="input" Font-Bold="True" Width="150px" AutoPostBack="True" Visible="False" Enabled="False"></asp:TextBox>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="Label31" runat="server" Text="Días  causados" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txvNoDiasCausados" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px" Enabled="False" OnTextChanged="txvNoDiasCausados_TextChanged">0</asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#003366" OnClick="lbFechaIngreso_Click" Visible="False">Fecha salida</asp:LinkButton>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:Calendar ID="niCalendarFechaSalida" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaSalida_SelectionChanged" Visible="False" Width="150px">
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
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="Label30" runat="server" Text="Fecha retorno" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txtFechaRetorno" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" AutoPostBack="True" Visible="False" Enabled="False"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label35" runat="server" Text="Dias tomados" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txvNoDiasDisfrutados" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px">0</asp:TextBox>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="Label40" runat="server" Text="Dias pagar" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txvDiasPagar" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px" Enabled="False">0</asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label37" runat="server" Text="Valor Base" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txvValorBase" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px" Enabled="False">0</asp:TextBox>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Label ID="Label39" runat="server" Text="Días pendientes" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 250px;">
                        <asp:TextBox ID="txvNoDiasPendientes" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px">0</asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label38" runat="server" Text="Observaciones" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left;" colspan="4">
                        <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="40px" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox>
                    </td>
                    <td></td>
                </tr>
                <tr>
                    <td colspan="7" style="text-align: center">
                        <asp:Panel ID="pnConceptos" runat="server" Visible="False">
                            <div style="display: inline-block">
                                <table cellspacing="0" id="datosDet">
                                    <tr>
                                        <td valign="top" colspan="3">
                                            <asp:GridView ID="gvSaludPension" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" RowHeaderColumn="cuenta" OnRowDeleting="gvSaludPension_RowDeleting" Width="700px">
                                                <AlternatingRowStyle CssClass="alt" />
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Elim">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imElimina0" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" />
                                                        <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="codConcepto" HeaderText="Concepto">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="desConcepto" HeaderText="NombreConcepto">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="20px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valorTotal" HeaderText="Val Total" DataFormatString="{0:N2}">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="100px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="signo">
                                                        <HeaderStyle Width="5px" />
                                                        <ItemStyle Width="5px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="noPrestamo">
                                                    <ItemStyle Width="20px" />
                                                    </asp:BoundField>
                                                    <asp:CheckBoxField DataField="bss">
                                                        <ItemStyle Width="5px" />
                                                    </asp:CheckBoxField>
                                                </Columns>
                                                <PagerStyle CssClass="pgr" />
                                                <RowStyle CssClass="rw" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td valign="top" style="width: 100px">
                                            <asp:Label ID="Label41" runat="server" Text="Valor vacaciones" Visible="False"></asp:Label>
                                        </td>
                                        <td valign="top" style="width: 100px">
                                            <asp:TextBox ID="txtValorVacaciones" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="100px" Enabled="False">0</asp:TextBox>
                                        </td>
                                        <td style="width: 100px" valign="top">
                                            <asp:CheckBox ID="chkLiquiNomina" runat="server" Text="Paga nomina" AutoPostBack="True" OnCheckedChanged="chkLiquiNomina_CheckedChanged" />
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>

                        </asp:Panel>

                    </td>
                </tr>
            </table>
            <div style="margin: 5px; padding: 5px">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="1000px" CssClass="Grid" GridLines="None" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging1" OnRowUpdating="gvLista_RowUpdating">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:TemplateField HeaderText="Anul">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" />
                                <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="periodoInicial" HeaderText="PeriodoI" DataFormatString="{0:yyyy/MM/dd}">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="periodoFinal" DataFormatString="{0:yyyy/MM/dd}" HeaderText="PeriodoF">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaSalida" DataFormatString="{0:yyyy/MM/dd}" HeaderText="FSalida">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaRetorno" DataFormatString="{0:yyyy/MM/dd}" HeaderText="FRetorno">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="registro" HeaderText="Cod">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"  Width="10px"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="TipVaca" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="idEmpleado" HeaderText="Cedula">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tercero" HeaderText="CodTer" ShowHeader="False">
                                <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" Width="10px"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="empleado" HeaderText="Empleado">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="250px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="diasCausados" HeaderText="DiasC">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"  Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="diasPendientes" HeaderText="DiasP">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"  Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="año" HeaderText="Año">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="periodo" HeaderText="Periodo">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="valorPagado" HeaderText="Val. Pagado">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="ejecutado" HeaderText="Eje">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px"/>
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="anulado" HeaderText="Anul">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imImprime" runat="server" CommandName="update" ImageUrl="~/Imagen/TabsIcon/print.png" OnClientClick="if(!confirm('Desea imprimir el registro ?')){return false;};" ToolTip="Imprime el registro seleccionado" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="registro" />
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
