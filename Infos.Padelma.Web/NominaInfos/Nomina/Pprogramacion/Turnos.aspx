<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Turnos.aspx.cs" Inherits="Nomina_Paminidtracion_Turnos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script runat="server">

</script>


<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: url('../../Imagenes/botones/BotonIzq.png'); width: 250px; background-repeat: no-repeat; height: 25px; text-align: center;">
                        <asp:ImageButton ID="nilblRegresar" runat="server" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="nilblRegresar_Click" ToolTip="Regresar" />
                    </td>
                    <td style="width: 100px; height: 25px; text-align: left">Busqueda</td>
                    <td style="width: 350px; height: 25px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: right; background-position-x: right;"></td>
                </tr>
                <tr>
                    <td colspan="4">
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
            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label1" runat="server" Text="Código" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="200px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input"></asp:TextBox>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Descripción" Visible="False"></asp:Label></td>
                    <td class="Campos">
                        <asp:TextBox ID="txtDescripcion" runat="server" Visible="False" Width="350px" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label3" runat="server" Text="Hora de Inicio" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <table cellpadding="0" cellspacing="0" style="width: 360px">
                            <tr>
                                <td style="width: 70px">
                                    <asp:Label ID="Label7" runat="server" Text="Hora (hh)" Visible="False"></asp:Label>
                                </td>
                                <td style="width: 90px">
                                    <asp:TextBox ID="txvHoraInicio" runat="server" CssClass="input" ToolTip="Digite aquí la hora de inicio del turno en formato de hora militar en el rango entre 0 y 23" Visible="False" Width="70px"></asp:TextBox>
                                </td>
                                <td style="width: 110px">
                                    <asp:Label ID="Label6" runat="server" Text="Minutos (mm)" Visible="False"></asp:Label>
                                </td>
                                <td style="width: 90px">
                                    <asp:TextBox ID="txvMinutoInicio" runat="server" CssClass="input" ToolTip="Digite aquí los minutos en el rango entre 0 y 59" Visible="False" Width="70px"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <asp:RangeValidator ID="RangeValidatorMinuto" runat="server" ControlToValidate="txvMinutoInicio" Display="Dynamic" ErrorMessage="El rango de minutos debe estar entre 0 y 59" MaximumValue="59" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                        <asp:RangeValidator ID="RangeValidatorHora" runat="server" ControlToValidate="txvHoraInicio" Display="Dynamic" ErrorMessage="El rango de horas debe estar entre 0 y 23" MaximumValue="23" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label4" runat="server" Text="Horas Turno (00 - 24)" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvHorasTurno" runat="server" CssClass="input" Visible="False" Width="100px"></asp:TextBox>
                        <br />
                        <asp:RangeValidator ID="RangeValidatorHorasTurno" runat="server" ControlToValidate="txvHorasTurno" Display="Dynamic" ErrorMessage="El rango de horas turno debe estar entre 0 y 23" MaximumValue="23" MinimumValue="0" SetFocusOnError="True" Type="Integer"></asp:RangeValidator>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        </td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label></td>
                </tr>
            </table>
            <div class="tablaGrilla">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="800px" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging1" OnRowUpdating="gvLista_RowUpdating">
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
                            <asp:TemplateField HeaderText="Dpt">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imbDepartamentos" runat="server" CommandName="Update" ImageAlign="Middle" ImageUrl="~/Imagen/TabsIcon/edit_add.png" ToolTip="Asigna los departamentos al turno seleccionado" />
                                    <asp:ImageButton ID="imbGuardar" runat="server" CommandName="Update" ImageAlign="Middle" ImageUrl="~/Imagen/TabsIcon/filesave.png" OnClick="imbGuardar_Click" OnClientClick="if(!confirm('Desea guardar los cambios en la asignación ?')){return false;};" ToolTip="Clic aquí para guardar la asignación de departamentos" Visible="False" />
                                    <asp:GridView ID="gvDepartamento" runat="server" AutoGenerateColumns="False" GridLines="None" Visible="False" Width="400px">
                                        <Columns>
                                            <asp:BoundField DataField="codigo" HeaderText="Departamento">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="descripcion" HeaderText="Descripción">
                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                            </asp:BoundField>
                                            <asp:TemplateField HeaderText="Asignado">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="chkAsignado" runat="server" />
                                                </ItemTemplate>
                                                <HeaderStyle BackColor="White" />
                                                <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" Width="30px" />
                                <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="codigo" HeaderText="Código" ReadOnly="True">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"  Width="20px"/>
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True" SortExpression="descripcion">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="horaInicio" HeaderText="HoraInicio">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="horas" HeaderText="HorasTurno">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                            </asp:BoundField>
                             <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                        </Columns>
                        <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        <FooterStyle BackColor="LightYellow" />
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
