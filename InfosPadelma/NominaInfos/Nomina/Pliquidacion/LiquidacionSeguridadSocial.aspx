<%@ Page Language="C#" AutoEventWireup="true" CodeFile="LiquidacionSeguridadSocial.aspx.cs" Inherits="Nomina_Pliquidacion_LiquidacionSeguridadSocial" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Seguridad</title>
    <link rel="stylesheet" href="../../css/common.css" type="text/css" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui.css" rel="stylesheet" />
    <link type="text/css" href="../../css/ui.multiselect.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/jqueryv1.5.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui1.8.10.min.js"></script>
    <script type="text/javascript" src="../../js/plugins/localisation/jquery.localisation-min.js"></script>
    <script type="text/javascript" src="../../js/plugins/scrollTo/jquery.scrollTo-min.js"></script>
    <script type="text/javascript" src="../../js/ui.multiselect.js"></script>
    <script type="text/javascript">
        $(function () {
            $.localise('ui-multiselect', { language: 'es', path: '../../js/locale/' });
            $(".multiselect").multiselect();
        });

        function Visualizacion(informe) {
            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + screen.availWidth + ", height =" + screen.availHeight + ", top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }

        function VisualizacionLiquidacion(informe, ano, periodo, numero) {
            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + screen.availWidth + ", height =" + screen.availHeight + ", top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe + "&ano=" + ano + "&periodo=" + periodo + "&numero=" + numero;;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }
        function alerta(mensaje) {
            alert(mensaje);
        }
    </script>

    <script type="text/javascript">

        function VisualizacionPlano(empresa, año, periodo) {

            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + 0 + ", height =" + 0 + ", top = 0, left = 5";
            sTransaccion = "GenerarPlano.aspx?empresa=" + empresa + "&periodo=" + periodo + "&año=" + año;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }

        function VisualizacionInforme(informe, año, periodo, numero) {
            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + screen.availWidth + ", height =" + screen.availHeight + ", top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe + "&año=" + año + "&periodo=" + periodo + "&numero=" + numero;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }

        $(function () {
            $.localise('ui-multiselect', { language: 'es', path: '../../js/locale/' });
            $(".multiselect").multiselect();
            // $('#switcher').themeswitcher();
        });
    </script>

    <link href="../../css/chosen.css" rel="stylesheet" />
    <script charset="utf-8" type="text/javascript">
        var contador = 0;
    </script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div style="text-align: center; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 12px; color: #000066;">
            <div style="display: inline-block">
                <table style="width: 100%">
                    <tr>
                        <td style="width: 20%">
                            <asp:ScriptManager ID="ScriptManager1" runat="server">
                            </asp:ScriptManager>
                        </td>
                        <td>Año</td>
                        <td style="width: 70px; text-align: left;">
                            <asp:TextBox ID="nitxvAño" runat="server" CssClass="input" ToolTip="Escriba el texto para la busqueda" Width="70px" MaxLength="4"></asp:TextBox>
                        </td>
                        <td>Mes</td>
                        <td style="text-align: left; width: 150px;">
                            <asp:DropDownList ID="niddlMes" runat="server" Width="120px" CssClass="chzn-select">
                                <asp:ListItem Value="1">Enero</asp:ListItem>
                                <asp:ListItem Value="2">Febrero</asp:ListItem>
                                <asp:ListItem Value="3">Marzo</asp:ListItem>
                                <asp:ListItem Value="4">Abril</asp:ListItem>
                                <asp:ListItem Value="5">Mayo</asp:ListItem>
                                <asp:ListItem Value="6">Junio</asp:ListItem>
                                <asp:ListItem Value="7">Julio</asp:ListItem>
                                <asp:ListItem Value="8">Agosto</asp:ListItem>
                                <asp:ListItem Value="9">Septiembre</asp:ListItem>
                                <asp:ListItem Value="10">Octubre</asp:ListItem>
                                <asp:ListItem Value="11">Noviembre</asp:ListItem>
                                <asp:ListItem Value="12">Diciembre</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td style="text-align: left">Trabajador</td>
                        <td style="text-align: left">
                            <asp:TextBox ID="nitxtFiltro" runat="server" CssClass="input" ToolTip="Escriba el texto para la busqueda" Width="270px"></asp:TextBox>
                        </td>
                        <td style="width: 20%"></td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <asp:UpdateProgress ID="UpdateProgress2" runat="server">
                                <ProgressTemplate>
                                    Cargando...<br>
                                        <asp:Image ID="Image2" runat="server" ImageUrl="~/Imagen/bitmaps/ajax-loader.gif" />
                                    </br>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                            <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="niimbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" Style="height: 21px" />
                            <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="lbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                            <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                            <asp:ImageButton ID="nibtnLiquidar" runat="server" ImageUrl="~/Imagen/Bonotes/btnLiquidar.png" OnClick="btnLiquidar_Click" OnClientClick="if(!confirm('Desea liquidar el periodo de Seguridad Social ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnLiquidar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnLiquidarN.png'" ToolTip="Liquidar Seguridad Social" />

                            <asp:ImageButton ID="nilbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                                onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                                onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                            <asp:ImageButton ID="nibtnGenerarPlano" runat="server" ImageUrl="~/Imagen/Bonotes/btnGeneraPlano.png" OnClick="nibtnGenerarPlano_Click" onmouseout="this.src='../../Imagen/Bonotes/btnGeneraPlano.png'"
                                onmouseover="this.src='../../Imagen/Bonotes/btnGeneraPlanoN.png'" ToolTip="General plano seguridad social" />

                        </td>
                    </tr>
                    <tr>
                        <td colspan="8">
                            <asp:Label ID="nilblInformacion" runat="server"></asp:Label>

                        </td>
                    </tr>
                </table>
                <asp:Panel ID="pnDatos" runat="server" Visible="False">
                    <div id="caja" style="width: 1230px; padding: 5px">
                        <fieldset style="border: 1px solid #3366FF; padding: 3px">
                            <legend style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 14px; color: #3366FF; font-weight: bold; text-align: left">Datos de contrato </legend>
                            <table style="width: 100%; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;" id="Table2">
                                <tr>
                                    <td style="width: 100px; text-align: left;">
                                        <asp:Label ID="lblaño" runat="server" Text="Año / Mes" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 80px; text-align: left;">
                                        <asp:TextBox ID="txvAño" runat="server" CssClass="input" MaxLength="4" ToolTip="Escriba el texto para la busqueda" Visible="False" Width="70px" AutoPostBack="True" OnTextChanged="txvAño_TextChanged" TextMode="Number"></asp:TextBox>
                                    </td>
                                    <td style="width: 120px; text-align: left;">
                                        <asp:DropDownList ID="ddlMes" runat="server" CssClass="chzn-select" Visible="False" Width="100px" AutoPostBack="True" OnSelectedIndexChanged="ddlMes_SelectedIndexChanged">
                                            <asp:ListItem Value="1">Enero</asp:ListItem>
                                            <asp:ListItem Value="2">Febrero</asp:ListItem>
                                            <asp:ListItem Value="3">Marzo</asp:ListItem>
                                            <asp:ListItem Value="4">Abril</asp:ListItem>
                                            <asp:ListItem Value="5">Mayo</asp:ListItem>
                                            <asp:ListItem Value="6">Junio</asp:ListItem>
                                            <asp:ListItem Value="7">Julio</asp:ListItem>
                                            <asp:ListItem Value="8">Agosto</asp:ListItem>
                                            <asp:ListItem Value="9">Septiembre</asp:ListItem>
                                            <asp:ListItem Value="10">Octubre</asp:ListItem>
                                            <asp:ListItem Value="11">Noviembre</asp:ListItem>
                                            <asp:ListItem Value="12">Diciembre</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 100px; text-align: left;">
                                        <asp:Label ID="lblOpcionLiquidacion" runat="server" Text="Trabajador" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left;">
                                        <asp:DropDownList ID="ddlEmpleado" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged" Visible="False" Width="350px">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: left;">
                                        <asp:Label ID="lblOpcionLiquidacion0" runat="server" Text="Contrato" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left;">
                                        <asp:DropDownList ID="ddlContratos" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="250px" AutoPostBack="True" OnSelectedIndexChanged="ddlContratos_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="width: 50px; text-align: left;">
                                        <asp:Label ID="lbRegistro" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>
                            <table style="width: 100%">
                                <tr>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto88" runat="server" Text="Tipo Identi." Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:DropDownList ID="ddlTipoId" runat="server" CssClass="chzn-select" Visible="False" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: left; width: 110px">
                                        <asp:Label ID="lblCcosto89" runat="server" Text="Identificacion" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtIdentificacion" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" Visible="False" Width="180px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto90" runat="server" Text="Código" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtCodigoTercero" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 110px">&nbsp;</td>
                                    <td style="text-align: left">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto47" runat="server" Text="Primer apellido" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtApellido1" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" Visible="False" Width="180px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 110px">
                                        <asp:Label ID="lblCcosto48" runat="server" Text="Segundo apellido" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtApellido2" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" Visible="False" Width="180px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto49" runat="server" Text="Primer nombre" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtNombre1" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" Visible="False" Width="180px"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 110px">
                                        <asp:Label ID="lblCcosto50" runat="server" Text="Segundo nombre" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtNombre2" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" Visible="False" Width="180px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto51" runat="server" Text="Departamento" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:DropDownList ID="ddlDepartamento" runat="server" Width="200px" CssClass="chzn-select" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlDepartamento_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: left; width: 110px">
                                        <asp:Label ID="lblCcosto52" runat="server" Text="Ciudad" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:DropDownList ID="ddlCiudad" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto53" runat="server" Text="Tipo cotizante" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:DropDownList ID="ddlTipoCotizante" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="text-align: left; width: 110px">
                                        <asp:Label ID="lblCcosto54" runat="server" Text="Sub tipo cot" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:DropDownList ID="ddlSubTipoCotizante" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto46" runat="server" Text="Horas laboradas" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txvNoHoras" runat="server" Font-Bold="True" ForeColor="#336699"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px" TextMode="Number"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 110px">
                                        <asp:CheckBox ID="chkExtrajero" runat="server" Text="Extranjero" Visible="False" />
                                    </td>
                                    <td style="text-align: left">
                                        <asp:CheckBox ID="chkRecidenteExtranjero" runat="server" Text="Recidente Exterior" Visible="False" />
                                    </td>
                                    <td style="text-align: left; width: 100px">
                                        <asp:Label ID="lblCcosto37" runat="server" Text="Fecha rad. ext." Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txtFechaRadExtrajero" runat="server" Font-Bold="True" ForeColor="#336699"
                                            Visible="False" CssClass="input" Width="150px" OnTextChanged="txtFechaRadExtrajero_TextChanged1"></asp:TextBox>
                                    </td>
                                    <td style="text-align: left; width: 110px">
                                        <asp:Label ID="lblCcosto55" runat="server" Text="Salario" Visible="False"></asp:Label>
                                    </td>
                                    <td style="text-align: left">
                                        <asp:TextBox ID="txvSalario" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="border: 1px solid #3366FF; padding: 3px">
                            <legend style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 14px; color: #3366FF; font-weight: bold; text-align: left">Novedades </legend>
                            <table style="width: 100%">
                                <tr>
                                    <td>
                                        <table style="width: 100%; text-align: left;">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkING" runat="server" Text="ING" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlIngreso" runat="server" Width="50px" CssClass="chzn-select" Visible="False">
                                                        <asp:ListItem>X</asp:ListItem>
                                                        <asp:ListItem>R</asp:ListItem>
                                                        <asp:ListItem>C</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="width: 100px">
                                                    <asp:Label ID="lblCcosto23" runat="server" Text="Fecha ingreso" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaIngreso" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkRET" runat="server" Text="RET" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlRetiro" runat="server" Width="50px" CssClass="chzn-select" Visible="False">
                                                        <asp:ListItem>X</asp:ListItem>
                                                        <asp:ListItem>P</asp:ListItem>
                                                        <asp:ListItem>R</asp:ListItem>
                                                        <asp:ListItem>C</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto22" runat="server" Text="Fecha retiro" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaRetiro" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table style="width: 100%">
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkTDE" runat="server" Text="TDE" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkTAE" runat="server" Text="TAE" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkTDP" runat="server" Text="TDP" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkTAP" runat="server" Text="TAP" Visible="False" />
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <table style="width: 100%; text-align: left;">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chkVSP" runat="server" Text="VSP" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto34" runat="server" Text="Fecha VSP" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaVSP" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkVST" runat="server" Text="VST" Visible="False" />
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chkIGE" runat="server" Text="IGE" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto42" runat="server" Text="Fecha inicial" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaInicialIGE" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto43" runat="server" Text="Fecha final" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaFinalIGE" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkVAC" runat="server" Text="VAC" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlVacaciones" runat="server" Width="50px" CssClass="chzn-select" Visible="False">
                                                        <asp:ListItem>X</asp:ListItem>
                                                        <asp:ListItem>L</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto24" runat="server" Text="Fecha inicial" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaInicialVacaciones" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto25" runat="server" Text="Fecha final" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaFinalVacaciones" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkIRL" runat="server" Text="IRL" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txvIRP" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto44" runat="server" Text="Fecha inicial" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaInicialIRL" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto45" runat="server" Text="Fecha final" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaFinalIRL" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td>
                                        <table style="width: 100%; text-align: left;">
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chkSLN" runat="server" Text="SLN" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto38" runat="server" Text="Fecha inicial" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaInicialSLN" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto39" runat="server" Text="Fecha final" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaFinalSLN" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chkLMA" runat="server" Text="LMA" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto40" runat="server" Text="Fecha inicial" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaInicialLMA" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto41" runat="server" Text="Fecha final" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaFinalLMA" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:CheckBox ID="chkAVP" runat="server" Text="AVP" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:CheckBox ID="chkVCT" runat="server" Text="VCT" Visible="False" />
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto32" runat="server" Text="Fecha inicial" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaInicialVCT" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblCcosto33" runat="server" Text="Fecha final" Visible="False"></asp:Label>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtFechaFinalVCT" runat="server" Font-Bold="True" ForeColor="#336699"
                                                        Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:CheckBox ID="chkCorreccion" runat="server" Text="Correcciones" Visible="False" />
                                                </td>
                                                <td colspan="3">
                                                    <asp:CheckBox ID="chkSalarioIntegral" runat="server" Text="Salario integral" Visible="False" />
                                                </td>
                                                <td></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>

                        </fieldset>
                        <fieldset style="border: 1px solid #3366FF; padding: 3px">
                            <legend style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 14px; color: #3366FF; font-weight: bold; text-align: left">Liquidación / Pensión </legend>
                            <table style="width: 100%; text-align: left;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto56" runat="server" Text="Administrador pensión" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 200px">
                                        <asp:DropDownList ID="ddlPension" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto17" runat="server" Text="Días pensión" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvDiasPension" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto5" runat="server" Text="% Pensión" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvpPension" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto1" runat="server" Text="IBC Pensión" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvIBCPension" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto9" runat="server" Text="$ Pensión" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvValorPension" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="100px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto57" runat="server" Text="Inficador de alto riesgo" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 200px">
                                        <asp:DropDownList ID="ddlAltoRiesgo" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                            <asp:ListItem>0</asp:ListItem>
                                            <asp:ListItem>1</asp:ListItem>
                                            <asp:ListItem>2</asp:ListItem>
                                            <asp:ListItem>3</asp:ListItem>
                                            <asp:ListItem>4</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto79" runat="server" Text="% Fondo" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvpFondo" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto60" runat="server" Text="$ Fondo solidaridad" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvValorFondo" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto61" runat="server" Text="$ Fondo subsidiado" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvValorFondoSub" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto58" runat="server" Text="$ Volun. afiliado" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvValorVoluntarioAfiliado" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto71" runat="server" Text="Pensión destino" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 200px">
                                        <asp:DropDownList ID="ddlPensionDestino" runat="server" CssClass="chzn-select" Visible="False" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto59" runat="server" Text="$ Volun. empleador" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvValorVoluntarioEmpleador" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto62" runat="server" Text="$ Retenido" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvValorRetenido" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto63" runat="server" Text="$ Total" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 100px">
                                        <asp:TextBox ID="txvValorTotalPension" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td style="width: 100px"></td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="border: 1px solid #3366FF; padding: 3px">
                            <legend style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 14px; color: #3366FF; font-weight: bold; text-align: left">Liquidación / Salud </legend>
                            <table style="width: 100%; text-align: left;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto64" runat="server" Text="Administrador salud" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSalud" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto16" runat="server" Text="Días salud" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvDiasSalud" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto4" runat="server" Text="% Salud" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvpSalud" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto0" runat="server" Text="IBC salud" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvIBCSalud" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="100px"></asp:TextBox></td>
                                    <td>
                                        <asp:Label ID="lblCcosto8" runat="server" Text="$ Salud" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorSalud" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="100px"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto65" runat="server" Text="$ UPC" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorUPC" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="100px"></asp:TextBox></td>
                                    <td colspan="2">
                                        <asp:Label ID="lblCcosto66" runat="server" Text="No. autorización (EG)" Visible="False"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtNoAutorizacionEG" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="150px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto68" runat="server" Text="$ Incapacidad (EG)" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorEG" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto93" runat="server" Text="Tipo ID UPC" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlTipoIdUPC" runat="server" CssClass="chzn-select" Visible="False" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto70" runat="server" Text="Salud destino" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSaludDestino" runat="server" CssClass="chzn-select" Visible="False" Width="200px">
                                        </asp:DropDownList>
                                    </td>
                                    <td colspan="2">
                                        <asp:Label ID="lblCcosto67" runat="server" Text="No. autorización (LAM)" Visible="False"></asp:Label>
                                    </td>
                                    <td colspan="2">
                                        <asp:TextBox ID="txtNoAutorizacionLAM" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="150px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto69" runat="server" Text="$ Incapacidad (LAM)" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorLAM" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto94" runat="server" Text="ID UPC" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtIdentificacionUPC" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="100px"></asp:TextBox>
                                    </td>
                                </tr>
                            </table>
                        </fieldset>
                        <fieldset style="border: 1px solid #3366FF; padding: 3px">
                            <legend style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 14px; color: #3366FF; font-weight: bold; text-align: left">Liquidación / ARL </legend>
                            <table style="width: 100%; text-align: left;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto72" runat="server" Text="Administrador ARL" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 220px">
                                        <asp:DropDownList ID="ddlARL" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto19" runat="server" Text="Días ARL" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvDiasARP" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                    <td>
                                        <asp:Label ID="lblCcosto6" runat="server" Text="% ARL" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvpARP" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto2" runat="server" Text="IBC ARL" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 110px">
                                        <asp:TextBox ID="txvIBCArp" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="120px"></asp:TextBox>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td style="width: 110px">&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto73" runat="server" Text="Clase ARL" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 220px">
                                        <asp:DropDownList ID="ddlClaseARL" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                            <asp:ListItem>0</asp:ListItem>
                                            <asp:ListItem>1</asp:ListItem>
                                            <asp:ListItem>2</asp:ListItem>
                                            <asp:ListItem>3</asp:ListItem>
                                            <asp:ListItem>4</asp:ListItem>
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto74" runat="server" Text="Centro trabajo" Visible="False"></asp:Label>
                                    </td>
                                    <td colspan="3">
                                        <asp:DropDownList ID="ddlCentroTrabajo" runat="server" CssClass="chzn-select" Visible="False" Width="300px">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto10" runat="server" Text="$ ARL" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 110px">
                                        <asp:TextBox ID="txvValorARP" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" Visible="False" Width="120px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td style="width: 110px"></td>
                                </tr>
                            </table>
                        </fieldset>

                        <fieldset style="border: 1px solid #3366FF; padding: 3px">
                            <legend style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 14px; color: #3366FF; font-weight: bold; text-align: left">Liquidación / Caja </legend>
                            <table style="width: 100%; text-align: left;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto75" runat="server" Text="Administrador Caja" Visible="False"></asp:Label>
                                    </td>
                                    <td style="width: 220px">
                                        <asp:DropDownList ID="ddlCaja" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto18" runat="server" Text="Días Caja" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvDiasCaja" runat="server" Font-Bold="True" ForeColor="#336699"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                    <td>
                                        <asp:Label ID="lblCcosto7" runat="server" Text="% Caja" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvpCaja" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto3" runat="server" Text="IBC Caja" Visible="False"></asp:Label>
                                    </td>
                                    <td class="width: 100px">
                                        <asp:TextBox ID="txvIBCCaja" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto11" runat="server" Text="$ Caja" Visible="False"></asp:Label>
                                    </td>
                                    <td class="width: 100px">
                                        <asp:TextBox ID="txvValorCaja" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="100px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto78" runat="server" Text="IBC Caja otros Paraf." Visible="False"></asp:Label>
                                    </td>
                                    <td class="width: 100px">
                                        <asp:TextBox ID="txvValorOtrosParafiscales" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="100px"></asp:TextBox>
                                    </td>
                                </tr>

                            </table>
                        </fieldset>
                        <fieldset style="border: 1px solid #3366FF; padding: 3px">
                            <legend style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 14px; color: #3366FF; font-weight: bold; text-align: left">Liquidación / Parefiscales </legend>
                            <table style="width: 100%; text-align: left;">
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto76" runat="server" Text="Administrador Sena" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlSena" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto80" runat="server" Text="% Sena" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvpSena" runat="server" Font-Bold="True" ForeColor="#336699"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                    <td>
                                        <asp:Label ID="lblCcosto13" runat="server" Text="Valor Sena" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorSena" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                    </td>
                                    <td>
                                        <asp:CheckBox ID="chkExoneraSalud" runat="server" Text="Exonera salud" Visible="False" />
                                    </td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto77" runat="server" Text="Administrador ICBF" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlICBF" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto81" runat="server" Text="% ICBF" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvpICBF" runat="server" Font-Bold="True" ForeColor="#336699"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                    <td>
                                        <asp:Label ID="lblCcosto14" runat="server" Text="Valor ICBF" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorICBF" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto82" runat="server" Text="Administrador ESAP" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlESAP" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto84" runat="server" Text="% ESAP" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvpESAP" runat="server" Font-Bold="True" ForeColor="#336699"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                    <td>
                                        <asp:Label ID="lblCcosto86" runat="server" Text="Valor ESAP" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorESAP" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                    </td>
                                    <td>&nbsp;</td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="lblCcosto83" runat="server" Text="Administrador MEN" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlMEN" runat="server" Width="200px" CssClass="chzn-select" Visible="False">
                                        </asp:DropDownList>
                                    </td>
                                    <td>
                                        <asp:Label ID="lblCcosto85" runat="server" Text="% MEN" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvpMEN" runat="server" Font-Bold="True" ForeColor="#336699"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                    <td>
                                        <asp:Label ID="lblCcosto87" runat="server" Text="Valor MEN" Visible="False"></asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txvValorMEN" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)"
                                            Visible="False" CssClass="input" AutoPostBack="True" Width="120px"></asp:TextBox>
                                    </td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </table>

                        </fieldset>
                    </div>
                </asp:Panel>
            </div>
            <div style="margin: 5px; padding: 10px; overflow-x: scroll; width: 1250px; display: inline-block;">
                <asp:GridView ID="gvLista" runat="server" GridLines="None" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AllowPaging="True" PageSize="50" OnPageIndexChanging="gvLista_PageIndexChanging" AutoGenerateColumns="False" Width="1200px" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
                    <AlternatingRowStyle CssClass="alt" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
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
                        <asp:BoundField DataField="año" HeaderText="Año">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="mes" HeaderText="Mes">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="registro" HeaderText="No.">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="idTercero" HeaderText="IdEmp">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="codigoTercero" HeaderText="Identif">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="apellido1" HeaderText="PApellido">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="apellido2" HeaderText="SApellido">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="nombre1" HeaderText="PNombre">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="nombre2" HeaderText="SNombre">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IBCpension" HeaderText="IBCpension">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                             <asp:BoundField DataField="dpension" HeaderText="dpension">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                         <asp:BoundField DataField="valorPension" HeaderText="vPension">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IBCSalud" HeaderText="IBCSalud">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                         <asp:BoundField DataField="dSalud" HeaderText="dSalud">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                         <asp:BoundField DataField="valorSalud" HeaderText="vSalud">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IBCarl" HeaderText="IBCarl">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                         <asp:BoundField DataField="darl" HeaderText="darl">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"  Width="5px" />
                        </asp:BoundField>
                         <asp:BoundField DataField="valorArl" HeaderText="vARL">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IBCcaja" HeaderText="IBCcaja">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dcaja" HeaderText="dcaja">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                         <asp:BoundField DataField="valorcaja" HeaderText="vCaja">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>

                        <asp:BoundField DataField="ING" HeaderText="ING">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="RET" HeaderText="RET">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TDE" HeaderText="TDE">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TAE" HeaderText="TAE">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TDP" HeaderText="TDP">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="TAP" HeaderText="TAP">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VSP" HeaderText="VSP">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VST" HeaderText="VST">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="SLN" HeaderText="SLN">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IGE" HeaderText="IGE">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="LMA" HeaderText="LMA">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VAC" HeaderText="VAC">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="AVP" HeaderText="AVP">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="VCT" HeaderText="VCT">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="IRL" HeaderText="IRP">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                        </asp:BoundField>
                    </Columns>
                    <PagerStyle CssClass="pgr" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                    <RowStyle CssClass="rw" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                </asp:GridView>
            </div>
        </div>
    </form>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
</body>
</html>
