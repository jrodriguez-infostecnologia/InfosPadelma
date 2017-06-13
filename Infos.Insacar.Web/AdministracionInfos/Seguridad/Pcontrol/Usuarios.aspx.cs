using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Facturacion_Padministracion_Usuarios : System.Web.UI.Page
{


    #region Instancias

    Cusuarios usuario = new Cusuarios();
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


            this.gvLista.DataSource = usuario.BuscarEntidad(
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
              this.gvLista.Rows.Count.ToString() + " Registros encontrados",
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
       
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "sUsuarios",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Usuario " + this.txtCodigo.Text + " ya se encuentra registrado";

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
        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {

                switch (usuario.ModificaUsuario(this.txtCodigo.Text, this.txtDescripcion.Text, this.chkActivo.Checked, txtCorreo.Text))
                {
                    case 0:
                        ManejoExito("Usuario modificado satisfactoriamente", "A");
                        break;
                    case 1:
                        ManejoError("Error al modificar el registro. Operación no realizada", "A");
                        break;
                }
            }
            else
            {
                switch (usuario.InsertaUsuario(this.txtCodigo.Text, this.txtDescripcion.Text, this.txtContrasena.Text, this.chkActivo.Checked, DateTime.Now, txtCorreo.Text))
                {
                    case 0:
                        ManejoExito("Datos insertados satisfactoriamente", "I");
                        break;
                    case 1:
                        ManejoError("Usuario existente. Operación no realizada", "I");
                        break;
                    case 2:
                        ManejoError("La longitud de la contraseña debe ser mayor o iual a 4 caracteres. Operación no realizada", "I");
                        break;
                    case 3:
                        ManejoError("Error al insertar el registro. Operación no realizada", "I");
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, "I");
        }
    }

    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
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

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.txtCodigo.Enabled = false;
        this.txtContrasena.Enabled = false;
        this.txtDescripcion.Focus();
        this.txtContrasenaAnterior.Visible = false;
        this.txtContrasenaNueva.Visible = false;
        this.lblContrasenaAnterior.Visible = false;
        this.lblNueva.Visible = false;
        this.lbCambiar.Visible = false;
        this.lbReestablecer.Visible = false;
        this.lbCancelarCambio.Visible = false;
        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[1].Text != "&nbsp;")
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[1].Text);
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            else
                this.txtDescripcion.Text = "";

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.txtCorreo.Text = this.gvLista.SelectedRow.Cells[4].Text;
            else
                this.txtCorreo.Text = "";

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[5].Controls)
            {
                if (objControl is CheckBox)
                    this.chkActivo.Checked = ((CheckBox)objControl).Checked;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void lbCambiarContrasena_Click(object sender, EventArgs e)
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

        this.txtContrasenaAnterior.Visible = true;
        this.txtContrasenaNueva.Visible = true;
        this.lblContrasenaAnterior.Visible = true;
        this.lblNueva.Visible = true;
        this.txtContrasenaAnterior.Focus();
        this.lbCambiar.Visible = true;
        lbCancelarCambio.Visible = true;
        lbReestablecer.Visible = false;
    }
    protected void niimbBuscar_Click1(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
         this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }
    protected void nilbNuevo_Click(object sender, ImageClickEventArgs e)
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

        this.txtCodigo.Enabled = true;
        this.txtContrasena.Enabled = true;
        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
        this.lbCambiarContrasena.Visible = false;
        this.txtContrasenaAnterior.Visible = false;
        this.txtContrasenaNueva.Visible = false;
        this.lblContrasenaAnterior.Visible = false;
        this.lblNueva.Visible = false;
        this.lbCambiar.Visible = false;
        this.lbReestablecer.Visible = false;
        this.lbRestablecerContrasena.Visible = true;
        this.lbCambiarContrasena.Visible = true;
        lbCancelarCambio.Visible = false;
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (txtCodigo.Text.Length == 0 || txtDescripcion.Text.Length == 0 || txtCorreo.Text.Length == 0)
        {
            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

        Guardar();
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }
    protected void lbCambiar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (this.txtContrasenaAnterior.Text.Length == 0 || this.txtContrasenaNueva.Text.Length == 0)
            {
                this.nilblInformacion.Text = "Campos vacios por favor corrija";
            }
            else
            {
                if (this.txtContrasenaAnterior.Text == this.txtContrasenaNueva.Text)
                    this.nilblInformacion.Text = "La contaseña nueva debe ser diferente a la contraseña anterior";
                else
                {
                    switch (usuario.ActualizaIdSysUsuario(this.txtCodigo.Text, this.txtContrasenaAnterior.Text, this.txtContrasenaNueva.Text))
                    {
                        case 0:
                            ManejoExito("Contraseña cambiada satisfactoriamente", "A");
                            break;
                        case 1:
                            ManejoError("Contraseña incorrecta", "A");
                            break;
                        case 2:
                            ManejoError("La contraseña debe ser mayor o igual a cuatro caracteres", "A");
                            break;
                        case 3:
                            ManejoError("Error al cambiar la contaseña. Operación no realizada", "A");
                            break;
                    }
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cambiar la contraseña. Correspondiente a: " + ex.Message, "A");
        }
    }
    protected void lbReestablecer_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (txtContrasenaNueva.Text.Length == 0)
            {
                nilblMensaje.Text = "campo vacio por favor corrija, debe digitar una nueva contraseña.";
                return;
            }

            switch (usuario.ReestableceUsuario(this.txtCodigo.Text, txtContrasenaNueva.Text))
            {
                case 0:
                    ManejoExito("Contraseña Reestablecida satisfactoriamente", "A");
                    break;
                case 1:
                    ManejoError("Error al Reestablecer Contraseña ", "A");
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cambiar la contraseña. Correspondiente a: " + ex.Message, "A");
        }
    }

    #endregion Eventos



    protected void lbRestablecerContrasena_Click(object sender, EventArgs e)
    {
        lblNueva.Visible = true;
        txtContrasenaNueva.Visible = true;
        lblContrasenaAnterior.Visible = false;
        lblContrasenaAnterior.Visible = false;
        txtContrasenaAnterior.Visible = false;
        lbRestablecerContrasena.Visible = true;
        lbReestablecer.Visible = true;
        lbCancelarCambio.Visible = true;
        lbCambiar.Visible = false;
    }
    protected void lbCancelarCambio_Click(object sender, ImageClickEventArgs e)
    {
        lblNueva.Visible = false;
        txtContrasenaNueva.Visible = false;
        lblContrasenaAnterior.Visible = false;
        lbRestablecerContrasena.Visible = true;
        txtContrasenaAnterior.Visible = false;
        lbCambiarContrasena.Visible = true;
        lbCancelarCambio.Visible = false;
        lbReestablecer.Visible = false;
        lbCambiar.Visible = false;
    }

}
