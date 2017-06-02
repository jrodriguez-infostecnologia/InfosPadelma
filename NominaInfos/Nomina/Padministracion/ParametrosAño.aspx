<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ParametrosAño.aspx.cs" Inherits="Nomina_Paminidtracion_ParametrosAño" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: left;">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
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
            <div>
                <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
            </div>
            <asp:UpdatePanel ID="upCabeza" runat="server" UpdateMode="Conditional" Visible="False">
                <ContentTemplate>
                    <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
                        <tr>
                            <td style="width: 400px">&nbsp;</td>
                            <td style="text-align: left; height: 8px;">
                                &nbsp;</td>
                            <td style="text-align: left">
                                &nbsp;</td>
                            <td style="width: 300px">&nbsp;</td>
                        </tr>
                        <tr>
                            <td style="width: 400px"></td>
                            <td style="text-align: left">
                                <asp:Label ID="Label1" runat="server" Text="Año" Visible="False"></asp:Label>
                            </td>
                            <td style="text-align: left">
                                <asp:DropDownList ID="ddlAño" runat="server" AutoPostBack="True" CssClass="input" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" Visible="False" Width="100px">
                                </asp:DropDownList>
                            </td>
                            <td style="width: 300px"></td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <div style="padding: 5px 10px 5px 10px; text-align: center">
                                    <div style="border: 1px solid silver; padding: 8px; display: inline-block;">
                                        <table cellpadding="0" cellspacing="0" style="width: 960px">
                                            <tr>
                                                <td style="width: 100px"></td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label6" runat="server" Text="Valor sueldo mínimo" Visible="False"></asp:Label></td>
                                                <td style="width: 220px; text-align: left;">
                                                    <asp:TextBox ID="txvSalarioMinimo" runat="server" Visible="False" Width="200px" CssClass="input" onkeyup="formato_numero(this)"></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label7" runat="server" Text="Valor auxilo transporte" Visible="False"></asp:Label></td>
                                                <td style="width: 220px; text-align: left;">
                                                    <asp:TextBox ID="txvAuxilioTransporte" runat="server" Visible="False" Width="200px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td style="width: 100px"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 100px">&nbsp;</td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label25" runat="server" Text="No SMLV para sub. transporte" Visible="False"></asp:Label>
                                                </td>
                                                <td style="width: 220px; text-align: left;">
                                                    <asp:TextBox ID="txvCantidadSMLV" runat="server" CssClass="input" MaxLength="2" onkeyup="formato_numero(this)" ToolTip="Número de salarios para sub. de transporte" Visible="False" Width="50px"></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label26" runat="server" Text="Pago minimo por periodo" Visible="False"></asp:Label>
                                                </td>
                                                <td style="width: 220px; text-align: left;">
                                                    <asp:TextBox ID="txvPagoMinPeriodo" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="200px"></asp:TextBox>
                                                </td>
                                                <td style="width: 100px">&nbsp;</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                                <div style="padding: 10px; text-align: left">
                                    <div style="border: 1px solid silver; padding: 8px; display: inline-block;">

                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                            <tr>
                                                <td style="font-size: 11px; width: 270px">
                                                    <asp:Label ID="Label8" runat="server" Text="Valor unidad tributaria (U.V.T)" Visible="False"></asp:Label></td>
                                                <td style="font-size: 11px; width: 120px">
                                                    <asp:TextBox ID="txvValorUVT" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 270px">
                                                    <asp:Label ID="Label9" runat="server" Text="Porcentaje exento de retención" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvPorcentajeRete" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 270px">
                                                    <asp:Label ID="Label10" runat="server" Text="Porcentaje máximo de aportes en pensión y AFC" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvPorcentajeMaximoAFC" runat="server" Visible="False" Width="120px" CssClass="input"  onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 270px">
                                                    <asp:Label ID="Label11" runat="server" Text="Patrimonio bruto (DIAN)" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvPatrimonioBruto" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 270px">
                                                    <asp:Label ID="Label12" runat="server" Text="Ingresos Brutos (DIAN)" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvIngresosBrutos" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 270px">
                                                    <asp:Label ID="Label13" runat="server" Text="Porc. Exento de pagos no Const. de salario L.1393" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvpExentoSalario1393" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                    <div style="width: 15px; display: inline-block;"></div>
                                    <div style="border: 1px solid silver; padding: 8px; display: inline-block;">

                                        <table cellpadding="0" cellspacing="0" class="auto-style1">
                                            <tr>
                                                <td style="font-size: 11px; width: 230px">
                                                    <asp:Label ID="Label3" runat="server" Text="Máximo valor exento" Visible="False"></asp:Label></td>
                                                <td style="font-size: 11px; width: 100px">
                                                    <asp:TextBox ID="txvValorMaxExento" runat="server" Visible="False" Width="80px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td style="font-size: 11px; width: 60px">
                                                    <asp:Label ID="Label18" runat="server" Text="(U.V.T) =" Visible="False"></asp:Label>
                                                </td>
                                                <td style="font-size: 11px;">
                                                    <asp:TextBox ID="txvUVT1" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 230px">
                                                    <asp:Label ID="Label4" runat="server" Text="Valor máx. de aporte en pensión y AFC" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvValorMaxAFC" runat="server" Visible="False" Width="80px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label19" runat="server" Text="(U.V.T) =" Visible="False"></asp:Label>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvUVT2" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 230px">
                                                    <asp:Label ID="Label14" runat="server" Text="Valor máx. de deducible por vivienda" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvValorMaxDeducible" runat="server" Visible="False" Width="80px" AutoPostBack="True" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label20" runat="server" Text="(U.V.T) =" Visible="False"></asp:Label>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvUVT3" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 230px">
                                                    <asp:Label ID="Label15" runat="server" Text="Valor máx. de pagos por salud" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvValorMaximoSalud" runat="server" Visible="False" Width="80px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label21" runat="server" Text="(U.V.T) =" Visible="False"></asp:Label>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvUVT4" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 230px; vertical-align: middle;">
                                                    <asp:Label ID="Label16" runat="server" Text="Valor de dependientes" Visible="False"></asp:Label>
                                                    <asp:TextBox ID="txvpDep" runat="server" Visible="False" Width="50px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvValorDependientes" runat="server" Visible="False" Width="80px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label22" runat="server" Text="(U.V.T) =" Visible="False"></asp:Label>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvUVT5" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="font-size: 11px; width: 230px">
                                                    <asp:Label ID="Label17" runat="server" Text="Valor minimo ingreso para declarante" Visible="False"></asp:Label></td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvValorMinimoIngresos" runat="server" Visible="False" Width="80px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:Label ID="Label23" runat="server" Text="(U.V.T) =" Visible="False"></asp:Label>
                                                </td>
                                                <td class="nombreCampos">
                                                    <asp:TextBox ID="txvUVT6" runat="server" Visible="False" Width="120px" CssClass="input" onkeyup="formato_numero(this)" ></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>

                                    </div>
                                </div>
                                <div style="padding: 5px; text-align: center">
                                    <div style="border: 1px solid silver; padding: 8px; display: inline-block;">
                                        <table cellpadding="0" cellspacing="0" style="width: 960px">
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:CheckBox ID="chkAplicaArt385" runat="server" Text="Aplicar Art. 385 Regimen de impuesto a la renta" Visible="False" /></td>
                                                <td style="text-align: left">
                                                    <asp:CheckBox ID="chkRestaIncapacidad" runat="server" Text="Resta Incapadiades de los ingresos base retefuente" Visible="False" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:CheckBox ID="chkSalarioIntegral" runat="server" Text="Salario Integral toma base pagos no const. de salario (70%)" Visible="False" />
                                                </td>
                                                <td style="text-align: left">
                                                    <asp:CheckBox ID="chkDiasTNL" runat="server" Text="Días TNL entre periodos suma para calculo deducible" Visible="False" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>

                                <div style="padding: 5px; text-align: center">
                                    <div style="border: 1px solid silver; padding: 8px; display: inline-block;">
                                        <table cellpadding="0" cellspacing="0" style="width: 960px">
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:Label ID="Label24" runat="server" Text="Observaciones" Visible="False"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: left">
                                                    <asp:TextBox ID="txtObservacion" runat="server" Visible="False" Width="950px" CssClass="input" Height="60px" TextMode="MultiLine"></asp:TextBox>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlAño" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>
            <div style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"> <asp:Label ID="nilblMensaje" runat="server"></asp:Label></div>
            <div class="tablaGrilla">
                <div style="display: inline-block">
                    <asp:GridView ID="gvLista" runat="server" Width="800px" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" AllowPaging="True" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging1">
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
                            <asp:BoundField DataField="ano" HeaderText="Año" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vSalarioMinimo" HeaderText="SalarioMinimo" ReadOnly="True"
                                SortExpression="descripcion">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vAuxilioTransporte" HeaderText="vAuxilioTransporte" ReadOnly="True"
                                SortExpression="descripcion">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Observacion" HeaderText="Observación" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vUVT" HeaderText="vUVT" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vPatrimonioBruto" HeaderText="vPatrimonioBruto" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vIngresoBruto" HeaderText="vIngresoBruto" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pExentoRetencion" HeaderText="pExentoRetencion" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pMaximoaportePension" HeaderText="pMaximoaportePension" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pExentoSalario1393" HeaderText="pExentoSalario1393" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pDependientes" HeaderText="pDependientes" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vMaximoExento" HeaderText="vMaximoExento" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vMaxAporteAFC" HeaderText="vMaxAporteAFC" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vMaxDeducibleVivienda" HeaderText="vMaxDeducibleVivienda" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vDependientes" HeaderText="vDependientes" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vMinimoingresosDeclarante" HeaderText="vMinimoingresosDeclarante" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vUVT1" HeaderText="vUVT1" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vUVT2" HeaderText="vUVT2" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vUVT3" HeaderText="vUVT3" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vUVT4" HeaderText="vUVT4" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vUVT5" HeaderText="vUVT5" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="vUVT6" HeaderText="vUVT6" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="cAplicarArt385" HeaderText="cAplicarArt385">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="cSalarioIntegral" HeaderText="cSalarioIntegral">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="cRestaIncapacidad" HeaderText="cRestaIncapacidad">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                            <asp:CheckBoxField DataField="cDiasTNL" HeaderText="cDiasTNL">
                                <ItemStyle HorizontalAlign="Center" Width="40px" CssClass="Items" />
                            </asp:CheckBoxField>
                              <asp:BoundField DataField="vUVT1" HeaderText="vUVT1" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                              <asp:BoundField DataField="vMinimoPeriodo" HeaderText="vPMP" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                              <asp:BoundField DataField="noSueldoST" HeaderText="noSST" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                              <asp:BoundField DataField="vMaxPagoSalud" HeaderText="VMPS" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
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
