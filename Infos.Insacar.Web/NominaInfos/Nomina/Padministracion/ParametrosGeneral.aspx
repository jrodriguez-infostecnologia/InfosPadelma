<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ParametrosGeneral.aspx.cs" Inherits="Nomina_Paminidtracion_ParametrosGeneral" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td>

                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                    </td>
                </tr>
            </table>
            <div>
                <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
            </div>

            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td>
                        <div style="padding: 5px; text-align: center">
                            <div style="border: 1px solid silver; padding: 8px; display: inline-block;">
                                <div>
                                    <fieldset>
                                        <legend>Cálculos</legend>
                                        <table cellpadding="0" cellspacing="0" style="width: 980px">
                                            <tr>
                                                <td style="width: 100px"></td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label6" runat="server" Text="No. minímos salario integral"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvNoSalarioIntegral" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label7" runat="server" Text="Jornada diaria"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvJornadaDiaria" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:Label ID="Label25" runat="server" Text="Tipo jornada diaria"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:DropDownList ID="ddlTipoJornadaDiaria" data-placeholder="Seleccione una opción..." CssClass="chzn-select" runat="server">
                                                        <asp:ListItem Value="C">Corriente</asp:ListItem>
                                                        <asp:ListItem Value="A">Anticipado</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px">&nbsp;</td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label26" runat="server" Text="HIJ diurna" ToolTip="Hora inicial jornada diurna"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvHIJD" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label27" runat="server" Text="HIJ nocturna" ToolTip="Hora inicial jornada nocturna"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvHIJN" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#003366" OnClick="lbFecha_Click">Fecha ultima cesantias</asp:LinkButton>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:Calendar ID="calendarUltimaCesantias" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged" Visible="False" Width="150px">
                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                    </asp:Calendar>
                                                    <asp:TextBox ID="txtUltimaCesantias" runat="server" class="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px"></asp:TextBox>
                                                </td>
                                                <td style="width: 100px">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px">&nbsp;</td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label69" runat="server" Text="HFJ diurna" ToolTip="Hora final jornada diurna"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvHFJD" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label70" runat="server" Text="HFJ nocturna" ToolTip="Hora final jornada nocturna"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvHFJN" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td style="width: 150px; text-align: left;">
                                                    <asp:Label ID="Label66" runat="server" Text="Días vacaciones"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvDiasVacaciones" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td style="width: 100px">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px">&nbsp;</td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label71" runat="server" Text="No. SMLV Parafiscales (Sena, ICBF)"></asp:Label>
                                                </td>
                                                <td style="width: 100px; text-align: left;">
                                                    <asp:TextBox ID="txvNoSMLVParafiscales" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="50px"></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos" colspan="2">
                                                    <asp:CheckBox ID="chkPromediaGD" runat="server" Text="Promedia gana domingo" />
                                                </td>
                                                <td style="text-align: left;" colspan="2">
                                                    <asp:CheckBox ID="chkPromediaFestivo" runat="server" Text="Promedia festivos" />
                                                    <asp:CheckBox ID="chkPaga31" runat="server" Text="Paga meses con 31" />
                                                </td>
                                                <td style="width: 100px">&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px">&nbsp;</td>
                                                <td class="nombreCampos">
                                                    &nbsp;</td>
                                                <td style="width: 100px; text-align: left;">
                                                    &nbsp;</td>
                                                <td class="nombreCampos">&nbsp;</td>
                                                <td style="width: 100px; text-align: left;">&nbsp;</td>
                                                <td style="width: 150px; text-align: left;">
                                                    &nbsp;</td>
                                                <td style="width: 100px; text-align: left;">&nbsp;</td>
                                                <td style="width: 100px">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </div>
                                <div>
                                    <fieldset>
                                        <legend>Conceptos de extras y regargos</legend>
                                        <div style="width: 980px">
                                            <div style="padding: 8px; display: inline-block;">
                                                <fieldset style="width: 650px">
                                                    <legend>Días ordinarios</legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label31" runat="server" Text="Horas ordinarias"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHorasOrdinarias" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label1" runat="server" Text="Horas recargo nocturno"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHRN" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label2" runat="server" Text="Horas extras diurnas"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHED" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label5" runat="server" Text="Horas extras nocturnas"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHEN" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div style="padding: 8px; display: inline-block;">
                                                <fieldset style="width: 450px">
                                                    <legend>Días&nbsp; festivos </legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label4" runat="server" Text="Hora festivas"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHF" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label34" runat="server" Text="Horas recargo nocturno"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHRF" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label35" runat="server" Text="Horas extras diurnas"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHEDF" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label36" runat="server" Text="Horas extras nocturnas"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHENF" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div style="padding: 8px; display: inline-block;">
                                                <fieldset style="width: 450px">
                                                    <legend>Días dominicales</legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label32" runat="server" Text="Horas dominicales"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHD" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label8" runat="server" Text="Horas recargo nocturno"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlRND" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label9" runat="server" Text="Horas extras diurnas"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHEDD" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label10" runat="server" Text="Horas extras nocturnas"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHEND" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>

                                <div>
                                    <fieldset>
                                        <legend>Conceptos generales</legend>
                                        <div style="width: 980px">
                                            <div style="padding: 8px; display: inline-block;">
                                                <fieldset style="width: 450px">
                                                    <legend>Conceptos ordinarios</legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label28" runat="server" Text="Sueldo"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSueldo" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label29" runat="server" Text="Jornales"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlJornales" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label30" runat="server" Text="Cesantias"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlCesantias" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label37" runat="server" Text="Intereses cesantias"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlInteresesCesantias" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label38" runat="server" Text="Vacaciones"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlVacaciones" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label39" runat="server" Text="Primas"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlPrimas" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label50" runat="server" Text="Salario integral"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSalarioIntegral" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label48" runat="server" Text="Permisos"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlPermisos" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label52" runat="server" Text="Subsidio de transporte"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSubsidioTranasporte" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label55" runat="server" Text="Retroactivo"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlRetroactivo" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label53" runat="server" Text="Retención"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlRetencion" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label56" runat="server" Text="Sunpenciones"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSuspencion" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label57" runat="server" Text="Incapacidades"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlincapacidades" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label62" runat="server" Text="Embargos"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlEmbargos" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label63" runat="server" Text="Gana domingo campo"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlGanaDomingoCampo" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label65" runat="server" Text="Sindicato"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSindicato" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label67" runat="server" Text="Paga festivo "></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlPagaFestivo" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div style="padding: 8px; display: inline-block;">
                                                <fieldset style="width: 450px">
                                                    <legend>Conceptos entidades / adicionales</legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label43" runat="server" Text="Caja compensación"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlCajaCompensacion" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label60" runat="server" Text="Salud"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSalud" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label61" runat="server" Text="Pensión"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlPension" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label44" runat="server" Text="Sena"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSena" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label45" runat="server" Text="ICBF"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlICBF" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label54" runat="server" Text="ARP"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlARP" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label40" runat="server" Text="Indemnización"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlIndemnizacion" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label41" runat="server" Text="Enfermedad y Maternidad"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlEnfermedadMaternidad" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label42" runat="server" Text="Invalidez, vejez y muerte"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlIVM" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label46" runat="server" Text="A.T.E.P."></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlATEP" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label47" runat="server" Text="Fondo solidaridad"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlFondoSolidaridad" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label49" runat="server" Text="Lic. remunerado"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlLicRemunerada" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label51" runat="server" Text="Lic. no  remunerado"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlLicNoRemunerada" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label58" runat="server" Text="Primas extralegales"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlPrimasExtralegales" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label59" runat="server" Text="Anticipo cesantias"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAnticipoCesantias" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label64" runat="server" Text="Fondo de empleados"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlFondoEmpleado" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label68" runat="server" Text="Aprendiz Sena"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAprendizSena" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </div>
                                    </fieldset>
                                </div>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>

        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
