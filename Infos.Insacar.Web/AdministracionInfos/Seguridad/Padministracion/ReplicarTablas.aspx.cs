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

public partial class Admon_Padministracion_TiposTransaccionCampos : System.Web.UI.Page
{

    #region Instancias

    Creplicaciones replicaciones = new Creplicaciones();
    Centidades entidades = new Centidades();
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

            this.gvLista.DataSource = replicaciones.BuscarEntidadCampo(
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
            this.ddlTabla.DataSource = entidades.BuscarEntidad();
            this.ddlTabla.DataValueField = "name";
            this.ddlTabla.DataTextField = "name";
            this.ddlTabla.DataBind();
            this.ddlTabla.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar entidades. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlEmpresa.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresa(CentidadMetodos.EntidadGet("gEmpresa", "ppa"), "razonSocial");
            this.ddlEmpresa.DataValueField = "id";
            this.ddlEmpresa.DataTextField = "razonSocial";
            this.ddlEmpresa.DataBind();
            this.ddlEmpresa.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empresa desde. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlEmpresaDestino.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresa(CentidadMetodos.EntidadGet("gEmpresa", "ppa"), "razonSocial");
            this.ddlEmpresaDestino.DataValueField = "id";
            this.ddlEmpresaDestino.DataTextField = "razonSocial";
            this.ddlEmpresaDestino.DataBind();
            this.ddlEmpresaDestino.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empresa destino. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta";

        try
        {
            if (replicaciones.AgregarRegistro(ddlEmpresa.SelectedValue, ddlEmpresaDestino.SelectedValue, ddlTabla.SelectedValue) == 0)
            {

                object[] objValores = new object[]{                
                ddlEmpresa.SelectedValue,
                ddlEmpresaDestino.SelectedValue,
                DateTime.Now,
                txtNoRegistros.Text,
                ddlTabla.SelectedValue,
                Session["usuario"].ToString()
            };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "sReplicacion",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:

                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        break;

                    case 1:

                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }
            }
            else
            {
                ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
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

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }


    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
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
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();
       

        this.ddlEmpresa.Enabled = true;
        this.ddlEmpresa.Focus();
        this.ddlTabla.Enabled = true;
        this.ddlEmpresaDestino.Enabled = true;
        this.nilblInformacion.Text = "";
        this.nilblMensaje.Text = "";
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

        this.nilblMensaje.Text = "";

        if (ddlEmpresa.SelectedValue.Length == 0 || ddlEmpresaDestino.SelectedValue.Length == 0 || ddlTabla.SelectedValue.Length == 0 || txtNoRegistros.Text.Length==0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }
        

        Guardar();
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
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

        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[1].Text),
              
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "sReplicacion",
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

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }



    protected void ddlEntidad_SelectedIndexChanged(object sender, EventArgs e)
    {

        CargarNoRegistro();
    }

    private void CargarNoRegistro()
    {
        try
        {
            if (ddlTabla.SelectedValue.Length > 0 && ddlEmpresa.SelectedValue.Length > 0)
            {
                string[] noRegistro = replicaciones.NoRegistros(ddlEmpresa.SelectedValue, ddlTabla.SelectedValue);

                txtNoRegistros.Text = Convert.ToString(noRegistro.GetValue(0));
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar el nombre del tercero. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Eventos


    protected void ddlEmpresa_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarNoRegistro();
    }
}
