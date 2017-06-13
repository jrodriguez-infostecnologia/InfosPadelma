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

public partial class Facturacion_Padministracion_Terceros : System.Web.UI.Page
{
    #region Instancias

    Centidades entidades = new Centidades();
    Cterceros terceros = new Cterceros();
    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();
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
            CcontrolesUsuario.InhabilitarControles(Page.Controls);
            this.gvLista.Visible = true;
            this.nilblInformacion.Visible = true;
            this.nilbNuevo.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
            this.nilblMensaje.Text = "";


            this.gvLista.DataSource = terceros.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(this.Session["empresa"]));
            this.gvLista.DataBind();



            manejoGrilla(false);



        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, "C");
        }
    }

    protected void manejoGrilla(bool manejo)
    {

        for (int x = 0; x < gvLista.Columns.Count; x++)
        {
            if (x >= 13)
                gvLista.Columns[x].Visible = manejo;
        }





    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        this.Session["gvConsulta"] = null;
        seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              operacion,
               ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er",
              error,
              ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));

        this.Response.Redirect("~/Contabilidad/Error.aspx", false);
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
                      ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));

        GetEntidad();
        this.Session["gvConsulta"] = null;
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
            DataView tipodocumento = accesoDatos.EntidadGet("gTipoDocumento", "ppa").Tables[0].DefaultView;
            tipodocumento.RowFilter = "empresa =" + this.Session["empresa"].ToString();

            this.ddlTipoID.DataSource = tipodocumento;
            this.ddlTipoID.DataValueField = "codigo";
            this.ddlTipoID.DataTextField = "descripcion";
            this.ddlTipoID.DataBind();
            this.ddlTipoID.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de documento. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView ciudad = CcontrolesUsuario.OrdenarEntidad(
                accesoDatos.EntidadGet("gCiudad", "ppa"),
                "nombre", Convert.ToInt16(this.Session["empresa"]));
            ciudad.RowFilter = "empresa =" + this.Session["empresa"].ToString();
            this.ddlCiudad.DataSource = ciudad;
            this.ddlCiudad.DataValueField = "codigo";
            this.ddlCiudad.DataTextField = "nombre";
            this.ddlCiudad.DataBind();
            this.ddlCiudad.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar ciudades. Correspondiente a: " + ex.Message, "C");
        }



    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString(), (int)this.Session["empresa"] };

        try
        {
            if (accesoDatos.EntidadGetKey(
                "cTercero",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "El codigo: " + " " + Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString() +
                    " ya se encuentra registrado";

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
            int id = 0;

            object nit = null;
            object dv = null;
            object ciudad = null;
            object foto = null;
            object contacto = null;
            object telefono = null;
            object direccion = null;
            object barrio = null;
            object fax = null;
            object email = null;
            object razonSocial = null;

            id = terceros.RetornaConsecutivoIdtercero(Convert.ToInt16(Session["empresa"]));

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                id = Convert.ToInt32(this.Session["id"]);
            }
            else
                EntidadKey();


            if (txtDv.Text.Trim().Length > 0)
                dv = txtDv.Text;
            if (ddlCiudad.SelectedValue.Trim().Length > 0)
                ciudad = ddlCiudad.SelectedValue.ToString();
            else
                ciudad = null;

            if (txtContacto.Text.Trim().Length > 0)
                contacto = txtContacto.Text;

            if (txtTelefono.Text.Trim().Length > 0)
                telefono = txtTelefono.Text;

            if (txtDireccion.Text.Trim().Length > 0)
                direccion = txtDireccion.Text;

            if (txtBarrio.Text.Trim().Length > 0)
                barrio = txtBarrio.Text;

            if (txtFax.Text.Trim().Length > 0)
                fax = txtFax.Text;

            if (txtEmail.Text.Trim().Length > 0)
                email = txtEmail.Text;

            if (!txtRazonSocial.Enabled)
                razonSocial = txtApellido1.Text.Trim() + " " + txtApellido2.Text.Trim() + " " + txtNombre1.Text.Trim() + " " + txtNombre2.Text.Trim();
            else
                razonSocial = txtRazonSocial.Text;

            using (TransactionScope ts = new TransactionScope())
            {

                object[] objValores = new object[] {
                                        chkAccionista.Checked,//@accionista
                                        chkActivo.Checked,//@activo
                                        txtApellido1.Text,//@apellido1
                                        txtApellido2.Text,//@apellido2
                                        txtBarrio.Text,//@barrio
                                        ddlCiudad.SelectedValue.ToString(),//@cidudad
                                        chkCliente.Checked,//@cliente
                                       Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString(),//@codigo
                                        txtContacto.Text,//@contacto
                                        chkContratista.Checked,//@contratista
                                        txtDescripcion.Text,//@descripcion
                                        txtDireccion.Text,//@direccion
                                        dv,//@dv
                                        txtEmail.Text,//@email
                                        chkEmpleado.Checked,//@empleado
                                        Convert.ToInt16(this.Session["empresa"]),//@empresa
                                        chkExtractora.Checked,   //extractora
                                        txtFax.Text,//@fax
                                        DateTime.Now,//@fechaRegistro
                                        foto,//@foto
                                        id,//@id
                                        Convert.ToInt32(Convert.ToDecimal(txtDocumento.Text)).ToString(),//@nit
                                        txtNombre1.Text,//@nombre1
                                        txtNombre2.Text,//@nombre2
                                        chkProveedor.Checked,//@proveedor
                                        razonSocial,//@razonSocial
                                        txtTelefono.Text,//@telefono
                                        rbTipoPersona.SelectedValue,//@tipo
                                        ddlTipoID.SelectedValue//@tipoDocumento
            };

                switch (accesoDatos.EntidadInsertUpdateDelete("cTercero", operacion, "ppa", objValores))
                {
                    case 0:
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        ts.Complete();
                        break;
                    case 1:
                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }
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


                if (!IsPostBack)
                {
                    CargarCombos();
                }

                if (this.txtCodigo.Text.Length > 0)
                {
                    this.txtDescripcion.Focus();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", ingreso);
            }


        }
    }



    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        GetEntidad();


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

    private void ComportamientoInicialNombres()
    {
        this.txtNombre1.Visible = false;
        this.txtNombre2.Visible = false;
        this.txtApellido1.Visible = false;
        this.txtApellido2.Visible = false;
        this.txtRazonSocial.Visible = false;
        this.lblPrimerNombre.Visible = false;
        this.lblSegundoNombre.Visible = false;
        this.lblPrimerApellido.Visible = false;
        this.lblSegundoApellido.Visible = false;
        this.lblRazonSocial.Visible = false;
    }



    #endregion Eventos
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

        cargarNuevo();

    }

    protected void cargarNuevo()
    {
        ComportamientoInicialNombres();
        CargarCombos();
        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.txtCodigo.Enabled = true;
        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
        comportamientoCampos();
        this.gvLista.Visible = false;
        this.nilblMensaje.Text = "";
        txtCodigo.Focus();
        this.Session["gvConsulta"] = null;
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
           this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();


        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.nilblMensaje.Text = "";
        this.Session["gvConsulta"] = null;

    }
    protected void nilbGuardar_Click(object sender, ImageClickEventArgs e)
    {

        if (Convert.ToBoolean(this.Session["editar"]) == false)
        {
            switch (terceros.RetornaCodigoTercero(Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString(), (int)this.Session["empresa"]))
            {
                case 1:
                    ManejoError("Código de usuario existente", "I");
                    return;
            }
        }

        if (ddlTipoID.SelectedValue.ToString().Trim().Length == 0)
        {
            this.nilblMensaje.Text = "Seleccione un tipo de documento valido";
            return;
        }

        if (rbTipoPersona.SelectedIndex == 2)
        {
            if (txtDocumento.Text.Trim().Length == 0 || txtApellido1.Text.Trim().Length == 0 || txtApellido2.Text.Trim().Length == 0
                || txtNombre1.Text.Trim().Length == 0 || txtNombre2.Text.Trim().Length == 0 || txtNombre2.Text.Trim().Length == 0
                || txtDescripcion.Text.Trim().Length == 0)
            {
                this.nilblMensaje.Text = "Campos vacios por favor corrija";
                return;
            }
        }
        else if (rbTipoPersona.SelectedIndex == 1)
        {

            if (txtDocumento.Text.Trim().Length == 0 || txtDv.Text.Trim().Length == 0 || txtDescripcion.Text.Trim().Length == 0)
            {

                this.nilblMensaje.Text = "Campos vacios por favor corrija";
                return;
            }

        }
        else
        {

            if (txtDocumento.Text.Trim().Length == 0 || txtDescripcion.Text.Trim().Length == 0)
            {
                this.nilblMensaje.Text = "Campos vacios por favor corrija";
                return;
            }
        }

        Guardar();
    }


    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(), editar, Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }
        cargarNuevo();
        this.Session["editar"] = true;
        try
        {
            CargarCombos();
            DataView dvTercero = terceros.RetornaDatosTercero(this.gvLista.SelectedRow.Cells[2].Text, (int)this.Session["empresa"]);
            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
                this.txtCodigo.Enabled = false;
            }
            else
                this.txtCodigo.Text = "";

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                ddlTipoID.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text.Trim());
            else
                ddlTipoID.SelectedValue = "";

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                rbTipoPersona.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);
                ManejoDocumento();
            }
            else
                rbTipoPersona.SelectedValue = "2";

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                txtDocumento.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);
            else
                txtDocumento.Text = "";

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                txtDv.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text);
            else
                txtDv.Text = "";

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                txtRazonSocial.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
            else
                txtRazonSocial.Text = "";

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                txtApellido1.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);
            else
                txtApellido1.Text = "";

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                txtApellido2.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[10].Text);
            else
                txtApellido2.Text = "";

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                txtNombre1.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[11].Text);
            else
                txtNombre1.Text = "";

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
                txtNombre2.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[12].Text);
            else
                txtNombre2.Text = "";

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(12) != null)
            {
                if (dvTercero.Table.Rows[0].ItemArray.GetValue(12).ToString().Trim().Length > 0)
                    txtDescripcion.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(12).ToString();
                else
                    txtDescripcion.Text = "";
            }
            else
                txtDescripcion.Text = "";

            chkActivo.Checked = Convert.ToBoolean(dvTercero.Table.Rows[0].ItemArray.GetValue(13));

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(14) != null)
            {
                if (dvTercero.Table.Rows[0].ItemArray.GetValue(14).ToString().Trim().Length > 0)
                    ddlCiudad.SelectedValue = dvTercero.Table.Rows[0].ItemArray.GetValue(14).ToString();
            }
            else
                ddlCiudad.SelectedValue = "";

            chkCliente.Checked = Convert.ToBoolean(dvTercero.Table.Rows[0].ItemArray.GetValue(15));
            chkProveedor.Checked = Convert.ToBoolean(dvTercero.Table.Rows[0].ItemArray.GetValue(16));
            chkEmpleado.Checked = Convert.ToBoolean(dvTercero.Table.Rows[0].ItemArray.GetValue(17));
            chkAccionista.Checked = Convert.ToBoolean(dvTercero.Table.Rows[0].ItemArray.GetValue(18));
            chkContratista.Checked = Convert.ToBoolean(dvTercero.Table.Rows[0].ItemArray.GetValue(19));
            chkExtractora.Checked = Convert.ToBoolean(dvTercero.Table.Rows[0].ItemArray.GetValue(20));

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(22) != null)
                txtContacto.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(22).ToString();
            else
                txtContacto.Text = "";

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(24) != null)
                txtTelefono.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(24).ToString();
            else
                txtTelefono.Text = "";


            if (dvTercero.Table.Rows[0].ItemArray.GetValue(25) != null)
                txtDireccion.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(25).ToString();
            else
                txtDireccion.Text = "";

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(26) != null)
                txtBarrio.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(26).ToString();
            else
                txtBarrio.Text = "";

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(27) != null)
                txtFax.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(27).ToString();
            else
                txtFax.Text = "";

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(28) != null)
                txtEmail.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(28).ToString();
            else
                txtEmail.Text = "";

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(1) != null)
                this.Session["id"] = dvTercero.Table.Rows[0].ItemArray.GetValue(1).ToString();
            else
                this.Session["id"] = null;

            switch (rbTipoPersona.SelectedValue.ToString())
            {
                case "2":
                    this.txtNombre1.Visible = false;
                    this.txtNombre2.Visible = false;
                    this.txtApellido1.Visible = false;
                    this.txtApellido2.Visible = false;
                    this.txtRazonSocial.Visible = true;
                    this.lblPrimerNombre.Visible = false;
                    this.lblSegundoNombre.Visible = false;
                    this.lblPrimerApellido.Visible = false;
                    this.lblSegundoApellido.Visible = false;
                    this.lblRazonSocial.Visible = true;
                    this.txtRazonSocial.Enabled = true;
                    this.txtDv.Visible = true;
                    this.txtDv.Enabled = true;
                    this.txtDocumento.Focus();
                    break;
                case "1":

                    this.txtNombre1.Visible = true;
                    this.txtNombre2.Visible = true;
                    this.txtApellido1.Visible = true;
                    this.txtApellido2.Visible = true;
                    this.txtRazonSocial.Visible = true;
                    this.lblPrimerNombre.Visible = true;
                    this.lblSegundoNombre.Visible = true;
                    this.lblPrimerApellido.Visible = true;
                    this.lblSegundoApellido.Visible = true;
                    this.lblRazonSocial.Visible = true;
                    this.txtRazonSocial.Enabled = false;
                    this.txtDv.Visible = true;
                    this.txtDv.Enabled = false;
                    this.txtDocumento.Focus();
                    break;

                case "0":

                    this.txtNombre1.Visible = false;
                    this.txtNombre2.Visible = false;
                    this.txtApellido1.Visible = false;
                    this.txtApellido2.Visible = false;
                    this.txtRazonSocial.Visible = true;
                    this.lblPrimerNombre.Visible = false;
                    this.lblSegundoNombre.Visible = false;
                    this.lblPrimerApellido.Visible = false;
                    this.lblSegundoApellido.Visible = false;
                    this.lblRazonSocial.Visible = true;
                    this.txtRazonSocial.Enabled = true;
                    this.txtDv.Visible = true;
                    this.txtDv.Enabled = false;
                    this.txtRazonSocial.Focus();
                    break;
            }
            gvLista.Visible = false;
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
                ManejoError("Usuario no autorizado para ejecutar esta operación", eliminar);
                return;
            }


            object[] objValores = new object[] {  Convert.ToInt16(this.Session["empresa"]),Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[2].Text.Trim())};

            if (accesoDatos.EntidadInsertUpdateDelete("cTercero",operacion,"ppa",objValores) == 0)
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            else
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro.  debido a: " + ex.Message, "E");
            }
            else
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.HResult.ToString() + ex.Message, "E");
            }
        }
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void rbTipoPersona_SelectedIndexChanged(object sender, EventArgs e)
    {
        comportamientoCampos();
    }

    protected void comportamientoCampos()
    {

        switch (rbTipoPersona.SelectedValue.ToString())
        {
            case "2":
                this.txtNombre1.Visible = false;
                this.txtNombre2.Visible = false;
                this.txtApellido1.Visible = false;
                this.txtApellido2.Visible = false;
                this.txtRazonSocial.Visible = true;
                this.lblPrimerNombre.Visible = false;
                this.lblSegundoNombre.Visible = false;
                this.lblPrimerApellido.Visible = false;
                this.lblSegundoApellido.Visible = false;
                this.lblRazonSocial.Visible = true;
                this.txtRazonSocial.Enabled = true;
                this.txtDv.Visible = true;
                this.txtDv.Enabled = true;
                this.txtDocumento.Focus();
                break;
            case "1":

                this.txtNombre1.Visible = true;
                this.txtNombre2.Visible = true;
                this.txtApellido1.Visible = true;
                this.txtApellido2.Visible = true;
                this.txtRazonSocial.Visible = true;
                this.lblPrimerNombre.Visible = true;
                this.lblSegundoNombre.Visible = true;
                this.lblPrimerApellido.Visible = true;
                this.lblSegundoApellido.Visible = true;
                this.lblRazonSocial.Visible = true;
                this.txtRazonSocial.Enabled = false;
                this.txtDv.Visible = true;
                this.txtDv.Enabled = false;
                this.txtDocumento.Focus();
                break;

            case "0":

                this.txtNombre1.Visible = false;
                this.txtNombre2.Visible = false;
                this.txtApellido1.Visible = false;
                this.txtApellido2.Visible = false;
                this.txtRazonSocial.Visible = true;
                this.lblPrimerNombre.Visible = false;
                this.lblSegundoNombre.Visible = false;
                this.lblPrimerApellido.Visible = false;
                this.lblSegundoApellido.Visible = false;
                this.lblRazonSocial.Visible = true;
                this.txtRazonSocial.Enabled = true;
                this.txtDv.Visible = true;
                this.txtDv.Enabled = false;
                this.txtRazonSocial.Focus();
                break;



        }


    }
    protected void txtCodigo_TextChanged(object sender, EventArgs e)
    {
        switch (terceros.RetornaCodigoTercero(Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString(), (int)this.Session["empresa"]))
        {
            case 1:
                ManejoError("Codigo de usuario existente por favor corrija", "I");
                break;

            case 0:
                nilblMensaje.Text = "";
                txtDocumento.Text = Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString();
                break;
        }
        ddlTipoID.Focus();
    }

    protected void imbProveedores_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Proveedor.aspx", false);
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
    }
    protected void imbCliente_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Clientes.aspx", false);
    }
    protected void ddlTipoID_SelectedIndexChanged(object sender, EventArgs e)
    {
        ManejoDocumento();
        comportamientoCampos();
    }

    private void ManejoDocumento()
    {
        if (ddlTipoID.SelectedValue == "31")
        {
            txtDv.Enabled = true;
        }
        else
        {

            txtDv.Enabled = false;

        }
    }

}
