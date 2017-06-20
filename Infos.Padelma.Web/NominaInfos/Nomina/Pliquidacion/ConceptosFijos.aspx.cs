using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_ConceptosFijos : System.Web.UI.Page
{

    #region Instancias


    NominaInfos.SeguridadInfos.SecuritySoapClient seguridad = new NominaInfos.SeguridadInfos.SecuritySoapClient();
    CIP ip = new CIP();


    CconceptosFijos conceptosFijos = new CconceptosFijos();
    Cdepartamentos departamentos = new Cdepartamentos();
    Cperiodos periodoNomina = new Cperiodos();

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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }
            selConceptos.Visible = false;
            this.gvLista.DataSource = conceptosFijos.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));

            this.gvLista.DataBind();

            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C",
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
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;
        this.ddlCentroCosto.Enabled = true;
        this.selConceptos.Visible = false;

        seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              operacion,
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex",
              mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }
    private void CargarCombos()
    {
        try
        {
            DataView dvCcosto = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cCentrosCosto", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvCcosto.RowFilter = "empresa =" + Convert.ToInt16(Session["empresa"]).ToString() + " and  auxiliar=1";
            this.ddlCentroCosto.DataSource = dvCcosto;
            this.ddlCentroCosto.DataValueField = "codigo";
            this.ddlCentroCosto.DataTextField = "descripcion";
            this.ddlCentroCosto.DataBind();
            this.ddlCentroCosto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar departamentos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlA�o.DataSource = periodoNomina.PeriodoA�oAbiertoNomina(Convert.ToInt16(Session["empresa"]));
            this.ddlA�o.DataValueField = "a�o";
            this.ddlA�o.DataTextField = "a�o";
            this.ddlA�o.DataBind();
            this.ddlA�o.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�o. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.selConceptos.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.selConceptos.DataValueField = "codigo";
            this.selConceptos.DataTextField = "descripcion";
            this.selConceptos.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar funcionarios. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void EntidadKey()
    {
        object[] objKey = new object[] { ddlA�o.SelectedValue, ddlCentroCosto.SelectedValue, Convert.ToInt16(Session["empresa"]), ddlMes.SelectedValue, ddlPeriodo.SelectedValue };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "nConceptosFijos",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Ya se encuentra registrada la combinaci�n";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

                this.nilbNuevo.Visible = true;
                this.selConceptos.DataSource = null;
                this.selConceptos.DataBind();
                this.selConceptos.Visible = false;
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
        bool verificacion = false;
        try
        {

            using (System.Transactions.TransactionScope ts = new System.Transactions.TransactionScope())
            {
                for (int x = 0; x < this.selConceptos.Items.Count; x++)
                {
                    if (this.selConceptos.Items[x].Selected)
                        verificacion = true;
                }

                if (verificacion == false)
                {
                    this.nilblInformacion.Text = "Debe seleccionar al menos un funcionario para realizar la asignaci�n";
                    return;
                }

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                    operacion = "actualiza";

                object[] objValores = new object[]{
                false,
                ddlA�o.SelectedValue,
                ddlCentroCosto.SelectedValue,
                Convert.ToInt16(Session["empresa"]),
                DateTime.Now,
                ddlFomaPago.SelectedValue,
                chkLausentismo.Checked,
                chkLDomingos.Checked,
                chkLDomingoCero.Checked,
                chkLembargos.Checked,
                chkLFestivos.Checked,
                chkLFondavi.Checked,
                chkLhoras.Checked,
                false,
                chkLnovedades.Checked,
                chkNovedadesCredito.Checked,
                chkLotros.Checked,
                chkLprestamos.Checked,
                chkLPrimas.Checked,
                chkLiquidaSindicato.Checked,
                chkLvacaciones.Checked,
                chkMuestraDomingo.Checked,
                ddlMes.SelectedValue,
                ddlPeriodo.SelectedValue,
                 HttpUtility.HtmlEncode(txtObservacion.Text),
                Session["usuario"].ToString()

            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nConceptosFijos", operacion, "ppa", objValores))
                {
                    case 0:
                        if (Convert.ToBoolean(this.Session["editar"]) == true)
                        {
                            for (int x = 0; x < this.selConceptos.Items.Count; x++)
                            {
                                if (conceptosFijos.VerificaConceptosFijos(ddlCentroCosto.SelectedValue, Convert.ToInt32(ddlA�o.SelectedValue), Convert.ToInt32(ddlMes.SelectedValue),
                                    Convert.ToInt32(ddlPeriodo.SelectedValue), selConceptos.Items[x].Value, Convert.ToInt16(Session["empresa"])) == 0)
                                {
                                    if (this.selConceptos.Items[x].Selected == false)
                                    {

                                        object[] objValoresConcepto = new object[]{
                                                        ddlA�o.SelectedValue,                                                        
                                                        ddlCentroCosto.SelectedValue,
                                                        this.selConceptos.Items[x].Value,
                                                        Convert.ToInt16(Session["empresa"]),
                                                        ddlMes.SelectedValue,
                                                        ddlPeriodo.SelectedValue      
                                                          };

                                        switch (CentidadMetodos.EntidadInsertUpdateDelete("nConceptosFijosDetalle", "elimina", "ppa", objValoresConcepto))
                                        {
                                            case 1:
                                                verificacion = true;
                                                break;
                                        }

                                    }

                                }
                                else
                                {
                                    if (this.selConceptos.Items[x].Selected == true)
                                    {

                                        object[] objValoresConcepto = new object[]{
                                                        ddlA�o.SelectedValue,   
                                                        ddlCentroCosto.SelectedValue,
                                                          this.selConceptos.Items[x].Value,
                                                        Convert.ToInt16(Session["empresa"]),
                                                        ddlMes.SelectedValue,
                                                        ddlPeriodo.SelectedValue  };

                                        switch (CentidadMetodos.EntidadInsertUpdateDelete("nConceptosFijosDetalle", "inserta", "ppa", objValoresConcepto))
                                        {
                                            case 1:
                                                verificacion = true;
                                                break;
                                        }

                                    }
                                }
                            }
                        }
                        else
                        {
                            for (int x = 0; x < this.selConceptos.Items.Count; x++)
                            {
                                if (this.selConceptos.Items[x].Selected == true)
                                {

                                    object[] objValoresConcepto = new object[]{
                                                       ddlA�o.SelectedValue,                                                   
                                                        ddlCentroCosto.SelectedValue,
                                                             this.selConceptos.Items[x].Value,
                                                        Convert.ToInt16(Session["empresa"]),
                                                        ddlMes.SelectedValue,
                                                        ddlPeriodo.SelectedValue   };

                                    switch (CentidadMetodos.EntidadInsertUpdateDelete("nConceptosFijosDetalle", operacion, "ppa", objValoresConcepto))
                                    {
                                        case 1:
                                            verificacion = true;
                                            break;
                                    }
                                }
                            }
                        }

                        break;

                    case 1:
                        verificacion = false;
                        break;
                }

                if (verificacion == false)
                    this.nilblInformacion.Text = "Error al insertar el registro. operaci�n no realizada";
                else
                {
                    ManejoExito("Asignaci�n registrada correctamente", "I");
                    ts.Complete();
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
        for (int x = 0; x < this.selConceptos.Items.Count; x++)
        {
            if (conceptosFijos.VerificaConceptosFijos(ddlCentroCosto.SelectedValue, Convert.ToInt32(ddlA�o.SelectedValue), Convert.ToInt32(ddlMes.SelectedValue),
                Convert.ToInt32(ddlPeriodo.SelectedValue), selConceptos.Items[x].Value, Convert.ToInt16(Session["empresa"])) == 0)
                selConceptos.Items[x].Selected = true;
            else
                selConceptos.Items[x].Selected = false;
        }
    }
    protected void cargarMes()
    {
        try
        {
            this.ddlMes.DataSource = periodoNomina.PeriodoMesAbiertoNomina(Convert.ToInt16(ddlA�o.SelectedValue), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
            this.ddlMes.DataValueField = "mes";
            this.ddlMes.DataTextField = "descripcion";
            this.ddlMes.DataBind();
            this.ddlMes.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar mes. Correspondiente a: " + ex.HResult.ToString()+ " - " + ex.Message, "C");
        }
    }

    protected void cargarPeriodo()
    {
        try
        {
            this.ddlPeriodo.DataSource = periodoNomina.PeriodosAbiertoNomina(Convert.ToInt16(ddlA�o.SelectedValue), Convert.ToInt16(ddlMes.SelectedValue), Convert.ToInt16(Session["empresa"])).Tables[0].DefaultView;
            this.ddlPeriodo.DataValueField = "noPeriodo";
            this.ddlPeriodo.DataTextField = "descripcion";
            this.ddlPeriodo.DataBind();
            this.ddlPeriodo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar periodos. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Metodos

    #region Eventos



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
    protected void ddlA�o_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlA�o.SelectedValue.Length != 0)
        {
            cargarMes();
        }
        else
        {
            ddlMes.DataSource = null;
            ddlMes.DataBind();
        }

        if (ddlCentroCosto.SelectedValue.Trim().Length > 0 & ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlA�o.SelectedValue.Trim().Length > 0
            & ddlMes.SelectedValue.Trim().Length > 0)
        {
            EntidadKey();
        }
    }
    protected void ddlMes_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlMes.SelectedValue.Length != 0)
        {
            cargarPeriodo();
        }
        else
        {
            ddlPeriodo.DataSource = null;
            ddlPeriodo.DataBind();
        }

        if (ddlCentroCosto.SelectedValue.Trim().Length > 0 & ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlA�o.SelectedValue.Trim().Length > 0
           & ddlMes.SelectedValue.Trim().Length > 0)
        {
            EntidadKey();
        }
    }
    protected void ddlCentroCosto_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCentroCosto.SelectedValue.Trim().Length > 0 & ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlA�o.SelectedValue.Trim().Length > 0
            & ddlMes.SelectedValue.Trim().Length > 0)
        {
            EntidadKey();
        }
    }
    protected void ddlPeriodo_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlCentroCosto.SelectedValue.Trim().Length > 0 & ddlPeriodo.SelectedValue.Trim().Length > 0 & ddlA�o.SelectedValue.Trim().Length > 0
           & ddlMes.SelectedValue.Trim().Length > 0)
        {
            EntidadKey();
        }
    }

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
                this.ddlCentroCosto.Focus();

                //if (!IsPostBack)
                //{
                //    CargarCombos();
                //}
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
            }
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                          ConfigurationManager.AppSettings["Modulo"].ToString(),
                           nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = null;
        this.ddlCentroCosto.Focus();
        this.nilblInformacion.Text = "";
        this.selConceptos.Visible = true;


    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.ddlCentroCosto.Enabled = true;
        this.selConceptos.Visible = false;
        this.Session["editar"] = null;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlCentroCosto.SelectedValue.Length == 0 || ddlA�o.SelectedValue.Length == 0 || ddlMes.SelectedValue.Length == 0 || ddlPeriodo.SelectedValue.Length == 0)
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

        this.selConceptos.Visible = true;
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.ddlCentroCosto.Enabled = false;
        ddlCentroCosto.Enabled = false;
        ddlA�o.Enabled = false;
        ddlMes.Enabled = false;
        ddlPeriodo.Enabled = false;

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.ddlCentroCosto.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.ddlA�o.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;

                if (ddlA�o.SelectedValue.Length != 0)
                    cargarMes();
            }
            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                if (ddlA�o.SelectedValue.Length != 0)
                    this.ddlMes.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text;

                if (ddlMes.SelectedValue.Length != 0)
                    cargarPeriodo();

            }
            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                if (ddlMes.SelectedValue.Length != 0)
                    this.ddlPeriodo.SelectedValue = this.gvLista.SelectedRow.Cells[6].Text;
            }
            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                this.ddlFomaPago.SelectedValue = this.gvLista.SelectedRow.Cells[7].Text;

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.txtObservacion.Text = HttpUtility.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);

            ValidaRegistro();

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLnovedades.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLprestamos.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[13].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLhoras.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[14].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLvacaciones.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[15].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLPrimas.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[16].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLausentismo.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[17].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLembargos.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[18].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLotros.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[19].Controls)
            {
                if (objControl is CheckBox)
                    this.chkNovedadesCredito.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[20].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLFondavi.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[21].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLDomingos.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[22].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLFestivos.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[23].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLDomingoCero.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[24].Controls)
            {
                if (objControl is CheckBox)
                    this.chkMuestraDomingo.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[25].Controls)
            {
                if (objControl is CheckBox)
                    this.chkLiquidaSindicato.Checked = ((CheckBox)objControl).Checked;
            }

        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString()=="-2146233086")
                ManejoError("Error al cargar los campos debido a: el periodo se encuentra cerrado", "C");
            else
                ManejoError("Error al cargar los campos correspondiente a: " + ex.HResult.ToString()+ " - " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";

        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                                       nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }


            object[] objValores = new object[] { 
                Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[4].Text),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), 
                                Convert.ToInt16(Session["empresa"]),
                Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[5].Text), 
                Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[6].Text)
            };

            if (conceptosFijos.EliminaConceptosFijos(Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[4].Text),
                Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[5].Text), Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[6].Text), Convert.ToInt16(Session["empresa"])) == 0)
            {
                if (CentidadMetodos.EntidadInsertUpdateDelete("nConceptosFijos", operacion, "ppa", objValores) == 0)
                {
                    ManejoExito("Registro eliminado satisfactoriamente", "E");
                }
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operaci�n no realizada", "E");

            }

        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El c�digo ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociaci�n, no es posible eliminar el registro.", "E");
            }
            else
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }



    protected void nilblListado_Click(object sender, EventArgs e)
    {
        Response.Redirect("ListadoDestinos.aspx");
    }


    protected void txtCodigo_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void nilbRegresar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("Programacion.aspx");
    }

    #endregion Eventos

    #region MetodosFuncionario




    #endregion MetodosFuncionario

    #region EventosFuncionario


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
           this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    #endregion EventosFuncionario


}
