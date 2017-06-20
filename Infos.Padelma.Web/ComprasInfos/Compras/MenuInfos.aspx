<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuInfos.aspx.cs" Inherits="Infos_MenuInfos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Menu InfoS</title>

    <script src="../js/jquery-1.3.min.js"></script>
    <link href="../css/demo.css" rel="stylesheet" type="text/css" />
    <link href="../css/LetraLustria.css" rel="stylesheet" />
    <link href="../css/MenuPrincipal.css" rel="stylesheet" />
    <link href="../css/menucss.css" rel="stylesheet" />
    <link href="../css/iconTabs.css" rel="stylesheet" />
    <link href="../css/TabsInfoscss.css" rel="stylesheet" />
    <script src="../js/jquery-1.4.4.min.js"></script>
    <script src="../js/jquery.easyui.min.js"></script>

    <script>
        var contador = 0;

        function contadorMenos() {
            contador--;

        }

        function addTab(title, url) {

            if (contador < 8) {
                if ($('#tt').tabs('exists', title)) {
                    $('#tt').tabs('select', title);


                } else {
                    contador++;
                    var content = '<iframe  frameborder="0"  src="' + url + '" style="width:1024px;height:540px;"></iframe>';
                    $('#tt').tabs('add', {
                        title: title,
                        content: content,
                        closable: true
                    });
                }
            }
            else {

            }
        }



    </script>
    <script type="text/javascript">
        function mainmenu() {
            $(" #nav ul ").css({ display: "none" });
            $(" #nav li").hover(function () {
                $(this).find('ul:first:hidden').css({ visibility: "visible", display: "none" }).slideDown(400);
            }, function () {
                $(this).find('ul:first').slideUp(400);
            });
        }
        $(document).ready(function () {
            mainmenu();
        });
    </script>
</head>
<body style="margin: 0; padding: 0; min-width: 1180px; width: 100%;">
    <form id="form1" runat="server">
        <div style="font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; font-size: 11px; color: #003366">
            <div style="height: 30px; width: 100%; text-align: center; background-image: url('../Imagen/Fondos/barraTitulo.jpg'); background-repeat: repeat-x; font-family: 'Trebuchet MS', 'Lucida Sans Unicode', 'Lucida Grande', 'Lucida Sans', Arial, sans-serif; color: #FFFFFF; font-size: 13px;">
                <div style="width: 800px; display: inline-block; height: 30px; text-align: left;">
                    <div style="padding-top: 8px; width: 90%; float: left;">
                        <span>Sistema de Información INFOS - © 2014 Infos Tecnología S.A.S. Todos los derechos reservados - Santa Marta, Colombia</span>

                    </div>

                    <div style="width: 50px; float: right; padding: 4px;">
                        <asp:ImageButton ID="imbPrincipal" runat="server" ImageUrl="~/Imagen/Bonotes/menuPrincipal.png" Width="20px" OnClick="imbPrincipal_Click" ToolTip="Volver al menú principal" />
                    </div>

                </div>
            </div>
            <div style="border-bottom: 1px solid #808080; width: 100%; height: 100px; text-align: center; background-image: url('../Imagen/Fondos/BarraEstados.jpg'); background-repeat: repeat-x;">
                <div style="width: 1024px; height: 80px; padding: 10px 10% 10px 10%; display: inline-block; text-align: right">
                    <div style="height: 80px; width: 235px; text-align: center; float: left;">
                        <img src="../Imagen/Logos/LogoInfosNew.png" alt="InfoS" />
                        <span style="color: #171E75; font-weight: bold; font-size: 14px;">Versión 2.0</span>
                    </div>
                    <div style="height: 80px; width: 77%; float: right;">
                        <div style="float: right;">
                            <asp:Image ID="imgUser" runat="server" ImageUrl="~/Imagen/Utilidades/FotoUser.png" BorderColor="#006699" BorderStyle="Solid" Width="80px" />
                        </div>
                        <div style="height: 80px; width: 260px; float: right; font-size: 12px;">
                            <table cellpadding="0" cellspacing="0" style="width: 100%">
                                <tr>
                                    <td><strong>Usuario</strong></td>
                                    <td style="width: 10px"></td>
                                    <td style="width: 150px; text-align: left;">
                                        <asp:Label ID="lbUsuario" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="auto-style1"><strong>Nombre Usuario</strong></td>
                                    <td></td>
                                    <td style="text-align: left;">
                                        <asp:Label ID="lbNombreUsuario" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Empresa</strong></td>
                                    <td></td>
                                    <td style="text-align: left">
                                        <asp:Label ID="lbEmpresa" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Fecha</strong></td>
                                    <td></td>
                                    <td style="text-align: left">
                                        <asp:Label ID="lbFecha" runat="server"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td><strong>Modulo</strong></td>
                                    <td></td>
                                    <td style="text-align: left">
                                        <asp:Label ID="lbModulo" runat="server">Compras y servicios</asp:Label>
                                    </td>
                                </tr>
                            </table>
                        </div>

                    </div>
                </div>
            </div>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="lblInformacion" runat="server" Style="font-weight: 700"></asp:Label>
            </div>


        </div>
        <div id="menu">
            <ul id="nav">

                <li class="" style="text-align: left"><a class="" href="#">Administración</a>
                    <ul class="submenu">
                        <li class="" style="text-align: left"><a class="" href="#">Criterios</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Planes','Padministracion/Planes.aspx',true);">Planes</a></li>
                                <li><a href="#" onclick="addTab('Mayores','Padministracion/Mayores.aspx',true);">Mayores</a></li>
                            </ul>
                        </li>
                        <li><a href="#" onclick="addTab('Items','Padministracion/Items.aspx',true);">Items</a></li>
                        <li><a href="#" onclick="addTab('Destinos','Padministracion/Destinos.aspx',true);">Destinos</a></li>
                        <li><a href="#" onclick="addTab('TransaccionDias','Padministracion/ActivarDias.aspx',true);">Transacción activar días</a></li>
                        

                    </ul>
                </li>
                 <li class="" style="text-align: left"><a class="" href="#">Transacción</a>
                    <ul class="submenu">
                        <li><a href="#" onclick="addTab('Transacción','Ptransaccion/Transaccion.aspx',true);">Registro</a></li>
                    </ul>
                </li>
                <li class="" style="text-align: left"><a class="" href="#">Informes</a>
                    <ul class="submenu">
                        <li><a href="#" onclick="addTab('Informes','Pinformes/Informes.aspx',true);">Visualización</a></li>
                    </ul>
                </li>

            </ul>
        </div>
        <div id="tab">
            <div id="tt" class="easyui-tabs" style="min-width: 900px; min-height: 800px">
            </div>
        </div>
    </form>
</body>
</html>
