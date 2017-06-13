using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_Cuadrillas : System.Web.UI.Page
{

    #region Instancias

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();


    Ccuadrillas cuadrillas = new Ccuadrillas();
    Cdepartamentos departamentos = new Cdepartamentos();

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }


    private void Consecutivo()
    {
        try
        {
            this.txtCodigo.Text = cuadrillas.Consecutivo(
                Convert.ToString(this.ddlDepartamento.SelectedValue), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el consecutivo. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }
            selFuncionarios.Visible = false;
            this.gvLista.DataSource = cuadrillas.BuscarEntidad(
                Convert.ToString(this.ddlDepartamento.SelectedValue), Convert.ToInt16(Session["empresa"]));

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
        this.ddlDepartamento.Enabled = true;
        this.selFuncionarios.Visible = false;

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
            this.ddlDepartamento.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nDepartamento", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlDepartamento.DataValueField = "codigo";
            this.ddlDepartamento.DataTextField = "cadena";
            this.ddlDepartamento.DataBind();
            this.ddlDepartamento.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar departamentos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.selFuncionarios.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nFuncionario", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.selFuncionarios.DataValueField = "tercero";
            this.selFuncionarios.DataTextField = "descripcion";
            this.selFuncionarios.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar funcionarios. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(Session["empresa"]) };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "nCuadrilla",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Cuadrilla " + this.txtCodigo.Text + " ya se encuentra registrada";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

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


        try
        {

            using (TransactionScope ts = new TransactionScope())
            {
                for (int x = 0; x < this.selFuncionarios.Items.Count; x++)
                {
                    if (this.selFuncionarios.Items[x].Selected)
                    {
                        verificacion = true;
                    }
                }

             
                if (verificacion == false)
                {
                    this.nilblInformacion.Text = "Debe seleccionar al menos un funcionario para realizar la asignación";
                    return;
                }

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                }

                object[] objValores = new object[]{
                chkActivo.Checked,
                this.txtCodigo.Text,
                Convert.ToString(this.ddlDepartamento.SelectedValue),
                this.txtDescripcion.Text,
                Convert.ToInt16(Session["empresa"])
            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "nCuadrilla",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:
                        if (Convert.ToBoolean(this.Session["editar"]) == true)
                        {
                            for (int x = 0; x < this.selFuncionarios.Items.Count; x++)
                            {
                                if (cuadrillas.VerificaFuncionarioCuadrilla(txtCodigo.Text, Convert.ToInt32(this.selFuncionarios.Items[x].Value), Convert.ToInt16(Session["empresa"])) == 0)
                                {
                                    if (this.selFuncionarios.Items[x].Selected == false)
                                    {

                                        object[] objValoresConcepto = new object[]{
                                                        Convert.ToString(txtCodigo.Text),
                                                        Convert.ToInt16(Session["empresa"]),
                                                        Convert.ToInt16(this.selFuncionarios.Items[x].Value)  };

                                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                        "nCuadrillaFuncionario",
                                        "elimina",
                                        "ppa",
                                        objValoresConcepto))
                                        {
                                            case 1:
                                                verificacion = true;
                                                break;
                                        }

                                    }

                                }
                                else
                                {
                                    if (this.selFuncionarios.Items[x].Selected == true)
                                    {

                                        object[] objValoresConcepto = new object[]{
                                                        Convert.ToString(txtCodigo.Text),
                                                        Convert.ToInt16(Session["empresa"]),
                                                        Convert.ToInt16(this.selFuncionarios.Items[x].Value)  };

                                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                        "nCuadrillaFuncionario",
                                        "inserta",
                                        "ppa",
                                        objValoresConcepto))
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
                            for (int x = 0; x < this.selFuncionarios.Items.Count; x++)
                            {
                                if (this.selFuncionarios.Items[x].Selected == true)
                                {

                                    object[] objValoresConcepto = new object[]{
                                                       Convert.ToString(txtCodigo.Text),
                                                        Convert.ToInt16(Session["empresa"]),
                                                        Convert.ToInt16(this.selFuncionarios.Items[x].Value)  };

                                    switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                    "nCuadrillaFuncionario",
                                    operacion,
                                    "ppa",
                                    objValoresConcepto))
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
                {
                    this.nilblInformacion.Text = "Error al insertar el registro. operación no realizada";
                }
                else
                {
                    ManejoExito("Asignación registrada correctamente", "I");
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
        for (int x = 0; x < this.selFuncionarios.Items.Count; x++)
        {
            if (cuadrillas.VerificaFuncionarioCuadrilla(txtCodigo.Text, Convert.ToInt32(selFuncionarios.Items[x].Value), Convert.ToInt16(Session["empresa"])) == 0)
                selFuncionarios.Items[x].Selected = true;
            else
                selFuncionarios.Items[x].Selected = false;
        }
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
                this.ddlDepartamento.Focus();

                if (this.txtCodigo.Text.Length > 0)
                {
                    this.txtDescripcion.Focus();
                }

                if (!IsPostBack)
                {

                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                          ConfigurationManager.AppSettings["Modulo"].ToString(),
                           nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        txtCodigo.Text = "";
        this.txtCodigo.Enabled = false;
        this.ddlDepartamento.Focus();
        this.nilblInformacion.Text = "";
        this.selFuncionarios.Visible = true;
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.ddlDepartamento.Enabled = true;
        this.selFuncionarios.Visible = false;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (txtDescripcion.Text.Length == 0 || txtCodigo.Text.Length == 0)
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
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.selFuncionarios.Visible = true;
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.ddlDepartamento.Enabled = false;
        this.txtCodigo.Enabled = false;
        this.txtDescripcion.Focus();

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = this.gvLista.SelectedRow.Cells[2].Text.Trim();
                ValidaRegistro();
            }
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.txtDescripcion.Text = this.gvLista.SelectedRow.Cells[3].Text;
            else
                this.txtDescripcion.Text = "";

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.ddlDepartamento.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[5].Controls)
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

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";

        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                      ConfigurationManager.AppSettings["Modulo"].ToString(),
                                       nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }


            object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), 
                Convert.ToInt16(Session["empresa"])
            };

            if (cuadrillas.EliminaFunncionarios(Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(Session["empresa"])) == 0)
            {
                if (CentidadMetodos.EntidadInsertUpdateDelete("nCuadrilla", operacion, "ppa", objValores) == 0)
                {
                    ManejoExito("Registro eliminado satisfactoriamente", "E");
                }
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");

            }

        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro.", "E");
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

    protected void niddlDepartamento_SelectedIndexChanged(object sender, EventArgs e)
    {
        Consecutivo();
        txtDescripcion.Focus();


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
    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Programacion.aspx");
    }
}
