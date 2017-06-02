<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Calendario.ascx.cs" Inherits="Nomina_Control_Calendario"   %>

<style type="text/css">
        BODY {
            font-family: verdana, arial, helvetica;
        }
        .calTitle {
            font-weight: bold;
            font-size: 11px;
            background-color: #cccccc;
            color: black;
            width: 90px;
        }

        .calTitleAño {
            font-weight: bold;
            font-size: 11px;
            background-color: #cccccc;
            color: black;
            width: 60px;
        }
        .calBody {
            font-size: 11px;
            border-width: 10px;
        }
      
    .input {
    border: 1px solid silver;
    padding: 0px 3px;
    font-family: 'Trebuchet MS' , 'Lucida Sans Unicode' , 'Lucida Grande' , 'Lucida Sans' , Arial, sans-serif;
    font-size: 12px;
    color: #003366;
    height: 20px;
    border-radius: 2px 2px 2px 2px;
    box-shadow: 0 2px 2px rgba(0, 0, 0, 0.080) inset;
    margin-top: 0px;
}

    </style>

<table cellpadding="0" cellspacing="0" class="auto-style1">
    <tr>
        <td>
            <asp:DropDownList ID="ddlMes" runat="server" AutoPostBack="True" CssClass="calTitle" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlAño_SelectedIndexChanged">
                <asp:ListItem Value="1">Enero</asp:ListItem>
                <asp:ListItem Value="2">Febrero</asp:ListItem>
                <asp:ListItem Value="3">Marzo</asp:ListItem>
                <asp:ListItem Value="4">Abril</asp:ListItem>
                <asp:ListItem Value="5">Mayo</asp:ListItem>
                <asp:ListItem Value="6">Junio</asp:ListItem>
                <asp:ListItem Value="7">Julio</asp:ListItem>
                <asp:ListItem Value="8">Agosto</asp:ListItem>
                <asp:ListItem Value="9">Septiembre</asp:ListItem>
                <asp:ListItem Value="10">Octubre</asp:ListItem>
                <asp:ListItem Value="11">Noviembre</asp:ListItem>
                <asp:ListItem Value="12">Diciembre</asp:ListItem>
            </asp:DropDownList>
        </td>
        <td>
            <asp:DropDownList ID="ddlAño" runat="server" AutoPostBack="True" CssClass="calTitleAño" data-placeholder="Seleccione una opción..." OnSelectedIndexChanged="ddlAño_SelectedIndexChanged" Width="80px">
            </asp:DropDownList>
        </td>
    </tr>
    <tr>
        <td colspan="2">
            <asp:Calendar ID="CalendarFecha" runat="server" BackColor="White" BorderColor="#999999" CellPadding="4" CssClass="calBody" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="Black" Height="180px" OnSelectionChanged="CalendarFecha_SelectionChanged" ShowTitle="False" TitleFormat="Month" Width="100%">
                <SelectedDayStyle BackColor="#666666" Font-Bold="True" ForeColor="White" />
                <SelectorStyle BackColor="#CCCCCC" />
                <WeekendDayStyle BackColor="FloralWhite" />
                <TodayDayStyle BackColor="#CCCCCC" ForeColor="Black" />
                <OtherMonthDayStyle ForeColor="Gray" />
                <NextPrevStyle VerticalAlign="Bottom" />
                <DayHeaderStyle BackColor="#CCCCCC" Font-Bold="True" Font-Size="7pt" />
                <TitleStyle BackColor="#999999" BorderColor="Black" Font-Bold="True" />
            </asp:Calendar>
        </td>
    </tr>
    <tr>
        <td colspan="2">
                                    <asp:TextBox ID="txtFechaNacimiento" runat="server" CssClass="input" Font-Bold="True" ForeColor="Gray" ReadOnly="True" Width="100%"></asp:TextBox>
        </td>
    </tr>
</table>

