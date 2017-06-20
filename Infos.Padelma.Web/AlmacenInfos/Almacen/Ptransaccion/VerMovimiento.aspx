<%@ Page Language="C#" AutoEventWireup="true" CodeFile="VerMovimiento.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" Theme="Entidades" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>Contabilidad</title>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    <div style="vertical-align: top; width: 1000px; height: 600px; text-align: center">
        <table cellspacing="0" style="width: 1000px">
            <tr>
                <td style="background-image: url(../../Imagenes/botones/BotonIzq.png);
                    width: 250px; background-repeat: no-repeat; text-align: left;">
                    </td>
                <td style="width: 500px; text-align: center">
                    Detalle de la salida de almacen en consignación</td>
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
        <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE2" onclick="return TABLE2_onclick()">
            <tr>
                <td style="width: 500px; text-align: center">
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanelTransaccion" runat="server" Visible="False">
            <ContentTemplate>
                <table id="OPERACIONES" onclick="return TABLE1_onclick()" style="width: 1000px" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 50px; height: 48px">
                        </td>
                        <td style="width: 900px; height: 48px">
                        </td>
                        <td style="width: 50px; height: 48px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px; height: 19px;">
                        </td>
                        <td style="width: 900px; height: 19px;">
                            Salida Nro.&nbsp;
                            <asp:Label ID="lblTransaccion" runat="server" ForeColor="Navy"></asp:Label></td>
                        <td style="width: 50px; height: 19px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px; height: 11px">
                        </td>
                        <td style="width: 900px; height: 11px">
                        </td>
                        <td style="width: 50px; height: 11px">
                        </td>
                    </tr>
                </table>
                <table id="ENCABEZADO" onclick="return TABLE1_onclick()" style="width: 1000px" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 50px">
                        </td>
                        <td style="width: 150px; text-align: left">
                            Fecha</td>
                        <td style="width: 750px; text-align: left">
                            <asp:Label ID="lblFechaSal" runat="server" ForeColor="Navy"></asp:Label></td>
                        <td style="width: 50px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px">
                        </td>
                        <td style="width: 150px; text-align: left">
                            Entregado a</td>
                        <td style="width: 750px; text-align: left">
                            <asp:Label ID="lblTercero" runat="server" ForeColor="Navy"></asp:Label></td>
                        <td style="width: 50px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px; height: 19px;">
                        </td>
                        <td style="width: 150px; text-align: left; height: 19px;">
                            Realizado por</td>
                        <td style="width: 750px; text-align: left; height: 19px;">
                            <asp:Label ID="lblrealizado" runat="server" ForeColor="Navy"></asp:Label>&nbsp;
                            Fecha&nbsp;Registro
                            <asp:Label ID="lblFecha" runat="server" ForeColor="Navy"></asp:Label></td>
                        <td style="width: 50px; height: 19px;">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px">
                        </td>
                        <td style="width: 150px; text-align: left">
                            Observaciones</td>
                        <td style="width: 750px; text-align: left">
                            <asp:Label ID="lblObservaciones" runat="server" ForeColor="Navy"></asp:Label></td>
                        <td style="width: 50px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px; height: 10px">
                        </td>
                        <td style="width: 150px; height: 10px">
                        </td>
                        <td style="width: 750px; height: 10px">
                        </td>
                        <td style="width: 50px; height: 10px">
                        </td>
                    </tr>
                </table>
                <table id="DETALLE" onclick="return TABLE1_onclick()" style="width: 1000px" cellpadding="0" cellspacing="0">
                    <tr>
                        <td style="width: 50px">
                        </td>
                        <td style="width: 900px"><asp:GridView ID="gvDetalle" runat="server" AutoGenerateColumns="False"
                                            GridLines="None" Width="1000px">
                                            <Columns>
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtCantidad" runat="server" Width="50px" Text=<%# Bind("cantidad") %> AutoPostBack="True" OnDataBinding="txtCantidad_DataBinding" OnTextChanged="txtCantidad_TextChanged" ReadOnly="True"></asp:TextBox>
                                                    </ItemTemplate>
                                                    <HeaderStyle BackColor="White" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="producto" HeaderText="Producto">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
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
                                                <asp:BoundField DataField="valorUnitario" DataFormatString="{0:N2}" HeaderText="Vl. Unitario">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right"/>
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />                                                
                                                </asp:BoundField>                                                    
                                                <asp:BoundField DataField="valorTotal" DataFormatString="{0:N2}" HeaderText="Vl. Total" >
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right"/>
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />                                                
                                                </asp:BoundField>                                                
                                                <asp:BoundField DataField="descripcionDestino" HeaderText="Destino">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="pIva" DataFormatString="{0:N2}" HeaderText="% I.V.A">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="docRef" HeaderText="DocRef">
                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                </asp:BoundField>
                                                <asp:BoundField DataField="registro">
                                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                    <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                </asp:BoundField>
                                            </Columns>
                                            <HeaderStyle BackColor="FloralWhite" />
                                        </asp:GridView>
                        </td>
                        <td style="width: 50px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px; height: 10px">
                        </td>
                        <td style="width: 900px; height: 10px">
                        </td>
                        <td style="width: 50px; height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 50px">
                        </td>
                        <td style="width: 900px; text-align: left">
                            <asp:DataList ID="dlTotal" runat="server" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" GridLines="Both" ShowFooter="False" ShowHeader="False">
                                <ItemTemplate>
                                    <table cellpadding="0" cellspacing="0" style="width: 200px">
                                        <tr>
                                            <td style="width: 100px">
                                                Sub Total</td>
                                            <td style="width: 100px; text-align: right">
                                                <asp:Label ID="lblTotal" runat="server" Text=<%# Eval("total") %> OnDataBinding="lblTotal_DataBinding"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px">
                                                I.V.A.</td>
                                            <td style="width: 100px; text-align: right">
                                                <asp:Label ID="lblIva" runat="server" Text=<%# Eval("iva") %> OnDataBinding="lblTotal_DataBinding"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px">
                                                Neto</td>
                                            <td style="width: 100px; text-align: right">
                                                <asp:Label ID="lblNeto" runat="server" Text=<%# Eval("neto") %> OnDataBinding="lblTotal_DataBinding"></asp:Label></td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <ItemStyle BackColor="White" ForeColor="#003399" />
                                <SelectedItemStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <HeaderStyle BackColor="#003399" Font-Bold="True" ForeColor="#CCCCFF" />
                            </asp:DataList></td>
                        <td style="width: 50px">
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
