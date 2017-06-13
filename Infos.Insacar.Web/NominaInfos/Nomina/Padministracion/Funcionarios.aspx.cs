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

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cterceros terceros = new Cterceros();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";

    Cfuncionarios funcionarios = new Cfuncionarios();

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void GetNombreTercero(string tercero)
    {
        try
        {
            string[] nombreTercero = funcionarios.RetornaNombreTercero(tercero, Convert.ToInt16(Session["empresa"]));
            this.txtDescripcion.Text = Convert.ToString(nombreTercero.GetValue(2));
            this.txtIdentificacion.Text = Convert.ToString(nombreTercero.GetValue(1));
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar el nombre del tercero. Correspondiente a: " + ex.Message, "C");
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

            this.gvLista.DataSource = funcionarios.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C", ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
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
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        nilblInformacion.Text = mensaje;
        nilblInformacion.ForeColor = System.Drawing.Color.Green;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        CcontrolesUsuario.InhabilitarControles(this.pnTercero.Controls);
        CcontrolesUsuario.LimpiarControles(this.pnTercero.Controls);
        this.nilbNuevo.Visible = true;
        this.fuFoto.Visible = false;
        this.imbFuncionario.Visible = false;
        txtFechaNacimiento.Visible = false;
        this.pnTercero.Visible = false;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlTercero.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet("cTercero", "ppa"), "razonSocial", "empleado", Convert.ToInt16(Session["empresa"]));
            this.ddlTercero.DataValueField = "id";
            this.ddlTercero.DataTextField = "razonSocial";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlCiudadNacimineto.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gCiudad", "ppa"), "nombre", Convert.ToInt16(Session["empresa"]));
            this.ddlCiudadNacimineto.DataValueField = "codigo";
            this.ddlCiudadNacimineto.DataTextField = "nombre";
            this.ddlCiudadNacimineto.DataBind();
            this.ddlCiudadNacimineto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar ciudades. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlNivelEducativo.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gNivelEducativo", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlNivelEducativo.DataValueField = "codigo";
            this.ddlNivelEducativo.DataTextField = "descripcion";
            this.ddlNivelEducativo.DataBind();
            this.ddlNivelEducativo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar nivel educativo. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView ciudad = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gCiudad", "ppa"), "nombre", Convert.ToInt16(this.Session["empresa"]));
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
        try
        {
            this.ddlRh.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gRh", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlRh.DataValueField = "codigo";
            this.ddlRh.DataTextField = "descripcion";
            this.ddlRh.DataBind();
            this.ddlRh.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar grupos sanguineos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView tipodocumento = CentidadMetodos.EntidadGet("gTipoDocumento", "ppa").Tables[0].DefaultView;
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
        cargarComboxDetalle();
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { Convert.ToInt16(Session["empresa"]), Convert.ToInt16(this.ddlTercero.SelectedValue) };
        try
        {
            if (CentidadMetodos.EntidadGetKey("nFuncionario", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Funcionario " + Convert.ToString(this.ddlTercero.SelectedValue) + " ya se encuentra registrado";
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
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
        string operacion = "inserta", cliente = null, proveedor = null, nivelEducativo = null;
        string operacionTer = "inserta";
        try
        {
            using (TransactionScope ts = new TransactionScope())
            {
                if (pnTercero.Visible == true)
                {
                    int id = 0;
                    object nit = null, dv = null, foto = null, contacto = null, telefono = null, direccion = null, barrio = null;
                    object fax = null, email = null, razonSocial = null, descripcion = null, identificacion = null;

                    if (this.fuFoto.HasFile)
                    {
                        //    this.fuFoto.SaveAs(Convert.ToString(ConfigurationManager.AppSettings["urlFoto"]) + Convert.ToString(txtIdentificacion.Text).Trim() + ".png");
                    }
                    else
                    {
                        if (operacion == "inserta" && chkValidaFoto.Checked == true)
                        {
                            CcontrolesUsuario.MensajeError("Debe seleccionar la foto del funcionario", nilblInformacion);
                            return;
                        }
                    }
                    if (Convert.ToBoolean(this.Session["editar"]) == true)
                    {
                        operacionTer = "actualiza";
                        id = Convert.ToInt16(this.Session["id"]);
                    }
                    else
                    {
                        switch (terceros.RetornaCodigoTercero(Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString(), Convert.ToInt16(Session["empresa"])))
                        {
                            case 1:
                                ManejoError("Código de usuario existente", "I");
                                return;
                        }
                        id = terceros.RetornaConsecutivoIdtercero(Convert.ToInt16(Session["empresa"]));
                    }

                    descripcion = txtApellido1.Text.Trim() + " " + txtApellido2.Text.Trim() + " " + txtNombre1.Text.Trim() + " " + txtNombre2.Text.Trim();
                    razonSocial = txtApellido1.Text.Trim() + " " + txtApellido2.Text.Trim() + " " + txtNombre1.Text.Trim() + " " + txtNombre2.Text.Trim();

                    if (ddlTipoID.SelectedValue.ToString().Trim().Length == 0)
                    {
                        CcontrolesUsuario.MensajeError("Seleccione un tipo de documento valido", nilblInformacion);
                        return;
                    }

                    if (txtDocumento.Text.Trim().Length == 0 || txtApellido1.Text.Trim().Length == 0 || txtNombre1.Text.Trim().Length == 0 || txtDireccion.Text.Trim().Length == 0 || ddlCiudad.SelectedValue.Length==0)
                    {
                        CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblInformacion);
                        return;
                    }

                    object[] objValores = new object[] {
                                        false,//@accionista
                                        chkActivo.Checked,//@activo
                                        txtApellido1.Text,//@apellido1
                                        txtApellido2.Text,//@apellido2
                                        "",//@barrio
                                        ddlCiudad.SelectedValue,//@cidudad
                                        false,//@cliente
                                        Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString(),//@codigo
                                        "",//@contacto
                                       false,//@contratista
                                        descripcion,//@descripcion
                                        txtDireccion.Text,//@direccion
                                        dv,//@dv
                                        null,//@email
                                        true,//@empleado
                                        Convert.ToInt16(this.Session["empresa"]),//@empresa
                                        false,   //extractora
                                        null,//@fax
                                        DateTime.Now,//@fechaRegistro
                                        foto,//@foto
                                        id,//@id
                                        txtDocumento.Text,//@nit
                                        txtNombre1.Text,//@nombre1
                                        txtNombre2.Text,//@nombre2
                                        false,//@proveedor
                                        razonSocial,//@razonSocial
                                        txtTelefono.Text,//@telefono
                                        "1",//@tipo
                                        ddlTipoID.SelectedValue//@tipoDocumento
            };
                    switch (CentidadMetodos.EntidadInsertUpdateDelete("cTercero", operacionTer, "ppa", objValores))
                    {
                        case 0:

                            if (Convert.ToBoolean(this.Session["editar"]) == true)
                                operacion = "actualiza";

                            if (ddlCliente.SelectedValue.Length == 0)
                                cliente = null;
                            else
                                cliente = ddlCliente.SelectedValue;
                            if (ddlProveedor.SelectedValue.Length == 0)
                                proveedor = null;
                            else
                                proveedor = ddlProveedor.SelectedValue;

                            if (ddlNivelEducativo.SelectedValue.Length == 0)
                                nivelEducativo = null;
                            else
                                nivelEducativo = ddlNivelEducativo.SelectedValue;

                            if (pnTercero.Visible == true)
                                identificacion = txtDocumento.Text.Trim();
                            else
                                identificacion = txtIdentificacion.Text.Trim();

                            object[] objValores1 = new object[]{                
                                this.chkActivo.Checked,
                                ddlCiudadNacimineto.SelectedValue,
                                cliente,
                                identificacion,
                                chkConductor.Checked,
                                chkContratista.Checked,
                                chkDeclarante.Checked,
                                descripcion,
                                Convert.ToInt16(Session["empresa"]),
                                chkExtranjero.Checked,
                                Convert.ToDateTime(txtFechaNacimiento.Text),
                                nivelEducativo,
                                chkOperador.Checked,
                                proveedor,
                                Convert.ToString(this.ddlRh.SelectedValue),
                                ddlSexo.SelectedValue,
                                Convert.ToInt16(id),
                                this.chkValidaTurno.Checked
                                };
                            switch (CentidadMetodos.EntidadInsertUpdateDelete("nFuncionario", operacion, "ppa", objValores1))
                            {
                                case 0:
                                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                                    ts.Complete();
                                    break;
                                case 1:
                                    ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                                    break;
                            }
                            break;
                        case 1:
                            ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                            break;
                    }
                }
                else
                {
                    if (Convert.ToBoolean(this.Session["editar"]) == true)
                        operacion = "actualiza";

                    if (ddlCliente.SelectedValue.Length == 0)
                        cliente = null;
                    else
                        cliente = ddlCliente.SelectedValue;
                    if (ddlProveedor.SelectedValue.Length == 0)
                        proveedor = null;
                    else
                        proveedor = ddlProveedor.SelectedValue;

                    if (ddlNivelEducativo.SelectedValue.Length == 0)
                        nivelEducativo = null;
                    else
                        nivelEducativo = ddlNivelEducativo.SelectedValue;

                    object[] objValores = new object[]{                
                            this.chkActivo.Checked,
                            ddlCiudadNacimineto.SelectedValue,
                            cliente,
                            txtIdentificacion.Text,
                            chkConductor.Checked,
                            chkContratista.Checked,
                            chkDeclarante.Checked,
                            txtDescripcion.Text,
                            Convert.ToInt16(Session["empresa"]),
                            chkExtranjero.Checked,
                            Convert.ToDateTime( txtFechaNacimiento.Text),
                            nivelEducativo,
                            chkOperador.Checked,
                            proveedor,
                            Convert.ToString(this.ddlRh.SelectedValue),
                            ddlSexo.SelectedValue,
                            Convert.ToInt16(this.ddlTercero.SelectedValue),
                            chkValidaTurno.Checked
                            };

                    switch (CentidadMetodos.EntidadInsertUpdateDelete("nFuncionario", operacion, "ppa", objValores))
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
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
               ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();
                if (Convert.ToString(this.ddlTercero.SelectedValue).Length > 0)
                    this.ddlCiudadNacimineto.Focus();
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                               nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        CcontrolesUsuario.InhabilitarControles(this.pnTercero.Controls);
        CcontrolesUsuario.LimpiarControles(this.pnTercero.Controls);
        foreach (Control c in pnTercero.Controls)
            CcontrolesUsuario.LimpiarControles(c.Controls);
        CcontrolesUsuario.HabilitarControles(this.pnTercero.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        CargarCombos();
        this.ddlTercero.Enabled = true;
        this.ddlTercero.Focus();
        txtDescripcion.Text = "";
        txtIdentificacion.Text = "";
        this.nilblInformacion.Text = "";
        this.txtDescripcion.Enabled = false;
        this.txtIdentificacion.Enabled = false;
        this.fuFoto.Visible = true;
        chkValidaFoto.Checked = true;
        chkManejaTercero.Text = "Crea tercero";
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        foreach (Control c in pnTercero.Controls)
            CcontrolesUsuario.LimpiarControles(c.Controls);
        this.pnTercero.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        txtFechaNacimiento.Visible = false;
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.fuFoto.Visible = false;
        this.imbFuncionario.Visible = false;
        chkManejaTercero.Text = "Crea tercero";
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        this.imbFuncionario.Visible = false;
        this.fuFoto.Visible = false;
        txtFechaNacimiento.Visible = false;
        GetEntidad();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (pnTercero.Visible == false)
        {
            if (txtDescripcion.Text.Length == 0 || ddlCiudadNacimineto.SelectedValue.Length == 0 || ddlTercero.SelectedValue.Length == 0 || ddlRh.SelectedValue.Length == 0)
            {
                CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblInformacion);
                return;
            }
        }
        if (chkContratista.Checked == true)
        {
            if (ddlProveedor.SelectedValue.Trim().Length == 0)
            {
                CcontrolesUsuario.MensajeError("Debe seleccionar un proveedor si es contratista", nilblInformacion);
                return;
            }
        }
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
        nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }
        CcontrolesUsuario.LimpiarControles(pnTercero.Controls);
        pnTercero.Visible = false;
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.nilblInformacion.Text = "";
        this.ddlTercero.Enabled = false;
        this.ddlCiudadNacimineto.Focus();
        this.txtDescripcion.Enabled = false;
        this.txtIdentificacion.Enabled = false;
        this.fuFoto.Visible = true;
        this.ddlTercero.Enabled = false;
        try
        {
            CargarCombos();
            DataView dvTercero = terceros.RetornaDatosTercero(this.gvLista.SelectedRow.Cells[3].Text.Trim(), Convert.ToInt16(Session["empresa"]));
            chkManejaTercero.Text = "Actualiza tercero";

            if (dvTercero.Table.Rows[0].ItemArray.GetValue(1) != null)
                this.Session["id"] = dvTercero.Table.Rows[0].ItemArray.GetValue(1).ToString();
            else
                this.Session["id"] = null;

            if (dvTercero.Table.Rows.Count > 0)
            {
                if (dvTercero.Table.Rows[0].ItemArray.GetValue(1) != null)
                {
                    txtCodigo.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(2).ToString();
                    txtCodigo.Enabled = false;
                }
                else
                    txtCodigo.Text = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(2) != null)
                    txtDocumento.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(5).ToString();
                else
                    txtDocumento.Text = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(3) != null)
                    ddlTipoID.SelectedValue = dvTercero.Table.Rows[0].ItemArray.GetValue(3).ToString().Trim();
                else
                    ddlTipoID.SelectedValue = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(8) != null)
                    txtApellido1.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(8).ToString();
                else
                    txtApellido1.Text = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(9) != null)
                    txtApellido2.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(9).ToString();
                else
                    txtApellido2.Text = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(10) != null)
                    txtNombre1.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(10).ToString();
                else
                    txtNombre1.Text = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(11) != null)
                    txtNombre2.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(11).ToString();
                else
                    txtNombre2.Text = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(25) != null)
                    txtDireccion.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(25).ToString();
                else
                    txtDireccion.Text = "";

                if (dvTercero.Table.Rows[0].ItemArray.GetValue(24) != null)
                    txtTelefono.Text = dvTercero.Table.Rows[0].ItemArray.GetValue(24).ToString();
                else
                    txtTelefono.Text = "";

                if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                {
                    this.ddlTercero.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text.Trim();
                    GetNombreTercero(this.gvLista.SelectedRow.Cells[3].Text);
                }

                if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                {
                    txtFechaNacimiento.Visible = true;
                    txtFechaNacimiento.Text = Convert.ToDateTime(this.gvLista.SelectedRow.Cells[5].Text).ToShortDateString();
                    niCalendarFechaNacimiento.SelectedDate = Convert.ToDateTime(this.gvLista.SelectedRow.Cells[5].Text);
                }

                if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                    this.ddlCiudadNacimineto.SelectedValue = this.gvLista.SelectedRow.Cells[6].Text;

                if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                    this.ddlSexo.SelectedValue = this.gvLista.SelectedRow.Cells[7].Text;

                if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                    this.ddlRh.SelectedValue = this.gvLista.SelectedRow.Cells[8].Text;

                if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                    this.ddlNivelEducativo.SelectedValue = this.gvLista.SelectedRow.Cells[9].Text;

                if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                    this.ddlProveedor.SelectedValue = this.gvLista.SelectedRow.Cells[10].Text;

                if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                    this.ddlCliente.SelectedValue = this.gvLista.SelectedRow.Cells[11].Text;

                foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
                {
                    if (objControl is CheckBox)
                        this.chkValidaTurno.Checked = ((CheckBox)objControl).Checked;
                }

                foreach (Control objControl in this.gvLista.SelectedRow.Cells[13].Controls)
                {
                    if (objControl is CheckBox)
                        this.chkConductor.Checked = ((CheckBox)objControl).Checked;
                }

                foreach (Control objControl in this.gvLista.SelectedRow.Cells[14].Controls)
                {
                    if (objControl is CheckBox)
                        this.chkOperador.Checked = ((CheckBox)objControl).Checked;
                }
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[15].Controls)
                {
                    if (objControl is CheckBox)
                        this.chkExtranjero.Checked = ((CheckBox)objControl).Checked;
                }
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[16].Controls)
                {
                    if (objControl is CheckBox)
                        this.chkDeclarante.Checked = ((CheckBox)objControl).Checked;
                }

                foreach (Control objControl in this.gvLista.SelectedRow.Cells[17].Controls)
                {
                    if (objControl is CheckBox)
                        this.chkContratista.Checked = ((CheckBox)objControl).Checked;
                }

                foreach (Control objControl in this.gvLista.SelectedRow.Cells[18].Controls)
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

        try
        {
            this.imbFuncionario.Visible = true;
            string urlFoto = ConfigurationManager.AppSettings["RutaFoto"] + Convert.ToString(txtIdentificacion.Text) + ".png";
            this.imbFuncionario.ImageUrl = urlFoto;
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al recuperar la foto del funcionario. Correspondiente a: " + ex.Message;
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }
        string operacion = "elimina";
        try
        {
            object[] objValores = new object[] { Convert.ToInt16(Session["empresa"]), Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[3].Text) };

            if (CentidadMetodos.EntidadInsertUpdateDelete("nFuncionario", operacion, "ppa", objValores) == 0)
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            else
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }

    protected void ddlFuncionario_SelectedIndexChanged(object sender, EventArgs e)
    {
        EntidadKey();
        GetNombreTercero(Convert.ToString(this.ddlTercero.SelectedValue));
    }

    private void cargarComboxDetalle()
    {
        try
        {
            DataView proveedor = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cxpProveedor", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"])); ;
            this.ddlProveedor.DataSource = proveedor;
            this.ddlProveedor.DataValueField = "idTercero";
            this.ddlProveedor.DataTextField = "descripcion";
            this.ddlProveedor.DataBind();
            this.ddlProveedor.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar proveedor. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView proveedor = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cxcCliente", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"])); ;
            this.ddlCliente.DataSource = proveedor;
            this.ddlCliente.DataValueField = "idTercero";
            this.ddlCliente.DataTextField = "descripcion";
            this.ddlCliente.DataBind();
            this.ddlCliente.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cliente. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void lbImprimir_Click(object sender, ImageClickEventArgs e)
    {
        //    string color="";

        //    if (this.ddlPlantilla.SelectedValue == "aceites")
        //    {
        //        color = "DarkGreen";
        //    }
        //    if (this.ddlPlantilla.SelectedValue == "contratista")
        //    {
        //        color = "DarkBlue";
        //    }
        //    if (this.ddlPlantilla.SelectedValue == "multicarga")
        //    {
        //        color = "DarkRed";
        //    }
        //    string impresion = "Informes.aspx?funcionario=" + this.ddlFuncionario.SelectedValue 
        //        + "&plantilla=" +this.ddlPlantilla.SelectedValue + "&color="+color;

        //abreVentana(impresion);

        //        this.Response.Redirect(impresion);
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaNacimiento.Visible = true;
        this.txtFechaNacimiento.Visible = false;
        this.niCalendarFechaNacimiento.SelectedDate = Convert.ToDateTime(null);
    }

    protected void chkManejaTercero_CheckedChanged1(object sender, EventArgs e)
    {
        foreach (Control c in pnTercero.Controls)
            CcontrolesUsuario.LimpiarControles(c.Controls);
        manejoPanel();
    }

    private void manejoPanel()
    {
        if (chkManejaTercero.Checked == true)
        {
            pnTercero.Visible = true;
            ddlTercero.Visible = false;
            lblTercero.Visible = false;
            txtIdentificacion.Visible = false;
            txtDescripcion.Visible = false;
            lblIdentifiacion.Visible = false;
            lblDescripcion.Visible = false;
            ddlTipoID.SelectedValue = "13";
            ddlTipoID.Enabled = false;
        }
        else
        {
            pnTercero.Visible = false;
            lblTercero.Visible = true;
            txtIdentificacion.Visible = true;
            txtDescripcion.Visible = true;
            lblIdentifiacion.Visible = true;
            lblDescripcion.Visible = true;
            ddlTercero.Visible = true;
        }
    }

    protected void txtCodigo_TextChanged(object sender, EventArgs e)
    {
        try
        {
            switch (terceros.RetornaCodigoTercero(Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString(), Convert.ToInt16(Session["empresa"])))
            {
                case 1:
                    ManejoError("Codigo usuario existente", "C");
                    break;
                case 0:
                    nilblInformacion.Text = "";
                    txtDocumento.Text = Convert.ToInt32(Convert.ToDecimal(txtCodigo.Text)).ToString();
                    break;
            }
            txtDocumento.Focus();
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar usuario debido a:" + ex.Message, "C");
        }
    }

    protected void chkContratista_CheckedChanged(object sender, EventArgs e)
    {
        chkActivo.Checked = !chkContratista.Checked;
    }

    protected void chkActivo_CheckedChanged(object sender, EventArgs e)
    {
        chkContratista.Checked = !chkActivo.Checked;
        cargarComboxDetalle();
    }

    protected void chkValidaFoto_CheckedChanged(object sender, EventArgs e)
    {
        if (chkValidaFoto.Checked)
            fuFoto.Visible = true;
        else
            fuFoto.Visible = false;
    }

    protected void niCalendarFechaSalida_SelectionChanged(object sender, EventArgs e)
    {
        txtFechaNacimiento.Text = niCalendarFechaNacimiento.SelectedDate.ToShortDateString();
        txtFechaNacimiento.Enabled = false;
        txtFechaNacimiento.Visible = true;
        niCalendarFechaNacimiento.Visible = false;
    }

    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            DateTime fechaNacimiento;
            fechaNacimiento = Convert.ToDateTime(txtFechaNacimiento.Text);
        }
        catch (Exception ex)
        {
            CcontrolesUsuario.MensajeError("Formato de fecha incorrecto", nilblInformacion);
        }

    }

    #endregion Eventos
   
}
