using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seguridad_Poperaciones_Procedencias : System.Web.UI.Page
{
    #region Instancias

    Cprocedencias procedencia = new Cprocedencias();
    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";
    #endregion

    #region Metodos
    private void Guardar()
    {
        string operacion = "inserta";
        string codigo = txtCodigo.Text;


        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";




            object[] objValores = new object[]{          
                                       chkActivo.Checked,      //@activo
                                        ddlTercero.SelectedValue.Trim(),    //@agrupadoPor
                                          codigo,   //@codigo
                                          txtCorreos.Text,
                                          (int)this.Session["empresa"],  //@empresa
                                           ddlExtractora.SelectedValue.Trim(),  //@extractora
                                           DateTime.Now, //@fechaRegistro
                                           ddlTerceroMayor.SelectedValue,
                                          ddlProveedor.SelectedValue.Trim(),  //@proveedor
                                          (string)this.Session["usuario"]  //@usuario
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("bProcedencia", operacion, "ppa", objValores))
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
    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlProveedor.DataSource = procedencia.seleccionaProveedor(Convert.ToInt16(Session["empresa"]));
            this.ddlProveedor.DataValueField = "codigo";
            this.ddlProveedor.DataTextField = "razonSocial";
            this.ddlProveedor.DataBind();
            this.ddlProveedor.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los proveedores. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTercero.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cTercero", "ppa"), "razonSocial", Convert.ToInt16(this.Session["empresa"])); ;
            this.ddlTercero.DataValueField = "codigo";
            this.ddlTercero.DataTextField = "razonSocial";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los terceros. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTerceroMayor.DataSource = procedencia.seleccionaProveedor(Convert.ToInt16(Session["empresa"]));
            this.ddlTerceroMayor.DataValueField = "codigo";
            this.ddlTerceroMayor.DataTextField = "razonSocial";
            this.ddlTerceroMayor.DataBind();
            this.ddlTerceroMayor.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los gran mayor. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView extractora = CcontrolesUsuario.OrdenarEntidadSinEmpresa(CentidadMetodos.EntidadGet("gEmpresa", "ppa"), "razonSocial");
            extractora.RowFilter = "extractora=1 and activo = 1";
            extractora.Sort = "razonSocial";
            this.ddlExtractora.DataSource = extractora;
            this.ddlExtractora.DataValueField = "id";
            this.ddlExtractora.DataTextField = "razonSocial";
            this.ddlExtractora.DataBind();
            this.ddlExtractora.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los Empresa. Correspondiente a: " + ex.Message, "C");
        }


    }

    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                                    nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            this.gvLista.DataSource = procedencia.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

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

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, (int)this.Session["empresa"] };

        try
        {
            if (CentidadMetodos.EntidadGetKey("bProcedencia", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Procedencia " + this.txtCodigo.Text + " ya se encuentra registrada";
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                this.nilbNuevo.Visible = true;
                ddlProveedor.Focus();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }
    #endregion


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


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }
    #endregion
    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
    }
    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
        ddlTercero.Focus();

    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
           this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (txtCodigo.Text.Length == 0)
        {
            nilblInformacion.Text = "Debe digitar el codigo";
            return;
        }
        if (ddlProveedor.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un proveedor valido";
            return;
        }

        if (ddlTercero.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un proveedor valido";
            return;
        }

        if (ddlTerceroMayor.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar un gran mayor";
            return;
        }

        if (ddlExtractora.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar una extractora valida";
            return;
        }

        object[] objKey = new object[] { this.txtCodigo.Text, (int)this.Session["empresa"] };


        if (Convert.ToBoolean(this.Session["editar"]) == false)
        {
            try
            {
                if (CentidadMetodos.EntidadGetKey("bProcedencia", "ppa", objKey).Tables[0].Rows.Count > 0)
                {
                    this.nilblInformacion.Visible = true;
                    ManejoError("Procedencia " + this.txtCodigo.Text + " ya se encuentra registrada", "I");
                    CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                    this.nilbNuevo.Visible = true;
                    ddlProveedor.Focus();
                }
                else
                    Guardar();
            }
            catch (Exception ex)
            {
                ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
            }
        }
        else
        {
            Guardar();
        }
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(), nombrePaginaActual(), eliminar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }

        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), (int)this.Session["empresa"] };

            if (CentidadMetodos.EntidadInsertUpdateDelete("bProcedencia", operacion, "ppa", objValores) == 0)
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            else
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }
    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(), nombrePaginaActual(), editar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }

        try
        {
            CcontrolesUsuario.HabilitarControles(this.Page.Controls);
            CargarCombos();
            this.Session["editar"] = true;

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = this.gvLista.SelectedRow.Cells[2].Text;
                this.txtCodigo.Enabled = false;
		if (Session["usuario"].ToString() != "ejaraba")
		    ddlProveedor.Enabled = false;

            }
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text.Trim() != "&nbsp;")
                ddlTercero.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text.Trim();

            if (this.gvLista.SelectedRow.Cells[5].Text.Trim() != "&nbsp;")
                this.ddlProveedor.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text.Trim();

            if (this.gvLista.SelectedRow.Cells[7].Text.Trim() != "&nbsp;")
                this.ddlExtractora.SelectedValue = this.gvLista.SelectedRow.Cells[7].Text.Trim();

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                this.txtCorreos.Text = this.gvLista.SelectedRow.Cells[9].Text;
            else
                this.txtCorreos.Text = "";

            if (this.gvLista.SelectedRow.Cells[10].Text.Trim() != "&nbsp;")
                this.ddlTerceroMayor.SelectedValue = this.gvLista.SelectedRow.Cells[10].Text.Trim();

            foreach (Control c in gvLista.SelectedRow.Cells[12].Controls)
            {
                if (c is CheckBox)
                    chkActivo.Checked = ((CheckBox)c).Checked;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "E");
        }
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
}