using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nomina_Pprogramacion_RegistroInOut : System.Web.UI.Page
{

    #region Instancias

    
    NominaInfos.SeguridadInfos.SecuritySoapClient seguridad = new NominaInfos.SeguridadInfos.SecuritySoapClient();
    CIP ip = new CIP();
    Ccuadrillas cuadrillas = new Ccuadrillas();
    Cdepartamentos departamentos = new Cdepartamentos();
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
    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

            if (nitxtFI.Text.Length == 0 || nitxtFF.Text.Length == 0)
                return;

            selFuncionarios.Visible = false;
            this.gvLista.DataSource = programacion.BuscaRegistros(nitxtBusqueda.Text, Convert.ToDateTime(nitxtFI.Text), Convert.ToDateTime(nitxtFF.Text), Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
                        this.Session["usuario"].ToString(), "C",
                      ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                        this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, "C");
        }
    }
    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        this.selFuncionarios.Visible = false;
        nilblInformacion.Text = "";
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }
    private void CargarCombos()
    {
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

        try
        {
            this.ddlTurno.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nTurno", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlTurno.DataValueField = "codigo";
            this.ddlTurno.DataTextField = "descripcion";
            this.ddlTurno.DataBind();
            this.ddlTurno.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar turnos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.selFuncionarios.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nFuncionario", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.selFuncionarios.DataValueField = "tercero";
            this.selFuncionarios.DataTextField = "descripcion";
            this.selFuncionarios.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar funcionarios. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta";
        bool verificacion = true;
        try
        {

            using (System.Transactions.TransactionScope ts = new System.Transactions.TransactionScope())
            {
                string cuadrilla = null;
                if (rblTipo.SelectedValue == "C")
                    cuadrilla = ddlCuadrilla.SelectedValue;

                if (this.rblOpcion.SelectedValue == "IN")
                    txtFechaSalida.Text = txtFechaEntrada.Text;

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    switch (programacion.GuardaRegistroManual(cuadrilla,
                                Convert.ToDateTime(this.txtFecha.Text), Convert.ToDateTime(this.txtFechaEntrada.Text),
                                Convert.ToDateTime(this.txtFechaSalida.Text), lblCodigo.Text,
                                this.rblOpcion.SelectedValue.ToString(), this.ddlTurno.SelectedValue.ToString(),
                                this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                    {
                        case 1:
                            verificacion = false;
                            break;
                    }
                }
                else
                {
                    for (int x = 0; x < this.selFuncionarios.Items.Count; x++)
                    {
                        if (this.selFuncionarios.Items[x].Selected)
                            verificacion = true;
                    }

                    if (verificacion == false)
                    {
                        this.nilblInformacion.Text = "Debe seleccionar al menos un funcionario para realizar registro";
                        return;
                    }

                    for (int x = 0; x < this.selFuncionarios.Items.Count; x++)
                    {
                        if (this.selFuncionarios.Items[x].Selected == true)
                        {
                            switch (programacion.GuardaRegistroManual(cuadrilla,
                               Convert.ToDateTime(this.txtFecha.Text), Convert.ToDateTime(this.txtFechaEntrada.Text),
                               Convert.ToDateTime(this.txtFechaSalida.Text), this.selFuncionarios.Items[x].Value,
                               this.rblOpcion.SelectedValue.ToString(), this.ddlTurno.SelectedValue.ToString(),
                               this.Session["usuario"].ToString(), Convert.ToInt16(Session["empresa"])))
                            {
                                case 1:
                                    verificacion = false;
                                    break;
                            }
                        }
                    }
                }

                if (verificacion == false)
                    this.nilblInformacion.Text = "Error al insertar el registro. operaci�n no realizada";
                else
                {
                    //nitxtFI.Text = this.txtFecha.Text;
                    //nitxtFF.Text = this.txtFecha.Text;
                    ts.Complete();
                    ManejoExito("Asignaci�n registrada correctamente", "I");
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }
    }

    private void ValidaRegistro()
    {
        //for (int x = 0; x < this.selFuncionarios.Items.Count; x++)
        //{
        //    if (cuadrillas.VerificaFuncionarioCuadrilla(txtCodigo.Text, Convert.ToInt32(selFuncionarios.Items[x].Value), Convert.ToInt16(Session["empresa"])) == 0)
        //        selFuncionarios.Items[x].Selected = true;
        //    else
        //        selFuncionarios.Items[x].Selected = false;
        //}
    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
             ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
            }
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        CargarCombos();
        lblCedula.Text = "";
        lblNombre.Text = "";
        lblCodigo.Text = "";

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.nilblInformacion.Text = "";
        this.selFuncionarios.Visible = false;
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.selFuncionarios.Visible = false;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlTurno.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }
        Guardar();
    }




    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.selFuncionarios.Visible = false;
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.ddlCuadrilla.Enabled = false;
        this.ddlTurno.Enabled = false;
        this.lbFecha.Enabled = false;
        this.txtFechaEntrada.Focus();
        rblTipo.Enabled = false;

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txtFecha.Text = this.gvLista.SelectedRow.Cells[2].Text;
            else
                this.txtFecha.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.ddlTurno.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
            else
                this.ddlTurno.SelectedValue = "";

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                this.lblCedula.Text = this.gvLista.SelectedRow.Cells[5].Text;

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                this.lblCodigo.Text = this.gvLista.SelectedRow.Cells[6].Text;

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                this.lblNombre.Text = this.gvLista.SelectedRow.Cells[7].Text;

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.ddlCuadrilla.SelectedValue = this.gvLista.SelectedRow.Cells[8].Text;
            else
                this.ddlCuadrilla.SelectedValue = "";

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                this.txtFechaEntrada.Text = this.gvLista.SelectedRow.Cells[11].Text;
            else
                this.txtFechaEntrada.Text = "";

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                this.txtFechaSalida.Text = this.gvLista.SelectedRow.Cells[12].Text;
            else
                this.txtFechaSalida.Text = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";

        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

           object[] objValores = new object[] { Convert.ToInt16(Session["empresa"]), Convert.ToDateTime(this.gvLista.Rows[e.RowIndex].Cells[2].Text) ,
             Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[6].Text), Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[3].Text)};

            if (cuadrillas.EliminaFunncionarios(Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(Session["empresa"])) == 0)
            {
                if (CentidadMetodos.EntidadInsertUpdateDelete("nProgramacion", operacion, "ppa", objValores) == 0)
                    ManejoExito("Registro eliminado satisfactoriamente", "E");
            }
            else
                ManejoError("Errores al eliminar el registro. Operaci�n no realizada", "E");


        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El c�digo ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociaci�n, no es posible eliminar el registro.", "E");
            }
            else
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFecha.Text);
        }
        catch (Exception ex)
        {
            nilblInformacion.Text = "Formato de fecha no valido";
            txtFecha.Focus();
            txtFecha.Text = "";
            return;
        }

        if (ddlTurno.SelectedValue.Trim().Length > 0)
        {
            this.txtFechaEntrada.Text = Convert.ToDateTime(txtFecha.Text).ToString();
            int horaInicio = Convert.ToInt32(ddlTurno.SelectedItem.Text.Substring(12, ddlTurno.SelectedItem.Text.Length));
            txtFechaEntrada.Text = Convert.ToDateTime(txtFechaEntrada).AddHours(horaInicio).ToString();
        }
        else
        {
            nilblInformacion.Text = "Debe seleccionar un turno";
            ddlTurno.Focus();
            return;
        }

    }

    #endregion Eventos

    #region MetodosFuncionario




    #endregion MetodosFuncionario

    #region EventosFuncionario


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;

        if (nitxtFI.Text.Length == 0 || nitxtFF.Text.Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar fecha inicial y fecha final para la busqueda";
            return;
        }

        GetEntidad();
    }

    protected void gvAsignacion_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        CargarCombos();
        gvLista.DataBind();
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void niCalendarFI_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFI.Visible = false;
        this.nitxtFI.Visible = true;
        this.nitxtFI.Text = this.niCalendarFI.SelectedDate.ToShortDateString();
    }
    protected void niCalendarFF_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFF.Visible = false;
        this.nitxtFF.Visible = true;
        this.nitxtFF.Text = this.niCalendarFF.SelectedDate.ToShortDateString();
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        if (ddlTurno.SelectedValue.Trim().Length > 0)
        {
            this.CalendarFecha.Visible = false;
            this.txtFecha.Visible = true;
            this.txtFecha.Text = this.CalendarFecha.SelectedDate.ToShortDateString();
            this.txtFechaEntrada.Text = this.CalendarFecha.SelectedDate.ToString();
            this.txtFecha.Visible = true;
            this.txtFechaEntrada.Focus();
            int inicio = ddlTurno.SelectedItem.Text.IndexOf("Hora inicio:	") + "Hora inicio:	".Length;
            string numero = ddlTurno.SelectedItem.Text.Substring(inicio, 2);
            int horaInicio = Convert.ToInt32(numero);
            DateTime fecha = Convert.ToDateTime(txtFecha.Text);
            fecha=fecha.AddHours(Convert.ToDouble(numero));
            txtFechaEntrada.Text = fecha.ToString("dd/MM/yyy HH:mm:ss");


        }
        else
        {
            nilblInformacion.Text = "Debe seleccionar un turno para continuar";
            ddlTurno.Focus();
        }



    }
    protected void CalendarFechaOut_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaOut.Visible = false;
        this.txtFechaSalida.Visible = true;
        this.txtFechaSalida.Text = this.CalendarFechaOut.SelectedDate.ToString();
        this.txtFechaSalida.Focus();
    }
    protected void ddlCuadrilla_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (this.ddlCuadrilla.SelectedValue != "")
            {
                selFuncionarios.Visible = true;
                //selFuncionarios.Enabled = true;
                try
                {
                    this.selFuncionarios.DataSource = cuadrillas.GetFuncionariosCuadrilla(this.ddlCuadrilla.SelectedValue.ToString(), Convert.ToInt16(Session["empresa"]));
                    this.selFuncionarios.DataValueField = "codigo";
                    this.selFuncionarios.DataTextField = "descripcion";
                    this.selFuncionarios.DataBind();

                }
                catch (Exception ex)
                {
                    ManejoError("Error al cargar funcionarios. Correspondiente a: " + ex.Message, "C");
                }
            }
            else
                this.nilblInformacion.Text = "Seleccione una cuadrilla";
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar funcionarios debido a:" + ex;
        }
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblTipo.SelectedValue == "C")
        {
            try
            {
                this.ddlCuadrilla.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nCuadrilla", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
                this.ddlCuadrilla.DataValueField = "codigo";
                this.ddlCuadrilla.DataTextField = "descripcion";
                this.ddlCuadrilla.DataBind();
                this.ddlCuadrilla.Items.Insert(0, new ListItem("Seleccione una opci�n", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar cuadrillas. Correspondiente a: " + ex.Message, "C");
            }

            selFuncionarios.Visible = false;
            ddlCuadrilla.Enabled = true;
        }
        else
        {
            selFuncionarios.Visible = true;
            GetFuncionariosIndividual();
            ddlCuadrilla.Enabled = false;
        }
    }

    private void GetFuncionariosIndividual()
    {
        try
        {

            this.selFuncionarios.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nFuncionario", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.selFuncionarios.DataValueField = "tercero";
            this.selFuncionarios.DataTextField = "descripcion";
            this.selFuncionarios.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar funcionarios sin programaci�n. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void nilbFI_Click(object sender, EventArgs e)
    {
        this.niCalendarFI.Visible = true;
        this.nitxtFI.Visible = false;
        this.niCalendarFI.SelectedDate = Convert.ToDateTime(null);
    }
    protected void nilbFF_Click(object sender, EventArgs e)
    {
        this.niCalendarFF.Visible = true;
        this.nitxtFF.Visible = false;
        this.niCalendarFF.SelectedDate = Convert.ToDateTime(null);
    }
    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.CalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.CalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }
    protected void lbFechaOut_Click(object sender, EventArgs e)
    {
        this.CalendarFechaOut.Visible = true;
        this.txtFechaSalida.Visible = false;
        this.CalendarFechaOut.SelectedDate = Convert.ToDateTime(null);
    }
    protected void lblFechaEntrada_Click(object sender, EventArgs e)
    {
        this.CalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.CalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }
    protected void rblEmpresa_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.rblOpcion.SelectedValue == "IN")
        {
            this.txtFechaSalida.Enabled = false;
            lblFechaSalida.Enabled = false;
            txtFechaSalida.Text = txtFechaEntrada.Text;
        }
        else
        {
            this.txtFechaSalida.Enabled = true;
            lblFechaSalida.Enabled = true;
        }
    }

    #endregion EventosFuncionario

}
