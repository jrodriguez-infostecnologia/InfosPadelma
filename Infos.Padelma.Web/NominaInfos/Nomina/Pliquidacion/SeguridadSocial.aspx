<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SeguridadSocial.aspx.cs" Inherits="Agronomico_Padministracion_Liquidacion" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="width: 120px"></td>
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
                    <td style="width: 120px"></td>
                </tr>
                <tr>
                    <td colspan="8">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="niimbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="lbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                        <asp:ImageButton ID="nibtnLiquidar" runat="server" ImageUrl="~/Imagen/Bonotes/btnLiquidar.png" OnClick="btnLiquidar_Click" OnClientClick="if(!confirm('Desea liquidar el periodo de Seguridad Social ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnLiquidar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnLiquidarN.png'" ToolTip="Liquidar Seguridad Social" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                        <asp:ImageButton ID="nibtnGenerarPlano" runat="server" ImageUrl="~/Imagen/Bonotes/btnGeneraPlano.png" OnClick="nibtnGenerarPlano_Click" onmouseout="this.src='../../Imagen/Bonotes/btnGeneraPlano.png'" 
                            onmouseover="this.src='../../Imagen/Bonotes/btnGeneraPlanoN.png'" ToolTip="General plano seguridad social" />

                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 1000px; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;" id="Table2">
                <tr>
                    <td colspan="6" style="border-top-style: solid; border-top-width: 1px; border-color: silver">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="width: 110px; text-align: left;">
                        <asp:Label ID="lblaño" runat="server" Text="Año / Mes" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos" style="vertical-align: top">
                        <table cellpadding="0" cellspacing="0" class="ui-accordion">
                            <tr>
                                <td style="width: 75px">
                        <asp:TextBox ID="txvAño" runat="server" CssClass="input" ToolTip="Escriba el texto para la busqueda" Width="70px" MaxLength="4" Visible="False"></asp:TextBox>
                                </td>
                                <td>
                        <asp:DropDownList ID="ddlMes" runat="server" Width="100px" CssClass="chzn-select" Visible="False">
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
                                <td>
                        <asp:Label ID="lbRegistro" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 120px; text-align: left;">
                        <asp:Label ID="lblOpcionLiquidacion" runat="server" Text="Trabajador" Visible="False"></asp:Label>
                    </td>
                    <td style="width: 300px; text-align: left;">
                        <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 80px"></td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="text-align: left;" colspan="4">
                        <table cellpadding="0" cellspacing="0" class="ui-accordion">
                            <tr>
                                <td>
                                    <asp:Label ID="lblCcosto0" runat="server" Text="IBC Salud" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvIBCSalud" runat="server" Font-Bold="True" ForeColor="#336699"  onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="lblCcosto16" runat="server" Text="Días Salud" Visible="False"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txvDiasSalud" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblCcosto4" runat="server" Text="% Salud" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvpSalud" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                <td colspan="2">
                                    <asp:Label ID="lblCcosto8" runat="server" Text="Valor Salud" Visible="False"></asp:Label>
                                </td>
                                <td class="chzn-rtl">
                                    <asp:TextBox ID="txvValorSalud" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCcosto1" runat="server" Text="IBC Pensión" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvIBCPension" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="lblCcosto17" runat="server" Text="Días Pensión" Visible="False"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txvDiasPension" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblCcosto5" runat="server" Text="% Pensión" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvpPension" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                <td colspan="2">
                                    <asp:Label ID="lblCcosto9" runat="server" Text="Valor Pensión" Visible="False"></asp:Label>
                                </td>
                                <td class="chzn-rtl">
                                    <asp:TextBox ID="txvValorPension" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCcosto12" runat="server" Text="Fondo Solidaridad" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvValorFondo1" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox></td>
                                <td style="width: 80px">
                                    <asp:Label ID="lblCcosto21" runat="server" Text="% Fondo " Visible="False"></asp:Label>
                                </td>
                                <td style="width: 50px">
                                    <asp:TextBox ID="txvpFondo" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                    &nbsp;</td>
                                <td colspan="2">
                                    <asp:Label ID="lblCcosto15" runat="server" Text="Fondo Solidaridad Subsidiado" Visible="False"></asp:Label>
                                </td>
                                <td colspan="2" class="chzn-rtl">
                                    <asp:TextBox ID="txvValorFondo2" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCcosto3" runat="server" Text="IBC Caja" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvIBCCaja" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblCcosto18" runat="server" Text="Días Caja" Visible="False"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txvDiasCaja" runat="server" Font-Bold="True" ForeColor="#336699"
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="lblCcosto7" runat="server" Text="% Caja" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvpCaja" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="lblCcosto11" runat="server" Text="Valor Caja" Visible="False"></asp:Label>
                                </td>
                                <td class="chzn-rtl">
                                    <asp:TextBox ID="txvValorCaja" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCcosto2" runat="server" Text="IBC ARP" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvIBCArp" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                </td>
                                <td>
                                    <asp:Label ID="lblCcosto19" runat="server" Text="Días ARP" Visible="False"></asp:Label>
                                </td>
                                <td colspan="2">
                                    <asp:TextBox ID="txvDiasARP" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                <td>
                                    <asp:Label ID="lblCcosto6" runat="server" Text="% ARP" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvpARP" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox>
                                </td>
                                <td colspan="2">
                                    <asp:Label ID="lblCcosto10" runat="server" Text="Valor ARP" Visible="False"></asp:Label>
                                </td>
                                <td class="chzn-rtl">
                                    <asp:TextBox ID="txvValorARP" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCcosto14" runat="server" Text="Valor ICBF" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvValorICBF" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                </td>
                                <td colspan="4">
                                    <asp:Label ID="lblCcosto13" runat="server" Text="Valor Sena" Visible="False"></asp:Label>
                                </td>
                                <td colspan="4">
                                    <asp:TextBox ID="txvValorSena" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="150px"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:Label ID="lblCcosto20" runat="server" Text="Días IRP" Visible="False"></asp:Label>
                                </td>
                                <td>
                                    <asp:TextBox ID="txvIRP" runat="server" Font-Bold="True" ForeColor="#336699" onkeyup="formato_numero(this)" 
                                        Visible="False" CssClass="input" AutoPostBack="True" Width="50px"></asp:TextBox></td>
                                <td colspan="4">
                                    <asp:CheckBox ID="chkExoneraSalud" runat="server" Text="Exonera Salud" Visible="False" />
                                </td>
                                <td colspan="4"></td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 80px"></td>
                </tr>
                <tr>
                    <td style="width: 80px"></td>
                    <td style="text-align: center;" colspan="4">
                        <asp:CheckBox ID="chkING" runat="server" Text="ING" Visible="False" />
                        <asp:CheckBox ID="chkRET" runat="server" Text="RET" Visible="False" />
                        <asp:CheckBox ID="chkTDE" runat="server" Text="TDE" Visible="False" />
                        <asp:CheckBox ID="chkTAE" runat="server" Text="TAE" Visible="False" />
                        <asp:CheckBox ID="chkTDP" runat="server" Text="TDP" Visible="False" />
                        <asp:CheckBox ID="chkTAP" runat="server" Text="TAP" Visible="False" />
                        <asp:CheckBox ID="chkVSP" runat="server" Text="VSP" Visible="False" />
                        <asp:CheckBox ID="chkVTE" runat="server" Text="VTE" Visible="False" />
                        <asp:CheckBox ID="chkVST" runat="server" Text="VST" Visible="False" />
                        <asp:CheckBox ID="chkSLN" runat="server" Text="SLN" Visible="False" />
                        <asp:CheckBox ID="chkIGE" runat="server" Text="IGE" Visible="False" />
                        <asp:CheckBox ID="chkLMA" runat="server" Text="LMA" Visible="False" />
                        <asp:CheckBox ID="chkVAC" runat="server" Text="VAC" Visible="False" />
                        <asp:CheckBox ID="chkAVP" runat="server" Text="AVP" Visible="False" />
                        <asp:CheckBox ID="chkVCT" runat="server" Text="VCT" Visible="False" />
                    </td>
                    <td style="width: 80px"></td>
                </tr>
                <tr>
                    <td style="text-align: center; height: 10px;" colspan="6">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div>
                <div style="margin: 5px; padding: 10px; overflow-x: scroll; width: 950px;">
                    <div style="display: inline-block">
                        <asp:GridView ID="gvLista" runat="server" GridLines="None" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AllowPaging="True" PageSize="50" OnPageIndexChanging="gvLista_PageIndexChanging" AutoGenerateColumns="False" Width="2000px" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
                            <AlternatingRowStyle CssClass="alt" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <Columns>
                                <asp:ButtonField ButtonType="Image" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón" CommandName="Select">
                                    <ItemStyle Width="20px" CssClass="Items" />
                                </asp:ButtonField>

                                <asp:TemplateField HeaderText="Anul">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" />
                                    <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="registro" HeaderText="No.">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="idTercero" HeaderText="IdEmp">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="Identificacion" HeaderText="Identif">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="NombreEmpleado" HeaderText="NombreEmpleado">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="350px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IBCpension" HeaderText="IBCpension">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dPension" HeaderText="dPension">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pPension" HeaderText="pPension">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vPension" HeaderText="vPension">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vFondo" HeaderText="vFondo">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vFondoSub" HeaderText="vFondoSub">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IBCSalud" HeaderText="IBCSalud">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dSalud" HeaderText="dSalud">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pSalud" HeaderText="pSalud">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vSalud" HeaderText="vSalud">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IBCarl" HeaderText="IBCarl">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dArp" HeaderText="dArp">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pArp" HeaderText="pArp">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="valorArp" HeaderText="valorArp">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="IBCcaja" HeaderText="IBCcaja">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dCaja" HeaderText="dCaja">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pCaja" HeaderText="pCaja">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vCaja" HeaderText="vCaja">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vSena" HeaderText="vSena">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="vIcbf" HeaderText="vIcbf">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
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
                                <asp:BoundField DataField="VTE" HeaderText="VTE">
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
                                <asp:BoundField DataField="IRP" HeaderText="IRP">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="ExS" HeaderText="ExS">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="pFondo" HeaderText="pFondo">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="año" HeaderText="Año">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="mes" HeaderText="Mes">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                </asp:BoundField>

                            </Columns>
                            <PagerStyle CssClass="pgr" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <RowStyle CssClass="rw" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </form>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
</body>
</html>
