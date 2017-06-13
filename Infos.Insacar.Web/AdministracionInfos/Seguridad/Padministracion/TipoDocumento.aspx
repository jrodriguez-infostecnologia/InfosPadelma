<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TipoDocumento.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1"  %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Agron�mico</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
</head>


<body class="principalBody">
    <form id="form1" runat="server">
    <div class="principal">
        <table cellspacing="0" style="width: 950px">
            <tr>
                <td class="bordes">
                </td>
                <td class="nombreCampos" >
                    Busqueda</td>
                <td class="Campos" >
                    <asp:TextBox ID="nitxtBusqueda" runat="server" Width="300px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                <td class="bordes">
                </td>
            </tr>
            <tr>
                <td style="text-align: center" colspan="4">
                    <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click" 
                        onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" 
                        onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'"
                         />
                    <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="lbNuevo_Click"
                        onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'" 
                        onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'"   />
                     <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operaci�n" OnClick="lbCancelar_Click"
                        onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" 
                        onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False"                         />
                   
                    <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos" 
                        onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'" 
                        onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};"   />
                </td>
            </tr>
        </table>
        <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1">
            <tr>
                <td style="height: 15px;  text-align: center;" colspan="4">
                    <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                   
                    </td>
            </tr>
            <tr>
                <td class="bordes" >
                </td>
                <td class="nombreCampos" >
                    <asp:Label ID="Label1" runat="server" Text="C�digo" Visible="False" CssClass="label"></asp:Label></td>
                <td class="Campos" >
                    <asp:TextBox ID="txtCodigo" runat="server" Visible="False" Width="200px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input" ></asp:TextBox></td>
                <td class="bordes" >
                </td>
            </tr>
            <tr>
                <td >
                </td>
                <td class="nombreCampos" >
                    <asp:Label ID="Label2" runat="server" Text="Descripci�n" Visible="False" CssClass="label"></asp:Label></td>
                <td class="Campos" >
                    <asp:TextBox ID="txtDescripcion" runat="server" Visible="False" Width="350px" CssClass="input"></asp:TextBox></td>
                <td >
                </td>
            </tr>
            <tr>
                <td >
                    </td>
                <td class="nombreCampos" >
                    <asp:Label ID="Label3" runat="server" CssClass="label" Text="Abreviatura" Visible="False"></asp:Label>
                </td>
                <td class="Campos" >
                    <asp:TextBox ID="txtAbreviatura" runat="server" CssClass="input" Visible="False" Width="100px" MaxLength="3"></asp:TextBox>
                </td>
                <td >
                    </td>
            </tr>
            <tr>
                <td >
                    </td>
                <td class="nombreCampos" >
                    <asp:Label ID="Label4" runat="server" CssClass="label" Text="C�digo TD" Visible="False"></asp:Label>
                </td>
                <td class="Campos" >
                    <asp:TextBox ID="txvCodigoTD" runat="server" CssClass="input" Visible="False" Width="100px" MaxLength="3"></asp:TextBox>
                </td>
                <td >
                    </td>
            </tr>
            <tr>
                <td colspan="4" >
                    <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                </td>
            </tr>
        </table>

        <div class="tablaGrilla">
            <div style="display:inline-block"> 
                    <asp:GridView ID="gvLista" runat="server" AllowPaging="True" AutoGenerateColumns="False" CssClass="Grid" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" PageSize="20" Width="800px" OnPageIndexChanging="gvLista_PageIndexChanging">
                        <AlternatingRowStyle CssClass="alt" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Edit">
                            <HeaderStyle BackColor="White" />
                            <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" />
                                <ItemStyle Width="20px" CssClass="Items" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="codigo" HeaderText="C�digo" >
                            <ItemStyle Width="70px" CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcion" HeaderText="Descripci�n" >
                            <ItemStyle CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="descripcionCorta" HeaderText="Abreviatura" >
                            <ItemStyle Width="70px" CssClass="Items" />
                            </asp:BoundField>
                            <asp:BoundField DataField="codigoTD" HeaderText="CodigoTD" >
                            <ItemStyle Width="30px" CssClass="Items" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
            </div>
        </div>
          
    </div>
    </form>
</body>
</html>
