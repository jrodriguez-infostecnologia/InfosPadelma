<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Periodos.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Contabilidad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
   
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
     <div style="vertical-align: top; width: 1000px; text-align: center; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 12px; color: #003366;">
 <table cellspacing="0" style="width: 1000px">
            <tr>
                <td class="bordes">
                   </td>
                <td class="nombreCampos">
                    Busqueda</td>
                <td style="width: 350px; height: 25px; text-align: left">
                    <asp:TextBox ID="nitxtBusqueda" runat="server" Width="350px" ToolTip="Escriba el texto para la busqueda" CssClass="input"></asp:TextBox></td>
                 <td class="bordes">
                   </td>
            </tr>
            <tr>
                
                <td style="text-align: center; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;" colspan="4">
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
  
        <table cellspacing="0" style="width: 1000px">
            <tr>
                <td class="bordesPeque">
                </td>
                <td>
                    <asp:LinkButton ID="nilbAbrirAnos" runat="server" ForeColor="#003366" OnClick="nilbAbrirAnos_Click"
                        ToolTip="Clic aquí para abrir los periodos de un año determinado">Abrir/Cerrar Periodos Año</asp:LinkButton>
                    
                    &nbsp;<asp:LinkButton ID="nilbEliminarPeriodos" runat="server" ForeColor="#003366" OnClick="lbEliminarPeriodos_Click"
                        ToolTip="Clic aquí para eliminar los periodos de un año determinado">Eliminar Periodos Año</asp:LinkButton></td>
                <td class="bordesPeque">
                </td>
            </tr>
            <tr>
                <td class="bordesPeque">
                    </td>
                <td style="text-align:center; height: 10px;">
                    </td>
                <td class="bordesPeque">
                    </td>
            </tr>
            <tr>
                <td class="bordesPeque">
                </td>
                <td style="text-align:center">
                    <div style="display:inline-block">
                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                        <tr>
                            <td>
                                <asp:Label ID="nilblOperacion" runat="server" Visible="False"></asp:Label></td>
                            <td style="text-align: left">
                    
                    <asp:DropDownList ID="niddlAno" runat="server" Visible="False" Width="100px" CssClass="input">
                    </asp:DropDownList>
                    
                    <asp:TextBox ID="nitxtAno" runat="server" Visible="False" Width="100px" CssClass="input"></asp:TextBox>
                                <asp:CheckBox ID="nichkCerrarAño" runat="server" Text="Cerrado" Visible="False" /></td>
                            <td style="text-align: left">
                        
                        <asp:ImageButton ID="nilbEjecutar" runat="server" ImageUrl="~/Imagen/Bonotes/btnEjecutar.png" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="nilbEjecutar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnEjecutar.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnEjecutarN.png'" Visible="False" />
                                
                        <asp:ImageButton ID="nilblCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="nilblCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" />

                            </td>
                        </tr>
                        </table>
                        </div>
                </td>
                <td class="bordesPeque">
                </td>
            </tr>
            <tr>
                <td class="bordesPeque">
                    </td>
                <td style="text-align:center; height: 10px;">
                    </td>
                <td class="bordesPeque">
                    </td>
            </tr>
            </table>
        <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1" >
            <tr>
                <td colspan="6">
                    <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td class="nombreCampos">
                    <asp:Label ID="Label1" runat="server" Text="Año" Visible="False"></asp:Label></td>
                <td class="Campos">
                    <asp:TextBox ID="txvAño" runat="server" Visible="False" Width="100px" AutoPostBack="True" OnTextChanged="txtConcepto_TextChanged" CssClass="input" MaxLength="4"></asp:TextBox></td>
                <td class="nombreCampos">
                    <asp:Label ID="Label2" runat="server" Text="Mes" Visible="False"></asp:Label></td>
                <td class="Campos">
                    <asp:DropDownList ID="ddlMes" runat="server" CssClass="input" Visible="False" Width="100px">
                        <asp:ListItem Value="1">Enero</asp:ListItem>
                        <asp:ListItem Value="2">Febrero</asp:ListItem>
                        <asp:ListItem Value="3">Marzo</asp:ListItem>
                        <asp:ListItem Value="4">Abril</asp:ListItem>
                        <asp:ListItem Value="5">Mayo</asp:ListItem>
                        <asp:ListItem Value="6">Junio</asp:ListItem>
                        <asp:ListItem Value="7">Julio</asp:ListItem>
                        <asp:ListItem Value="8">Agosto</asp:ListItem>
                        <asp:ListItem Value="9">Septiembre</asp:ListItem>
                        <asp:ListItem Value="10">Octubre</asp:ListItem>
                        <asp:ListItem Value="11">Noviembre</asp:ListItem>
                        <asp:ListItem Value="12">Diciembre</asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                    </td>
                <td class="nombreCampos">
                    <asp:LinkButton ID="lbFechaIni" runat="server" ForeColor="#003366" OnClick="lbFechaIni_Click" Visible="False">Fecha inicial</asp:LinkButton>
                </td>
                <td class="Campos">
                    <asp:Calendar ID="CalendarFechaIni" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaIni_SelectionChanged" Visible="False" Width="150px">
                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                        <SelectorStyle BackColor="#CCCCCC" />
                        <WeekendDayStyle BackColor="FloralWhite" />
                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <OtherMonthDayStyle ForeColor="Gray" />
                        <NextPrevStyle VerticalAlign="Bottom" />
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                    </asp:Calendar>
                    <asp:TextBox ID="txtFechaIni" runat="server" class="input" Font-Bold="True" ReadOnly="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px"></asp:TextBox>
                    <asp:Label ID="Label20" runat="server" Text="(dd/MM/aaaa)" Visible="False"></asp:Label>
                </td>
                <td class="nombreCampos">
                    <asp:LinkButton ID="lbFechaFinal" runat="server" ForeColor="#003366" OnClick="lbFechaFinal_Click" Visible="False">Fecha final</asp:LinkButton>
                </td>
                <td class="Campos">
                    <asp:Calendar ID="CalendarFechaFinal" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaFinal_SelectionChanged" Visible="False" Width="150px">
                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                        <SelectorStyle BackColor="#CCCCCC" />
                        <WeekendDayStyle BackColor="FloralWhite" />
                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <OtherMonthDayStyle ForeColor="Gray" />
                        <NextPrevStyle VerticalAlign="Bottom" />
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                    </asp:Calendar>
                    <asp:TextBox ID="txtFechaFinal" runat="server" class="input" Font-Bold="True" ReadOnly="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px"></asp:TextBox>
                    <asp:Label ID="Label21" runat="server" Text="(dd/MM/aaaa)" Visible="False"></asp:Label>
                </td>
                <td style="width: 100px">
                    </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td class="nombreCampos">
                    </td>
                <td class="Campos">
                    <asp:CheckBox ID="chkCerrado" runat="server" Text="Periodo Cerrado." Visible="False" /></td>
                <td class="nombreCampos">
                    &nbsp;</td>
                <td class="Campos">
                    &nbsp;</td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td colspan="6">
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
                            <ItemStyle Width="20px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:ButtonField>
                            <asp:TemplateField HeaderText="Elim">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                </ItemTemplate>

                                <ItemStyle Width="20px" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="año" HeaderText="Año" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="30px" />
                            </asp:BoundField>

                            <asp:BoundField DataField="mes" HeaderText="Mes">
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="20px" />
                            </asp:BoundField>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripcion" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                                <asp:BoundField DataField="periodo" HeaderText="Periodo" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="40px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaInicial" HeaderText="Fecha inicial" ReadOnly="True" DataFormatString="{0:dd/MM/yyy}">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaFinal" HeaderText="Fecha final" ReadOnly="True" DataFormatString="{0:dd/MM/yyy}">
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="80px" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="cerrado" HeaderText="Cerrado">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="20px" />
                            </asp:CheckBoxField>
                        </Columns>
                        <FooterStyle BackColor="FloralWhite" />
                        <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                        <AlternatingRowStyle BackColor="#E0E0E0" />
                   <PagerStyle CssClass="pgr" />
                        <RowStyle CssClass="rw" />
                    </asp:GridView>
            </div>
        </div>
    </div>
    
    </div>
    </form>
</body>
</html>
