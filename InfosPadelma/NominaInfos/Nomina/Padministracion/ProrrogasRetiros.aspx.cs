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

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Ccontratos contratos = new Ccontratos();
    cProrroga prorroga = new cProrroga();
    Cfuncionarios funcionarios = new Cfuncionarios();
    DateTime fechaContratoIndefinido = Convert.ToDateTime("1901-01-01 00:00:00.000");


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

            this.gvLista.DataSource = prorroga.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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

        CcontrolesUsuario.LimpiarControles(this.pnProrroga.Controls);

        CcontrolesUsuario.LimpiarControles(this.pnRetiro.Controls);
        pnProrroga.Visible = false;
        pnRetiro.Visible = false;

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
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(this.pnProrroga.Controls);

        CcontrolesUsuario.LimpiarControles(this.pnRetiro.Controls);
        pnProrroga.Visible = false;
        pnRetiro.Visible = false;

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
        object[] objKey = new object[] { this.txtCodigo.Text.Trim().ToString(), Convert.ToInt16(Session["empresa"]) };

        try
        {
            if (CentidadMetodos.EntidadGetKey("nDepartamento", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Departamento " + this.txtCodigo.Text + " ya se encuentra registrado";
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
        string operacion = "inserta";
        string codigo = null;

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            string fechaFinal = Convert.ToDateTime(null).ToShortDateString();
            string fechaFinalAnterior = Convert.ToDateTime(null).ToShortDateString();
            string fechaInicial = Convert.ToDateTime(null).ToShortDateString();
            string fechaRetiro = Convert.ToDateTime(null).ToShortDateString();
            string motivoRetiro = null;
            string observacion = "";
            bool retirado = false;
            decimal dias = 0;

            if (ddlTipoRegistro.SelectedValue.Trim() == "P")
            {
                fechaInicial = Convert.ToDateTime(txtFechaInicial.Text).ToShortDateString();
                fechaFinal = Convert.ToDateTime(txtFechaFinal.Text).ToShortDateString();
                fechaFinalAnterior = Convert.ToDateTime(txtUltimaFechaFinal.Text).ToShortDateString();
                observacion = txtObservacion.Text;
                dias = Convert.ToDecimal(txtDias.Text);
                codigo = prorroga.Consecutivo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue.Trim(), "P");
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                    codigo = txtCodigo.Text;
            }
            else
            {
                fechaInicial = Convert.ToDateTime(txtFechaInicialR.Text).ToShortDateString();
                fechaFinal = Convert.ToDateTime(txtFechaFinalR.Text).ToShortDateString();
                fechaRetiro = Convert.ToDateTime(txtFecha.Text).ToShortDateString();
                motivoRetiro = ddlMotivo.SelectedValue.Trim();
                retirado = true;
                observacion = txtObservacionRetiro.Text;
                codigo = prorroga.Consecutivo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue.Trim(), "R");
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                    codigo = txtCodigo.Text;
            }


            object[] objValores = new object[]{  
                                  ddlContrato.SelectedValue.Trim(),  //@contrato
                                  dias, //@dias
                                  Convert.ToInt16(Session["empresa"]), //@empresa
                                   fechaFinal ,//@fechaFinal
                                   fechaFinalAnterior, //@fechaFinalAnterior
                                   fechaInicial, //@fechaInicial
                                    DateTime.Now,//@fechaRegistro
                                    fechaRetiro,//@fechaRetiro
                                  codigo, //@id
                                   motivoRetiro, //@motivoRetiro
                                  observacion,  //@observacion
                                    retirado,//@retirado
                                   ddlEmpleado.SelectedValue.Trim(), //@tercero
                                   ddlTipoRegistro.SelectedValue.Trim(), //@tipo
                                   this.Session["usuario"].ToString() //@usuario

                                        };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("nProrroga", operacion, "ppa", objValores))
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

    private void CargarCombos()
    {
        try
        {
            DataView dvFuncionarios = funcionarios.RetornaTercerosContratosActivos(Convert.ToInt16(Session["empresa"]));
            this.ddlEmpleado.DataSource = dvFuncionarios;
            this.ddlEmpleado.DataValueField = "tercero";
            this.ddlEmpleado.DataTextField = "descripcion";
            this.ddlEmpleado.DataBind();
            this.ddlEmpleado.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlMotivo.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(
                CentidadMetodos.EntidadGet("nMotivoRetiro", "ppa"),
                "descripcion", "activo", Convert.ToInt16(Session["empresa"]));
            this.ddlMotivo.DataValueField = "codigo";
            this.ddlMotivo.DataTextField = "descripcion";
            this.ddlMotivo.DataBind();
            this.ddlMotivo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
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
        CcontrolesUsuario.LimpiarControles(pnProrroga.Controls);

        CargarCombos();

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.txtCodigo.Enabled = false;
        this.ddlContrato.Focus();
        this.nilblInformacion.Text = "";
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {


        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
           this.pnProrroga.Controls);

        CcontrolesUsuario.LimpiarControles(
           this.pnRetiro.Controls);

        ddlMotivo.DataSource = null;
        ddlMotivo.DataBind();

        ddlEmpleado.DataSource = null;
        ddlEmpleado.DataBind();
        ddlContrato.DataSource = null;
        ddlContrato.DataBind();

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.pnProrroga.Visible = false;
        this.pnRetiro.Visible = false;
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        //CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.pnProrroga.Controls);
        CcontrolesUsuario.LimpiarControles(this.pnRetiro.Controls);

        ddlMotivo.DataSource = null;
        ddlMotivo.DataBind();

        ddlEmpleado.DataSource = null;
        ddlEmpleado.DataBind();
        ddlContrato.DataSource = null;
        ddlContrato.DataBind();

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.pnProrroga.Visible = false;
        this.pnRetiro.Visible = false;

        this.nilbNuevo.Visible = true;

        GetEntidad();

    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (pnProrroga.Visible == true)
        {
            if (txtCodigo.Text.Length == 0 || ddlContrato.SelectedValue.Length == 0 || txtDias.Text.Trim().Length == 0)
            {
                nilblMensaje.Text = "Campos vacios por favor corrija";
                return;
            }
        }
        else
        {
            if (txtCodigoRetiro.Text.Length == 0 || ddlContrato.SelectedValue.Length == 0 || ddlMotivo.SelectedValue.Trim().Length == 0)
            {
                nilblMensaje.Text = "Campos vacios por favor corrija";
                return;
            }
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
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.txtCodigo.Enabled = false;
        this.ddlContrato.Enabled = false;
        this.ddlTipoRegistro.Enabled = false;


        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.ddlTipoRegistro.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
            }
            else
            {
                this.ddlTipoRegistro.SelectedValue = "";
            }

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
            {
                ddlEmpleado.SelectedValue = this.gvLista.SelectedRow.Cells[8].Text.Trim();
            }
            else
            {
                ddlEmpleado.SelectedValue = "";
            }

            manejoContrato();

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                ddlContrato.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text.Trim();
            }
            else
            {
                ddlContrato.SelectedValue = "";
            }



            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = this.gvLista.SelectedRow.Cells[2].Text;
            }
            else
            {
                this.txtCodigo.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigoRetiro.Text = this.gvLista.SelectedRow.Cells[2].Text;
            }
            else
            {
                this.txtCodigoRetiro.Text = "";
            }


            manejoTipo();



            //if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            //{
            //    this.txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            //}
            //else
            //{
            //    this.txtDescripcion.Text = "";
            //}

            //if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            //{
            //    this.ddlContrato.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;
            //}

            //if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            //{
            //    foreach (Control objControl in this.gvLista.SelectedRow.Cells[5].Controls)
            //    {
            //        if (objControl is CheckBox)
            //        {
            //            this.chkActivo.Checked = ((CheckBox)objControl).Checked;
            //        }
            //    }
            //}
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                      ConfigurationManager.AppSettings["Modulo"].ToString(),
                                       nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                          Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text.Trim())),
                          Convert.ToInt16(Session["empresa"]),  //@empresa
                           Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[1].Text.Trim())),//@id
                           Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[11].Text.Trim())), //@tercero
                           Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text.Trim())), //@tipo
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "nProrroga",
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

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }



    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();

    }
    #endregion Eventos




    protected void ddlEmpleado_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoContrato();
        ddlTipoRegistro.SelectedValue = "P";

    }

    private void manejoContrato()
    {
        if (ddlEmpleado.SelectedValue.Trim().Length > 0)
        {

            try
            {
                DataView contra = contratos.RetornaContratosTercero(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim());
                this.ddlContrato.DataSource = contra;
                this.ddlContrato.DataValueField = "id";
                this.ddlContrato.DataTextField = "contrato";
                this.ddlContrato.DataBind();
                this.ddlContrato.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar contratos. Correspondiente a: " + ex.Message, "C");
            }
        }
        else
        {
            nilblInformacion.Text = "Por favor seleccione un empleado valido";
            return;
        }
    }




    private void manejoTipo()
    {
        CcontrolesUsuario.LimpiarControles(pnProrroga.Controls);
        CcontrolesUsuario.LimpiarControles(pnRetiro.Controls);
        txtFechaFinalR.Enabled = false;
        lbFechaFinal.Enabled = false;


        if (ddlContrato.SelectedValue.Trim().Length > 0)
        {
            switch (ddlTipoRegistro.SelectedValue.Trim())
            {
                case "P":
                    pnProrroga.Visible = true;
                    pnRetiro.Visible = false;
                    CcontrolesUsuario.LimpiarControles(pnProrroga.Controls);
                    txtCodigo.Text = prorroga.Consecutivo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue.Trim(), ddlTipoRegistro.SelectedValue.Trim());
                    DataView con = contratos.RetornaDatosContrato(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), Convert.ToInt16(ddlContrato.SelectedValue.Trim()));
                    if (con.Table.Rows.Count > 0)
                    {
                        if (prorroga.verificaUltimaFechaProrroga(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue, "P").Length > 0)
                        {
                            txtUltimaFechaFinal.Text = Convert.ToDateTime(prorroga.verificaUltimaFechaProrroga(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue, "P")).ToShortDateString();
                            txtFechaInicial.Text = Convert.ToDateTime(prorroga.verificaUltimaFechaProrroga(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue, "P")).ToShortDateString();
                        }
                        else
                        {
                            if (con.Table.Rows[0].ItemArray.GetValue(22).ToString().Trim().Length > 0)
                            {
                                if (Convert.ToDateTime(con.Table.Rows[0].ItemArray.GetValue(22).ToString()) != fechaContratoIndefinido)
                                {
                                    txtDias.Focus();
                                    txtUltimaFechaFinal.Text = Convert.ToDateTime(con.Table.Rows[0].ItemArray.GetValue(22).ToString()).ToShortDateString();
                                    txtFechaInicial.Text = Convert.ToDateTime(con.Table.Rows[0].ItemArray.GetValue(22).ToString()).ToShortDateString();
                                }
                                else
                                {
                                    txtUltimaFechaFinal.Text = "";
                                    txtFechaInicial.Text = "";
                                    ddlTipoRegistro.SelectedValue = "R";
                                    manejoTipo();

                                }
                            }
                            else
                            {
                                txtUltimaFechaFinal.Text = "";
                                txtFechaInicial.Text = "";
                                ddlTipoRegistro.SelectedValue = "R";
                                manejoTipo();
                            }

                        }
                    }
                    break;

                case "R":
                    pnProrroga.Visible = false;
                    pnRetiro.Visible = true;
                    txtCodigoRetiro.Text = prorroga.Consecutivo(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue.Trim(), ddlTipoRegistro.SelectedValue.Trim());

                    DataView con2 = contratos.RetornaDatosContrato(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), Convert.ToInt16(ddlContrato.SelectedValue.Trim()));
                    if (con2.Table.Rows.Count > 0)
                    {
                        txtFechaInicialR.Text = Convert.ToDateTime(con2.Table.Rows[0].ItemArray.GetValue(20).ToString()).ToShortDateString();
                        if (prorroga.verificaUltimaFechaProrroga(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue, "P").Length > 0)
                        {
                            txtFechaFinalR.Text = Convert.ToDateTime(prorroga.verificaUltimaFechaProrroga(Convert.ToInt16(Session["empresa"]), ddlEmpleado.SelectedValue.Trim(), ddlContrato.SelectedValue, "P")).ToShortDateString();
                        }
                        else
                        {
                            if (con2.Table.Rows[0].ItemArray.GetValue(22).ToString().Length > 0)
                            {
                                if (Convert.ToDateTime(con2.Table.Rows[0].ItemArray.GetValue(22).ToString()) != fechaContratoIndefinido)
                                {
                                    txtFechaFinalR.Text = Convert.ToDateTime(con2.Table.Rows[0].ItemArray.GetValue(22).ToString()).ToShortDateString();
                                }
                                else
                                {
                                    txtFecha.Focus();
                                    txtFechaFinalR.Enabled = true;
                                    lbFechaFinal.Enabled = true;
                                    txtFechaFinalR.Text = DateTime.Now.ToShortDateString();
                                    txtFechaFinalR.Focus();
                                }
                            }
                            else
                            {
                                txtFecha.Focus();
                                txtFechaFinalR.Enabled = true;
                                lbFechaFinal.Enabled = true;
                                txtFechaFinalR.Text = DateTime.Now.ToShortDateString();
                                txtFechaFinalR.Focus();
                            }
                        }
                    }
                    break;
            }

        }
        else
        {
            nilblInformacion.Text = "Seleccione un contrato valido";
            return;
        }
    }
    protected void ddlContrato_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoTipo();
    }

    protected void txtDias_TextChanged(object sender, EventArgs e)
    {

        //string decimalDias = (Convert.ToDecimal(txtDias.Text) / 30).ToString();
        //int meses = Convert.ToInt16((decimalDias.Split('.')[0]));
        //decimal dias = Convert.ToDecimal(txtDias.Text) - (meses * 30) - 1;
        DateTime fechaFinal = Convert.ToDateTime(txtFechaInicial.Text);
        //fechaFinal = fechaFinal.AddMonths(meses);
        double dias = Convert.ToDouble(Convert.ToDecimal(txtDias.Text));
        fechaFinal = fechaFinal.AddDays(dias);
        txtFechaFinal.Text = fechaFinal.ToShortDateString();
        txtObservacion.Focus();
    }


    protected void lbFechaIngreso_Click(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }
    protected void niCalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToShortDateString();
    }
    protected void ddlTipoRegistro_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            manejoTipo();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar el tipo de registro debido a:  " + ex.Message, "I");
        }

    }
    protected void niCalendarFechaFinal_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaFinal.Visible = false;
        this.txtFechaFinalR.Visible = true;
        this.txtFechaFinalR.Text = this.niCalendarFecha.SelectedDate.ToShortDateString();
    }
    protected void lbFechaFinal_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaFinal.Visible = true;
        this.txtFechaFinalR.Visible = false;
        this.niCalendarFechaFinal.SelectedDate = Convert.ToDateTime(null);
    }
    protected void txtFechaFinalR_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaFinalR.Text);
        }
        catch (Exception ex)
        {
            nilblInformacion.Text = "Fecha no valida";
            txtFechaFinalR.Text = "";
            txtFechaFinalR.Focus();
            return;
        }

    }
    protected void txtFecha_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFecha.Text);
        }
        catch (Exception ex)
        {
            nilblInformacion.Text = "Fecha no valida";
            txtFecha.Text = "";
            txtFecha.Focus();
            return;
        }

    }
}
