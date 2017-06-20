<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Terceros.aspx.cs" Inherits="Facturacion_Padministracion_Terceros" %>

<%@ OutputCache Location="None" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Terceros</title>
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/CalendarioMin.js" type="text/javascript"></script>
    <script src="../../js/CalendarioUiMin.js" type="text/javascript"></script>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/Calendarios.css" rel="stylesheet" type="text/css" />
    <link href="../../css/BotonesAuxiliares.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div style="vertical-align: top; width: 1000px; text-align: center; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 12px; color: #003366;">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td class="bordes">
                        </td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td></td>
                    <td class="bordes" valign="bottom">
                        </td>
                </tr>
                <tr>
                    <td style="text-align: center" colspan="5">
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
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="nilbGuardar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                    </td>
                </tr>
            </table>
            <div style="text-align: left; vertical-align: central">
                <table cellspacing="0" style="width: 1000px; border-top-style: solid; border-top-width: 1px; border-top-color: silver; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;" id="TABLE1">
                    <tr>
                        <td colspan="6" style="text-align: center">
                            <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align: center">
                        <asp:ToolkitScriptManager ID="ToolkitScriptManager2" runat="server">
                        </asp:ToolkitScriptManager>
                            <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td></td>
                        <td>
                            <asp:RadioButtonList ID="rbTipoPersona" runat="server" AutoPostBack="True" RepeatDirection="Horizontal" OnSelectedIndexChanged="rbTipoPersona_SelectedIndexChanged" Visible="False">
                                <asp:ListItem Value="1" Selected="True">Per. Natural</asp:ListItem>
                                <asp:ListItem Value="2">Per. Jurídica</asp:ListItem>
                                <asp:ListItem Value="0">Sin identificación</asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                        <td></td>
                        <td></td>
                        <td class="auto-style5"></td>
                    </tr>
                    <tr>
                        <td style="width: 30px"></td>
                        <td>
                            <asp:Label ID="Label5" runat="server" Text="Tipo identificación" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlTipoID" runat="server" Width="300px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Height="20px" TabIndex="2" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoID_SelectedIndexChanged">
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Label ID="Label1" runat="server" Text="Código" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="150px" AutoPostBack="True" OnTextChanged="txtCodigo_TextChanged" CssClass="input" TabIndex="1"></asp:TextBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="width: 30px"></td>
                        <td>
                            <asp:Label ID="Label4" runat="server" Text="Nro. Identificación" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDocumento" runat="server" CssClass="input" Visible="False" Width="150px" onkeyup="formato_numero(this)" TabIndex="3"></asp:TextBox>
                            <asp:Label ID="Label18" runat="server" Text="  dv -" Visible="False"></asp:Label>
                            <asp:TextBox ID="txtDv" runat="server" CssClass="input" Visible="False" Width="30px"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblRazonSocial" runat="server" Text="Razón Social" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtRazonSocial" runat="server" Visible="False" Width="300px" CssClass="input" TabIndex="4"></asp:TextBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="width: 30px"></td>
                        <td>
                            <asp:Label ID="lblPrimerApellido" runat="server" Text="Primer Apellido" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtApellido1" runat="server" Visible="False" Width="300px" CssClass="input" TabIndex="5"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblSegundoApellido" runat="server" Text="Segundo Apellido" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtApellido2" runat="server" Visible="False" Width="300px" CssClass="input" TabIndex="6"></asp:TextBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="width: 30px"></td>
                        <td>
                            <asp:Label ID="lblPrimerNombre" runat="server" Text="Primer Nombre" Visible="False"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtNombre1" runat="server" Visible="False" Width="300px" CssClass="input" TabIndex="7"></asp:TextBox>
                        </td>
                        <td>
                            <asp:Label ID="lblSegundoNombre" runat="server" Text="Segundo Nombre" Visible="False"></asp:Label></td>
                        <td>
                            <asp:TextBox ID="txtNombre2" runat="server" Visible="False" Width="300px" CssClass="input" TabIndex="8"></asp:TextBox>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td style="width: 30px"></td>
                        <td>
                            <asp:Label ID="Label2" runat="server" Text="Descripción" Visible="False"></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtDescripcion" runat="server" Visible="False" Width="300px" CssClass="input" TabIndex="9"></asp:TextBox>
                        </td>
                        <td colspan="2">
                            <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" Checked="True" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 30px"></td>
                        <td colspan="4" style="height: 5px; text-align: left">
                            <asp:TabContainer ID="tabTerceros" runat="server" ActiveTabIndex="0" Width="100%" Visible="False">
                                <asp:TabPanel ID="TabPanel3" runat="server" HeaderText="TabPanel3">
                                    <HeaderTemplate>
                                        Generales
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <div class="label">
                                            <table cellpadding="0" cellspacing="0" class="ui-accordion">
                                                <tr>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="Label23" runat="server" Text="Ciiu" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <div style="position: absolute; z-index: 99; margin-top: -13px;">
                                                            <asp:DropDownList ID="ddlCiiu" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Height="20px" TabIndex="14" Visible="False" Width="300px">
                                                            </asp:DropDownList>
                                                        </div>
                                                    </td>
                                                    <td></td>
                                                </tr>

                                                <tr>
                                                    <td></td>
                                                    <td>

                                                        <asp:CheckBox ID="chkCliente" runat="server" Text="Cliente" Visible="False" /><asp:CheckBox ID="chkProveedor" runat="server" Text="Proveedor" Visible="False" /><asp:CheckBox ID="chkEmpleado" runat="server" Text="Empleado" Visible="False" /><asp:CheckBox ID="chkAccionista" runat="server" Text="Accionista" Visible="False" /><asp:CheckBox ID="chkContratista" runat="server" Text="Contratista" Visible="False" /><asp:CheckBox ID="chkExtractora" runat="server" Text="Extractora" Visible="False" /></td>
                                                    <td></td>
                                                </tr>





                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </asp:TabPanel>
                                <asp:TabPanel ID="TabPanel1" runat="server" HeaderText="TabPanel1">
                                    <HeaderTemplate>
                                        Contacto
                                    </HeaderTemplate>
                                    <ContentTemplate>
                                        <div class="label">
                                            <table cellpadding="0" cellspacing="0" class="ui-accordion">
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label17" runat="server" Text="Contácto" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtContacto" runat="server" CssClass="input" TabIndex="10" Visible="False" Width="330px"></asp:TextBox>
                                                    </td>
                                                    <td></td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label7" runat="server" Text="Teléfono" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtTelefono" runat="server" AutoPostBack="True" CssClass="input" TabIndex="12" Visible="False" Width="100px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label20" runat="server" Text="Fax" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtFax" runat="server" CssClass="input" TabIndex="13" Visible="False" Width="100px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>

                                                        <asp:Label ID="Label22" runat="server" Text="Ciudad" Visible="False"></asp:Label></td>
                                                    <td>
                                                        <div style="position: absolute; z-index: 99; margin-top: -11px;">
                                                            <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Height="20px" TabIndex="14" Visible="False" Width="300px"></asp:DropDownList>
                                                        </div>
                                                    </td>

                                                    <td>
                                                        <asp:Label ID="Label19" runat="server" Text="Dirección" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtDireccion" runat="server" AutoPostBack="True" CssClass="input" TabIndex="15" Visible="False" Width="100%"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="Label9" runat="server" Text="Barrio" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtBarrio" runat="server" CssClass="input" TabIndex="16" Visible="False" Width="250px"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label21" runat="server" Text="Email" Visible="False"></asp:Label>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="input" TabIndex="17" Visible="False" Width="250px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </ContentTemplate>
                                </asp:TabPanel>
                            </asp:TabContainer>
                        </td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="6" style="text-align: center"></td>
                    </tr>
                </table>
            </div>
            <div style="text-align: center">
                <div style="margin: 10px; padding: 5px; display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Edit">
                                <HeaderStyle BackColor="White" Width="20px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" Width="20px" />
                                <ItemStyle CssClass="items" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="id">
                                <HeaderStyle BackColor="White" BorderColor="White" BorderWidth="0px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="codigo" HeaderText="Código">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipoDocumento" HeaderText="TipDoc">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="TipoPer">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nit" HeaderText="Nit">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="dv" HeaderText="Dv">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="razonSocial" HeaderText="RazSocial">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="cliente" HeaderText="Cliente">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="proveedor" HeaderText="Proveedor">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="empleado" HeaderText="Empleado">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="extractora" HeaderText="Extractora">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="contratista" HeaderText="Contratista">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="activo" HeaderText="Activo">
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:CheckBoxField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>
            </div>
        </div>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
