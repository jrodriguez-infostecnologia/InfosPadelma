<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Conceptos.aspx.cs" Inherits="Nomina_Padministracion_Conceptos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />

</head>

<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: left;">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                        <script type="text/javascript">
                            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
                            function endReq(sender, args) {
                                $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true });
                            }
                        </script>
                    </td>
                    <td style="width: 100px; height: 25px; text-align: left">Busqueda</td>
                    <td style="width: 350px; height: 25px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: right; background-position-x: right;"></td>
                </tr>
                <tr>
                    <td colspan="4" style="width: 940px; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;">
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
            <div>
                <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
            </div>


            <asp:UpdatePanel ID="upCabeza" runat="server" UpdateMode="Conditional" Visible="False">
                <ContentTemplate>
                    <div style="padding: 5px 15px 5px 15px">
                        <div style="border: 1px solid silver; display: inline-block; ">
                            <div style="padding: 2px 5px 2px 5px">
                                <table cellspacing="0" style="width: 940px;" id="TABLE1">
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label1" runat="server" Text="Código" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="200px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input" MaxLength="20"></asp:TextBox>
                                        </td>
                                        <td style="text-align: left" colspan="2">
                                            <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                                            <asp:CheckBox ID="chkConceptoFijo" runat="server" Text="Concepto fijo" Visible="False" />
                                            <asp:CheckBox ID="chkControlaSaldo" runat="server" Text="Controla saldo" Visible="False" />
                                            <asp:CheckBox ID="chkConceptoAusentismo" runat="server" Text="Concepto Ausentismo" Visible="False" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label2" runat="server" Text="Descripción" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtDescripcion" runat="server" Visible="False" Width="350px" CssClass="input"></asp:TextBox></td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label7" runat="server" Text="Abreviatura" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtAbreviatura" runat="server" Visible="False" Width="250px" CssClass="input" MaxLength="20"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label6" runat="server" Text="Naturaleza" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlSigno" runat="server" Visible="False" Width="150px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                <asp:ListItem Value="0">No aplica</asp:ListItem>
                                                <asp:ListItem Value="1">Devengado</asp:ListItem>
                                                <asp:ListItem Value="2">Deducido</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label8" runat="server" Text="Tipo liquidación" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlTipoLiquidacion" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                <asp:ListItem Value="1">Horas</asp:ListItem>
                                                <asp:ListItem Value="2">Días</asp:ListItem>
                                                <asp:ListItem Value="3">Valor fijo</asp:ListItem>
                                                <asp:ListItem Value="4">Calculado</asp:ListItem>
                                                <asp:ListItem Value="5">Fijo periodo</asp:ListItem>
                                                <asp:ListItem Value="6">Fijo mes</asp:ListItem>
                                                <asp:ListItem Value="7">Valor unidad</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:CheckBox ID="chkManejaBase" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaBase_CheckedChanged" Text="Maneja Base" Visible="False" />
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlConceptoBase" runat="server" Visible="False" Width="350px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:CheckBox ID="chkValidaPorcentaje" runat="server" AutoPostBack="True" OnCheckedChanged="chkValidaPorcentaje_CheckedChanged" Text="Porcentaje" Visible="False" />
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvPorcentaje" runat="server" Visible="False" Width="200px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label4" runat="server" Text="Valor" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvValor" runat="server" Visible="False" Width="200px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox></td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label11" runat="server" Text="Valor minimo" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvValorMinimo" runat="server" Visible="False" Width="200px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label10" runat="server" Text="Control concepto" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlControlConcepto" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                                <asp:ListItem Value="0">No aplica</asp:ListItem>
                                                <asp:ListItem Value="1">Suma a sueldo</asp:ListItem>
                                                <asp:ListItem Value="2">Resta de sueldo</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                        <td style="text-align: left; width: 130px;">
                                            <asp:Label ID="Label13" runat="server" Text="Prioridad" ToolTip="Prioridades para los descuentos, el orden que deben ser descontados" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvPrioridad" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" ToolTip="Prioridades para los descuentos, el orden que deben ser descontados" Visible="False" Width="100px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label14" runat="server" Text="No. veces en mes" ToolTip="Prioridades para los descuentos, el orden que deben ser descontados" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvNoMes" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" ToolTip="Prioridades para los descuentos, el orden que deben ser descontados" Visible="False" Width="100px"></asp:TextBox>
                                        </td>
                                        <td style="text-align: left; width: 130px;">&nbsp;</td>
                                        <td class="Campos">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: center" colspan="4">
                                            <asp:CheckBox ID="chkIngresoGravado" runat="server" Text="Ingreso gravado" Visible="False" />
                                            <asp:CheckBox ID="chkManejaRango" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaRango_CheckedChanged" Text="Maneja tabla rango" Visible="False" />
                                            <asp:CheckBox ID="chkDescuentaDomingo" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaRango_CheckedChanged" Text="Descuenta domingo" Visible="False" />
                                            <asp:CheckBox ID="chkDescuentaTranporte" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaRango_CheckedChanged" Text="Descuenta transporte" Visible="False" />
                                            <asp:CheckBox ID="chkMostrarFecha" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaRango_CheckedChanged" Text="Mostrar fecha desprendible" Visible="False" />
                                            <asp:CheckBox ID="chkMostrarCantidad" runat="server" Text="No mostrar cantidad desprendible" Visible="False" />
                                            <br />
                                            <asp:CheckBox ID="chkMostrarDetalle" runat="server" Text="Mostrar detalle desprendible" Visible="False" />
                                            <asp:CheckBox ID="chkNoMostraDesprendible" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaRango_CheckedChanged" Text="No mostrar en desprendible" Visible="False" />
                                            <asp:CheckBox ID="chkLiquiddacionNomina" runat="server" Text="No liquida con nomina" Visible="False" />
                                            <asp:CheckBox ID="chkPrestacionSocial" runat="server" Text="Concepto prestaciones social" Visible="False" />
                                            <asp:CheckBox ID="chkSumaPrestacionSocial" runat="server" Text="Suma día prestaciones sociales" Visible="False" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            &nbsp;</td>
                                        <td class="Campos">
                                            &nbsp;</td>
                                        <td colspan="2" style="text-align: left">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left" colspan="4">

                                            <div>
                                                <fieldset>
                                                    <legend>Base de conceptos</legend>
                                                    <div style="padding: 10px">
                                                        <asp:CheckBox ID="chkBaseCensancias" runat="server" Text="Base cesantias" Visible="False" />
                                                        <asp:CheckBox ID="chkBaseIntereses" runat="server" Text="Base intereses cesantias" Visible="False" />
                                                        <asp:CheckBox ID="chkBasePrimas" runat="server" Text="Base primas" Visible="False" />
                                                        <asp:CheckBox ID="chkBaseVaciones" runat="server" Text="Base Vacaciones" Visible="False" />
                                                        <asp:CheckBox ID="chkBaseCaja" runat="server" Text="Base caja compensación" Visible="False" />
                                                        <asp:CheckBox ID="chkBaseSeguridad" runat="server" Text="Base seguridad Social" Visible="False" />
                                                        <asp:CheckBox ID="chkBaseEmbargo" runat="server" Text="Base embargos" Visible="False" />
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left" colspan="4">
                                            <asp:UpdatePanel ID="upRango" runat="server" UpdateMode="Conditional" Visible="False">
                                                <ContentTemplate>
                                                    <div>
                                                        <fieldset>
                                                            <legend>Rango por concepto</legend>
                                                            <div style="padding: 10px">
                                                                <table cellpadding="0" cellspacing="0" style="width: 850px">
                                                                    <tr>
                                                                        <td style="width: 100px; text-align: left">
                                                                            <asp:Label ID="Label12" runat="server" Text="Rango final" Visible="False"></asp:Label></td>
                                                                        <td style="width: 250px">
                                                                            <asp:TextBox ID="txvRangoFinal" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="150px"></asp:TextBox>
                                                                        </td>
                                                                        <td>
                                                                            <asp:ImageButton ID="btnCargar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="btnCargar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" />

                                                                        </td>
                                                                        <td style="width: 400px"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="width: 100px; text-align: left">
                                                                            <asp:CheckBox ID="chkPorcentajeRango" runat="server" Text="Procentaje" />
                                                                        </td>
                                                                        <td style="width: 150px; text-align: left">
                                                                            <asp:TextBox ID="txvValorRango" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="150px"></asp:TextBox>

                                                                        </td>
                                                                        <td></td>
                                                                        <td></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" style="text-align: center; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;">
                                                                            <asp:Label ID="nilblMensajeRango" runat="server"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: left" colspan="4">
                                                                            <div style="text-align: center">
                                                                                <div style="display: inline-block">
                                                                                    <asp:GridView ID="gvRangosConcepto" runat="server" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvCanal_RowDeleting" PageSize="30" Width="800px" Visible="False">
                                                                                        <AlternatingRowStyle CssClass="alt" />
                                                                                        <Columns>
                                                                                            <asp:TemplateField HeaderText="Elim">
                                                                                                <ItemTemplate>
                                                                                                    <asp:ImageButton ID="imEliminaCanal" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" ToolTip="Elimina el registro seleccionado" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                                            </asp:TemplateField>

                                                                                            <asp:BoundField DataField="numero" HeaderText="No." ReadOnly="True">
                                                                                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="rInicio" HeaderText="Rango Inicial" ReadOnly="True">
                                                                                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:BoundField DataField="rFinal" HeaderText="Rango Final" ReadOnly="True">
                                                                                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                                            </asp:BoundField>
                                                                                            <asp:TemplateField HeaderText="Porcentaje">
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txvPorRango" runat="server" onkeyup="formato_numero(this)" Text='<%# Eval("porcentaje") %>' CssClass="input" Width="80px"></asp:TextBox>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="100px" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="Valor">
                                                                                                <ItemTemplate>
                                                                                                    <asp:TextBox ID="txvValorRango" runat="server" onkeyup="formato_numero(this)" Text='<%# Eval("valor") %>' CssClass="input" Width="150px"></asp:TextBox>
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="160px" />
                                                                                            </asp:TemplateField>
                                                                                            <asp:TemplateField HeaderText="%">
                                                                                                <ItemTemplate>
                                                                                                    <asp:CheckBox ID="chkPorRango" runat="server" Checked='<%# Eval("por") %>' Enabled="False" />
                                                                                                </ItemTemplate>
                                                                                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                                                                                            </asp:TemplateField>

                                                                                        </Columns>
                                                                                        <PagerStyle CssClass="pgr" />
                                                                                        <RowStyle CssClass="rw" />
                                                                                    </asp:GridView>
                                                                                </div>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                        </fieldset>
                                                    </div>
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="chkManejaRango" EventName="CheckedChanged" />
                    <asp:AsyncPostBackTrigger ControlID="txtCodigo" EventName="TextChanged" />
                </Triggers>
            </asp:UpdatePanel>
            <div>
                <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
            </div>
            <div>
                <div style="margin: 5px; padding: 10px; overflow-x: scroll; width: 900px;">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="1200px" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging1">
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
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" ReadOnly="True"
                                SortExpression="descripcion">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="abreviatura" HeaderText="Abreviatura" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="signo" HeaderText="Signo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipoLiquidacion" HeaderText="tipoLiqui" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="base" HeaderText="Base" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="valor" HeaderText="Valor" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="valorMinimo" HeaderText="VlrMinimo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="basePrimas" HeaderText="BP">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="baseCajaCompensacion" HeaderText="BCC">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="baseCesantias" HeaderText="BC">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="baseVacaciones" HeaderText="BV">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="baseIntereses" HeaderText="BI">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="baseSeguridadSocial" HeaderText="BS">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="controlaSaldo" HeaderText="CS">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="manejaRango" HeaderText="MR">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="ingresoGravado" HeaderText="IG">
                                <ItemStyle HorizontalAlign="Center" Width="20px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="controlConcepto" HeaderText="CC" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                               <asp:BoundField DataField="porcentaje" HeaderText="%" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                               <asp:CheckBoxField DataField="validaPorcentaje" HeaderText="v%">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                             <asp:CheckBoxField DataField="fijo" HeaderText="fijo">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="baseEmbargo" HeaderText="BE">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                               <asp:BoundField DataField="prioridad" HeaderText="Prio" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="descuentaDomingo" HeaderText="DD">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="descuentaTransporte" HeaderText="DT">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="mostrarFecha" HeaderText="MF">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="noMostrar" HeaderText="NM">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="mostrarDetalle" HeaderText="MD">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="ausentismo" HeaderText="AUS">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="prestacionSocial" HeaderText="PS">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="sumaPrestacionSocial" HeaderText="SDPS">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="mostrarCantidad" HeaderText="MCan">
                                <ItemStyle HorizontalAlign="Center" Width="10px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="noMes" HeaderText="NM" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>

                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>
            </div>
</div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>

    </form>
</body>
</html>

