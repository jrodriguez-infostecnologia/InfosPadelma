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

public partial class Logistica_Pprogramacion_ProgramacionVehiculos : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cprogramacion programacion = new Cprogramacion();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Cvehiculos vehiculos = new Cvehiculos();


    #endregion Instancias

    #region Metodos
    private void manejoPropio()
    {

        if (chkPropio.Checked == true)
        {
            this.ddlVehiculo.Visible = true;
            this.ddlRemolque.Visible = true;
            this.ddlConductor.Visible = true;
            this.lblConductor.Visible = true;
            this.lblCconductor.Visible = false;
            this.lblNombreConductor.Visible = false;
            txtNombreConductor.Visible = false;
            txtConductor.Visible = false;
            this.txtLVehiculo.Visible = false;
            this.txtNVehiculo.Visible = false;
            this.txtRemolque.Visible = false;
            this.lblSeparador.Visible = false;
            lblLetra.Visible = false;
            lblNumero.Visible = false;
            CargaVehiculosPropios();
        }
        else
        {
            this.ddlVehiculo.Visible = false;
            this.ddlRemolque.Visible = false;
            this.ddlConductor.Visible = false;
            this.lblConductor.Visible = false;
            this.lblCconductor.Visible = true;
            this.lblNombreConductor.Visible = true;
            txtNombreConductor.Visible = true;
            txtConductor.Visible = true;
            this.txtLVehiculo.Visible = true;
            this.txtNVehiculo.Visible = true;
            this.txtRemolque.Visible = true;
            lblLetra.Visible = true;
            lblNumero.Visible = true;
            this.lblSeparador.Visible = true;


        }
    }

    private void CargaVehiculosPropios()
    {
        try
        {
            this.ddlVehiculo.DataSource = vehiculos.GetVehiculosPropios(
                (int)this.Session["empresa"]);
            this.ddlVehiculo.DataValueField = "codigo";
            this.ddlVehiculo.DataTextField = "descripcion";
            this.ddlVehiculo.DataBind();
            this.ddlVehiculo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al seleccionar vehículos propios. Correpondiente a: " + ex.Message;
        }

        try
        {
            this.ddlRemolque.DataSource = vehiculos.GetRemolquesPropios(
                 (int)this.Session["empresa"]);
            this.ddlRemolque.DataValueField = "codigo";
            this.ddlRemolque.DataTextField = "codigo";
            this.ddlRemolque.DataBind();
            this.ddlRemolque.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al seleccionar remolques propios. Correpondiente a: " + ex.Message;
        }

        try
        {
            DataView conductor = vehiculos.GetConductoresPropiosProgramacion((int)this.Session["empresa"]);
            ddlConductor.DataSource = conductor;
            this.ddlConductor.DataValueField = "codigo";
            this.ddlConductor.DataTextField = "descripcion";
            this.ddlConductor.DataBind();
            this.ddlConductor.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al cargar  conductor. Correspondiente a: " + ex.Message;
        }
    }

    private void GetEntidad()
    {
        try
        {
            this.gvLista.DataSource = programacion.GetProgramacionCargaProgramacionGrl(Convert.ToString(Session["programacion"]), "P", Convert.ToInt16(Session["empresa"]));

            this.gvLista.DataBind();

            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
        }
        catch (Exception ex)
        {
            ManejoError("Errora al cargar las programaciones" + ex.Message, "C");
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

        this.Response.Redirect("~/Logistica/Error.aspx", false);
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

    private void SucursalCliente()
    {
        try
        {
            DataView dvCliente = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "cxcCliente", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));

            dvCliente.RowFilter = "idTercero =" + ddlCliente.SelectedValue;
            this.ddlSucursal.DataSource = dvCliente;
            this.ddlSucursal.DataValueField = "codigo";
            this.ddlSucursal.DataTextField = "descripcion";
            this.ddlSucursal.DataBind();
            this.ddlSucursal.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar lugares de entrega. Correspondiente a: " + ex.Message, "C");
        }

    }

    protected void CargarCombos()
    {

        try
        {
            this.ddlCliente.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet(
                "cTercero", "ppa"), "razonSocial", "cliente", Convert.ToInt16(Session["empresa"]));
            this.ddlCliente.DataValueField = "id";
            this.ddlCliente.DataTextField = "razonSocial";
            this.ddlCliente.DataBind();
            this.ddlCliente.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar clientes. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView productosProduccion = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            productosProduccion.RowFilter = "tipo in('P','T')";
            this.ddlProducto.DataSource = productosProduccion;
            this.ddlProducto.DataValueField = "codigo";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();
            this.ddlProducto.SelectedValue = Convert.ToString(programacion.ValoresProgramacion(Session["programacion"].ToString(), Convert.ToInt16(Session["empresa"])).GetValue(2));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar novedades. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView productosProduccion = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            productosProduccion.RowFilter = "empresa = " + Session["empresa"].ToString() + " and tipo in('CC') and activo=1";
            this.ddlProductoCertificado.DataSource = productosProduccion;
            this.ddlProductoCertificado.DataValueField = "codigo";
            this.ddlProductoCertificado.DataTextField = "descripcion";
            this.ddlProductoCertificado.DataBind();
            //this.ddlProductoCertificado.SelectedValue = Convert.ToString(programacion.ValoresProgramacion(Session["programacion"].ToString(), Convert.ToInt16(Session["empresa"])).GetValue(2));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar certificados. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlComercializadora.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet(
                "cTercero", "ppa"), "razonSocial", "comercializadora", Convert.ToInt16(Session["empresa"]));
            this.ddlComercializadora.DataValueField = "id";
            this.ddlComercializadora.DataTextField = "razonSocial";
            this.ddlComercializadora.DataBind();
            this.ddlComercializadora.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar comercializadoras. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPlanta.DataSource = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet(
                "cTercero", "ppa"), "razonSocial", "extractora", Convert.ToInt16(Session["empresa"]));
            this.ddlPlanta.DataValueField = "id";
            this.ddlPlanta.DataTextField = "razonSocial";
            this.ddlPlanta.DataBind();
            this.ddlPlanta.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar terceros. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta", numero = "";
        DateTime fecha = DateTime.Today;
        object[] objValores = new object[23];
        string vehiculo = "";
        string remolque = "";
        string cConductor = "";
        string nConductor = "";

        if (chkPropio.Checked == true)
        {
            vehiculo = ddlVehiculo.SelectedValue.Trim();
            remolque = ddlRemolque.SelectedValue.Trim();
            cConductor = ddlConductor.SelectedValue.Trim();
            nConductor = ddlConductor.SelectedItem.Text;
        }
        else
        {
            vehiculo = this.txtLVehiculo.Text + txtNVehiculo.Text;
            remolque = txtRemolque.Text.Trim();
            cConductor = txtConductor.Text.Trim();
            nConductor = txtNombreConductor.Text.Trim();
        }

        if (Convert.ToString(this.CalendarFechaDespacho.SelectedDate).Length == 0 || Convert.ToString(this.ddlCliente.SelectedValue).Length == 0 ||
            Convert.ToString(this.ddlProducto.SelectedValue).Length == 0 || this.txvCantidad.Text.Length == 0 ||
            Convert.ToString(this.ddlComercializadora.SelectedValue).Length == 0 || (this.txtLVehiculo.Text.Length == 0 & chkPropio.Checked == false) ||
            (this.txtNVehiculo.Text.Length == 0 & chkPropio.Checked == false) || (this.txtRemolque.Text.Length == 0 & chkPropio.Checked == false) ||
            (this.txtConductor.Text.Length == 0 & chkPropio.Checked == false) || (this.txtNombreConductor.Text.Length == 0 & chkPropio.Checked == false) ||
            (ddlConductor.SelectedValue.Trim().Length == 0 & chkPropio.Checked == true) || (ddlRemolque.SelectedValue.Trim().Length == 0 & chkPropio.Checked == true) ||
            (ddlVehiculo.SelectedValue.Trim().Length == 0 & chkPropio.Checked == true) || Convert.ToString(this.ddlPlanta.SelectedValue).Length == 0 ||
            Convert.ToString(this.ddlProductoCertificado.SelectedValue).Length == 0 || Convert.ToString(this.ddlSucursal.SelectedValue).Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                fecha = Convert.ToDateTime(this.Session["fecha"].ToString());
                numero = Session["proVehiculo"].ToString();

                objValores.SetValue(Convert.ToDecimal(this.txvCantidad.Text), 0);//@cantidad
                objValores.SetValue(ddlProductoCertificado.SelectedValue, 1);//@certificado
                objValores.SetValue(Convert.ToString(this.ddlSucursal.SelectedValue), 2);//@cliente
                objValores.SetValue(cConductor, 3);//@codigoConductor
                objValores.SetValue(Convert.ToString(this.ddlComercializadora.SelectedValue), 4);//@comercializadora
                objValores.SetValue(null, 5);//@comercializadora
                objValores.SetValue(Convert.ToInt16(Session["empresa"]), 6);//@empresa
                objValores.SetValue("P", 7);//@estado
                objValores.SetValue(fecha, 8);//@fecha
                objValores.SetValue(this.CalendarFechaDespacho.SelectedDate, 9);//@fechaDespacho
                objValores.SetValue(DateTime.Now, 10);//@fechaRegistro
                objValores.SetValue(nConductor, 11);//@nombreConductor
                objValores.SetValue(numero, 12);//@numeroTransaccion
                objValores.SetValue(Server.HtmlDecode(this.txtObservacion.Text), 13);//@observacion
                objValores.SetValue(Convert.ToString(this.ddlPlanta.SelectedValue), 14);//@planta
                objValores.SetValue(Convert.ToString(this.ddlProducto.SelectedValue), 15);//@producto
                objValores.SetValue(Session["programacion"].ToString(), 16);//@programacionCarga
                objValores.SetValue(remolque, 17);//@remolque
                objValores.SetValue(Convert.ToString(this.ddlCliente.SelectedValue), 18);//@tercero
                objValores.SetValue(ConfigurationManager.AppSettings["tipoProgramacion"].ToString(), 19);//@tipo
                objValores.SetValue(Session["usuario"].ToString(), 20);//@usuario
                objValores.SetValue(vehiculo, 21);//@vehiculo
                objValores.SetValue(Convert.ToBoolean(chkPropio.Checked), 22);//@vehiculoPropio
            }
            else
            {
                numero = tipoTransaccion.RetornaConsecutivo(ConfigurationManager.AppSettings["tipoProgramacion"].ToString(), Convert.ToInt16(Session["empresa"]));
                fecha = DateTime.Now;

                objValores.SetValue(Convert.ToDecimal(this.txvCantidad.Text), 0);//@cantidad
                objValores.SetValue(ddlProductoCertificado.SelectedValue, 1);//@certificado
                objValores.SetValue(Convert.ToString(this.ddlSucursal.SelectedValue), 2);//@cliente
                objValores.SetValue(cConductor, 3);//@codigoConductor
                objValores.SetValue(Convert.ToString(this.ddlComercializadora.SelectedValue), 4);//@comercializadora
                objValores.SetValue(null, 5);//@comercializadora
                objValores.SetValue(Convert.ToInt16(Session["empresa"]), 6);//@empresa
                objValores.SetValue("P", 7);//@estado
                objValores.SetValue(fecha, 8);//@fecha
                objValores.SetValue(this.CalendarFechaDespacho.SelectedDate, 9);//@fechaDespacho
                objValores.SetValue(DateTime.Now, 10);//@fechaRegistro
                objValores.SetValue(nConductor, 11);//@nombreConductor
                objValores.SetValue(numero, 12);//@numeroTransaccion
                objValores.SetValue(Server.HtmlDecode(this.txtObservacion.Text), 13);//@observacion
                objValores.SetValue(Convert.ToString(this.ddlPlanta.SelectedValue), 14);//@planta
                objValores.SetValue(Convert.ToString(this.ddlProducto.SelectedValue), 15);//@producto
                objValores.SetValue(Session["programacion"].ToString(), 16);//@programacionCarga
                objValores.SetValue(remolque, 17);//@remolque
                objValores.SetValue(Convert.ToString(this.ddlCliente.SelectedValue), 18);//@tercero
                objValores.SetValue(ConfigurationManager.AppSettings["tipoProgramacion"].ToString(), 19);//@tipo
                objValores.SetValue(Session["usuario"].ToString(), 20);//@usuario
                objValores.SetValue(vehiculo, 21);//@vehiculo
                objValores.SetValue(Convert.ToBoolean(chkPropio.Checked), 22);//@vehiculoPropio
            }

            using (TransactionScope ts = new TransactionScope())
            {
                switch (CentidadMetodos.EntidadInsertUpdateDelete("logProgramacionVehiculo", operacion, "ppa", objValores))
                {
                    case 0:

                        if (Convert.ToBoolean(this.Session["editar"]) == true)
                        {
                            CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                            GetEntidad();
                            ManejoExito("Datos insertados satisfactoriamente", "I");
                            ts.Complete();
                        }
                        else
                        {
                            switch (tipoTransaccion.ActualizaConsecutivo(ConfigurationManager.AppSettings["tipoProgramacion"].ToString(), Convert.ToInt16(Session["empresa"])))
                            {
                                case 0:
                                    CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                                    GetEntidad();
                                    ManejoExito("Datos insertados satisfactoriamente", "I");
                                    ts.Complete();
                                    break;
                                case 1:
                                    ManejoError("Error al actualizar consecutivo de transacción. Operación no realizada", "I");
                                    break;
                            }
                        }
                        break;
                    case 1:
                        ManejoError("Errores al insertar el registro. Operación no realizada", "I");
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al insertar el registro. Correspondiente a: " + ex.Message, "I");
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
            if (!IsPostBack)
            {
                CargarCombos();
                GetEntidad();
            }
        }
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CargarCombos();
        this.txtFechaDespacho.ReadOnly = true;
        this.ddlProducto.Enabled = false;
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.txtLVehiculo.Focus();
        this.nilblInformacion.Text = "";
        ddlVehiculo.Visible = false;
        ddlConductor.Visible = false;
        ddlRemolque.Visible = false;
        chkPropio.Checked = false;
        lblConductor.Visible = false;

    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        chkPropio.Checked = false;
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        GetEntidad();
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
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {

        object[] Objprogramacion = new object[50];
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.ddlProducto.Enabled = false;
        this.txtNVehiculo.Enabled = false;
        this.txtLVehiculo.Enabled = false;
        this.txtRemolque.Focus();
        string lvehiculo = "", nvehiculo = "";
        bool propio = false;

        try
        {
            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.Session["programacion"] = Convert.ToString(this.gvLista.SelectedRow.Cells[8].Text);

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                this.Session["proVehiculo"] = Convert.ToString(this.gvLista.SelectedRow.Cells[9].Text);

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                Session["fecha"] = Convert.ToString(this.gvLista.SelectedRow.Cells[2].Text);

            CargarCombos();
            Objprogramacion = programacion.GetPRogramacionCargaKey(Convert.ToInt16(Session["empresa"]), this.gvLista.SelectedRow.Cells[9].Text.Trim(), this.gvLista.SelectedRow.Cells[10].Text.Trim());

            foreach (char i in Convert.ToString(Objprogramacion.GetValue(5)).ToCharArray())
            {
                if (char.IsDigit(i))
                    nvehiculo += i;
                else
                    lvehiculo += i;
            }

            propio = Convert.ToBoolean(Objprogramacion.GetValue(4));
            chkPropio.Checked = propio;
            manejoPropio();
            if (propio == true)
            {
                this.ddlRemolque.SelectedValue = Convert.ToString(Objprogramacion.GetValue(11));
                this.ddlVehiculo.SelectedValue = lvehiculo + nvehiculo;
                this.ddlConductor.SelectedValue = Convert.ToString(Objprogramacion.GetValue(7));
            }
            else
            {
                this.txtRemolque.Text = Convert.ToString(Objprogramacion.GetValue(11));
                this.txtConductor.Text = Convert.ToString(Objprogramacion.GetValue(7));
                this.txtNombreConductor.Text = Convert.ToString(Objprogramacion.GetValue(8));
                this.txtLVehiculo.Text = lvehiculo;
                this.txtNVehiculo.Text = nvehiculo;
            }

            this.txvCantidad.Text = Convert.ToString(Objprogramacion.GetValue(15));
            this.txtFechaDespacho.Text = Convert.ToString(Objprogramacion.GetValue(10));
            this.CalendarFechaDespacho.SelectedDate = Convert.ToDateTime(Objprogramacion.GetValue(10));
            this.ddlComercializadora.SelectedValue = Convert.ToString(Objprogramacion.GetValue(13));
            this.txtObservacion.Text = Convert.ToString(Objprogramacion.GetValue(16));
            this.ddlCliente.SelectedValue = Convert.ToString(Objprogramacion.GetValue(14));
            SucursalCliente();
            ddlSucursal.SelectedValue = Convert.ToString(Objprogramacion.GetValue(19));
            this.ddlProducto.SelectedValue = Convert.ToString(Objprogramacion.GetValue(12));
            ddlPlanta.SelectedValue = Convert.ToString(Objprogramacion.GetValue(17));
            ddlProductoCertificado.SelectedValue = Convert.ToString(Objprogramacion.GetValue(22));
        }
        catch (Exception ex)
        {
            ManejoError("Error al mostrar los datos" + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                Convert.ToInt16(Session["empresa"]),
                                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[9].Text),
                                this.gvLista.Rows[e.RowIndex].Cells[10].Text
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "logProgramacionVehiculo",
                operacion,
                "ppa",
                objValores) == 0)
            {
                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

                GetEntidad();

                ManejoExito("Datos eliminados satisfactoriamente", "E");
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.CalendarFechaDespacho.Visible = true;
        this.txtFechaDespacho.Visible = false;
        this.CalendarFechaDespacho.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        if (this.CalendarFechaDespacho.SelectedDate >= DateTime.Now.Date)
        {
            nilblInformacion.Text = "";
            this.CalendarFechaDespacho.Visible = false;
            this.txtFechaDespacho.Visible = true;
            this.txtFechaDespacho.Text = this.CalendarFechaDespacho.SelectedDate.ToString();
            this.txvCantidad.Focus();
        }
        else
            nilblInformacion.Text = "La fecha de programación no puede ser inferior a la fecha de hoy";
    }

    protected void nilbRegresar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("~/Logistica/Pprogramacion/Programacion.aspx");
    }

    protected void txtConductor_TextChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        this.txtNombreConductor.Text = "";

        try
        {
            this.txtNombreConductor.Text = programacion.RetornaNombreConductor(
                this.txtConductor.Text, Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al recuperar nombre de conductor.";
        }

        if (this.txtNombreConductor.Text.Trim().Length == 0)
        {
            this.txtNombreConductor.Focus();
            this.txtNombreConductor.Enabled = true;
        }
        else
        {
            this.lbFechaDespacho.Focus();
            this.txtNombreConductor.Enabled = false;
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
    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("~/Logistica/Pprogramacion/Programacion.aspx");
    }


    protected void ddlCliente_SelectedIndexChanged(object sender, EventArgs e)
    {
        SucursalCliente();

    }

    #endregion Eventos


    protected void Txt_Vehiculo_TextChanged(object sender, EventArgs e)
    {
        if (txtLVehiculo.Text.Length > 0 & txtNVehiculo.Text.Length == 0)
            txtNVehiculo.Focus();

        if (txtLVehiculo.Text.Length == 0 & txtNVehiculo.Text.Length > 0)
            txtNVehiculo.Focus();

        if (txtNVehiculo.Text.Length > 0 & txtLVehiculo.Text.Length > 0)
            this.txtRemolque.Focus();
    }
    protected void chkPropio_CheckedChanged(object sender, EventArgs e)
    {
        manejoPropio();
    }

}