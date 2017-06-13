<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Visualizacion.aspx.cs" Inherits="Bascula_Pinformes_Visualizacion"  MaintainScrollPositionOnPostback="true" %>

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
                                <asp:TreeNode Text="Adminitración" Value="Nomina">
                                    <asp:TreeNode Text="Conceptos" Value="Nomi01"></asp:TreeNode>
                                    <asp:TreeNode Text="Contratos" Value="Nomi03"></asp:TreeNode>
                                    <asp:TreeNode Text="Funcionarios" Value="Nomi02"></asp:TreeNode>
                                    <asp:TreeNode Text="Funcionario por centro costo" Value="Nomi04"></asp:TreeNode>
                                    <asp:TreeNode Text="Vencimiento de contratos" Value="Nomi05"></asp:TreeNode>
                                    <asp:TreeNode Text="Contratos - Destajo" Value="Cont01"></asp:TreeNode>
                                </asp:TreeNode>

                                <asp:TreeNode Text="Control de Acceso" Value="Seguridad Social">
                                    <asp:TreeNode Text="Liquidación de Horas Extras" Value="liqui13"></asp:TreeNode>
                                    <asp:TreeNode Text="Liquidación de Horas Extras Totales" Value="liqui14"></asp:TreeNode>
                                </asp:TreeNode>

                                <asp:TreeNode Text="Novedades" Value="Novedades">
                                    <asp:TreeNode Text="Registro Novedades" Value="liqui02"></asp:TreeNode>
                                    <asp:TreeNode Text="Novedades Periodicas Activas" Value="liqui03"></asp:TreeNode>
                                    <asp:TreeNode Text="Novedades Tercero Fecha" Value="liqui04"></asp:TreeNode>
                                    <asp:TreeNode Text="Relación Novedades Periodo" Value="liqui16"></asp:TreeNode>
                                    <asp:TreeNode Text="Relación Descuentos Periodo" Value="liqui17"></asp:TreeNode>
                                    <asp:TreeNode Text="Prestamos" Value="nove01"></asp:TreeNode>
                                    <asp:TreeNode Text="Ausentismo" Value="liqui28"></asp:TreeNode>
                                </asp:TreeNode>

                                <asp:TreeNode Text="Liquidación Nomina" Value="Liquidación Nomina">

                                    <asp:TreeNode Text="Preliquidación" Value="liqui01"></asp:TreeNode>
                                    <asp:TreeNode Text="Resumen Preliquidación" Value="liqui05"></asp:TreeNode>
                                    <asp:TreeNode Text="Liquidación Definitiva Periodo" Value="liqui06"></asp:TreeNode>
                                    <asp:TreeNode Text="Liquidación por Trabajador" Value="liqui20"></asp:TreeNode>
                                    <asp:TreeNode Text="Resumen Liquidación por Periodo" Value="liqui07"></asp:TreeNode>
                                    <asp:TreeNode Text="Resumen Liquidación Mensual" Value="liqui21"></asp:TreeNode>
                                    <asp:TreeNode Text="Pago de Liquidación Periodo" Value="liqui08"></asp:TreeNode>
                                    <asp:TreeNode Text="Desprendibles Nomina" Value="liqui09"></asp:TreeNode>
                                    <asp:TreeNode Text="Descuentos Nomina Periodo" Value="liqui10"></asp:TreeNode>
                                    <asp:TreeNode Text="Acumulado Empleado Año" Value="liqui50"></asp:TreeNode>
                                    <asp:TreeNode Text="Acumulados Periodo" Value="liqui12"></asp:TreeNode>
                                    <asp:TreeNode Text="Labores no Liquidadas en nomina" Value="liqui15"></asp:TreeNode>
                                    <asp:TreeNode Text="Liquidación Nomina Detalle" Value="liqui24"></asp:TreeNode>
                                    <asp:TreeNode Text="Descuentos por periodo de nomina" Value="liqui29"></asp:TreeNode>
                                    <asp:TreeNode Text="Ingresos y retenciones detallado " Value="ingre01"></asp:TreeNode>
                                    <asp:TreeNode Text="Formato Ingreso y Retenciones" Value="liqui46"></asp:TreeNode>
                                   <asp:TreeNode Text="Detalle Novedades" Value="liqui45"></asp:TreeNode>
                                </asp:TreeNode>
                                <asp:TreeNode Text="Seguridad Social" Value="Seguridad Social">
                                    <asp:TreeNode Text="Relación Devengado Trabajador" Value="liqui18"></asp:TreeNode>
                                    <asp:TreeNode Text="Seguridad Social Periodo" Value="liqui11"></asp:TreeNode>
                                    <asp:TreeNode Text="Seguridad Social x Entidad" Value="liqui22"></asp:TreeNode>
                                    <asp:TreeNode Text="IBC Seguridad Social" Value="liqui30"></asp:TreeNode>
                                    <asp:TreeNode Text="IBC nomi vs SS" Value="liqui31"></asp:TreeNode>
                                </asp:TreeNode>

                                <asp:TreeNode Text="Prestaciones Sociales" Value="Prestaciones Sociales">
                                    <asp:TreeNode Text="Vacaciones Periodo" ToolTip="Vacaciones Periodo" Value="liqui23"></asp:TreeNode>
                                    <asp:TreeNode Text="Consolidado Vacaciones" Value="liqui25"></asp:TreeNode>
                                    <asp:TreeNode Text="Acumulados Prestaciones" Value="presta01"></asp:TreeNode>
                                    <asp:TreeNode Text="Pre-liquidación Primas semestrales" Value="presta02"></asp:TreeNode>
                                    <asp:TreeNode Text="Liquidación de Contrato - Tercero" Value="presta05"></asp:TreeNode>
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
