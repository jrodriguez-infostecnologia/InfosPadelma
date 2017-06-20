using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using System.Configuration;
using System.Web;

public partial class Porteria_Padministracion_EntradaMp : System.Web.UI.Page
{
    #region Instancias

    Cvehiculos vehiculos = new Cvehiculos();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();


    #endregion Instancias

    #region Atributos

    object[] DatosProgramacion = new object[12];

    #endregion Atributos

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }


    private void ValidacionVehiculo(string remision, string vehiculo, string remolque)
    {
        if (vehiculos.VerificaRemisionEstado(remision, "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            this.nilblInformacion.Text = "La remisión ingresada no es válida";
            this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
            this.txtRemision.Text = "";
            return;
        }
        else
        {
            if (vehiculos.VerificaVehiculoEnPlanta(remolque,
                vehiculo, Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.nilblInformacion.Text = "Vehículo en planta no es posible realizar el registro de entrada";
                this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                this.txtLVehiculo.Text = "";
                return;
            }
        }
    }

    private void ManejoError(string error)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        this.Response.Redirect("~/Porteria/Error.aspx", false);
    }

    private void ManejoExito(string mensaje)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.lbRegistrar.Visible = false;
        this.lbCancelar.Visible = false;
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.ForeColor = System.Drawing.Color.Black;
        this.nilblInformacion.Text = mensaje;
        GetEntidad();
    }

    private void GetEntidad()
    {
        try
        {
            DataView vehi = vehiculos.GetVehiculosDesCargaPlanta(Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataSource = vehi;
            this.gvLista.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar vehículos en planta. Correspondiente a: " + ex.Message);
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

        this.Response.Redirect("~/Porteria/Error.aspx", false);
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

    private void CargarCampo()
    {

        try
        {

            this.ddlVehiculo.DataSource = vehiculos.SeleccionaVehiculos(Convert.ToInt16(this.Session["empresa"]));
            this.ddlVehiculo.DataValueField = "codigo";
            this.ddlVehiculo.DataTextField = "descripcion";
            this.ddlVehiculo.DataBind();
            this.ddlVehiculo.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar vehículo. Correspondiente a: " + ex.Message, "C");
        }
        try
        {

            this.ddlRemolque.DataSource = vehiculos.SeleccionaRemolques(Convert.ToInt16(this.Session["empresa"]));
            this.ddlRemolque.DataValueField = "codigo";
            this.ddlRemolque.DataTextField = "descripcion";
            this.ddlRemolque.DataBind();
            this.ddlRemolque.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar caja/remolque. Correspondiente a: " + ex.Message, "C");
        }
        try
        {

            ddlConductor.DataSource = vehiculos.SeleccionaConductores(Convert.ToInt16(this.Session["empresa"]));
            this.ddlConductor.DataValueField = "codigo";
            this.ddlConductor.DataTextField = "descripcion";
            this.ddlConductor.DataBind();
            this.ddlConductor.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conducto. Correspondiente a: " + ex.Message, "C");
        }


    }
    private void Guardar()
    {
        string remision, vehiculo, remolque, codigoConductor, nombreConductor;

        if (chkPropio.Checked)
        {
            remision = txtRemision.Text;
            vehiculo = ddlVehiculo.SelectedValue;
            remolque = ddlRemolque.SelectedValue;
            codigoConductor = ddlConductor.SelectedValue;
            nombreConductor = ddlConductor.SelectedItem.Text;
            ValidacionVehiculo(txtRemision.Text, ddlVehiculo.SelectedValue, ddlRemolque.SelectedValue);
        }

        else
        {
            remision = txtRemision.Text;
            vehiculo = txtLVehiculo.Text.Trim() + txtNVehiculo.Text.Trim();
            codigoConductor = txtIdConductor.Text;
            nombreConductor = txtNombreConductor.Text;
            ValidacionVehiculo(txtRemision.Text, txtLVehiculo.Text, "");
            remolque = txtRemolque.Text;
        }


        using (TransactionScope ts = new TransactionScope())
        {
            try
            {
                object[] objValores = new object[]{
                codigoConductor,
                Convert.ToInt16(Session["empresa"]),
                "EP",
                DateTime.Now,
                DateTime.Now,
                DateTime.Now,
                DateTime.Now,
                nombreConductor,
                this.txtRemision.Text,
                chkPropio.Checked,
                this.txtRemision.Text,
                remolque,
                "entrada",
                this.Session["usuario"].ToString(),
                vehiculo};


                switch (CentidadMetodos.EntidadInsertUpdateDelete("bRegistroPorteria", "inserta", "ppa", objValores))
                {
                    case 0:

                        switch (vehiculos.CambiaEstadoRemision(
                            this.txtRemision.Text,
                            "U", Convert.ToInt16(Session["empresa"])))
                        {
                            case 0:

                                ManejoExito("Registro insertado satisfactoriamente");
                                ts.Complete();
                                break;

                            case 1:

                                ManejoError("Error al cambiar el estado de la remisión seleccionada");
                                break;
                        }

                        break;

                    case 1:

                        ManejoError("Error al insertar el registro. Operación no realizada");
                        break;
                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al guardar el registro. Correspondiente a: " + ex.Message);
            }
        }
    }

    private void Cancelar()
    {
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.lbRegistrar.Visible = false;


        GetEntidad();
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
                if (!IsPostBack)
                {
                    GetEntidad();
                    this.txtLVehiculo.Focus();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }


        }
    }

    protected void chkPropio_CheckedChanged(object sender, EventArgs e)
    {
        lbRegistrar.Visible = false;
        txtRemision.Text = "";
        txtNVehiculo.Text = "";
        txtLVehiculo.Text = "";

        if (chkPropio.Checked)
        {
            ddlConductor.Visible = true;
            ddlRemolque.Visible = true;
            ddlVehiculo.Visible = true;
            txtLVehiculo.Visible = false;
            txtNVehiculo.Visible = false;
            txtIdConductor.Visible = false;
            lblRemolque.Visible = true;
            txtNombreConductor.Visible = false;
            lbCedula.Visible = false;
            lblNumero.Visible = false;
            lblLetra.Visible = false;
            txtRemolque.Visible = false;
        }
        else
        {
            ddlConductor.Visible = false;
            ddlRemolque.Visible = false;
            ddlVehiculo.Visible = false;
            lblRemolque.Visible = false;
            txtLVehiculo.Visible = true;
            txtNVehiculo.Visible = true;
            txtIdConductor.Visible = true;
            txtNombreConductor.Visible = true;
            lbCedula.Visible = true;
            lblNumero.Visible = true;
            lblLetra.Visible = true;
            txtRemolque.Visible = false;
        }
    }

    private void VerificaVehiculoenPlanta()
    {
        this.nilblInformacion.Text = "";
        try
        {
            if (chkPropio.Checked)
            {
                if (ddlVehiculo.SelectedValue.Length == 0)
                    CcontrolesUsuario.MensajeError("Debe seleccionar una placa", nilblInformacion);
                if (ddlRemolque.SelectedValue.Length == 0)
                    CcontrolesUsuario.MensajeError("Debe seleccionar una remolque", nilblInformacion);

                switch (vehiculos.VerificaVehiculoEnPlanta(this.ddlRemolque.SelectedValue, this.ddlVehiculo.SelectedValue, Convert.ToInt16(Session["empresa"])))
                {
                    case 1:
                        this.txtLVehiculo.Focus();
                        CcontrolesUsuario.MensajeError("Vehículo seleccionado en planta, no es posible registrar la entrada", nilblInformacion);
                        txtRemision.Enabled = false;
                        break;
                    case 2:
                        this.txtLVehiculo.Focus();
                        CcontrolesUsuario.MensajeError("Remolque/caja seleccionado en planta, no es posible registrar la entrada", nilblInformacion);
                        txtRemision.Enabled = false;
                        break;
                    case 0:
                        this.txtRemision.Focus();
                        txtRemision.Enabled = true;
                        break;
                }

            }
            else
            {
                if (txtLVehiculo.Text.Length > 0 & txtNVehiculo.Text.Length == 0)
                {
                    txtNVehiculo.Focus();
                    return;
                }

                if (txtLVehiculo.Text.Length == 0 & txtNVehiculo.Text.Length > 0)
                {
                    txtNVehiculo.Focus();
                    return;
                }

                if (txtLVehiculo.Text.Length == 0 || txtNVehiculo.Text.Length == 0)
                {
                    CcontrolesUsuario.MensajeError("Debe digitar una placa", nilblInformacion);
                    return;
                }
                

                switch (vehiculos.VerificaVehiculoEnPlanta("", txtLVehiculo.Text.Trim() + txtNVehiculo.Text.Trim(), Convert.ToInt16(Session["empresa"])))
                {
                    case 1:
                        this.txtLVehiculo.Text = "";
                        this.txtNVehiculo.Text = "";
                        this.txtLVehiculo.Focus();
                        CcontrolesUsuario.MensajeError("Vehículo digitado en planta, no es posible registrar la entrada", nilblInformacion);
                        txtRemision.Enabled = false;
                        break;
                    case 2:
                        this.txtLVehiculo.Text = "";
                        this.txtNVehiculo.Text = "";
                        this.txtLVehiculo.Focus();
                        CcontrolesUsuario.MensajeError("Remolque/caja digitado en planta, no es posible registrar la entrada", nilblInformacion);
                        txtRemision.Enabled = false;
                        break;
                    case 0:
                        this.txtIdConductor.Focus();
                        txtRemision.Enabled = true;
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar vehículo. Correspondiente a: " + ex.Message);
        }
    }

    protected void ddlVehiculo_SelectedIndexChanged(object sender, EventArgs e)
    {
        VerificaVehiculoenPlanta();
    }
    protected void ddlRemolque_SelectedIndexChanged(object sender, EventArgs e)
    {
        VerificaVehiculoenPlanta();
    }

    protected void ddlConductor_SelectedIndexChanged(object sender, EventArgs e)
    {
        txtRemision.Focus();
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        GetEntidad();
        lbRegistrar.Visible = false;
        nilbNuevo.Visible = true;
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
                                   nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        CargarCampo();

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.lbRegistrar.Visible = true;
        this.nilblInformacion.Text = "";
        lbRegistrar.Visible = false;
        lblRemolque.Visible = true;
        txtRemolque.Visible = true;
        ddlConductor.Visible = false;
        ddlRemolque.Visible = false;
        ddlVehiculo.Visible = false;
        this.txtLVehiculo.Focus();
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        Cancelar();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (txtRemision.Text.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Debe asignar un remisión", nilblInformacion);
            lbRegistrar.Visible = false;
            return;
        }

        if (chkPropio.Checked)
        {
            if (ddlConductor.SelectedValue.Length == 0 || ddlRemolque.SelectedValue.Length == 0 || ddlVehiculo.SelectedValue.Length == 0 )
            {
                CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblInformacion);
                lbRegistrar.Visible = false;
                return;
            }
        }
        else
        {
            if (txtLVehiculo.Text.Length == 0 || txtNVehiculo.Text.Length == 0 || txtIdConductor.Text.Length == 0 || txtNombreConductor.Text.Length == 0)
            {
                CcontrolesUsuario.MensajeError("Campos vacios por favor corrija", nilblInformacion);
                lbRegistrar.Visible = false;
                return;
            }
        }



        Guardar();
    }

    protected void Txt_Vehiculo_TextChanged(object sender, EventArgs e)
    {
        VerificaVehiculoenPlanta();
    }

    protected void niimbBuscar_Click1(object sender, ImageClickEventArgs e)
    {
        GetEntidad();
    }

    protected void txtRemolque_TextChanged(object sender, EventArgs e)
    {
        VerificaVehiculoenPlanta();
    }

    protected void txtIdConductor_TextChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";

        try
        {

            this.txtNombreConductor.Text = vehiculos.RetornaNombreConductor(this.txtIdConductor.Text, Convert.ToInt16(Session["empresa"]));

            if (txtNombreConductor.Text.Trim().Length > 0)
                this.txtRemision.Focus();
            else
                this.txtNombreConductor.Focus();
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar conductor. Correspondiente a: " + ex.Message);
        }
    }

    protected void txtRemision_TextChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";

        try
        {
            if (vehiculos.VerificaRemisionEstado(this.txtRemision.Text, "A", Convert.ToInt16(Session["empresa"])) == 0)
            {
                CcontrolesUsuario.MensajeError("La remisión ingresada no es válida", nilblInformacion);
                this.txtRemision.Text = "";
            }
            else
                this.lbRegistrar.Visible = true;
            this.txtRemision.Focus();
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la remisión. Correspondiente a: " + ex.Message);
        }
    }

    //protected void txtRemision_TextChanged1(object sender, EventArgs e)
    //{
    //    this.nilblInformacion.Text = "";

    //    if (vehiculos.VerificaRemisionEstado(
    //        ((TextBox)sender).Text,
    //        "A") == 0)
    //    {
    //        this.nilblInformacion.Text = "Remisión no valida";
    //        this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
    //        ((TextBox)sender).Text = "";
    //    }
    //    else
    //    {
    //        this.lbRegistrar.Visible = true;
    //    }
    //}

    #endregion Eventos







}
