<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImpresionOSA.aspx.cs" Inherits="Laboratorio_Panalisis_ImprimeRemision" %><%@ Register assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" namespace="Microsoft.Reporting.WebForms" tagprefix="rsweb" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title></title>
     <link href="../../css/Formularios.css" rel="stylesheet" />
    <link href="../../css/chosen.css" rel="stylesheet" />
    <script src="../../js/jquery.min.js"></script>
    <script type="text/javascript" lang="javascript">

     $(document).ready(function () {

         if ($.browser.mozilla || $.browser.webkit) {

             try {

                 showPrintButton();

             }

             catch (e) { alert(e); }

         }

     });



        function showPrintButton() {

            var table = $("table[title='Refresh']");

            var parentTable = $(table).parents('table');

            var parentDiv = $(parentTable).parents('div').parents('div').first();

            parentDiv.append('<input type="image" style="border-width: 0px; padding: 3px;margin-top:2px; height:16px; width: 16px;" alt="Print" src="/LaborInfos/Reserved.ReportViewerWebControl.axd?OpType=Resource&Version=11.0.3452.0&Name=Microsoft.Reporting.WebForms.Icons.Print.gif" ;title="Print" onclick="PrintReport();">');


        }

        // Print Report function

        function PrintReport() {



            //get the ReportViewer Id
        
            var rv1 = $('#rvTiquete_ctl09');

            var iDoc = rv1.parents('html');



            // Reading the report styles

            var styles = iDoc.find("head style[id$='ReportControl_styles']").html();

            if ((styles == undefined) || (styles == '')) {

                iDoc.find('head script').each(function () {

                    var cnt = $(this).html();

                    var p1 = cnt.indexOf('ReportStyles":"');

                    if (p1 > 0) {

                        p1 += 15;

                        var p2 = cnt.indexOf('"', p1);

                        styles = cnt.substr(p1, p2 - p1);

                    }

                });

            }

            if (styles == '') { alert("Cannot generate styles, Displaying without styles.."); }

            styles = '<style type="text/css">' + styles + "</style>";



            // Reading the report html

            var table = rv1.find("div[id$='_oReportDiv']");

            if (table == undefined) {

                alert("Report source not found.");

                return;

            }



            // Generating a copy of the report in a new window

            var docType = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/loose.dtd">';

            var docCnt = styles + table.parent().html();

            var docHead = '<head><style>body{margin:5;padding:0;}</style></head>';

            var winAttr = "location=yes, statusbar=no, directories=no, menubar=no, titlebar=no, toolbar=no, dependent=no, width=720, height=600, resizable=yes, screenX=200, screenY=200, personalbar=no, scrollbars=yes";;

            var newWin = window.open("", "_blank", winAttr);

            writeDoc = newWin.document;

            writeDoc.open();

            writeDoc.write(docType + '<html>' + docHead + '<body onload="window.print();">' + docCnt + '</body></html>');

            writeDoc.close();

            newWin.focus();

            // uncomment to autoclose the preview window when printing is confirmed or canceled.

            // newWin.close();

        };

    </script>
</head>
<body style="text-align: left">
    <form id="form1" runat="server">
        <div style="text-align: left" class="principal">

            <table cellspacing="0" style="width: 1000px">
                <tr>
                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;"></td>
                    <td style="border-bottom: 1px solid silver; text-align: center;"><strong>Impresión de Salida</strong></td>
                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;"></td>
                </tr>
            </table>

            <table style="width: 1000px; height: 700px;" cellspacing="0">
                <tr>
                    <td style="vertical-align: top; width: 1000px; text-align: left; height: 700px;">
                        <table id="Impresion" cellpadding="0" cellspacing="0" style="width: 1000px">
                            <tr>
                                <td style="height: 10px; text-align: center;" colspan="3">
                                    <asp:Label ID="lblMensaje" runat="server"></asp:Label></td>
                            </tr>
                            <tr>
                                <td style="width: 250px"></td>
                                <td style="width: 500px;">
                                    <div style="text-align:center">
                                    </div>
                                </td>
                                <td style="width: 250px">
                                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                                    </asp:ScriptManager>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 250px; height: 10px"></td>
                                <td style="width: 500px; height: 10px; text-align: center;">
                                    <asp:TextBox ID="txtRemision" runat="server" BorderStyle="None" Enabled="False" Font-Bold="True"></asp:TextBox></td>
                                <td style="width: 250px; height: 10px"></td>
                            </tr>
                            <tr>
                                <td style="width: 250px"></td>
                                <td style="width: 500px">
                                    <table cellpadding="0" cellspacing="0" style="width: 500px">
                                        <tr>
                                            <td style="width: 100px; text-align: left">
                                                <asp:Label ID="Label1" runat="server" Text="Vehículo"></asp:Label></td>
                                            <td style="width: 350px; text-align: left">
                                                <asp:DropDownList ID="ddlRemision" runat="server" Width="325px" AutoPostBack="True" data-placeholder="Seleccione una opción..." CssClass="chzn-select" OnSelectedIndexChanged="ddlRemision_SelectedIndexChanged">
                                                </asp:DropDownList></td>
                                        </tr>
                                        <tr>
                                            <td style="width: 100px; text-align: left">
                                                <asp:Label ID="Label2" runat="server" Text="Motivo"></asp:Label></td>
                                            <td style="width: 350px; text-align: left">
                                                <asp:TextBox ID="txtMotivo" runat="server" TextMode="MultiLine" Width="320px"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center" colspan="2">
                                                <asp:ImageButton ID="imbImprimirOS" runat="server" ImageUrl="~/Imagen/Bonotes/btnOrdenSalida.png" ToolTip="Clic para imprimir el documento" OnClick="imbImprimirOS_Click"
                                                    onmouseout="this.src='../../Imagen/Bonotes/btnOrdenSalida.png'"
                                                    onmouseover="this.src='../../Imagen/Bonotes/btnOrdenSalidaN.png'" />
                                                <asp:ImageButton ID="btnAtras" runat="server" ImageUrl="~/Imagen/Bonotes/btnAtras.png"
                                                    Visible="False" ToolTip="Clic para imprimir el documento" OnClick="tbnAtras_Click"
                                                    onmouseout="this.src='../../Imagen/Bonotes/btnAtras.png'"
                                                    onmouseover="this.src='../../Imagen/Bonotes/btnAtrasN.png'" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: center" colspan="2">&nbsp;</td>
                                        </tr>
                                    </table>
                                </td>
                                <td style="width: 250px">
                                    
                                </td>
                            </tr>
                        </table>
                        <rsweb:ReportViewer ID="rvTiquete" runat="server" ProcessingMode="Remote" Width="100%" Visible="False" ShowBackButton="False" ShowExportControls="False" ShowFindControls="False" ShowPageNavigationControls="False" ShowParameterPrompts="False" ShowZoomControl="False">
                        </rsweb:ReportViewer>
               
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

