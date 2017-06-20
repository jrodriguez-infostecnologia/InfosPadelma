﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Procedencias.aspx.cs" Inherits="Seguridad_Poperaciones_Procedencias" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script type="text/javascript">
        javascript: window.history.forward(1);
    </script>
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script charset="utf-8" type="text/javascript">
        var contador = 0;
    </script>
    <style type="text/css">
        .auto-style1 {
            width: 250px;
            height: 24px;
        }
        .auto-style2 {
            text-align: left;
            height: 24px;
        }
        .auto-style3 {
            width: 360px;
            text-align: left;
            height: 24px;
        }
    </style>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">
            <div style="display: inline-block">
                <table cellspacing="0" style="width: 1000px">
                    <tr>
                        <td class="bordes"></td>
                        <td class="nombreCampos">Busqueda</td>
                        <td class="Campos">
                            <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                        <td class="bordes"></td>
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
                                onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" Style="height: 21px" />
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
                            <asp:Label ID="Label2" runat="server" Text="Código" Visible="False"></asp:Label>
                        </td>
                        <td class="Campos">
                            <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="150px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input"></asp:TextBox></td>
                        <td class="bordes"></td>
                    </tr>
                    <tr>
                        <td class="bordes"></td>
                        <td class="nombreCampos">
                            <asp:Label ID="lblProveedor" runat="server" Text="Proveedor" Visible="False"></asp:Label>
                        </td>
                        <td class="Campos">
                            <asp:DropDownList ID="ddlProveedor" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="350px" Visible="False">
                            </asp:DropDownList>
                        </td>
                        <td class="bordes"></td>
                    </tr>
                    <tr>
                        <td class="auto-style1"></td>
                        <td class="auto-style2">
                            <asp:Label ID="lblTercero" runat="server" Text="Agrupado Por" Visible="False"></asp:Label>
                        </td>
                        <td class="auto-style3">
                            <asp:DropDownList ID="ddlTercero" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="350px" Visible="False">
                            </asp:DropDownList>
                        </td>
                        <td class="auto-style1"></td>
                    </tr>
                    <tr>
                        <td class="bordes"></td>
                        <td class="nombreCampos">
                            <asp:Label ID="lblTercero0" runat="server" Text="Gran Mayor" Visible="False"></asp:Label>
                        </td>
                        <td class="Campos">
                            <asp:DropDownList ID="ddlTerceroMayor" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="350px" Visible="False">
                            </asp:DropDownList>
                        </td>
                        <td class="bordes"></td>
                    </tr>
                    <tr>
                        <td class="bordes"></td>
                        <td class="nombreCampos">
                            <asp:Label ID="lblProveedor0" runat="server" Text="Planta extractora" Visible="False"></asp:Label>
                        </td>
                        <td class="Campos">
                            <asp:DropDownList ID="ddlExtractora" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="350px" Visible="False">
                            </asp:DropDownList>
                        </td>
                        <td class="bordes"></td>
                    </tr>
                    <tr>
                        <td class="bordes"></td>
                        <td class="nombreCampos">
                            <asp:Label ID="lblProveedor1" runat="server" Text="Correos" Visible="False"></asp:Label>
                        </td>
                        <td class="Campos">
                            <asp:TextBox ID="txtCorreos" runat="server" Visible="False" Width="350px" AutoPostBack="True" CssClass="input" Height="80px" TextMode="MultiLine" ToolTip="Puede ingresar varios correos separados por punto y coma (;)"></asp:TextBox>
                        </td>
                        <td class="bordes"></td>
                    </tr>
                    <tr>
                        <td class="bordes"></td>
                        <td class="nombreCampos"></td>
                        <td class="Campos">
                            <asp:CheckBox ID="chkActivo" runat="server" Text="Activo" Visible="False" />
                        </td>
                        <td class="bordes"></td>
                    </tr>
                </table>
                <div style="text-align: center">
                    <div style="display: inline-block; padding: 5px 0px 5px 0px">
                        <asp:GridView ID="gvLista" runat="server" Width="1000px" GridLines="None" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1" OnRowDeleting="gvLista_RowDeleting" AutoGenerateColumns="False" CssClass="Grid" AllowPaging="True" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="20">
                            <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                            <AlternatingRowStyle BackColor="#E0E0E0" />
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
                                <asp:BoundField DataField="codigo" HeaderText="Código" ReadOnly="True">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="50px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="agrupadoPor" HeaderText="IdAgru" ReadOnly="True">
                                    <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                    <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DesAgrupado" HeaderText="AgrupadoPor">
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="proveedor" HeaderText="idPro">
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="desproveedor" HeaderText="Proveedor">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:BoundField DataField="extractora" HeaderText="idExt">
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="desExtractora" HeaderText="Extractora">
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="100px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="correo" HeaderText="Correos">
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="200px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="granMayor" HeaderText="idGM">
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="10px" />
                                </asp:BoundField>
                                <asp:BoundField DataField="desGranMayor" HeaderText="nombreGM">
                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:CheckBoxField DataField="activo" HeaderText="Act">
                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="5px" />
                                </asp:CheckBoxField>
                            </Columns>
                            <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                            <FooterStyle BackColor="LightYellow" />
                            <PagerStyle CssClass="pgr" />
                            <RowStyle CssClass="rw" />
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>

