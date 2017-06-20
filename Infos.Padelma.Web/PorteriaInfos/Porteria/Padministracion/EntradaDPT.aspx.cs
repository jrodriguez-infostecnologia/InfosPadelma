using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using System.Configuration;
using System.Web;

public partial class Porteria_Padministracion_EntradaDPT : System.Web.UI.Page
{
    #region Instancias

    Cvehiculos vehiculos = new Cvehiculos();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cvehiculos servicio = new Cvehiculos();
    Biocosta.swBiocosta biocosta = new Biocosta.swBiocosta();
    CIP ip = new CIP();
    object[] DatosProgramacion = new object[12];

    #endregion Instancias

    #region Metodos

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }


    private void ValidacionVehiculo()
    {
        string registro = "";
        Session["numero"] = null;
        try
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

            if (vehiculos.verificaVehiculoPropio(txtLVehiculo.Text.Trim() + txtNVehiculo.Text.Trim(), Convert.ToInt16(Session["empresa"])) == 0)
            {
                if (vehiculos.VerificaProgramacionPlanta(txtLVehiculo.Text.Trim() + txtNVehiculo.Text.Trim(), Convert.ToInt16(Session["empresa"])).Count > 0)
                {
                    this.nilblInformacion.Text = "El vehículo se encuentra dentro de planta extractora";
                    this.txtLVehiculo.Text = "";
                    txtNVehiculo.Text = "";
                    this.txtIdConductor.Text = "";
                    this.txtNombreConductor.Text = "";
                    this.Session["registro"] = "";
                    this.txtLVehiculo.Focus();
                    return;
                }
            }
            else if (txtRemolque.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Vehiculo propio Ingrese el remolque";
                txtRemolque.Focus();
                txtRemolque.Enabled = true;
                return;
            }
            if (vehiculos.verificaVehiculoPropio(txtLVehiculo.Text.Trim() + txtNVehiculo.Text.Trim(), Convert.ToInt16(Session["empresa"])) == 1)
            {
                if (vehiculos.ValidaProgramacionDespachosExtractoraRemolque(this.txtLVehiculo.Text + this.txtNVehiculo.Text, txtRemolque.Text, out registro, Convert.ToInt16(Session["empresa"])).Count == 0)
                {
                    this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                    this.nilblInformacion.Text = "El vehículo no se encuentra programado. No es posible ingresar el vehículo";
                    this.txtLVehiculo.Text = "";
                    this.txtNVehiculo.Text = "";
                    this.txtIdConductor.Text = "";
                    this.txtNombreConductor.Text = "";
                    this.Session["registro"] = null;
                    this.txtLVehiculo.Focus();
                    this.Session["numero"] = null;
                    this.txtRemolque.Text = "";
                    this.txtRemolque.Enabled = false;
                }
                else
                {
                    this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
                    this.nilblInformacion.Text = "Vehículo programado asigne código de carnet";


                    foreach (DataRowView dato in vehiculos.GetProgramacionDespachos(registro, Convert.ToInt16(Session["empresa"])))
                    {
                        this.txtIdConductor.Text = Convert.ToString(dato.Row.ItemArray.GetValue(7));
                        this.txtNombreConductor.Text = Convert.ToString(dato.Row.ItemArray.GetValue(8));
                        this.txtRemolque.Text = Convert.ToString(dato.Row.ItemArray.GetValue(11));
                        Session["tipoProgramacion"] = Convert.ToString(dato.Row.ItemArray.GetValue(2));
                    }

                    this.Session["registro"] = registro;
                    Session["numero"] = registro;
                    this.txtCodigoAsignado.Focus();

                }

            }
            else
            {
                if (vehiculos.verificaVehiculoPropio(txtLVehiculo.Text.Trim() + txtNVehiculo.Text.Trim(), Convert.ToInt16(Session["empresa"])) == 1)
                {
                    if (vehiculos.ValidaProgramacionDespachosExtractoraRemolque(this.txtLVehiculo.Text + this.txtNVehiculo.Text, txtRemolque.Text, out registro, Convert.ToInt16(Session["empresa"])).Count == 0)
                    {
                        this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                        this.nilblInformacion.Text = "El vehículo no se encuentra programado. No es posible ingresar el vehículo";
                        this.txtLVehiculo.Text = "";
                        this.txtNVehiculo.Text = "";
                        this.txtIdConductor.Text = "";
                        this.txtNombreConductor.Text = "";
                        this.Session["registro"] = null;
                        this.txtLVehiculo.Focus();
                        this.Session["numero"] = null;
                    }
                    else
                    {
                        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
                        this.nilblInformacion.Text = "Vehículo programado asigne código de carnet";
                        foreach (DataRowView dato in vehiculos.GetProgramacionDespachos(registro, Convert.ToInt16(Session["empresa"])))
                        {
                            this.txtIdConductor.Text = Convert.ToString(dato.Row.ItemArray.GetValue(7));
                            this.txtNombreConductor.Text = Convert.ToString(dato.Row.ItemArray.GetValue(8));
                            this.txtRemolque.Text = Convert.ToString(dato.Row.ItemArray.GetValue(11));
                            Session["tipoProgramacion"] = Convert.ToString(dato.Row.ItemArray.GetValue(2));
                        }

                        this.Session["registro"] = registro;
                        Session["numero"] = registro;
                        this.txtCodigoAsignado.Focus();

                    }

                }
                else

                    if (vehiculos.ValidaProgramacionDespachosExtractora(this.txtLVehiculo.Text + this.txtNVehiculo.Text, out registro, Convert.ToInt16(Session["empresa"])).Count == 0)
                    {
                        this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                        this.nilblInformacion.Text = "El vehículo no se encuentra programado. No es posible ingresar el vehículo";
                        this.txtLVehiculo.Text = "";
                        this.txtNVehiculo.Text = "";
                        this.txtIdConductor.Text = "";
                        this.txtNombreConductor.Text = "";
                        this.Session["registro"] = null;
                        this.txtLVehiculo.Focus();
                        this.Session["numero"] = null;
                        this.txtRemolque.Text = "";
                        this.txtRemolque.Enabled = false;
                    }
                    else
                    {
                        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
                        this.nilblInformacion.Text = "Vehículo programado asigne código de carnet";
                        foreach (DataRowView dato in vehiculos.GetProgramacionDespachos(registro, Convert.ToInt16(Session["empresa"])))
                        {
                            this.txtIdConductor.Text = Convert.ToString(dato.Row.ItemArray.GetValue(7));
                            this.txtNombreConductor.Text = Convert.ToString(dato.Row.ItemArray.GetValue(8));
                            this.txtRemolque.Text = Convert.ToString(dato.Row.ItemArray.GetValue(11));
                            Session["tipoProgramacion"] = Convert.ToString(dato.Row.ItemArray.GetValue(2));
                        }
                        this.Session["registro"] = registro;
                        this.txtCodigoAsignado.Focus();
                    }
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la programación de vehículos" + ex.Message, "C");
        }
    }


    private void GetEntidad()
    {
        try
        {
            DataView vehi = vehiculos.GetVehiculosDesCargaPlantaDespachos(Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataSource = vehi;
            this.gvLista.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar vehículos en planta. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Porteria/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
    "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }

    private void CargarCampo()
    {



    }
    private void Guardar()
    {
        ValidacionVehiculo();
        string vehiculo = "";
        string arp = "", ccConducto = "", celular = "", cliente = "", desCliente = "", desConductor = "", desDestino = "", desProducto = "",
           numero = "", observacion = "", placa = "", producto = "", remolque = "", salud = "";
        string destino = "";
        int registro = 0;
        DateTime fechaCargue;

        if (vehiculos.RetornaEstadoCarnet(this.txtCodigoAsignado.Text, Convert.ToInt16(Session["empresa"])) != "A")
        {
            this.txtCodigoAsignado.Text = "";
            this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
            this.nilblInformacion.Text = "El código de carnet asignado no es valido";
            this.lbRegistrar.Visible = false;
            return;
        }

        if (this.txtIdConductor.Text.Trim().Length == 0 || this.txtNombreConductor.Text.Trim().Length == 0)
        {
            this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
            this.nilblInformacion.Text = "Debe ingresar los datos del conductor";
            return;
        }

        vehiculo = txtLVehiculo.Text.Trim() + txtNVehiculo.Text.Trim();

        using (TransactionScope ts = new TransactionScope())
        {
            try
            {
                Biocosta.swBiocosta biocosta = new Biocosta.swBiocosta();



                if (!(Session["numero"] == null))
                {



                    foreach (DataRowView dato in biocosta.GetProgramacionDespachos(
                          Convert.ToString(ConfigurationManager.AppSettings["UsuarioSW"])
            , Convert.ToString(ConfigurationManager.AppSettings["ClaveSW"]),
            Convert.ToString(this.Session["registro"])).Tables[0].DefaultView)
                    {


                        Session["tipoProgramacion"] = ConfigurationManager.AppSettings["TipoProComer"].ToString();


                        switch (vehiculos.insertaClienteComer(dato.Row.ItemArray.GetValue(5).ToString(), Convert.ToInt16(Session["empresa"]),
                   dato.Row.ItemArray.GetValue(6).ToString()
                       ))
                        {
                            case 1:
                                ManejoError("Error al insertar cliente", "I");
                                return;
                        }

                        switch (vehiculos.insertaSucursalCliente(dato.Row.ItemArray.GetValue(5).ToString(), Convert.ToInt16(Session["empresa"]),
                        dato.Row.ItemArray.GetValue(7).ToString(),
                        dato.Row.ItemArray.GetValue(8).ToString())
                            )
                        {
                            case 1:
                                ManejoError("Error al insertar sucursal", "I");
                                return;
                        }



                        object[] objValoresSW = new object[]{ 
                     Convert.ToDecimal(dato.Row.ItemArray.GetValue(21)),// @cantidad
                        dato.Row.ItemArray.GetValue(7).ToString() ,//@cliente
                        dato.Row.ItemArray.GetValue(12).ToString(),  //@codigoConductor
                       ConfigurationManager.AppSettings["TerceroComercizalizadora"].ToString(), //@comercializadora
                       null, //@despacho
                       Convert.ToInt16(Session["empresa"]), //@empresa
                       "P", //@estado
                        DateTime.Now, //@fecha
                    Convert.ToDateTime(dato.Row.ItemArray.GetValue(1)), //@fechaDespacho
                        DateTime.Now, //@fechaRegistro
                        dato.Row.ItemArray.GetValue(13).ToString(),//@nombreConductor
                        dato.Row.ItemArray.GetValue(0).ToString(),//@numero
                        "",//@observacion
                        vehiculos.RetornaTerceroProgramacion(dato.Row.ItemArray.GetValue(3).ToString(),Convert.ToInt16(Session["empresa"])).ToString(),//@planta
                        vehiculos.RetornaItemRefProducto(dato.Row.ItemArray.GetValue(2).ToString(),Convert.ToInt16(Session["empresa"])).ToString(),//@producto
                        null,//@programacionCarga
                        dato.Row.ItemArray.GetValue(14).ToString(),//@remolque
                        dato.Row.ItemArray.GetValue(5).ToString(),//@tercero
                        ConfigurationManager.AppSettings["TipoProComer"].ToString(),//@tipo
                         ConfigurationManager.AppSettings["usuarioComer"].ToString(),//@usuario
                       dato.Row.ItemArray.GetValue(11).ToString() ,//@vehiculo
                        0//@vehiculoPropio
                     };

                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                            "logProgramacionVehiculo", "inserta", "ppa", objValoresSW))
                        {
                            case 1:
                                ManejoError("Error al insertar de la programación logística", "I");
                                break;
                        }

                    }
                }

                object[] objValores = new object[]{
                this.txtIdConductor.Text,
                Convert.ToInt16(Session["empresa"]),
                "EP",
                DateTime.Now,
                DateTime.Now,
                DateTime.Now,
                DateTime.Now,
                this.txtNombreConductor.Text,
                Convert.ToString(Session["registro"]),
                false,
                txtCodigoAsignado.Text,
                this.txtRemolque.Text,
                "salida",
                Session["usuario"].ToString(),
                vehiculo
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("bRegistroPorteria", "inserta", "ppa", objValores))
                {
                    case 0:

                        switch (vehiculos.CambiaEstadoCarnet(this.txtCodigoAsignado.Text, "T", Convert.ToInt16(Session["empresa"])))
                        {
                            case 0:

                                if (vehiculos.ActualizaEstadoProgramacion(Convert.ToString(Session["registro"]), "", Session["tipoProgramacion"].ToString(), "EP", Convert.ToInt16(Session["empresa"])) == 0)
                                {
                                    ManejoExito("Registro insertado satisfactoriamente", "I");
                                    ts.Complete();
                                }
                                else
                                {
                                    ManejoError("Error al cambiar el estado de la programación logística", "I");
                                }
                                break;

                            case 1:

                                ManejoError("Error al cambiar el estado de la remisión seleccionada", "I");
                                break;
                        }

                        break;

                    case 1:

                        ManejoError("Error al insertar el registro. Operación no realizada", "I");
                        break;
                }
            }

            catch (Exception ex)
            {
                ManejoError("Error al guardar el registro. Correspondiente a: " + ex.Message, "I");
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
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
                ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                if (!IsPostBack)
                {
                    GetEntidad();
                    txtLVehiculo.Focus();
                }
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
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
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                   ConfigurationManager.AppSettings["Modulo"].ToString(),
                                   nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);

        txtRemolque.Enabled = false;
        txtIdConductor.Enabled = false;
        txtNombreConductor.Enabled = false;

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.lbRegistrar.Visible = false;
        this.nilblInformacion.Text = "";
        this.txtLVehiculo.Focus();
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        Cancelar();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void Txt_Vehiculo_TextChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        try
        {
            if (txtLVehiculo.Text.Trim().Length > 0 & txtNVehiculo.Text.Trim().Length > 0)
                ValidacionVehiculo();
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar vehículo. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void niimbBuscar_Click1(object sender, ImageClickEventArgs e)
    {
        GetEntidad();
    }

    protected void txtCodigoAsignado_TextChanged(object sender, EventArgs e)
    {
        try
        {
            if (vehiculos.RetornaEstadoCarnet(this.txtCodigoAsignado.Text, Convert.ToInt16(Session["empresa"])) != "A")
            {
                this.txtCodigoAsignado.Text = "";
                this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                this.nilblInformacion.Text = "El código de carnet asignado no es valido";
                this.lbRegistrar.Visible = false;
            }
            else
            {
                this.nilblInformacion.Text = "";
                this.lbRegistrar.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar estado del carnet. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void txtRemolque_TextChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        try
        {
            if (txtLVehiculo.Text.Trim().Length > 0 & txtNVehiculo.Text.Trim().Length > 0 & txtRemolque.Text.Length > 0)
                ValidacionVehiculo();
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar vehículo. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Eventos









}
