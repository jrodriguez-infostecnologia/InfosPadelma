<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Tiquetes.aspx.cs" Inherits="Administracion_Poperacion_Tiquetes" %>

<%@ OutputCache Location="None" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>

    <script type="text/javascript">

        function obtener_neto() {
            var pesoBruto = document.getElementById("txvPesoBruto").value.replace(/\,/g, '');
            var pesoTara = document.getElementById("txvPesoTara").value.replace(/\,/g, '');;
            var pesoDescuento = document.getElementById("txvPesoDescuento").value.replace(/\,/g, '');;
            var pesoNeto = document.getElementById("txvPneto");



            if (!isNaN(pesoBruto) & !isNaN(pesoTara) & !isNaN(pesoDescuento)) {

                if (pesoTara != "") {

                    var resultado = parseFloat(pesoBruto) - parseFloat(pesoTara) ;

                    if (resultado < 0) {
                        //alert("La tara no puede ser mayor al neto");
                        document.getElementById("txvPesotara").value = 0;
                        document.getElementById("txvPesoDescuento").value = 0;
                        document.getElementById("txvPneto").value = 0;
                    } else {

                        pesoNeto.value = parseFloat(resultado).toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                        pesoNeto.value = pesoNeto.value.split('').reverse().join('').replace(/^[\,]/, '');
                    }
                }
                else {
                    pesoNeto.value = 0;
                }



            } else {
                pesoNeto.value = 0;
            }

            if (parseFloat(pesoNeto.value) > 0) {
                document.getElementById("txvPneto").value = pesoNeto.value;

            } else {
                document.getElementById("txvPneto").value = 0;
            }

        }

    </script>
 





</head>
<body style="text-align: center">
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
            <table id="TABLE1" cellspacing="0"  style="BORDER-TOP: silver thin solid; WIDTH: 950px; BORDER-BOTTOM: silver thin solid">
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblTipoTransaccion" runat="server" Text="Tipo Transacción" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:DropDownList ID="ddlTipoTransaccion" runat="server" AutoPostBack="True" data-placeholder="Seleccione una opción..."  CssClass="chzn-select" OnSelectedIndexChanged="ddlTipoTransaccion_SelectedIndexChanged" Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblNumeroTransaccion" runat="server" Text="Número Transacción" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtNumeroTransaccion" runat="server" CssClass="input" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblProgramacion" runat="server" Text="Nro. Programación" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtProgramacion" runat="server" CssClass="input" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblOperacion" runat="server" Text="Operación" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:DropDownList ID="ddlOperación" runat="server" AutoPostBack="True"  data-placeholder="Seleccione una opción..."  CssClass="chzn-select" OnSelectedIndexChanged="ddlOperación_SelectedIndexChanged" Visible="False" Width="250px">
                            <asp:ListItem Value="0">Solo Anular</asp:ListItem>
                            <asp:ListItem Value="1">Anular y Crear Nuevo Tiquete</asp:ListItem>
                            <asp:ListItem Value="2">Solo Modificar</asp:ListItem>
                        </asp:DropDownList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblRemision" runat="server" Text="Remisión" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtRemision" runat="server" CssClass="input" Visible="False" Width="300px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:LinkButton ID="lbFechaProceso" runat="server" ForeColor="#003366" onclick="lbFechaProceso_Click" Visible="False">Fecha Proceso</asp:LinkButton>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:Calendar ID="CalendarFechaProceso" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaProceso_SelectionChanged" Visible="False" Width="150px">
                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                            <SelectorStyle BackColor="#CCCCCC" />
                            <WeekendDayStyle BackColor="#FFFFCC" />
                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                            <OtherMonthDayStyle ForeColor="Gray" />
                            <NextPrevStyle VerticalAlign="Bottom" />
                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                        </asp:Calendar>
                        <asp:TextBox ID="txtFechaProceso" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Visible="False"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label1" runat="server" Text="Peso Bruto Kg" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txvPesoBruto" runat="server" CssClass="input" Visible="False" Width="150px" onkeyup="formato_numero(this); obtener_neto();" ></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label14" runat="server" Text="Peso Descuento Kg" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txvPesoDescuento" runat="server" CssClass="input" Visible="False" Width="150px" onkeyup="formato_numero(this); obtener_neto();" ></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label2" runat="server" Text="Peso Tara Kg" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txvPesoTara" runat="server" CssClass="input" Visible="False" Width="150px" onkeyup="formato_numero(this); obtener_neto();" ></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label13" runat="server" Text="Peso Neto Kg" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txvPneto" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="150px" Enabled="False">0</asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label3" runat="server" Text="Vehículo" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtVehiculo" runat="server" CssClass="input" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label4" runat="server" Text="Remolque" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtRemolque" runat="server" CssClass="input" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblCodigoConductor" runat="server" Text="CC conductor" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtCodigoConductor" runat="server" CssClass="input" Visible="False" Width="150px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblNombreConductor" runat="server" Text="Nombre Conductor" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtNombreConductor" runat="server" CssClass="input" Visible="False" Width="300px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label5" runat="server" Text="Producto" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:DropDownList ID="ddlProducto" runat="server" AutoPostBack="True"  data-placeholder="Seleccione una opción..."  CssClass="chzn-select" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged" Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblProcedencia" runat="server"  Text="Procedencia" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:DropDownList ID="ddlProcedencia" runat="server" AutoPostBack="True"  data-placeholder="Seleccione una opción..."  CssClass="chzn-select" OnSelectedIndexChanged="ddlProcedencia_SelectedIndexChanged" Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblFinca" runat="server" Text="Finca" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:DropDownList ID="ddlFinca" runat="server"  data-placeholder="Seleccione una opción..."  CssClass="chzn-select" Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblRacimos" runat="server" Text="Racimos" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txvRacimos" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="150px">0</asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="Label9" runat="server" Text="Sacos" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txvSacos" runat="server" CssClass="input" Visible="False" Width="150px" onkeyup="formato_numero(this);"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblPesoSacos" runat="server" Text="Peso Sacos Kg." Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txvPesoSacos" runat="server" CssClass="input" Visible="False" Width="150px" onkeyup="formato_numero(this);"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblSellos" runat="server" Text="Sellos" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:TextBox ID="txtSellos" runat="server" CssClass="input" Visible="False" Width="300px"></asp:TextBox>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblBodegaDescargue" runat="server" Text="Bodega Descargue" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:DropDownList ID="ddlBodega" runat="server"  data-placeholder="Seleccione una opción..."  CssClass="chzn-select" Visible="False" Width="250px">
                        </asp:DropDownList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 140px; TEXT-ALIGN: left">
                        <asp:Label ID="lblDescargador" runat="server" Text="Descargador" Visible="False"></asp:Label>
                    </td>
                    <td style="VERTICAL-ALIGN: top; WIDTH: 360px; BACKGROUND-COLOR: transparent; TEXT-ALIGN: left">
                        <asp:RadioButtonList ID="rblDescargador" runat="server" RepeatDirection="Horizontal" Visible="False">
                            <asp:ListItem Selected="True">Autovolteo</asp:ListItem>
                            <asp:ListItem>Cooperativa</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td style="WIDTH: 250px"></td>
                    <td style="TEXT-ALIGN: left" colspan="2">
                        <asp:GridView ID="gvAnalisis" runat="server" AutoGenerateColumns="False" GridLines="None" Width="500px">
                            <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                            <AlternatingRowStyle BackColor="#E0E0E0" />
                            <Columns>
                                <asp:BoundField DataField="analisis" HeaderText="Código Análisis" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="descripcion" HeaderText="Descripción" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Resultado">
                                    <ItemTemplate>
                                        <asp:TextBox ID="txtResultado" runat="server" Width="50px"></asp:TextBox>
                                    </ItemTemplate>
                                    <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                    <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                                </asp:TemplateField>
                            </Columns>
                            <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" VerticalAlign="Middle" />
                            <FooterStyle BackColor="#FFFFC0" />
                        </asp:GridView>
                    </td>
                    <td style="WIDTH: 250px"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>
            <div class="tablaGrilla">
                <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" CssClass="Grid" PageSize="20" Width="800px" OnSelectedIndexChanged="gvLista_SelectedIndexChanged1">
                    <AlternatingRowStyle CssClass="alt" />
                    <Columns>
                        <asp:ButtonField ButtonType="Image" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón" CommandName="Select">
                            <ItemStyle Width="20px" CssClass="Items" />
                        </asp:ButtonField>
                         <asp:BoundField DataField="tiquete" HeaderText="Tiquete" ReadOnly="True" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="numero" HeaderText="N&#250;mero Interno" ReadOnly="True" >
                                <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="fechaProceso" DataFormatString="{0:d}" HeaderText="Fecha de Proceso">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="item" HeaderText="Producto">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="pesoNeto" DataFormatString="{0:N0}" HeaderText="Peso Neto Kg.">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                            </asp:BoundField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:HyperLink ID="hlVer" Target="_search" NavigateUrl=<%# Eval("ver") %> runat="server">Ver</asp:HyperLink>
                                </ItemTemplate>
                                <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                            </asp:TemplateField>
                        </Columns>
                    <PagerStyle CssClass="pgr" />
                    <RowStyle CssClass="rw" />
                </asp:GridView>
            </div>
        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
