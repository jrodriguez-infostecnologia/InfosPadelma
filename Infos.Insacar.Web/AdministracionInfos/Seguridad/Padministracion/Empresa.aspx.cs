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

    Cempresa empresa = new Cempresa();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
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

    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            consulta,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", consulta);
                return;
            }

            this.gvLista.DataSource = empresa.BuscarEntidad(
                this.nitxtBusqueda.Text);

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              consulta,
               ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex",
              this.gvLista.Rows.Count.ToString() + " Registros encontrados",
              ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
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
                error,
                ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

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
                mensaje,
                ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            DataView terceros = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cTercero", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            terceros.RowFilter = "empresa=" + Convert.ToInt16(this.Session["empresa"]);
            this.ddlTercero.DataSource = terceros;
            this.ddlTercero.DataValueField = "id";
            this.ddlTercero.DataTextField = "descripcion";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar terceros. Correspondiente a: " + ex.Message, "C");
        }

    }


    private void Guardar()
    {
        string operacion = "inserta", tercero = null;


        try
        {
            int codigo = Convert.ToInt16(Cgeneral.RetornaConsecutivoAutomaticoSinEmpresa("gEmpresa", "id"));

            if (ddlTercero.SelectedValue.ToString().Trim().Length > 0)
                tercero = ddlTercero.SelectedValue;



            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                codigo = Convert.ToInt16(txtCodigo.Text);
            }


            object[] objValores = new object[]{          
                chkActivo.Checked,//@activo
                txtDv.Text,//@dv
                chkExtractora.Checked,//@extractora
                DateTime.Now, //@fechaRegistro
                codigo,//@id
                txtNit.Text,//@nit
                this.txtDescripcion.Text,//@razonSocial
                tercero//@tercero
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("gEmpresa", operacion, "ppa", objValores))
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

                if (this.txtCodigo.Text.Length > 0)
                {
                    this.txtDescripcion.Focus();
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

        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            insertar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", insertar);
            return;
        }


        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();

        txtCodigo.Text = Cgeneral.RetornaConsecutivoAutomaticoSinEmpresa("gEmpresa", "id");
        txtCodigo.Enabled = false;
        txtNit.Focus();
        this.nilblInformacion.Text = "";
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
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }



    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             editar,//operacion
                            Convert.ToInt16(this.Session["empresa"]))//empresa
                            == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }


        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.txtCodigo.Enabled = false;
        this.txtDescripcion.Focus();

        try
        {
            CargarCombos();

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
                this.txtNit.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            }
            else
            {
                this.txtNit.Text = "";
            }


            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.txtDv.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            }
            else
            {
                this.txtDv.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);
            }
            else
            {
                this.txtDescripcion.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                this.ddlTercero.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text.Trim());
            }
            else
            {
                this.ddlTercero.SelectedValue = "";
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[7].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkExtractora.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkActivo.Checked = ((CheckBox)objControl).Checked;
                    }
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

        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            eliminar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", eliminar);
            return;
        }

        try
        {
            object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text) 
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "gEmpresa",
                operacion,
                "ppa",
                objValores) == 0)
            {
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }

    protected void lbRegistrar_Click1(object sender, ImageClickEventArgs e)
    {
        if (txtNit.Text.Length == 0 || txtDescripcion.Text.Length == 0 || txtDv.Text.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        if (chkExtractora.Checked == true)
        {
            if (ddlTercero.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar una extractora valida para continuar";

            }
        }

        Guardar();
    }
    #endregion Eventos


    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void chkExtractora_CheckedChanged(object sender, EventArgs e)
    {
        try
        {
            DataView terceros = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("cTercero", "ppa"),
                "descripcion", Convert.ToInt16(this.Session["empresa"]));
            terceros.RowFilter = "empresa=" + Convert.ToInt16(this.Session["empresa"]) + "and extractora=1";

            this.ddlTercero.DataSource = terceros;
            this.ddlTercero.DataValueField = "id";
            this.ddlTercero.DataTextField = "descripcion";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
            this.ddlTercero.SelectedValue = "";
            this.ddlTercero.Focus();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar terceros. Correspondiente a: " + ex.Message, "C");
        }
    }
}
