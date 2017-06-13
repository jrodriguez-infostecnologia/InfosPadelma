<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Facturacion_Error" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Untitled Page</title>
    <link href="../css/MenuPrincipal.css" rel="stylesheet" />
    <link href="../css/Formularios.css" rel="stylesheet" />
    <style type="text/css">
        .fielset {
            border-width: 2px;
            border-style: solid;
            border-color: #006FA8;
            -webkit-border-radius: 10px; /* border-radius para Safari y Chrome */
            -moz-border-radius: 10px; /* border-radius para Firefox */
            -khtml-border-radius: 10px; /* border-radius para navegadores Linux */
            border-radius: 10px; /* CSS3 Est�ndar */
        }
        
    </style>
</head>
<body style="text-align: center">
    <form id="form1" runat="server">
        <div style="width: 950px; height: 600px; text-align: center">
            <table style="width: 950px" cellspacing="0">
                <tr>
                    <td style="background-image: url(../Imagenes/botones/BotonIzq.png); width: 250px; background-repeat: no-repeat; height: 25px; text-align: left"></td>
                    <td style="width: 50px; height: 25px"></td>
                    <td style="width: 450px; height: 25px; text-align: left;"></td>
                    <td style="background-position-x: right; background-image: url(../Imagenes/botones/BotonDer.png); background-repeat: no-repeat;"></td>
                </tr>
                <tr>
                    <td style="background-position-x: left; background-image: url(../Imagenes/botones/BotonIzq.png); background-repeat: no-repeat" class="bordes">
                        </td>
                    <td style="height: 50px" colspan="2">
                        <div id="fielset" class="fielset">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="padding: 3px; text-align: left;" width="5px">
                        <asp:ImageButton ID="ImageButton1" runat="server" ToolTip="Regresar" ImageUrl="~/Imagen/TabsIcon/back.png" OnClick="ImageButton1_Click" />
                                    </td>
                                    <td style="padding: 3px; text-align: left;" width="500px">
                                        <asp:Label  ID="lblError" runat="server"></asp:Label></td>
                                    <td style="padding: 3px; text-align: left;" width="50px">
                                        <asp:Image ID="imgStop" runat="server" Height="50px" ImageUrl="~/Imagen/Iconos/exitoblue.png"
                                            Width="50px" /></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                    <td style="background-position-x: right; background-image: url(../Imagenes/botones/BotonDer.png); background-repeat: no-repeat" class="bordes"></td>
                </tr>
                <tr>
                    <td></td>
                    <td></td>
                    <td></td>
                    <td></td>
                </tr>
            </table>
            
        </div>
    </form>
</body>
</html>
