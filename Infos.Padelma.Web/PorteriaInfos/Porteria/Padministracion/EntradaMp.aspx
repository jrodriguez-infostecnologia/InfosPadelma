<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EntradaMp.aspx.cs" Inherits="Porteria_Padministracion_EntradaMp"  %>
<%@ OutputCache Location="None" %>   
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">
 
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    
    <%-- Este es el estilo de combobox --%>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <%-- Aqui termina el estilo es el estilo de combobox --%>
    <link href="../../css/Formularios.css" rel="stylesheet" />

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

    

    <style type="text/css">
        .campos {
            text-align: left;
        }
    </style>

    

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td class="bordes">
                        </td>
                    <td><strong>Vehículos en planta de materia prima</strong></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="3">
                    <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click" 
                        onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" 
                        onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" style="height: 21px"/>
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
            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;">
            <tr>
                <td colspan="5">
                    <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td colspan="3">
                    <asp:Label ID="lblMulticarga" runat="server"></asp:Label>
                </td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                    </td>
                <td colspan="3">
                    <asp:CheckBox ID="chkPropio" runat="server" AutoPostBack="True" OnCheckedChanged="chkPropio_CheckedChanged" Text="Vehículo Interno" Visible="False" />
                </td>
                <td class="bordes">
                    </td>
            </tr>
            <tr>
                <td class="bordes" rowspan="3">
                </td>
                <td class="nombreCampos" rowspan="3">
                    <asp:Label ID="lbVehiculo" runat="server" Text="Vehículo" Visible="False" Width="114px"></asp:Label></td>
                <td style="text-align: left; width: 200px;">
                    <asp:Label ID="lblLetra" runat="server" Text="Letras" Visible="False"></asp:Label>
                </td>
                <td style="text-align: left; width: 145px;">
                    <asp:Label ID="lblNumero" runat="server" Text="Número" Visible="False" style="text-align: left"></asp:Label>
                </td>
                <td class="bordes" rowspan="3">
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <asp:TextBox ID="txtLVehiculo" onkeypress="return soloLetras(event)" onKeyUp="this.value=this.value.toUpperCase();" runat="server" Width="200px" Visible="False" CssClass="input" AutoPostBack="True" OnTextChanged="Txt_Vehiculo_TextChanged" AutoCompleteType="Disabled" MaxLength="20"></asp:TextBox>
                </td>
                <td style="text-align: left">
                    <asp:TextBox ID="txtNVehiculo" onkeypress="return soloNumeros(event)" runat="server" Width="100px" Visible="False" CssClass="input" AutoPostBack="True" OnTextChanged="Txt_Vehiculo_TextChanged" AutoCompleteType="Disabled" MaxLength="20"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="Campos" colspan="2">
                    <asp:DropDownList ID="ddlVehiculo" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..."  CssClass="chzn-select" AutoPostBack="True" OnSelectedIndexChanged="ddlVehiculo_SelectedIndexChanged">
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="lblRemolque" runat="server" Text="Caja/Remolque" Visible="False" Width="114px"></asp:Label></td>
                <td class="Campos" colspan="2">
                    <asp:DropDownList ID="ddlRemolque" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..."  CssClass="chzn-select" AutoPostBack="True" OnSelectedIndexChanged="ddlRemolque_SelectedIndexChanged">
                    </asp:DropDownList>
                        <asp:TextBox ID="txtRemolque" runat="server" CssClass="input" Visible="False"
                            Width="183px" AutoPostBack="True" MaxLength="50" Enabled="False"></asp:TextBox>
                </td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="lbCedula" runat="server" Text="C.C. Conductor" Visible="False" Width="109px"></asp:Label></td>
                <td class="Campos" colspan="2">
                    <asp:TextBox ID="txtIdConductor" runat="server" onkeypress="return soloNumeros(event)" Visible="False" Width="183px" CssClass="input" AutoPostBack="True" OnTextChanged="txtIdConductor_TextChanged" MaxLength="10"></asp:TextBox>
                </td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label1" runat="server" Text="Nombre Conductor" Visible="False"></asp:Label></td>
                <td class="Campos" colspan="2">
                    <asp:DropDownList ID="ddlConductor" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..."  CssClass="chzn-select" AutoPostBack="True" OnSelectedIndexChanged="ddlConductor_SelectedIndexChanged">
                    </asp:DropDownList>
                    <asp:TextBox ID="txtNombreConductor" runat="server" CssClass="input" Visible="False" Width="350px" MaxLength="250"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label5" runat="server" Text="Asigne la Remisión" Visible="False"></asp:Label></td>
                <td class="Campos" colspan="2">
                    <asp:TextBox ID="txtRemision" runat="server" CssClass="input" Visible="False"
                        Width="350px" AutoPostBack="True" OnTextChanged="txtRemision_TextChanged" MaxLength="50"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td colspan="5">
                </td>
            </tr>
            </table>
            <div class="tablaGrilla">
                <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None" Height="1px" Width="800px" CssClass="Grid">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha Ingreso" ReadOnly="True">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="vehiculo" HeaderText="Vehículo" ReadOnly="True">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="70px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="remolque" HeaderText="Remolque">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="codigoConductor" HeaderText="Cédula">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="nombreConductor" HeaderText="Nombre">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
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
