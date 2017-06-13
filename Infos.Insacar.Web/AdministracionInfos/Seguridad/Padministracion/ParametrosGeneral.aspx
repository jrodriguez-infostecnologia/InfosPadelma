<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ParametrosGeneral.aspx.cs" Inherits="Nomina_Paminidtracion_ParametrosGeneral" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />

</head>
<body class="principalBody">
    <form id="form1" runat="server">
    <div class="principal">
            <table cellspacing="0" style="width: 950px">
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

            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td style="width: 900px">
                        <div style="padding: 5px; text-align: center">
                            <div style="border: 1px solid silver; padding: 8px; display: inline-block;">
                                  <div>
                                    <fieldset>
                                        <legend>Parametros de transacciones</legend>
                                        <div style="width: 900px">
                                            <div style="padding: 8px; display: inline-block; width: 850px;">
                                                <fieldset style="width: 750px">
                                                    <legend>Transacciones </legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    &nbsp;</td>
                                                                <td style="text-align: center">
                                                                    <asp:Label ID="Label90" runat="server" Text="Principal"></asp:Label>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <asp:Label ID="Label81" runat="server" Text="Alterno"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label31" runat="server" Text="Entradas"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlEntradas" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlEntradasAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label1" runat="server" Text="Salidas"></asp:Label>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSalidas" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlSalidasAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label2" runat="server" Text="Pesajes"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlPesajes" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlPesajesAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label91" runat="server" Text="Anulado"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAnulado" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAnuladoAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div style="padding: 8px; display: inline-block; width: 850px;">
                                                <fieldset style="width: 750px">
                                                    <legend>Materia Prima </legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    &nbsp;</td>
                                                                <td style="font-size: 11px; width: 270px; text-align: center;">
                                                                    <asp:Label ID="Label82" runat="server" Text="Principal"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: center">
                                                                    <asp:Label ID="Label83" runat="server" Text="Alterno"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label32" runat="server" Text="Fruta de palma africana"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlFrutaPalma" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlFrutaPalmaAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label69" runat="server" Text="Almendra palma africana"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlAlmendra" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAlmendraAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label70" runat="server" Text="Nuez palma africana"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlNuez" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlNuezAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div style="padding: 8px; display: inline-block; width: 850px;">
                                                <fieldset style="width: 750px">
                                                    <legend>Productos</legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    &nbsp;</td>
                                                                <td style="font-size: 11px; width: 270px; text-align: center;">
                                                                    <asp:Label ID="Label84" runat="server" Text="Principal"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: center">
                                                                    <asp:Label ID="Label85" runat="server" Text="Alterno"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label71" runat="server" Text="Aceite crudo palma"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlAceitePalma" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAceitePalmaAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label72" runat="server" Text="Aceite crudo palmiste"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlAceiteCrudoPalmiste" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAceiteCrudoPalmisteAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label73" runat="server" Text="Aceite de palmiste blanqueado"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlAceitePalmisteBlanqueado" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAceitePalmisteBlanqueadoAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div style="padding: 8px; display: inline-block; width: 850px;">
                                                <fieldset style="width: 750px">
                                                    <legend>Subproductos</legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    &nbsp;</td>
                                                                <td style="font-size: 11px; width: 270px; text-align: center;">
                                                                    <asp:Label ID="Label86" runat="server" Text="Principal"></asp:Label>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: center">
                                                                    <asp:Label ID="Label87" runat="server" Text="Alterno"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label74" runat="server" Text="Cascarilla"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlCascarilla" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlCascarillaAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label75" runat="server" Text="Torta de palmiste"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlTorta" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlTortaAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label76" runat="server" Text="Raquis"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlRaquiz" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlRaquizAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label77" runat="server" Text="Raquis prensado"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlRaquizPrensado" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlRaquizPrensadoAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label78" runat="server" Text="Fibra"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlFibra" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlFibraAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            <div style="padding: 8px; display: inline-block; width: 850px;">
                                                <fieldset style="width: 750px">
                                                    <legend>Análisis predeterminados </legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    &nbsp;</td>
                                                                <td style="font-size: 11px; width: 270px; text-align: center;">
                                                                    <asp:Label ID="Label92" runat="server" Text="Principal"></asp:Label>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <asp:Label ID="Label93" runat="server" Text="Alterno"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label97" runat="server" Text="Fruta dura"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlFrutaDura" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlFrutaDuraAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label98" runat="server" Text="Fruta tenera"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlFrutaTenera" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlFrutaTeneraAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label94" runat="server" Text="AGL"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlAGL" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlAGLAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label95" runat="server" Text="Humedad"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlH" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlHAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label96" runat="server" Text="Impurezas"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlI" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlIAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            </table>
                                                    </div>
                                                </fieldset>
                                            </div>
                                            
                                            <div style="padding: 8px; display: inline-block; width: 850px;">
                                                <fieldset style="width: 750px">
                                                    <legend>Formatos de impresión </legend>
                                                    <div style="padding: 5px">
                                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    &nbsp;</td>
                                                                <td style="font-size: 11px; width: 270px; text-align: center;">
                                                                    <asp:Label ID="Label88" runat="server" Text="Principal"></asp:Label>
                                                                </td>
                                                                <td style="text-align: center">
                                                                    <asp:Label ID="Label89" runat="server" Text="Alterno"></asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label4" runat="server" Text="Tiquete"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlTiquete" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td style="text-align: left">
                                                                    <asp:DropDownList ID="ddlTiqueteAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label34" runat="server" Text="Orden Envio"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlOrdenEnvio" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlOrdenEnvioAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label35" runat="server" Text="Remisión comercializadora"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlRemComer" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlRemComerAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label36" runat="server" Text="Remisión interna"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlRemInterna" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlRemInternaAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:Label ID="Label79" runat="server" Text="Orden de salida"></asp:Label>
                                                                </td>
                                                                <td style="font-size: 11px; width: 270px; text-align: left;">
                                                                    <asp:DropDownList ID="ddlOrdenSalida" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="nombreCampos" style="text-align: left">
                                                                    <asp:DropDownList ID="ddlOrdenSalidaAlt" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="280px">
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
                                    &nbsp;</div>
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
