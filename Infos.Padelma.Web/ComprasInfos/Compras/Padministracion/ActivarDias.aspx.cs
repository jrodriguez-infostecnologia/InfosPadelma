using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Compras_Padministracion_ActivarDias : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cdias dias = new Cdias();
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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            this.gvLista.DataSource = dias.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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

        this.Response.Redirect("~/Compras/Error.aspx", false);
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

    private void CargarCombos()
    {
        try
        {
            this.ddlTipoTransaccion.DataSource = dias.GetTipoTransaccionModulo(Convert.ToInt16(Session["empresa"]));
            this.ddlTipoTransaccion.DataValueField = "codigo";
            this.ddlTipoTransaccion.DataTextField = "descripcion";
            this.ddlTipoTransaccion.DataBind();
            this.ddlTipoTransaccion.Items.Insert(0, new ListItem("", ""));
            this.ddlTipoTransaccion.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { ddlTipoTransaccion.SelectedValue, Convert.ToInt16(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "iMayorItem",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Código " + this.ddlTipoTransaccion.SelectedItem.Text + " ya se encuentra registrado";

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


        if (ddlTipoTransaccion.SelectedValue.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        try
        {


            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }
            

            object[] objValores = new object[]{
                    chkDomingo.Checked,
                    Convert.ToInt16(Session["empresa"]),
                    chkJueves.Checked,
                    chkLunes.Checked,
                    chkMartes.Checked,
                    chkMiercoles.Checked,
                    chkSabado.Checked,
                    ddlTipoTransaccion.SelectedValue,
                    chkViernes.Checked                  
                    
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "gTipoTransaccionDias",
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
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
                ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {

                this.nitxtBusqueda.Focus();

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

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);


        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();

        
        ddlTipoTransaccion.Focus();


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

   
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
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
                Convert.ToInt16(Session["empresa"]),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text))
                
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "gTipoTransaccionDias",
                "elimina",
                "ppa",
                objValores))
            {
                case 0:

                    ManejoExito("Registro eliminado satisfactoriamente", "E");
                    break;

                case 1:

                    ManejoError("Error al eliminar el registro. Operación no realizada", "E");
                    break;
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

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {

        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            "A",//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
          this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        CargarCombos();
        ddlTipoTransaccion.Enabled = false;
        chkLunes.Focus();

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.ddlTipoTransaccion.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);

            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[3].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkLunes.Checked = ((CheckBox)objControl).Checked;
                }

            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[4].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkMartes.Checked = ((CheckBox)objControl).Checked;
                }

            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[5].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkMiercoles.Checked = ((CheckBox)objControl).Checked;
                }

            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[6].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkJueves.Checked = ((CheckBox)objControl).Checked;
                }

            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[7].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkViernes.Checked = ((CheckBox)objControl).Checked;
                }

            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[8].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkSabado.Checked = ((CheckBox)objControl).Checked;
                }

            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[9].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkDomingo.Checked = ((CheckBox)objControl).Checked;
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
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

  

    protected void ddlFinca_SelectedIndexChanged(object sender, EventArgs e)
    {
        EntidadKey();
        chkLunes.Focus();
    }
    #endregion Eventos
  
}