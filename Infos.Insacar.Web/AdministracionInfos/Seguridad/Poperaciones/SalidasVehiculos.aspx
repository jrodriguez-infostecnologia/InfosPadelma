<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalidasVehiculos.aspx.cs" Inherits="Porteria_Padministracion_Salidas" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title></title>
    <style type="text/css">
 

.principal {
    vertical-align: top;
     width: 950px; height: 600px;
      text-align: center; 
      font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; 
      font-size: 12px;
       color: #003366;
}

.bordes {
    width: 250px;
    text-align: center;
}

.nombreCampos {
    text-align: left;
    }

.Campos {
    width: 360px;
    text-align: left;
    padding-top: 1px;
    padding-bottom: 1px;
}

.mayuscula{  
      padding: 0px 3px 0px 3px;
    border-width: 1px;
    border-color: silver;
    font-family: 'Trebuchet MS' , 'Lucida Sans Unicode' , 'Lucida Grande' , 'Lucida Sans' , Arial, sans-serif;
    font-size: 12px;
    color: #003366;
    height: 20px;
    border-style: solid;
    border-radius: 2px 2px 2px 2px;
    box-shadow: 0 2px 2px rgba(0, 0, 0, 0.080) inset;
text-transform: uppercase;  
} 

.input {
    padding: 0px 3px 0px 3px;
    border-width: 1px;
    border-color: silver;
    font-family: 'Trebuchet MS' , 'Lucida Sans Unicode' , 'Lucida Grande' , 'Lucida Sans' , Arial, sans-serif;
    font-size: 12px;
    color: #003366;
    height: 20px;
    border-style: solid;
    border-radius: 2px 2px 2px 2px;
    box-shadow: 0 2px 2px rgba(0, 0, 0, 0.080) inset;
}

.tablaGrilla {
    margin: 10px 100px 10px 100px;
    width: 800px;
    }



.Grid {
    margin: 0px;
    border: 1px solid silver;
    font-family: Calibri;
    color: #474747;
}

.Grid th {
        border: 1px solid #C1C1C1;
            padding: 0px;
            color: #fff;
    background: #006699 url('../../Imagen/Fondos/barraGrilla.jpg') repeat-x;
            font-size: 0.9em;
            text-align: center;
}


.Grid .rw {
    border: 1px solid silver;
    text-align: left;
}

.Grid .alt {
        border: 1px solid silver;
            background: #fcfcfc url('../../Imagen/Fondos/grid-alt.png') repeat-x 50% top;
            text-align: left;
}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 950px">
                <tr>
                    <td class="bordes">
                        </td>
                    <td>Clic aquí para buscar vehículos en planta</td>
                    <td class="bordes"></td>
                </tr>
                <tr>
                    <td colspan="3">
                    <asp:ImageButton ID="niimbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" ToolTip="Haga clic aqui para realizar la busqueda" OnClick="niimbBuscar_Click" 
                        onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" 
                        onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" style="height: 21px"/>
                    </td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;">
            <tr>
                <td>
                    <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                </td>
            </tr>
            </table>
            <div class="tablaGrilla">
                <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False"  CssClass="Grid" GridLines ="None" Height="1px" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" Width="800px">
                   <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:TemplateField HeaderText="Salir">
                            <ItemTemplate>
                                <asp:ImageButton ID="imbSalida" runat="server" CommandName="Select" ImageUrl="~/Imagen/TabsIcon/undo.png" OnClientClick="if(!confirm('Desea dar salida al vehículo ?')){return false;};" ToolTip="Clic aqui para dar salida al vehículo seleccionado" />
                            </ItemTemplate>
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" Width="30px" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="vehiculo" HeaderText="Vehículo" ReadOnly="True">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="60px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="remolque" HeaderText="Remolque">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="fechaEntrada" HeaderText="Fecha Ingreso" ReadOnly="True">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="80px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="codigoConductor" HeaderText="Cédula">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="70px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="nombreConductor" HeaderText="Nombre">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="remision" HeaderText="Remision">
                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="90px" />
                        </asp:BoundField>
                    </Columns>
                   <PagerStyle CssClass="pgr" />
                    <RowStyle CssClass="rw" />
                </asp:GridView>
            </div>
        </div>

    </form>
</body>
</html>
