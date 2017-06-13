<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Remisiones.aspx.cs" Inherits="Seguridad_Poperaciones_Remisiones" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Calendarios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">

            <table cellspacing="0" style="WIDTH: 950px">
                <tr>
                    <td class="bordes">
                        <asp:LinkButton ID="nilbImprimir" runat="server" ForeColor="#404040" onclick="nilbImprimir_Click" ToolTip="Clic aquí para imprimir las remisiones generadas">Imprimir Remisiones</asp:LinkButton>
                        </td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" ToolTip="Escriba el texto para la busqueda" Width="350px" CssClass="input"></asp:TextBox>
                    </td>
                    <td class="bordes">
                        <asp:LinkButton ID="nilbAsignar" runat="server" ForeColor="#404040" onclick="lbAsignar_Click" ToolTip="Clic aquí para asignar las remisiones impresas">Asignar Remisiones</asp:LinkButton>
                    </td>
                </tr>
                <tr>
                    <td colspan="4" >
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" onclick="niimbBuscar_Click" ToolTip="Haga clic aqui para realizar la busqueda" />
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

            <table id="TABLE1" cellspacing="0" onclick="return TABLE1_onclick()" style="BORDER-TOP: silver thin solid; WIDTH: 950px; BORDER-BOTTOM: silver thin solid">
                <tr>
                    <td colspan="4">
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
                        <asp:Label ID="Label1" runat="server" ForeColor="#404040" Text="Nro. de Remisiones para Generar" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="numRegistros" runat="server" CssClass="input" Width="200px" TextMode="Number" ValidateRequestMode="Enabled" ViewStateMode="Enabled" onkeyup="formato_numero(this)" Visible="False"></asp:TextBox>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos"></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>

            <div class="tablaGrilla">
                <div style="display:inline-block">
                       <asp:GridView ID="gvLista" runat="server" Width="500px" GridLines="None" AutoGenerateColumns="False" CssClass="Grid" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:BoundField DataField="estado" HeaderText="Estado" ReadOnly="True" SortExpression="nivel" >
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="conteo" HeaderText="Conteo" ReadOnly="True" >
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                    <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>

            </div>

               <div class="tablaGrilla">
                <div style="display:inline-block">
                      <asp:GridView ID="gvBusqueda" runat="server" Width="800px" GridLines="None" AutoGenerateColumns="False" CssClass="Grid" AllowPaging="True" OnPageIndexChanging="gvBusqueda_PageIndexChanging">
                          <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:BoundField DataField="codigo" HeaderText="C&#243;digo" ReadOnly="True" >
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaCreacion" HeaderText="Fec. Creaci&#243;n" ReadOnly="True" DataFormatString="{0:d}" >
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaImpresion" DataFormatString="{0:d}" HeaderText="Fec. Impresi&#243;n">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaAsignacion" DataFormatString="{0:d}" HeaderText="Fec. Asignaci&#243;n">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="estado" HeaderText="Estado">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:BoundField>
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
