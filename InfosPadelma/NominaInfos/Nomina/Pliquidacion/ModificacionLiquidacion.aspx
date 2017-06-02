<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModificacionLiquidacion.aspx.cs" Inherits="Agronomico_Padministracion_Liquidacion" %>

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
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe + "&ano=" + ano + "&periodo=" + periodo + "&numero=" + numero;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }

        function VisualizacionContrato(informe, numero) {
            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + screen.availWidth + ", height =" + screen.availHeight + ", top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe + "&numero=" + numero;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }
        function alerta(mensaje) {
            alert(mensaje);
        }
    </script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script charset="utf-8" type="text/javascript">
        var contador = 0;
    </script>

    <style type="text/css">
        .auto-style2 {
            width: 20px;
            height: 150px;
        }
        .auto-style3 {
            height: 150px;
        }
    </style>

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td>Madificacion de liquidación de documentos</td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 100%; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;" id="Table2">
                <tr>
                    <td colspan="6" style="border-top-style: solid; border-top-width: 1px; border-color: silver">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 100px; text-align: left;">
                        <asp:Label ID="lblaño" runat="server" Text="Año"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlAño" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="130px" AutoPostBack="True" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left">
                        <asp:Label ID="lblPeriodo" runat="server" Text="Periodo Nomina"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlPeriodo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="320px" AutoPostBack="True" OnSelectedIndexChanged="ddlPeriodo_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 100px; text-align: left; margin-left: 40px;">
                        <asp:Label ID="lblEmpleado1" runat="server" Text="Tipo documento"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left; width: 150px;">
                        <asp:Label ID="lblEmpleado0" runat="server" Text="Número documento"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlNumeroDocumento" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="320px" OnSelectedIndexChanged="ddlNumeroDocumento_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 100px; text-align: left;">
                        <asp:Label ID="lblEmpleado" runat="server" Text="Empleado"></asp:Label>
                    </td>
                    <td colspan="3" style="text-align: left">
                        <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="600px" AutoPostBack="True" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 100px; text-align: left;">
                        <asp:Label ID="lblEmpleado2" runat="server" Text="Contrato"></asp:Label>
                    </td>
                    <td colspan="3" style="text-align: left">
                        <asp:DropDownList ID="ddlContratos" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px" OnSelectedIndexChanged="ddlContratos_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 100px; text-align: left;">
                        <asp:Label ID="lblConcepto" runat="server" Text="Concepto"></asp:Label>
                    </td>
                    <td colspan="3">
                        <table style="width: 100%; text-align: left;">
                            <tr>
                                <td style="width: 350px">
                                    <asp:DropDownList ID="ddlConcepto" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="320px" AutoPostBack="True" OnSelectedIndexChanged="ddlPeriodo_SelectedIndexChanged">
                                    </asp:DropDownList>
                                </td>
                                <td style="text-align: center;">
                                    <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="niimbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" Style="height: 21px" />
                                    <asp:ImageButton ID="btnCargar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="btnCargar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" ToolTip="Preliquidar documento" Visible="False" Style="height: 21px" />
                                    <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td colspan="4" style="text-align: center;">
                        <table cellpadding="0" cellspacing="0" class="ui-accordion">
                            <tr>
                                <td style="text-align: center;" colspan="3">
                                    <table cellpadding="0" cellspacing="0" class="ui-accordion">
                                        <tr>
                                            <td style="text-align: left; width: 100px;">
                                                <asp:Label ID="lblCantidad" runat="server" Text="Cantidad" Visible="False"></asp:Label>
                                            </td>
                                            <td style="text-align: left; width: 120px;">
                                                <asp:TextBox ID="txvCantidad" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this)" Width="80px">0</asp:TextBox>
                                            </td>
                                            <td style="text-align: left; width: 100px;">
                                                <asp:Label ID="lblValorUnitario" runat="server" Text="Valor Unitario" Visible="False"></asp:Label>
                                            </td>
                                            <td style="text-align: left; width: 170px;">
                                                <asp:TextBox ID="txvValorUnitario" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this)" Width="150px">0</asp:TextBox>
                                            </td>
                                            <td style="text-align: left; width: 100px;">
                                                <asp:Label ID="lblValorTotal" runat="server" Text="Valor Total" Visible="False"></asp:Label>
                                            </td>
                                            <td style="text-align: left">
                                                <asp:TextBox ID="txvValorTotal" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this)" Width="150px">0</asp:TextBox>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right; width: 400px;">
                                    &nbsp;</td>
                                <td style="width: 20px"></td>
                                <td style="text-align: left; width: 400px;">
                                    <asp:ImageButton ID="btnLiquidar" runat="server" ImageUrl="~/Imagen/Bonotes/btnLiquidar.png" OnClick="btnLiquidar_Click" OnClientClick="if(!confirm('Desea liquidar el documento ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnLiquidar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnLiquidarN.png'" ToolTip="Preliquidar documento" Visible="False" />
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td colspan="4" style="text-align: center;"></td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="auto-style2"></td>
                    <td colspan="4" style="text-align: center;" class="auto-style3">
                        <div style="text-align: center">
                            <div style="display: inline-block">
                                <asp:GridView ID="gvDetalleLiquidacion" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" RowHeaderColumn="cuenta" OnRowDeleting="gvSaludPension_RowDeleting" Width="800px">
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
                                        <asp:TemplateField HeaderText="Cantidad">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvCantidad" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="80px">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ValorUnitario">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvValorUnitario" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="80px">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="ValorTotal">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvValorTotal" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="150px">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle CssClass="pgr" />
                                    <RowStyle CssClass="rw" />
                                </asp:GridView>
                            </div>
                        </div>
                    </td>
                    <td class="auto-style2"></td>
                </tr>
                <tr>

                    <td colspan="6" style="text-align: center"></td>
                </tr>
                <tr>
                    <td style="text-align: center; height: 10px;" colspan="6">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </form>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
</body>
</html>
