<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImprimeInformeCR.aspx.cs" Inherits="Bascula_Pinformes_ImprimeInforme" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=12.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" Namespace="CrystalDecisions.Web" TagPrefix="CR" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
   
    <link rel="stylesheet" href="../../css/common.css" type="text/css" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <script src="../../js/Numero.js" type="text/javascript"></script>
    <link href="../../css/jquery-ui.css" rel="stylesheet" />
    <link type="text/css" href="../../css/ui.multiselect.css" rel="stylesheet" />
    <script type="text/javascript" src="../../js/jqueryv1.5.1.min.js"></script>
    <script type="text/javascript" src="../../js/jquery-ui1.8.10.min.js"></script>
    <script type="text/javascript" src="../../js/plugins/localisation/jquery.localisation-min.js"></script>
    <script type="text/javascript" src="../../js/plugins/scrollTo/jquery.scrollTo-min.js"></script>
    <script type="text/javascript" src="../../js/ui.multiselect.js"></script>


    <script type="text/javascript">

        function Visualizacion(empresa, año, periodo) {

            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + 0 + ", height =" + 0 + ", top = 0, left = 5";
            sTransaccion = "GenerarPlano.aspx?empresa=" + empresa + "&periodo=" + periodo + "&año=" + año;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }

        function VisualizacionInforme(informe, año, periodo, numero) {
            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + screen.availWidth + ", height =" + screen.availHeight + ", top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe + "&año=" + año + "&periodo=" + periodo + "&numero=" + numero;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }

        $(function () {
            $.localise('ui-multiselect', { language: 'es', path: '../../js/locale/' });
            $(".multiselect").multiselect();
            // $('#switcher').themeswitcher();
        });
    </script>



    <%-- Este es el estilo de combobox --%>

    <link href="../../css/chosen.css" rel="stylesheet" />


    <%-- Aqui termina el estilo es el estilo de combobox --%>

    <script charset="utf-8" type="text/javascript">
        var contador = 0;
    </script>


    <script src='<%=ResolveUrl("~/crystalreportviewers13/js/crviewer/crv.js")%>' type="text/javascript"></script>
    <link rel="stylesheet" href='<%=ResolveUrl("~/crystalreportviewers13/js/crviewer/images/style.css")%>' type="text/css" />
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
    <style type="text/css">
        .bordes {
            width: 250px;
        }

        .nombreCampos {
            text-align: left;
        }

        a {
            color: #636363;
        }

        .Campos {
            width: 360px;
            text-align: left;
        }

        .input {
            border: 1px solid silver;
            padding: 0px 3px;
            font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif;
            font-size: 12px;
            color: #003366;
            height: 20px;
            border-radius: 2px 2px 2px 2px;
            box-shadow: 0 2px 2px rgba(0, 0, 0, 0.080) inset;
            margin-top: 0px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <div style="width: 100%">

                <table cellspacing="0" style="width: 100%">
                    <tr>
                        <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                        <td style="text-align: center;">
                            <strong style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 12px; color: #003366; text-align: center;">Visualización Informes</strong></td>
                        <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td style="background-repeat: no-repeat; height: 25px; text-align: left" colspan="3">
                            <table cellspacing="0" style="width: 100%; border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;" id="Table2">
                                <tr>
                                    <td colspan="4" style="border-top: 1px solid silver; text-align: center; border-left-color: silver; border-right-color: silver; border-bottom-color: silver;">
                                        <asp:Label ID="nilblInformacion" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="bordes"></td>
                                    <td class="nombreCampos">
                                        <asp:Label ID="lblaño" runat="server" Text="Año"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:DropDownList ID="ddlAño" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="130px" AutoPostBack="True" OnSelectedIndexChanged="ddlAño_SelectedIndexChanged1">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="bordes"></td>
                                </tr>
                                <tr>
                                    <td class="bordes"></td>
                                    <td class="nombreCampos">
                                        <asp:Label ID="lblPeriodo" runat="server" Text="Periodo nómina"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:DropDownList ID="ddlPeriodo" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="350px" AutoPostBack="True" OnSelectedIndexChanged="ddlPeriodo_SelectedIndexChanged">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="bordes"></td>
                                </tr>
                                <tr>
                                    <td class="bordes"></td>
                                    <td class="nombreCampos">
                                        <asp:Label ID="lblOpcionLiquidacion" runat="server" Text="Documento nómina"></asp:Label>
                                    </td>
                                    <td class="Campos">
                                        <asp:DropDownList ID="ddlDocumento" runat="server" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="300px">
                                        </asp:DropDownList>
                                    </td>
                                    <td class="bordes"></td>
                                </tr>
                                <tr>
                                    <td class="bordes"></td>
                                    <td class="nombreCampos"></td>
                                    <td class="Campos">
                                        <asp:ImageButton ID="niimbImprimir" runat="server" ImageUrl="~/Imagen/Bonotes/btnImprimir.png" OnClick="niimbImprimir_Click" onmouseout="this.src='../../Imagen/Bonotes/btnImprimir.png'" onmouseover="this.src='../../Imagen/Bonotes/btnImprimirN.png'" ToolTip="Haga clic aqui para realizar la busqueda" Visible="False" />
                                    </td>
                                    <td class="bordes"></td>
                                </tr>
                                <tr>
                                    <td style="text-align: center; height: 10px;" colspan="4">
                                        <asp:Label ID="nilblMensaje" runat="server"></asp:Label>
                                    </td>
                                </tr>
                            </table>



                        </td>
                    </tr>
                </table>

                <table style="width: 100%; height: 700px;" cellspacing="0">
                    <tr>
                        <td style="vertical-align: top; width: 100%; text-align: left; height: 700px;">

                            <CR:CrystalReportViewer ID="crViewer" runat="server" AutoDataBind="true" DisplayStatusbar="False" EnableDatabaseLogonPrompt="False" EnableDrillDown="False" EnableParameterPrompt="False" EnableTheming="False" ToolPanelView="None" Width="350px" />

                        </td>
                    </tr>
                </table>
                <script src="../../js/chosen.jquery.js" type="text/javascript"></script>
                <script type="text/javascript"> $(".chzn-select").chosen(); $(".chzn-select-deselect").chosen({ allow_single_deselect: true }); </script>
            </div>
        </div>
    </form>
</body>
</html>
