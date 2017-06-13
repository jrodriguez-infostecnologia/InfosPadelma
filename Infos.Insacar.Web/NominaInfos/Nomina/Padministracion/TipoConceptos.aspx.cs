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
using System.Transactions;

public partial class Contabilidad_Padministracion_IR : System.Web.UI.Page
{
    #region Instancias



    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cconceptos conceptos = new Cconceptos();
    CtipoConcepto tipoConcepto = new CtipoConcepto();
    CIP ip = new CIP();


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
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            this.selConceptos.DataSource = null;
            this.selConceptos.DataBind();
            selConceptos.Visible = false;

            this.gvLista.DataSource = tipoConcepto.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C", ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
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
            error, ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;
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
            selConceptos.Visible = true;
            this.selConceptos.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.selConceptos.DataValueField = "codigo";
            this.selConceptos.DataTextField = "descripcion";
            this.selConceptos.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los IR correspondiente a: " + ex.Message, "C");
        }

    }

    private void ValidaRegistro()
    {

        for (int x = 0; x < selConceptos.Items.Count; x++)
        {

            if (tipoConcepto.VerificaTipoConcepto(txtCodigo.Text, selConceptos.Items[x].Value, Convert.ToInt16(Session["empresa"])) == 0)
                selConceptos.Items[x].Selected = true;
            else
                selConceptos.Items[x].Selected = false;
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey("nTipoConcepto", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Código " + this.txtCodigo.Text + " ya se encuentra registrado";
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                this.nilbNuevo.Visible = true;
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

        if (this.txtDescripcion.Text.Length == 0 || this.txtCodigo.Text.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
        }
        else
        {
            try
            {
                using (TransactionScope ts = new TransactionScope())
                {

                    if (Convert.ToBoolean(this.Session["editar"]) == true)
                        operacion = "actualiza";

                    object[] objValores = new object[]{
                    chkActivo.Checked,
                    this.txtCodigo.Text,
                    this.txtDescripcion.Text,
                    Convert.ToInt16(Session["empresa"])
                };

                    switch (CentidadMetodos.EntidadInsertUpdateDelete("nTipoConcepto", operacion, "ppa", objValores))
                    {
                        case 0:
                            if (Convert.ToBoolean(this.Session["editar"]) == true)
                            {
                                for (int x = 0; x < selConceptos.Items.Count; x++)
                                {
                                    if (tipoConcepto.VerificaTipoConcepto(txtCodigo.Text, selConceptos.Items[x].Value, Convert.ToInt16(Session["empresa"])) == 0)
                                    {
                                        if (selConceptos.Items[x].Selected == false)
                                        {
                                            object[] objValoresConcepto = new object[]{
                                                        selConceptos.Items[x].Value,
                                                        Convert.ToInt16(Session["empresa"]),
                                                        this.txtCodigo.Text};

                                            switch (CentidadMetodos.EntidadInsertUpdateDelete("nTipoConceptoDetalle", "elimina", "ppa", objValoresConcepto))
                                            {
                                                case 1:
                                                    verificacion = true;
                                                    break;
                                            }
                                        }
                                    }
                                    else
                                    {
                                        if (selConceptos.Items[x].Selected == true)
                                        {
                                            object[] objValoresConcepto = new object[]{
                                                        selConceptos.Items[x].Value,
                                                        Convert.ToInt16(Session["empresa"]),
                                                        this.txtCodigo.Text};

                                            switch (CentidadMetodos.EntidadInsertUpdateDelete("nTipoConceptoDetalle", "inserta", "ppa", objValoresConcepto))
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
                                for (int x = 0; x < selConceptos.Items.Count; x++)
                                {
                                    if (selConceptos.Items[x].Selected == true)
                                    {

                                        object[] objValoresConcepto = new object[]{
                                                        selConceptos.Items[x].Value,
                                                        Convert.ToInt16(Session["empresa"]),
                                                        this.txtCodigo.Text};

                                        switch (CentidadMetodos.EntidadInsertUpdateDelete("nTipoConceptoDetalle", operacion, "ppa", objValoresConcepto))
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
                            verificacion = true;
                            break;
                    }

                    if (verificacion == true)
                    {
                        this.nilblInformacion.Text = "Error al insertar el detalle de la transacción. Operación no realizada";
                        return;
                    }
                    ManejoExito("Transacción registrada satisfactoriamente.", "I");
                    ts.Complete();
                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
            }
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
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
                this.txtCodigo.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbNuevo_Click(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();

        this.txtDescripcion.Enabled = true;
        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.selConceptos.DataSource = null;
        this.selConceptos.DataBind();
        selConceptos.Visible = false;

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.selConceptos.Visible = false;
        this.selConceptos.DataSource = null;
        this.selConceptos.DataBind();
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
        chkActivo.Focus();
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            object[] objValores = new object[] {
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text),
                Convert.ToInt16(Session["empresa"])
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("nTipoConcepto", "elimina", "ppa", objValores))
            {
                case 0:
                    if (tipoConcepto.EliminaConceptosdelTipo(Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(Session["empresa"])) == 0)
                        ManejoExito("Registro eliminado satisfactoriamente", "E");

                    break;

                case 1:

                    ManejoError("Error al eliminar el registro. Operación no realizada", "E");
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        bool swValida = false;
        for (int x = 0; x < selConceptos.Items.Count; x++)
        {
            if (selConceptos.Items[x].Selected == true)
                swValida = true;
        }

        if (swValida == false)
        {
            nilblInformacion.Text = "Debe seleccionar por lo menos un Imp/Rete";
            return;
        }

        Guardar();
    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        selConceptos.Visible = true;
        CargarCombos();
        this.txtCodigo.Enabled = false;
        this.txtDescripcion.Focus();

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
                ValidaRegistro();
            }
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            else
                this.txtDescripcion.Text = "";



            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[4].Controls)
                {
                    if (objControl is CheckBox)
                        this.chkActivo.Checked = ((CheckBox)objControl).Checked;
                }
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }


    #endregion Eventos



}
