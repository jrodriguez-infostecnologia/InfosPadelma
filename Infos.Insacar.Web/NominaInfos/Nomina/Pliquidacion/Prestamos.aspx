<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Prestamos.aspx.cs" Inherits="Nomina_PLiquidacion_Prestamo" %>

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
                        document.getElementById("txvSaldo").value = Math.round(parseFloat(valorTotal));
                        document.getElementById("txvCuotasPendiente").value = Math.round(parseFloat(noCuota));
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
                                            <asp:Label ID="Label1" runat="server" Text="Código" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" CssClass="input" MaxLength="20" Visible="False" Width="200px"></asp:TextBox>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:LinkButton ID="lbFecha" runat="server" OnClick="lbFecha_Click" Style="color: #003366" Visible="False">Fecha</asp:LinkButton>
                                        </td>
                                        <td class="Campos">
                                            <asp:Calendar ID="niCalendarFecha" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged" Visible="False" Width="150px">
                                                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                <SelectorStyle BackColor="#CCCCCC" />
                                                <WeekendDayStyle BackColor="FloralWhite" />
                                                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                <OtherMonthDayStyle ForeColor="Gray" />
                                                <NextPrevStyle VerticalAlign="Bottom" />
                                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                            </asp:Calendar>
                                            <asp:TextBox ID="txtFecha" runat="server" Visible="False" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" AutoPostBack="True" OnTextChanged="txtFecha_TextChanged"></asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label7" runat="server" Text="Centro costo" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlCentroCosto" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlCentroCosto_SelectedIndexChanged" Visible="False" Width="320px">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label13" runat="server" Text="Empleado" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlEmpleado" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="320px">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label3" runat="server" Text="Concepto" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlConcepto" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="320px">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblPeriodoInicial" runat="server" Text="Periodo inicial" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvPeriodoInicial" runat="server" CssClass="input" onkeyup="formato_numero(this);cuotas()" Visible="False">0</asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="Label4" runat="server" Text="Valor" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvValor" runat="server" Visible="False" Width="200px" CssClass="input" onkeyup="formato_numero(this);cuotas()">0</asp:TextBox></td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblCantidad" runat="server" Text="Cantidad cuotas" Visible="False"></asp:Label></td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvCuotas" runat="server" Visible="False" onkeyup="formato_numero(this);cuotas()" CssClass="input">0</asp:TextBox></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblValorCuota" runat="server" Text="Valor cuota" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvValorCuota" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this);cuotas()" Width="200px">0</asp:TextBox>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblCantidad0" runat="server" Text="Cuotas Pendiente" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvCuotasPendiente" runat="server" onkeyup="formato_numero(this)" CssClass="input" Visible="False">0</asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblSaldo" runat="server" Text="Valor saldo" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txvSaldo" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this)" Width="200px">0</asp:TextBox>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblCantidad1" runat="server" Text="Frecuencia" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlFrecuencia" runat="server" style="margin-top: 0px">
                                                <asp:ListItem Value="0">Todos los pagos</asp:ListItem>
                                                <asp:ListItem Value="1">Primer pago</asp:ListItem>
                                                <asp:ListItem Value="2">Segundo pago</asp:ListItem>
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblDepartamento30" runat="server" Text="Forma de pago"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:DropDownList ID="ddlFormaPago" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                            </asp:DropDownList>
                                        </td>
                                        <td style="width: 130px; text-align: left">
                                            <asp:Label ID="lblCantidad2" runat="server" Text="Doc Ref" ToolTip="Documento de referencia" Visible="False"></asp:Label>
                                        </td>
                                        <td class="Campos">
                                            <asp:TextBox ID="txtDocRef" runat="server" AutoPostBack="True" CssClass="input" Enabled="False" ToolTip="Documento de referencia" Visible="False" Width="100px"></asp:TextBox>
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
                                    <tr>
                                        <td style="text-align: left" colspan="4">&nbsp;</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </ContentTemplate>
            </asp:UpdatePanel>
            <div>
                <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
            </div>
            <div>
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="1000px" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging1">
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
                            <asp:BoundField DataField="fecha" HeaderText="Fecha" ReadOnly="True" DataFormatString="{0:dd/MM/yyy}" SortExpression="Fecha">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="concepto" HeaderText="Id Co" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desConcepto" HeaderText="Con.">

                                <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid" Width="70px"></ItemStyle>
                            </asp:BoundField>
                            <asp:BoundField DataField="empleado" HeaderText="Id Emp" ReadOnly="True">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desEmpleado" HeaderText="Empleado">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="200px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="valor" HeaderText="Valor" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cuotas" HeaderText="Cuotas" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="valorCuotas" HeaderText="VlCuotas" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cuotasPendiente" HeaderText="CuoPend" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="valorSaldo" HeaderText="VlSaldo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="liquidado" HeaderText="Liq">
                                <ItemStyle Width="20px" />
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

