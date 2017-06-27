<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ModificacionPrimas.aspx.cs" Inherits="Nomina_Pliquidacion_ModificacionPrimas" %>

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

    <script type="text/javascript" src="../../js/lib/jquery/dist/jquery.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui1.8.10.min.js"></script>
    <script type="text/javascript" src="../../js/plugins/localisation/jquery.localisation-min.js"></script>
    <script type="text/javascript" src="../../js/plugins/scrollTo/jquery.scrollTo-min.js"></script>
    <script type="text/javascript" src="../../js/ui.multiselect.js"></script>
    <script type="text/javascript" src="../../js/Liquidación/ModificacionLiquidacion.js"></script>
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
                    <td>Modificación de liquidación de primas
                        <div>
                            <asp:Label ID="successMessage" runat="server" ForeColor="Green" Font-Bold="true"></asp:Label>
                            <asp:Label ID="failMessage" runat="server" ForeColor="Red" Font-Bold="true"></asp:Label>
                        </div>
                    </td>
                </tr>
            </table>
            <hr />
            <table cellspacing="0" style="width: 100%;" id="Table2">
                <tr>
                    <td colspan="6"></td>
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
                        <asp:DropDownList ID="ddlTipoDocumento" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" AutoPostBack="true" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left; width: 150px;">
                        <asp:Label ID="lblEmpleado0" runat="server" Text="Número documento"></asp:Label>
                    </td>
                    <td style="text-align: left">
                        <asp:DropDownList ID="ddlNumeroDocumento" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="320px" AutoPostBack="true" OnSelectedIndexChanged="ddlNumeroDocumento_SelectedIndexChanged">
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
                        <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" AutoPostBack="True" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged">
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
                        <asp:DropDownList ID="ddlContratos" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px" AutoPostBack="true" OnSelectedIndexChanged="ddlContratos_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr runat="server" id="detailLoadedPanel">
                    <td style="width: 20px"></td>
                    <td style="width: 100px; text-align: left;">
                        <asp:Label ID="lblConcepto" runat="server" Text="Concepto"></asp:Label>
                    </td>
                    <td style="width: 350px; text-align: left;">
                        <asp:DropDownList ID="ddlConcepto" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px"></asp:DropDownList>
                        <asp:Label ID="ddlConceptoVal" runat="server" ForeColor="Red"></asp:Label>
                    </td>
                    <td style="text-align: center;" colspan="2">
                        <asp:ImageButton ID="btnCargar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" ToolTip="Preliquidar documento" Style="height: 21px" OnClick="btnCargar_Click" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" OnClick="lbCancelar_Click" />
                        <asp:ImageButton ID="btnGuardar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClientClick="if(!confirm('Desea guardar los cambios ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guardar Cambios" OnClick="btnGuardar_Click" />
                    </td>
                </tr>
                <tr>
                    <td class="auto-style2"></td>
                    <td colspan="4" style="text-align: center;" class="auto-style3">
                        <div style="text-align: center">
                            <div style="display: inline-block" id="detalleLiqidacion" runat="server">
                                <asp:GridView ID="gvDetalleLiquidacion" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" RowHeaderColumn="cuenta" OnRowDeleting="gvDetalleLiquidacion_RowDeleting" Width="800px">
                                    <AlternatingRowStyle CssClass="alt" />
                                    <Columns>
                                        <asp:BoundField DataField="CodigoTercero" HeaderText="Cod.">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="IdentificacionTercero" HeaderText="Indent.">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="NombreTercero" HeaderText="Nombre">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaIngeso" HeaderText="Fecha Ingreso">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaInicial" HeaderText="Fecha Inicial">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="FechaFinal" HeaderText="Fecha Final">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="Basico" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvBasico" runat="server" ClientIDMode="Static" CssClass="input" Text='<%#Eval("Basico") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transporte" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvTransporte" runat="server" ClientIDMode="Static" CssClass="input" Text='<%#Eval("Transporte") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Valor Promedio" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvValorPromedio" runat="server" ClientIDMode="Static" CssClass="input" Text='<%#Eval("ValorPromedio") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Base" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvBase" runat="server" ClientIDMode="Static" CssClass="input" Text='<%#Eval("Base") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dias Promedio" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvDiasPromedio" runat="server" ClientIDMode="Static" CssClass="input" Text='<%#Eval("DiasPromedio") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Dias Prima" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvDiasPrima" runat="server" ClientIDMode="Static" CssClass="input" Text='<%#Eval("DiasPrima") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Valor Prima" ItemStyle-HorizontalAlign="Right">
                                            <ItemTemplate>
                                                <asp:TextBox ID="txvValorPrima" runat="server" ClientIDMode="Static" CssClass="input" Text='<%#Eval("ValorPrima") %>' Width="80%">0</asp:TextBox>
                                            </ItemTemplate>
                                            <ItemStyle CssClass="Items" Width="90px" />
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
            </table>
            <hr />
        </div>
    </form>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
</body>
</html>
