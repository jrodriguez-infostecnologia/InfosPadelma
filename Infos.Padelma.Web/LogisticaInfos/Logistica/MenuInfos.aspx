<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuInfos.aspx.cs" Inherits="Infos_MenuInfos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Administración Infos</title>
    <script src="../js/jquery-1.3.min.js"></script>
    <link href="../css/demo.css" rel="stylesheet" type="text/css" />
    <link href="../css/LetraLustria.css" rel="stylesheet" />
    <link href="../css/MenuPrincipal.css" rel="stylesheet" />
    <link href="../css/menucss.css" rel="stylesheet" />
    <link href="../css/iconTabs.css" rel="stylesheet" />
    <link href="../css/TabsInfoscss.css" rel="stylesheet" />
    <script src="../js/jquery-1.4.4.min.js"></script>
    <script src="../js/jquery.easyui.min.js"></script>
    <link href="../css/BarraSuperiorInfos.css" rel="stylesheet" />
    <script type="text/javascript">

        Reloj();
        function Reloj() {
            var tiempo = new Date();
            $("#lbFecha").text(tiempo.toLocaleString());
            setTimeout('Reloj()', 1000);
        }
        function mainmenu() {
            //por ricardo gomez
            $("#nav ul").css({ display: "none" });
            $(" #nav li ul li").hover(function () {
                $(this).find('ul:first:hidden').css({ visibility: "visible", display: "none" }).slideDown(300);
            }, function () {
                $(this).find('ul:first').slideUp(800);
            });

            $("#nav li").click(function (e) {
                if (!$(this).hasClass('selected')) {
                    $("body").find("#nav li.selected").find('ul').slideUp(800);
                    $("body").find("#nav li").removeClass('selected');
                    $(this).addClass("selected");
                    $(this).find('ul:first:hidden').css({ visibility: "visible", display: "none" }).slideDown(300);
                }
                else {

                    $(this).find('ul:first').slideUp(800);
                    $("#nav li").removeClass("selected");
                }
                e.stopPropagation();
            }
            );

            $("body").click(function () { // binding onclick to body
                $("body").find("#nav li.selected").find('ul').slideUp(800); // hiding popups
                $("body").find("#nav li").removeClass('selected');
            });

        }

        $(document).ready(function () {
            mainmenu();
        });
    </script>
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
    <style type="text/css">
        .auto-style1 {
            text-align: left;
        }
    </style>
</head>
<body style="margin: 0; padding: 0; min-width: 1180px; width: 100%;">
    <form id="form1" runat="server">
        <div>
            <div>
                <div id="PrimeraLinea">
                    <div id="Titulo">
                        <span>Sistema de Información INFOS - © 2015 Todos los derechos reservados - Santa Marta, Colombia</span>
                    </div>
                </div>
            </div>
            <div>
                <div style="height: 100px; background-image: url('../Imagen/Fondos/BarraEstados.jpg'); background-repeat: repeat-x;">
                    <div id="LogoInfos">
                        <asp:ImageButton ID="imbPrincipal" runat="server" ImageUrl="~/Imagen/Logos/LogoInfos.png" OnClick="imbPrincipal_Click" ToolTip="Volver al menu principal" />
                    </div>
                    <div>

                        <div id="InfoUsuario">
                            <div style="display: inline-block;">
                                <table cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td rowspan="2"></td>
                                        <td>
                                            <img alt="InfoS" src="../Imagen/IconV20/users.png" style="width: 30px" /></td>
                                        <td class="auto-style1">
                                            <asp:Label ID="lbUsuario" runat="server"></asp:Label>
                                            <br />
                                            <asp:Label ID="lbNombreUsuario" runat="server"></asp:Label>
                                        </td>
                                        <td style="width: 120px; text-align: center;" rowspan="2">
                                            <img src="../Imagen/IconV20/Modulos/iconoBannerLogistica.png" alt="InfoS" style="width: 60px" /><br />
                                            <asp:Label ID="lbModulo" runat="server" Font-Size="12pt" Style="font-weight: 700">Logistica</asp:Label>
                                        </td>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <img alt="InfoS" src="../Imagen/IconV20/company.png" style="width: 30px" /></td>
                                        <td class="auto-style1">
                                            <asp:Label ID="lbEmpresa" runat="server"></asp:Label>
                                            <br />
                                            <asp:Label ID="lbFecha" runat="server"></asp:Label>
                                        </td>
                                        <td></td>
                                    </tr>
                                </table>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
      <div id="menu">
            <ul id="nav">

              <li class="" style="text-align: left"><a class="" href="#">Administración</a>
                    <ul class="submenu">
                        <li><a href="#" onclick="addTab('TipoMercado','Padministracion/TipoMercado.aspx',true);">Tipo Mercado</a></li>
                        <li><a href="#" onclick="addTab('Mercados','Padministracion/Mercado.aspx',true);">Mercados</a></li>
                        <li><a href="#" onclick="addTab('Boni-Maquila','Padministracion/BonificacionMaquila.aspx',true);">Boni-Maquila</a></li>

                    </ul>
                </li>

                <li class="" style="text-align: left"><a class="" href="#">Logística</a>
                    <ul class="submenu">
                        <li><a href="#" onclick="addTab('Programación','Pprogramacion/Programacion.aspx',true);">Programación Depachos</a></li>
                        <li><a href="#" onclick="addTab('Negocio','Pprogramacion/NegocioMaquila.aspx',true);">Negocio Maquila</a></li>
                    </ul>
                </li>
                <li class="" style="text-align: left"><a class="" href="#">Consultas</a>
                    <ul class="submenu">
                        <li><a href="#" onclick="addTab('Despachos','Pconsultas/DespachosDiarios.aspx',true);">Despachos</a></li>
                    </ul>
                </li>
                <li class="" style="text-align: left"><a href="#" onclick="addTab('Menu Inf.','Pinformes/Visualizacion.aspx',true)">Informes</a></li>
                           
            </ul>
        </div>
        <div id="tab">
            <div id="tt" class="easyui-tabs" style="min-width: 900px; min-height: 800px">
            </div>
        </div>
    </form>
</body>
    

</html>
