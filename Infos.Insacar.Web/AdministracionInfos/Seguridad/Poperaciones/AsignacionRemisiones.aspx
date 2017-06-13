<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AsignacionRemisiones.aspx.cs" Inherits="Seguridad_Poperaciones_AsignacionRemisiones" %>

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
        <div class="principal" >
            <table cellspacing="0" style="WIDTH: 950px">
                <tr>
                    <td class="bordes">
                        <asp:ImageButton ID="nilblRegresar" runat="server" ToolTip="Regresar" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="nilblRegresar_Click" style="height: 16px" />
                        </td>
                    <td>Asignación de Remisiones</td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="3">
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
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 220px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 300px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left"></td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 220px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:Label ID="Label2" runat="server" Text="C.C. Persona que Recibe" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 300px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:DropDownList ID="ddlOperadorLogistico" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 220px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 300px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left"></td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>

            <div class="tablaGrilla">
                <div style="display:inline-block">
                     <asp:GridView ID="gvLista" runat="server" Width="500px" GridLines="None"  CssClass="Grid" AutoGenerateColumns="False" AllowPaging="True" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="20">
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
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
