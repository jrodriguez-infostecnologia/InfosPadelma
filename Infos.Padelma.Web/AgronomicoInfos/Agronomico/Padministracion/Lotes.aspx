<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Lotes.aspx.cs" Inherits="Agronomico_Padministracion_Lotes"  MaintainScrollPositionOnPostBack="True" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script charset="utf-8" type="text/javascript">
        var contador = 0;
    </script>



</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">

            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td width="250px"></td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td width="250px"></td>
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
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" style="height: 21px" />
                    </td>
                </tr>
            </table>
            <table cellpadding="0" cellspacing="0" style="width: 100%; border-bottom-style: solid; border-top-style: solid; border-top-width: 1px; border-bottom-width: 1px; border-top-color: silver; border-bottom-color: silver;">
                <tr>
                    <td colspan="6" height="8">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label11" runat="server" Text="Año Siembra" Visible="False"></asp:Label>

                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlAño" runat="server" CssClass="input" Width="100px" Visible="False" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>
                        <asp:Label ID="Label12" runat="server" Text="Mes Siembra" Visible="False"></asp:Label>
                        <asp:DropDownList ID="ddlMes" runat="server" CssClass="input" Width="100px" Visible="False">
                        </asp:DropDownList>

                    </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:Label ID="Label2" runat="server" Text="Código" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="150px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input" MaxLength="5" ToolTip="Campo de cinco (5) caracteres"></asp:TextBox>
                        <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                        <asp:CheckBox ID="chkDesarrollo" runat="server" Text="En desarrollo" Visible="False" />
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label3" runat="server" Text="Descripción" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtDescripcion" runat="server" Visible="False" Width="340px" CssClass="input" MaxLength="550"></asp:TextBox>

                    </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:Label ID="Label4" runat="server" Text="Finca" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList data-placeholder="Seleccione una opción..." ID="ddlFinca" runat="server" class="chzn-select" Width="350px" Visible="False">
                        </asp:DropDownList>

                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:CheckBox ID="chkSession" runat="server" Text="Sección" Visible="False" AutoPostBack="True" OnCheckedChanged="chkSession_CheckedChanged" ToolTip="Habilitar si el lote maneja sección" />
                    </td>
                    <td class="Campos">
                        <asp:DropDownList data-placeholder="Seleccione una opción..." ID="ddlSeccion" runat="server" CssClass="chzn-select" Width="350px" Visible="False">
                        </asp:DropDownList>

                    </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:Label ID="Label5" runat="server" Text="Variedad" Visible="False"></asp:Label>

                    </td>
                    <td class="Campos">
                        <asp:DropDownList data-placeholder="Seleccione una opción..." CssClass="chzn-select" ID="ddlVariedad" runat="server" Width="350px" Visible="False">
                        </asp:DropDownList>

                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label16" runat="server" Text="No. (Ha) brutas" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvHaBruta" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox>
                    </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:Label ID="Label79" runat="server" Text="Distancia Siembra" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvDistancia" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txvDistancia_TextChanged1" Visible="False" Width="150px" onkeyup="formato_numero(this)"></asp:TextBox>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label78" runat="server" Text="Densidad" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvDensidad" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox>
                    </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:Label ID="Label6" runat="server" Text="No Palmas brutas" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvPalmasBruta" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txvPalmasBruta_TextChanged1" Visible="False" Width="150px" onkeyup="formato_numero(this)"></asp:TextBox>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label83" runat="server" Text="No. (Ha) netas" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvHaNetas" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox>
                    </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:Label ID="Label8" runat="server" Text="Palmas Producción" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txvPalmasProduccion" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="txvPalmasProduccion_TextChanged1" Visible="False" Width="150px" onkeyup="formato_numero(this)"></asp:TextBox>
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td style="width: 20px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label81" runat="server" Text="Tipo Canal" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlTipoCanal" runat="server" Visible="False" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" >
                        </asp:DropDownList>
                        <asp:ImageButton ID="imbCargarCanal" runat="server" ImageUrl="~/Imagen/TabsIcon/reload.png" OnClick="imbCargarCanal_Click" Visible="False"
                            ToolTip="Cargar tipo de canales" style="height: 16px; width: 16px;" />
                    </td>
                    <td style="width: 150px; text-align: left;">
                        <asp:Label ID="Label10" runat="server" Text="No. de lineas" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtNoLinea" runat="server" Visible="False" Width="150px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox>
                        <asp:ImageButton ID="imbCargarLineas" runat="server" ImageUrl="~/Imagen/TabsIcon/reload.png" OnClick="imbCargar_Click" Visible="False"
                            ToolTip="Cargar el número de lineas que tiene el lote" />
                    </td>
                    <td style="width: 20px"></td>
                </tr>
                <tr>
                    <td colspan="6" height="8">
                        <asp:Label ID="lblgvLineas" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div style="padding:10px; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;">

                <div style="display: inline-block; padding: 0px 10px 0px 10px; vertical-align: top;">
                    <asp:GridView ID="gvCanal" runat="server" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvCanal_RowDeleting" PageSize="30" Width="310px" Visible="False">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imEliminaCanal" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="tipoCanal" HeaderText="TipoCanal" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="numero" HeaderText="No." ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="(mts)">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtMetros" runat="server" onkeyup="formato_numero(this)" Text='<%# Eval("metros") %>' CssClass="input" Width="100px"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>
                <div style="display: inline-block; padding: 0px 10px 0px 10px">
                    <asp:GridView ID="gvLineas" runat="server" AutoGenerateColumns="False" CssClass="Grid" PageSize="30" Width="250px" Visible="False" OnRowDeleting="gvLineas_RowDeleting">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imEliminaCanal" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="linea" HeaderText="Linea" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="NoPalmaBrutas">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtNoPalma" runat="server" onkeyup="formato_numero(this)" Text='<%# Eval("NoPalma") %>' CssClass="input"></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="N-S">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkOrden" runat="server" Checked='<%# Eval("Orden") %>' />
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>

            </div>

            <div style="padding: 10px">

                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" PageSize="20" Width="100%" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:ButtonField ButtonType="Image" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón" CommandName="Select">
                            <ItemStyle Width="20px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:ButtonField>
                        <asp:TemplateField HeaderText="Elim">
                            <ItemTemplate>
                                <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                            </ItemTemplate>
                            <HeaderStyle BackColor="White" />
                            <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="codigo" HeaderText="Código" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="finca" HeaderText="Finca">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="seccion" HeaderText="Sección">

                            <ItemStyle BorderColor="Silver" BorderWidth="1px" BorderStyle="Solid"></ItemStyle>
                        </asp:BoundField>
                        <asp:BoundField DataField="variedad" HeaderText="Variedad">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="palmasBrutas" HeaderText="PalmaBrut">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="palmasProduccion" HeaderText="PalmaProd">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>

                        <asp:BoundField DataField="añoSiembra" HeaderText="Año">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"  Width="30px"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="mesSiembra" HeaderText="Mes">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"  Width="20px"/>
                        </asp:BoundField>
                        <asp:BoundField DataField="NoLineas" HeaderText="NoLinea">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="palmasBrutas" HeaderText="PalmasB">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="palmasProduccion" HeaderText="PalmasP">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hBrutas" HeaderText="haBrutas">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                         <asp:BoundField DataField="hNetas" HeaderText="haNetas">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                         <asp:BoundField DataField="densidad" HeaderText="densidad">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dSiembra" HeaderText="dSiembra">
                            <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="activo" HeaderText="Act">
                            <ItemStyle HorizontalAlign="Center" Width="30px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:CheckBoxField>
                        <asp:CheckBoxField DataField="manejaSeccion" HeaderText="mSec">
                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="30px" />
                        </asp:CheckBoxField>
                        <asp:CheckBoxField DataField="desarrollo" HeaderText="Des">
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                        </asp:CheckBoxField>
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
