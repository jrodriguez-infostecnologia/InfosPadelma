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

public partial class Nomina_Paminidtracion_ICBF : System.Web.UI.Page
{
    #region Instancias

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Csena sena = new Csena();
    cParametrosGenerales parametrosGenerales = new cParametrosGenerales();

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

            this.gvLista.DataSource = sena.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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

        this.Response.Redirect("~/Nomina/Error.aspx", false);
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
            this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }
    private void CargarCombos()
    {

        try
        {

            this.ddlTercero.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet("cTercero", "ppa"), "descripcion", "proveedor", Convert.ToInt16(this.Session["empresa"]));
            this.ddlTercero.DataValueField = "id";
            this.ddlTercero.DataTextField = "RazonSocial";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tercero. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView dvCuenta = parametrosGenerales.RetornaAuxiliaresPuc(Convert.ToInt16(Session["empresa"]));
            this.ddlCuenta.DataSource = dvCuenta;
            this.ddlCuenta.DataValueField = "codigo";
            this.ddlCuenta.DataTextField = "nombre";
            this.ddlCuenta.DataBind();
            this.ddlCuenta.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cuentas. Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            this.ddlCodigoNacional.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gEntidadNacional", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlCodigoNacional.DataValueField = "codigo";
            this.ddlCodigoNacional.DataTextField = "descripcion";
            this.ddlCodigoNacional.DataBind();
            this.ddlCodigoNacional.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar coidgos nacionales. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            this.ddlPais.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gPais", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPais.DataValueField = "codigo";
            this.ddlPais.DataTextField = "descripcion";
            this.ddlPais.DataBind();
            this.ddlPais.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar paises. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void cargarProveedor()
    {
        try
        {
            DataView proveedor = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cxpProveedor", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"])); ;
            proveedor.RowFilter = "activo = 1 and empresa = " + Convert.ToString(Session["empresa"]) + " and idTercero=" + ddlTercero.SelectedValue.ToString();
            this.ddlProveedor.DataSource = proveedor;
            this.ddlProveedor.DataValueField = "codigo";
            this.ddlProveedor.DataTextField = "descripcion";
            this.ddlProveedor.DataBind();
            this.ddlProveedor.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar proveedor. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void cargarCiudad()
    {
        try
        {
            DataView ciudad = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gCiudad", "ppa"), "nombre", Convert.ToInt16(this.Session["empresa"])); ;
            ciudad.RowFilter = "empresa = " + Convert.ToString(Session["empresa"]) + " and pais='" + ddlPais.SelectedValue.ToString() + "'";
            this.ddlCiudad.DataSource = ciudad;
            this.ddlCiudad.DataValueField = "codigo";
            this.ddlCiudad.DataTextField = "nombre";
            this.ddlCiudad.DataBind();
            this.ddlCiudad.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar proveedor. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text.Trim().ToString(), Convert.ToInt16(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
               "nEntidadSena",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "C�digo " + this.txtCodigo.Text + " ya se encuentra registrado";

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
        string operacion = "inserta", codigoNacional = null, pais = null, ciudad = null;


        if (this.txtDescripcion.Text.Length == 0 || this.txtCodigo.Text.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
        }
        else
        {
            try
            {

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                }

                if (ddlCodigoNacional.SelectedValue.Length > 0)
                    codigoNacional = ddlCodigoNacional.SelectedValue;

                if (ddlPais.SelectedValue.Length > 0)
                    pais = ddlPais.SelectedValue;

                if (ddlCiudad.SelectedValue.Length > 0)
                    ciudad = ddlCiudad.SelectedValue;

                string cuenta = null;
                if (ddlCuenta.SelectedValue.Length > 0)
                    cuenta = ddlCuenta.SelectedValue;


                object[] objValores = new object[]{
                    chkActivo.Checked,
                    ciudad,
                      txtCodigo.Text,
                      codigoNacional,
                      cuenta,
                    this.txtDescripcion.Text,
                   Convert.ToInt16(Session["empresa"]),
                   DateTime.Now,
                   chkIntegral.Checked,
                   txtObservacion.Text,
                   pais,
                   Convert.ToDecimal(txvAporte.Text),
                   ddlProveedor.SelectedValue,
                   ddlTercero.SelectedValue,
                   Convert.ToString(Session["usuario"])

                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                   "nEntidadSena",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:

                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        break;

                    case 1:

                        ManejoError("Errores al insertar el registro. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
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
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
                ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {


                this.txtCodigo.Focus();

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

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        ddlCiudad.DataSource = null;
        ddlCiudad.DataBind();

        ddlProveedor.DataSource = null;
        ddlProveedor.DataBind();

        CargarCombos();

        txtCodigo.Focus();

        this.nilblInformacion.Text = "";
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

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
        txtDescripcion.Focus();
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

            object[] objValores = new object[] {
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToInt16(Session["empresa"])
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
               "nEntidadSena",
                "elimina",
                "ppa",
                objValores))
            {
                case 0:

                    ManejoExito("Registro eliminado satisfactoriamente", "E");
                    break;

                case 1:

                    ManejoError("Error al eliminar el registro. Operaci�n no realizada", "E");
                    break;
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

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        if (txtCodigo.Text.Trim().ToString().Length == 0 || txtDescripcion.Text.Length == 0 || ddlTercero.SelectedValue.Length == 0 || ddlProveedor.SelectedValue.Length == 0
            || txvAporte.Text.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }
        if (Convert.ToDecimal(txvAporte.Text) > 100)
        {
            nilblMensaje.Text = "Campos porcentaje del empleado no puede ser mayor a 100, por avor corrija";
            return;
        }

        Guardar();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(
         this.Session["usuario"].ToString(),
         ConfigurationManager.AppSettings["Modulo"].ToString(),
          nombrePaginaActual(),
         "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "A");
            return;
        }


        CcontrolesUsuario.HabilitarControles(
         this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.txtCodigo.Enabled = false;
        this.txtDescripcion.Focus();
        CargarCombos();
        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            }
            else
            {
                this.txtCodigo.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            }
            else
            {
                this.txtDescripcion.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.ddlTercero.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
                cargarProveedor();
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.ddlProveedor.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                this.ddlCodigoNacional.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                this.txvAporte.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text);
            }
            else
            {
                this.txvAporte.Text = "0";
            }
            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
            {
                this.ddlPais.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
                cargarCiudad();
            }
            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
            {
                this.ddlCiudad.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);
            }

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
            {
                this.txtObservacion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[10].Text);
            }
            else
            {
                this.txtObservacion.Text = "";
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkIntegral.Checked = ((CheckBox)objControl).Checked;
                }
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkActivo.Checked = ((CheckBox)objControl).Checked;
                }
            }
            if (this.gvLista.SelectedRow.Cells[13].Text != "&nbsp;")
            {
                this.ddlCuenta.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[13].Text);
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    protected void gvLista_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void ddlTercero_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarProveedor();
    }

    protected void ddlPais_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarCiudad();
    }

    #endregion Eventos

}
