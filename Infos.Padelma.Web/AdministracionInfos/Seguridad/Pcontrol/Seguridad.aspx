<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Seguridad.aspx.cs" Inherits="Facturacion_Padministracion_Clientes1"  %>
<%@ OutputCache Location="None" %>            



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>Seguridad</title>
    <link href="../../css/Formularios.css" rel="stylesheet" />

    <script type="text/javascript" >
        javascript: window.history.forward(1);
     </script>

</head>
<body style="text-align: center">
    <form id="form1" runat="server">
    <div class="principal">
        <table cellspacing="0" style="width: 950px">
            <tr>
                <td style="background-image: url(../../Imagenes/botones/BotonIzq.png);
                    width: 250px; background-repeat: no-repeat; text-align: left; height: 25px;">
                </td>
                <td style="width: 500px; text-align: center; vertical-align: middle; height: 25px; font-size: 14px;">
                    <asp:Label ID="Label1" runat="server" Font-Bold="True" Text="Administración de Seguridad"></asp:Label></td>
                <td style="background-image: url(../../Imagenes/botones/BotonDer.png);
                    width: 250px; background-repeat: no-repeat; text-align: left; background-position-x: right; height: 25px;">
                </td>
            </tr>
        </table>
        <table cellspacing="0" style="width: 950px; border-top: silver thin solid; border-bottom: silver thin solid;">
            <tr>
                <td style="vertical-align: middle; width: 950px; text-align: center">
                    </td>
            </tr>
            <tr>
                <td style="vertical-align: middle; width: 950px; text-align: center; font-size: 14px;">
                    <asp:ImageButton ID="niimbConsultarLog" runat="server" ImageUrl="~/Imagen/Iconos/ConsultaLog.png" ToolTip="Haga clic aqui para consultar el log de eventos" OnClick="niimbConsultarLog_Click"/>&nbsp; Consultar Log&nbsp;
                    <asp:ImageButton ID="niimbMenu" runat="server" ImageUrl="~/Imagen/Iconos/admonMenu.png" ToolTip="Haga clic aqui para administrar los menues de los sitios Web " OnClick="niimbMenu_Click"/>
                    Administrar Menú&nbsp;
                    <asp:ImageButton ID="imbPermisos" runat="server" ImageUrl="~/Imagen/Iconos/permisos.png" ToolTip="Haga clic aqui para asignar permisos a un perfil" OnClick="imbPermisos_Click"/>
                    Permisos Perfil&nbsp;
                    <asp:ImageButton ID="niimbUsuarioPerfil" runat="server" ImageUrl="~/Imagen/Iconos/usuarioPerfil.png" ToolTip="Haga clic aqui para asignar un perfil a un usuario" OnClick="niimbUsuarioPerfil_Click"/>
                    Usuario Perfil</td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
