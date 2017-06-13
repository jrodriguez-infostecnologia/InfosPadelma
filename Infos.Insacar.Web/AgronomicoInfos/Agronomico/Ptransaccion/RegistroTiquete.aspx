<%@ Page Language="C#" AutoEventWireup="true" MaintainScrollPositionOnPostback="true" CodeFile="RegistroTiquete.aspx.cs" Inherits="Agronomico_Ptransaccion_RegistroTiquete" %>

<%@ Register Assembly="obout_Calendar2_Net" Namespace="OboutInc.Calendar2" TagPrefix="obout" %>
<%@ OutputCache Location="None" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Transacciones Agro</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/CalendarioMin.js" type="text/javascript"></script>
    <script src="../../js/CalendarioUiMin.js" type="text/javascript"></script>
    <link href="../../css/Calendarios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <script src="../../js/OcultarMostrar.js"></script>
    <link rel="stylesheet" href="../../css/common.css" type="text/css" />
    <link href="../../css/jquery-ui.css" rel="stylesheet" />
    <link type="text/css" href="../../css/ui.multiselect.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/jqueryv1.5.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui1.8.10.min.js"></script>
    <script type="text/javascript" src="../../js/plugins/localisation/jquery.localisation-min.js"></script>
    <script type="text/javascript" src="../../js/plugins/scrollTo/jquery.scrollTo-min.js"></script>
    <script type="text/javascript" src="../../js/ui.multiselect.js"></script>
    <script type="text/javascript">
        setInterval('MantenSesion()', '<%#(int) (0.9 * (Session.Timeout * 60000)) %>');
    </script>
    <script type="text/javascript">
        function MantenSesion() {
            var CONTROLADOR = "refresh_session.ashx";
            var head = document.getElementsByTagName('head').item(0);
            script = document.createElement('script');
            script.src = CONTROLADOR;
            script.setAttribute('type', 'text/javascript');
            script.defer = true;
            head.appendChild(script);
        }
        function igualarRacimos() {
            if (parseFloat(document.getElementById("txvRacimosTiquete").value) > 0) {
                document.getElementById("txvRacimos").value = document.getElementById("txvRacimosTiquete").value
            }
        }
        function obtener_neto() {
            var pesoBruto = document.getElementById("txvPbruto").value.replace(/\,/g, '');
            var pesoTara = document.getElementById("txvPtara").value.replace(/\,/g, '');;
            var pesoNeto = document.getElementById("txvPneto");

            if (!isNaN(pesoBruto) & !isNaN(pesoTara)) {
                if (pesoTara != "") {
                    var resultado = parseFloat(pesoBruto) - parseFloat(pesoTara);
                    if (resultado < 0) {
                        alert("La tara no puede ser mayor al neto");
                        document.getElementById("txvPtara").value = 0;
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
                document.getElementById("txvCantidad").value = pesoNeto.value;
            } else {
                document.getElementById("txvCantidad").value = 0;
            }
        }
    </script>
    <style type="text/css">
        .auto-style1 {
            height: 20px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; color: #003366; font-size: 12px; width: 100%">
            <div style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver; padding: 5px; vertical-align: text-bottom; height: 21px; width: 100%;">
                <asp:ScriptManager ID="ScriptManager1" runat="server" AsyncPostBackTimeout="0" ScriptMode="Release"
                    EnablePartialRendering="true" EnablePageMethods="true">
                </asp:ScriptManager>
                <script type="text/javascript">
                    var xPos, yPos;
                    var prm = Sys.WebForms.PageRequestManager.getInstance();
                    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(endReq);
                    function endReq(sender, args) {
                        $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true });
                        $.localise('ui-multiselect', { language: 'es', path: '../../js/locale/' });
                        $(".multiselect").multiselect();
                        setInterval('MantenSesion()', '<%#(int) (0.9 * (Session.Timeout * 60000)) %>');
                    }
                </script>
                <asp:ImageButton ID="niimbRegistro" runat="server" ImageUrl="~/Imagen/Bonotes/pRegistro.png"
                    onmouseout="this.src='../../Imagen/Bonotes/pRegistro.png'"
                    onmouseover="this.src='../../Imagen/Bonotes/pRegistroN.png'" OnClick="niimbRegistro_Click" />
                <asp:ImageButton ID="imbConsulta" runat="server" ImageUrl="~/Imagen/Bonotes/pConsulta.png"
                    onmouseout="this.src='../../Imagen/Bonotes/pConsulta.png'"
                    onmouseover="this.src='../../Imagen/Bonotes/pConsultaN.png'" OnClick="imbConsulta_Click" />
            </div>
            <asp:UpdatePanel ID="upGeneral" runat="server">
                <ContentTemplate>
                    <div style="text-align: center;">
                        <asp:ImageButton ID="nilbNuevo" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevo.jpg" ToolTip="Habilita el formulario para un nuevo registro" OnClick="lbNuevo_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevo.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevN.jpg'" />
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" ToolTip="Cancela la operación" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" Visible="False" />
                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" ToolTip="Guarda el nuevo registro en la base de datos"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" OnClick="lbRegistrar_Click1" Visible="False" OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};" />
                        <asp:ImageButton ID="niimbImprimir" runat="server" ImageUrl="~/Imagen/Bonotes/btnImprimir.png" ToolTip="Haga clic aqui para realizar la busqueda"
                            onmouseout="this.src='../../Imagen/Bonotes/btnImprimir.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnImprimirN.png'" Visible="False" OnClick="niimbImprimir_Click" />
                    </div>
                    <div style="text-align: center">
                        <asp:Label ID="nilblInformacion" runat="server" ForeColor="Red"></asp:Label>
                    </div>
                    <div style="text-align: center; padding: 5px;">
                        <div style="display: inline-block">
                            <asp:UpdatePanel ID="upBascula" runat="server" Visible="False" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <fieldset style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                                        <legend>Detalle de la Bascula</legend>
                                        <table cellpadding="0" cellspacing="0" style="width: 950px">
                                            <tr>
                                                <td style="width: 20px"></td>
                                                <td colspan="2">
                                                    <asp:Label ID="nilbInofrmacionBascula" runat="server"></asp:Label>
                                                </td>
                                                <td style="width: 20px"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td style="text-align: left">
                                                    <asp:RadioButtonList ID="rblBascula" runat="server" AutoPostBack="True" OnSelectedIndexChanged="rblBascula_SelectedIndexChanged" RepeatDirection="Horizontal">
                                                        <asp:ListItem Selected="True" Value="1">Tiquete del grupo</asp:ListItem>
                                                        <asp:ListItem Value="2">Tiquete Externo</asp:ListItem>
                                                    </asp:RadioButtonList>
                                                </td>
                                                <td style="text-align: left" class="auto-style2"></td>
                                                <td class="auto-style1"></td>
                                            </tr>
                                            <tr>
                                                <td style="width: 20px"></td>
                                                <td colspan="2">
                                                    <table cellpadding="0" cellspacing="0" style="width: 100%">
                                                        <tr>
                                                            <td style="width: 90px; text-align: left">
                                                                <asp:Label ID="lblExtractoraFiltro" runat="server" Text="Extractora" Visible="False"></asp:Label>
                                                            </td>
                                                            <td style="width: 350px; text-align: left;">
                                                                <asp:DropDownList ID="ddlExtractoraFiltro" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlExtractoraFiltro_SelectedIndexChanged" Visible="False" Width="320px">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td style="width: 120px; text-align: left">
                                                                <asp:Label ID="lblFiltroBusqueda" runat="server" Text="Filtro tiquete" Visible="False"></asp:Label>
                                                            </td>
                                                            <td style="text-align: left; width: 180px;">
                                                                <asp:TextBox ID="txtFiltroBascula" runat="server" CssClass="input" Visible="False" Width="150px" ToolTip="Ingrese numero tiquete" AutoPostBack="True" OnTextChanged="txtFiltroBascula_TextChanged"></asp:TextBox>
                                                            </td>
                                                            <td style="text-align: center">
                                                                <asp:ImageButton ID="imbBuscarBascula" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="imbBuscarBascula_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" Visible="False" />
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5" style="height: 5px; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;">
                                                                <asp:GridView ID="gvTiquetes" runat="server" AutoGenerateColumns="False" CssClass="Grid" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="5" Visible="False" Width="900px" AllowPaging="True" OnSelectedIndexChanged="gvTiquetes_SelectedIndexChanged">
                                                                    <AlternatingRowStyle CssClass="alt" />
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="Select">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="imbSelecionaTiquete" runat="server" ImageUrl="~/Imagen/Iconos/ok.png" CommandName="select" />
                                                                            </ItemTemplate>
                                                                            <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                                                                        </asp:TemplateField>
                                                                        <asp:BoundField DataField="extractora" HeaderText="Extractora">
                                                                            <ItemStyle CssClass="Items" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="tiquete" HeaderText="Tiquete" ReadOnly="True">
                                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="120px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="Fecha" HeaderText="Fecha" DataFormatString="{0:dd/MM/yyy hh:mm:ss}">
                                                                            <ItemStyle CssClass="Items" Width="120px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="vehiculo" HeaderText="Vehí.">
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="50px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="remolque" HeaderText="Remol.">
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="30px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="pesoBruto" HeaderText="pBruto(kg)" DataFormatString="{0:N}">
                                                                            <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="60px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="pesoTara" HeaderText="pTara(kg)" DataFormatString="{0:N}">
                                                                            <ItemStyle CssClass="Items" Width="60px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="pesoNeto" HeaderText="pNeto(kg)" DataFormatString="{0:N}">
                                                                            <ItemStyle CssClass="Items" Width="60px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="sacos" HeaderText="Sacos">
                                                                            <ItemStyle CssClass="Items" Width="20px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="racimos" HeaderText="Racimos">
                                                                            <ItemStyle CssClass="Items" Width="40px" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="codigoConductor" HeaderText="C.C. ">
                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                            <ItemStyle CssClass="Items" Width="50px" />
                                                                        </asp:BoundField>
                                                                        <asp:BoundField DataField="nombreConductor" HeaderText="NombreConductor">
                                                                            <HeaderStyle HorizontalAlign="Center" />
                                                                            <ItemStyle CssClass="Items" />
                                                                        </asp:BoundField>
                                                                    </Columns>
                                                                    <PagerStyle CssClass="pgr" />
                                                                    <RowStyle CssClass="rw" />
                                                                </asp:GridView>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="5">
                                                                <asp:UpdatePanel ID="upTiquete" runat="server" Visible="False">
                                                                    <ContentTemplate>
                                                                        <table cellpadding="0" cellspacing="0">
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:Label ID="lbTiquete1" runat="server" Text="Extractora"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:DropDownList ID="ddlExtractoraTiquete" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td style="width: 120px; text-align: left">
                                                                                    <asp:Label ID="lbTiquete" runat="server" Text="Tiquete"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txtTiquete" runat="server" CssClass="input" Width="150px"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:LinkButton ID="lbFechaTiqueteI" runat="server" ForeColor="#003366" OnClick="lbFecha_Click" Visible="False">Fecha Tiquete</asp:LinkButton>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:Calendar ID="niCalendarFechaTiqueteI" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaTiqueteI_SelectionChanged1" Visible="False" Width="150px">
                                                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                                                    </asp:Calendar>
                                                                                    <asp:TextBox ID="txtFechaTiqueteI" runat="server" class="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px" ReadOnly="True"></asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 120px; text-align: left">
                                                                                    <asp:Label ID="Label3" runat="server" Text="Sacos"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txvSacos" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="150px">0</asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:Label ID="Label2" runat="server" Text="Peso Bruto"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txvPbruto" runat="server" CssClass="input" onkeyup="formato_numero(this); obtener_neto();" Visible="False" Width="150px" AutoPostBack="True" OnTextChanged="txvPbruto_TextChanged">0</asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 120px; text-align: left">
                                                                                    <asp:Label ID="Label6" runat="server" Text="Racimos"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txvRacimosTiquete" runat="server" CssClass="input" onkeyup="formato_numero(this); igualarRacimos();" Visible="False" Width="150px">0</asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:Label ID="Label4" runat="server" Text="Peso Tara"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txvPtara" runat="server" CssClass="input" onkeyup="formato_numero(this); obtener_neto(); " Visible="False" Width="150px" AutoPostBack="True" OnTextChanged="txvPtara_TextChanged">0</asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 120px; text-align: left">
                                                                                    <asp:Label ID="Label14" runat="server" Text="Vehículo"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txtVehiculo" runat="server" CssClass="input" Width="100px"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:Label ID="Label5" runat="server" Text="Peso Neto"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txvPneto" runat="server" CssClass="input" onkeyup="formato_numero(this)" Visible="False" Width="150px">0</asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 120px; text-align: left">
                                                                                    <asp:Label ID="Label15" runat="server" Text="Remolque"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txtRemolque" runat="server" CssClass="input" Width="100px"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:CheckBox ID="chkLaborTransporte" runat="server" Text="Labor Transp" AutoPostBack="True" OnCheckedChanged="chkLaborTransporte_CheckedChanged" />
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:DropDownList ID="ddlLaborTransporte" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td style="width: 120px; text-align: left">
                                                                                    <asp:Label ID="Label7" runat="server" Text="Conductor"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:DropDownList ID="ddlConductor" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px">
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#003366" OnClick="lbFecha_Click2" Visible="False">Fecha Transacción</asp:LinkButton>
                                                                                </td>
                                                                                <td style="text-align: left; width: 350px;">
                                                                                    <asp:Calendar ID="niCalendarFecha" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFecha_SelectionChanged" Visible="False" Width="150px">
                                                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                                                    </asp:Calendar>
                                                                                    <asp:TextBox ID="txtFecha" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" OnTextChanged="txtFecha_TextChanged" ToolTip="Formato fecha (dd/mm/yyyy)" Visible="False" Width="150px"></asp:TextBox>
                                                                                </td>
                                                                                <td style="width: 120px; text-align: left">
                                                                                    <asp:Label ID="lblRemision" runat="server" Text="Remisión" Visible="False"></asp:Label>
                                                                                </td>
                                                                                <td style="width: 350px; text-align: left">
                                                                                    <asp:TextBox ID="txtRemision" runat="server" CssClass="input" Width="150px" Wrap="False"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                            <tr>
                                                                                <td style="width: 120px; text-align: left;">
                                                                                    <asp:Label ID="lblObservacion" runat="server" Text="Observaciones" Visible="False"></asp:Label>
                                                                                </td>
                                                                                <td colspan="3" style="text-align: left">
                                                                                    <asp:TextBox ID="txtObservacion" runat="server" CssClass="input" Height="40px" TextMode="MultiLine" Visible="False" Width="100%"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </ContentTemplate>
                                                                </asp:UpdatePanel>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </td>
                                                <td style="width: 20px"></td>
                                            </tr>
                                        </table>
                                    </fieldset>
                                </ContentTemplate>
                                <Triggers>
                                    <asp:AsyncPostBackTrigger ControlID="ddlSeccion" EventName="SelectedIndexChanged" />
                                    <asp:AsyncPostBackTrigger ControlID="imbCargar" EventName="Click" />

                                    <asp:AsyncPostBackTrigger ControlID="txtFiltroBascula" EventName="TextChanged" />

                                </Triggers>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                    <div style="text-align: center; padding: 5px;">
                        <div style="display: inline-block">
                            <asp:UpdatePanel ID="upRecolector" runat="server" UpdateMode="Conditional" Visible="False">
                                <ContentTemplate>
                                    <fieldset style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                                        <legend>Detalle de Cargadores</legend>
                                        <table cellspacing="0" style="width: 1000px;">
                                            <tr>
                                                <td class="auto-style1"></td>
                                                <td style="text-align: center;" class="auto-style1" colspan="4">
                                                    <asp:Label ID="nilblInformacionCargadoresTiq" runat="server" ForeColor="Red"></asp:Label>
                                                </td>
                                                <td class="auto-style1"></td>
                                            </tr>
                                            <tr>
                                                <td></td>
                                                <td style="width: 110px; text-align: left;">
                                                    <asp:CheckBox ID="chkLaborCargue" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="chkLaborCargue_CheckedChanged" Text="Labor Carga" />
                                                </td>
                                                <td class="Campos">
                                                    <asp:DropDownList ID="ddlLaborCargadores" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Visible="False" Width="350px">
                                                    </asp:DropDownList>
                                                </td>
                                                <td class="nombreCampos" style="width: 110px; text-align: left;">
                                                    <asp:LinkButton ID="lbFechaCargadores" runat="server" ForeColor="#003366" OnClick="lbFechaCargadores_Click" Visible="False">Fecha cargue</asp:LinkButton>
                                                </td>
                                                <td class="Campos">
                                                    <asp:Calendar ID="calendarCargadores" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="calendarCargadores_SelectionChanged" Visible="False" Width="150px">
                                                        <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                        <SelectorStyle BackColor="#CCCCCC" />
                                                        <WeekendDayStyle BackColor="FloralWhite" />
                                                        <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                        <OtherMonthDayStyle ForeColor="Gray" />
                                                        <NextPrevStyle VerticalAlign="Bottom" />
                                                        <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                        <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                    </asp:Calendar>
                                                    <asp:TextBox ID="txtFechaCargadores" runat="server" AutoPostBack="True" CssClass="input" Font-Bold="True" OnTextChanged="txtFechaCargadores_TextChanged" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px"></asp:TextBox>
                                                </td>
                                                <td></td>
                                            </tr>
                                            <tr>
                                                <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>

                                                <td colspan="4" style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver; text-align: center;">
                                                    <div style="display: inline-block">
                                                        <select id="selTerceroCargadores" runat="server" class="multiselect" multiple="true" name="countries[]" visible="False" style="width: 800px; height: 100px;">
                                                        </select>
                                                    </div>
                                                </td>
                                                <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                                            </tr>
                                        </table>
                                        </div>
                                    </fieldset>
                                </ContentTemplate>


                            </asp:UpdatePanel>
                        </div>
                    </div>
                    <div style="text-align: center; padding: 5px;">
                        <div style="display: inline-block">
                            <asp:UpdatePanel ID="upDetalle" runat="server" UpdateMode="Conditional" Visible="False">
                                <ContentTemplate>
                                    <div>
                                        <fieldset style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                                            <legend>Detalle de la Cosecha</legend>
                                            <table cellspacing="0" style="width: 1000px;">
                                                <tr>
                                                    <td></td>
                                                    <td colspan="4">
                                                        <asp:Label ID="nilblInformacionDetalle" runat="server" ForeColor="Red"></asp:Label>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td style="width: 110px; text-align: left;">
                                                        <asp:Label ID="lblFinca" runat="server" Text="Finca" Visible="False"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:DropDownList ID="ddlFinca" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlFinca_SelectedIndexChanged2" Visible="False" Width="350px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td class="nombreCampos" style="width: 110px; text-align: left;">
                                                        <asp:Label ID="lblSeccion" runat="server" Text="Sección"></asp:Label>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:DropDownList ID="ddlSeccion" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlSeccion_SelectedIndexChanged" Width="350px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td style="text-align: left; width: 110px;">
                                                        <asp:Label ID="lblLote" runat="server" Text="Lote"></asp:Label>
                                                    </td>
                                                    <td class="Campos" style="vertical-align: middle; line-height: normal">
                                                        <asp:DropDownList ID="ddlLote" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="350px">
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="text-align: left; width: 110px;">
                                                        <asp:LinkButton ID="lbFechaD" runat="server" ForeColor="#003366" OnClick="lbFechaD_Click" Visible="False">Fecha cosecha</asp:LinkButton>
                                                    </td>
                                                    <td class="Campos">
                                                        <asp:Calendar ID="calendarFechaNovedad" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="niCalendarFechaD_SelectionChanged" Visible="False" Width="150px">
                                                            <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                                                            <SelectorStyle BackColor="#CCCCCC" />
                                                            <WeekendDayStyle BackColor="FloralWhite" />
                                                            <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                                                            <OtherMonthDayStyle ForeColor="Gray" />
                                                            <NextPrevStyle VerticalAlign="Bottom" />
                                                            <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                                                            <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
                                                        </asp:Calendar>
                                                        <asp:TextBox ID="txtFechaD" runat="server" CssClass="input" Font-Bold="True" ToolTip="Formato fecha (dd/mm/yyyy)" Width="150px" OnTextChanged="txtFechaD_TextChanged" AutoPostBack="True"></asp:TextBox>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td style="text-align: left;" colspan="4">
                                                        <table cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td style="padding-right: 4px; padding-left: 4px; width: 100px">
                                                                    <asp:Label ID="lblRacimosD" runat="server" Text="Racimos"></asp:Label>
                                                                </td>
                                                                <td style="width: 140px; text-align: left;">
                                                                    <asp:TextBox ID="txvRacimosD" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="110px">0</asp:TextBox>
                                                                </td>
                                                                <td style="padding-right: 4px; padding-left: 4px; width: 100px;">
                                                                    <asp:Label ID="lblJornalesD" runat="server" Text="Jornales"></asp:Label>
                                                                </td>
                                                                <td style="padding-right: 4px; padding-left: 4px">
                                                                    <asp:TextBox ID="txvJornalesD" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="110px">0</asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                                <tr>
                                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                                                    <td colspan="4" style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                                                        <div style="display: inline-block">
                                                            <select id="selTerceroCosecha" runat="server" class="multiselect" multiple="true" name="countries[]0" visible="False" style="width: 800px; height: 150px;">
                                                            </select>
                                                        </div>
                                                    </td>

                                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                                                </tr>
                                                <tr>
                                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                                                    <td colspan="4" style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                                                        <asp:ImageButton ID="imbCargar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCargar.png" OnClick="imbCargar_Click1" onmouseout="this.src='../../Imagen/Bonotes/btnCargar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnCargarN.png'" />
                                                        <asp:ImageButton ID="imbLiquidar" runat="server" ImageUrl="~/Imagen/Bonotes/btnLiquidar.png" OnClick="imbLiquidar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnLiquidar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnLiquidarN.png'" />
                                                        <asp:ImageButton ID="lbCancelarD" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelarD_Click" onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Cancela la operación" Visible="False" />
                                                    </td>
                                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                                                </tr>
                                                <tr>
                                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                                                    <td colspan="4" style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver">
                                                        <asp:GridView ID="gvSubTotales" runat="server" AutoGenerateColumns="False" BorderStyle="None" Width="800px">
                                                            <Columns>
                                                                <asp:BoundField DataField="novedades" HeaderText="Novedad">
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="70px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="subCantidad" HeaderText="SubCantidad">
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="70px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="subRacimo" HeaderText="SubRacimos">
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="70px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="SubJornal" HeaderText="SubJornales">
                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" Width="70px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="nombreNovedades" HeaderText="nombreNovedades">
                                                                    <ItemStyle HorizontalAlign="Left" />
                                                                </asp:BoundField>
                                                            </Columns>
                                                            <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" Font-Italic="False" Font-Names="Trebuchet MS" Font-Size="9pt" />
                                                            <RowStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Font-Names="Trebuchet MS" Font-Size="8pt" />
                                                        </asp:GridView>
                                                    </td>
                                                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver"></td>
                                                </tr>
                                                <tr>
                                                    <td></td>
                                                    <td colspan="4">
                                                        <asp:DataList ID="dlDetalle" runat="server" RepeatColumns="2" Style="margin-right: 0px" Width="100%" OnDeleteCommand="dlDetalle_DeleteCommand" RepeatDirection="Horizontal" OnItemCommand="dlDetalle_ItemCommand">
                                                            <ItemTemplate>
                                                                <div style="padding: 5px; border: solid; border-color: silver; border-width: 1px; width: 510px;">
                                                                    <div style="border: 1px solid silver;">
                                                                        <div style="padding: 2px">
                                                                            <table cellpadding="0" cellspacing="0" style="width: 100%;">
                                                                                <tr>
                                                                                    <td class="nombreCampos"><b style="text-align: left">Concepto</b></td>
                                                                                    <td class="nombreCampos"><b style="text-align: left">Código</b></td>
                                                                                    <td class="nombreCampos"><b>Descripción</b></td>
                                                                                    <td class="nombreCampos" style="width: 90px">&nbsp;</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 70px; text-align: left;">
                                                                                        <asp:Label ID="Label16" runat="server" Text="Novedad"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 20px; text-align: left">
                                                                                        <asp:Label ID="lblNovedad" runat="server" Text='<%# Eval("codnovedad") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">
                                                                                        <asp:Label ID="lblDesNovedad" runat="server" Text='<%# Eval("desnovedad") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">
                                                                                        <asp:Label ID="lblUmedida" runat="server" Text='<%# Eval("umedida") %>'></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 70px; text-align: left;">
                                                                                        <asp:Label ID="Label17" runat="server" Text="Sección"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 20px; text-align: left">
                                                                                        <asp:Label ID="lblSeccion" runat="server" Text='<%# Eval("codseccion") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">
                                                                                        <asp:Label ID="lblDesSeccion" runat="server" Text='<%# Eval("desseccion") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">
                                                                                        <asp:Label ID="lblPesoPromedio" runat="server" Text='<%# Eval("PesoRacimo") %>'></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 70px; text-align: left;">
                                                                                        <asp:Label ID="Label18" runat="server" Text="Lote"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 20px; text-align: left">
                                                                                        <asp:Label ID="lblLote" runat="server" Text='<%# Eval("codlote") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">
                                                                                        <asp:Label ID="lblDesLote" runat="server" Text='<%# Eval("deslote") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">
                                                                                        <asp:Label ID="lblpRacimos" runat="server"></asp:Label>
                                                                                        <asp:Label ID="lblDifKilos" runat="server"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 70px; text-align: left;">
                                                                                        <asp:Label ID="Label19" runat="server" Text="Fecha"></asp:Label>
                                                                                    </td>
                                                                                    <td style="width: 20px; text-align: left">
                                                                                        <asp:Label ID="lblFechaD" runat="server" Text='<%# Eval("fechaD") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">
                                                                                        <asp:Label ID="Label20" runat="server" Text="Precio Labor $"></asp:Label>
                                                                                        <asp:Label ID="lblPrecioLabor" runat="server" Text='<%# Eval("precioLabor") %>'></asp:Label>
                                                                                    </td>
                                                                                    <td style="text-align: left">&nbsp;</td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td style="width: 70px; text-align: left;">
                                                                                        <asp:Label ID="lblTercero" runat="server" Text="Trabajador"></asp:Label>
                                                                                    </td>
                                                                                    <td colspan="2" style="text-align: left">
                                                                                        <asp:DropDownList ID="ddlTerceroGrilla" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="350px">
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td style="text-align: center">
                                                                                        <asp:ImageButton ID="imbCargarTercero" runat="server" ImageUrl="~/Imagen/TabsIcon/edit_add.png" CommandName="Select" ToolTip="Seleccione el tercero que desea agregar" />
                                                                                        <asp:ImageButton ID="imbCargarTercero0" runat="server" CommandName="Update" ImageUrl="~/Imagen/TabsIcon/no.png" ToolTip="Antes chequee el terceros en la grilla que quiere eliminar" />
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </div>
                                                                    <div style="padding-top: 2px">
                                                                        <table cellpadding="0" cellspacing="0" class="ui-accordion">
                                                                            <tr>
                                                                                <td style="text-align: left; width: 90px;">
                                                                                    <asp:Label ID="lblCantidadD0" runat="server" CssClass="ui-priority-primary" Text="Cantidad"></asp:Label>
                                                                                </td>
                                                                                <td style="text-align: left">
                                                                                    <asp:TextBox ID="txvCantidadG" runat="server" CssClass="input" onkeyup="formato_numero(this)" Width="70px" Text='<%# Eval("cantidad") %>'></asp:TextBox>
                                                                                </td>
                                                                                <td style="text-align: left"></td>
                                                                                <td></td>
                                                                                <td style="text-align: left; width: 90px;">
                                                                                    <asp:Label ID="lblRacimosN" runat="server" CssClass="ui-priority-primary" Text="No. racimos"></asp:Label>
                                                                                </td>
                                                                                <td style="text-align: left">
                                                                                    <asp:TextBox ID="txvRacimoG" runat="server" CssClass="input" onkeyup="formato_numero(this)" Text='<%# Eval("racimos") %>' Width="70px" AutoPostBack="True" OnTextChanged="txvRacimoG_TextChanged"></asp:TextBox>
                                                                                </td>
                                                                                <td style="text-align: left">
                                                                                    <asp:Label ID="lblRacimosN0" runat="server" CssClass="ui-priority-primary" Text="Jornales"></asp:Label>
                                                                                </td>
                                                                                <td style="text-align: left">
                                                                                    <asp:TextBox ID="txvJornalesD" runat="server" CssClass="input" onkeyup="formato_numero(this)" Text='<%# Eval("jornal") %>' Width="70px" AutoPostBack="True" OnTextChanged="txvJornalesD_TextChanged"></asp:TextBox>
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>

                                                                    <div style="padding-top: 3px; padding-bottom: 3px">
                                                                        <asp:GridView ID="gvLotes" runat="server" AutoGenerateColumns="False" CssClass="Grid" OnPageIndexChanging="gvLista_PageIndexChanging" PageSize="5" Width="500px">
                                                                            <AlternatingRowStyle CssClass="alt" />
                                                                            <Columns>
                                                                                <asp:TemplateField HeaderText="Elim">
                                                                                    <ItemTemplate>
                                                                                        <asp:CheckBox ID="chkSeleccion" runat="server" OnCheckedChanged="chkSeleccion_CheckedChanged" ToolTip="Eliminar tercero" />
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle CssClass="Items" Width="20px" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="codTercero" HeaderText="codTrab" ReadOnly="True">
                                                                                    <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="30px" />
                                                                                </asp:BoundField>
                                                                                <asp:BoundField DataField="desTercero" HeaderText="NombreTrabajador">
                                                                                    <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Width="200px" />
                                                                                </asp:BoundField>
                                                                                <asp:TemplateField HeaderText="Cantidad">
                                                                                    <ItemTemplate>
                                                                                        <asp:TextBox ID="txtCantidad" runat="server" CssClass="input" Enabled="False" Text='<%# Eval("cantidad") %>' Width="70px"></asp:TextBox>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle CssClass="Items" Width="70px" />
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField HeaderText="Jornal">
                                                                                    <ItemTemplate>
                                                                                        <asp:TextBox ID="txtJornal" runat="server" CssClass="input" Enabled="False" Text='<%# Eval("jornal") %>' Width="70px"></asp:TextBox>
                                                                                    </ItemTemplate>
                                                                                    <ItemStyle CssClass="Items" Width="70px" />
                                                                                </asp:TemplateField>
                                                                                <asp:BoundField DataField="precioLabor" HeaderText="Precio($)" />
                                                                            </Columns>
                                                                            <PagerStyle CssClass="pgr" />
                                                                            <RowStyle CssClass="rw" />
                                                                        </asp:GridView>
                                                                    </div>


                                                                    <div>
                                                                        <table cellpadding="0" cellspacing="0" class="ui-accordion">
                                                                            <tr>
                                                                                <td style="text-align: left; width: 150px;">
                                                                                    <asp:Label ID="Label1" runat="server" CssClass="ui-priority-primary" Text="Registro por novedad No."></asp:Label>
                                                                                </td>
                                                                                <td style="text-align: left">
                                                                                    <asp:Label ID="lblRegistro" runat="server" Text='<%# Eval("registro") %>'></asp:Label>
                                                                                </td>
                                                                                <td style="width: 100px"></td>
                                                                                <td style="text-align: right">
                                                                                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/Imagen/Bonotes/btnEliminar.png" onmouseout="this.src='../../Imagen/Bonotes/btnEliminar.png'" onmouseover="this.src='../../Imagen/Bonotes/btnEliminarN.png'" CommandName="Delete" />
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </div>
                                                                </div>
                                                            </ItemTemplate>
                                                            <SeparatorStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        </asp:DataList>
                                                    </td>
                                                    <td></td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </div>

                        <asp:UpdatePanel ID="upConsulta" runat="server" Visible="False" UpdateMode="Conditional">
                            <ContentTemplate>
                                <div style="text-align: center">
                                    <div style="display: inline-block; padding-top: 10px;">
                                        <table cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td style="padding: 2px"></td>
                                                <td style="padding: 2px">
                                                    <asp:DropDownList ID="niddlCampo" runat="server" ToolTip="Selección de campo para busqueda" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Width="250px">
                                                        <asp:ListItem Value="tiquete">Tiquete</asp:ListItem>
                                                        <asp:ListItem Value="fecha">Fecha</asp:ListItem>
                                                        <asp:ListItem Value="numero">Número</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="padding: 2px">
                                                    <asp:DropDownList ID="niddlOperador" runat="server" data-placeholder="Seleccione una opción..." CssClass="chzn-select" AutoPostBack="True" OnSelectedIndexChanged="niddlOperador_SelectedIndexChanged" ToolTip="Selección de operador para busqueda" Width="125px">
                                                        <asp:ListItem Value="like">Contiene</asp:ListItem>
                                                        <asp:ListItem Value="&lt;&gt;">Diferente</asp:ListItem>
                                                        <asp:ListItem Value="between">Entre</asp:ListItem>
                                                        <asp:ListItem Selected="True" Value="=">Igual</asp:ListItem>
                                                        <asp:ListItem Value="&gt;=">Mayor o Igual</asp:ListItem>
                                                        <asp:ListItem Value="&gt;">Mayor que</asp:ListItem>
                                                        <asp:ListItem Value="&lt;=">Menor o Igual</asp:ListItem>
                                                        <asp:ListItem Value="&lt;">Menor</asp:ListItem>
                                                    </asp:DropDownList>
                                                </td>
                                                <td style="padding: 2px">
                                                    <asp:TextBox ID="nitxtValor1" runat="server" AutoPostBack="True" CssClass="input" OnTextChanged="nitxtValor1_TextChanged" Width="200px"></asp:TextBox>
                                                    <asp:TextBox ID="nitxtValor2" runat="server" CssClass="input" Visible="False" Width="200px"></asp:TextBox>
                                                </td>
                                                <td style="padding: 2px">
                                                    <asp:ImageButton ID="niimbAdicionar" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Enabled="False" ImageUrl="~/Imagen/TabsIcon/filter.png" OnClick="niimbAdicionar_Click" ToolTip="Clic aquí para adicionar parámetro a la busqueda" Width="18px" />
                                                </td>
                                                <td style="padding: 2px">
                                                    <asp:ImageButton ID="imbBusqueda" runat="server" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" Enabled="False" ImageUrl="~/Imagen/TabsIcon/search.png" OnClick="imbBusqueda_Click" Style="height: 18px" ToolTip="Clic aquí para realizar la busqueda" Visible="False" />
                                                </td>
                                                <td style="padding: 2px">
                                                    <asp:Label ID="nilblRegistros" runat="server" Text="Nro. Registros 0"></asp:Label>
                                                </td>
                                                <td style="padding: 2px;"></td>
                                            </tr>
                                            <tr>
                                                <td style="text-align: center;" colspan="8">
                                                    <asp:Label ID="nilblMensajeEdicion" runat="server" ForeColor="Navy"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="8" style="text-align: center;">
                                                    <div style="text-align: center">
                                                        <div style="display: inline-block">
                                                            <asp:GridView ID="gvParametros" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" OnRowDeleting="gvParametros_RowDeleting" Width="400px">
                                                                <AlternatingRowStyle CssClass="alt" />
                                                                <Columns>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <asp:ImageButton ID="imbEliminarParametro1" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" ToolTip="Elimina el parámetro de la consulta" />
                                                                        </ItemTemplate>
                                                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:BoundField DataField="campo" HeaderText="Campo">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="operador" HeaderText="Operador">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="valor" HeaderText="Valor">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="valor2" HeaderText="Valor 2">
                                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <PagerStyle CssClass="pgr" />
                                                                <RowStyle CssClass="rw" />
                                                            </asp:GridView>
                                                        </div>
                                                    </div>
                                                </td>
                                            </tr>


                                        </table>
                                    </div>
                                    <div style="text-align: center">
                                        <div style="display: inline-block; width: 950px;">
                                            <asp:GridView ID="gvTransaccion" runat="server" AutoGenerateColumns="False" CssClass="Grid" GridLines="None" OnRowDeleting="gvTransaccion_RowDeleting" OnRowUpdating="gvTransaccion_RowUpdating" Width="950px" AllowPaging="True" OnPageIndexChanging="gvTransaccion_PageIndexChanging">
                                                <PagerStyle CssClass="pgr" />
                                                <RowStyle CssClass="rw" />
                                                <Columns>
                                                    <asp:ButtonField ButtonType="Image" CommandName="Update" HeaderText="Edit" ImageUrl="~/Imagen/TabsIcon/pencil.png" Text="Botón">
                                                        <ItemStyle CssClass="Items" Width="20px" />
                                                    </asp:ButtonField>
                                                    <asp:TemplateField HeaderText="Elim">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imElimina" runat="server" CommandName="Delete" ImageUrl="~/Imagen/TabsIcon/cancel.png" OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" ToolTip="Elimina el registro seleccionado" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" />
                                                        <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="40px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="numero" HeaderText="Numero">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="160px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="Fecha">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="50px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="tiquete" HeaderText="Tiquete">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" Width="90px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="observacion" HeaderText="Observación">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:CheckBoxField DataField="anulado" HeaderText="Anul">
                                                        <ItemStyle CssClass="Items" HorizontalAlign="Center" Width="20px" />
                                                    </asp:CheckBoxField>
                                                </Columns>
                                                <AlternatingRowStyle CssClass="alt" />
                                            </asp:GridView>
                                        </div>
                                    </div>
                                </div>

                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                    <div>
                    </div>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="txtFiltroBascula" EventName="TextChanged" />
                </Triggers>
            </asp:UpdatePanel>
        </div>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>
