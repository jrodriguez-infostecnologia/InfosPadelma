using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nomina_Control_Calendario : System.Web.UI.UserControl
{


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            Populate_YearList();

            txtFechaNacimiento.Text = DateTime.Now.ToShortDateString();
            CalendarFecha.SelectedDate = DateTime.Today;
            ddlAño.SelectedValue = Convert.ToString(DateTime.Today.Year);
            ddlMes.SelectedValue = Convert.ToString(DateTime.Today.Month);

            CalendarFecha.Visible = true;
            ddlAño.Visible = true;
            ddlMes.Visible = true;

        }
    }

    private void Populate_YearList()
    {
        int year = Convert.ToInt16(DateTime.Now.Year.ToString()) - 60;
        int yearA = Convert.ToInt16(DateTime.Now.Year.ToString());

        for (int i = year; i <= yearA; i++)
        {
            ddlAño.Items.Add(Convert.ToString(i));
        }

    }

    protected void ddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {
        CalendarFecha.VisibleDate = new DateTime(Convert.ToInt16(ddlAño.SelectedValue), Convert.ToInt16(ddlMes.SelectedValue), 1);
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {

        txtFechaNacimiento.Text = CalendarFecha.SelectedDate.ToShortDateString();
        //ddlAño.Visible = false;
        //ddlMes.Visible = false;
        //CalendarFecha.Visible = false;
    }

    public DateTime SeleccionaFecha
    {
        get
        {

            if (!string.IsNullOrEmpty(txtFechaNacimiento.Text))
                return Convert.ToDateTime(txtFechaNacimiento.Text);

            return DateTime.MinValue;
        }

        set
        {

        
            txtFechaNacimiento.Text = Convert.ToString(value);
            CalendarFecha.SelectedDate = value;
        }


    }


    public bool Mostrar
    {
        get
        {
            return true;
        }
        set
        {
            CalendarFecha.Visible = value;
            ddlAño.Visible = value;
            ddlMes.Visible = value;
        }
    }




}