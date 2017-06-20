<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RegitrarDatosPesajePP.aspx.cs" Inherits="Bascula_Poperaciones_RegitrarDatosPesajePP" %>
<%@ OutputCache Location="None" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
     <script src="../../js/Numero.js" type="text/javascript"></script>
      <script type="text/javascript">
          javascript: window.history.forward(1);
    </script>

    
</head>
<body style="text-align: center">
    <object id="RSClientPrint" classid="CLSID:5554DCB0-700B-498D-9B58-4E40E5814405" codebase="http://192.168.3.47/ReportServer?rs:Command=Get&amp;rc:GetImage=10.50.1600.1rsclientprint.cab#Version=2009,100,1600,1" viewastext></object>

    <script type="text/javascript" language="javascript">

        function Print(tiquete) {
            if (typeof RSClientPrint.Print == "undefined") {
                alert("Problema en el controlador de impresión");

                return;
            }

            alert("Tiquete Nro. " + tiquete);

            RSClientPrint.MarginLeft = 1;
            RSClientPrint.MarginTop = 0;
            RSClientPrint.MarginRight = 0;
            RSClientPrint.MarginBottom = 1;
            RSClientPrint.Culture = 2058;
            RSClientPrint.UICulture = 2058;

            var ruta = '/AceitesSa/Formatos/Bascula/TiqueteB&tiquete=' + tiquete;

            RSClientPrint.Print('http://192.168.3.47/ReportService', ruta, 'TiquetePes')
        }

    </script>
    <form id="form1" runat="server">
        <div class="principal">
            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="background-position-x: left; background-image: url(../../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                    <td style="width: 500px; height: 25px; background-image: none;">
                        <asp:Label ID="lblTipoTra" runat="server"></asp:Label>&nbsp;
                    <asp:Label ID="lblTransaccion" runat="server" Font-Bold="True" Font-Size="Medium"></asp:Label></td>
                    <td style="background-position-x: right; background-image: url(../../Imagenes/botones/BotonDer.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: right"></td>
                </tr>
            </table>
            <table cellspacing="0" style="width: 1000px; border-top: silver thin solid; border-bottom: silver thin solid;" id="TABLE1" >
                <tr>
                    <td colspan="4">
                        <asp:ImageButton ID="lbCancelar" runat="server" ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg" OnClick="lbCancelar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnCancelar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnCancelarNegro.jpg'" ToolTip="Continúa con la operación" />
                        <asp:ImageButton ID="lbRegistrar" runat="server" ImageUrl="~/Imagen/Bonotes/btnGuardar.jpg" OnClick="lbRegistrar_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnGuardar.jpg'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnGuardarN.jpg'" ToolTip="Continúa con la operación" />
                        <asp:ImageButton ID="lbNuevoPeso" runat="server" ImageUrl="~/Imagen/Bonotes/btnNuevoPeso.png" OnClick="lbNuevoPeso_Click"
                            onmouseout="this.src='../../Imagen/Bonotes/btnNuevoPeso.png'"
                            onmouseover="this.src='../../Imagen/Bonotes/btnNuevoPesoN.png'" ToolTip="Continúa con la operación" Visible="False" />
                    </td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label9" runat="server" Text="Fecha"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtFecha" runat="server" Enabled="False" Width="200px" CssClass="input"></asp:TextBox></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px">&nbsp;</td>
                    <td style="width: 150px; text-align: left">
                        &nbsp;</td>
                    <td style="width: 350px; text-align: left">
                        <asp:CheckBox ID="chkPropio" runat="server" AutoPostBack="True" OnCheckedChanged="chkPropio_CheckedChanged" Text="Propio " />
                    </td>
                    <td style="width: 250px">&nbsp;</td>
                </tr>
                <tr>
                    <td style="width: 250px;"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label1" runat="server" Text="Placa Vehículo"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtVehiculo" runat="server" Width="200px" CssClass="input"></asp:TextBox>
                        <br />
                        <asp:DropDownList ID="ddlVehiculo" runat="server" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False">
                        </asp:DropDownList></td>
                    <td style="width: 250px;"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left; vertical-align: top;">
                        <asp:Label ID="Label2" runat="server" Text="Remolque / Caja"></asp:Label></td>
                    <td style="width: 350px; text-align: left; vertical-align: top;">
                        <asp:TextBox ID="txtRemolque" runat="server" Width="200px" CssClass="input"></asp:TextBox>
                        <asp:DropDownList ID="ddlRemolque" runat="server" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select" Visible="False">
                        </asp:DropDownList></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label3" runat="server" Text="Id. Conductor"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtIdConductor" runat="server" Width="200px" CssClass="input" OnTextChanged="txtIdConductor_TextChanged"></asp:TextBox></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label4" runat="server" Text="Nombre Conductor"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtNombreConductor" runat="server" Width="300px" CssClass="input"></asp:TextBox></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label6" runat="server" Text="Producto"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:DropDownList ID="ddlProducto" runat="server" Width="250px" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label11" runat="server" Text="Tercero"></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:DropDownList ID="ddlTercero" runat="server" Width="300px" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select">
                        </asp:DropDownList></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label7" runat="server" Text="Peso Tara Kg."></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtPeso" runat="server" Enabled="False" Font-Bold="True" Font-Size="16pt"
                            ForeColor="#004000" Height="30px" Width="200px" CssClass="input"></asp:TextBox></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label5" runat="server" Text="Peso Bruto Kg."></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtPesoBruto" runat="server" Enabled="False" Font-Bold="True" Font-Size="16pt"
                            ForeColor="#004000" Height="30px" Width="200px" CssClass="input"></asp:TextBox></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td style="width: 250px"></td>
                    <td style="width: 150px; text-align: left">
                        <asp:Label ID="Label10" runat="server" Text="Peso Neto Kg."></asp:Label></td>
                    <td style="width: 350px; text-align: left">
                        <asp:TextBox ID="txtPesoNeto" runat="server" Enabled="False" Font-Bold="True" Font-Size="16pt"
                            ForeColor="#004000" Height="30px" Width="200px" CssClass="input"></asp:TextBox></td>
                    <td style="width: 250px"></td>
                </tr>
                <tr>
                    <td colspan="4">
                        <asp:Label ID="lblObservaciones" runat="server"></asp:Label>
                    </td>
                </tr>
            </table>

        </div>
        <script src="../../js/jquery.min.js" type="text/javascript"></script>
        <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
        <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
    </form>
</body>
</html>

