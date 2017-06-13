<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TransaccionConfig.aspx.cs" Inherits="Admon_Padministracion_TiposTransaccionCampos" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admon</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <style type="text/css">
    
    </style>
</head>
<body class="principalBody">
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 950px">
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">Busqueda</td>
                    <td class="Campos">
                        <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td style="text-align: center" colspan="4">
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
            <table id="TABLE1" cellspacing="0" style="BORDER-TOP: silver thin solid; WIDTH: 950px; BORDER-BOTTOM: silver thin solid">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label2" runat="server" Text="Tipo de Transacción" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlTipoTransaccion" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="300px">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label1" runat="server" Text="Nivel Destino" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlNivelDestino" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="150px">
                        </asp:DropDownList>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label3" runat="server" Text="Formato Impresión" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtFormatoImpresion" runat="server" CssClass="input" Visible="False" Width="300px"></asp:TextBox>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label4" runat="server" Text="Ds Referencia Detalle" Visible="False"></asp:Label>
                    </td>
                    <td class="Campos">
                        <asp:TextBox ID="txtDsReferenciaDetalle" runat="server" CssClass="input" Visible="False" Width="300px"></asp:TextBox>
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes">&nbsp;</td>
                    <td class="nombreCampos">
                        <asp:CheckBox ID="chkTipoLiquidacionNomina" runat="server" OnCheckedChanged="chkLiquidacion_CheckedChanged" Text="Liquidacion Nomina" AutoPostBack="True" Visible="False" />
                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlTipoLiquidacionNomina" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False" Width="150px">
                            <asp:ListItem Value="1">Liquidación Definitiva</asp:ListItem>
                            <asp:ListItem Value="2">Cesantías</asp:ListItem>
                            <asp:ListItem Value="3">Interes Cesantías</asp:ListItem>
                            <asp:ListItem Value="4">Primas</asp:ListItem>
                            <asp:ListItem Value="5">Consolidado Vacaciones</asp:ListItem>
                            <asp:ListItem Value="6">Acumulados</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td class="bordes">&nbsp;</td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkAjuste" runat="server" Text="Ajuste" Visible="False" />
                        <asp:CheckBox ID="chkEstudioCompra" runat="server" Text="Estudio Compra" Visible="False" />
                        <asp:CheckBox ID="chkSalida" runat="server" Text="Salida" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkRegistroProveedor" runat="server" Text="Valida Proveedor" Visible="False" />
                        <asp:CheckBox ID="chkValidaSaldo" runat="server" Text="Valida Saldo" Visible="False" />
                        <asp:CheckBox ID="chkVigencia" runat="server" Text="Vigencia" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkReferenciaTercero" runat="server" Text="Tercero en Ds Referencia" Visible="False" />
                        <asp:CheckBox ID="chkDias" runat="server" Text="Activar Días" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkPdesEditable" runat="server" Text="pDescuento Editable" Visible="False" />
                        <asp:CheckBox ID="chkCantidadEditable" runat="server" Text="Cantidad Editable" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkVunitarioEditable" runat="server" Text="Vl. Unitario Editable" Visible="False" />
                        <asp:CheckBox ID="chkUmedidaEditable" runat="server" Text="uMedida Editable" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkPivaEditable" runat="server" Text="% I.V.A Editable" Visible="False" />
                        <asp:CheckBox ID="chkFecha" runat="server" Text="Fecha Editable" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkManejaTalonario" runat="server" Text="Maneja Talonario" Visible="False" />
                        <asp:CheckBox ID="chkConsignacion" runat="server" Text="Consignación" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkManejaBodega" runat="server" Text="Maneja Bodega" Visible="False" />
                        <asp:CheckBox ID="chkRegistroDirecto" runat="server" Text="Registro Directo" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkDocumento" runat="server" Text="Maneja Documento" Visible="False" />
                        <asp:CheckBox ID="chkEntradaDirecta" runat="server" Text="Entrada Directa" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td class="bordes"></td>
                    <td class="nombreCampos"></td>
                    <td class="Campos">
                        <asp:CheckBox ID="chkLiberaReferencia" runat="server" Text="Libera Referencia" Visible="False" />
                        <asp:CheckBox ID="chkManejaBascula" runat="server" Text="Maneja Bascula" Visible="False" />
                    </td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>

            <div style="margin: 10px">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" Width="1200px" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="20">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Edit">
                                <HeaderStyle Width="20px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imbEliminar" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <HeaderStyle Width="20px" />
                                <ItemStyle CssClass="Items" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="tipoTransaccion" HeaderText="Tipo" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="nivelDestino" HeaderText="NivDes" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="formatoImpresion" HeaderText="ForImp">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="dsReferenciaDetalle" HeaderText="RefDetalle">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="ajuste" HeaderText="Ajuste">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="salida" HeaderText="Salida">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="validaSaldo" HeaderText="ValSald">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="referenciaTercero" HeaderText="TercDs">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="cantidadEditable" HeaderText="CantEdit">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="vUnitarioEditable" HeaderText="VlEdit">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="pIvaEditable" HeaderText="%IvaEdit">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="manejaTalonario" HeaderText="Tal">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="manejaBodega" HeaderText="Bodg">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="liberaReferencia" HeaderText="Libr">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="entradaDirecta" HeaderText="Diret">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="registroDirecto" HeaderText="Reg">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="consignacion" HeaderText="Consg">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="diaSemana" HeaderText="D&#237;as">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="manejaDocumento" HeaderText="Url">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="vigencia" HeaderText="Vig.">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="pDesEditable" HeaderText="%DesEdit">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="UmedidaEditable" HeaderText="umEdit">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="estudioCompra" HeaderText="ECO">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="registroProveedor" HeaderText="rProve">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="fechaActual" HeaderText="FechEdit">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="manejaBascula" HeaderText="Bascula">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="mTipoLiquidacionNomina" HeaderText="mTL">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="tipoLiquidacionNomina" HeaderText="TLN" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
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
