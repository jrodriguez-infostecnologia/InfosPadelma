<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ImprimeTrans.aspx.cs" Inherits="Bascula_Pinformes_ImprimeTrans" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=11.0.0.0, Culture=neutral, PublicKeyToken=89845dcd8080cc91" Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>

    <%@ Register assembly="printButtonDLL" namespace="printButtonDLL" tagprefix="cc1" %>
     
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
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

        parentDiv.append('<input type="image" style="border-width: 0px; padding: 3px;margin-top:2px; height:16px; width: 16px;" alt="Print" src="/AdmonInfos/Reserved.ReportViewerWebControl.axd?OpType=Resource&amp;Version=11.0.3452.0&amp;Name=Microsoft.Reporting.WebForms.Icons.Print.gif" ;title="Print" onclick="PrintReport();">');



    }

    // Print Report function

    function PrintReport() {



        //get the ReportViewer Id
        
        var rv1 = $('#rvTransaccion_ctl09 ');

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
<body>
    <form id="form1" runat="server">
        <div style="width: 100%" class="principal">

            <table cellspacing="0" style="width: 100%">
                <tr>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                    <td style="text-align: center;">Impresion de transacciones</td>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">
                        <asp:ScriptManager ID="ScriptManager1" runat="server">
                        </asp:ScriptManager>
                    </td>
                </tr>
                <tr>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">&nbsp;</td>
                    <td style="text-align: center;">
                        <table cellpadding="0" cellspacing="0" style="WIDTH: 1000px">
                            <tr>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                                <td style="WIDTH: 200px; text-align: left;">
                                    <asp:Label ID="Label1" runat="server" Text="Tipo de Transacción"></asp:Label>
                                </td>
                                <td style="WIDTH: 500px; text-align: left;">
                                    <asp:DropDownList ID="ddlTipoDocumento" runat="server" AutoPostBack="True" CssClass="chzn-select" data-placeholder="Seleccione una opción..." Width="350px">
                                    </asp:DropDownList>
                                </td>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                                <td style="WIDTH: 200px; text-align: left;">
                                    <asp:Label ID="Label2" runat="server" Text="Número de Transacción"></asp:Label>
                                </td>
                                <td style="WIDTH: 500px; text-align: left;">
                                    <asp:TextBox ID="txtNumero" runat="server" CssClass="input" Width="200px"></asp:TextBox>
                                    &nbsp;
                        <asp:ImageButton ID="imbBuscar" runat="server" ImageUrl="~/Imagen/Bonotes/btnBuscar.jpg" OnClick="imbBuscar_Click" onmouseout="this.src='../../Imagen/Bonotes/btnBuscar.jpg'" onmouseover="this.src='../../Imagen/Bonotes/btnBuscarN.jpg'" ToolTip="Haga clic aqui para realizar la busqueda" />
                                </td>
                                <td style="WIDTH: 200px; text-align: left;">&nbsp;</td>
                            </tr>
                            <tr>
                                <td colspan="4">
                        <asp:Label ID="lblMensaje" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </td>
                    <td style="width: 250px; background-repeat: no-repeat; height: 25px; text-align: left">&nbsp;</td>
                </tr>
            </table>

            <table style="width: 100%; height: 700px;" cellspacing="0">
                <tr>
                    <td style="vertical-align: top; width: 100%; text-align: left; height: 700px;">

                        <rsweb:ReportViewer ID="rvTransaccion" runat="server" ProcessingMode="Remote" Width="100%" Visible="False">
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
