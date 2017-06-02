using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using System.Drawing;
using System.Data;
using System.Configuration;


public partial class Nomina_Pprogramacion_Programacion : System.Web.UI.Page
{
    #region Instancias


    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();


    Cturnos turnos = new Cturnos();
    Ccuadrillas cuadrillas = new Ccuadrillas();
    Cprogramacion programacion = new Cprogramacion();

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }
    private void GetFuncionariosIndividual()
    {
        try
        {
            this.gvLista.DataSource = programacion.GetFuncionariosSinProgramacionCuadrilla(this.CalendarFecha.SelectedDate, Convert.ToString(this.ddlCuadrilla.SelectedValue), Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar funcionarios sin programación. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void GuardarExtras()
    {
        bool verifica = false;

        this.nilblInformacion.Text = "";

        try
        {

            if (Convert.ToString(this.niddlTurno.SelectedValue).Length == 0 || Convert.ToString(this.ddlCuadrilla.SelectedValue).Length == 0 ||
                this.txtFecha.Text.Length == 0 || this.gvExtras.Rows.Count == 0)
            {
                this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                return;
            }

            foreach (GridViewRow registro in this.gvExtras.Rows)
            {
                if (((TextBox)registro.Cells[3].FindControl("txtExtrasLun")).Text.Length > 0)
                {
                    verifica = true;
                }

                if (((TextBox)registro.Cells[4].FindControl("txtExtrasMar")).Text.Length > 0)
                {
                    verifica = true;
                }

                if (((TextBox)registro.Cells[5].FindControl("txtExtrasMie")).Text.Length > 0)
                {
                    verifica = true;
                }

                if (((TextBox)registro.Cells[6].FindControl("txtExtrasJue")).Text.Length > 0)
                {
                    verifica = true;
                }

                if (((TextBox)registro.Cells[7].FindControl("txtExtrasVie")).Text.Length > 0)
                {
                    verifica = true;
                }

                if (((TextBox)registro.Cells[8].FindControl("txtExtrasSab")).Text.Length > 0)
                {
                    verifica = true;
                }

                if (((TextBox)registro.Cells[9].FindControl("txtExtrasDom")).Text.Length > 0)
                {
                    verifica = true;
                }
            }

            if (verifica == false)
            {
                this.nilblInformacion.Text = "Debe asignar horas extras a almenos un funcionario en un día de la semana";
            }
            else
            {
                using (TransactionScope ts = new TransactionScope())
                {
                    foreach (GridViewRow registro in this.gvExtras.Rows)
                    {
                        if (verifica == true)
                        {
                            if (((TextBox)registro.Cells[3].FindControl("txtExtrasLun")).Text.Length > 0)
                            {
                                switch (programacion.AutorizaHorasExtras(
                                    this.CalendarFecha.SelectedDate,
                                    Convert.ToString(this.niddlTurno.SelectedValue),
                                    registro.Cells[0].Text,
                                    Convert.ToDecimal(((TextBox)registro.Cells[3].FindControl("txtExtrasLun")).Text),
                                    "lun", this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 1:

                                        verifica = false;
                                        break;
                                }
                            }

                            if (((TextBox)registro.Cells[4].FindControl("txtExtrasMar")).Text.Length > 0)
                            {
                                switch (programacion.AutorizaHorasExtras(
                                    this.CalendarFecha.SelectedDate,
                                    Convert.ToString(this.niddlTurno.SelectedValue),
                                    registro.Cells[0].Text,
                                    Convert.ToDecimal(((TextBox)registro.Cells[4].FindControl("txtExtrasMar")).Text),
                                    "mar", this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 1:

                                        verifica = false;
                                        break;
                                }
                            }

                            if (((TextBox)registro.Cells[5].FindControl("txtExtrasMie")).Text.Length > 0)
                            {
                                switch (programacion.AutorizaHorasExtras(
                                    this.CalendarFecha.SelectedDate,
                                    Convert.ToString(this.niddlTurno.SelectedValue),
                                    registro.Cells[0].Text,
                                    Convert.ToDecimal(((TextBox)registro.Cells[5].FindControl("txtExtrasMie")).Text),
                                    "mie", this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 1:

                                        verifica = false;
                                        break;
                                }
                            }

                            if (((TextBox)registro.Cells[6].FindControl("txtExtrasJue")).Text.Length > 0)
                            {
                                switch (programacion.AutorizaHorasExtras(
                                    this.CalendarFecha.SelectedDate,
                                    Convert.ToString(this.niddlTurno.SelectedValue),
                                    registro.Cells[0].Text,
                                    Convert.ToDecimal(((TextBox)registro.Cells[6].FindControl("txtExtrasJue")).Text),
                                    "jue", this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 1:

                                        verifica = false;
                                        break;
                                }
                            }

                            if (((TextBox)registro.Cells[7].FindControl("txtExtrasVie")).Text.Length > 0)
                            {
                                switch (programacion.AutorizaHorasExtras(
                                    this.CalendarFecha.SelectedDate,
                                    Convert.ToString(this.niddlTurno.SelectedValue),
                                    registro.Cells[0].Text,
                                    Convert.ToDecimal(((TextBox)registro.Cells[7].FindControl("txtExtrasVie")).Text),
                                    "vie", this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 1:

                                        verifica = false;
                                        break;
                                }
                            }

                            if (((TextBox)registro.Cells[8].FindControl("txtExtrasSab")).Text.Length > 0)
                            {
                                switch (programacion.AutorizaHorasExtras(
                                    this.CalendarFecha.SelectedDate,
                                    Convert.ToString(this.niddlTurno.SelectedValue),
                                    registro.Cells[0].Text,
                                    Convert.ToDecimal(((TextBox)registro.Cells[8].FindControl("txtExtrasSab")).Text),
                                    "sab", this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 1:

                                        verifica = false;
                                        break;
                                }
                            }

                            if (((TextBox)registro.Cells[9].FindControl("txtExtrasDom")).Text.Length > 0)
                            {
                                switch (programacion.AutorizaHorasExtras(
                                    this.CalendarFecha.SelectedDate,
                                    Convert.ToString(this.niddlTurno.SelectedValue),
                                    registro.Cells[0].Text,
                                    Convert.ToDecimal(((TextBox)registro.Cells[9].FindControl("txtExtrasDom")).Text),
                                    "dom", this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                                {
                                    case 1:

                                        verifica = false;
                                        break;
                                }
                            }
                        }
                    }

                    if (verifica == true)
                    {
                        this.nilblInformacion.ForeColor = Color.Green;
                        this.nilblInformacion.Text = "Autorización de horas extras registrada satisfactoriamente";
                        this.gvExtras.Visible = false;
                        this.lbRegistrarExtras.Visible = false;
                        ts.Complete();

                    }
                    else
                    {
                        this.nilblInformacion.Text = "Error al registrar autorización de horas extras. Operación no realizada";
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al autorizar horas extras correspondiente a: " + ex.Message, "C");
        }
    }
    private void GetEntidadExtras()
    {
        int i = 0;
        bool sw = false;
        this.nilblInformacion.Text = "";
        try
        {
            this.gvExtras.DataSource = programacion.GetProgramacionFuncionariosCuadrillaRegistroPorteria(
                Convert.ToString(this.ddlCuadrilla.SelectedValue),
                Convert.ToString(this.niddlTurno.SelectedValue),
                Convert.ToString(this.Session["usuario"]),
                this.CalendarFecha.SelectedDate, Convert.ToInt16(Session["empresa"]));
            this.gvExtras.DataBind();

            foreach (DataRowView registro in programacion.GetProgramacionFuncionariosCuadrillaRegistroPorteria(
                  Convert.ToString(this.ddlCuadrilla.SelectedValue),
                  Convert.ToString(this.niddlTurno.SelectedValue),
                  Convert.ToString(this.Session["usuario"]),
                  this.CalendarFecha.SelectedDate, Convert.ToInt16(Session["empresa"])))
            {
                if (Convert.ToInt16(registro.Row.ItemArray.GetValue(3)) == 1)
                {
                    sw = true;
                    foreach (DataRowView dia in programacion.GetProgramacionFuncionariosDiasP(
                        this.CalendarFecha.SelectedDate,
                        Convert.ToString(this.Session["usuario"]),
                        Convert.ToString(this.niddlTurno.SelectedValue),
                        Convert.ToString(this.ddlCuadrilla.SelectedValue),
                        Convert.ToString(registro.Row.ItemArray.GetValue(0)), Convert.ToInt16(Session["empresa"])))
                    {
                        if (Convert.ToInt16(dia.Row.ItemArray.GetValue(1)) > 0)
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasLun")).Visible = true;
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasLun")).Text = "0";
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(1)) > 1)
                                ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasLun")).Text = Convert.ToString(dia.Row.ItemArray.GetValue(1));
                        }
                        else
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasLun")).Visible = false;

                        }

                        if (Convert.ToInt16(dia.Row.ItemArray.GetValue(2)) > 0)
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMar")).Visible = true;
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMar")).Text = "0";
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(2)) > 1)
                                ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMar")).Text = Convert.ToString(dia.Row.ItemArray.GetValue(2));

                        }
                        else
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMar")).Visible = false;
                        }

                        if (Convert.ToInt16(dia.Row.ItemArray.GetValue(3)) > 0)
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMie")).Visible = true;
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMie")).Text = "0";
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(3)) > 1)
                                ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMie")).Text = Convert.ToString(dia.Row.ItemArray.GetValue(3));
                        }
                        else
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasMie")).Visible = false;
                        }

                        if (Convert.ToInt16(dia.Row.ItemArray.GetValue(4)) > 0)
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasJue")).Visible = true;
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasJue")).Text = "0";
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(4)) > 1)
                                ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasJue")).Text = Convert.ToString(dia.Row.ItemArray.GetValue(4));
                        }
                        else
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasJue")).Visible = false;
                        }

                        if (Convert.ToInt16(dia.Row.ItemArray.GetValue(5)) > 0)
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasVie")).Visible = true;
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasVie")).Text = "0";
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(5)) > 1)
                                ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasVie")).Text = Convert.ToString(dia.Row.ItemArray.GetValue(5));
                        }
                        else
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasVie")).Visible = false;
                        }

                        if (Convert.ToInt16(dia.Row.ItemArray.GetValue(6)) > 0)
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasSab")).Visible = true;
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasSab")).Text = "0";
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(6)) > 1)
                                ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasSab")).Text = Convert.ToString(dia.Row.ItemArray.GetValue(6));
                        }
                        else
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasSab")).Visible = false;
                        }

                        if (Convert.ToInt16(dia.Row.ItemArray.GetValue(7)) > 0)
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasDom")).Visible = true;
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasDom")).Text = "0";
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(7)) > 1)
                                ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasDom")).Text = Convert.ToString(dia.Row.ItemArray.GetValue(7));
                        }
                        else
                        {
                            ((TextBox)this.gvExtras.Rows[i].FindControl("txtExtrasDom")).Visible = false;
                        }
                    }


                }


                i++;
            }
            if (sw == false)
            {

                this.lbRegistrarExtras.Visible = false;
                this.nilblInformacion.ForeColor = Color.Red;
                this.nilblInformacion.Text = "Las programaciones no se encuentran ejecuatadas para autorizar horas extras";

            }
            else
            {
                this.lbRegistrarExtras.Visible = true;
            }


        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la programación para autorización de horas extras. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void Guardar()
    {
        bool verificacion = true;

        try
        {
            if (Convert.ToString(this.niddlTurno.SelectedValue).Length == 0 || Convert.ToString(this.ddlCuadrilla.SelectedValue).Length == 0 || this.txtFecha.Text.Length == 0 || this.gvLista.Rows.Count == 0)
            {
                this.nilblInformacion.Text = "Campos vacios. Por favor corrija";
                return;
            }

            using (TransactionScope ts = new TransactionScope())
            {
                foreach (GridViewRow registro in this.gvLista.Rows)
                {
                    if (verificacion == true)
                    {
                        switch (programacion.GuardaProgramacion(this.CalendarFecha.SelectedDate, Convert.ToString(this.niddlTurno.SelectedValue), registro.Cells[0].Text,
                            Convert.ToString(this.ddlCuadrilla.SelectedValue), this.Session["usuario"].ToString(), "lun",
                            ((CheckBox)registro.Cells[4].FindControl("chkLun")).Checked, Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                                verificacion = false;
                                break;

                            case 2:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " se encuentra programado el mismo día en un turno que coincide con el seleccionado";
                                verificacion = false;
                                break;
                            case 3:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " no se encuentra programado el día Lunes y este es inferior a la fecha";
                                verificacion = false;
                                break;
                            case 4:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " No puede eliminar la programación fue ejecutada.";
                                verificacion = false;
                                break;
                            case 5:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al Programar:  hora del turno iniciada";
                                verificacion = false;
                                break;
                        }
                    }
                    else
                    {
                        return;
                    }

                    if (verificacion == true)
                    {
                        switch (programacion.GuardaProgramacion(this.CalendarFecha.SelectedDate, Convert.ToString(this.niddlTurno.SelectedValue),
                            registro.Cells[0].Text, Convert.ToString(this.ddlCuadrilla.SelectedValue), this.Session["usuario"].ToString(), "mar",
                            ((CheckBox)registro.Cells[5].FindControl("chkMar")).Checked, Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                                verificacion = false;
                                break;

                            case 2:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " se encuentra programado el mismo día en un turno que coincide con el seleccionado";
                                verificacion = false;
                                break;
                            case 3:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " no se encuentra programado el día Martes y este es inferior a la fecha";
                                verificacion = false;
                                break;
                            case 4:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " No puede eliminar la programación fue ejecutada.";
                                verificacion = false;
                                break;
                            case 5:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al Programar:  hora del turno iniciada";
                                verificacion = false;
                                break;
                        }
                    }
                    else
                        return;

                    if (verificacion == true)
                    {
                        switch (programacion.GuardaProgramacion(this.CalendarFecha.SelectedDate, Convert.ToString(this.niddlTurno.SelectedValue),
                            registro.Cells[0].Text, Convert.ToString(this.ddlCuadrilla.SelectedValue), this.Session["usuario"].ToString(), "mie",
                            ((CheckBox)registro.Cells[6].FindControl("chkMie")).Checked, Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                                verificacion = false;
                                break;

                            case 2:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " se encuentra programado el mismo día en un turno que coincide con el seleccionado";
                                verificacion = false;
                                break;
                            case 3:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " no se encuentra programado el día Miercoles y este es inferior a la fecha";
                                verificacion = false;
                                break;
                            case 4:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " No puede eliminar la programación fue ejecutada.";
                                verificacion = false;
                                break;
                            case 5:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al Programar:  hora del turno iniciada";
                                verificacion = false;
                                break;
                        }
                    }
                    else
                        return;

                    if (verificacion == true)
                    {
                        switch (programacion.GuardaProgramacion(this.CalendarFecha.SelectedDate,
                            Convert.ToString(this.niddlTurno.SelectedValue), registro.Cells[0].Text, Convert.ToString(this.ddlCuadrilla.SelectedValue),
                            this.Session["usuario"].ToString(), "jue", ((CheckBox)registro.Cells[7].FindControl("chkJue")).Checked, Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                                verificacion = false;
                                break;

                            case 2:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " se encuentra programado el mismo día en un turno que coincide con el seleccionado";
                                verificacion = false;
                                break;
                            case 3:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " no se encuentra programado el día Jueves y este es inferior a la fecha";
                                verificacion = false;
                                break;
                            case 4:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " No puede eliminar la programación fue ejecutada.";
                                verificacion = false;
                                break;
                            case 5:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al Programar:  hora del turno iniciada";
                                verificacion = false;
                                break;
                        }
                    }
                    else
                        return;

                    if (verificacion == true)
                    {
                        switch (programacion.GuardaProgramacion(this.CalendarFecha.SelectedDate,
                            Convert.ToString(this.niddlTurno.SelectedValue), registro.Cells[0].Text, Convert.ToString(this.ddlCuadrilla.SelectedValue), this.Session["usuario"].ToString(), "vie",
                            ((CheckBox)registro.Cells[8].FindControl("chkVie")).Checked, Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                                verificacion = false;
                                break;

                            case 2:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " se encuentra programado el mismo día en un turno que coincide con el seleccionado";
                                verificacion = false;
                                break;
                            case 3:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " no se encuentra programado el día Viernes y este es inferior a la fecha";
                                verificacion = false;
                                break;
                            case 4:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " No puede eliminar la programación fue ejecutada.";
                                verificacion = false;
                                break;
                            case 5:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al Programar:  hora del turno iniciada";
                                verificacion = false;
                                break;
                        }
                    }
                    else
                        return;

                    if (verificacion == true)
                    {
                        switch (programacion.GuardaProgramacion(this.CalendarFecha.SelectedDate, Convert.ToString(this.niddlTurno.SelectedValue), registro.Cells[0].Text,
                            Convert.ToString(this.ddlCuadrilla.SelectedValue), this.Session["usuario"].ToString(), "sab",
                            ((CheckBox)registro.Cells[9].FindControl("chkSab")).Checked, Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                                verificacion = false;
                                break;

                            case 2:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " se encuentra programado el mismo día en un turno que coincide con el seleccionado";
                                verificacion = false;
                                break;
                            case 3:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " no se encuentra programado el día Sábado y este es inferior a la fecha";
                                verificacion = false;
                                break;
                            case 4:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " No puede eliminar la programación fue ejecutada.";
                                verificacion = false;
                                break;
                            case 5:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al Programar:  hora del turno iniciada";
                                verificacion = false;
                                break;
                        }
                    }
                    else
                        return;

                    if (verificacion == true)
                    {
                        switch (programacion.GuardaProgramacion(this.CalendarFecha.SelectedDate, Convert.ToString(this.niddlTurno.SelectedValue), registro.Cells[0].Text,
                            Convert.ToString(this.ddlCuadrilla.SelectedValue), this.Session["usuario"].ToString(), "dom",
                            ((CheckBox)registro.Cells[10].FindControl("chkDom")).Checked, Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                                verificacion = false;
                                break;

                            case 2:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " se encuentra programado el mismo día en un turno que coincide con el seleccionado";
                                verificacion = false;
                                break;
                            case 3:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " no se encuentra programado el día Domingo y este es inferior a la fecha";
                                verificacion = false;
                                break;
                            case 4:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "El funcionario " + registro.Cells[1].Text + " No puede eliminar la programación fue ejecutada.";
                                verificacion = false;
                                break;
                            case 5:
                                this.nilblInformacion.ForeColor = Color.Red;
                                this.nilblInformacion.Text = "Error al Programar:  hora del turno iniciada";
                                verificacion = false;
                                break;
                        }
                    }
                    else
                        return;
                }

                if (verificacion == true)
                {
                    this.nilblInformacion.ForeColor = Color.Green;
                    this.nilblInformacion.Text = "Programación registrada satisfactoriamente";
                    GetProgramacion();
                    ts.Complete();
                }
                else
                {
                    this.nilblInformacion.ForeColor = Color.Red;
                    this.nilblInformacion.Text = "Error al insertar la programación. Operación no realizada";
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al registrar la programación de funcionarios. Correspondiente a: " + ex.Message, "I");
        }
    }
    private void ManejarControles()
    {
        this.lbAsignar.Visible = false;
        this.lbRegistrar.Visible = false;
    }
    private void GetProgramacion()
    {
        gvLista.DataSource = null;
        gvLista.DataBind();
        ManejarControles();
        int i = 0;
        this.gvLista.Visible = true;

        try
        {
            if (Convert.ToString(this.niddlTurno.SelectedValue).Length == 0 || Convert.ToString(this.CalendarFecha.SelectedDate).Length == 0 ||
                Convert.ToString(this.ddlCuadrilla.SelectedValue).Length == 0)
            {
                return;
            }

            this.gvLista.DataSource = programacion.GetProgramacionFuncionariosCuadrilla(Convert.ToString(this.ddlCuadrilla.SelectedValue),
                Convert.ToString(this.niddlTurno.SelectedValue), this.CalendarFecha.SelectedDate, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            if (Convert.ToInt16(programacion.VerificaProgramacionExiste(this.CalendarFecha.SelectedDate, Convert.ToString(this.niddlTurno.SelectedValue),
                Convert.ToString(this.ddlCuadrilla.SelectedValue), Convert.ToInt16(Session["empresa"]))) == 0 && this.gvLista.Rows.Count > 0)
            {
                ((CheckBox)this.gvLista.HeaderRow.Cells[4].FindControl("chkLunT")).Checked = true;
                ((CheckBox)this.gvLista.HeaderRow.Cells[5].FindControl("chkMarT")).Checked = true;
                ((CheckBox)this.gvLista.HeaderRow.Cells[6].FindControl("chkMieT")).Checked = true;
                ((CheckBox)this.gvLista.HeaderRow.Cells[7].FindControl("chkJueT")).Checked = true;
                ((CheckBox)this.gvLista.HeaderRow.Cells[8].FindControl("chkVieT")).Checked = true;
                ((CheckBox)this.gvLista.HeaderRow.Cells[9].FindControl("chkSabT")).Checked = true;
                ((CheckBox)this.gvLista.HeaderRow.Cells[10].FindControl("chkDomT")).Checked = true;

                foreach (GridViewRow registro in this.gvLista.Rows)
                {
                    ((CheckBox)registro.FindControl("chkAsignacion")).Checked = true;
                    ((CheckBox)registro.FindControl("chkLun")).Checked = true;
                    ((CheckBox)registro.FindControl("chkMar")).Checked = true;
                    ((CheckBox)registro.FindControl("chkMie")).Checked = true;
                    ((CheckBox)registro.FindControl("chkJue")).Checked = true;
                    ((CheckBox)registro.FindControl("chkVie")).Checked = true;
                    ((CheckBox)registro.FindControl("chkSab")).Checked = true;
                    ((CheckBox)registro.FindControl("chkDom")).Checked = true;
                }
            }
            else
            {
                foreach (DataRowView registro in programacion.GetProgramacionFuncionariosCuadrilla(Convert.ToString(this.ddlCuadrilla.SelectedValue), Convert.ToString(this.niddlTurno.SelectedValue),
                                        this.CalendarFecha.SelectedDate, Convert.ToInt16(Session["empresa"])))
                {
                    if (Convert.ToInt16(registro.Row.ItemArray.GetValue(3)) == 1)
                    {
                        ((CheckBox)this.gvLista.Rows[i].FindControl("chkAsignacion")).Checked = true;

                        foreach (DataRowView dia in programacion.GetProgramacionFuncionariosDias(this.CalendarFecha.SelectedDate, Convert.ToString(this.niddlTurno.SelectedValue),
                            Convert.ToString(this.ddlCuadrilla.SelectedValue), Convert.ToString(registro.Row.ItemArray.GetValue(0)), Convert.ToInt16(Session["empresa"])))
                        {
                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(1)) == 1)
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkLun")).Checked = true;
                            else
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkLun")).Checked = false;

                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(2)) == 1)
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkMar")).Checked = true;
                            else
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkMar")).Checked = false;

                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(3)) == 1)
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkMie")).Checked = true;
                            else
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkMie")).Checked = false;

                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(4)) == 1)
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkJue")).Checked = true;
                            else
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkJue")).Checked = false;

                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(5)) == 1)
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkVie")).Checked = true;
                            else
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkVie")).Checked = false;

                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(6)) == 1)
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkSab")).Checked = true;
                            else
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkSab")).Checked = false;

                            if (Convert.ToInt16(dia.Row.ItemArray.GetValue(7)) == 1)
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkDom")).Checked = true;
                            else
                                ((CheckBox)this.gvLista.Rows[i].FindControl("chkDom")).Checked = false;
                        }
                    }
                    else
                        ((CheckBox)this.gvLista.Rows[i].FindControl("chkAsignacion")).Checked = false;

                    i++;
                }
            }
            this.lbAsignar.Visible = true;
            this.lbRegistrar.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la programación de funcionarios. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void CargaCombos()
    {
        try
        {
            this.niddlTurno.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nTurno", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.niddlTurno.DataValueField = "codigo";
            this.niddlTurno.DataTextField = "descripcion";
            this.niddlTurno.DataBind();
            this.niddlTurno.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar turnos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlCuadrilla.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nCuadrilla", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlCuadrilla.DataValueField = "codigo";
            this.ddlCuadrilla.DataTextField = "descripcion";
            this.ddlCuadrilla.DataBind();
            this.ddlCuadrilla.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cuadrillas. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er",
            error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                if (!IsPostBack)
                {
                    CargaCombos();
                    ManejarControles();
                }
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void imbCuadrilla_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), "Cuadrillas.aspx", Convert.ToInt16(Session["empresa"])) == 0)
            ManejoError("Usuario no autorizado para acceder a esta página", "C");
        else
            this.Response.Redirect("Cuadrillas.aspx");
    }

    protected void imbTurnos_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), "Turnos.aspx", Convert.ToInt16(Session["empresa"])) == 0)
            ManejoError("Usuario no autorizado para acceder a esta página", "C");
        else
            this.Response.Redirect("Turnos.aspx");
    }

    protected void ddlCuadrilla_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        this.gvExtras.DataSource = null;
        this.gvExtras.DataBind();
        this.lbRegistrarExtras.Visible = false;
        GetProgramacion();
    }

    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.CalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.CalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        this.ddlCuadrilla.Focus();
        this.CalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.CalendarFecha.SelectedDate.ToString();
        this.gvExtras.Visible = false;
        this.gvExtras.DataSource = null;
        this.gvExtras.DataBind();
        this.lbRegistrarExtras.Visible = false;

        GetProgramacion();
    }

    protected void chkLunT_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            ((CheckBox)registro.Cells[4].FindControl("chkLun")).Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void chkMarT_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            ((CheckBox)registro.Cells[5].FindControl("chkMar")).Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void chkMieT_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            ((CheckBox)registro.Cells[6].FindControl("chkMie")).Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void chkJueT_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            ((CheckBox)registro.Cells[7].FindControl("chkJue")).Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void chkVieT_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            ((CheckBox)registro.Cells[8].FindControl("chkVie")).Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void chkSabT_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            ((CheckBox)registro.Cells[9].FindControl("chkSab")).Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void chkDomT_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            ((CheckBox)registro.Cells[10].FindControl("chkDom")).Checked = ((CheckBox)sender).Checked;
        }
    }

    protected void chkAsignacion_CheckedChanged(object sender, EventArgs e)
    {
        ((CheckBox)this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("chkAsignacion", ((CheckBox)sender).ClientID)].Cells[4].FindControl("chkLun")).Checked = ((CheckBox)sender).Checked;
        ((CheckBox)this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("chkAsignacion", ((CheckBox)sender).ClientID)].Cells[5].FindControl("chkMar")).Checked = ((CheckBox)sender).Checked;
        ((CheckBox)this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("chkAsignacion", ((CheckBox)sender).ClientID)].Cells[6].FindControl("chkMie")).Checked = ((CheckBox)sender).Checked;
        ((CheckBox)this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("chkAsignacion", ((CheckBox)sender).ClientID)].Cells[7].FindControl("chkJue")).Checked = ((CheckBox)sender).Checked;
        ((CheckBox)this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("chkAsignacion", ((CheckBox)sender).ClientID)].Cells[8].FindControl("chkVie")).Checked = ((CheckBox)sender).Checked;
        ((CheckBox)this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("chkAsignacion", ((CheckBox)sender).ClientID)].Cells[9].FindControl("chkSab")).Checked = ((CheckBox)sender).Checked;
        ((CheckBox)this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("chkAsignacion", ((CheckBox)sender).ClientID)].Cells[10].FindControl("chkDom")).Checked = ((CheckBox)sender).Checked;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void niddlTurno_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        this.CalendarFecha.Focus();

        this.gvExtras.Visible = false;
        this.gvExtras.DataSource = null;
        this.gvExtras.DataBind();
        this.lbRegistrarExtras.Visible = false;

        GetProgramacion();
    }

    protected void imbExtras_Click(object sender, ImageClickEventArgs e)
    {
        string funcionario = this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("imbExtras", ((ImageButton)sender).ClientID)].Cells[0].Text;
        this.nilblInformacion.Text = funcionario;
    }

    protected void lbRegistroHorasExtra_Click(object sender, EventArgs e)
    {

    }

    protected void lbRegistrarExtras_Click(object sender, EventArgs e)
    {
        GuardarExtras();
    }

    protected void lbAsignar_Click(object sender, ImageClickEventArgs e)
    {
        GetFuncionariosIndividual();
    }

    protected void imbPermisos_Click(object sender, ImageClickEventArgs e)
    {
        string funcionario = this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("imbPermisos", ((ImageButton)sender).ClientID)].Cells[0].Text;
        string nombre = this.gvLista.Rows[CcontrolesUsuario.IndiceControlGrilla("imbPermisos", ((ImageButton)sender).ClientID)].Cells[1].Text;
        string script = "<script language='javascript'>" + "AutorizaPermiso('" + funcionario + "','" + nombre + "','" + Convert.ToString(this.niddlTurno.SelectedValue) + "');" + "</script>";
        Page.RegisterStartupScript("AutorizaPermiso", script);
    }

    protected void imbInformeProgramacion_Click(object sender, ImageClickEventArgs e)
    {
        string script = "<script language='javascript'>" + "Visualizacion('FuncionarioProgramado');" + "</script>";
        Page.RegisterStartupScript("Visualizacion", script);
    }

    protected void imbInformeEntradas_Click(object sender, ImageClickEventArgs e)
    {
        string script = "<script language='javascript'>" + "Visualizacion('PersonalEnPlanta');" + "</script>";
        Page.RegisterStartupScript("Registro", script);
    }

    protected void imbCuadrilla0_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToString(this.niddlTurno.SelectedValue).Length == 0 || Convert.ToString(this.CalendarFecha.SelectedDate).Length == 0 ||
                Convert.ToString(this.ddlCuadrilla.SelectedValue).Length == 0)
        {
            this.nilblInformacion.ForeColor = Color.Red;
            this.nilblInformacion.Text = "Debe seleccionar un turno, la fecha y la cuadrilla";
            return;
        }

        this.gvExtras.Visible = true;
        this.lbRegistrarExtras.Visible = true;
        this.gvLista.Visible = false;
        this.lbRegistrar.Visible = false;
        this.lbAsignar.Visible = false;
        GetEntidadExtras();
    }

    #endregion Eventos





}