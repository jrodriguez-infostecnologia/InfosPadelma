<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Informes.aspx.cs" Inherits="Bascula_Pinformes_Visualizacion" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link href="../../css/Formularios.css" rel="stylesheet" />
    <title></title>

    <script language="javascript" type="text/javascript">

        var x = null;

        function Visualizacion(informe) {

            var opciones = "toolbar = no, location = no, directories = no, status = no, menubar = no, scrollbars = yes, resizable = yes, width =" + screen.availWidth + ", height =" + screen.availHeight + ", top = 0, left = 5";
            sTransaccion = "ImprimeInforme.aspx?informe=" + informe;
            x = window.open(sTransaccion, "", opciones);
            x.focus();
        }

    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div class="principal">
            <table style="width: 1000px" cellspacing="0">
                <tr>
                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;"></td>
                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;"><strong>Visualización</strong></td>
                    <td style="border-bottom-style: solid; border-bottom-width: 1px; border-bottom-color: silver;"></td>
                </tr>
            </table>
            <table style="width: 1000px" cellspacing="0">
                <tr>
                    <td style="background-image: none; vertical-align: top; width: 300px; height: 70px; background-color: transparent; text-align: left">
                        <asp:TreeView ID="tvInformes" runat="server" ForeColor="#0066CC" ImageSet="XPFileExplorer" NodeWrap="True" PopulateNodesFromClient="False" OnSelectedNodeChanged="tvInformes_SelectedNodeChanged" NodeIndent="15" style="font-size: small" Width="328px">
                            <ParentNodeStyle Font-Bold="False" />
                            <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                            <SelectedNodeStyle Font-Underline="False" HorizontalPadding="0px" VerticalPadding="0px" BackColor="#B5B5B5" />
                            <Nodes>
                                <asp:TreeNode Expanded="True" SelectAction="Expand" Text="Informes Agronómico" Value="Contable">
                                    <asp:TreeNode Text="Finca  - Lotes" Value="admon01"></asp:TreeNode>
                                    <asp:TreeNode Text="Lista de precio novedades" Value="admon04"></asp:TreeNode>
                                    <asp:TreeNode Text="Labores" Value="labo01"></asp:TreeNode>
                                    <asp:TreeNode Text="Labores por trabajador en fechas" Value="tran03"></asp:TreeNode>
                                    <asp:TreeNode Text="Labores por lote en fecha" Value="tran06"></asp:TreeNode>
                                    <asp:TreeNode Text="Labores por centro de costo en fecha" Value="tran04"></asp:TreeNode>
                                    <asp:TreeNode Text="Producción lote fecha" Value="tran07"></asp:TreeNode>
                                    <asp:TreeNode Text="Liquidación contratistas por periodo" Value="tran09"></asp:TreeNode>
                                    <asp:TreeNode Text="Liquidación contratistas por periodo y lotes" Value="tran10"></asp:TreeNode>
                                    <asp:TreeNode Text="Resumen contratistas por periodo" Value="tran11"></asp:TreeNode>
                                    <asp:TreeNode Text="Resumen de labores por año (fecha labor)" Value="Resu01"></asp:TreeNode>
                                    <asp:TreeNode Text="Resumen de labores por año (fecha tra.)" Value="Resu02"></asp:TreeNode>
                                </asp:TreeNode>
                                <asp:TreeNode Text="Informes de Nómina" Value="Liquidación Nomina">
                                    <asp:TreeNode Text="Resumen Liquidación Definitiva" Value="liqui07"></asp:TreeNode>
                                    <asp:TreeNode Text="Pago de Liquidación Periodo" Value="liqui08"></asp:TreeNode>
                                    <asp:TreeNode Text="Desprendibles Nomina" Value="liqui09"></asp:TreeNode>
                                    <asp:TreeNode Text="Resumen Concepto x año" Value="resu01"></asp:TreeNode>
                                    <asp:TreeNode Text="Descuentos nomina por periodo" Value="des01"></asp:TreeNode>
                                    <asp:TreeNode Text="IBC Seguridad Social" Value="liqui30"></asp:TreeNode>
                                </asp:TreeNode>
                                <asp:TreeNode Text="Informes de Contabilidad" Value="Nomina">
                                    <asp:TreeNode Text="Precontabilización" Value="conta01"></asp:TreeNode>
                                    <asp:TreeNode Text="Parametros de Contabilización" Value="para01"></asp:TreeNode>
                                    <asp:TreeNode Text="Conceptos Faltantes x parametros" Value="Cont02"></asp:TreeNode>
                                    <asp:TreeNode Text="Informe por conceptos" Value="Cont03"></asp:TreeNode>
                                    <asp:TreeNode Text="Precontabilización por tercero" Value="Cont04"></asp:TreeNode>
                                </asp:TreeNode>

                            </Nodes>
                            <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" HorizontalPadding="2px"
                                NodeSpacing="0px" VerticalPadding="2px" />
                        </asp:TreeView>
                    </td>
                    <td style="background-image: none; width: 700px; background-color: transparent; text-align: left; vertical-align: top; height: 70px;"></td>
                </tr>
            </table>
            &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
        </div>
    </form>
</body>
</html>
