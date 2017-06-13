<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Contratos.aspx.cs" Inherits="Facturacion_Padministracion_Contratos" EnableEventValidation="false" MaintainScrollPositionOnPostback="true" %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>

    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/TabsAjax.css" rel="stylesheet" />
    <%-- Este es el estilo de combobox --%>

    <link href="../../css/chosen.css" rel="stylesheet" />

    <style type="text/css">
        BODY {
            font-family: verdana, arial, helvetica;
        }

        .calTitle {
            font-weight: bold;
            font-size: 11px;
            background-color: #cccccc;
            color: black;
            width: 90px;
        }

        .calTitleAño {
            font-weight: bold;
            font-size: 11px;
            background-color: #cccccc;
            color: black;
            width: 60px;
        }



        .calBody {
            font-size: 11px;
            border-width: 10px;
        }



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
                    <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); background-repeat: no-repeat; text-align: left;"></td>
                    <td style="width: 100px; text-align: left">Busqueda</td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; text-align: right; background-position-x: right;"></td>
                </tr>
                <tr>
                    <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); background-repeat: no-repeat; text-align: left;"></td>
                    <td style="text-align: center" colspan="2">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="lbNuevo_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" Style="height: 21px" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" Style="height: 21px" />

                        <asp:ImageButton ID="lbImprimir" runat="server" ImageUrl="~/Imagen/Bonotes/btnImprimir.png" ToolTip="Imprime Carnet"
                            onmouseout="this.src='../../Imagen/Bonotes/btnImprimir.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnImprimirN.png'" OnClick="lbImprimir_Click" Visible="False" Style="margin-left: 0px" />
                    </td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; text-align: right; background-position-x: right;"></td>
                </tr>
            </table>
            <div style="text-align: center">
                <div style="display: inline-block;">
                    <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                        <tr>
                            <td colspan="3" style="width: 950px; height: 10px;">
                                <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 200px; text-align: center" rowspan="6">
                                <asp:Image ID="imbFuncionario" runat="server" Height="140px" Visible="False" Width="130px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </td>
                            <td style="width: 100px; text-align: left">
                                <asp:Label ID="Label1" runat="server" Text="Empleado" Visible="False"></asp:Label></td>
                            <td style="text-align: left">
                                <asp:DropDownList ID="ddlTercero" runat="server" Width="350px" AutoPostBack="True" OnSelectedIndexChanged="ddlFuncionario_SelectedIndexChanged" Visible="False" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                </asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: left">
                                <asp:Label ID="Label15" runat="server" Text="Código" Visible="False"></asp:Label></td>
                            <td style="text-align: left">
                                <asp:TextBox ID="txtCodigoTercero" runat="server" CssClass="input" Width="150px" Visible="False" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: left">
                                <asp:Label ID="Label13" runat="server" Text="Identificación" Visible="False"></asp:Label></td>
                            <td style="text-align: left">
                                <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="input" Width="150px" Visible="False" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: left">
                                <asp:Label ID="Label12" runat="server" Text="Descripción" Visible="False"></asp:Label></td>
                            <td style="text-align: left">
                                <asp:TextBox ID="txtDescripcion" runat="server" CssClass="input" Width="350px" Visible="False" ReadOnly="True"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: left">
                                <asp:Label ID="Label14" runat="server" Text="Nro. contrato" Visible="False"></asp:Label></td>
                            <td style="text-align: left">
                                <asp:TextBox ID="txtNroContrato" runat="server" CssClass="input" Width="70px" Visible="False" ReadOnly="True" Enabled="False"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px; text-align: left"></td>
                            <td style="text-align: left">
                                <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                            </td>
                        </tr>
                        <tr>
                            <td style="height: 15px;" colspan="3">
                                <asp:Panel ID="pnContratos" runat="server" Visible="False">
                                    <div id="Generales">
                                        <fieldset>
                                            <legend>Generales
                                            </legend>
                                            <div id="">
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento39" runat="server" Text="Centro costo"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="Campos">
                                                            <asp:DropDownList ID="ddlCcosto" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlCcosto_SelectedIndexChanged" Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:LinkButton ID="lbFechaIngreso" runat="server" ForeColor="#003366" OnClick="lbFechaIngreso_Click">Fecha ingreso</asp:LinkButton>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:Calendar ID="niCalendarFechaIngreso" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaIngreso_SelectionChanged" Visible="False" Width="150px">
                                                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                                <NextPrevStyle VerticalAlign="Bottom" />
                                                                <OtherMonthDayStyle ForeColor="Gray" />
                                                                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                                <SelectorStyle BackColor="#CCCCCC" />
                                                                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                                <WeekendDayStyle BackColor="FloralWhite" />
                                                            </asp:Calendar>
                                                            <asp:TextBox ID="txtFechaIngreso" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" AutoPostBack="True" OnTextChanged="txtFechaIngreso_TextChanged"></asp:TextBox>
                                                            <asp:Label ID="lblRL0" runat="server" Text="(dd/mm/aaaa)"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento" runat="server" Text="Departamento"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlDepartamento" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblClaseContrato" runat="server" Text="Clase contrato"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlClaseContrato" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" OnSelectedIndexChanged="ddlClaseContrato_SelectedIndexChanged">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblRL" runat="server" Text="Regimen Laboral"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlRegimenLaboral" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="150px">
                                                                <asp:ListItem Value="1">Ley 50</asp:ListItem>
                                                                <asp:ListItem Value="2">Antes Ley 50</asp:ListItem>
                                                                <asp:ListItem Value="3">Jubilado</asp:ListItem>
                                                                <asp:ListItem Value="4">Otros</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblClaseContrato1" runat="server" Text="Días duración contrato"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:TextBox ID="txtDiasDuracion" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" OnTextChanged="txtDiasDuracion_TextChanged" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos"></td>
                                                        <td class="Campos">
                                                            <asp:CheckBox ID="chkSalarioIntegral" runat="server" Text="Salario Integral  " />
                                                            <asp:CheckBox ID="chkPactoColectivo" runat="server" Text="Pacto Colectivo " />
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblClaseContrato0" runat="server" Text="Contrato hasta"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:TextBox ID="txtFechaCH" runat="server" CssClass="input" Enabled="False" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos"></td>
                                                        <td class="Campos" style="width: 350px"></td>
                                                        <td class="nombreCampos" style="width: 150px"></td>
                                                        <td class="Campos"></td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div id="SeguridadSocial">
                                        <fieldset>
                                            <legend>Seguridad Social </legend>
                                            <div>
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento2" runat="server" Text="Entidad de Salud"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="Campos">
                                                            <asp:DropDownList ID="ddlEPS" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento1" runat="server" Text="Entidad de Pensión"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlAFP" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento6" runat="server" Text="Tipo Salud Adicional"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="Campos">
                                                            <asp:DropDownList ID="ddlTipoSaludAdicional" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlSP_SelectedIndexChanged" Width="200px">
                                                                <asp:ListItem Value="01">No aplica</asp:ListItem>
                                                                <asp:ListItem Value="02">U.P.C</asp:ListItem>
                                                                <asp:ListItem Value="03">Prepagada</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento11" runat="server" Text="Personas a cargo salud"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txvPersonasCargo" runat="server" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento43" runat="server" Text="Salud Adicional"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="Campos">
                                                            <asp:DropDownList ID="ddlEPSAdicional" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento38" runat="server" Text="Valor adicional (UPC)"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txvValAdicional" runat="server" CssClass="input" Enabled="False" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento0" runat="server" Text="A.R.P"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="Campos">
                                                            <asp:DropDownList ID="ddlARP" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento3" runat="server" Text="Centro de Trabajo"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlCT" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento4" runat="server" Text="Tipo de cotizante"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="Campos">
                                                            <asp:DropDownList ID="ddlTipoCotizante" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento5" runat="server" Text="Subtipo cotizante"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlSubTipoCotizante" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos"></td>
                                                        <td class="Campos" style="width: 350px"></td>
                                                        <td class="nombreCampos" style="width: 150px"></td>
                                                        <td class="campos"></td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div id="Parafiscales">
                                        <fieldset>
                                            <legend>Parafiscales</legend>
                                            <div>
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento8" runat="server" Text="Caja de Compensación"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlCaja" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento9" runat="server" Text="Sena"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlSena" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>

                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento10" runat="server" Text="ICBF"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlICBF" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos" style="width: 150px"></td>
                                                        <td class="campos"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos" style="width: 150px"></td>
                                                        <td style="width: 350px"></td>
                                                        <td class="nombreCampos"></td>
                                                        <td class="campos"></td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div id="Fondos">
                                        <fieldset>
                                            <legend>Fondos</legend>
                                            <div>
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento12" runat="server" Text="Fondo de Cesantias"></asp:Label>
                                                        </td>
                                                        <td style="width: 350px; text-align: left;">
                                                            <asp:DropDownList ID="ddlFondoCesantias" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos"></td>
                                                        <td class="campos"></td>
                                                    </tr>

                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:CheckBox ID="chkSindicato" runat="server" AutoPostBack="True" OnCheckedChanged="chkSindicato_CheckedChanged" Text="Sindicato" />
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlSindicato" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Enabled="False" OnSelectedIndexChanged="ddlSP_SelectedIndexChanged" Width="300px">
                                                                <asp:ListItem Value="01">No aplica</asp:ListItem>
                                                                <asp:ListItem Value="02">U.P.C</asp:ListItem>
                                                                <asp:ListItem Value="03">Prepagada</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento40" runat="server" Text="Sindicato (%)"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txvPorcentajeSindicato" runat="server" CssClass="input" Enabled="False" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:CheckBox ID="chkFondoEmpleado" runat="server" AutoPostBack="True" OnCheckedChanged="chkFondoEmpleado_CheckedChanged" Text="Fondo Empleado" />
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlFondoEmpleado" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Enabled="False" OnSelectedIndexChanged="ddlSP_SelectedIndexChanged" Width="300px">
                                                                <asp:ListItem Value="01">No aplica</asp:ListItem>
                                                                <asp:ListItem Value="02">U.P.C</asp:ListItem>
                                                                <asp:ListItem Value="03">Prepagada</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento42" runat="server" Text="Fondo Empleado (%)"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txvPorcentajeFondo" runat="server" CssClass="input" Enabled="False" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos" style="width: 150px"></td>
                                                        <td class="Campos"></td>
                                                        <td class="nombreCampos" style="width: 150px"></td>
                                                        <td class="campos"></td>
                                                    </tr>

                                                </table>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div id="Salario">
                                        <fieldset>
                                            <legend>Información del Salario</legend>
                                            <div>
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento13" runat="server" Text="Tipo de nomina"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="campos">
                                                            <asp:DropDownList ID="ddlTipoNomina" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos" style="width: 150px; text-align: left">
                                                            <asp:Label ID="lblDepartamento20" runat="server" Text="Sueldo basico"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="campos">
                                                            <asp:TextBox ID="txtSueldoBasico" runat="server" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Solo numeros" Width="150px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento15" runat="server" Text="Cargo"></asp:Label>
                                                        </td>
                                                        <td width="310px" class="campos">
                                                            <asp:DropDownList ID="ddlCargo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento27" runat="server" Text="Sueldo anterior"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txtSueldoAnterior" runat="server" CssClass="input" Enabled="False" onkeyup="formato_numero(this)" Font-Bold="True" ToolTip="Solo Numeros" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento17" runat="server" Text="Auxilio de transporte"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlAuxTransporte" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                                <asp:ListItem Value="0">No aplica</asp:ListItem>
                                                                <asp:ListItem Value="1">En dinero</asp:ListItem>
                                                                <asp:ListItem Value="2">En especie</asp:ListItem>
                                                                <asp:ListItem Value="3">Menor a 2.S.M.V.L </asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento28" runat="server" Text="Cantidad de horas"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txtHoras" runat="server" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Solo numeros" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblRL6" runat="server" Text="Fecha ultimo aumento"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txtFechaUltimoAumento" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" Enabled="False"></asp:TextBox>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento29" runat="server" Text="Tiempo laborado (%)"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:TextBox ID="txtTiempoLaborado" runat="server" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos"></td>
                                                        <td class="campos" style="width: 350px"></td>
                                                        <td class="nombreCampos" style="width: 350px"></td>
                                                        <td class="campos"></td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </fieldset>
                                    </div>
                                    <div id="Pago">
                                        <fieldset>
                                            <legend>Información de Pago</legend>
                                            <div>
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos"></td>
                                                        <td style="width: 250px" class="Campos"></td>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos"></td>
                                                        <td style="width: 250px" class="Campos"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento30" runat="server" Text="Forma de pago"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento32" runat="server" Text="Banco"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:DropDownList ID="ddlBanco" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento37" runat="server" Text="Tipo de cuenta"></asp:Label>
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlTipoCuenta" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="lblDepartamento36" runat="server" Text="Número cuenta"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:TextBox ID="txtNumeroCuenta" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="250px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos"></td>
                                                        <td class="campos" style="width: 350px"></td>
                                                        <td class="nombreCampos"></td>
                                                        <td class="Campos"></td>
                                                    </tr>
                                                </table>
                                            </div>

                                        </fieldset>
                                    </div>

                                    <div id="TipoDestajo">
                                        <fieldset>
                                            <legend>Información de Destajo</legend>
                                            <div>
                                                <table cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos"></td>
                                                        <td style="width: 250px" class="Campos"></td>
                                                        <td style="width: 150px; text-align: left" class="nombreCampos"></td>
                                                        <td style="width: 250px" class="Campos"></td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos">
                                                            <asp:CheckBox ID="chkManejaDestajo" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaDestajo_CheckedChanged" Text="Maneja destajo" />
                                                        </td>
                                                        <td class="campos">
                                                            <asp:DropDownList ID="ddlGrupoLabores" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td class="nombreCampos">
                                                            <asp:Label ID="Label3" runat="server" Text="Cantidad Destajo"></asp:Label>
                                                        </td>
                                                        <td class="Campos">
                                                            <asp:TextBox ID="txvValorContrato" runat="server" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Solo numeros" Width="150px">0</asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td class="nombreCampos"></td>
                                                        <td class="campos" style="width: 350px"></td>
                                                        <td class="nombreCampos"></td>
                                                        <td class="Campos"></td>
                                                    </tr>
                                                </table>
                                            </div>

                                        </fieldset>
                                    </div>
                                </asp:Panel>
                            </td>
                            <td style="height: 15px;"></td>
                        </tr>
                        <tr>
                            <td colspan="3" style="height: 15px"></td>
                        </tr>
                    </table>
                </div>
            </div>
            <div style="text-align: center">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="900px" GridLines="None" CssClass="Grid" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging">
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
                            <asp:BoundField DataField="codigo" HeaderText="C&#243;digo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tercero" HeaderText="Tercero" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" ReadOnly="True"
                                SortExpression="descripcion" HtmlEncode="False" HtmlEncodeFormatString="False">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaNacimiento" HeaderText="FechaN" DataFormatString="{0:dd/MM/yyy}">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ciduadNacimiento" HeaderText="CiudadN">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sexo" HeaderText="Sexo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="id" HeaderText="No Contrato">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="conductor" HeaderText="Cond">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="operadorLogistico" HeaderText="Port">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="declarante" HeaderText="Decl">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Activo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
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
