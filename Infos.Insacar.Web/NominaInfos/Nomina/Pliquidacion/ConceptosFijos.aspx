<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ConceptosFijos.aspx.cs" Inherits="Agronomico_Padministracion_ConceptosFijos" %>

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
            // $('#switcher').themeswitcher();
        });
    </script>


    <%-- Este es el estilo de combobox --%>

    <link href="../../css/chosen.css" rel="stylesheet" />


    <%-- Aqui termina el estilo es el estilo de combobox --%>

    <script charset="utf-8" type="text/javascript">
        var contador = 0;
    </script>



</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" CssClass="input" ToolTip="Escriba el texto para la busqueda" Width="350px"></asp:TextBox>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="niimbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" OnClick="lbNuevo_Click" onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" ToolTip="Habilita el formulario para un nuevo registro" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Guarda el nuevo registro en la base de datos" Visible="False" />
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 100%; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;" id="Table2">
                <tr>
                    <td colspan="4" style="border-top-style: solid; border-top-width: 1px; border-color: silver">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos"></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label7" runat="server" Text="Centro de costo" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlCentroCosto" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="350px" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlCentroCosto_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label1" runat="server" Text="Año - Mes" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlAño" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Año..." OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" Width="120px" Visible="False">
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlMes" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Mes..." OnSelectedIndexChanged="ddlMes_SelectedIndexChanged" Width="200px" Visible="False">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label10" runat="server" Text="Periodo" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlPeriodo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione un periodo..." Width="350px" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlPeriodo_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label8" runat="server" Text="Forma de pago" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlFomaPago" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="200px" Visible="False">
                            <asp:ListItem Value="0">Fijo</asp:ListItem>
                            <asp:ListItem Value="1">Destajo</asp:ListItem>
                            <asp:ListItem Value="2">Fijo a destajo</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos" colspan="2">
                        <asp:CheckBox ID="chkLnovedades" runat="server" Text="Liquida Novedades +" Visible="False" />
                        <asp:CheckBox ID="chkNovedadesCredito" runat="server" Text="Liquida Novedades -" Visible="False" />
                        <asp:CheckBox ID="chkLembargos" runat="server" Text="Liquida Embargos" Visible="False" />
                        <br />
                        <asp:CheckBox ID="chkLhoras" runat="server" Text="Liquida Horas Control de acceso" Visible="False" />
                        <asp:CheckBox ID="chkLausentismo" runat="server" Text="Liquida Ausentismo" Visible="False" />
                        <asp:CheckBox ID="chkLprestamos" runat="server" Text="Liquida Prestamos" Visible="False" />
                        <br />
                        <asp:CheckBox ID="chkLvacaciones" runat="server" Text="Liquida Vacaciones" Visible="False" />
                        <asp:CheckBox ID="chkLPrimas" runat="server" Text="Liquida Primas" Visible="False" />
                        <asp:CheckBox ID="chkLotros" runat="server" Text="Otros" Visible="False" />
                        <asp:CheckBox ID="chkLFondavi" runat="server" Text="Liquida Fondavi" Visible="False" />
                        <asp:CheckBox ID="chkLiquidaSindicato" runat="server" Text="Liquida Sindicato" Visible="False" />
                        <br />
                        <asp:CheckBox ID="chkLDomingos" runat="server" Text="Liquida Domingos" Visible="False" />
                        <asp:CheckBox ID="chkLFestivos" runat="server" Text="Liquida Festivos" Visible="False" />
                        <asp:CheckBox ID="chkLDomingoCero" runat="server" Text="Liquida Domingos y Festivos en Cero(0)" Visible="False" />
                        <br />
                        <asp:CheckBox ID="chkMuestraDomingo" runat="server" Text="Muestra Domingo" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label9" runat="server" Text="Observación" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="78px" TextMode="MultiLine" Visible="False" Width="350px"></asp:TextBox>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        </td>
                    <td class="bordes"></td>
                </tr>
                <tr>

                    <td colspan="4" style="text-align: center">
                        <div style="display: inline-block">

                            <select runat="server" id="selConceptos" class="multiselect" multiple="true" name="countries[]" visible="False">
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td style="text-align: center; height: 10px;" colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div>
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="1000px" GridLines="None" CssClass="Grid" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="20">
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
                            <asp:BoundField DataField="centrocosto" HeaderText="Codigo cc" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Centro costo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="año" HeaderText="Año" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="mes" HeaderText="Mes" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="noPeriodo" HeaderText="Periodo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="formaPago" HeaderText="fPago" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Observacion" HeaderText="Observación" ReadOnly="True" HtmlEncode="False" HtmlEncodeFormatString="False">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="liquidada" HeaderText="Liq">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="acumulada" HeaderText="Acum">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lNovedades" HeaderText="lNove">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lPresamo" HeaderText="lPres">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lHoras" HeaderText="lHoras">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lVacaciones" HeaderText="lVaca">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lPrimas" HeaderText="lPri">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lAusentismo" HeaderText="lAuse">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lEmbargo" HeaderText="lEmba">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="lOtros" HeaderText="lOtr">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="lNovedadesCredito" HeaderText="LNo -">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="lFondavi" HeaderText="LFon">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="lDomingo" HeaderText="LDom">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="lFestivo" HeaderText="LFes">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="lDomingoCero" HeaderText="LDC">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="mDomingo" HeaderText="MD">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="lSindicato" HeaderText="lSin">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>

            </div>



        </div>

    </form>
    <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
    <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
</body>
</html>
