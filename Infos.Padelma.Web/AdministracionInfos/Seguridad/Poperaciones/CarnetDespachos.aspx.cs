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

public partial class Seguridad_Operaciones_CarnetDespachos : System.Web.UI.Page
{
    #region Instancias

    CcarnetDes carnet = new CcarnetDes();
    
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
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

            this.gvLista.DataSource = carnet.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"])
          );

            this.gvLista.DataBind();

            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

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
          "ex",
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

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(Session["empresa"]) };

        try
        {
            if (CentidadMetodos.EntidadGetKey("logCarnetDespacho", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "logCarnetDespacho" + " " + this.txtCodigo.Text + " ya se encuentra registrado";

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

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }

            object[] objValores = new object[] {
                this.txtCodigo.Text,
                                Convert.ToInt16(Session["empresa"]),
                ddlEstado.SelectedValue
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
               "logCarnetDespacho",
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
                    this.ddlEstado.Focus();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
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
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", insertar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.txtCodigo.Enabled = true;
        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);

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
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", editar);
            return;
        }
        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.txtCodigo.Enabled = false;
      
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
                ddlEstado.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
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
            if (seguridad.VerificaAccesoOperacion(
                           this.Session["usuario"].ToString(),//usuario
                            ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                            nombrePaginaActual(),//pagina
                           eliminar,//operacion
                          Convert.ToInt16(this.Session["empresa"]))//empresa
                          == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

            object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text),
                Convert.ToInt16(Session["empresa"])
 
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete("logCarnetDespacho", operacion, "ppa", objValores) == 0)
            {
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operaci�n no realizada", "E");
            }
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

    protected void ddlEntidad_SelectedIndexChanged(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        CcontrolesUsuario.OpcionesDefault(
            this.Page.Controls,
            0);

        this.nilblMensaje.Text = "";
        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        if (txtCodigo.Text.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
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

}
