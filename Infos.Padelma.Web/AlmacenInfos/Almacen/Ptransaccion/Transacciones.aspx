<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transacciones.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1" Theme="Entidades" %>

<%@ Register Src="../ControlesUsuario/NumericII.ascx" TagName="NumericII" TagPrefix="uc3" %>

<%@ Register Assembly="System.Web.Extensions, Version=3.5.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>
<%@ OutputCache Location="None" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <script src="../../js/jquery.js" type="text/javascript"></script>
    <script type="text/javascript">
        function formato(entrada) {
            if (window.event.keyCode != 9) {
                var num = entrada.value.replace(/\,/g, '');
                var totalGlobal = 0;
                var total = 0;
                var totalDes = 0;
                var iva = 0;
                var des = 0;
                var neto = 0;
                var netoGlobal = 0;

                if (!isNaN(num)) {
                    num = num.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                    num = num.split('').reverse().join('').replace(/^[\,]/, '');
                    entrada.value = num;

                    controlGrillaRef = document.getElementById("gvReferencia");


                    if (controlGrillaRef != null) {
                        for (i = 1; i < controlGrillaRef.rows.length; i++) {
                            objeto = controlGrillaRef.rows[i].getElementsByTagName("input");

                            if (objeto != null) {

                                /* if(objeo[0].type == "text" && objeto[1].type == "text")
                                { */

                                total = parseFloat(objeto[1].value.replace(/\,/g, '')) * parseFloat(objeto[2].value.replace(/\,/g, ''));
                                des = parseFloat(total * objeto[4].value.replace(/\,/g, '') / 100);
                                totalDes = total - des;
                                iva = parseFloat(total * objeto[3].value.replace(/\,/g, '') / 100);
                                neto = parseFloat(totalDes + iva);

                                if (!isNaN(total)) {
                                    totalGlobal += parseFloat(total);
                                    netoGlobal += parseFloat(neto)

                                    total = total.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                                    total = total.split('').reverse().join('').replace(/^[\,]/, '');

                                    iva = iva.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                                    iva = iva.split('').reverse().join('').replace(/^[\,]/, '');

                                    des = des.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                                    des = des.split('').reverse().join('').replace(/^[\,]/, '');

                                    neto = neto.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                                    neto = neto.split('').reverse().join('').replace(/^[\,]/, '');

                                    controlGrillaRef.rows[i].cells[11].innerHTML = des;
                                    controlGrillaRef.rows[i].cells[9].innerHTML = iva;
                                    controlGrillaRef.rows[i].cells[10].innerHTML = total;
                                    controlGrillaRef.rows[i].cells[12].innerHTML = neto;
                                }
                                //}
                            }
                        }
                    }

                    controlValorTotal = document.getElementById("nitxtTotalValorTotal");

                    if (controlValorTotal != null) {
                        totalGlobal = totalGlobal.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                        totalGlobal = totalGlobal.split('').reverse().join('').replace(/^[\,]/, '');

                        controlValorTotal.value = totalGlobal;
                        hdValorTotalRef = document.getElementById("hdValorTotalRef");
                        hdValorTotalRef.value = totalGlobal;
                    }

                    controlNetoTotal = document.getElementById("nitxtTotalValorNeto");

                    if (controlNetoTotal != null) {
                        netoGlobal = netoGlobal.toString().split('').reverse().join('').replace(/(?=\d*\,?)(\d{3})/g, '$1,');
                        netoGlobal = netoGlobal.split('').reverse().join('').replace(/^[\,]/, '');

                        controlNetoTotal.value = netoGlobal;
                        hdValorNetoRef = document.getElementById("hdValorNetoRef");
                        hdValorNetoRef.value = netoGlobal;
                    }
                }
                else {
                    alert('Solo se permiten números');
                    entrada.value = entrada.value.replace(/[^\d\.\,]*/g, '');
                }
            }
        }
    </script>
    <script type="text/javascript">
        $(function () {
            $('.bubbleInfo').each(function () {
                var distance = 10;
                var time = 250;
                var hideDelay = 500;

                var hideDelayTimer = null;

                var beingShown = false;
                var shown = false;
                var trigger = $('.trigger', this);
                var info = $('.popup', this).css('opacity', 0);


                $([trigger.get(0), info.get(0)]).mouseover(function () {
                    if (hideDelayTimer) clearTimeout(hideDelayTimer);
                    if (beingShown || shown) {
                        // don't trigger the animation again
                        return;
                    } else {
                        // reset position of info box
                        beingShown = true;

                        info.css({
                            top: -115,
                            left: -33,
                            display: 'block'
                        }).animate({
                            top: '-=' + distance + 'px',
                            opacity: 1
                        }, time, 'swing', function () {
                            beingShown = false;
                            shown = true;
                        });
                    }

                    return false;
                }).mouseout(function () {
                    if (hideDelayTimer) clearTimeout(hideDelayTimer);
                    hideDelayTimer = setTimeout(function () {
                        hideDelayTimer = null;
                        info.animate({
                            top: '-=' + distance + 'px',
                            opacity: 0
                        }, time, 'swing', function () {
                            shown = false;
                            info.css('display', 'none');
                        });

                    }, hideDelay);

                    return false;
                });
            });
        });

        //-->


    </script>
    <link href="../../css/prueba.css" rel="stylesheet" type="text/css" />
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <div style="text-align: center">
            <div style="display: inline-block">
                <div class="principal">
                    <div style="vertical-align: top; width: 1000px; height: 600px; text-align: left">
                        <table cellspacing="0" style="width: 1000px" cellpadding="0">
                            <tr>
                                <td style="text-align: left">
                                    <asp:ImageButton ID="niimbRegistro" runat="server" Height="25px" ImageUrl="~/Imagenes/botones/Pestana Registro.jpg"
                                        Width="100px" OnClick="niimbRegistro_Click" Enabled="False" /><asp:ImageButton ID="niimbConsulta" runat="server" Height="25px"
                                            ImageUrl="~/Imagenes/botones/PestanaConsulta.jpg" Width="100px" OnClick="niimbConsulta_Click" BorderColor="White" BorderStyle="Solid" BorderWidth="1px" /></td>
                            </tr>
                        </table>
                        <asp:UpdatePanel ID="UpdatePanelRegistro" runat="server">
                            <ContentTemplate>

                                <table id="encabezado" cellspacing="0" style="width: 1000px">
                                    <tr>
                                        <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 200px; background-repeat: no-repeat; text-align: right;">
                                            <asp:LinkButton ID="nilbNuevo" runat="server" ForeColor="#404040" OnClick="nilbNuevo_Click" ToolTip="Habilita el formulario para un nuevo registro" Font-Bold="True">>> Nuevo Registro</asp:LinkButton><asp:LinkButton ID="lbCancelar" runat="server" ForeColor="#404040" Visible="False" OnClick="lbCancelar_Click" ToolTip="Cancela la operación" CausesValidation="False"><< Cancelar</asp:LinkButton></td>
                                        <td style="width: 600px; text-align: center;">
                                            <asp:Label ID="nilblInformacion" runat="server" ForeColor="Red"></asp:Label></td>
                                        <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png); width: 200px; background-repeat: no-repeat; text-align: left;">
                                            <asp:LinkButton ID="lbRegistrar" runat="server" ForeColor="#404040"
                                                OnClientClick="if(!confirm('Desea insertar el registro ?')){return false;};"
                                                Visible="False" ToolTip="Guarda el nuevo registro en la base de datos" OnClick="lbRegistrar_Click">>> Guardar</asp:LinkButton><asp:LinkButton
                                                    ID="lbImprimir" runat="server" ForeColor="#404040" OnClick="lbImprimir_Click1"
                                                    ToolTip="Imprime la transacción actual" Visible="False">Imprimir</asp:LinkButton></td>
                                    </tr>
                                    <tr>
                                        <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 200px; background-repeat: no-repeat; text-align: right; height: 48px;"></td>
                                        <td style="width: 600px; text-align: center; height: 48px;">
                                            <table cellspacing="0" style="width: 600px">
                                                <tr>
                                                    <td style="width: 125px; height: 25px; text-align: left">
                                                        <asp:Label ID="lblTipoDocumento" runat="server" Text="Tipo Transacción" Visible="False"></asp:Label></td>
                                                    <td style="width: 260px; height: 25px; text-align: left">
                                                        <asp:DropDownList ID="ddlTipoDocumento" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlTipoDocumento_SelectedIndexChanged"
                                                            Visible="False" Width="250px">
                                                        </asp:DropDownList></td>
                                                    <td style="width: 65px; height: 25px; text-align: left">
                                                        <asp:Label ID="lblNumero" runat="server" Text="Numero" Visible="False"></asp:Label></td>
                                                    <td style="width: 150px; height: 25px; text-align: left">
                                                        <asp:TextBox ID="txtNumero" runat="server" AutoPostBack="True" OnTextChanged="txtNumero_TextChanged"
                                                            Visible="False" Width="150px"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="background-image: url(../../Imagenes/botones/BotonDer.png); width: 200px; background-repeat: no-repeat; text-align: right; background-position-x: right; height: 48px;"></td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanelEncabezado" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table cellspacing="0" style="width: 1000px; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid;" id="datosCab">
                                    <tr>
                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                        <td style="width: 125px; height: 10px; text-align: left"></td>
                                        <td style="width: 175px; height: 10px; text-align: left"></td>
                                        <td style="width: 100px; height: 10px; text-align: left;"></td>
                                        <td style="width: 400px; height: 10px; text-align: left;"></td>
                                        <td style="width: 100px; height: 10px; text-align: left;"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px; text-align: left"></td>
                                        <td style="vertical-align: top; width: 125px; text-align: left">
                                            <asp:LinkButton ID="lbFecha" runat="server" ForeColor="#404040" OnClick="lbFecha_Click"
                                                Visible="False">Fecha Transacción</asp:LinkButton></td>
                                        <td style="vertical-align: top; width: 175px; text-align: left">
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
                                        <td style="vertical-align: top; width: 100px; text-align: left">
                                            <asp:Label ID="lblObservacion" runat="server" Text="Observaciones" Visible="False"></asp:Label></td>
                                        <td style="vertical-align: top; width: 400px; text-align: left">
                                            <asp:TextBox ID="txtObservacion" runat="server" Visible="False"
                                                Width="400px" Height="30px" TextMode="MultiLine"></asp:TextBox>
                                            <asp:HiddenField ID="hdValorTotalRef" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdValorNetoRef" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdTransaccionConfig" runat="server" />
                                            <asp:HiddenField ID="hdCantidad" runat="server" Value="0" />
                                            <asp:HiddenField ID="hdRegistro" runat="server" Value="0" />
                                        </td>
                                        <td style="width: 100px; text-align: left"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                        <td style="width: 125px; height: 10px; text-align: left">
                                            <asp:Label ID="lblDocref" runat="server" Text="Doc. Referencia" Visible="False"></asp:Label></td>
                                        <td style="width: 175px; height: 10px; text-align: left">
                                            <asp:TextBox ID="txtDocref" runat="server" Visible="False" Width="160px"></asp:TextBox></td>
                                        <td style="width: 100px; height: 10px; text-align: left;">
                                            <asp:Label ID="lblTercero" runat="server" Text="Tercero" Visible="False"></asp:Label></td>
                                        <td style="width: 400px; height: 10px; text-align: left;">
                                            <asp:DropDownList ID="ddlTercero" runat="server" Visible="False" Width="400px" AutoPostBack="True" OnSelectedIndexChanged="ddlTercero_SelectedIndexChanged">
                                            </asp:DropDownList></td>
                                        <td style="width: 100px; height: 10px; text-align: left;"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                        <td style="width: 125px; height: 10px; text-align: left">
                                            <asp:Label ID="lblVigencia" runat="server" Text="Días Vigencia" Visible="False"></asp:Label></td>
                                        <td style="width: 175px; height: 10px; text-align: left">
                                            <asp:TextBox ID="txtVigencia" runat="server" Width="60px" Visible="False"></asp:TextBox></td>
                                        <td style="width: 100px; height: 10px; text-align: left">
                                            <asp:Label ID="lblTipoSalida" runat="server" Text="Tipo Salida" Visible="False"></asp:Label></td>
                                        <td style="width: 400px; height: 10px; text-align: left">
                                            <asp:DropDownList ID="ddlTipoSalida" runat="server" Visible="False" Width="400px">
                                            </asp:DropDownList></td>
                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                        <td style="width: 125px; height: 10px; text-align: left"></td>
                                        <td style="width: 175px; height: 10px; text-align: left"></td>
                                        <td style="width: 100px; height: 10px; text-align: left">
                                            <asp:Label ID="lblDepartamento" runat="server" Text="Departamento" Visible="False"></asp:Label></td>
                                        <td style="width: 400px; height: 10px; text-align: left">
                                            <asp:DropDownList ID="ddlDepartamento" runat="server" Visible="False" Width="400px">
                                            </asp:DropDownList></td>
                                        <td style="width: 100px; height: 10px; text-align: left"></td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanelDetalle" runat="server" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                    <tr>
                                        <td style="width: 75px; height: 10px;"></td>
                                        <td style="width: 175px; height: 10px;"></td>
                                        <td style="width: 750px; height: 10px;"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 75px">
                                            <asp:Label ID="lblProducto" runat="server" Text="Producto" Visible="False"></asp:Label></td>
                                        <td style="width: 175px">
                                            <asp:TextBox ID="txtProducto" runat="server" Width="150px" Visible="False" AutoPostBack="True" OnTextChanged="txtProducto_TextChanged"></asp:TextBox></td>
                                        <td style="width: 750px">
                                            <asp:DropDownList ID="ddlProducto" runat="server" Width="650px" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlProducto_SelectedIndexChanged">
                                            </asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 75px; height: 10px;"></td>
                                        <td style="width: 175px; height: 10px;"></td>
                                        <td style="width: 750px; height: 10px;"></td>
                                    </tr>
                                </table>
                                <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="datosDet">
                                    <tr>
                                        <td style="width: 200px; text-align: left; vertical-align: top; height: 199px;">
                                            <table cellspacing="0" style="width: 200px; border-right: gray thin solid; border-top: gray thin solid; border-left: gray thin solid; border-bottom: gray thin solid;" id="TABLE1" onclick="return TABLE1_onclick()">
                                                <tr>
                                                    <td style="width: 200px; text-align: left"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblBodega" runat="server" Text="Bodega" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:DropDownList ID="ddlBodega" runat="server" Visible="False" Width="200px">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblUmedida" runat="server" Text="Und. Medida" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:DropDownList ID="ddlUmedida" runat="server" Width="200px" Visible="False">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblCantidad" runat="server" Text="Cantidad" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:TextBox ID="txvCantidadDetalle" runat="server" CssClass="input" Width="150px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblValorUnitario" runat="server" Text="Valor Unitario" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:TextBox ID="txvCantidadDetalle0" runat="server" CssClass="input" Width="150px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblPiva" runat="server" Text="% I.V.A" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:TextBox ID="txvCantidadDetalle1" runat="server" CssClass="input" Width="150px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblRteFte" runat="server" Text="% Rte. Fte." Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:TextBox ID="txvCantidadDetalle2" runat="server" CssClass="input" Width="150px"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblDestino" runat="server" Text="Destino" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:DropDownList ID="ddlDestino" runat="server" Width="200px" Visible="False" AutoPostBack="True" OnSelectedIndexChanged="ddlDestino_SelectedIndexChanged">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblCuenta" runat="server" Text="Cuenta" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:DropDownList ID="ddlCuenta" runat="server" Width="200px" Visible="False" OnSelectedIndexChanged="ddlCuenta_SelectedIndexChanged" AutoPostBack="True">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblCcosto" runat="server" Text="C. Costo" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:DropDownList ID="ddlCcosto" runat="server" Width="200px" Visible="False">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:CheckBox ID="chkInversion" runat="server" Text="Inversión" Visible="False" OnCheckedChanged="chkInversion_CheckedChanged" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:Label ID="lblDetalle" runat="server" Text="Detalle" Visible="False"></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left">
                                                        <asp:TextBox ID="txtDetalle" runat="server" TextMode="MultiLine" Visible="False"
                                                            Width="200px"></asp:TextBox></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: center">
                                                        <asp:Button ID="btnRegistrar" runat="server" OnClick="btnRegistrar_Click" Text="Registrar"
                                                            Visible="False" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 200px; text-align: left"></td>
                                                </tr>
                                            </table>
                                        </td>
                                        <td style="width: 756px; text-align: left; vertical-align: top;">
                                            <asp:GridView ID="gvAjuste" runat="server" Width="500px" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" GridLines="None" RowHeaderColumn="cuenta" Visible="False" CssClass="Grid">
                                                <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <Columns>
                                                    <asp:BoundField DataField="bodega" HeaderText="Bodega">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="costo" DataFormatString="{0:N2}" HeaderText="Costo">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="saldo" DataFormatString="{0:N2}" FooterText="Saldos"
                                                        HeaderText="Saldo">
                                                        <FooterStyle HorizontalAlign="Left" />
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="uMedida" HeaderText="U. Medida">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Cantidad Ajuste">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtCantidadAjuste" runat="server" Width="100px" onkeyup="formato(this)" onchange="formato(this)"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                            HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle Font-Bold="True" />
                                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="False" />
                                                <AlternatingRowStyle BackColor="#E0E0E0" />

                                            </asp:GridView>
                                            <asp:GridView ID="gvSaldo" runat="server" Width="700px" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" GridLines="None" RowHeaderColumn="cuenta" CssClass="Grid">
                                                <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <Columns>
                                                    <asp:BoundField DataField="saldo" DataFormatString="{0:N}" HeaderText="Saldo Fisico">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Requerimientos">
                                                        <ItemTemplate>
                                                            <div class="bubbleInfo">
                                                                <asp:Label class="trigger" ID="lblRequerimientos" runat="server" Text='<%# Convert.ToDecimal( Eval( "requerimiento" ) ) %>'></asp:Label>

                                                                <table id="dpop" class="popup">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="corner" id="topleft"></td>
                                                                            <td class="top"></td>
                                                                            <td class="corner" id="topright"></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td class="left"></td>
                                                                            <td>
                                                                                <table class="popup-contents">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">Requerimientos sin salida
        				 <asp:GridView ID="gvDetalleReque" runat="server" AutoGenerateColumns="False" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Names="Calibri" Font-Size="12px" Style="left: 0px; top: 24px" Width="200px" Font-Bold="False">
                             <RowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <Columns>
                                 <asp:BoundField DataField="numero" HeaderText="N&#250;mero">
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                     <ItemStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="Fecha">
                                     <ItemStyle HorizontalAlign="Right" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="cantidad" DataFormatString="{0:N}" HeaderText="Cantidad">
                                     <ItemStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                 </asp:BoundField>
                             </Columns>
                             <FooterStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <PagerStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <SelectedRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <EmptyDataRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <EditRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <AlternatingRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                         </asp:GridView>
                                                                                            </td>
                                                                                        </tr>

                                                                                    </tbody>
                                                                                </table>

                                                                            </td>
                                                                            <td class="right"></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td class="corner" id="bottomleft"></td>
                                                                            <td class="bottom">
                                                                                <img width="30" height="29" alt="popup tail" src="http://static.jqueryfordesigners.com/demo/images/coda/bubble-tail2.png" />
                                                                            </td>
                                                                            <td id="bottomright" class="corner"></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>


                                                            </div>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Saldo Disponible">
                                                        <ItemTemplate>
                                                            <div class="bubbleInfo">

                                                                <asp:Label class="trigger" ID="lblSaldoActual" runat="server" Text='<%# Convert.ToDecimal( Eval( "saldo" ) ) - Convert.ToDecimal( Eval( "requerimiento" ) ) %>'></asp:Label>&nbsp;
                          
                                                            </div>

                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Compras Pendientes">
                                                        <ItemTemplate>
                                                            <div class="bubbleInfo">
                                                                <asp:Label class="trigger" ID="lbComprasPendiente" runat="server" Text='<%#Convert.ToDecimal( Eval("compra")) %>'></asp:Label>
                                                                <table id="dpop" class="popup">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="corner" id="topleft"></td>
                                                                            <td class="top"></td>
                                                                            <td class="corner" id="topright"></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td class="left"></td>
                                                                            <td>
                                                                                <table class="popup-contents">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">Compras sin entradas
        				 <asp:GridView ID="gvDetalleCompra" runat="server" AutoGenerateColumns="False" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Names="Calibri" Font-Size="12px" Style="left: 0px; top: 24px" Width="200px" Font-Bold="False">
                             <RowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <Columns>
                                 <asp:BoundField DataField="numero" HeaderText="N&#250;mero">
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                     <ItemStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="Fecha">
                                     <ItemStyle HorizontalAlign="Right" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="cantidad" DataFormatString="{0:N}" HeaderText="Cantidad">
                                     <ItemStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                 </asp:BoundField>
                             </Columns>
                             <FooterStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <PagerStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <SelectedRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <EmptyDataRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <EditRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <AlternatingRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                         </asp:GridView>
                                                                                            </td>
                                                                                        </tr>

                                                                                    </tbody>
                                                                                </table>

                                                                            </td>
                                                                            <td class="right"></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td class="corner" id="bottomleft"></td>
                                                                            <td class="bottom">
                                                                                <img width="30" height="29" alt="popup tail" src="http://static.jqueryfordesigners.com/demo/images/coda/bubble-tail2.png" />
                                                                            </td>
                                                                            <td id="bottomright" class="corner"></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>

                                                            </div>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Requi. Pendientes">
                                                        <ItemTemplate>
                                                            <div class="bubbleInfo">
                                                                <asp:Label class="trigger" ID="lbRequesiciones" runat="server" Text='<%# Convert.ToDecimal( Eval( "requisicion" ) ) %>'></asp:Label>

                                                                <table id="dpop" class="popup">
                                                                    <tbody>
                                                                        <tr>
                                                                            <td class="corner" id="topleft"></td>
                                                                            <td class="top"></td>
                                                                            <td class="corner" id="topright"></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td class="left"></td>
                                                                            <td>
                                                                                <table class="popup-contents">
                                                                                    <tbody>
                                                                                        <tr>
                                                                                            <td align="center">Requisiciones sin OCO
        				 <asp:GridView ID="gvDetalleRequi" runat="server" AutoGenerateColumns="False" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Names="Calibri" Font-Size="12px" Style="left: 0px; top: 24px" Width="200px" Font-Bold="False">
                             <RowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <Columns>
                                 <asp:BoundField DataField="numero" HeaderText="N&#250;mero">
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                     <ItemStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="fecha" DataFormatString="{0:d}" HeaderText="Fecha">
                                     <ItemStyle HorizontalAlign="Right" BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                 </asp:BoundField>
                                 <asp:BoundField DataField="cantidad" DataFormatString="{0:N}" HeaderText="Cantidad">
                                     <ItemStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="False" />
                                     <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" Font-Bold="True" />
                                 </asp:BoundField>
                             </Columns>
                             <FooterStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <PagerStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <SelectedRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <HeaderStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <EmptyDataRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <EditRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                             <AlternatingRowStyle BorderColor="#E0E0E0" BorderStyle="Solid" BorderWidth="1px" />
                         </asp:GridView>
                                                                                            </td>
                                                                                        </tr>

                                                                                    </tbody>
                                                                                </table>

                                                                            </td>
                                                                            <td class="right"></td>
                                                                        </tr>

                                                                        <tr>
                                                                            <td class="corner" id="bottomleft"></td>
                                                                            <td class="bottom">
                                                                                <img width="30" height="29" alt="popup tail" src="http://static.jqueryfordesigners.com/demo/images/coda/bubble-tail2.png" />
                                                                            </td>
                                                                            <td id="bottomright" class="corner"></td>
                                                                        </tr>
                                                                    </tbody>
                                                                </table>

                                                            </div>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <FooterStyle Font-Bold="True" />
                                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="False" />
                                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                            </asp:GridView>

                                            <br />
                                            <asp:GridView ID="gvLista" runat="server" Width="1200px" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" OnRowDeleting="gvLista_RowDeleting" OnSelectedIndexChanged="gvLista_SelectedIndexChanged" GridLines="None" RowHeaderColumn="cuenta" CssClass="Grid">
                                                <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imbEditar" runat="server" CommandName="Select" ImageUrl="~/Imagenes/botones/Edit.png"
                                                                ToolTip="Edita el registro seleccionado" Width="17px" Height="17px" ImageAlign="Middle" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                            HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imbEliminar" runat="server" CommandName="Delete" ImageUrl="~/Imagenes/botones/anular.png"
                                                                ToolTip="Elimina el registro seleccionado" Width="17px" Height="17px" ImageAlign="Middle"
                                                                OnClientClick="if(!confirm('Desea eliminar el registro ?')){return false;};" />
                                                        </ItemTemplate>
                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                        <HeaderStyle HorizontalAlign="Center" VerticalAlign="Middle" BackColor="White" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="bodega" HeaderText="Bodega">
                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="producto" HeaderText="Producto">
                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="detalle" HeaderText="Detalle">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="cantidad" DataFormatString="{0:N2}" HeaderText="Cantidad">
                                                        <HeaderStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle HorizontalAlign="Right" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="uMedida" HeaderText="U. Medida">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valorUnitario" DataFormatString="{0:N2}" HeaderText="Vl. Unitario">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valorTotal" DataFormatString="{0:N2}" HeaderText="Vl. Total">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="iva" DataFormatString="{0:N2}" HeaderText="% I.V.A.">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="Cuenta" HeaderText="Cuenta">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="destino" HeaderText="Destino">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:CheckBoxField DataField="inversion" HeaderText="Inversi&#243;n">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    </asp:CheckBoxField>
                                                    <asp:BoundField DataField="Ccosto" HeaderText="C. Costo">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="vIva" DataFormatString="{0:N2}" HeaderText="V. I.V.A">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="neto" DataFormatString="{0:N2}" HeaderText="Neto">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkAnulado" runat="server" Enabled="False" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" />
                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                            HorizontalAlign="Center" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="registro">
                                                        <HeaderStyle BackColor="White" />
                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                            HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <FooterStyle BackColor="LightYellow" Font-Bold="True" />
                                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="False" />
                                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                            </asp:GridView>
                                            <br />
                                            <asp:GridView ID="gvTotal" runat="server" Width="300px" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" GridLines="None" RowHeaderColumn="cuenta" ShowFooter="True" CssClass="Grid">
                                                <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <Columns>
                                                    <asp:BoundField DataField="valorTotal" DataFormatString="{0:N2}" FooterText="Totales"
                                                        HeaderText="Vl. Total">
                                                        <FooterStyle HorizontalAlign="Left" />
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="neto" DataFormatString="{0:N2}" HeaderText="Neto">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <FooterStyle Font-Bold="True" />
                                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="False" />
                                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanelReferencia" runat="server" Visible="False">
                            <ContentTemplate>
                                <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                    <tr>
                                        <td style="width: 1000px; height: 10px;"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1000px; vertical-align: top; text-align: left;">
                                            <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                                <tr>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="nilblDocReferencia" runat="server" Text="Trn. Referencia" Visible="False"></asp:Label></td>
                                                    <td style="width: 900px">
                                                        <asp:DropDownList ID="niddlTrnReferencia" runat="server" AutoPostBack="True" OnSelectedIndexChanged="niddlTrnReferencia_SelectedIndexChanged"
                                                            Visible="False" Width="850px">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; height: 10px"></td>
                                                    <td style="width: 900px; height: 10px"></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="nilblBodega" runat="server" Text="Bodega" Visible="False"></asp:Label></td>
                                                    <td style="width: 900px">
                                                        <asp:DropDownList ID="niddlBodega" runat="server" Visible="False" Width="400px" DataSource="<%# DvBodega() %>"
                                                            DataValueField="codigo" DataTextField="descripcion">
                                                        </asp:DropDownList></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px">
                                                        <asp:Label ID="lbDocumento" runat="server" ForeColor="#404040" Text="Documento" Visible="False"></asp:Label></td>
                                                    <td style="width: 900px">
                                                        <asp:FileUpload ID="fuFoto" runat="server" ToolTip="Haga clic para cargar la foto del funcionario seleccionado"
                                                            Visible="False" Width="360px" /></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 100px; height: 24px;">
                                                        <asp:Label ID="nilblValorTotal" runat="server" Text="Valor Total "></asp:Label></td>
                                                    <td style="width: 900px; height: 24px;">
                                                        <asp:TextBox ID="nitxtTotalValorTotal" runat="server" Width="100px" Enabled="False"></asp:TextBox>&nbsp;
                            <asp:Label ID="nilblValorNeto" runat="server" Text="Valor Neto"></asp:Label>&nbsp;
                            <asp:TextBox ID="nitxtTotalValorNeto" runat="server" Enabled="False" Width="100px"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                            <asp:GridView ID="gvReferencia" runat="server" AutoGenerateColumns="False"
                                                Font-Size="Small" GridLines="None" Width="1000px" CssClass="Grid">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkSeleccion" runat="server" Checked="True" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" BorderColor="White" BorderStyle="None" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="producto" HeaderText="Producto">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="cadena" HeaderText="Descripci&#243;n">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Cantidad">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtCantidad" runat="server" onchange="formato(this)" OnDataBinding="txtCantidad_DataBinding"
                                                                onkeyup="formato(this)" Text='<%# Eval("saldo") %>' Width="70px"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="SaldoProducto" HeaderText="Saldo">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="uMedida" HeaderText="U. Med">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:TemplateField HeaderText="Vlr. Unitario">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtValorUnitario" runat="server" onchange="formato(this)" OnDataBinding="txtValorUnitario_DataBinding"
                                                                onkeyup="formato(this)" Text='<%# Eval("valorUnitario") %>' Width="100px"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="% I.V.A">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtPiva" runat="server" onchange="formato(this)" OnDataBinding="txtPiva_DataBinding"
                                                                onkeyup="formato(this)" Text='<%# Eval("pIva") %>' Width="50px"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="%Dsto.">
                                                        <ItemTemplate>
                                                            <asp:TextBox ID="txtPDes" runat="server" onchange="formato(this)" OnDataBinding="txtPDes_DataBinding"
                                                                onkeyup="formato(this)" Text='<%# Eval("pDescuento") %>' Width="50px"></asp:TextBox>
                                                        </ItemTemplate>
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="valorIva" HeaderText="I.V.A">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valorTotal" DataFormatString="{0:N2}" HeaderText="Total">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valorDescuento" HeaderText="Dsto.">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valorNeto" DataFormatString="{0:N2}" HeaderText="Neto">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Right" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="registro">
                                                        <HeaderStyle BackColor="White" />
                                                        <ItemStyle BackColor="White" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px"
                                                            HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <HeaderStyle BackColor="FloralWhite" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1000px"></td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                        <asp:UpdatePanel ID="UpdatePanelConsulta" runat="server" Visible="False" UpdateMode="Conditional">
                            <ContentTemplate>
                                <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                    <tr>
                                        <td style="background-image: url(../../Imagenes/botones/BotonIzq.png); width: 200px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                                        <td style="width: 150px; height: 25px; text-align: left">
                                            <asp:DropDownList ID="niddlCampo" runat="server" ToolTip="Selección de campo para busqueda"
                                                Width="145px">
                                            </asp:DropDownList></td>
                                        <td style="width: 100px; height: 25px; text-align: left">
                                            <asp:DropDownList ID="niddlOperador" runat="server" ToolTip="Selección de operador para busqueda"
                                                Width="95px" AutoPostBack="True" OnSelectedIndexChanged="niddlOperador_SelectedIndexChanged">
                                                <asp:ListItem Value="like">Contiene</asp:ListItem>
                                                <asp:ListItem Value="&lt;&gt;">Diferente</asp:ListItem>
                                                <asp:ListItem Value="between">Entre</asp:ListItem>
                                                <asp:ListItem Selected="True" Value="=">Igual</asp:ListItem>
                                                <asp:ListItem Value="&gt;=">Mayor o Igual</asp:ListItem>
                                                <asp:ListItem Value="&gt;">Mayor que</asp:ListItem>
                                                <asp:ListItem Value="&lt;=">Menor o Igual</asp:ListItem>
                                                <asp:ListItem Value="&lt;">Menor</asp:ListItem>
                                            </asp:DropDownList></td>
                                        <td style="width: 110px; height: 25px; text-align: left">
                                            <asp:TextBox ID="nitxtValor1" runat="server" Width="95px" AutoPostBack="True" OnTextChanged="nitxtValor1_TextChanged"></asp:TextBox><asp:TextBox
                                                ID="nitxtValor2" runat="server" Visible="False" Width="95px"></asp:TextBox></td>
                                        <td style="width: 70px; height: 25px; text-align: center">
                                            <asp:ImageButton ID="niimbAdicionar"
                                                runat="server" Height="25px" ImageUrl="~/Imagenes/botones/Asignar1.png"
                                                Width="25px" ToolTip="Clic aquí para adicionar parámetro a la busqueda" Enabled="False" OnClick="niimbAdicionar_Click" /></td>
                                        <td style="width: 170px; height: 25px; text-align: left">
                                            <asp:Label ID="nilblRegistros" runat="server" Text="Nro. Registros 0"></asp:Label></td>
                                        <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png); width: 200px; background-repeat: no-repeat; height: 25px"></td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                    <tr>
                                        <td style="width: 400px; height: 10px"></td>
                                        <td style="width: 10px; height: 10px"></td>
                                        <td style="width: 25px; height: 10px"></td>
                                        <td style="width: 10px; height: 10px"></td>
                                        <td style="width: 550px; height: 10px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 400px">
                                            <asp:GridView ID="gvParametros" runat="server" Width="400px" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" GridLines="None" OnRowDeleting="gvParametros_RowDeleting" CssClass="Grid">
                                                <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imbEliminarParametro" runat="server" Height="17px" ImageUrl="~/Imagenes/botones/anular.png"
                                                                ToolTip="Elimina el parámetro de la consulta" Width="17px" CommandName="Delete" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="campo" HeaderText="Campo">
                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="operador" HeaderText="Operador">
                                                        <HeaderStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle HorizontalAlign="Center" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valor" HeaderText="Valor">
                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                        <ItemStyle HorizontalAlign="Left" BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="valor2" HeaderText="Valor 2">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <FooterStyle BackColor="LightYellow" Font-Bold="True" />
                                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="False" />
                                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                            </asp:GridView>
                                        </td>
                                        <td style="vertical-align: top; width: 10px; text-align: left"></td>
                                        <td style="width: 25px; vertical-align: top; text-align: left;">
                                            <asp:ImageButton ID="imbBusqueda"
                                                runat="server" Height="25px" ImageUrl="~/Imagenes/Ver.png"
                                                Width="25px" ToolTip="Clic aquí para realizar la busqueda" Enabled="False" Visible="False" OnClick="imbBusqueda_Click" /></td>
                                        <td style="vertical-align: top; width: 10px; text-align: left"></td>
                                        <td style="vertical-align: top; width: 550px; text-align: left">
                                            <asp:Label ID="nilblMensajeEdicion" runat="server" ForeColor="Navy"></asp:Label></td>
                                    </tr>
                                </table>
                                <table cellpadding="0" cellspacing="0" style="width: 1000px">
                                    <tr>
                                        <td style="width: 1000px; height: 5px"></td>
                                    </tr>
                                    <tr>
                                        <td style="width: 1000px; text-align: left;">
                                            <asp:GridView ID="gvTransaccion" runat="server" Width="950px" AutoGenerateColumns="False" Font-Names="Arial" Font-Size="Small" GridLines="None" OnRowDeleting="gvTransaccion_RowDeleting" OnRowUpdating="gvTransaccion_RowUpdating" CssClass="Grid">
                                                <RowStyle HorizontalAlign="Left" VerticalAlign="Middle" />
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imbEditar" runat="server" Height="17px" ImageUrl="~/Imagenes/botones/Edit.png"
                                                                ToolTip="Clic aquí para editar la transacción seleccionada" Width="17px" CommandName="Update" OnClientClick="if(!confirm('Desea editar la transacción seleccionada ?')){return false;};" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" BorderColor="LightSteelBlue" BorderStyle="Dotted" BorderWidth="2px" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imbEliminarParametro" runat="server" Height="17px" ImageUrl="~/Imagenes/botones/anular.png" CommandName="Delete"
                                                                ToolTip="Elimina la transacción seleccionada" Width="17px" OnClientClick="if(!confirm('Desea eliminar la transacción seleccionada ?')){return false;};" />
                                                        </ItemTemplate>
                                                        <HeaderStyle BackColor="White" HorizontalAlign="Center" />
                                                        <ItemStyle BackColor="White" HorizontalAlign="Center" BorderColor="LightSteelBlue" BorderStyle="Dotted" BorderWidth="2px" />
                                                    </asp:TemplateField>
                                                    <asp:BoundField DataField="periodo" HeaderText="Periodo">
                                                        <HeaderStyle BorderColor="LightSteelBlue" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="LightSteelBlue" BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="tipo" HeaderText="Tipo">
                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="LightSteelBlue" BorderStyle="Solid" BorderWidth="2px" />
                                                        <ItemStyle HorizontalAlign="Left" BorderColor="LightSteelBlue" BorderStyle="Solid" BorderWidth="2px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="numero" HeaderText="Numero">
                                                        <HeaderStyle HorizontalAlign="Left" BorderColor="LightSteelBlue" BorderStyle="Solid" BorderWidth="2px" />
                                                        <ItemStyle HorizontalAlign="Left" BorderColor="LightSteelBlue" BorderStyle="Solid" BorderWidth="2px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="fecha" HeaderText="Fecha" DataFormatString="{0:d}">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="observacion" HeaderText="Observaciones">
                                                        <HeaderStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                        <ItemStyle BorderColor="Silver" BorderStyle="Solid" BorderWidth="1px" HorizontalAlign="Left" />
                                                    </asp:BoundField>
                                                </Columns>
                                                <FooterStyle BackColor="LightYellow" Font-Bold="True" />
                                                <HeaderStyle BackColor="FloralWhite" HorizontalAlign="Left" VerticalAlign="Middle" Font-Bold="False" />
                                                <AlternatingRowStyle BackColor="#E0E0E0" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                </table>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
