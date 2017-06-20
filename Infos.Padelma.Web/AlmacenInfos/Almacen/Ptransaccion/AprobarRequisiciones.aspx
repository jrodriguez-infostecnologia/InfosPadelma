<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AprobarRequisiciones.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" Theme="Entidades" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<script type="text/javascript">

    function formato(entrada)
    {        
        if(window.event.keyCode != 9)
        {
            var num = entrada.value.replace(/\,/g,'');
          
            if(!isNaN(num))
            {
                num = num.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g,'$1,');
                num = num.split('').reverse().join('').replace(/^[\,]/,'');
                entrada.value = num;
            }        
            else
            {
                alert('Solo se permiten números');
                entrada.value = entrada.value.replace(/[^\d\.\,]*/g,'');
            }
        }            
    }
    
    function VerMovimiento(numero)
    {                                                             
        var direccion = "VerUltimasCompras.aspx?numero=" + numero ;                                                                
        var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width = 1200, height = 600, top = 0, left = 20";
        x = window.open(direccion,"",opciones);                                                               
        x.focus();                                                                                             
    }

</script>

<head runat="server">
    <title>Contabilidad</title>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div style="vertical-align: top; width: 1000px; height: 600px; text-align: center">
        <table cellspacing="0" style="width: 1000px">
            <tr>
                <td style="background-image: url(../../Imagenes/botones/BotonIzq.png);
                    width: 250px; background-repeat: no-repeat; text-align: left; height: 23px;">
                    </td>
                <td style="width: 500px; text-align: center; height: 23px;">
                    Aprobación de Requisiciones&nbsp;
                    <asp:ImageButton ID="imbActualizar" runat="server" Height="17px" ImageUrl="~/Imagenes/botones/Refresh.png"
                        OnClick="imbActualizar_Click" ToolTip="Clic aquí para actualizar el listado de requisiciones"
                        Width="17px" /></td>
                <td style="background-image: url(../../Imagenes/botones/BotonDer.png);
                    width: 250px; background-repeat: no-repeat; text-align: left; background-position-x: right; height: 23px;">
                    </td>
            </tr>
            <tr>
                <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px;
                    background-repeat: no-repeat; text-align: left">
                </td>
                <td style="width: 500px; text-align: center">
                    <asp:Label ID="nilblMensaje" runat="server"></asp:Label></td>
                <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png);
                    width: 250px; background-repeat: no-repeat; text-align: left">
                </td>
            </tr>
        </table>
        <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE2" onclick="return TABLE2_onclick()">
            <tr>
                <td style="width: 500px; text-align: center">
                </td>
            </tr>
            <tr>
                <td style="width: 500px; text-align: center">
                    <asp:GridView ID="gvLista" runat="server" Width="1000px" GridLines="None" AutoGenerateColumns="False" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" OnRowUpdating="gvLista_RowUpdating">
                        <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                        <AlternatingRowStyle BackColor="#E0E0E0" />
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:ImageButton ID="imbAprobar" runat="server" CommandName="Select" Height="17px"
                                        ImageUrl="~/Imagenes/botones/Asignar1.png" ToolTip="Clic aquí para aprobar la requisición"
                                        Width="17px" />
                                    <asp:ImageButton ID="imbGuardar" runat="server" CommandName="Update" Height="17px"
                                        ImageUrl="~/Imagenes/botones/Btn_Guardar.PNG" ToolTip="Clic aquí para aprobar la requisición"
                                        Width="17px" OnClientClick="if(!confirm('Desea aprobar la requisición ?')){return false;};" Visible="False"  />
                                                <asp:LinkButton ID="lbVerUltimas" runat="server" Visible="False" OnClick="lbVerUltimas_Click">Ver ultimas compras</asp:LinkButton>
                                                <asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="False"
                                            GridLines="None" Visible="False" Width="800px" >
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCantidad" runat="server" Width="50px" Text=<%# Bind("cantidad") %> AutoPostBack="True" OnDataBinding="txtCantidad_DataBinding" OnTextChanged="txtCantidad_TextChanged"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="White" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="producto" HeaderText="Producto">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="descripcion" HeaderText="Descripci&#243;n">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="referencia" HeaderText="Referencia">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="uMedida" HeaderText="U. Medida">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="descripcionDestino" HeaderText="Destino">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="registro">
                                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                    <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                        HorizontalAlign="Center" />
                                                </asp:BoundField>
                                            </Columns>
                                            <HeaderStyle BackColor="FloralWhite" />
                                        </asp:GridView>
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" />
                                <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                    HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="numero" HeaderText="N&#250;mero" ReadOnly="True" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="usuario" HeaderText="Realizado Por">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left"
                                    VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="observacion" HeaderText="Observaciones" ReadOnly="True" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                        </Columns>
                        <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        <FooterStyle BackColor="#FFFFC0" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="width: 500px; text-align: center">
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
