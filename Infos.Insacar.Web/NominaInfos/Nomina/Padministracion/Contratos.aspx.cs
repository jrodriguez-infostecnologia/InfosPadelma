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
using System.Globalization;

public partial class Facturacion_Padministracion_Contratos : System.Web.UI.Page
{
    #region Instancias


    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Ccontratos contratos = new Ccontratos();
    CIP ip = new CIP();
    Cfuncionarios funcionarios = new Cfuncionarios();
    Cgeneral general = new Cgeneral();

    #endregion Instancias

    #region Metodos


    private void retornaDatosTercero()
    {
        try
        {
            DataView tercero = funcionarios.RetornaDatosTercero(ddlTercero.SelectedValue, Convert.ToInt16(Session["empresa"]));

            foreach (DataRowView drv in tercero)
            {
                txtDescripcion.Text = drv.Row.ItemArray.GetValue(12).ToString().Trim();
                txtIdentificacion.Text = drv.Row.ItemArray.GetValue(5).ToString().Trim();
            }
            txtCodigoTercero.Text = ddlTercero.SelectedValue.ToString();
            txtNroContrato.Text = contratos.Consecutivo(Convert.ToInt16(Session["empresa"]), txtIdentificacion.Text.Trim());

        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar los datos del funcionario. Correspondiente a: " + ex.Message, "C");
        }
    }

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
            string[] nombreTercero = funcionarios.RetornaNombreTercero(
                tercero, Convert.ToInt16(Session["empresa"]));

            this.txtDescripcion.Text = Convert.ToString(nombreTercero.GetValue(0));
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
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
                return;
            }

            this.gvLista.DataSource = contratos.BuscarEntidad(this.nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C", ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                         this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
            CcontrolesUsuario.LimpiarControles(pnContratos.Controls);
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

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);


        CcontrolesUsuario.InhabilitarControles(
            this.pnContratos.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.pnContratos.Controls);

        this.nilbNuevo.Visible = true;
        //this.fuFoto.Visible = false;
        //this.imbFuncionario.Visible = false;
        //txtFechaNacimiento.Visible = false;
        pnContratos.Visible = false;


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
            DataView tercero = CcontrolesUsuario.OrdenarEntidadTercero(CentidadMetodos.EntidadGet("nFuncionario", "ppa"), "descripcion", "activo", Convert.ToInt16(Session["empresa"]));
            ddlTercero.DataSource = tercero;
            this.ddlTercero.DataValueField = "tercero";
            this.ddlTercero.DataTextField = "descripcion";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTipoCotizante.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nTipoCotizante", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlTipoCotizante.DataValueField = "codigo";
            this.ddlTipoCotizante.DataTextField = "descripcion";
            this.ddlTipoCotizante.DataBind();
            this.ddlTipoCotizante.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo cotizante. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlSubTipoCotizante.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nSubTipoCotizante", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSubTipoCotizante.DataValueField = "codigo";
            this.ddlSubTipoCotizante.DataTextField = "descripcion";
            this.ddlSubTipoCotizante.DataBind();
            this.ddlSubTipoCotizante.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar subtipo cotizante. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            DataView dvSindicato = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nEntidadFondo", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvSindicato.RowFilter = "tipofondo = 1";
            this.ddlFondoEmpleado.DataSource = dvSindicato;
            this.ddlFondoEmpleado.DataValueField = "codigo";
            this.ddlFondoEmpleado.DataTextField = "descripcion";
            this.ddlFondoEmpleado.DataBind();
            this.ddlFondoEmpleado.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar  Sindicatos. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView dvSindicato = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nEntidadFondo", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvSindicato.RowFilter = "tipoFondo = 2";
            this.ddlSindicato.DataSource = dvSindicato;
            this.ddlSindicato.DataValueField = "codigo";
            this.ddlSindicato.DataTextField = "descripcion";
            this.ddlSindicato.DataBind();
            this.ddlSindicato.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar  Sindicatos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView dvCcosto = general.CentroCosto(true, Convert.ToInt16(Session["empresa"]));
            this.ddlCcosto.DataSource = dvCcosto;
            this.ddlCcosto.DataValueField = "codigo";
            this.ddlCcosto.DataTextField = "descripcion";
            this.ddlCcosto.DataBind();
            this.ddlCcosto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar departamentos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlARP.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nEntidadArp", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlARP.DataValueField = "codigo";
            this.ddlARP.DataTextField = "descripcion";
            this.ddlARP.DataBind();
            this.ddlARP.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar  ARP. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlAFP.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nEntidadFondoPension", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlAFP.DataValueField = "codigo";
            this.ddlAFP.DataTextField = "descripcion";
            this.ddlAFP.DataBind();
            this.ddlAFP.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar  AFP. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlEPS.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nEntidadEps", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlEPS.DataValueField = "codigo";
            this.ddlEPS.DataTextField = "descripcion";
            this.ddlEPS.DataBind();
            this.ddlEPS.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar  EPS. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlEPSAdicional.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nEntidadEps", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlEPSAdicional.DataValueField = "codigo";
            this.ddlEPSAdicional.DataTextField = "descripcion";
            this.ddlEPSAdicional.DataBind();
            this.ddlEPSAdicional.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar  EPS Adicional. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlCaja.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nEntidadCaja", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlCaja.DataValueField = "codigo";
            this.ddlCaja.DataTextField = "descripcion";
            this.ddlCaja.DataBind();
            this.ddlCaja.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar  Caja. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlSena.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nEntidadSena", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlSena.DataValueField = "codigo";
            this.ddlSena.DataTextField = "descripcion";
            this.ddlSena.DataBind();
            this.ddlSena.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar Sena. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlICBF.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nEntidadIcbf", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlICBF.DataValueField = "codigo";
            this.ddlICBF.DataTextField = "descripcion";
            this.ddlICBF.DataBind();
            this.ddlICBF.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar ICBF. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTipoNomina.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nTipoNomina", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlTipoNomina.DataValueField = "codigo";
            this.ddlTipoNomina.DataTextField = "descripcion";
            this.ddlTipoNomina.DataBind();
            this.ddlTipoNomina.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo nomina. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlFondoCesantias.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("nEntidadAfc", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlFondoCesantias.DataValueField = "codigo";
            this.ddlFondoCesantias.DataTextField = "descripcion";
            this.ddlFondoCesantias.DataBind();
            this.ddlFondoCesantias.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar fondo de sesantias. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlFormaPago.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("gFormaPago", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlFormaPago.DataValueField = "codigo";
            this.ddlFormaPago.DataTextField = "descripcion";
            this.ddlFormaPago.DataBind();
            this.ddlFormaPago.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar forma de pago. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlBanco.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gBanco", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlBanco.DataValueField = "codigo";
            this.ddlBanco.DataTextField = "descripcion";
            this.ddlBanco.DataBind();
            this.ddlBanco.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar bancos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTipoCuenta.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("gTipoCuenta", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlTipoCuenta.DataValueField = "codigo";
            this.ddlTipoCuenta.DataTextField = "descripcion";
            this.ddlTipoCuenta.DataBind();
            this.ddlTipoCuenta.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar bancos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlCargo.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nCargo", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlCargo.DataValueField = "codigo";
            this.ddlCargo.DataTextField = "descripcion";
            this.ddlCargo.DataBind();
            this.ddlCargo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cargos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlClaseContrato.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nClaseContrato", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlClaseContrato.DataValueField = "codigo";
            this.ddlClaseContrato.DataTextField = "descripcion";
            this.ddlClaseContrato.DataBind();
            this.ddlClaseContrato.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar clase de contratos. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlCT.DataSource = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nCentroTrabajo", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlCT.DataValueField = "codigo";
            this.ddlCT.DataTextField = "descripcion";
            this.ddlCT.DataBind();
            this.ddlCT.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar centros de trabajo. Correspondiente a: " + ex.Message, "C");
        }


    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { Convert.ToInt16(Session["empresa"]), Convert.ToInt16(this.ddlTercero.SelectedValue) };

        try
        {
            //if (CentidadMetodos.EntidadGetKey(
            //    "nFuncionario",
            //    "ppa",
            //    objKey).Tables[0].Rows.Count > 0)
            //{
            //    this.nilblInformacion.Visible = true;
            //    this.nilblInformacion.Text = "Funcionario " + Convert.ToString(this.ddlTercero.SelectedValue) + " ya se encuentra registrado";

            //    CcontrolesUsuario.InhabilitarControles(
            //        this.Page.Controls);

            //    this.nilbNuevo.Visible = true;
            //}
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta";
        string usuarioActualizacion = null;
        string fechaIngresoLey50 = null, tipoCotizante = null, subTipoCotizante = null;
        string entidadEPS = null, entidadPension = null, entidadArp = null, entidadIcbf = null,
            EPSAdicional = null, entidadSena = null, entidadCaja = null, entidadCensantia = null, entidadFondoEmpleado = null, entidadSindicato = null;
        string fechaContratoHasta = null, grupoDestajo = null;
        bool Ley50 = false;

        try
        {
            Convert.ToDateTime(txtFechaIngreso.Text);
        }
        catch
        {
            nilblInformacion.Text = "Fecha no valida por favor corrija";
            return;
        }

        if (txtFechaUltimoAumento.Text.Trim().Length > 0)
            Convert.ToDateTime(txtFechaUltimoAumento.Text);
        else
            txtFechaUltimoAumento.Text = null;

        if (ddlRegimenLaboral.SelectedValue == "1")
        {
            fechaIngresoLey50 = Convert.ToDateTime(txtFechaIngreso.Text).ToShortDateString();
            Ley50 = true;
        }

        if (txtFechaCH.Text.Trim().Length > 0)
            fechaContratoHasta = txtFechaCH.Text;
        if (txtSueldoAnterior.Text.Trim().Length == 0)
            txtSueldoAnterior.Text = "0";
        if (ddlSubTipoCotizante.SelectedValue.Length > 0)
            subTipoCotizante = ddlSubTipoCotizante.SelectedValue;
        if (ddlTipoCotizante.SelectedValue.Length > 0)
            tipoCotizante = ddlTipoCotizante.SelectedValue;
        if (ddlCaja.SelectedValue.Length > 0)
            entidadCaja = ddlCaja.SelectedValue;
        if (ddlEPS.SelectedValue.Length > 0)
            entidadEPS = ddlEPS.SelectedValue;
        if (ddlARP.SelectedValue.Length > 0)
            entidadArp = ddlARP.SelectedValue;
        if (ddlSena.SelectedValue.Length > 0)
            entidadSena = ddlSena.SelectedValue;
        if (ddlAFP.SelectedValue.Length > 0)
            entidadPension = ddlAFP.SelectedValue;
        if (ddlFondoCesantias.SelectedValue.Length > 0)
            entidadCensantia = ddlFondoCesantias.SelectedValue;
        if (ddlICBF.SelectedValue.Length > 0)
            entidadIcbf = ddlICBF.SelectedValue;
        if (ddlEPSAdicional.SelectedValue.Length > 0)
            EPSAdicional = ddlEPSAdicional.SelectedValue;
        if (ddlFondoEmpleado.SelectedValue.Length > 0)
            entidadFondoEmpleado = ddlFondoEmpleado.SelectedValue;
        if (ddlSindicato.SelectedValue.Length > 0)
            entidadSindicato = ddlSindicato.SelectedValue;
        if (ddlGrupoLabores.SelectedValue.Length > 0)
            grupoDestajo = ddlGrupoLabores.SelectedValue;


        try
        {
            if (contratos.ValidaContratosActivosTercero(Convert.ToInt16(Session["empresa"]), ddlTercero.SelectedValue) == 1 & Convert.ToBoolean(this.Session["editar"]) != true)
            {
                nilblInformacion.Text = "El tercero tiene contratos activos";
                return;
            }

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                usuarioActualizacion = (string)this.Session["usuario"];
            }


            CultureInfo culture = new CultureInfo("en-US");
            decimal sueldo = Convert.ToDecimal(txtSueldoBasico.Text.Replace(",", ""));

            object[] objValores = new object[]{       
                               chkActivo.Checked , //                @activo	bit
                                         Convert.ToInt16(ddlAuxTransporte.SelectedValue) , //@auxilioTransporte	int
                                          ddlBanco.SelectedValue.Trim(),  //@banco	varchar
                                          Convert.ToDecimal(txvValorContrato.Text),//@cantidadDestajo
                                          Convert.ToDecimal( txtHoras.Text.Replace(",","")), //@cantidadHoras	decimal
                                          ddlCargo.SelectedValue.Trim(),  //@cargo	varchar
                                          ddlCcosto.SelectedValue,  //@ccosto	varchar
                                          ddlCT.SelectedValue.Trim(), //@centroTrabajo
                                          ddlClaseContrato.SelectedValue.Trim(),  //@claseContrato	varchar
                                          txtIdentificacion.Text,  //@codigoTercero	varchar
                                          txtNumeroCuenta.Text.Trim(),  //@cuentaBancaria	varchar
                                          null,  //@deducible	varchar
                                          ddlDepartamento.SelectedValue.Trim(),  //@departamento	varchar
                                         decimal.Round(Convert.ToDecimal(txtDiasDuracion.Text),0),//@dias contrato int
                                           0, //@diasPagadosVaciones	decimal
                                          (int) this.Session["empresa"],//@empresa	int
                                          entidadArp, //@entidadArp	varchar
                                          entidadCaja,  //@entidadCaja	varchar
                                          entidadCensantia,  //@entidadCesantias	varchar
                                          entidadEPS,  //@entidadEps	varchar
                                          entidadFondoEmpleado,
                                          entidadIcbf,  //@entidadIcbf	varchar
                                          entidadPension,  //@entidadPension	varchar
                                          EPSAdicional,//@entidadSaludAdicional
                                          entidadSena,  //@entidadSena	varchar
                                          entidadSindicato,
                                          null,  //@fechaActualizacion	datetime
                                          fechaContratoHasta, //@fechaContratoHasta	datetime
                                          fechaIngresoLey50,
                                           Convert.ToDateTime(txtFechaIngreso.Text), //@fechaIngreso	datetime
                                          null, //@fechaPrimaHasta	datetime
                                           DateTime.Now, //@fechaRegistro	datetime
                                         null, //@fechaRetiro	datetime
                                          null,  //@fechaUltimaPension	datetime
                                         null,  //@fechaUltimoAumento	datetime
                                          null, //@fechaUltimoCesantias	datetime
                                          null, //@fechaUltimoVacaciones	datetime
                                         null,  //@fechaVacacionesHasta	datetime
                                           ddlFormaPago.SelectedValue.Trim(), //@formaPago	varchar
                                           null, //@foto	int
                                           grupoDestajo,//@grupolaborDestajo
                                           Convert.ToInt16( txtNroContrato.Text), //@id	int
                                           Ley50,//@ley 50
                                           chkManejaDestajo.Checked,//@manejaDestajo
                                            chkFondoEmpleado.Checked,
                                            null,//@motivoRetiro	varchar
                                            chkSindicato.Checked,
                                             null, //@observacion	varchar
                                           ddlTipoSaludAdicional.SelectedValue, //@otrosSalud	varchar
                                           chkPactoColectivo.Checked, //@pactoColectivo	varchar
                                           decimal.Round(Convert.ToDecimal(txvPersonasCargo.Text.Replace(",","")),0),//@personaCargo	int
                                           Convert.ToDecimal(txvPorcentajeFondo.Text),
                                            0,//@pRetencion	decimal
                                            0,//@procediimentoRete	int
                                            Convert.ToDecimal(txvPorcentajeSindicato.Text),//@pSindicato
                                           Convert.ToDecimal( txtTiempoLaborado.Text.Replace(",","")),//@pTiempoLaborado	decimal
                                            ddlRegimenLaboral.SelectedValue.Trim(),//@regimenLaboral	int
                                            sueldo,//@salario	money
                                            Convert.ToDecimal(txtSueldoAnterior.Text.Replace(",","")),//@salarioAnterior	money
                                           chkSalarioIntegral.Checked, //@salarioIntegral	bit
                                           subTipoCotizante, //@subTipoCotizante
                                           ddlTercero.SelectedValue, //@tercero	int
                                           0, //@terminoContrato	varchar
                                            Convert.ToInt16(decimal.Round(Convert.ToDecimal(txtTiempoLaborado.Text.Replace(",","")),0)), //@tiempoBasico	varchar
                                           tipoCotizante,//@tipoContizante	varchar
                                            ddlTipoCuenta.SelectedValue.Trim(),//@tipoCuenta	varchar
                                            ddlTipoNomina.SelectedValue.Trim(),//@tipoNomina	varchar
                                            null,//@turno	varchar
                                           (string) this.Session["usuario"],//@usuario	varchar
                                            usuarioActualizacion,//@usuarioActualizacion	varchar
                                            0,//@valorCesantiasCongeladas	money
                                            0,//@valorCesantiasRetiradas	money
                                            0,//@valorDeducibleRete	money
                                           0, //@valorDependientes	money
                                           0,//@valorOtrosSalud	money
                                             Convert.ToDecimal(txvValAdicional.Text.Replace(",","")),//@valorPrepagada	money
                                            0//@valorSaludObligatoria	money
            };

            using (TransactionScope ts = new TransactionScope())
            {
                switch (CentidadMetodos.EntidadInsertUpdateDelete("nContratos", operacion, "ppa", objValores))
                {
                    case 0:
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        ts.Complete();
                        break;
                    case 1:
                        ManejoError("Errores al insertar el registro. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
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
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
               ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
                this.nitxtBusqueda.Focus();
            else
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
        }

    }



    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {


        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                             ConfigurationManager.AppSettings["Modulo"].ToString(),
                              nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
            return;
        }
        nilblInformacion.Text = "";
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        CcontrolesUsuario.HabilitarControles(this.pnContratos.Controls);
        CcontrolesUsuario.LimpiarControles(this.pnContratos.Controls);

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
        this.txtNroContrato.Enabled = false;
        txvValAdicional.Text = "0";
        txtHoras.Text = "0";
        txtTiempoLaborado.Text = "0";
        manejoEdicion(true);
        txtFechaUltimoAumento.Enabled = false;
        txtSueldoAnterior.Enabled = false;


    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        CcontrolesUsuario.InhabilitarControles(this.pnContratos.Controls);

        CcontrolesUsuario.LimpiarControles(this.pnContratos.Controls);
        this.pnContratos.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        //txtFechaNacimiento.Visible = false;

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        //this.fuFoto.Visible = false;
        this.imbFuncionario.Visible = false;

    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.InhabilitarControles(this.pnContratos.Controls);
        pnContratos.Visible = false;
        this.nilbNuevo.Visible = true;
        this.imbFuncionario.Visible = false;
        GetEntidad();
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlClaseContrato.SelectedValue.Length == 0)
        {
            CcontrolesUsuario.MensajeError("Debe selecionar una clase de contrato", nilblInformacion);
            return;
        }

        if (Convert.ToInt16(contratos.ClaseContratoValidar(ddlClaseContrato.SelectedValue, Convert.ToInt16(Session["empresa"]))) == 1)
        {
            if (ddlDepartamento.SelectedValue.Trim().Length == 0 || txtFechaIngreso.Text.Trim().Length == 0 ||
              ddlCargo.SelectedValue.Trim().Length == 0 || ddlDepartamento.SelectedValue.Trim().Length == 0 ||
              ddlEPS.SelectedValue.Trim().Length == 0 || ddlTercero.SelectedValue.Trim().Length == 0 || ddlTipoNomina.SelectedValue.Trim().Length == 0)
            {
                if (ddlDepartamento.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Departamento vacio por favor corrija**    ";

                if (txtFechaIngreso.Text.Trim().Length == 0)
                    nilblInformacion.Text += "Fecha ingreso vacio por favor corrija**   ";

                if (ddlCargo.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Cargo vacio por favor corrija**  ";

                if (ddlEPS.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Eps vacio por favor corrija**  ";

                if (ddlTercero.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Funcionario vacio por favor corrija** ";

                if (ddlTipoNomina.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Tipo de nomina vacio por favor corrija**  ";
                return;
            }
        }
        else
        {

            if (ddlDepartamento.SelectedValue.Trim().Length == 0 || txtFechaIngreso.Text.Trim().Length == 0 ||
                 ddlCargo.SelectedValue.Trim().Length == 0 || ddlDepartamento.SelectedValue.Trim().Length == 0 ||
                 ddlEPS.SelectedValue.Trim().Length == 0 || ddlTercero.SelectedValue.Trim().Length == 0 ||
                 ddlTipoNomina.SelectedValue.Trim().Length == 0 || ddlARP.SelectedValue.Trim().Length == 0
                || ddlCaja.SelectedValue.Trim().Length == 0 || ddlFondoCesantias.SelectedValue.Trim().Length == 0
                || ddlICBF.SelectedValue.Trim().Length == 0 || ddlSena.SelectedValue.Trim().Length == 0)
            {

                if (ddlDepartamento.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Departamento vacio por favor corrija**    ";

                if (txtFechaIngreso.Text.Trim().Length == 0)
                    nilblInformacion.Text += "Fecha ingreso vacio por favor corrija**   ";


                if (ddlCargo.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Cargo vacio por favor corrija**  ";


                if (ddlEPS.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Eps vacio por favor corrija**  ";


                if (ddlTercero.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Funcionario vacio por favor corrija**  ";

                if (ddlTipoNomina.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Tipo de nomina vacio por favor corrija**  ";


                if (ddlARP.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Arp vacio por favor corrija**  ";

                if (ddlCaja.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Caja vacio por favor corrija**  ";

                if (ddlFondoCesantias.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Fondo vacio por favor corrija**  ";

                if (ddlICBF.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "ICBF vacio por favor corrija**  ";

                if (ddlSena.SelectedValue.Trim().Length == 0)
                    nilblInformacion.Text += "Sena vacio por favor corrija**  ";

                return;
            }

        }

        if (txtHoras.Text.Trim().Length == 0 || txtSueldoBasico.Text.Trim().Length == 0 || txtTiempoLaborado.Text.Trim().Length == 0 || txtFechaIngreso.Text.Trim().Length == 0)
        {
            nilblInformacion.Text += "Revise horas, sueldo, tiepo laborado corrija";
            return;
        }

        if (chkFondoEmpleado.Checked)
        {
            if (ddlFondoEmpleado.SelectedValue.Length == 0 || Convert.ToDecimal(txvPorcentajeFondo.Text) == 0)
            {
                nilblInformacion.Text += "Debe seleccionar un fondo de empleado y un porcentaje para continuar";
                return;
            }
        }

        if (chkSindicato.Checked)
        {
            if (ddlSindicato.SelectedValue.Length == 0 || Convert.ToDecimal(txvPorcentajeSindicato.Text) == 0)
            {
                nilblInformacion.Text += "Debe seleccionar un sindicato y un porcentaje para continuar";
                return;
            }
        }
        if (ddlTipoSaludAdicional.SelectedValue != "01")
        {
            if (Convert.ToDecimal(txvValAdicional.Text) == 0)
            {
                nilblInformacion.Text = "Debe agregar un valor adicional por el tipo de Salud Adicional";
                return;
            }

            if (ddlTipoSaludAdicional.SelectedValue == "03")
            {
                nilblInformacion.Text = "Debe seleccionar una Entidad de EPS Adicional por el tipo de Salud Adicional";
                return;
            }
        }

        if (ddlTipoCotizante.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text += "Tipo de cotizante vacio por favor corrija**  ";
            return;
        }
        if (ddlSubTipoCotizante.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text += "Subtipo de cotizante vacio por favor corrija**  ";
            return;
        }

        if (chkManejaDestajo.Checked)
        {
            if (ddlSubTipoCotizante.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "Grupo de labores destajo vacio por favor corrija**  ";
                return;
            }

            if (txvValorContrato.Text.Length == 0)
            {
                nilblInformacion.Text = "Cantidad de destajo vacio por favor corrija**  ";
                return;
            }

            if (Convert.ToDecimal(txvValorContrato.Text) == 0)
            {
                nilblInformacion.Text = "Cantidad de destajo debe ser mayor cero (0), por favor corrija**  ";
                return;
            }

        }
        if (ddlTipoCuenta.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Seleccione un tipo de cuenta, por favor corrija**";
            return;
        }

        if (ddlFormaPago.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Seleccione una forma de pago, por favor corrija**";
            return;
        }

            Guardar();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
        nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "A");
            return;
        }

        try
        {
            string tercero = this.gvLista.SelectedRow.Cells[3].Text.Trim();
            int contrato = Convert.ToInt32(this.gvLista.SelectedRow.Cells[8].Text);
            if (contratos.validaFuncionarioActivo(Convert.ToInt16(Session["empresa"]), tercero) == 1)
            {
                nilblInformacion.Text = "El funcionario se encuentra inactivo, no es posible editar el contrato, para ver datos consulte los informes.";
                return;
            }
            CargarCombos();

            txtFechaUltimoAumento.Enabled = false;
            txtSueldoAnterior.Enabled = false;
            txtCodigoTercero.Enabled = false;
            nilblInformacion.Text = "";
            CcontrolesUsuario.HabilitarControles(this.Page.Controls);
            this.pnContratos.Visible = true;
            this.Session["editar"] = true;



            DataView dvContrato = contratos.RetornaDatosContrato(Convert.ToInt16(Session["empresa"]), tercero, contrato);
            txtDescripcion.Text = HttpUtility.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text.Trim());
            txtCodigoTercero.Text = this.gvLista.SelectedRow.Cells[3].Text.Trim();

            foreach (DataRowView registro in dvContrato)
            {
                if (registro.Row.ItemArray.GetValue(1) != null)
                    txtNroContrato.Text = registro.Row.ItemArray.GetValue(1).ToString().Trim();

                if (registro.Row.ItemArray.GetValue(2) != null)
                    txtIdentificacion.Text = registro.Row.ItemArray.GetValue(2).ToString().Trim();

                if (registro.Row.ItemArray.GetValue(3) != null)
                    ddlTercero.SelectedValue = registro.Row.ItemArray.GetValue(3).ToString().Trim();
                else
                    ddlTercero.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(4) != null)
                    ddlCargo.SelectedValue = registro.Row.ItemArray.GetValue(4).ToString().Trim();
                else
                    ddlCargo.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(5) != null)
                    ddlBanco.SelectedValue = registro.Row.ItemArray.GetValue(5).ToString().Trim();
                else
                    ddlBanco.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(6) != null)
                    ddlTipoCotizante.SelectedValue = registro.Row.ItemArray.GetValue(6).ToString().Trim();
                else
                    ddlTipoCotizante.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(10) != null)
                {
                    ddlCcosto.SelectedValue = registro.Row.ItemArray.GetValue(10).ToString().Trim();
                    CargarDepartamentos();
                }
                else
                    ddlCcosto.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(9) != null)
                    ddlDepartamento.SelectedValue = registro.Row.ItemArray.GetValue(9).ToString().Trim();
                else
                    ddlDepartamento.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(11) != null)
                    ddlTipoNomina.SelectedValue = registro.Row.ItemArray.GetValue(11).ToString().Trim();
                else
                    ddlTipoNomina.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(12) != null)
                    txtTiempoLaborado.Text = registro.Row.ItemArray.GetValue(12).ToString().Trim();
                else
                    txtTiempoLaborado.Text = "";

                if (registro.Row.ItemArray.GetValue(13) != null)
                    ddlAFP.SelectedValue = registro.Row.ItemArray.GetValue(13).ToString().Trim();
                else
                    ddlAFP.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(14) != null)
                    ddlEPS.SelectedValue = registro.Row.ItemArray.GetValue(14).ToString().Trim();
                else
                    ddlEPS.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(15) != null)
                    ddlFondoCesantias.SelectedValue = registro.Row.ItemArray.GetValue(15).ToString().Trim();
                else
                    ddlFondoCesantias.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(16) != null)
                    ddlCaja.SelectedValue = registro.Row.ItemArray.GetValue(16).ToString().Trim();
                else
                    ddlCaja.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(17) != null)
                    ddlARP.SelectedValue = registro.Row.ItemArray.GetValue(17).ToString().Trim();
                else
                    ddlARP.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(18) != null)
                    ddlSena.SelectedValue = registro.Row.ItemArray.GetValue(18).ToString().Trim();
                else
                    ddlSena.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(19) != null)
                    ddlICBF.SelectedValue = registro.Row.ItemArray.GetValue(19).ToString().Trim();
                else
                    ddlICBF.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(20) != null)
                    txtFechaIngreso.Text = Convert.ToDateTime(registro.Row.ItemArray.GetValue(20).ToString().Trim()).ToShortDateString();
                else
                    txtFechaIngreso.Text = "";



                if (registro.Row.ItemArray.GetValue(22) != null)
                {
                    if (registro.Row.ItemArray.GetValue(22).ToString().Length > 0)
                        txtFechaCH.Text = Convert.ToDateTime(registro.Row.ItemArray.GetValue(22).ToString()).ToShortDateString();
                    else
                        txtFechaCH.Text = "";
                }
                else
                    txtSueldoBasico.Text = "0";


                if (registro.Row.ItemArray.GetValue(30) != null)
                    txtSueldoBasico.Text = registro.Row.ItemArray.GetValue(30).ToString();
                else
                    txtSueldoBasico.Text = "0";

                if (registro.Row.ItemArray.GetValue(31) != null)
                    txtSueldoAnterior.Text = registro.Row.ItemArray.GetValue(31).ToString();
                else
                    txtSueldoAnterior.Text = "0";

                if (registro.Row.ItemArray.GetValue(37) != null)
                    txtHoras.Text = decimal.Round(Convert.ToDecimal(registro.Row.ItemArray.GetValue(37).ToString()), 0).ToString();
                else
                    txtHoras.Text = "0";

                if (registro.Row.ItemArray.GetValue(41) != null)
                    txvPersonasCargo.Text = decimal.Round(Convert.ToDecimal(registro.Row.ItemArray.GetValue(41).ToString()), 0).ToString();
                else
                    txvPersonasCargo.Text = "0";

                if (registro.Row.ItemArray.GetValue(42) != null)
                    txtNumeroCuenta.Text = registro.Row.ItemArray.GetValue(42).ToString();
                else
                    txtNumeroCuenta.Text = "";

                if (registro.Row.ItemArray.GetValue(43) != null)
                    ddlFormaPago.SelectedValue = registro.Row.ItemArray.GetValue(43).ToString().Trim();
                else
                    ddlFormaPago.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(44) != null)
                    ddlRegimenLaboral.SelectedValue = registro.Row.ItemArray.GetValue(44).ToString();

                if (registro.Row.ItemArray.GetValue(45) != null)
                    ddlAuxTransporte.SelectedValue = registro.Row.ItemArray.GetValue(45).ToString();
                else
                    ddlAuxTransporte.SelectedValue = "";
                if (registro.Row.ItemArray.GetValue(47) != null)
                    chkPactoColectivo.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(47).ToString());
                else
                    chkPactoColectivo.Checked = false;

                if (registro.Row.ItemArray.GetValue(49) != null)
                    ddlTipoSaludAdicional.SelectedValue = registro.Row.ItemArray.GetValue(49).ToString();

                if (registro.Row.ItemArray.GetValue(50) != null)
                    chkSalarioIntegral.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(50).ToString());
                else
                    chkSalarioIntegral.Checked = false;

                if (registro.Row.ItemArray.GetValue(51) != null)
                    ddlTipoCuenta.SelectedValue = registro.Row.ItemArray.GetValue(51).ToString();
                else
                    ddlTipoCuenta.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(52) != null)
                    ddlClaseContrato.SelectedValue = registro.Row.ItemArray.GetValue(52).ToString();

                if (registro.Row.ItemArray.GetValue(56) != null)
                    chkActivo.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(56).ToString());
                else
                    chkActivo.Checked = false;

                if (registro.Row.ItemArray.GetValue(3) != null)
                    ddlTercero.SelectedValue = registro.Row.ItemArray.GetValue(3).ToString();
                else
                    ddlTercero.SelectedValue = "";

                if (registro.Row.ItemArray.GetValue(64) != null)
                    ddlCT.SelectedValue = registro.Row.ItemArray.GetValue(64).ToString();

                if (registro.Row.ItemArray.GetValue(35) != null)
                    txvValAdicional.Text = Convert.ToDecimal(registro.Row.ItemArray.GetValue(35).ToString()).ToString();
                else
                    txvValAdicional.Text = "0";

                if (registro.Row.ItemArray.GetValue(65) != null)
                    txtDiasDuracion.Text = decimal.Round(Convert.ToDecimal(registro.Row.ItemArray.GetValue(65)), 0).ToString();
                else
                    txtDiasDuracion.Text = "0";

                if (registro.Row.ItemArray.GetValue(67) != null)
                    chkFondoEmpleado.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(67).ToString());
                else
                    chkFondoEmpleado.Checked = false;

                if (registro.Row.ItemArray.GetValue(66) != null)
                    chkSindicato.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(66).ToString());
                else
                    chkSindicato.Checked = false;

                if (registro.Row.ItemArray.GetValue(68) != null && Convert.ToBoolean(registro.Row.ItemArray.GetValue(67)) == true)
                {
                    ddlFondoEmpleado.SelectedValue = registro.Row.ItemArray.GetValue(68).ToString();
                    ddlFondoEmpleado.Enabled = true;
                }

                if (registro.Row.ItemArray.GetValue(69) != null && Convert.ToBoolean(registro.Row.ItemArray.GetValue(66)) == true)
                {
                    ddlSindicato.SelectedValue = registro.Row.ItemArray.GetValue(69).ToString();
                    ddlSindicato.Enabled = true;
                }

                if (registro.Row.ItemArray.GetValue(70) != null)
                    txvPorcentajeFondo.Text = registro.Row.ItemArray.GetValue(70).ToString();
                else
                    txvPorcentajeFondo.Text = "0";

                if (registro.Row.ItemArray.GetValue(71) != null)
                    txvPorcentajeSindicato.Text = registro.Row.ItemArray.GetValue(71).ToString();
                else
                    txvPorcentajeSindicato.Text = "0";

                if (registro.Row.ItemArray.GetValue(72) != null)
                    ddlSubTipoCotizante.Text = registro.Row.ItemArray.GetValue(72).ToString();
                
                if (registro.Row.ItemArray.GetValue(74) != null)
                    chkManejaDestajo.Checked = Convert.ToBoolean(registro.Row.ItemArray.GetValue(74).ToString());
                else
                    chkManejaDestajo.Checked = false;

                if (registro.Row.ItemArray.GetValue(75) != null)
                    ddlGrupoLabores.Text = registro.Row.ItemArray.GetValue(75).ToString();

                if (registro.Row.ItemArray.GetValue(76) != null)
                    txvValorContrato.Text = registro.Row.ItemArray.GetValue(76).ToString();
                else
                    txvValorContrato.Text = "0";
            }

            manejoEdicion(false);


        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar funcionario. Correspondiente a: " + ex.Message, "A");
        }
    }

    private void manejoEdicion(bool manejo)
    {
        if (manejo == true)
        {
            ddlTercero.Enabled = true;
            txtIdentificacion.Enabled = false;
            txtNroContrato.Enabled = false;
        }
        else
        {
            txtCodigoTercero.Enabled = false;
            ddlTercero.Enabled = false;
            txtIdentificacion.Enabled = false;
            txtNroContrato.Enabled = false;
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                     ConfigurationManager.AppSettings["Modulo"].ToString(),
                                      nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", "C");
            return;
        }
        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                this.gvLista.Rows[e.RowIndex].Cells[2].Text.ToString().Trim(),
                Convert.ToInt16(Session["empresa"]), 
                Convert.ToInt32(this.gvLista.Rows[e.RowIndex].Cells[8].Text.Trim()),
                Convert.ToInt32(this.gvLista.Rows[e.RowIndex].Cells[3].Text.ToString().Trim()),
		this.Session["usuario"].ToString() };

            if (CentidadMetodos.EntidadInsertUpdateDelete("nContratos", operacion, "ppa", objValores) == 0)
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            else
                ManejoError("Errores al eliminar el registro. Operaci�n no realizada", "E");
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }

    protected void ddlFuncionario_SelectedIndexChanged(object sender, EventArgs e)
    {
        retornaDatosTercero();
        pnContratos.Visible = true;
        CcontrolesUsuario.LimpiarControles(pnContratos.Controls);
        this.pnContratos.Visible = true;
        txvValAdicional.Text = "0";
        txtHoras.Text = "0";
        txtTiempoLaborado.Text = "0";
        txvPersonasCargo.Text = "0";
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

    //private void abreVentana(string ventana)
    //{
    //    string Clientscript = "<script>window.open('" +
    //                          ventana +
    //                          "')</script>";

    //    if (!this.IsStartupScriptRegistered("WOpen"))
    //    {
    //        this.RegisterStartupScript("WOpen", Clientscript);
    //    }
    //}


    #endregion Eventos

    protected void lbFechaIngreso_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaIngreso.Visible = true;
        this.txtFechaIngreso.Visible = false;
        this.niCalendarFechaIngreso.SelectedDate = Convert.ToDateTime(null);
    }
    protected void niCalendarFechaIngreso_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaIngreso.Visible = false;
        this.txtFechaIngreso.Visible = true;
        this.txtFechaIngreso.Text = this.niCalendarFechaIngreso.SelectedDate.ToShortDateString();

        if (ddlClaseContrato.SelectedValue.Trim().Length > 0)
        {
            calcularContratoHasta();
        }

    }

    protected void ddlSP_SelectedIndexChanged(object sender, EventArgs e)
    {
        verificaPrepagada();
    }

    private void verificaPrepagada()
    {
        if (ddlTipoSaludAdicional.SelectedValue.Trim().Length > 0)
        {
            if (ddlTipoSaludAdicional.SelectedValue.Trim() == "03")
            {
                ddlEPSAdicional.Enabled = true;
                txvValAdicional.Enabled = true;
            }
            else
            {
                if (ddlTipoSaludAdicional.SelectedValue.Trim() == "02")
                {
                    ddlEPSAdicional.Enabled = false;
                    ddlEPSAdicional.SelectedValue = "";
                    txvValAdicional.Enabled = true;
                }
                else
                {
                    txvValAdicional.Enabled = false;
                    txvValAdicional.Text = "0";
                }
            }

        }
    }
    protected void ddlCcosto_SelectedIndexChanged(object sender, EventArgs e)
    {
        CargarDepartamentos();
    }

    private void CargarDepartamentos()
    {
        if (ddlCcosto.SelectedValue.Trim().Length > 0)
        {

            try
            {
                ddlDepartamento.DataSource = contratos.SeleccionaDepartamentoxCC(Convert.ToInt16(Session["empresa"]), ddlCcosto.SelectedValue.Trim());
                this.ddlDepartamento.DataValueField = "codigo";
                this.ddlDepartamento.DataTextField = "descripcion";
                this.ddlDepartamento.DataBind();
                this.ddlDepartamento.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar departamentos debido a: " + ex.Message, "I");

            }
        }
        else
        {
            nilblInformacion.Text = "Debe seleccionar un centro de costo valido";
            return;
        }
    }

    private void calcularContratoHasta()
    {
        if (txtFechaIngreso.Text.Trim().Length > 0)
        {
            try
            {
                Convert.ToDateTime(txtFechaIngreso.Text);

            }
            catch
            {
                nilblInformacion.Text = "Formato de fecha no valido";
                return;

            }

            int ddias = Convert.ToInt16(decimal.Round(Convert.ToDecimal(txtDiasDuracion.Text), 0));
            string decimalDias = (Convert.ToDecimal(ddias) / 30).ToString();
            int meses = Convert.ToInt16((decimalDias.Split('.')[0]));
            double dias = Convert.ToDouble(ddias) - (meses * 30) - 1;
            DateTime fechaFinal = Convert.ToDateTime(txtFechaIngreso.Text);
            fechaFinal = fechaFinal.AddMonths(meses);
            fechaFinal = fechaFinal.AddDays(dias);
            txtFechaCH.Text = fechaFinal.ToShortDateString();
        }
        else
        {
            nilblInformacion.Text = "Debe seleccionar primero una fecha de ingreso";
            return;
        }
    }
    protected void txtFechaIngreso_TextChanged(object sender, EventArgs e)
    {
        if (txtFechaIngreso.Text.Trim().Length > 0 & txtDiasDuracion.Text.Trim().Length > 0)
        {
            calcularContratoHasta();
            manejoClaseContrato();
        }

    }
    protected void txtDiasDuracion_TextChanged(object sender, EventArgs e)
    {
        if (txtFechaIngreso.Text.Trim().Length > 0 & txtDiasDuracion.Text.Trim().Length > 0)
        {
            calcularContratoHasta();
        }
    }
    protected void ddlClaseContrato_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoClaseContrato();
    }

    private void manejoClaseContrato()
    {

        if (ddlClaseContrato.SelectedValue.Trim().Length > 0)
        {
            if (contratos.VerificaClaseContrato(Convert.ToInt16(Session["empresa"]), ddlClaseContrato.SelectedValue.Trim()) != 1)
            {
                txtDiasDuracion.Enabled = false;
                txtFechaCH.Enabled = false;
                txtFechaCH.Text = "";
                txtDiasDuracion.Text = "0";
            }
            else
            {
                txtDiasDuracion.Enabled = true;
                txtFechaCH.Enabled = true;
                txtFechaCH.Text = "";
                txtDiasDuracion.Focus();
                txtDiasDuracion.Text = "0";

            }

        }
    }
    protected void chkSindicato_CheckedChanged(object sender, EventArgs e)
    {
        if (chkSindicato.Checked)
        {
            try
            {
                ddlSindicato.Enabled = true;
                txvPorcentajeSindicato.Enabled = true;
                txvPorcentajeSindicato.Text = "0";

                DataView dvSindicato = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nEntidadFondo", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
                dvSindicato.RowFilter = "tipoFondo = 2";
                this.ddlSindicato.DataSource = dvSindicato;
                this.ddlSindicato.DataValueField = "codigo";
                this.ddlSindicato.DataTextField = "descripcion";
                this.ddlSindicato.DataBind();
                this.ddlSindicato.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar  Sindicatos. Correspondiente a: " + ex.Message, "C");
            }

        }
        else
        {
            ddlSindicato.Enabled = false;
            txvPorcentajeSindicato.Enabled = false;
            txvPorcentajeSindicato.Text = "0";
            this.ddlSindicato.DataSource = null;
            ddlSindicato.DataBind();
        }
    }
    protected void chkFondoEmpleado_CheckedChanged(object sender, EventArgs e)
    {
        if (chkFondoEmpleado.Checked)
        {
            try
            {
                ddlFondoEmpleado.Enabled = true;
                txvPorcentajeFondo.Enabled = true;
                txvPorcentajeFondo.Text = "0";

                DataView dvSindicato = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nEntidadFondo", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
                dvSindicato.RowFilter = "tipoFondo = 1";
                this.ddlFondoEmpleado.DataSource = dvSindicato;
                this.ddlFondoEmpleado.DataValueField = "codigo";
                this.ddlFondoEmpleado.DataTextField = "descripcion";
                this.ddlFondoEmpleado.DataBind();
                this.ddlFondoEmpleado.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar  Sindicatos. Correspondiente a: " + ex.Message, "C");
            }

        }
        else
        {
            ddlFondoEmpleado.Enabled = false;
            txvPorcentajeFondo.Enabled = false;
            txvPorcentajeFondo.Text = "0";
            this.ddlFondoEmpleado.DataSource = null;
            ddlFondoEmpleado.DataBind();
        }
    }
    protected void chkManejaDestajo_CheckedChanged(object sender, EventArgs e)
    {
        if (chkManejaDestajo.Checked)
        {
            try
            {
                ddlGrupoLabores.Enabled = true;
                txvValorContrato.Enabled = true;
                txvValorContrato.Text = "0";
                this.ddlGrupoLabores.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("aGrupoNovedad", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
                this.ddlGrupoLabores.DataValueField = "codigo";
                this.ddlGrupoLabores.DataTextField = "descripcion";
                this.ddlGrupoLabores.DataBind();
                this.ddlGrupoLabores.Items.Insert(0, new ListItem("", ""));


            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar grupo de labores. Correspondiente a: " + ex.Message, "C");
            }

        }
        else
        {
            ddlGrupoLabores.Enabled = false;
            txvValorContrato.Enabled = false;
            txvValorContrato.Text = "0";
            this.ddlGrupoLabores.DataSource = null;
            ddlGrupoLabores.DataBind();
        }
    }
}
