<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ParametrosGenerales.aspx.cs" Inherits="Facturacion_Padministracion_ClaseParametro" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
</head>

<body class="principalBody">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 950px">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: left;"></td>
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
            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                <tr>
                    <td style="width: 20px;" width="30px"></td>
                    <td style="height: 15px;" colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                    <td style="width: 20px;"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="text-align: left; width: 115px;">
                        <asp:Label ID="Label1" runat="server" Text="Código" Visible="False" Width="30px"></asp:Label></td>
                    <td style="text-align: left; width: 340px;">
                        <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="200px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input"></asp:TextBox>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="Label9" runat="server" Text="Tipo" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 340px;">
                        <asp:DropDownList ID="ddlTipo" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación" AutoPostBack="True" OnSelectedIndexChanged="ddlTipo_SelectedIndexChanged">
                            <asp:ListItem Value="PE">Por empleado</asp:ListItem>
                            <asp:ListItem Value="PC">Por contratista</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px;"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="Label6" runat="server" Text="Clase" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 340px;">
                        <asp:DropDownList ID="ddlClase" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación" AutoPostBack="True">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="Label12" runat="server" Text="Tipo Tra" Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 340px;">
                        <asp:DropDownList ID="ddlTipoTraNomina" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 20px;"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="Label10" runat="server" Text="M. cen. costo no." Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 340px" >
                        <asp:DropDownList ID="ddlCcostoMayorNomi" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación" AutoPostBack="True" OnSelectedIndexChanged="ddlCcostoMayorNomi_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="Label11" runat="server" Text="Cen. costo no." Visible="False"></asp:Label></td>
                    <td style="text-align: left; width: 340px;" >
                        <asp:DropDownList ID="ddlCentroCostoNomi" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación" AutoPostBack="True" OnSelectedIndexChanged="ddlCentroCostoNomi_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:CheckBox ID="chkManejaDepartamento" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaDepartamento_CheckedChanged" Text=" Departamento" Visible="False" />
                    </td>
                    <td style="text-align: left; width: 340px" >
                        <asp:DropDownList ID="ddlDepartamento" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación" AutoPostBack="True" OnSelectedIndexChanged="ddlCentroCostoNomi_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="Label13" runat="server" Text="Concepto / labor" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px;" >
                        <asp:DropDownList ID="ddlConcepto" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:CheckBox ID="chkManejaEntidad" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaEntidad_CheckedChanged" Text=" Entidad" Visible="False" />
                    </td>
                    <td style="text-align: left; width: 340px;">
                        <asp:DropDownList ID="ddlEntidad" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                            <asp:ListItem Value="EEPS">Entidad Eps</asp:ListItem>
                            <asp:ListItem Value="EP">Entidad Pensión</asp:ListItem>
                            <asp:ListItem Value="ECESANTIAS">Entidad Cesantias</asp:ListItem>
                            <asp:ListItem Value="ECAJA">Entidad Caja Compensaciones</asp:ListItem>
                            <asp:ListItem Value="EARP">Entidad Arp</asp:ListItem>
                            <asp:ListItem Value="EICBF">Entidad ICBF</asp:ListItem>
                            <asp:ListItem Value="ESENA">Entidad Sena</asp:ListItem>
                            <asp:ListItem Value="EFONDO">Entidades de Fondos</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCuentaGasto" runat="server" Text="Cuenta gasto" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px;" >
                        <asp:DropDownList ID="ddlCuentaGasto" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCuentaContable" runat="server" Text="Cuenta activo" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px" >
                        <asp:DropDownList ID="ddlCuentaContable" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCuentaContratista" runat="server" Text="Cuenta contratista" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px;" >
                        <asp:DropDownList ID="ddlCuentaContratista" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:CheckBox ID="chkTerceroActivo" runat="server" AutoPostBack="True" OnCheckedChanged="chkTerceroActivo_CheckedChanged" Text="Tercero " Visible="False" />
                    </td>
                    <td style="text-align: left; width: 340px" >
                        <asp:DropDownList ID="ddlTercero" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." ToolTip="Código nacional de ocupación" Visible="False" Width="320px">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;"></td>
                    <td style="text-align: left; width: 340px;" ></td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCentroCosto0" runat="server" Text="M Cen. costo" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px" >
                        <asp:DropDownList ID="ddlCentroCostoMayor" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación" AutoPostBack="True" OnSelectedIndexChanged="ddlCentroCostoMayor_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCentroCosto" runat="server" Text="Cen. costo" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px;" >
                        <asp:DropDownList ID="ddlCentroCosto" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCuentaCredito" runat="server" Text="Cuenta credito" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px" >
                        <asp:DropDownList ID="ddlCuentaCredito" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:CheckBox ID="chkTerceroCredito" runat="server" AutoPostBack="True" OnCheckedChanged="chkTerceroCredito_CheckedChanged" Text="Tercero Cred." Visible="False" />
                    </td>
                    <td style="text-align: left; width: 340px;" >
                        <asp:DropDownList ID="ddlTerceroCredito" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." ToolTip="Código nacional de ocupación" Visible="False" Width="320px">
                        </asp:DropDownList>
                    </td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCcostoCredito0" runat="server" Text="M Cen.  costo cre." Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px" >
                        <asp:DropDownList ID="ddlCcostoMayorCredito" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación" AutoPostBack="True" OnSelectedIndexChanged="ddlCcostoMayorCredito_SelectedIndexChanged">
                        </asp:DropDownList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblCcostoCredito" runat="server" Text="Cen. costo cre" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px;" >
                        <asp:DropDownList ID="ddlCentroCostoCredito" runat="server" Visible="False" Width="320px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" ToolTip="Código nacional de ocupación">
                        </asp:DropDownList>
                    </td>
                    <td  style="width: 20px"></td>
                </tr>
                <tr>
                    <td class="nombreCampos" style="width: 20px"></td>
                    <td style="width: 115px; text-align: left;"></td>
                    <td style="text-align: left; width: 340px" >
                        <asp:RadioButtonList ID="rblTipoCantidad" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblTipoCantidad_SelectedIndexChanged" RepeatDirection="Horizontal" Visible="False" Style="height: 26px">
                            <asp:ListItem Value="1" Selected="True">Sin cantidad</asp:ListItem>
                            <asp:ListItem Value="2">Porcentaje</asp:ListItem>
                            <asp:ListItem Value="3">Cantidad</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style="width: 115px; text-align: left;">
                        <asp:Label ID="lblValor" runat="server" Text="Valor" Visible="False"></asp:Label>
                    </td>
                    <td style="text-align: left; width: 340px;">
                        <asp:TextBox ID="txvValor" runat="server" Visible="False" Width="150px" AutoPostBack="True" CssClass="input"></asp:TextBox>
                    </td>
                    <td style="width: 20px;"></td>
                </tr>
                <tr>
                    <td style="height: 15px;" colspan="5">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                    <td style="width: 20px;"></td>
                </tr>
            </table>
            <div>
                <div style="display: inline-block; padding-left: 15px;">
                    <asp:GridView ID="gvLista" runat="server" Width="1300px" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging1">
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
                            <asp:BoundField DataField="id" HeaderText="C&#243;digo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="Tipo" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desConcepto" HeaderText="Concepto">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="clase" HeaderText="idClase" ReadOnly="True"
                                SortExpression="descripcion">
                                <ItemStyle Width="30px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desClase" HeaderText="Clase" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipoTransaccion" HeaderText="Tra. N" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ccostoMayor" HeaderText="CCMayor" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="10px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desCcostoMayor" HeaderText="Ccosto M">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Ccosto" HeaderText="CCaux">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desCcosto" HeaderText="Ccosto">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="150px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="manejaEntidad" HeaderText="Ent.">
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
