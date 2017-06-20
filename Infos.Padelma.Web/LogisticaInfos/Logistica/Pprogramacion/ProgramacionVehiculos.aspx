<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ProgramacionVehiculos.aspx.cs" Inherits="Logistica_Pprogramacion_ProgramacionVehiculos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <script type="text/jscript" language="javascript">

        function soloNumeros(e) {
            key = e.keyCode || e.which;
            tecla = String.fromCharCode(key).toLowerCase();
            letras = "1234567890";
            especiales = "";

            tecla_especial = false
            for (var i in especiales) {
                if (key == especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if (letras.indexOf(tecla) == -1 && !tecla_especial) {
                return false;
            }
        }

        function soloLetrasNumeros(e) {
            key = e.keyCode || e.which;
            tecla = String.fromCharCode(key).toLowerCase();
            letras = "1234567890abcdefghijklmnopqrstuvwxyz";
            especiales = "";

            tecla_especial = false
            for (var i in especiales) {
                if (key == especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if (letras.indexOf(tecla) == -1 && !tecla_especial) {
                return false;
            }
        }

        function soloLetras(e) {
            key = e.keyCode || e.which;
            tecla = String.fromCharCode(key).toLowerCase();
            letras = "abcdefghijklmnopqrstuvwxyz";
            especiales = "";

            tecla_especial = false
            for (var i in especiales) {
                if (key == especiales[i]) {
                    tecla_especial = true;
                    break;
                }
            }

            if (letras.indexOf(tecla) == -1 && !tecla_especial) {
                return false;
            }
        }
    </script>
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
   
      </head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td class="bordes" style="width: 250px">
                        <asp:ImageButton ID="nilblRegresar" runat="server" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="nilblRegresar_Click" Style="width: 16px" ToolTip="Regresar" />
                    </td>
                    <td class="nombreCampos"></td>
                    <td class="Campos"></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td colspan="4">
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
            <table cellspacing="0" style="width: 100%; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td colspan="7">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 40px" rowspan="2"></td>
                    <td class="nombreCampos">
                        <asp:CheckBox ID="chkPropio" runat="server" AutoPostBack="True" OnCheckedChanged="chkPropio_CheckedChanged" Text="Propio" Visible="False" />
                        </td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblLetra" runat="server" Text="Letra " Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style1">
                        <asp:Label ID="lblNumero" runat="server" Style="text-align: left" Text="Número" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        </td>
                    <td class="nombreCampos">
                        </td>
                    <td style="width: 40px" rowspan="2"></td>
                </tr>
                <tr>
                    <td class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Vehículo" Visible="False"></asp:Label>
                    </td>
                    <td colspan="2" class="nombreCampos" >
                        <asp:TextBox ID="txtLVehiculo" runat="server" AutoCompleteType="Disabled" AutoPostBack="True" CssClass="input" MaxLength="20" onkeypress="return soloLetras(event)" onKeyUp="this.value=this.value.toUpperCase();" OnTextChanged="Txt_Vehiculo_TextChanged" Visible="False" Width="130px"></asp:TextBox>
                        <asp:Label ID="lblSeparador" runat="server" Style="text-align: left" Text="   -     " Visible="False"></asp:Label>
                        <asp:TextBox ID="txtNVehiculo" runat="server" AutoCompleteType="Disabled" AutoPostBack="True" CssClass="input" MaxLength="20" onkeypress="return soloNumeros(event)" OnTextChanged="Txt_Vehiculo_TextChanged" Visible="False" Width="130px"></asp:TextBox>
                        <asp:DropDownList ID="ddlVehiculo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label3" runat="server" Text="Remolque" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:TextBox ID="txtRemolque" runat="server" CssClass="input" MaxLength="50" onkeypress="return soloLetrasNumeros(event)" onKeyUp="this.value=this.value.toUpperCase();" Visible="False" Width="183px"></asp:TextBox>
                        <asp:DropDownList ID="ddlRemolque" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td style="width: 40px">&nbsp;</td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblCconductor" runat="server" Text="C.C. Conductor" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:TextBox ID="txtConductor" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txtConductor_TextChanged" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblNombreConductor" runat="server" Text="Nombre Conductor" Visible="False"></asp:Label>
                        </td>
                    <td class="nombreCampos">
                        <asp:TextBox ID="txtNombreConductor" runat="server" CssClass="input" Visible="False" Width="250px"></asp:TextBox>
                        </td>
                    <td style="width: 40px">&nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="lblConductor" runat="server" Text="Conductor" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:DropDownList ID="ddlConductor" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        </td>
                    <td class="nombreCampos">
                        </td>
                    <td style="width: 40px"></td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos" style="vertical-align: top">
                        <asp:LinkButton ID="lbFechaDespacho" runat="server" OnClick="lbFecha_Click" Visible="False" Style="color: #003366">Fecha Despacho</asp:LinkButton>
                    </td>
                    <td class="nombreCampos" colspan="2">
                        <asp:Calendar ID="CalendarFechaDespacho" runat="server" BackColor="White" BorderColor="Silver" BorderWidth="1px" CellPadding="1" DayNameFormat="FirstTwoLetters" Font-Names="Trebuchet MS" Font-Size="10px" ForeColor="#003366" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged" Visible="False" Width="180px">
                            <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                            <WeekendDayStyle BackColor="#CCCCFF" />
                            <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
                            <OtherMonthDayStyle ForeColor="#999999" />
                            <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                            <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                            <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True" Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaDespacho" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Visible="False"></asp:TextBox>
                    </td>
                    <td class="nombreCampos" style="vertical-align: top; width: 110px;">
                        <asp:Label ID="Label1" runat="server" Text="Cantidad TM." Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos" style="vertical-align: top">
                        <asp:TextBox ID="txvCantidad" runat="server" CssClass="input" Visible="False" onkeyup="formato_numero(this)" Width="100px"></asp:TextBox>
                    </td>
                    <td style="width: 40px"></td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label7" runat="server" Text="Comercializadora" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style1" colspan="2">
                        <asp:DropDownList ID="ddlComercializadora" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label10" runat="server" Text="Planta Extractora" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:DropDownList ID="ddlPlanta" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 40px"></td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos" style="width: 110px">
                        <asp:Label ID="Label6" runat="server" Text="Cliente" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style1" colspan="2">
                        <asp:DropDownList ID="ddlCliente" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="320px" AutoPostBack="True" OnSelectedIndexChanged="ddlCliente_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label8" runat="server" Text="Producto" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:DropDownList ID="ddlProducto" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 40px"></td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label14" runat="server" Text="Sucursal" Visible="False"></asp:Label>
                    </td>
                    <td class="auto-style1" colspan="2">
                        <asp:DropDownList ID="ddlSucursal" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="320px">
                        </asp:DropDownList>
                    </td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label15" runat="server" Text="Certificado" Visible="False"></asp:Label>
                    </td>
                    <td class="nombreCampos">
                        <asp:DropDownList ID="ddlProductoCertificado" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 40px"></td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos" style="vertical-align: top">
                        <asp:Label ID="Label13" runat="server" Text="Observaciones" Visible="False"></asp:Label>
                    </td>
                    <td colspan="4">
                        <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" TextMode="MultiLine" Visible="False" Width="100%" Height="40px"></asp:TextBox>
                    </td>
                    <td style="width: 40px"></td>
                </tr>
                <tr>
                    <td style="width: 40px"></td>
                    <td class="nombreCampos" style="vertical-align: top"></td>
                    <td colspan="4" style="text-align: left; height: 10px;"></td>
                    <td style="width: 40px"></td>
                </tr>
            </table>
            <div class="tablaGrilla">
                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" PageSize="20" Width="800px" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
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
                        <asp:BoundField DataField="fechaDespacho" HeaderText="Fecha" DataFormatString="{0:d}">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vehiculo" HeaderText="Veh&#237;culo">
                            <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="remolque" HeaderText="Remolque">
                            <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad TM.">
                            <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="codigoConductor" HeaderText="C.C. Conductor">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="nombreConductor" HeaderText="Nombre Conductor">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="programacionCarga" HeaderText="Prog. General">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="numero" HeaderText="Prog. Veh&#237;culo">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tipo" HeaderText="Tipo">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="descripcionAbreviada" HeaderText="Producto">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                        </asp:BoundField>
                    </Columns>
                    <PagerStyle CssClass="pgr" />
                    <RowStyle CssClass="rw" />
                </asp:GridView>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>



