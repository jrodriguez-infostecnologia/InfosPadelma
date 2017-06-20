﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Visualizacion.aspx.cs" Inherits="Bascula_Pinformes_Visualizacion" %>

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
                        <asp:TreeView ID="tvInformes" runat="server" ForeColor="#404040" ImageSet="WindowsHelp" NodeWrap="True" PopulateNodesFromClient="False" OnSelectedNodeChanged="tvInformes_SelectedNodeChanged">
                            <ParentNodeStyle Font-Bold="False" />
                            <HoverNodeStyle Font-Underline="True" ForeColor="#6666AA" />
                            <SelectedNodeStyle Font-Underline="False" HorizontalPadding="0px" VerticalPadding="0px" BackColor="#B5B5B5" />
                            <Nodes>
                                <asp:TreeNode Expanded="True" SelectAction="Expand" Text="Bascula" Value="Contable">
                                    <asp:TreeNode Text="Estado remisiones" Value="Bascula01"></asp:TreeNode>
                                    <asp:TreeNode Text="Bascula detallado" Value="Bascula02"></asp:TreeNode>
                                    <asp:TreeNode Text="Bascula por fecha" Value="Bascula03"></asp:TreeNode>
                                    <asp:TreeNode Text="Bascula por vehículo" Value="Bascula05"></asp:TreeNode>
                                    <asp:TreeNode Text="Bascula por procedencia" Value="Bascula06"></asp:TreeNode>
                                    <asp:TreeNode Text="Acumulados de Fruta" Value="Bascula04"></asp:TreeNode>
                                    <asp:TreeNode Text="Basecula por Producto" Value="Bascula07"></asp:TreeNode>
                                    <asp:TreeNode Text="Bascula del día" Value="Bascula08"></asp:TreeNode>
                                </asp:TreeNode>
                                <asp:TreeNode Text="Portería" Value="Portería">
                                    <asp:TreeNode Text="Registros por fecha" Value="Porteria01"></asp:TreeNode>
                                </asp:TreeNode>
                                <asp:TreeNode Text="Producción" Value="Producción">
                                    <asp:TreeNode Text="Acumulados" Value="pro01"></asp:TreeNode>
                                    <asp:TreeNode Text="Producción mensual" Value="pro02"></asp:TreeNode>
                                    <asp:TreeNode Text="Producción anual" Value="pro03"></asp:TreeNode>
                                    <asp:TreeNode Text="Producción corte" Value="pro04"></asp:TreeNode>
                                    <asp:TreeNode Text="Fruta diferencial" Value="pro05"></asp:TreeNode>
                                    <asp:TreeNode Text="Fruta por rango" Value="pro06"></asp:TreeNode>
                                    <asp:TreeNode Text="Fruta resumen" Value="pro07"></asp:TreeNode>
                                    <asp:TreeNode Text="Fruta periodo" Value="pro08"></asp:TreeNode>
                                    <asp:TreeNode Text="Fruta Anual" Value="pro09"></asp:TreeNode>
                                    <asp:TreeNode Text="Inventarios de Productos Certificados" Value="cer01"></asp:TreeNode>
                                </asp:TreeNode>
                                 <asp:TreeNode Text="Calidad" Value="Calidad">
                                    <asp:TreeNode Text="Análisis fecha" ToolTip="Análisis fecha" Value="calidad01"></asp:TreeNode>
                                    <asp:TreeNode Text="Análisis detallado" Value="calidad02"></asp:TreeNode>
                                    <asp:TreeNode Text="Análisis  ponderado" Value="calidad03"></asp:TreeNode>
                                </asp:TreeNode>
                            </Nodes>

                            <NodeStyle Font-Names="Tahoma" Font-Size="8pt" ForeColor="Black" HorizontalPadding="5px"
                                NodeSpacing="0px" VerticalPadding="1px" />

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
