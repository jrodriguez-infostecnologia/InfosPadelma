<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ListaPrecios.aspx.cs" Inherits="Agronomico_Padministracion_ListaPrecios" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <%-- Este es el estilo de combobox --%>

    <link href="../../css/chosen.css" rel="stylesheet" />
    <style type="text/css">
        a img {
            border: none;
        }

        ol li {
            list-style: decimal outside;
        }

        div#container {
            width: 780px;
            margin: 0 auto;
            padding: 1em 0;
        }

        div.side-by-side {
            width: 100%;
            margin-bottom: 1em;
        }

            div.side-by-side > div {
                float: left;
                width: 50%;
            }

                div.side-by-side > div > em {
                    margin-bottom: 10px;
                    display: block;
                }

        .clearfix:after {
            content: "\0020";
            display: block;
            height: 0;
            clear: both;
            overflow: hidden;
            visibility: hidden;
        }
        .auto-style1 {
            width: 250px;
            height: 18px;
        }
        .auto-style2 {
            text-align: left;
            height: 18px;
        }
    </style>

    <%-- Aqui termina el estilo es el estilo de combobox --%>

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div class="principal">

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
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                    </td>
                </tr>
            </table>

            <table cellpadding="0" cellspacing="0" style="width: 100%; border-bottom-style: solid; border-top-style: solid; border-top-width: 1px; border-bottom-width: 1px; border-top-color: silver; border-bottom-color: silver;">
                <tr>
                    <td colspan="4" height="8">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="auto-style1"></td>
                    <td>
                        </td>
                    <td class="auto-style2">
                            </td>
                    <td class="auto-style1"></td>
                </tr>
                <tr>
                    <td class="bordes">&nbsp;</td>
                    <td class="nombreCampos">
                        <asp:Label ID="Label11" runat="server" Text="Año:" Visible="False"></asp:Label>

                    </td>
                    <td class="Campos">
                        <asp:DropDownList ID="ddlAño" runat="server" CssClass="input" Width="100px" Visible="False" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" AutoPostBack="True">
                        </asp:DropDownList>

                    </td>
                    <td class="bordes">&nbsp;</td>
                </tr>
                <tr>
                    <td colspan="4" height="8">
                        <asp:Label ID="lblgvLineas" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div >
                <div style="display: inline-block">
                    
                    <asp:GridView ID="gvNovedades" runat="server" AutoGenerateColumns="False" CssClass="Grid" PageSize="30" OnPageIndexChanging="gvLista_PageIndexChanging" Visible="False" Width="950px">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:BoundField DataField="Novedad" HeaderText="idNovedad" ReadOnly="True">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="desNovedad" HeaderText="Novedad">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                                                       
                            <asp:TemplateField HeaderText="($) Destajo">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPrecioTerceros" runat="server" CssClass="input" onkeypress="formato_numero(this)" Text='<%# Eval("PrecioDestajo") %>' Width="80px"></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="($) Contratistas">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPrecioContratistas" runat="server" CssClass="input" onkeypress="formato_numero(this)" Text='<%# Eval("PrecioContratistas") %>'></asp:TextBox>
                                </ItemTemplate>
                                 <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="($) Otros">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPrecioOtros" runat="server" CssClass="input" onkeypress="formato_numero(this)" Text='<%# Eval("precioOtros") %>'></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="($) Porcentaje">
                                <ItemTemplate>
                                    <asp:TextBox ID="txtPorcentaje" runat="server" CssClass="input" onkeypress="formato_numero(this)" Text='<%# Eval("Porcentaje") %>'></asp:TextBox>
                                </ItemTemplate>
                                <ItemStyle Width="80px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="BaseSueldo" >
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkBaseSueldo" runat="server" Checked='<%# Eval("baseSueldo") %>' OnCheckedChanged="chkBaseSueldo_CheckedChanged" AutoPostBack="True"/>
                                </ItemTemplate>
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px"   Width="20px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
                </div>
            </div>

            <div class="tablaGrilla">
                <div style="display:inline-block">
                <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" PageSize="20" OnPageIndexChanging="gvLista_PageIndexChanging" OnSelectedIndexChanged="gvLista_SelectedIndexChanged">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:ButtonField ButtonType="Image" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón" CommandName="Select">
                            <ItemStyle Width="20px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                        </asp:ButtonField>
                        <asp:BoundField DataField="año" HeaderText="Año" />
                    </Columns>
                    <PagerStyle CssClass="pgr" />
                    <RowStyle CssClass="rw" />
                </asp:GridView>
                </div>
            </div>
        </div>

    </form>
         <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: false }); </script>
  
</body>
</html>
