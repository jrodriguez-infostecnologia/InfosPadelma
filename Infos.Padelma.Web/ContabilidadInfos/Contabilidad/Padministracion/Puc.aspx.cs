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

    Cpuc cuentas = new Cpuc();
    ADInfos.AccesoDatos CentidadMetodos = new ADInfos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }


    private void ComportamientoTipo(int estado)
    {
        try
        {
            if (estado == 0)
            {
                if (cuentas.VerificaCuentaEnMovimientos(this.txtCodigo.Text) == 1)
                {
                    ManejoError("Cuenta con movimiento no es posible editar su tipo", "A");
                    return;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al verificar cuenta con movimientos. Correspondiente a: " + ex.Message, "A");
        }

        if (this.ddlTipo.SelectedValue.ToString() == "A")
        {
            this.chkBase.Enabled = true;
            this.chkCcosto.Enabled = true;
            this.chkTercero.Enabled = true;
            this.chkTercero.Focus();
        }
        else
        {
            this.chkBase.Enabled = false;
            this.chkCcosto.Enabled = false;
            this.chkTercero.Enabled = false;
            this.chkActio.Focus();
        }
    }

    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(), nombrePaginaActual(),//pagina
                            consulta, Convert.ToInt16(this.Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", consulta);
                return;
            }
            this.gvLista.DataSource = cuentas.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(this.Session["empresa"]));
            this.gvLista.DataBind();
            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C", ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
               "ex", this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex", error, ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
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
            this.ddlClase.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gClaseCuenta", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlClase.DataValueField = "codigo";
            this.ddlClase.DataTextField = "descripcion";
            this.ddlClase.DataBind();
            this.ddlClase.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los centros de costo. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(this.Session["empresa"]) };

        if (CentidadMetodos.EntidadGetKey("cPuc", "ppa", objKey).Tables[0].Rows.Count > 0)
        {
            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = "La cuenta " + this.txtCodigo.Text + " ya se encuentra registrada";
            CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
            this.nilbNuevo.Visible = true;
            this.txtCodigo.Text = "";
        }
    }

    private void Guardar()
    {
        string operacion = "inserta";

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            switch (cuentas.RegistraPuc(
                this.txtCodigo.Text.Trim(),
                this.txtNombre.Text,
                Convert.ToString(this.ddlTipo.SelectedValue),
                this.chkTercero.Checked,
                this.chkCcosto.Checked,
                this.chkBase.Checked,
                this.chkActio.Checked,
                ddlClase.SelectedValue,
                operacion, Convert.ToInt16(this.Session["empresa"])))
            {
                case 0:
                    ManejoExito("Registro creado satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                    break;
                case 1:
                    ManejoError("Error al crear el registro. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
                case 2:
                    ManejoError("La ra�z de la cuenta no existe. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
                case 3:
                    ManejoError("No se puede crear una cuenta auxiliar de una cuenta auxiliar. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
                case 4:
                    ManejoError("Error no especificado. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
                case 5:
                    ManejoError("Campos vacios. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar el registro. Correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
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
            if (seguridad.VerificaAccesoPagina(
                   this.Session["usuario"].ToString(),
                   ConfigurationManager.AppSettings["Modulo"].ToString(),
                   nombrePaginaActual(),
                   Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();


            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
            }
        }
    }



    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.nilblMensaje.Text = "";
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    protected void lbRegistrar_Click(object sender, EventArgs e)
    {
        if (txtCodigo.Text.Length == 0 || txtNombre.Text.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                             nombrePaginaActual(), editar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", editar);
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.txtCodigo.Enabled = false;
        this.txtRaiz.Enabled = false;
        this.ddlNaturaleza.Enabled = false;
        this.txtNivel.Enabled = false;
        this.txtNombre.Focus();

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txtCodigo.Text = this.gvLista.SelectedRow.Cells[2].Text;
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.txtRaiz.Text = this.gvLista.SelectedRow.Cells[3].Text;
            else
                this.txtRaiz.Text = "";

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.txtNombre.Text = this.gvLista.SelectedRow.Cells[4].Text;
            else
                this.txtNombre.Text = "";

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                this.ddlNaturaleza.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text;

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                this.txtNivel.Text = this.gvLista.SelectedRow.Cells[6].Text;
            else
                this.txtNivel.Text = "";

            try
            {
                if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                {
                    this.ddlTipo.SelectedValue = this.gvLista.SelectedRow.Cells[7].Text.Trim();
                    ComportamientoTipo(1);
                }
            }
            catch
            {
            }

                        foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
            {
                this.chkTercero.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[9].Controls)
            {
                this.chkCcosto.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[10].Controls)
            {
                this.chkBase.Checked = ((CheckBox)objControl).Checked;
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                this.chkActio.Checked = ((CheckBox)objControl).Checked;
            }

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
                this.ddlClase.SelectedValue = this.gvLista.SelectedRow.Cells[12].Text;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos. Correspondiente a: " + ex.Message, "A");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";

        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                             nombrePaginaActual(), eliminar, Convert.ToInt16(this.Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", eliminar);
                return;
            }

            object[] objValores = new object[] { 
            Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text),
            (int)this.Session["empresa"]
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete("cPuc", operacion, "ppa", objValores) == 0)
                ManejoExito("Registro eliminado satisfactoriamente", "E");
            else
                ManejoError("Error al eliminar el registro. Operaci�n no realizada", "E");
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();

        this.txtNombre.Focus();
    }

    protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
    {
        //ComportamientoTipo(0);
    }

    protected void nilbInforme_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("ListadoPuc.aspx");
    }

    protected void nilbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),
                             nombrePaginaActual(), insertar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", insertar);
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();
        this.txtCodigo.Focus();
    }
    #endregion Eventos

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        gvLista.DataBind();
        GetEntidad();
    }


}
