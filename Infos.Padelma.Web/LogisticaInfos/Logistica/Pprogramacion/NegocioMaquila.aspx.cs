using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_NegocioMaquila : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CnegocioMaquila negocio = new CnegocioMaquila();
    CIP ip = new CIP();
    List<CanalisisNegocio> listaAnalisis = new List<CanalisisNegocio>();
    CanalisisNegocio analisis;
    List<CproductoMaquila> listaMaquila = new List<CproductoMaquila>();
    CproductoMaquila maquila;


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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            this.gvLista.DataSource = negocio.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
            gvAnalisis.DataSource = null;
            gvAnalisis.DataBind();
            gvMaquila.DataSource = null;
            gvMaquila.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C",
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

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Logistica/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        
        upMaquila.Visible = false;
        CcontrolesUsuario.HabilitarControles(upMaquila.Controls);
        CcontrolesUsuario.LimpiarControles(upMaquila.Controls);
        gvMaquila.DataSource = null;
        gvMaquila.DataBind();
        Session["maquila"] = null;

        upAnalisis.Visible = false;
        CcontrolesUsuario.HabilitarControles(upAnalisis.Controls);
        CcontrolesUsuario.LimpiarControles(upAnalisis.Controls);
        gvAnalisis.DataSource = null;
        gvAnalisis.DataBind();
        Session["analisis"] = null;

        GetEntidad();
    }
    private void CargarCombos()
    {
        try
        {
            this.ddlProveedor.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet("cTercero", "ppa"), "razonSocial", "proveedor", Convert.ToInt16(Session["empresa"]));
            this.ddlProveedor.DataValueField = "codigo";
            this.ddlProveedor.DataTextField = "razonSocial";
            this.ddlProveedor.DataBind();
            this.ddlProveedor.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar proveedor. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlProcedencia.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("bProcedencia", "ppa"), "codigo", Convert.ToInt16(Session["empresa"]));
            this.ddlProcedencia.DataValueField = "codigo";
            this.ddlProcedencia.DataTextField = "codigo";
            this.ddlProcedencia.DataBind();
            this.ddlProcedencia.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar procedencia. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView dvItems = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvItems.RowFilter = "empresa = " + Session["empresa"].ToString() + " and activo=1 and tipo='P'";
            this.ddlProduccto.DataSource = dvItems;
            this.ddlProduccto.DataValueField = "codigo";
            this.ddlProduccto.DataTextField = "descripcion";
            this.ddlProduccto.DataBind();
            this.ddlProduccto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar producto. Correspondiente a: " + ex.Message, "C");
        }

        CargarComboAnalisis();

    }

    private void CargarComboAnalisis()
    {

        try
        {
            DataView dvItems = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvItems.RowFilter = "empresa = " + Session["empresa"].ToString() + " and activo=1 and tipo='M'";
            this.ddlAnalisis.DataSource = dvItems;
            this.ddlAnalisis.DataValueField = "codigo";
            this.ddlAnalisis.DataTextField = "descripcion";
            this.ddlAnalisis.DataBind();
            this.ddlAnalisis.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar analisis. Correspondiente a: " + ex.Message, "C");
        }


    }
    private void CargarComboProductoMaquila()
    {
        try
        {
            DataView dvItems = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvItems.RowFilter = "empresa = " + Session["empresa"].ToString() + " and activo=1 and tipo='P'";
            this.ddlProductosMaquila.DataSource = dvItems;
            this.ddlProductosMaquila.DataValueField = "codigo";
            this.ddlProductosMaquila.DataTextField = "descripcion";
            this.ddlProductosMaquila.DataBind();
            this.ddlProductosMaquila.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar productos de maquila. Correspondiente a: " + ex.Message, "C");
        }


    }
    private void EntidadKey()
    {
        object[] objKey = new object[] { Convert.ToInt16(Session["empresa"]), this.txtNumero.Text.Trim().ToString(), ddlProveedor.SelectedValue };
        try
        {
            if (CentidadMetodos.EntidadGetKey("logNegocio", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                CcontrolesUsuario.MensajeError("Número y proveedor " + this.txtNumero.Text + " ya se encuentra registrado", nilblInformacion);
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                this.nilbNuevo.Visible = true;
                upMaquila.Visible = false;
                CcontrolesUsuario.HabilitarControles(upMaquila.Controls);
                CcontrolesUsuario.LimpiarControles(upMaquila.Controls);
                gvMaquila.DataSource = null;
                gvMaquila.DataBind();
                Session["maquila"] = null;

                upAnalisis.Visible = false;
                CcontrolesUsuario.HabilitarControles(upAnalisis.Controls);
                CcontrolesUsuario.LimpiarControles(upAnalisis.Controls);
                gvAnalisis.DataSource = null;
                gvAnalisis.DataBind();
                Session["analisis"] = null;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }
    protected void Guardar()
    {
        string operacion = "inserta";
        bool validar = false;

        try
        {
            using (TransactionScope ts = new TransactionScope())
            {
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                    operacion = "actualiza";

                object[] objValores = new object[]{
                    chkActivo.Checked, //Activo
                    false,
                    Convert.ToInt16(Session["empresa"]),//@empresa
                    null,
                    Convert.ToDateTime(txtFechaInicio.Text),
                    DateTime.Now,//@fechaRegistro
                    chkMaquila.Checked,
                    Convert.ToDecimal(txtNumero.Text),
                    chkPorRecibido.Checked,
                    ddlProcedencia.SelectedValue,
                    ddlProduccto.SelectedValue,//@producto
                    ddlProveedor.SelectedValue,
                    Convert.ToDecimal(txvTolerancia.Text),
                    null,
                    Convert.ToString(Session["usuario"])//@usuario
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("logNegocio", operacion, "ppa", objValores))
                {
                    case 0:
                        if (Convert.ToBoolean(this.Session["editar"]))
                        {
                            foreach (GridViewRow r2 in gvAnalisis.Rows)
                            {
                                object[] objValoresEliminaDetalle = new object[] { Convert.ToInt16(this.Session["empresa"]), Convert.ToDecimal(txtNumero.Text), ddlProveedor.SelectedValue,Convert.ToDecimal(r2.Cells[1].Text.Trim())};

                                switch (CentidadMetodos.EntidadInsertUpdateDelete("logNegocioDetalle", "elimina", "ppa", objValoresEliminaDetalle))
                                {
                                    case 1:
                                        validar = true;
                                        break;
                                }
                            }

                            foreach (GridViewRow r2 in gvMaquila.Rows)
                            {
                                object[] objValoresEliminaDetalle = new object[] { Convert.ToInt16(this.Session["empresa"]), Convert.ToDecimal(txtNumero.Text), ddlProveedor.SelectedValue, Convert.ToDecimal(r2.Cells[1].Text.Trim()) };

                                switch (CentidadMetodos.EntidadInsertUpdateDelete("logNegocioMaquila", "elimina", "ppa", objValoresEliminaDetalle))
                                {
                                    case 1:
                                        validar = true;
                                        break;
                                }
                            }

                        }

                        foreach (GridViewRow r in gvAnalisis.Rows)
                        {
                            object[] objValoresDetalle = new object[]{
                                    Convert.ToInt16(r.Cells[2].Text),
                                    Convert.ToInt32(((CheckBox)r.FindControl("chkAnalisis")).Checked) ,  
                                    Convert.ToInt16( this.Session["empresa"]),//@empresa
                                     Convert.ToDecimal(txtNumero.Text),
                                     ddlProveedor.SelectedValue,
                                    Convert.ToInt16(r.Cells[1].Text), //@registro
                                    Convert.ToDecimal(((TextBox)r.FindControl("txvPorAnalisis")).Text)   
                                     };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("logNegocioDetalle", "inserta", "ppa", objValoresDetalle))
                            {
                                case 1:
                                    validar = true;
                                    break;
                            }

                        }

                        foreach (GridViewRow r in gvMaquila.Rows)
                        {
                            object[] objValoresDetalle = new object[]{
                                    
                                    Convert.ToInt32(((CheckBox)r.FindControl("chkActivoM")).Checked) ,  
                                    Convert.ToInt16( this.Session["empresa"]),//@empresa
                                     Convert.ToDecimal(txtNumero.Text),
                                     Convert.ToInt16(r.Cells[2].Text),
                                     ddlProveedor.SelectedValue,
                                    Convert.ToInt16(r.Cells[1].Text), //@registro
                                    Convert.ToDecimal(((TextBox)r.FindControl("txvPorMaquila")).Text)   
                                     };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete("logNegocioMaquila", "inserta", "ppa", objValoresDetalle))
                            {
                                case 1:
                                    validar = true;
                                    break;
                            }
                        }
                        break;
                }

                if (validar == true)
                {
                    ManejoError("Error al insertar datos", operacion.Substring(0, 1).ToUpper());
                    return;
                }

                ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                ts.Complete();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }

    }
    private void cargarMaquila()
    {
        
        upMaquila.Visible = true;
        CcontrolesUsuario.HabilitarControles(upMaquila.Controls);
        CcontrolesUsuario.LimpiarControles(upMaquila.Controls);
        gvMaquila.DataSource = null;
        gvMaquila.DataBind();

        List<CproductoMaquila> listaTransaccion = null;
        this.Session["maquila"] = null;
        foreach (DataRowView dv in negocio.SeleccionaMaquilaNegocio(Convert.ToInt32(this.Session["empresa"]), txtNumero.Text.Trim(), ddlProveedor.SelectedValue.ToString()))
        {

            maquila = new CproductoMaquila(dv.Row.ItemArray.GetValue(0).ToString(), dv.Row.ItemArray.GetValue(1).ToString(), Convert.ToInt32(dv.Row.ItemArray.GetValue(2)), Convert.ToInt32(dv.Row.ItemArray.GetValue(3)), Convert.ToBoolean(dv.Row.ItemArray.GetValue(4)));

            if (this.Session["maquila"] == null)
            {
                listaTransaccion = new List<CproductoMaquila>();
                listaTransaccion.Add(maquila);
                this.Session["maquila"] = listaTransaccion;
            }
            else
            {
                listaTransaccion = (List<CproductoMaquila>)Session["maquila"];
                listaTransaccion.Add(maquila);
            }
        }

        this.Session["maquila"] = listaTransaccion;
        gvMaquila.DataSource = listaTransaccion;
        gvMaquila.DataBind();
        gvMaquila.Visible = true;


        if (gvMaquila.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.nilblMensajeMaquila.Visible = true;
            this.nilblMensajeMaquila.Text = "no hay registros realizados";
        }
        else
        {
            this.nilblMensajeMaquila.Visible = false;
            this.nilblMensajeMaquila.Text = "";
            this.lbRegistrar.Visible = true;
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
                nitxtBusqueda.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        gvAnalisis.DataSource = null;
        gvAnalisis.DataBind();
        gvMaquila.DataSource = null;
        gvMaquila.DataBind();
        Session["analaisis"] = null;
        Session["maquila"] = null;
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.txtNumero.Focus();
        this.nilblInformacion.Text = "";

        upAnalisis.Visible = true;
        CcontrolesUsuario.HabilitarControles(upAnalisis.Controls);
        CcontrolesUsuario.LimpiarControles(upAnalisis.Controls);
        gvAnalisis.DataSource = null;
        gvAnalisis.DataBind();
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvAnalisis.DataSource = null;
        this.gvAnalisis.DataBind();
        this.gvMaquila.DataSource = null;
        this.gvMaquila.DataBind();
        Session["canales"] = null;
        gvAnalisis.Visible = false;
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";

        upMaquila.Visible = false;
        CcontrolesUsuario.HabilitarControles(upMaquila.Controls);
        CcontrolesUsuario.LimpiarControles(upMaquila.Controls);
        gvMaquila.DataSource = null;
        gvMaquila.DataBind();
        Session["maquila"] = null;

        upAnalisis.Visible = false;
        CcontrolesUsuario.HabilitarControles(upAnalisis.Controls);
        CcontrolesUsuario.LimpiarControles(upAnalisis.Controls);
        gvAnalisis.DataSource = null;
        gvAnalisis.DataBind();
        Session["analisis"] = null;
    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            bool validar = false;
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }
            
            object[] objValores = new object[] {
                Convert.ToInt16(Session["empresa"]),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)),
                Session["usuario"].ToString()
            };

            if (validar == false)
            {
                switch (CentidadMetodos.EntidadInsertUpdateDelete("logNegocio", "elimina", "ppa", objValores))
                {
                    case 0:
                        ManejoExito("Registro eliminado satisfactoriamente", "E");
                        break;
                    case 1:
                        ManejoError("Error al eliminar el registro. Operación no realizada", "E");
                        break;
                }
            }
            else
                ManejoError("Error al eliminar el registro. Operación no realizada", "E");
        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro. " + ex.Message, "E");
            }
            else
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
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
        if (gvAnalisis.Rows.Count == 0)
        {
            CcontrolesUsuario.MensajeError("Debe ingresar analisis para continuar", nilblInformacion);
            return;
        }

        if (gvMaquila.Rows.Count == 0 && chkMaquila.Checked)
        {
            CcontrolesUsuario.MensajeError("Debe ingresar un producto de maquila para continuar", nilblInformacion);
            return;
        }

        if (ddlProveedor.SelectedValue.Trim().Length == 0 || this.txtNumero.Text.Trim().Length == 0 || this.txvTolerancia.Text.Trim().Length == 0 || ddlProcedencia.SelectedValue.Trim().Length == 0 || ddlProduccto.SelectedValue.Trim().Length == 0 || ddlProduccto.SelectedValue.Trim().Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblInformacion);
            return;
        }

        Guardar();
    }
    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        bool anulado = false;
        foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
        {
            if (objControl is CheckBox)
                anulado = ((CheckBox)objControl).Checked;
        }

        if (anulado == true)
        {
            CcontrolesUsuario.MensajeError("El registro se encuentra anulado no es posible su edición.", nilblInformacion);
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        CargarCombos();
       
        this.txtNumero.Enabled = false;
        ddlProveedor.Enabled = false;

       

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txtNumero.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            else
                this.txtNumero.Text = "";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.ddlProveedor.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
                ddlProcedencia.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                ddlProduccto.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.txtFechaInicio.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
            else
                this.txtFechaInicio.Text = "";

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                this.txvTolerancia.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);
            else
                this.txvTolerancia.Text = "0";

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[10].Controls)
            {
                if (objControl is CheckBox)
                    this.chkMaquila.Checked = ((CheckBox)objControl).Checked;
            }

            if (chkMaquila.Checked == true)
            {
                CargarComboProductoMaquila();
                cargarMaquila();
            }
            else
                upMaquila.Visible = false;
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[11].Controls)
            {
                if (objControl is CheckBox)
                    this.chkActivo.Checked = ((CheckBox)objControl).Checked;
            }
            foreach (Control objControl in this.gvLista.SelectedRow.Cells[12].Controls)
            {
                if (objControl is CheckBox)
                    this.chkPorRecibido.Checked = ((CheckBox)objControl).Checked;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
        cargarAnalisis();
    }
    protected void cargarAnalisis()
    {

        upAnalisis.Visible = true;
        CcontrolesUsuario.HabilitarControles(upAnalisis.Controls);
        CcontrolesUsuario.LimpiarControles(upAnalisis.Controls);
        gvAnalisis.DataSource = null;
        gvAnalisis.DataBind();

        List<CanalisisNegocio> listaTransaccion = null;
        this.Session["analisis"] = null;
        foreach (DataRowView dv in negocio.SeleccionaAnalisisNegocio(Convert.ToInt32(this.Session["empresa"]), txtNumero.Text.Trim(), ddlProveedor.SelectedValue.ToString()))
        {

            analisis = new CanalisisNegocio(dv.Row.ItemArray.GetValue(0).ToString(), dv.Row.ItemArray.GetValue(1).ToString(), Convert.ToInt32(dv.Row.ItemArray.GetValue(2)), Convert.ToInt32(dv.Row.ItemArray.GetValue(3)), Convert.ToBoolean(dv.Row.ItemArray.GetValue(4)));

            if (this.Session["analisis"] == null)
            {
                listaTransaccion = new List<CanalisisNegocio>();
                listaTransaccion.Add(analisis);
                this.Session["analisis"] = listaTransaccion;
            }
            else
            {
                listaTransaccion = (List<CanalisisNegocio>)Session["analisis"];
                listaTransaccion.Add(analisis);
            }
        }

        this.Session["analisis"] = listaTransaccion;
        gvAnalisis.DataSource = listaTransaccion;
        gvAnalisis.DataBind();
        gvAnalisis.Visible = true;


        if (gvAnalisis.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.nilblMensajeAnalisis.Visible = true;
            this.nilblMensajeAnalisis.Text = "no hay registros realizados";
        }
        else
        {
            this.nilblMensajeAnalisis.Visible = false;
            this.nilblMensajeAnalisis.Text = "";
            this.lbRegistrar.Visible = true;
        }
    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }

    #endregion Eventos


    protected void gvCanal_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string analisis = Convert.ToString(this.gvAnalisis.Rows[e.RowIndex].Cells[2].Text.Trim());
        int registro = 1;

        listaAnalisis = null;
        listaAnalisis = (List<CanalisisNegocio>)this.Session["analisis"];

        listaAnalisis.RemoveAt(e.RowIndex);

        foreach (CanalisisNegocio ca in listaAnalisis)
        {
            if (ca.Analisis == analisis)
            {
                ca.Registro = registro;
                registro++;
            }
        }
        gvAnalisis.DataSource = listaAnalisis;
        gvAnalisis.DataBind();
        Session["analisis"] = listaAnalisis;

    }


    protected void btnCargar_Click(object sender, ImageClickEventArgs e)
    {
        if (txvProcentaleAnalisis.Text.Length == 0 || ddlAnalisis.SelectedValue.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblMensajeAnalisis);
            return;
        }

        bool valida = false;
        foreach (GridViewRow r2 in gvAnalisis.Rows)
        {
            if (r2.Cells[2].Text.Trim() == ddlAnalisis.SelectedValue)
                valida = true;
        }
        if (valida == true)
        {
            CcontrolesUsuario.MensajeError("El analisis seleccionado ya se encuentra regitrado, por favor corrija.", nilblMensajeAnalisis);
            return;
        }

        if (gvAnalisis.Rows.Count == 0)
            Session["registroAnalisis"] = 0;

        decimal registro = Convert.ToDecimal(Session["registroAnalisis"]), porcentajeAnalisis = Convert.ToDecimal(txvProcentaleAnalisis.Text);
        listaAnalisis = null;


        if (this.Session["analisis"] == null)
        {
            listaAnalisis = new List<CanalisisNegocio>();
            analisis = new CanalisisNegocio(ddlAnalisis.SelectedValue, ddlAnalisis.SelectedItem.ToString(), gvAnalisis.Rows.Count + 1, Convert.ToDecimal(txvProcentaleAnalisis.Text), chkBaseCalculo.Checked);
            listaAnalisis.Add(analisis);
            this.Session["analisis"] = listaAnalisis;
        }
        else
        {
            listaAnalisis = (List<CanalisisNegocio>)this.Session["analisis"];
            analisis = new CanalisisNegocio(ddlAnalisis.SelectedValue, ddlAnalisis.SelectedItem.ToString(), gvAnalisis.Rows.Count + 1, Convert.ToDecimal(txvProcentaleAnalisis.Text), chkBaseCalculo.Checked);
            listaAnalisis.Add(analisis);
            this.Session["analisis"] = listaAnalisis;
        }

        gvAnalisis.Visible = true;
        gvAnalisis.DataSource = listaAnalisis;
        gvAnalisis.DataBind();

        if (gvAnalisis.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.nilblMensajeAnalisis.Visible = true;
            this.nilblMensajeAnalisis.Text = "no hay registros realizados";
        }
        else
        {
            this.nilblMensajeAnalisis.Visible = false;
            this.nilblMensajeAnalisis.Text = "";
            this.lbRegistrar.Visible = true;
        }

        txvProcentaleAnalisis.Text = "0";
        chkBaseCalculo.Checked = false;

    }
    protected void txtFechaInicio_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaInicio.Text);
        }
        catch
        {
            nilblInformacion.Text = "Formato de fecha no valido";
            txtFechaInicio.Text = "";
            txtFechaInicio.Focus();
            return;
        }
    }
    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.CalendarFechaInicio.Visible = true;
        this.txtFechaInicio.Visible = false;
        this.CalendarFechaInicio.SelectedDate = Convert.ToDateTime(null);
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaInicio.Visible = false;
        this.txtFechaInicio.Visible = true;
        this.txtFechaInicio.Text = this.CalendarFechaInicio.SelectedDate.ToShortDateString();

    }
    protected void btnCargarProductos_Click(object sender, ImageClickEventArgs e)
    {
        if (txvProcentajeMaquila.Text.Length == 0 || ddlProductosMaquila.SelectedValue.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblMensajeMaquila);
            return;
        }

        bool valida = false;
        if (gvMaquila.Rows.Count > 0)
        {
            foreach (GridViewRow r2 in gvMaquila.Rows)
            {
                if (r2.Cells[2].Text.Trim() == ddlProductosMaquila.SelectedValue)
                    valida = true;
            }
            if (valida == true)
            {
                nilblMensajeMaquila.Visible = true;
                CcontrolesUsuario.MensajeError("El producto seleccionado ya se encuentra regitrado, por favor corrija.", nilblMensajeMaquila);
                return;
            }
        }

        if (gvMaquila.Rows.Count == 0)
            Session["registroProducto"] = 0;

        decimal registro = Convert.ToDecimal(Session["registroProducto"]), porcentajeProducto = Convert.ToDecimal(txvProcentajeMaquila.Text);
        listaMaquila = null;

        if (this.Session["maquila"] == null)
        {
            listaMaquila = new List<CproductoMaquila>();
            maquila = new CproductoMaquila(ddlProductosMaquila.SelectedValue, ddlProductosMaquila.SelectedItem.ToString(), gvMaquila.Rows.Count + 1, Convert.ToDecimal(txvProcentajeMaquila.Text), chkActivoMaquila.Checked);
            listaMaquila.Add(maquila);
            this.Session["maquila"] = listaMaquila;
        }
        else
        {
            listaMaquila = (List<CproductoMaquila>)this.Session["maquila"];
            maquila = new CproductoMaquila(ddlProductosMaquila.SelectedValue, ddlProductosMaquila.SelectedItem.ToString(), gvMaquila.Rows.Count + 1, Convert.ToDecimal(txvProcentajeMaquila.Text), chkActivoMaquila.Checked);
            listaMaquila.Add(maquila);
            this.Session["maquila"] = listaMaquila;
        }

        gvMaquila.Visible = true;
        gvMaquila.DataSource = listaMaquila;
        gvMaquila.DataBind();

        if (gvMaquila.Rows.Count <= 0)
        {
            this.lbRegistrar.Visible = false;
            this.nilblMensajeMaquila.Visible = true;
            this.nilblMensajeMaquila.Text = "no hay registros realizados";
        }
        else
        {
            this.nilblMensajeMaquila.Visible = false;
            this.nilblMensajeMaquila.Text = "";
            this.lbRegistrar.Visible = true;
        }
        txvProcentajeMaquila.Text = "0";
        chkActivoMaquila.Checked = false;

    }
    protected void txtNumero_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }
    protected void chkSession_CheckedChanged(object sender, EventArgs e)
    {
        manejaMaquila();
    }

    private void manejaMaquila()
    {
        if (chkMaquila.Checked)
        {
            upMaquila.Visible = true;
            CcontrolesUsuario.HabilitarControles(upMaquila.Controls);
            CcontrolesUsuario.LimpiarControles(upMaquila.Controls);
            gvMaquila.DataSource = null;
            gvMaquila.DataBind();
            CargarComboProductoMaquila();
            ddlProductosMaquila.Focus();

        }
        else
        {
            upMaquila.Visible = false;
            CcontrolesUsuario.HabilitarControles(upMaquila.Controls);
            CcontrolesUsuario.LimpiarControles(upMaquila.Controls);
            gvMaquila.DataSource = null;
            gvMaquila.DataBind();
            Session["rangos"] = null;
        }
    }
    protected void gvMaquila_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string producto = Convert.ToString(this.gvMaquila.Rows[e.RowIndex].Cells[2].Text.Trim());
        int registro = 1;

        listaMaquila = null;
        listaMaquila = (List<CproductoMaquila>)this.Session["maquila"];

        listaMaquila.RemoveAt(e.RowIndex);

        foreach (CproductoMaquila ca in listaMaquila)
        {
            if (ca.Producto == producto)
            {
                ca.Registro = registro;
                registro++;
            }
        }
        gvMaquila.DataSource = listaMaquila;
        gvMaquila.DataBind();
        Session["maquila"] = listaMaquila;
    }
}
