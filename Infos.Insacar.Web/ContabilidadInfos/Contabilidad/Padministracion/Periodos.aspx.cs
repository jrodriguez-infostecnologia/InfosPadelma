using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    Cperiodos periodos = new Cperiodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    ADInfos.AccesoDatos CentidadMetodos = new ADInfos.AccesoDatos();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";
    #endregion Instancias

    #region Metodos

    private void OpcionesDefecto()
    {
        this.nilblOperacion.Text = "";
        this.nilblOperacion.Visible = false;
        this.niddlAno.Visible = false;
        this.nilbEjecutar.Visible = false;
        this.nilblCancelar.Visible = false;
        this.nitxtAno.Visible = false;
        this.nichkCerrarAño.Visible = false;
    }

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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                         nombrePaginaActual(), consulta, Convert.ToInt16(this.Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", consulta);
                return;
            }
            this.gvLista.DataSource = periodos.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(this.Session["empresa"]));
            this.gvLista.DataBind();
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
            seguridad.InsertaLog(this.Session["usuario"].ToString(), consulta, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
               "ex", this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
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
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
      "er", error, ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
        this.Response.Redirect("~/Contabilidad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
               "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.niddlAno.DataSource = periodos.GetAnosPeriodos();
            this.niddlAno.DataValueField = "año";
            this.niddlAno.DataTextField = "año";
            this.niddlAno.DataBind();
            this.niddlAno.Items.Insert(0, new ListItem("", "Seleccione una opción"));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar años. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        if (txvAño.Text.Length == 0 || ddlMes.Text.Length == 0)
            return;
        object[] objKey = new object[] { this.txvAño.Text, Convert.ToInt16(this.Session["empresa"]), ddlMes.Text };
        try
        {
            if (CentidadMetodos.EntidadGetKey("cPeriodo", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Periodo " + this.txvAño.Text + " ya se encuentra registrado";
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                this.nilbNuevo.Visible = true;
                this.txvAño.Text = "";
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta";
        DateTime fechaInicial = new DateTime(), fechaFinal = new DateTime();

        try
        {
            Convert.ToInt16(this.txvAño.Text);
        }
        catch
        {
            nilblMensaje.Text = "año debe ser un numero";
            return;
        }
        try
        {
            fechaFinal = Convert.ToDateTime(txtFechaFinal.Text);
            fechaInicial = Convert.ToDateTime(txtFechaIni.Text);

        }
        catch
        {
            nilblInformacion.Text = "Formato de fecha no validas por favor corrija";
            return;

        }

        if (txtFechaIni.Text.Length == 0 || txtFechaFinal.Text.Length == 0)

            if (fechaInicial.Year != Convert.ToInt16(txvAño.Text))
            {
                nilblInformacion.Text = "La fecha inicial debe pertenecer al mismo año del seleccionado";
                return;
            }

        if (fechaInicial > fechaFinal)
        {
            nilblInformacion.Text = "La fecha inicial debe ser menor a la fecha final";
            return;
        }

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            object[] objValores = new object[]{   
                Convert.ToInt16(this.txvAño.Text),
                this.chkCerrado.Checked,
                Convert.ToInt16(this.Session["empresa"]),
                Convert.ToDateTime(txtFechaFinal.Text),  
                Convert.ToDateTime(txtFechaIni.Text),  
                Convert.ToInt16(this.ddlMes.Text )             
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("cPeriodo", operacion, "ppa", objValores))
            {
                case 0:
                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                    break;
                case 1:
                    ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }
    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();
                this.nitxtBusqueda.Focus();
                if (this.txvAño.Text.Length > 0)
                    this.chkCerrado.Focus();
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbNuevo_Click(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                              nombrePaginaActual(), insertar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", insertar);
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();
        this.txvAño.Enabled = true;
        this.txvAño.Focus();
        this.nilblInformacion.Text = "";
        this.niddlAno.Visible = false;
        this.nilbEjecutar.Visible = false;
        this.nilblOperacion.Visible = false;
        this.nilblCancelar.Visible = false;
        this.nitxtAno.Visible = false;
        this.nichkCerrarAño.Visible = false;

    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.nitxtAno.Visible = false;
        this.niddlAno.Visible = false;
        this.nilblMensaje.Text = "";
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                             nombrePaginaActual(), editar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.nilblOperacion.Visible = false;
        this.niddlAno.Visible = false;
        this.nitxtAno.Visible = false;
        this.nichkCerrarAño.Visible = false;
        this.nilblCancelar.Visible = false;
        this.nilbEjecutar.Visible = false;
        this.nilblMensaje.Text = "";
        this.txvAño.Enabled = false;
        this.chkCerrado.Focus();

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txvAño.Text = this.gvLista.SelectedRow.Cells[2].Text;
            else
                this.txvAño.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.ddlMes.Text = this.gvLista.SelectedRow.Cells[3].Text;

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                txtFechaIni.Text = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text)).ToShortDateString();

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                txtFechaFinal.Text = Convert.ToDateTime(Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text)).ToShortDateString();

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
            {
                if (objControl is CheckBox)
                    this.chkCerrado.Checked = ((CheckBox)objControl).Checked;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                              nombrePaginaActual(), eliminar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", eliminar);
            return;
        }

        string operacion = "elimina";
        try
        {
            object[] objValores = new object[] { Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(this.Session["empresa"]), Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[3].Text) };

            if (CentidadMetodos.EntidadInsertUpdateDelete("cPeriodo", operacion, "ppa", objValores) == 0)
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            else
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void nilbAbrirAnos_Click(object sender, EventArgs e)
    {
        this.nilblOperacion.Text = "Seleccione el año que desea abrir";
        this.nilblOperacion.Visible = true;
        this.niddlAno.Visible = true;
        this.nilbEjecutar.Visible = true;
        this.nilblCancelar.Visible = true;
        this.nitxtAno.Visible = false;
        this.nichkCerrarAño.Visible = true;
        this.niddlAno.Focus();
        this.nilblMensaje.Text = "";
        this.nichkCerrarAño.Enabled = true;
        CcontrolesUsuario.InhabilitarControles(Page.Controls);
        this.Session["opcion"] = "abrir";
        CargarCombos();
    }


    protected void nilbEjecutar_Click(object sender, ImageClickEventArgs e)
    {
        int conteo = 0;
        try
        {
            switch (this.Session["opcion"].ToString())
            {
                case "abrir":
                    if (periodos.AbrirCerrarPeriodosAno(Convert.ToInt16(this.niddlAno.SelectedValue), Convert.ToInt16(this.Session["empresa"]), out conteo, nichkCerrarAño.Checked) == 0)
                    {
                        if (!chkCerrado.Checked)
                            ManejoExito("Peridos abiertos satisfactoriamente. " + conteo.ToString() + " registros afectados", "A");
                        else
                            ManejoExito("Peridos cerrados satisfactoriamente. " + conteo.ToString() + " registros afectados", "A");
                    }
                    else
                        ManejoError("Error al abrir/cerrar los periodos. Operación no realizada", "A");
                    break;
                case "eliminar":
                    if (periodos.EliminarPeriodosAno(Convert.ToInt16(this.nitxtAno.Text), Convert.ToInt16(this.Session["empresa"])) == 0)
                        ManejoExito("Peridos eliminados satisfactoriamente.", "E");
                    else
                        ManejoError("Error al eliminar los periodos. Operación no realizada", "E");
                    break;
            }
            OpcionesDefecto();
        }
        catch (Exception ex)
        {
            ManejoError("Error al ejecutar la operación seleccionada. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void nilbCerrarPeriodosAno_Click(object sender, EventArgs e)
    {
        this.nilblOperacion.Text = "Seleccione el año que desea cerrar";
        this.nilblOperacion.Visible = true;
        this.niddlAno.Visible = true;
        this.nilbEjecutar.Visible = true;
        this.nilblCancelar.Visible = true;
        this.nitxtAno.Visible = false;
        this.niddlAno.Focus();
        this.nilblMensaje.Text = "";
        this.nichkCerrarAño.Enabled = true;
        this.nichkCerrarAño.Visible = true;
        this.Session["opcion"] = "cerrar";
        CargarCombos();
    }

    protected void lbEliminarPeriodos_Click(object sender, EventArgs e)
    {
        this.nilblOperacion.Text = "Digite el año que desea eliminar";
        this.nilblOperacion.Visible = true;
        this.niddlAno.Visible = false;
        this.nilbEjecutar.Visible = true;
        this.nilblCancelar.Visible = true;
        this.nitxtAno.Visible = true;
        this.nitxtAno.Focus();
        this.nichkCerrarAño.Visible = false;
        this.nilblMensaje.Text = "";
        this.Session["opcion"] = "eliminar";
        CargarCombos();
    }

    protected void nilblCancelar_Click(object sender, EventArgs e)
    {
        OpcionesDefecto();
    }

    #endregion Eventos

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    protected void CalendarFechaIni_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaIni.Visible = false;
        this.txtFechaIni.Visible = true;
        this.txtFechaIni.Text = this.CalendarFechaIni.SelectedDate.ToShortDateString();
        this.txtFechaIni.Enabled = true;
    }
    protected void CalendarFechaFinal_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = false;
        this.txtFechaFinal.Visible = true;
        this.txtFechaFinal.Text = this.CalendarFechaFinal.SelectedDate.ToShortDateString();
        this.txtFechaFinal.Enabled = true;
    }
    protected void lbFechaFinal_Click(object sender, EventArgs e)
    {
        this.CalendarFechaFinal.Visible = true;
        this.txtFechaFinal.Visible = false;
        this.CalendarFechaFinal.SelectedDate = Convert.ToDateTime(null);
    }
    protected void lbFechaIni_Click(object sender, EventArgs e)
    {
        this.CalendarFechaIni.Visible = true;
        this.txtFechaIni.Visible = false;
        this.CalendarFechaIni.SelectedDate = Convert.ToDateTime(null);
    }

}
