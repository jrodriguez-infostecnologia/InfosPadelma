<%@ Page Language="C#" AutoEventWireup="true" CodeFile="InventarioFisico.aspx.cs" Inherits="Administracion_Caracterizacion" Theme="Entidades"%>

<%@ Register Src="../ControlesUsuario/NumericII.ascx" TagName="NumericII" TagPrefix="uc1" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=8.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
        
<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<script runat="server">

   
</script>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Inventario Físico</title>     
        
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.5.0/jquery.min.js" language="javascript" type="text/javascript"></script>

    <script language="javascript" type="text/javascript">
    
        var x = null;
    
        function Visualizacion(informe){
        
            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width = 1300, height = 800, top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe;
            x = window.open(sTransaccion,"",opciones); 
            x.focus();    
    }        
    
    function formato(entrada)
    {                               
        if(window.event.keyCode != 9)
        {                        
            var num = entrada.value.replace(/\,/g,'');
            var cantidad = 0;
                            
            if(!isNaN(num))
            {                        
                num = num.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g,'$1,');
                num = num.split('').reverse().join('').replace(/^[\,]/,'');
                entrada.value = num;                                    
                
                controlGrillaRef = document.getElementById("gvConteo");
                
                if(controlGrillaRef != null)
                {                    
                    for(i=1;i<controlGrillaRef.rows.length;i++)
                    {
                        objeto = controlGrillaRef.rows[i].getElementsByTagName("input");                    
                        
                        if(objeto != null)
                        {
                            if(objeto[0].type == "text")
                            {                        
                                cantidad = parseFloat(objeto[0].value.replace(/\,/g,''));
                                
                                if(!isNaN(total))
                                {                                    
                                    cantidad = cantidad.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g,'$1,');
                                    cantidad = cantidad.split('').reverse().join('').replace(/^[\,]/,'');                                                                                                  
                                    
                                    controlGrillaRef.rows[i].cells[3].innerHTML = total;                                                                     
                                }                                                                
                            }
                        }                            
                    }                    
                }                 
            }        
            else
            {
                alert('Solo se permiten números');
                entrada.value = entrada.value.replace(/[^\d\.\,]*/g,'');
            }
        }                                                            
    }    

    </script>
        
</head>
<body style="text-align: left">
    <form id="form1" runat="server">
    <div style="text-align: left">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px;
                        background-repeat: no-repeat; height: 25px; text-align: left">
                        </td>
                    <td style="width: 500px; height: 25px; text-align: center; vertical-align: top;">
                        Inventario Físico</td>
                    <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png);
                        width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">
                        </td>
                </tr>
                <tr>
                    <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px;
                        background-repeat: no-repeat; text-align: left">
                    </td>
                    <td style="vertical-align: top; width: 500px; text-align: center">
                        <asp:Label ID="lblMensaje" runat="server" ForeColor="#C00000"></asp:Label></td>
                    <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png);
                        width: 250px; background-repeat: no-repeat; text-align: left">
                    </td>
                </tr>
            </table>
        <table cellpadding="0" cellspacing="0" width="1000">
            <tr>
                <td style="width: 250px; height: 10px">
                </td>
                <td style="width: 600px; height: 10px">
                </td>
                <td style="width: 250px; height: 10px">
                </td>
            </tr>
            <tr>
                <td style="width: 250px; height: 19px;">
                </td>
                <td style="width: 700px; height: 19px; text-align: center;">
                    <asp:LinkButton ID="lbOperarios" runat="server" ForeColor="#404040" OnClick="lbOperarios_Click"
                        ToolTip="Clic aquí para registrar los operarios del conteo">Operarios</asp:LinkButton>&nbsp;
                    <asp:LinkButton ID="lbPapeletas" runat="server" ForeColor="#404040" OnClick="lbPapeletas_Click" ToolTip="Genera y asigna los números de papeleta a cada producto en el catálogo">Generación de Papeletas</asp:LinkButton>&nbsp;&nbsp;
                    <asp:LinkButton ID="lbConteo1" runat="server" ForeColor="#404040" OnClick="lbConteo1_Click"
                        ToolTip="Clic aquí para ingresar el conteo Nro. 1">Registrar Conteo</asp:LinkButton>
                    &nbsp;
                    <asp:LinkButton ID="lbDiferencias" runat="server" ForeColor="#404040" OnClick="lbDiferencias_Click"
                        ToolTip="Clic aquí para generar el informe de diferencias">Diferencias</asp:LinkButton>
                    &nbsp;&nbsp;<asp:LinkButton ID="lbEstadoInventario" runat="server" ForeColor="#404040" ToolTip="Clic aquí muestra informe del estado del inventario" OnClick="lbEstadoInventario_Click">Estado Inventario</asp:LinkButton></td>
                <td style="width: 250px; height: 19px;">
                </td>
            </tr>
            <tr>
                <td style="width: 250px; height: 10px">
                </td>
                <td style="width: 600px; height: 10px">
                </td>
                <td style="width: 250px; height: 10px">
                </td>
            </tr>
            <tr>
                <td style="width: 250px; height: 10px">
                </td>
                <td style="width: 500px; height: 10px">
                    <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                        <tr>
                            <td style="width: 100px">
                                <asp:LinkButton ID="lbFechaGenera" runat="server" ForeColor="#404040" 
                                    Visible="False" OnClick="lbFechaGenera_Click">Fecha</asp:LinkButton></td>
                            <td style="width: 100px">
                                <asp:Calendar ID="calendarGenera" runat="server" BackColor="White" BorderColor="#999999"
                        CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="Black" Height="180px" 
                        Visible="False" Width="150px" OnSelectionChanged="calendarGenera_SelectionChanged">
                                    <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                    <SelectorStyle BackColor="#CCCCCC" />
                                    <WeekendDayStyle BackColor="FloralWhite" />
                                    <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                    <OtherMonthDayStyle ForeColor="Gray" />
                                    <NextPrevStyle VerticalAlign="Bottom" />
                                    <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                    <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                </asp:Calendar>
                                <asp:TextBox ID="txtFechaGenera" runat="server" Font-Bold="True" ForeColor="Gray" ReadOnly="True"
                                    Visible="False"></asp:TextBox></td>
                            <td style="width: 100px">
                                <asp:LinkButton ID="lbRegistraGenera" runat="server" ForeColor="#404040" 
                                    OnClientClick="if(!confirm('Desea generar papeletas ?')){return false;};" ToolTip="Clic aquí para registrar el conteo"
                                    Visible="False" OnClick="lbRegistraGenera_Click">Registrar</asp:LinkButton></td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                                <asp:Label ID="Label8" runat="server" Text="Bodega" Visible="False"></asp:Label></td>
                            <td style="width: 100px">
                                <asp:DropDownList ID="ddlBodegaGenera" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBodega_SelectedIndexChanged"
                        Visible="False" Width="200px">
                                </asp:DropDownList></td>
                            <td style="width: 100px">
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 100px">
                            </td>
                            <td style="width: 100px">
                                <asp:LinkButton ID="lbCancelarGenera" runat="server" ForeColor="#404040" OnClick="lbCancelarGenera_Click"
                                    OnClientClick="if(!confirm('Desea cancelar ?')){return false;};" ToolTip="Haga click para cancelar operación" Visible="False">Cancelar</asp:LinkButton></td>
                        </tr>
                    </table>
                </td>
                <td style="width: 250px; height: 10px">
                </td>
            </tr>
        </table>

        </div>        
        <table cellpadding="0" cellspacing="0" width="1000">
            <tr>
                <td style="width: 150px">
                </td>
                <td style="width: 150px">
                    <asp:LinkButton ID="nilbCancelar" runat="server" ForeColor="#404040" OnClick="nilbCancelar_Click"
                        OnClientClick="if(!confirm('Desea cancelar la transacción ?')){return false;};"
                        ToolTip="Clic aquí para cancelar la operación" Visible="False">Cancelar</asp:LinkButton></td>
                <td style="width: 400px">
                </td>
                <td style="width: 150px; text-align: right">
                    <asp:LinkButton ID="nilbRegistrar" runat="server" ForeColor="#404040" OnClick="nilbRegistrar_Click"
                        OnClientClick="if(!confirm('Desea registrar el conteo ?')){return false;};" ToolTip="Clic aquí para registrar el conteo"
                        Visible="False">Registrar</asp:LinkButton></td>
                <td style="width: 150px">
                </td>
            </tr>
            <tr>
                <td style="width: 3px; height: 10px">
                </td>
                <td style="width: 3px; height: 10px">
                </td>
                <td style="width: 400px; height: 10px">
                </td>
                <td style="width: 3px; height: 10px">
                </td>
                <td style="width: 3px; height: 10px">
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" style="width: 1000px" id="TABLE1" onclick="return TABLE1_onclick()">
            <tr>
                <td style="width: 150px; height: 19px;">
                    </td>
                <td style="vertical-align: top; width: 150px; height: 19px">
                    <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#404040" OnClick="lbFecha_Click"
                        Visible="False">Fecha</asp:LinkButton></td>
                <td style="width: 200px; height: 19px">
                    <asp:Calendar ID="niCalendarFecha" runat="server" BackColor="White" BorderColor="#999999"
                        CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged"
                        Visible="False" Width="150px">
                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                        <SelectorStyle BackColor="#CCCCCC" />
                        <WeekendDayStyle BackColor="FloralWhite" />
                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                        <OtherMonthDayStyle ForeColor="Gray" />
                        <NextPrevStyle VerticalAlign="Bottom" />
                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                    </asp:Calendar>
                    <asp:TextBox ID="txtFecha" runat="server" Font-Bold="True" ForeColor="Gray" ReadOnly="True"
                        Visible="False"></asp:TextBox></td>
                <td style="width: 500px; height: 19px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 19px">
                </td>
                <td style="vertical-align: top; width: 150px; height: 19px">
                    <asp:Label ID="Label1" runat="server" Text="Bodega" Visible="False"></asp:Label></td>
                <td style="width: 200px; height: 19px">
                    <asp:DropDownList ID="ddlBodega" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlBodega_SelectedIndexChanged"
                        Visible="False" Width="200px">
                    </asp:DropDownList></td>
                <td style="width: 500px; height: 19px">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 19px">
                </td>
                <td style="vertical-align: top; width: 150px; height: 19px">
                    <asp:Label ID="Label4" runat="server" Text="Operario" Visible="False"></asp:Label></td>
                <td style="width: 200px; height: 19px">
                    <asp:DropDownList ID="ddlOperario" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlOperario_SelectedIndexChanged"
                        Visible="False" Width="200px">
                    </asp:DropDownList></td>
                <td style="width: 500px; height: 19px">
                    <asp:DropDownList ID="ddlOperarioNombre" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlOperarioNombre_SelectedIndexChanged"
                        Visible="False" Width="400px">
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td style="width: 150px; height: 19px">
                </td>
                <td style="vertical-align: top; width: 150px; height: 19px">
                    <asp:Label ID="Label2" runat="server" Text="Desde la Papeletas" Visible="False"></asp:Label></td>
                <td style="width: 200px; height: 19px">
                    <asp:TextBox ID="txtPapeleta1" runat="server" Visible="False" Width="84px"></asp:TextBox>
                    &nbsp; &nbsp; &nbsp;
                    <asp:Label ID="Label7" runat="server" Text="Hasta " Visible="False"></asp:Label></td>
                <td style="width: 500px; height: 19px">
                    <asp:TextBox ID="txtPapeleta2" runat="server" Visible="False" Width="84px"></asp:TextBox></td>
            </tr>
            <tr>
                <td style="width: 150px; height: 24px;">
                </td>
                <td style="vertical-align: top; width: 150px; height: 24px;">
                    <asp:Button ID="btnRegistrar" runat="server" OnClick="btnRegistrar_Click" Text="Editar"
                        Visible="False" Width="150px" /></td>
                <td style="width: 200px; height: 24px;">
                    <asp:Button ID="Button1" runat="server" Text="Buscar" OnClick="Button1_Click" Visible="False" Width="153px" /></td>
                <td style="width: 500px; height: 24px;">
                </td>
            </tr>
            <tr>
                <td style="width: 150px; height: 10px">
                </td>
                <td style="vertical-align: top; width: 150px; height: 10px">
                </td>
                <td style="width: 200px; height: 10px">
                </td>
                <td style="width: 500px; height: 10px">
                </td>
            </tr>
        </table>
        <table cellpadding="0" cellspacing="0" width="1000">
            <tr>
                <td style="width: 1000px">
                    <asp:GridView ID="gvConteo" runat="server" AutoGenerateColumns="False" GridLines="None"
                                              Width="950px" OnSelectedIndexChanged="gvConteo_SelectedIndexChanged">
                        <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                        <Columns>
                            <asp:BoundField DataField="papeleta" HeaderText="Papeleta" ReadOnly="True">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="codproducto" HeaderText="Cod Producto">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="producto" HeaderText="Producto">
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="Conteo">
                                <ItemTemplate>
                                   <asp:TextBox ID="txtCantidad" runat="server" Width="50px" Text=<%# Bind("conteo2") %> AutoPostBack="True" OnDataBinding="txtCantidad_DataBinding" 
                                        onkeyup="formato(this)" onchange="formato(this)" ></asp:TextBox>
                                </ItemTemplate>
                                <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle BackColor="LightYellow" />
                        <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                        <AlternatingRowStyle BackColor="#E0E0E0" />
                    </asp:GridView>
                </td>
            </tr>
        </table>
        <asp:UpdatePanel ID="UpdatePanelOperarios" runat="server">
            <ContentTemplate>
                <table cellpadding="0" cellspacing="0" style="width: 1000px">
                    <tr>
                        <td style="width: 200px; text-align: right; height: 19px;">
                            <asp:LinkButton ID="nilbNuevoOperario" runat="server" ForeColor="#404040" OnClick="nilbNuevoOperario_Click"
                                ToolTip="Clic aquí para crear un nuevo registro" Visible="False">Nuevo</asp:LinkButton>
                            <asp:LinkButton ID="nilbCancelarOperarios" runat="server" ForeColor="#404040" OnClick="nilbCancelarOperarios_Click"
                                OnClientClick="if(!confirm('Desea cancelar la transacción ?')){return false;};"
                                ToolTip="Clic aquí para cancelar la operación" Visible="False">Cancelar</asp:LinkButton></td>
                        <td style="width: 150px; height: 19px;">
                        </td>
                        <td style="width: 450px; height: 19px;">
                        </td>
                        <td style="width: 200px; height: 19px;">
                            <asp:LinkButton ID="nilbRegistrarOperarios" runat="server" ForeColor="#404040" OnClick="nilbRegistrarOperarios_Click"
                                OnClientClick="if(!confirm('Desea registrar el operario ?')){return false;};"
                                ToolTip="Clic aquí para registrar el operario" Visible="False">Registrar</asp:LinkButton></td>
                    </tr>
                    <tr>
                        <td style="width: 200px; height: 10px">
                        </td>
                        <td style="width: 150px; height: 10px">
                        </td>
                        <td style="width: 450px; height: 10px">
                        </td>
                        <td style="width: 200px; height: 10px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px">
                        </td>
                        <td style="vertical-align: top; width: 150px">
                            <asp:LinkButton ID="lbFechaOperario" runat="server" ForeColor="#404040" OnClick="lbFechaOperario_Click"
                                Visible="False">Fecha</asp:LinkButton></td>
                        <td style="width: 450px">
                            <asp:Calendar ID="CalendarFechaOperario" runat="server" BackColor="White" BorderColor="#999999"
                        CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
                        ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFechaOperario_SelectionChanged"
                        Visible="False" Width="150px">
                                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                <SelectorStyle BackColor="#CCCCCC" />
                                <WeekendDayStyle BackColor="FloralWhite" />
                                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                <OtherMonthDayStyle ForeColor="Gray" />
                                <NextPrevStyle VerticalAlign="Bottom" />
                                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                            </asp:Calendar>
                            <asp:TextBox ID="txtFechaOperario" runat="server" Font-Bold="True" ForeColor="Gray"
                                ReadOnly="True" Visible="False"></asp:TextBox></td>
                        <td style="width: 200px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px">
                        </td>
                        <td style="width: 150px">
                            <asp:Label ID="Label5" runat="server" Text="Código Operario" Visible="False"></asp:Label></td>
                        <td style="width: 450px">
                            <asp:TextBox ID="txtCodigoOperario" runat="server" Visible="False" Width="150px"></asp:TextBox>
                            </td>
                        <td style="width: 200px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px">
                        </td>
                        <td style="width: 150px">
                            <asp:Label ID="Label6" runat="server" Text="Nombre Operario" Visible="False"></asp:Label></td>
                        <td style="width: 450px">
                            <asp:TextBox ID="txtNombreOperario" runat="server" Visible="False" Width="400px"></asp:TextBox></td>
                        <td style="width: 200px">
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 200px; height: 10px">
                        </td>
                        <td style="width: 150px; height: 10px">
                        </td>
                        <td style="width: 450px; height: 10px">
                        </td>
                        <td style="width: 200px; height: 10px">
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="gvOperarios" runat="server" AutoGenerateColumns="False" GridLines="None"
                        OnRowDeleting="gvOperarios_RowDeleting" OnSelectedIndexChanged="gvOperarios_SelectedIndexChanged"
                        Width="950px">
                    <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                    <Columns>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEditar" runat="server" CommandName="Select" Height="17px"
                                        ImageAlign="Middle" ImageUrl="~/Imagenes/botones/Edit.png" ToolTip="Clic para editar el registro"
                                        Width="17px" />
                            </ItemTemplate>
                            <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                            <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                    HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:ImageButton ID="imbEliminar" runat="server" CommandName="Delete" Height="17px"
                                        ImageAlign="Middle" ImageUrl="~/Imagenes/botones/anular.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};"
                                        ToolTip="Elimina el registro seleccionado" Width="17px" />
                            </ItemTemplate>
                            <HeaderStyle BackColor="White" HorizontalAlign="Center" VerticalAlign="Middle" />
                            <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                    HorizontalAlign="Center" VerticalAlign="Middle" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="fecha" HeaderText="Fecha" ReadOnly="True" DataFormatString="{0:d}">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="operario" HeaderText="Operario">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                        <asp:BoundField DataField="nombre" HeaderText="Nombre">
                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="LightYellow" />
                    <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" />
                    <AlternatingRowStyle BackColor="#E0E0E0" />
                </asp:GridView>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
