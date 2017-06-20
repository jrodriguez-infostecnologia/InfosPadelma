<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Generacion.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" Theme="Entidades" %>

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
        var direccion = "VerMovimiento.aspx?numero=" + numero ;                                                                
        var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width = 1200, height = 600, top = 0, left = 20";
        x = window.open(direccion,"",opciones);                                                               
        x.focus();                                                                                             
    }

</script>

<head runat="server">
    <title>Legalizar almacen en consignación</title>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div style="vertical-align: top; width: 1000px; height: 600px; text-align: left">
        <table cellspacing="0" style="width: 1000px">
            <tr>
                <td style="background-image: url(../../Imagenes/botones/BotonIzq.png);
                    width: 250px; background-repeat: no-repeat; text-align: left;">
                    </td>
                <td style="width: 500px; text-align: center">
                    Generar requisición de salidas de almacen en consignación</td>
                <td style="background-image: url(../../Imagenes/botones/BotonDer.png);
                    width: 250px; background-repeat: no-repeat; text-align: left; background-position-x: right;">
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
        <table cellpadding="0" cellspacing="0" style="width: 1000px">
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 150px">
                    <asp:LinkButton ID="nilbNuevo" runat="server" ForeColor="#404040" OnClick="nilbNuevo_Click" ToolTip="Cilic aquí para realizar un nuevo estudio de compras">Nuevo >></asp:LinkButton><asp:LinkButton
                        ID="lbCancelar" runat="server" ForeColor="#404040" Visible="False" OnClick="lbCancelar_Click" ToolTip="Clic aquí para cancelar l aoperación"><< Cancelar</asp:LinkButton></td>
                <td style="width: 150px">
                </td>
                <td style="width: 350px; text-align: right;">
                    &nbsp;
                    &nbsp;&nbsp;
                </td>
                <td style="width: 150px">
                    <asp:LinkButton ID="nilbRegistrar" runat="server" ForeColor="#404040" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" OnClick="lbRegistrar_Click" ToolTip="Clic aquí para guardar el estudio de compras y generar las ordenes de compra">Generar Requicisión</asp:LinkButton></td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 10px;">
                </td>
                <td style="width: 150px; height: 10px;">
                </td>
                <td style="vertical-align: top; width: 150px; height: 10px;">
                </td>
                <td style="width: 350px; height: 10px;">
                </td>
                <td style="width: 150px; height: 10px;">
                </td>
                <td style="width: 100px; height: 10px;">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 19px">
                </td>
                <td style="width: 150px; height: 19px">
                </td>
                <td style="vertical-align: top; width: 150px; height: 19px">
                    <asp:Label ID="Label3" runat="server" Text="Periodo" Visible="False"></asp:Label></td>
                <td style="width: 350px; height: 19px">
                    <asp:DropDownList ID="ddlPeriodo" runat="server" Visible="False" Width="200px" AutoPostBack="True" >
                    </asp:DropDownList></td>
                <td style="width: 150px; height: 19px">
                </td>
                <td style="width: 100px; height: 19px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 30px;">
                </td>
                <td style="width: 150px; height: 30px;">
                </td>
                <td style="vertical-align: middle; width: 150px; height: 30px;">
                    <asp:Label ID="Label2" runat="server" Text="Proveedor" Visible="False"></asp:Label></td>
                <td style="width: 350px; height: 30px;">
                    <asp:DropDownList ID="ddlProveedor" runat="server" Visible="False" Width="400px" AutoPostBack="True" >
                    </asp:DropDownList></td>
                <td style="width: 150px; height: 30px;">
                </td>
                <td style="width: 100px; height: 30px;">
                </td>
            </tr>
            <tr>
                <td style="width: 100px">
                </td>
                <td style="width: 150px">
                </td>
                <td style="vertical-align: top; width: 150px">
                    <asp:Label ID="Label1" runat="server" Text="Observaciones" Visible="False"></asp:Label></td>
                <td style="width: 350px">
                    <asp:TextBox ID="txtObservaciones" runat="server" TextMode="MultiLine" Visible="False"
                        Width="400px"></asp:TextBox></td>
                <td style="width: 150px">
                </td>
                <td style="width: 100px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 11px">
                </td>
                <td style="width: 150px; height: 11px">
                </td>
                <td style="vertical-align: top; height: 11px; text-align: center;" colspan="2">
                    <asp:Label ID="nilblresultado" runat="server"></asp:Label></td>
                <td style="width: 150px; height: 11px">
                </td>
                <td style="width: 100px; height: 11px">
                </td>
            </tr>
            <tr>
                <td style="width: 100px; height: 33px;">
                </td>
                <td style="width: 150px; height: 33px;">
                </td>
                <td style="vertical-align: top; width: 150px; height: 33px;">
                </td>
                <td style="width: 350px; height: 33px;">
                    <asp:Button ID="btnVer" runat="server" OnClick="Button1_Click" Text="Ver Salidas AC" Visible="False" /></td>
                <td style="width: 150px; height: 33px;">
                </td>
                <td style="width: 100px; height: 33px;">
                </td>
            </tr>
        </table>
        <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE2" onclick="return TABLE2_onclick()">
            <tr>
                <td style="width: 1000px; text-align: left; height: 21px;">
                    &nbsp;</td>
            </tr>
            <tr>
                <td style="width: 1000px; height: 21px; text-align: left">
                    <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" GridLines="None"
                         OnSelectedIndexChanged="gvLista_SelectedIndexChanged"
                        Width="1150px">
                        <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        <Columns>
                            <asp:ButtonField ButtonType="Image" CommandName="Select" ImageUrl="~/Imagenes/botones/Asignar1.png"
                                Text="Ver">
                                <ControlStyle Height="20px" Width="20px" />
                                <HeaderStyle BackColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                                <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                    Height="20px" HorizontalAlign="Center" VerticalAlign="Middle" Width="20px" />
                            </asp:ButtonField>
                            <asp:BoundField DataField="periodo" HeaderText="Periodo" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="numero" HeaderText="N&#250;mero">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fecha" HeaderText="Fecha">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tercero" HeaderText="Tercero" ReadOnly="True" SortExpression="tercero">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="talonario" HeaderText="Talonario">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="observacion" HeaderText="Observaci&#243;n">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="LightYellow" />
                        <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                        <AlternatingRowStyle BackColor="#E0E0E0" />
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td style="width: 1000px; text-align: left">
                    &nbsp;</td>
            </tr>
        </table>
        </div>
    </form>
</body>
</html>
