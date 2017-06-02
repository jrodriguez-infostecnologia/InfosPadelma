<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Incapacidades.aspx.cs" Inherits="Nomina_PLiquidacion_Incapacidades" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script type="text/javascript">
        
            
        function cuotas() {
       
                var valorTotal = 0;
                var noCuota = 0;
                var valorCuita = 0;

                if (document.getElementById("txvCuotas").value != null & document.getElementById("txvValor").value != null) {
                    noCuota = document.getElementById("txvCuotas").value.replace(/\,/g, '');;
                    valorTotal = document.getElementById("txvValor").value.replace(/\,/g, '');;

                    if (parseFloat(noCuota) == 0) {
                        document.getElementById("txvValorCuota").value = 0;
                    }
                    else {

                        document.getElementById("txvValorCuota").value = Math.round(parseFloat(valorTotal) / parseFloat(noCuota));
                        formato_numero(document.getElementById("txvValorCuota"));
                    }
                }
            }


 
        
    </script>

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

                          

                            function BeginRequestHandler(sender, args) {
                                prm.add_beginRequest(BeginRequestHandler);
                                prm.add_endRequest(EndRequestHandler);
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
                        <div style="border: 1px solid silver; display: inline-block;">
                            <div style="padding: 2px 5px 2px 5px">
                                <table cellspacing="0" style="width: 940px;" id="TABLE1">
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label13" runat="server" Text="Empleado" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="320px" AutoPostBack="True" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label1" runat="server" Text="Número" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtCodigo" runat="server" CssClass="input" MaxLength="20" Visible="False" Width="200px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblPeriodoInicial1" runat="server" Text="Concepto" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlConcepto" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="320px" AutoPostBack="True" OnSelectedIndexChanged="ddlEmpleado_SelectedIndexChanged" Visible="False">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblPeriodoInicial0" runat="server" Text="Tipo ausentismo" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlTipoIncapacidad" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblPeriodoInicial" runat="server" Text="Diagnostico" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlDiagnostico" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:CheckBox ID="chkProrroga" runat="server" OnCheckedChanged="chkProrroga_CheckedChanged" Text="Prorroga" />
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlProrroga" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:LinkButton ID="lbFechaInicial" runat="server" OnClick="lbFecha_Click" Style="color: #003366" Visible="False">Fecha inicial</asp:LinkButton>
                                        </td>
                                        <td class="Campos">
                                            <asp:Calendar ID="niCalendarFechaInicial" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged" Visible="False" Width="150px">
                                                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                <SelectorStyle BackColor="#CCCCCC" />
                                                <WeekendDayStyle BackColor="FloralWhite" />
                                                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                <OtherMonthDayStyle ForeColor="Gray" />
                                                <NextPrevStyle VerticalAlign="Bottom" />
                                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                            </asp:Calendar>
                                            <asp:TextBox ID="txtFechaInicial" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Visible="False" AutoPostBack="True" OnTextChanged="txtFechaInicial_TextChanged"></asp:TextBox>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label7" runat="server" Text="No. días" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvNoDias" runat="server" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" OnTextChanged="txvNoDias_TextChanged" Visible="False" Width="100px">0</asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label18" runat="server" Text="Fecha Final" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtFechaFinal" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Visible="False"></asp:TextBox>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label3" runat="server" Text="No documento ref" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtReferencia" runat="server" CssClass="input" Visible="False" Width="200px">0</asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label14" runat="server" Text="Valor novedad" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvValorIncapacidad" runat="server" CssClass="input" Visible="False" Width="200px">0</asp:TextBox>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label15" runat="server" Text="No. días a pagar" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvDiasPagar" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txvDiasPagar_TextChanged" Visible="False" Width="100px">0</asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label16" runat="server" Text="Valor a pagar" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvValorPagar" runat="server" CssClass="input" Visible="False" Width="200px">0</asp:TextBox>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label17" runat="server" Text="Pagar a partir de" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlDiasInicio" runat="server" CssClass="chzn-select" OnSelectedIndexChanged="ddlDiasInicio_SelectedIndexChanged" AutoPostBack="True">
                                                <asp:ListItem Value="1">Primer día</asp:ListItem>
                                                <asp:ListItem Value="2">Segundo día</asp:ListItem>
                                                <asp:ListItem Value="3">Tercer día</asp:ListItem>
                                                <asp:ListItem Value="4">Cuarto día</asp:ListItem>
                                                <asp:ListItem Value="5">Quinto día</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: left" colspan="4">

                                            <div>
                                                <fieldset>
                                                    <legend>Observación</legend>
                                                    <div style="padding: 10px">
                                                        <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="50px" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="txvNoDias" EventName="TextChanged" />
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
                            <asp:BoundField DataField="tercero" HeaderText="Cod" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                            </asp:BoundField>
                               <asp:BoundField DataField="nombreEmpleado" HeaderText="NombreEmpleado" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="numero" HeaderText="No." ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaInicial" HeaderText="FechaInicial" ReadOnly="True" DataFormatString="{0:dd/MM/yyy}" SortExpression="Fecha">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaFinal" HeaderText="FechaFinal" ReadOnly="True" DataFormatString="{0:dd/MM/yyy}" SortExpression="Fecha">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>                             
                            <asp:BoundField DataField="noDias" HeaderText="noDias" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="referencia" HeaderText="Referencia" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            
                            <asp:BoundField DataField="tipoIncapacidad" HeaderText="Tipo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="diagnostico" HeaderText="Diagn." ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="observacion" HeaderText="Observacion" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="300px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="liquidada" HeaderText="Liq">
                                <ItemStyle Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="prorroga" HeaderText="Pro">
                                <ItemStyle Width="20px" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="numeroReferencia" HeaderText="numRef" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="valor" HeaderText="Valor" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                              <asp:BoundField DataField="diasPagos" HeaderText="DíasPag" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                              <asp:BoundField DataField="diasInicio" HeaderText="DíasIni" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                              <asp:BoundField DataField="valorPagado" HeaderText="ValorPag" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                              <asp:BoundField DataField="concepto" HeaderText="IdCon" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                             <asp:BoundField DataField="desConcepto" HeaderText="Concepto">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="150px" />
                            </asp:BoundField>
                             <asp:CheckBoxField DataField="anulado" HeaderText="Anu">
                                <ItemStyle Width="20px" />
                            </asp:CheckBoxField>
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

