<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Funcionarios.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" %>
<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>
<%@ Register Src="../Control/Calendario.ascx" TagName="Calendario" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>

    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <style type="text/css">
        BODY {
            font-family: verdana, arial, helvetica;
        }

        .calTitle {
            font-weight: bold;
            font-size: 11px;
            background-color: #cccccc;
            color: black;
            width: 90px;
        }

        .calTitleAño {
            font-weight: bold;
            font-size: 11px;
            background-color: #cccccc;
            color: black;
            width: 60px;
        }

        .calBody {
            font-size: 11px;
            border-width: 10px;
        }
    </style>

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; text-align: left;"></td>
                    <td style="width: 100px; text-align: left">Busqueda</td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; text-align: right; background-position-x: right;"></td>
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
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" Style="height: 21px" />

                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />

                        <asp:ImageButton ID="lbImprimir" runat="server" ImageUrl="~/Imagen/Bonotes/btnImprimir.png" ToolTip="Imprime Carnet"
                            onmouseout="this.src='../../Imagen/Bonotes/btnImprimir.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnImprimirN.png'" OnClick="lbImprimir_Click" Visible="False" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>

            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="vertical-align: top">
                        <div style="width: 190px; padding: 10px">
                            <asp:Image ID="imbFuncionario" runat="server" Height="220px" Visible="False" Width="180px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </div>
                    </td>
                    <td style="vertical-align: top; width: 20px"></td>
                    <td style="vertical-align: top; width: 800px">
                        <table cellspacing="0" style="width: 800px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                            <tr>
                                <td style="text-align: left; height: 20px;"></td>
                                <td style="text-align: left">
                                    <asp:CheckBox ID="chkManejaTercero" runat="server" AutoPostBack="True" OnCheckedChanged="chkManejaTercero_CheckedChanged1" Text="Crear Tercero" Visible="False" />
                                </td>
                                <td class="auto-style11"></td>
                            </tr>
                            <tr>
                                <td style="text-align: left" colspan="2">
                                    <asp:Panel ID="pnTercero" runat="server" Visible="False">
                                        <fieldset>
                                            <legend>Información del tercero</legend>
                                            <table cellspacing="0" style="" width="100%">
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="Label23" runat="server" Text="Código"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:TextBox ID="txtCodigo" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txtCodigo_TextChanged" onkeyup="formato_numero(this)" TabIndex="1" Width="150px"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="Label5" runat="server" Text="Tipo Identificación"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:DropDownList ID="ddlTipoID" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Height="20px" TabIndex="2" Width="300px" Enabled="False">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="Label4" runat="server" Text="Nro. Identificacion"></asp:Label>
                                                    </td>
                                                    <td class="Campos" valign="middle">
                                                        <asp:TextBox ID="txtDocumento" runat="server" CssClass="input" TabIndex="3" Width="200px"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos" valign="middle"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="lblPrimerApellido" runat="server" Text="Primer Apellido"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:TextBox ID="txtApellido1" runat="server" CssClass="input" TabIndex="5" Width="220px"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="lblSegundoApellido" runat="server" Text="Segundo Apellido"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:TextBox ID="txtApellido2" runat="server" CssClass="input" TabIndex="6" Width="220px"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="lblPrimerNombre" runat="server" Text="Primer Nombre"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:TextBox ID="txtNombre1" runat="server" CssClass="input" TabIndex="7" Width="220px"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="lblSegundoNombre" runat="server" Text="Segundo Nombre"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:TextBox ID="txtNombre2" runat="server" CssClass="input" TabIndex="7" Width="220px"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="lblSegundoNombre0" runat="server" Text="Teléfono"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:TextBox ID="txtTelefono" runat="server" CssClass="input" TabIndex="7" Width="180px" MaxLength="15"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos"></td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="lblDireccion" runat="server" Text="Dirección"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:TextBox ID="txtDireccion" runat="server" CssClass="input" TabIndex="7" Width="400px"></asp:TextBox>
                                                    </td>
                                                    <td class="Campos"></td>
                                                </tr>
                                                <tr>
                                                    <td class="nombreCampos">&nbsp;</td>
                                                    <td class="nombreCampos">
                                                        <asp:Label ID="Label22" runat="server" Text="Ciudad" Visible="False"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:DropDownList ID="ddlCiudad" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Height="20px" TabIndex="14" Visible="False" Width="300px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="Campos">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td colspan="2"></td>
                                                    <td></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </asp:Panel>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="lblTercero" runat="server" Text="Tercero" Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlTercero" runat="server" Width="350px" AutoPostBack="True" OnSelectedIndexChanged="ddlFuncionario_SelectedIndexChanged" Visible="False" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="lblIdentifiacion" runat="server" Text="Identificación" Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:TextBox ID="txtIdentificacion" runat="server" CssClass="input" Width="150px" Visible="False"></asp:TextBox>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="lblDescripcion" runat="server" Text="Descripción" Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:TextBox ID="txtDescripcion" runat="server" CssClass="input" Width="350px" Visible="False"></asp:TextBox>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:LinkButton ID="lbFecha" runat="server" OnClick="lbFecha_Click" Style="color: #003366" Visible="False">Fecha nacimiento</asp:LinkButton>
                                </td>
                                <td class="Campos">
                                    <asp:Calendar ID="niCalendarFechaNacimiento" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaSalida_SelectionChanged" Visible="False" Width="150px">
                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                        <NextPrevStyle VerticalAlign="Bottom" />
                                        <OtherMonthDayStyle ForeColor="Gray" />
                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                        <SelectorStyle BackColor="#CCCCCC" />
                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                        <WeekendDayStyle BackColor="FloralWhite" />
                                    </asp:Calendar>
                                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" AutoPostBack="True" Visible="False" OnTextChanged="txtFecha_TextChanged"></asp:TextBox>
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="Label15" runat="server" Text="Ciudad nacimiento"
                                        Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlCiudadNacimineto" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="Label9" runat="server" Text="Grupo Sanguineo"
                                        Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlRh" runat="server" Visible="False" Width="150px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="Label14" runat="server" Text="Sexo"
                                        Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlSexo" runat="server" Visible="False" Width="150px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                        <asp:ListItem Value="F">Femenino</asp:ListItem>
                                        <asp:ListItem Value="M">Masculino</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="Label18" runat="server" Text="Nivel Educativo"
                                        Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlNivelEducativo" runat="server" Visible="False" Width="350px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="Label16" runat="server" Text="Proveedor"
                                        Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlProveedor" runat="server" Visible="False" Width="350px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="Label17" runat="server" Text="Cliente"
                                        Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlCliente" runat="server" Visible="False" Width="350px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:Label ID="Label11" runat="server" Text="Plantilla" Visible="False"></asp:Label></td>
                                <td class="Campos">
                                    <asp:DropDownList ID="ddlPlantilla" runat="server" Visible="False" Width="150px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                                        <asp:ListItem Value="0">Plantilla 1</asp:ListItem>
                                        <asp:ListItem Value="1">Plantilla 2</asp:ListItem>
                                        <asp:ListItem Value="2">Plantilla 3</asp:ListItem>
                                    </asp:DropDownList></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left">
                                    <asp:CheckBox ID="chkValidaFoto" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="chkValidaFoto_CheckedChanged" Text="Maneja Foto" Visible="False" />
                                </td>
                                <td class="Campos">
                                    <asp:FileUpload ID="fuFoto" runat="server" ToolTip="Haga clic para cargar la foto del funcionario seleccionado"
                                        Visible="False" Width="360px" /></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left"></td>
                                <td class="Campos">
                                    <asp:CheckBox ID="chkValidaTurno" runat="server" Text="Genera horas extras" Visible="False" />
                                    <asp:CheckBox ID="chkConductor" runat="server" Text="Conductor Interno" Visible="False" />
                                    <asp:CheckBox ID="chkOperador" runat="server" Text="Operador Logístico" Visible="False" />
                                    <asp:CheckBox ID="chkDeclarante" runat="server" Text="Declarante" Visible="False" />
                                    <asp:CheckBox ID="chkExtranjero" runat="server" Text="Extranjero" Visible="False" />
                                </td>
                                <td></td>
                            </tr>
                            <tr>
                                <td style="width: 150px; text-align: left"></td>
                                <td class="Campos">
                                    <asp:CheckBox ID="chkContratista" runat="server" Text="Contratista" Visible="False" AutoPostBack="True" OnCheckedChanged="chkContratista_CheckedChanged" />
                                    <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" AutoPostBack="True" OnCheckedChanged="chkActivo_CheckedChanged" />
                                </td>
                                <td></td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>

            <br />
            <div style="text-align: center">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="900px" GridLines="None" CssClass="Grid" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging">
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
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tercero" HeaderText="Tercero" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n" ReadOnly="True"
                                SortExpression="descripcion">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaNacimiento" HeaderText="FechaN" DataFormatString="{0:dd/MM/yyy}">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ciduadNacimiento" HeaderText="CiudadN">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sexo" HeaderText="Sexo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="rh" HeaderText="Rh">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="nivelEducativo" HeaderText="NEducativo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="proveedor" HeaderText="Proveedor">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="cliente" HeaderText="Cliente">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="20px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="validaTurno" HeaderText="Turno">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="conductor" HeaderText="Cond">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="operadorLogistico" HeaderText="Port">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="extranjero" HeaderText="Extr">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="declarante" HeaderText="Decl">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="contratista" HeaderText="Con" />
                            <asp:CheckBoxField DataField="activo" HeaderText="Activo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
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
