<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MenuInfos.aspx.cs" Inherits="Infos_MenuInfos" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>Nómina InfoS</title>
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
    <link href='http://fonts.googleapis.com/css?family=Lustria' rel='stylesheet' type='text/css' />


    <script type="text/javascript">
            function mainmenu() {
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
                }
                else {
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
        Reloj();
        function Reloj() {
            var tiempo = new Date();
            $("#lbFecha").text(tiempo.toLocaleString());
            setTimeout('Reloj()', 1000);
        }
        $(document).ready(function () {
            $('.navigation li').hover(
                function () {
                    $('ul', this).fadeIn();
                },
                function () {
                    $('ul', this).fadeOut();
                }
            );
        });
    </script>
    <script type="text/javascript">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', 'UA-39128869-1']);
        _gaq.push(['_trackPageview']);

        (function () {
            var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
            ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
            var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

    </script>
    <script type="text/javascript">
        function validarPasswd() {

            var p1 = document.getElementById("txtContrasenaNueva").value;
            var p2 = document.getElementById("txtContrasenaNueva1").value;
            var p3 = document.getElementById("Clave").value;
            var p4 = document.getElementById("txtContrasenaAnterior").value;

            var espacios = false;
            var cont = 0;
            while (!espacios && (cont < p1.length)) {
                if (p1.charAt(cont) == " ")
                    espacios = true;
                cont++;
            }

            if (espacios) {
                alert("La contraseña no puede contener espacios en blanco");
                return false;
            }

            if (p1.length == 0 || p2.length == 0) {
                alert("Los campos de la password no pueden quedar vacios");
                return false;
            }

            if (p1 != p2) {
                alert("Las passwords deben de coincidir");
                return false;
            }
            if (p3 != p4) {

                alert("Contraseña Anterior no valida"); return false;
            }

            else {

                return true;
            }
        }
    </script>
    <script type="">
        $(document).ready(function () {
            $('.button').click(function () {
                type = $(this).attr('data-type');
                $('.overlay-container').fadeIn(function () {
                    window.setTimeout(function () {
                        $('.window-container.' + type).addClass('window-container-visible');
                    }, 100);
                });
            });
            $('.close').click(function () {
                $('.overlay-container').fadeOut().end().find('.window-container').removeClass('window-container-visible');
            });
        });
    </script>
    <script type="">
        $(document).ready(function () {
            $('.buttonr').click(function () {
                type = $(this).attr('data-type');
                $('.overlay-containerr').fadeIn(function () {
                    window.setTimeout(function () {
                        $('.window-containerr.' + type).addClass('window-containerr-visible');
                    }, 100);
                });
            });
            $('.close').click(function () {
                $('.overlay-containerr').fadeOut().end().find('.window-containerr').removeClass('window-containerr-visible');
            });
        });
    </script>

</head>
<body style="margin: 0; padding: 0; min-width: 1180px; width: 100%;">
    <form id="form1" runat="server">
        <div>
            <div id="PrimeraLinea">
                <div id="Titulo">
                    <span>Sistema de Información INFOS - © 2015 Infos Tecnología S.A.S. Todos los derechos reservados - Santa Marta, Colombia</span>

                </div>
                <div style="float: left; width: 10%; height: 20px; background-repeat: repeat-x;">
                    <ul class="navigation">
                        <li><span style="background-position: left center; background-image: url('../Imagen/Bonotes/opciones.png'); background-repeat: no-repeat">
                            <div style="padding-left: 20px">
                                Opciones
                            </div>
                        </span>
                            <ul>
                                <li><a href="#" class="button" data-type="zoomin">Cambiar Contraseña</a></li>
                                <li><a href="#" class="buttonr" data-type="zoominr">Cambiar Empresa</a></li>
                                <li><a id="hpMenuPrincipal" runat="server">Menú Principal</a> </li>
                                <li><a id="hpMenu" runat="server">Cerrar Sesión</a> </li>
                            </ul>
                        </li>
                    </ul>

                </div>
            </div>
        </div>
        <div>
            <div style="height: 100px; background-image: url('../Imagen/Fondos/BarraEstados.jpg'); background-repeat: repeat-x;">
                <div id="LogoInfos">
                    <asp:ImageButton ID="imbPrincipal" runat="server" ImageUrl="~/Imagen/Logos/LogoInfos.png" OnClick="imbPrincipal_Click" ToolTip="Volver al menu principal" />
                </div>
                <div id="InfoUsuario">
                    <div style="display: inline-block;">
                        <table cellpadding="0" cellspacing="0" style="width: 450px">
                            <tr>
                                <td style="width: 40px; text-align: center;">
                                    <img alt="InfoS" src="../Imagen/IconV20/users.png" style="width: 30px" /></td>
                                <td style="text-align: left">
                                    <asp:Label ID="lbUsuario" runat="server"></asp:Label>
                                    <br />
                                    <asp:Label ID="lbNombreUsuario" runat="server"></asp:Label>
                                </td>
                                <td style="width: 100px; text-align: center;" rowspan="2">
                                    <img src="../Imagen/IconV20/Modulos/iconoBannerNomina.png" alt="InfoS" style="width: 60px" /><br />
                                    <asp:Label ID="lbModulo" runat="server" Font-Size="12pt" Style="font-weight: 700">Nómina</asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: center">
                                    <img alt="InfoS" src="../Imagen/IconV20/company.png" style="width: 30px" /></td>
                                <td style="text-align: left">
                                    <asp:Label ID="lbIdEmpresa" runat="server"></asp:Label>
                                    -<asp:Label ID="lbEmpresa" runat="server"></asp:Label>
                                    <br />
                                    <asp:Label ID="lbFecha" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
                <div>
                </div>
            </div>
        </div>
        <div id="menu">
            <ul id="nav">

                <li class="" style="text-align: left"><a class="" href="#">Administración</a>
                    <ul class="submenu">
                        <li class="" style="text-align: left"><a class="" href="#">Parametros</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Parametros Gen.','Padministracion/ParametrosGeneral.aspx',true)">Parametros Generales</a></li>
                                <li><a href="#" onclick="addTab('Parametros Año','Padministracion/ParametrosAño.aspx',true)">Parametros Año</a></li>
                                <li><a href="#" onclick="addTab('Parametro Tipo Cotizante','Padministracion/ParametroTipoCotizante.aspx',true)">Parametro Tipo Cotizante</a></li>
                                <li><a href="#" onclick="addTab('Parametro SS','Padministracion/ParametroSeguridadSocial.aspx',true)">Parametro Seguridad Social</a></li>
                                <li><a href="#" onclick="addTab('DiasHabiles.','Padministracion/DiasHabiles.aspx',true)">Días Habiles</a></li>
                                <li><a href="#" onclick="addTab('Festivos.','Padministracion/Festivos.aspx',true)">Días Festivos</a></li>
                                <li><a href="#" onclick="addTab('Motivo Retiro','Padministracion/MotivoRetiro.aspx',true)">Motivo retiro</a></li>
                                <li><a href="#" onclick="addTab('Centro Trabajos','Padministracion/CentroTrabajos.aspx',true)">Centro de trabajos</a></li>
                                <li><a href="#" onclick="addTab('Tipo Ausentismo','Padministracion/TipoIncapacidad.aspx',true)">Tipo de ausentismo</a></li>
                                <li><a href="#" onclick="addTab('Clase Contratos','Padministracion/ClaseContratos.aspx',true)">Clases contratos</a></li>
                                <li><a href="#" onclick="addTab('Plano Bancos','Padministracion/PlanoBancos.aspx',true)">Plano pago bancos</a></li>
                                <li><a href="#" onclick="addTab('Forma Pago','Padministracion/FormaPago.aspx',true)">Forma de pago</a></li>
                                <li><a href="#" onclick="addTab('Tipo Cotizante','Padministracion/TipoCotizante.aspx',true)">Tipo cotizante</a></li>
                                <li><a href="#" onclick="addTab('SubTipo Cotizante','Padministracion/SubTipoCotizante.aspx',true)">Subtipo Cotizante</a></li>

                            </ul>
                        </li>
                        <li class="" style="text-align: left"><a class="" href="#">Centro de Costos</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('EstructuraCCosto','Padministracion/EstructuraCCosto.aspx',true);">Estructura</a></li>
                                <li><a href="#" onclick="addTab('GrupoCCosto','Padministracion/GrupoCC.aspx',true);">Grupo CCosto</a></li>
                                <li><a href="#" onclick="addTab('CCosto','Padministracion/CentroCosto.aspx',true);">Centro de Costo</a></li>
                            </ul>
                        </li>

                        <li class="" style="text-align: left"><a class="" href="#">Entidades</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('E.P.S.','Pentidades/EPS.aspx',true);">E.P.S.</a></li>
                                <li><a href="#" onclick="addTab('A.R.L.','Pentidades/ARP.aspx',true);">A.R.L.</a></li>
                                <li><a href="#" onclick="addTab('A.F.C.','Pentidades/AFC.aspx',true);">A.F.C.</a></li>
                                <li><a href="#" onclick="addTab('A.F.P.','Pentidades/FondoPension.aspx',true);">A.F.P.</a></li>
                                <li><a href="#" onclick="addTab('I.C.B.F.','Pentidades/ICBF.aspx',true);">I.C.B.F.</a></li>
                                <li><a href="#" onclick="addTab('Sena','Pentidades/Sena.aspx',true);">Sena</a></li>
                                <li><a href="#" onclick="addTab('Cajas','Pentidades/Cajas.aspx',true);">Cajas compensación</a></li>
                            </ul>
                        </li>

                        <li class="" style="text-align: left"><a class="" href="#">Periodos</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Periocidad Nomina.','Padministracion/TipoNomina.aspx',true)">Periocidad nomina</a></li>
                                <li><a href="#" onclick="addTab('Periodo Nomina','Padministracion/PeriodoNomina.aspx',true)">Periodos nomina</a></li>
                            </ul>
                        </li>
                        <li class="" style="text-align: left"><a class="" href="#">Conceptos</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Grupo Concep.','Padministracion/GrupoConceptos.aspx',true)">Grupo Concepto</a></li>
                                 <li><a href="#" onclick="addTab('Tipo Concep.','Padministracion/TipoConceptos.aspx',true)">Tipo Concepto</a></li>
                                <li><a href="#" onclick="addTab('Concepto','Padministracion/Conceptos.aspx',true)">Registra Concepto</a></li>
                            </ul>
                        </li>
                        <li class="" style="text-align: left"><a class="" href="#">Información de empleados</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Grup. Empleados','Padministracion/Departamentos.aspx',true)">Grupo Empleados (Clases)</a></li>
                                <li><a href="#" onclick="addTab('Cargos','Padministracion/Cargos.aspx',true)">Cargos</a></li>
                                <li><a href="#" onclick="addTab('Empleados','Padministracion/Funcionarios.aspx',true)">Empleados</a></li>
                                <li><a href="#" onclick="addTab('Contratos','Padministracion/Contratos.aspx',true)">Contratos</a></li>
                                <li><a href="#" onclick="addTab('Cuadrillas','Padministracion/Cuadrillas.aspx',true)">Cuadrillas</a></li>
                                <li><a href="#" onclick="addTab('Pror/Ret','Padministracion/ProrrogasRetiros.aspx',true)">Prorrogas/Retiros</a></li>
                                <li><a href="#" onclick="addTab('Act. Sueldo','Padministracion/CambioSueldo.aspx',true)">Actuallización Sueldos</a></li>

                            </ul>
                        </li>
                        <li class="" style="text-align: left"><a class="" href="#">Seguridad</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Log. Contratos.','Padministracion/Log.aspx',true);">Log Contratos</a></li>
                            </ul>
                        </li>
                    </ul>
                </li>
                <li class="" style="text-align: left"><a class="" href="#">Control Acceso</a>
                    <ul class="submenu">
                        <li><a href="#" onclick="addTab('Cuadrillas','Pprogramacion/Cuadrillas.aspx');">Cuadrillas</a> </li>
                        <li><a href="#" onclick="addTab('Turnos','Pprogramacion/Turnos.aspx');">Turnos</a> </li>
                        <li><a href="#" onclick="addTab('Programación','Pprogramacion/Programacion.aspx');">Programación</a> </li>
                        <li><a href="#" onclick="addTab('Registro IN/OUT','Pprogramacion/RegistroInOut.aspx');">Registros Entradas/Salidas</a> </li>
                    </ul>
                </li>

                <li class="" style="text-align: left"><a class="" href="#">Proceso Liquidación</a>
                    <ul class="submenu">
                        <li><a href="#" onclick="addTab('Conceptos Fijos','Pliquidacion/ConceptosFijos.aspx');">Conceptos fijos</a> </li>
                        <li class="" style="text-align: left"><a class="" href="#">Novedades</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="window.open('Pliquidacion/RegistroNovedades.aspx');">Registro Novedades</a></li>
                                <li><a href="#" onclick="addTab('Prestamos','Pliquidacion/Prestamos.aspx',true);">Prestamos</a></li>
                                <li><a href="#" onclick="addTab('Embargos','Pliquidacion/Embargos.aspx',true);">Embargos</a></li>
                                <li><a href="#" onclick="addTab('Ausentismo','Pliquidacion/Incapacidades.aspx',true);">Ausentismo</a></li>
                                <%--<li><a href="#" onclick="addTab('Novedades','Pliquidacion/CierreNovedades.aspx',true);">Cierre Novedades Periodicas</a></li>--%>
                            </ul>
                        </li>
                        <li class="" style="text-align: left"><a class="" href="#">Liquidación de Nomina</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Pre-liquidar','Pliquidacion/Preliquidar.aspx',true);">Pre-liquidación</a></li>
                                <li><a href="#" onclick="addTab('Liquidar Def.','Pliquidacion/Liquidacion.aspx',true);">Liquidación Definitiva</a></li>
                                <li><a href="#" onclick="addTab('Pagos.','Pliquidacion/PagosNomina.aspx',true);">Pagos de  Nomina</a></li>
                            </ul>
                        </li>
                        <li class="" style="text-align: left"><a class="" href="#">Prestaciones Sociales</a>
                            <ul class="subsubmenu">
                                <li><a href="#" onclick="addTab('Liq. Vacaciones','Pliquidacion/Vacaciones.aspx',true);">Liquidación de Vacaciones</a></li>
                                <li><a href="#" onclick="addTab('Liq. Primas','Pliquidacion/LiquidacionPrimas.aspx',true);">Primas</a></li>
                                <li><a href="#" onclick="addTab('Liq. Cesantias','Pliquidacion/LiquidacionCesantias.aspx',true);">Cesantias</a></li>
                                <li><a href="#" onclick="addTab('Liq. Contratos','Pliquidacion/LiquidacionContrato.aspx',true);">Liquidación de Contratos</a></li>
                            </ul>
                        </li>
                        <li class="" style="text-align: left"><a class="" href="#">Seguridad Social</a>
                            <ul class="subsubmenu">
                                <%--<li><a href="#" onclick="addTab('Liquidación','Pliquidacion/Vacaciones.aspx',true);">Parametros</a></li>
                                <li><a href="#" onclick="addTab('Liq. Primas','Pliquidacion/AFC.aspx',true);">Traslados</a></li>--%>
                                <li><a href="#" onclick="addTab('Liq. Seg. Social','Pliquidacion/SeguridadSocial.aspx',true);">Liquidación Seguridad Social</a></li>

                            </ul>
                        </li>
                    </ul>
                </li>

                <li class="" style="text-align: left"><a href="#" onclick="addTab('Visualización','Pinformes/Visualizacion.aspx',true)">Informes</a>
                    <%--     <ul class="submenu">
                        <li><a href="#" onclick="addTab('Visualización','Pinformes/Visualizacion.aspx',true)">Visualización</a></li>
                    </ul>--%>
                </li>
            </ul>
        </div>
        <div id="tab">
            <div id="tt" class="easyui-tabs" style="min-width: 900px; min-height: 800px">
            </div>
        </div>
        <div class="overlay-container">
            <div class="window-container zoomin">
                <table cellspacing="0">
                    <tr>
                        <td style="text-align: left"></td>
                        <td style="vertical-align: top; background-color: transparent; text-align: left">
                            <asp:HiddenField ID="Clave" runat="server" />
                        </td>
                    </tr>
                    <tr>
                        <td style="width: 130px; text-align: left;">
                            <asp:Label ID="lblContrasenaAnterior" runat="server" ForeColor="#003366" Text="Contraseña Anterior" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="12px"></asp:Label></td>
                        <td style="vertical-align: top; width: 250px; background-color: transparent; text-align: left;">
                            <asp:TextBox ID="txtContrasenaAnterior" runat="server" CssClass="input"
                                TextMode="Password" Width="120px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <asp:Label ID="lblNueva" runat="server" ForeColor="#003366" Text="Nueva Contraseña" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="12px"></asp:Label></td>
                        <td style="vertical-align: top; background-color: transparent; text-align: left">
                            <asp:TextBox ID="txtContrasenaNueva" runat="server" CssClass="input"
                                TextMode="Password" Width="120px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align: left">
                            <asp:Label ID="Label1" runat="server" ForeColor="#003366" Text="Confirmar Contraseña" Font-Bold="False" Font-Names="Trebuchet MS" Font-Size="12px"></asp:Label></td>
                        <td style="vertical-align: top; background-color: transparent; text-align: left">
                            <asp:TextBox ID="txtContrasenaNueva1" runat="server" CssClass="input"
                                TextMode="Password" Width="120px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td style="text-align: left; height: 10px;" colspan="2"></td>
                    </tr>
                    <tr>
                        <td style="text-align: right;" colspan="2">
                            <asp:ImageButton ID="btnCambiarClave" runat="server" BorderColor="#99CCFF" BorderStyle="None" BorderWidth="1px"
                                ImageUrl="~/Imagen/Bonotes/btnCambiarContraseña.jpg"
                                onmouseout="this.src='../Imagen/Bonotes/btnCambiarContraseña.jpg'"
                                onmouseover="this.src='../Imagen/Bonotes/btnCambiarContraseñaNegro.jpg'" TabIndex="3" OnClick="btnIniciarSesion_Click"
                                OnClientClick="if(!confirm('Desea cambiar contraseña ?')){return false;};" />
                            <asp:ImageButton ID="btnCancelar" runat="server" BorderColor="#99CCFF" BorderStyle="None" BorderWidth="1px"
                                ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg"
                                onmouseout="this.src='../Imagen/Bonotes/btnCancelar.jpg'"
                                onmouseover="this.src='../Imagen/Bonotes/btnCancelarNegro.jpg'" TabIndex="3" CssClass="close" />
                        </td>
                    </tr>
                </table>
            </div>

        </div>
        <div class="overlay-containerr">
            <div class="window-containerr zoominr">
                <table id="TABLE2" cellspacing="0">
                    <tr>
                        <td style="text-align: left"></td>
                    </tr>
                    <tr>
                        <td style="text-align: center; width: 500px;">
                            <asp:GridView ID="gvLista" runat="server" AutoGenerateColumns="False" BackColor="White" BorderColor="#3366CC" BorderStyle="None" BorderWidth="1px" CellPadding="4" Width="500px" OnSelectedIndexChanged="gvLista_SelectedIndexChanged">
                                <Columns>
                                    <asp:ButtonField ButtonType="Image" ImageUrl="~/Imagen/Iconos/ok.png" Text="Botón" CommandName="Select">
                                        <HeaderStyle BackColor="White" BorderStyle="None" Width="20px" />
                                        <ItemStyle BorderColor="Silver" BorderStyle="Dotted" BorderWidth="1px" Height="22px" Width="20px" />
                                    </asp:ButtonField>
                                    <asp:BoundField DataField="id" HeaderText="Id">
                                        <HeaderStyle CssClass="items" />
                                        <ItemStyle CssClass="Items" Width="20px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="nit" HeaderText="Nit">
                                        <HeaderStyle CssClass="items" />
                                        <ItemStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Height="22px" Width="100px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="razonSocial" HeaderText="Nombre Empresa">
                                        <HeaderStyle CssClass="items" />
                                        <ItemStyle BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px" Height="22px" />
                                    </asp:BoundField>
                                </Columns>
                                <FooterStyle BackColor="#99CCCC" ForeColor="#003399" />
                                <HeaderStyle CssClass="herader" BackColor="#003399" Font-Bold="True" ForeColor="White" Height="22px" HorizontalAlign="Center" VerticalAlign="Middle" />
                                <PagerStyle BackColor="#99CCCC" ForeColor="#003399" HorizontalAlign="Left" />
                                <RowStyle BackColor="White" ForeColor="#003399" />
                                <SelectedRowStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr>
                        <td style="text-align: right; height: 10px;"></td>
                    </tr>
                    <tr>
                        <td style="text-align: right;">

                            <asp:ImageButton ID="ImageButton2" runat="server" BorderColor="#99CCFF" BorderStyle="None" BorderWidth="1px"
                                ImageUrl="~/Imagen/Bonotes/btnCancelar.jpg"
                                onmouseout="this.src='../Imagen/Bonotes/btnCancelar.jpg'"
                                onmouseover="this.src='../Imagen/Bonotes/btnCancelarNegro.jpg'" TabIndex="3" CssClass="close" />

                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </form>
</body>
</html>
