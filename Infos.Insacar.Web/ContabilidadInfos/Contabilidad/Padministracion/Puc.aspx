<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Puc.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" %>

<%@ OutputCache Location="None" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Facturación y Logística</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />

</head>
<body class="principalBody">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 950px; padding-bottom: 1px;">
                <tr>
                    <td class="bordes"></td>
                    <td style="width: 100px; text-align: left">Busqueda</td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4" style="text-align: center">
                        <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" />
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="nilbNuevo_Click"
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
            <table style="border-top: silver thin solid; border-bottom: silver thin solid; width: 950px;" cellspacing="0">
                <tr>
                    <td colspan="6">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 120px; text-align: left">
                        <asp:Label ID="Label1" runat="server" Text="No Cuenta" Visible="False"></asp:Label></td>
                    <td style="width: 300px; text-align: left">
                        <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="200px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input"></asp:TextBox>
                        <asp:CheckBox
                            ID="chkActio" runat="server" Text="Activo" Visible="False" Checked="True" />
                    </td>
                    <td style="width: 120px; text-align: left">
                        <asp:Label ID="Label5" runat="server" Text="Nivel de la cuenta" Visible="False"></asp:Label></td>
                    <td style="width: 300px; text-align: left">
                        <asp:TextBox ID="txtNivel" runat="server" Visible="False" Width="50px" CssClass="input"></asp:TextBox>
                        <asp:CheckBox
                            ID="chkAuxiliar" runat="server" Text="Auxiliar" Visible="False" Checked="True" AutoPostBack="True" OnCheckedChanged="chkAuxiliar_CheckedChanged" />
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 120px; text-align: left">
                        <asp:Label ID="Label2" runat="server" Text="Raiz" Visible="False"></asp:Label></td>
                    <td style="width: 300px; text-align: left">
                        <asp:TextBox ID="txtRaiz" runat="server" Visible="False" Width="200px" CssClass="input"></asp:TextBox></td>
                    <td style="width: 120px; text-align: left">
                        <asp:Label ID="Label3" runat="server" Text="Descripción" Visible="False"></asp:Label></td>
                    <td style="width: 300px; text-align: left">
                        <asp:TextBox ID="txtNombre" runat="server" Visible="False" Width="300px" CssClass="input"></asp:TextBox></td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 120px; text-align: left">
                        <asp:Label ID="Label4" runat="server" Text="Naturaleza" Visible="False"></asp:Label></td>
                    <td style="width: 300px; text-align: left">
                        <asp:DropDownList ID="ddlNaturaleza" runat="server" Visible="False" Width="120px" CssClass="chzn-select">
                            <asp:ListItem Value="D">Debito</asp:ListItem>
                            <asp:ListItem Value="C">Credito</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="width: 120px; text-align: left">
                        <asp:Label ID="Label6" runat="server" Text="Tipo cuenta" Visible="False"></asp:Label></td>
                    <td style="width: 300px; text-align: left">
                        <asp:DropDownList ID="ddlTipoCuenta" runat="server" Visible="False" Width="120px" CssClass="chzn-select">
                            <asp:ListItem Value="B">Balance</asp:ListItem>
                            <asp:ListItem Value="E">Estado Resultado</asp:ListItem>
                            <asp:ListItem Value="O">Otros</asp:ListItem>
                        </asp:DropDownList></td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 120px; text-align: left">
                        <asp:CheckBox
                            ID="chkCcosto" runat="server" Text="Centro costo" Visible="False" AutoPostBack="True" />
                    </td>
                    <td style="width: 300px; text-align: left">
                        <asp:DropDownList ID="ddlGrupoCC" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 120px; text-align: left">
                        <asp:CheckBox ID="chkDisponible" runat="server" Text="Disponible" Visible="False" AutoPostBack="True" OnCheckedChanged="chkDisponible_CheckedChanged" />
                    </td>
                    <td style="width: 300px; text-align: left">
                        <asp:DropDownList ID="ddlTipoDisponible" runat="server" Visible="False" Width="120px" CssClass="chzn-select">
                            <asp:ListItem Value="B">Bancos</asp:ListItem>
                            <asp:ListItem Value="C">Caja</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="auto-style1"></td>
                    <td style="text-align: left" class="auto-style2">
                        <asp:CheckBox ID="chkTercero" runat="server" Text="Maneja tercero" Visible="False" AutoPostBack="True" />
                    </td>
                    <td style="text-align: left; width: 300px;">
                        <asp:DropDownList ID="ddlTipoManejaTercero" runat="server" Visible="False" Width="150px" AutoPostBack="True" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged" CssClass="chzn-select">
                            <asp:ListItem Value="SA">Sólo acumulado</asp:ListItem>
                            <asp:ListItem Value="SS">Si, saldos</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlTipoSaldo" runat="server" Visible="False" Width="100px" CssClass="chzn-select">
                            <asp:ListItem Value="C">Cliente</asp:ListItem>
                            <asp:ListItem Value="P">Proveedor</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="text-align: left" class="auto-style2">
                        <asp:Label ID="Label7" runat="server" Text="Plan de cuenta" Visible="False"></asp:Label></td>
                    <td style="text-align: left" class="auto-style3">
                        <asp:DropDownList ID="ddlPlanCuenta" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="auto-style1"></td>
                </tr>

                <tr>
                    <td style="width: 20px"></td>
                    <td colspan="4" style="text-align: left">
                        <div style="text-align: center; width: 100%">
                            <div style="display: inline-block; text-align: left; width: 870px; height: 100%">
                                <div style="padding: 5px; float: left; display: inline-block">
                                    <div style="border: 1px solid silver; padding: 5px; float: left">
                                        <asp:CheckBox ID="chkImpuesto" runat="server" Text="Impuestos" Visible="False" />
                                        <div>
                                            <table cellpadding="0" cellspacing="0" style="width: 400px">
                                                <tr>
                                                    <td style="width: 80px">
                                                        <asp:Label ID="lblDepartamento13" runat="server" Text="Tipo"></asp:Label>
                                                    </td>
                                                    <td style="width: 280px; text-align: left;" width="310px">
                                                        <asp:DropDownList ID="ddlTipoIR" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="200px" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoIR_SelectedIndexChanged">
                                                            <asp:ListItem Value="ID">Impuesto descontable</asp:ListItem>
                                                            <asp:ListItem Value="IG">Impuesto generado</asp:ListItem>
                                                            <asp:ListItem Value="RF">Retención a favor</asp:ListItem>
                                                            <asp:ListItem Value="RP">Retención por pagar</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 5px; text-align: left"></td>
                                                    <td style="width: 120px; text-align: left">
                                                        <asp:Label ID="lblDepartamento15" runat="server" Text="Tasa"></asp:Label>
                                                    </td>
                                                    <td style="width: 70px; text-align: left">
                                                        <asp:TextBox ID="txvTasaIR" runat="server" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Formato fecha (dd/mm/yyyy)" Width="50px">0</asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px">
                                                        <asp:Label ID="lblDepartamento14" runat="server" Text="Clase"></asp:Label>
                                                    </td>
                                                    <td style="width: 280px; text-align: left;" width="310px">
                                                        <asp:DropDownList ID="ddlCalseIR" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="200px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 5px; text-align: left"></td>
                                                    <td style="width: 120px; text-align: left">
                                                        <asp:Label ID="lblDepartamento16" runat="server" Text="Base"></asp:Label>
                                                    </td>
                                                    <td style="width: 70px; text-align: left">
                                                        <asp:TextBox ID="txvBaseIR" runat="server" CssClass="input" Font-Bold="True" onkeyup="formato_numero(this)" ToolTip="Formato fecha (dd/mm/yyyy)" Width="80px">0</asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 80px"></td>
                                                    <td style="width: 20px; text-align: left;" width="310px"></td>
                                                    <td style="width: 5px; text-align: left"></td>
                                                    <td style="width: 120px; text-align: left"></td>
                                                    <td style="width: 70px; text-align: left"></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                                <div style="padding: 5px; float: left; height: 100%; display: inline-block">
                                    <div style="border: 1px solid silver; padding: 5px; float: left; height: 100%">
                                        <div>
                                            <asp:Label ID="Label9" runat="server" Text="Notas" Visible="False"></asp:Label>
                                        </div>
                                        <asp:TextBox ID="txtNotas" runat="server" CssClass="input" Height="60px" TextMode="MultiLine" Visible="False" Width="400px"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
            </table>
            <div style="text-align: center">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" PageSize="20" Width="900px" OnPageIndexChanging="gvLista_PageIndexChanging">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Edit">
                                <HeaderStyle BackColor="White" />
                                <ItemStyle Width="20px" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <ItemStyle VerticalAlign="Middle" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" BackColor="White" Width="10px" />
                                <HeaderStyle VerticalAlign="Middle" BackColor="White" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="codigo" HeaderText="C&#243;digo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="raiz" HeaderText="Raiz" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="naturaleza" HeaderText="Natza">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nivel" HeaderText="Nivel">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipoBalanceResultado" HeaderText="Tipo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
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
