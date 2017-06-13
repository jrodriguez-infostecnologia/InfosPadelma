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

public partial class Nomina_Paminidtracion_ParametrosGeneral : System.Web.UI.Page
{
    #region Instancias

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CparametrosGeneral parametros = new CparametrosGeneral();
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
            if (parametros.BuscarEntidad(Convert.ToInt16(Session["empresa"])).Table.Rows.Count > 0)
            {
                Session["Editar"] = true;

                foreach (DataRowView r in parametros.BuscarEntidad(Convert.ToInt16(Session["empresa"])))
                {
                    txvNoSalarioIntegral.Text = r.Row.ItemArray.GetValue(1).ToString();
                    txvJornadaDiaria.Text = r.Row.ItemArray.GetValue(2).ToString();
                    ddlTipoJornadaDiaria.SelectedValue = r.Row.ItemArray.GetValue(3).ToString();
                    txvHIJD.Text = r.Row.ItemArray.GetValue(4).ToString();
                    txvHIJN.Text = r.Row.ItemArray.GetValue(5).ToString();
                    calendarUltimaCesantias.SelectedDate = Convert.ToDateTime(r.Row.ItemArray.GetValue(6));
                    txtUltimaCesantias.Visible = true;
                    txtUltimaCesantias.Text = r.Row.ItemArray.GetValue(6).ToString();
                    ddlHorasOrdinarias.SelectedValue = r.Row.ItemArray.GetValue(7).ToString();
                    ddlHRN.SelectedValue = r.Row.ItemArray.GetValue(8).ToString();
                    ddlHEN.SelectedValue = r.Row.ItemArray.GetValue(9).ToString();
                    ddlHED.SelectedValue = r.Row.ItemArray.GetValue(10).ToString();
                    ddlHD.SelectedValue = r.Row.ItemArray.GetValue(11).ToString();
                    ddlHF.SelectedValue = r.Row.ItemArray.GetValue(12).ToString();
                    ddlHRF.SelectedValue = r.Row.ItemArray.GetValue(13).ToString();
                    ddlHENF.SelectedValue = r.Row.ItemArray.GetValue(14).ToString();
                    ddlHEDF.SelectedValue = r.Row.ItemArray.GetValue(15).ToString();
                    ddlSueldo.SelectedValue = r.Row.ItemArray.GetValue(16).ToString();
                    ddlJornales.SelectedValue = r.Row.ItemArray.GetValue(17).ToString();
                    ddlCesantias.SelectedValue = r.Row.ItemArray.GetValue(18).ToString();
                    ddlInteresesCesantias.SelectedValue = r.Row.ItemArray.GetValue(19).ToString();
                    ddlVacaciones.SelectedValue = r.Row.ItemArray.GetValue(20).ToString();
                    ddlPrimas.SelectedValue = r.Row.ItemArray.GetValue(21).ToString();
                    ddlSalarioIntegral.SelectedValue = r.Row.ItemArray.GetValue(22).ToString();
                    ddlPermisos.SelectedValue = r.Row.ItemArray.GetValue(23).ToString();
                    ddlSubsidioTranasporte.SelectedValue = r.Row.ItemArray.GetValue(24).ToString();
                    ddlRetroactivo.SelectedValue = r.Row.ItemArray.GetValue(25).ToString();
                    ddlRetencion.SelectedValue = r.Row.ItemArray.GetValue(26).ToString();
                    ddlSuspencion.SelectedValue = r.Row.ItemArray.GetValue(27).ToString();
                    ddlincapacidades.SelectedValue = r.Row.ItemArray.GetValue(28).ToString();
                    ddlCajaCompensacion.SelectedValue = r.Row.ItemArray.GetValue(29).ToString();
                    ddlSena.SelectedValue = r.Row.ItemArray.GetValue(30).ToString();
                    ddlICBF.SelectedValue = r.Row.ItemArray.GetValue(31).ToString();
                    ddlARP.SelectedValue = r.Row.ItemArray.GetValue(32).ToString();
                    ddlIndemnizacion.SelectedValue = r.Row.ItemArray.GetValue(33).ToString();
                    ddlEnfermedadMaternidad.SelectedValue = r.Row.ItemArray.GetValue(34).ToString();
                    ddlIVM.SelectedValue = r.Row.ItemArray.GetValue(35).ToString();
                    ddlATEP.SelectedValue = r.Row.ItemArray.GetValue(36).ToString();
                    ddlFondoSolidaridad.SelectedValue = r.Row.ItemArray.GetValue(37).ToString();
                    ddlLicRemunerada.SelectedValue = r.Row.ItemArray.GetValue(38).ToString();
                    ddlLicNoRemunerada.SelectedValue = r.Row.ItemArray.GetValue(39).ToString();
                    ddlPrimasExtralegales.SelectedValue = r.Row.ItemArray.GetValue(40).ToString();
                    ddlAnticipoCesantias.SelectedValue = r.Row.ItemArray.GetValue(41).ToString();
                    ddlSalud.SelectedValue = r.Row.ItemArray.GetValue(46).ToString();
                    ddlPension.SelectedValue = r.Row.ItemArray.GetValue(47).ToString();
                    ddlEmbargos.SelectedValue = r.Row.ItemArray.GetValue(48).ToString();
                    ddlGanaDomingoCampo.SelectedValue = r.Row.ItemArray.GetValue(49).ToString();
                    chkPromediaGD.Checked = Convert.ToBoolean(r.Row.ItemArray.GetValue(50));
                    ddlRND.SelectedValue = r.Row.ItemArray.GetValue(53).ToString();
                    ddlHEDD.SelectedValue = r.Row.ItemArray.GetValue(51).ToString();
                    ddlHEND.SelectedValue = r.Row.ItemArray.GetValue(52).ToString();
                    ddlFondoEmpleado.SelectedValue = r.Row.ItemArray.GetValue(54).ToString();
                    ddlSindicato.SelectedValue = r.Row.ItemArray.GetValue(55).ToString();
                    txvDiasVacaciones.Text = r.Row.ItemArray.GetValue(56).ToString();
                    ddlAprendizSena.SelectedValue = r.Row.ItemArray.GetValue(58).ToString();
                    ddlPagaFestivo.SelectedValue = r.Row.ItemArray.GetValue(57).ToString();
                    txvHFJD.Text = r.Row.ItemArray.GetValue(59).ToString();
                    txvHFJN.Text = r.Row.ItemArray.GetValue(60).ToString();
                    txvNoSMLVParafiscales.Text = r.Row.ItemArray.GetValue(61).ToString();
                    chkPromediaFestivo.Checked = Convert.ToBoolean(r.Row.ItemArray.GetValue(62));
                    chkPaga31.Checked = Convert.ToBoolean(r.Row.ItemArray.GetValue(63));

                }
            }
            else
            {
                Session["Editar"] = false;
            }


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

        CargarCombos();
        GetEntidad();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));


    }
    private void CargarCombos()
    {

        try
        {
            this.ddlEmbargos.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlEmbargos.DataValueField = "codigo";
            this.ddlEmbargos.DataTextField = "descripcion";
            this.ddlEmbargos.DataBind();
            this.ddlEmbargos.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlHorasOrdinarias.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHorasOrdinarias.DataValueField = "codigo";
            this.ddlHorasOrdinarias.DataTextField = "descripcion";
            this.ddlHorasOrdinarias.DataBind();
            this.ddlHorasOrdinarias.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlAprendizSena.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlAprendizSena.DataValueField = "codigo";
            this.ddlAprendizSena.DataTextField = "descripcion";
            this.ddlAprendizSena.DataBind();
            this.ddlAprendizSena.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPagaFestivo.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPagaFestivo.DataValueField = "codigo";
            this.ddlPagaFestivo.DataTextField = "descripcion";
            this.ddlPagaFestivo.DataBind();
            this.ddlPagaFestivo.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlGanaDomingoCampo.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlGanaDomingoCampo.DataValueField = "codigo";
            this.ddlGanaDomingoCampo.DataTextField = "descripcion";
            this.ddlGanaDomingoCampo.DataBind();
            this.ddlGanaDomingoCampo.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlHRN.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHRN.DataValueField = "codigo";
            this.ddlHRN.DataTextField = "descripcion";
            this.ddlHRN.DataBind();
            this.ddlHRN.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHEN.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHEN.DataValueField = "codigo";
            this.ddlHEN.DataTextField = "descripcion";
            this.ddlHEN.DataBind();
            this.ddlHEN.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHED.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHED.DataValueField = "codigo";
            this.ddlHED.DataTextField = "descripcion";
            this.ddlHED.DataBind();
            this.ddlHED.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHD.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHD.DataValueField = "codigo";
            this.ddlHD.DataTextField = "descripcion";
            this.ddlHD.DataBind();
            this.ddlHD.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHF.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHF.DataValueField = "codigo";
            this.ddlHF.DataTextField = "descripcion";
            this.ddlHF.DataBind();
            this.ddlHF.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHRF.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHRF.DataValueField = "codigo";
            this.ddlHRF.DataTextField = "descripcion";
            this.ddlHRF.DataBind();
            this.ddlHRF.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHENF.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHENF.DataValueField = "codigo";
            this.ddlHENF.DataTextField = "descripcion";
            this.ddlHENF.DataBind();
            this.ddlHENF.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHEDF.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHEDF.DataValueField = "codigo";
            this.ddlHEDF.DataTextField = "descripcion";
            this.ddlHEDF.DataBind();
            this.ddlHEDF.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlSueldo.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSueldo.DataValueField = "codigo";
            this.ddlSueldo.DataTextField = "descripcion";
            this.ddlSueldo.DataBind();
            this.ddlSueldo.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlJornales.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlJornales.DataValueField = "codigo";
            this.ddlJornales.DataTextField = "descripcion";
            this.ddlJornales.DataBind();
            this.ddlJornales.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlCesantias.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlCesantias.DataValueField = "codigo";
            this.ddlCesantias.DataTextField = "descripcion";
            this.ddlCesantias.DataBind();
            this.ddlCesantias.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlInteresesCesantias.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlInteresesCesantias.DataValueField = "codigo";
            this.ddlInteresesCesantias.DataTextField = "descripcion";
            this.ddlInteresesCesantias.DataBind();
            this.ddlInteresesCesantias.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlVacaciones.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlVacaciones.DataValueField = "codigo";
            this.ddlVacaciones.DataTextField = "descripcion";
            this.ddlVacaciones.DataBind();
            this.ddlVacaciones.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlPrimas.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPrimas.DataValueField = "codigo";
            this.ddlPrimas.DataTextField = "descripcion";
            this.ddlPrimas.DataBind();
            this.ddlPrimas.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlSalarioIntegral.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSalarioIntegral.DataValueField = "codigo";
            this.ddlSalarioIntegral.DataTextField = "descripcion";
            this.ddlSalarioIntegral.DataBind();
            this.ddlSalarioIntegral.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlPermisos.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPermisos.DataValueField = "codigo";
            this.ddlPermisos.DataTextField = "descripcion";
            this.ddlPermisos.DataBind();
            this.ddlPermisos.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlSubsidioTranasporte.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSubsidioTranasporte.DataValueField = "codigo";
            this.ddlSubsidioTranasporte.DataTextField = "descripcion";
            this.ddlSubsidioTranasporte.DataBind();
            this.ddlSubsidioTranasporte.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlRetroactivo.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlRetroactivo.DataValueField = "codigo";
            this.ddlRetroactivo.DataTextField = "descripcion";
            this.ddlRetroactivo.DataBind();
            this.ddlRetroactivo.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlRetencion.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlRetencion.DataValueField = "codigo";
            this.ddlRetencion.DataTextField = "descripcion";
            this.ddlRetencion.DataBind();
            this.ddlRetencion.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlSuspencion.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSuspencion.DataValueField = "codigo";
            this.ddlSuspencion.DataTextField = "descripcion";
            this.ddlSuspencion.DataBind();
            this.ddlSuspencion.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlincapacidades.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlincapacidades.DataValueField = "codigo";
            this.ddlincapacidades.DataTextField = "descripcion";
            this.ddlincapacidades.DataBind();
            this.ddlincapacidades.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlCajaCompensacion.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlCajaCompensacion.DataValueField = "codigo";
            this.ddlCajaCompensacion.DataTextField = "descripcion";
            this.ddlCajaCompensacion.DataBind();
            this.ddlCajaCompensacion.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlSena.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSena.DataValueField = "codigo";
            this.ddlSena.DataTextField = "descripcion";
            this.ddlSena.DataBind();
            this.ddlSena.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlICBF.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlICBF.DataValueField = "codigo";
            this.ddlICBF.DataTextField = "descripcion";
            this.ddlICBF.DataBind();
            this.ddlICBF.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlARP.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlARP.DataValueField = "codigo";
            this.ddlARP.DataTextField = "descripcion";
            this.ddlARP.DataBind();
            this.ddlARP.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlIndemnizacion.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlIndemnizacion.DataValueField = "codigo";
            this.ddlIndemnizacion.DataTextField = "descripcion";
            this.ddlIndemnizacion.DataBind();
            this.ddlIndemnizacion.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlEnfermedadMaternidad.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlEnfermedadMaternidad.DataValueField = "codigo";
            this.ddlEnfermedadMaternidad.DataTextField = "descripcion";
            this.ddlEnfermedadMaternidad.DataBind();
            this.ddlEnfermedadMaternidad.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlIVM.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlIVM.DataValueField = "codigo";
            this.ddlIVM.DataTextField = "descripcion";
            this.ddlIVM.DataBind();
            this.ddlIVM.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlATEP.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlATEP.DataValueField = "codigo";
            this.ddlATEP.DataTextField = "descripcion";
            this.ddlATEP.DataBind();
            this.ddlATEP.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlFondoSolidaridad.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlFondoSolidaridad.DataValueField = "codigo";
            this.ddlFondoSolidaridad.DataTextField = "descripcion";
            this.ddlFondoSolidaridad.DataBind();
            this.ddlFondoSolidaridad.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlLicRemunerada.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlLicRemunerada.DataValueField = "codigo";
            this.ddlLicRemunerada.DataTextField = "descripcion";
            this.ddlLicRemunerada.DataBind();
            this.ddlLicRemunerada.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlLicNoRemunerada.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlLicNoRemunerada.DataValueField = "codigo";
            this.ddlLicNoRemunerada.DataTextField = "descripcion";
            this.ddlLicNoRemunerada.DataBind();
            this.ddlLicNoRemunerada.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlPrimasExtralegales.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPrimasExtralegales.DataValueField = "codigo";
            this.ddlPrimasExtralegales.DataTextField = "descripcion";
            this.ddlPrimasExtralegales.DataBind();
            this.ddlPrimasExtralegales.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlAnticipoCesantias.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlAnticipoCesantias.DataValueField = "codigo";
            this.ddlAnticipoCesantias.DataTextField = "descripcion";
            this.ddlAnticipoCesantias.DataBind();
            this.ddlAnticipoCesantias.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPension.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPension.DataValueField = "codigo";
            this.ddlPension.DataTextField = "descripcion";
            this.ddlPension.DataBind();
            this.ddlPension.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlSalud.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSalud.DataValueField = "codigo";
            this.ddlSalud.DataTextField = "descripcion";
            this.ddlSalud.DataBind();
            this.ddlSalud.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlRND.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlRND.DataValueField = "codigo";
            this.ddlRND.DataTextField = "descripcion";
            this.ddlRND.DataBind();
            this.ddlRND.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHEDD.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHEDD.DataValueField = "codigo";
            this.ddlHEDD.DataTextField = "descripcion";
            this.ddlHEDD.DataBind();
            this.ddlHEDD.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlHEND.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlHEND.DataValueField = "codigo";
            this.ddlHEND.DataTextField = "descripcion";
            this.ddlHEND.DataBind();
            this.ddlHEND.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlFondoEmpleado.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlFondoEmpleado.DataValueField = "codigo";
            this.ddlFondoEmpleado.DataTextField = "descripcion";
            this.ddlFondoEmpleado.DataBind();
            this.ddlFondoEmpleado.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }
        try
        {
            this.ddlSindicato.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet(
                "nConcepto", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSindicato.DataValueField = "codigo";
            this.ddlSindicato.DataTextField = "descripcion";
            this.ddlSindicato.DataBind();
            this.ddlSindicato.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }




    }
    private void Guardar()
    {
        string operacion = "inserta";
        string HorasOrdinarias = null;
        string HRN = null;
        string HEN = null;
        string HED = null;
        string HD = null;
        string HF = null;
        string HRF = null;
        string HENF = null;
        string HEDF = null;
        string Sueldo = null;
        string Jornales = null;
        string Cesantias = null;
        string InteresesCesantias = null;
        string Vacaciones = null;
        string Primas = null;
        string SalarioIntegral = null;
        string Permisos = null;
        string SubsidioTranasporte = null;
        string Retroactivo = null;
        string Retencion = null;
        string Suspencion = null;
        string incapacidades = null;
        string CajaCompensacion = null;
        string Sena = null;
        string ICBF = null;
        string ARP = null;
        string Indecnizacion = null;
        string EnfermedadMaternidad = null;
        string IVM = null;
        string ATEP = null;
        string FondoSolidaridad = null;
        string LicRemunerada = null;
        string LicNoRemunerada = null;
        string PrimasExtralegales = null;
        string AnticipoCesantias = null;
        string GanaDomingoCampo = null;
        string salud = null;
        string pension = null;
        string HRD = null;
        string HEDD = null;
        string HEND = null;
        string fondoEmpleado = null;
        string sindicato = null;
        string aprendizSena = null;
        string pagoFestivo = null;

        DateTime fechaultimasC = Convert.ToDateTime("01/01/1900");


        try
        {

            if (txtUltimaCesantias.Text.Trim().Length > 0)
            {
                fechaultimasC = Convert.ToDateTime(txtUltimaCesantias.Text);
            }

            if (ddlHorasOrdinarias.SelectedValue.Length == 0)
                HorasOrdinarias = ddlHorasOrdinarias.SelectedValue;

            if (ddlHRN.SelectedValue.Length == 0)
                HRN = null;
            else
                HRN = ddlHRN.SelectedValue;

            if (ddlHEN.SelectedValue.Length == 0)
                HEN = null;
            else
                HEN = ddlHEN.SelectedValue;

            if (ddlHED.SelectedValue.Length == 0)
                HED = null;
            else
                HED = ddlHED.SelectedValue;
            if (ddlHD.SelectedValue.Length == 0)
                HD = null;
            else
                HD = ddlHD.SelectedValue;

            if (ddlHF.SelectedValue.Length == 0)
                HF = null;
            else
                HF = ddlHF.SelectedValue;

            if (ddlHRF.SelectedValue.Length == 0)
                HRF = null;
            else
                HRF = ddlHRF.SelectedValue;

            if (ddlHENF.SelectedValue.Length == 0)
                HENF = null;
            else
                HENF = ddlHENF.SelectedValue;

            if (ddlHEDF.SelectedValue.Length == 0)
                HEDF = null;
            else
                HEDF = ddlHEDF.SelectedValue;

            if (ddlSueldo.SelectedValue.Length == 0)
                Sueldo = null;
            else
                Sueldo = ddlSueldo.SelectedValue;

            if (ddlJornales.SelectedValue.Length == 0)
                Jornales = null;
            else
                Jornales = ddlJornales.SelectedValue;

            if (ddlCesantias.SelectedValue.Length == 0)
                Cesantias = null;
            else
                Cesantias = ddlCesantias.SelectedValue;

            if (ddlInteresesCesantias.SelectedValue.Length == 0)
                InteresesCesantias = null;
            else
                InteresesCesantias = ddlInteresesCesantias.SelectedValue;

            if (ddlVacaciones.SelectedValue.Length == 0)
                Vacaciones = null;
            else
                Vacaciones = ddlVacaciones.SelectedValue;

            if (ddlPrimas.SelectedValue.Length == 0)
                Primas = null;
            else
                Primas = ddlPrimas.SelectedValue;

            if (ddlSalarioIntegral.SelectedValue.Length == 0)
                SalarioIntegral = null;
            else
                SalarioIntegral = ddlSalarioIntegral.SelectedValue;

            if (ddlPermisos.SelectedValue.Length == 0)
                Permisos = null;
            else
                Permisos = ddlPermisos.SelectedValue;

            if (ddlSubsidioTranasporte.SelectedValue.Length == 0)
                SubsidioTranasporte = null;
            else
                SubsidioTranasporte = ddlSubsidioTranasporte.SelectedValue;

            if (ddlRetroactivo.SelectedValue.Length == 0)
                Retroactivo = null;
            else
                Retroactivo = ddlRetroactivo.SelectedValue;

            if (ddlRetencion.SelectedValue.Length == 0)
                Retencion = null;
            else
                Retencion = ddlRetencion.SelectedValue;

            if (ddlSuspencion.SelectedValue.Length == 0)
                Suspencion = null;
            else
                Suspencion = ddlSuspencion.SelectedValue;

            if (ddlincapacidades.SelectedValue.Length == 0)
                incapacidades = null;
            else
                incapacidades = ddlincapacidades.SelectedValue;

            if (ddlCajaCompensacion.SelectedValue.Length == 0)
                CajaCompensacion = null;
            else
                CajaCompensacion = ddlCajaCompensacion.SelectedValue;

            if (ddlSena.SelectedValue.Length == 0)
                Sena = null;
            else
                Sena = ddlSena.SelectedValue;

            if (ddlICBF.SelectedValue.Length == 0)
                ICBF = null;
            else
                ICBF = ddlICBF.SelectedValue;

            if (ddlARP.SelectedValue.Length == 0)
                ARP = null;
            else
                ARP = ddlARP.SelectedValue;

            if (ddlIndemnizacion.SelectedValue.Length == 0)
                Indecnizacion = null;
            else
                Indecnizacion = ddlIndemnizacion.SelectedValue;

            if (ddlEnfermedadMaternidad.SelectedValue.Length == 0)
                EnfermedadMaternidad = null;
            else
                EnfermedadMaternidad = ddlEnfermedadMaternidad.SelectedValue;

            if (ddlIVM.SelectedValue.Length == 0)
                IVM = null;
            else
                IVM = ddlIVM.SelectedValue;

            if (ddlATEP.SelectedValue.Length == 0)
                ATEP = null;
            else
                ATEP = ddlATEP.SelectedValue;

            if (ddlFondoSolidaridad.SelectedValue.Length == 0)
                FondoSolidaridad = null;
            else
                FondoSolidaridad = ddlFondoSolidaridad.SelectedValue;

            if (ddlLicRemunerada.SelectedValue.Length == 0)
                LicRemunerada = null;
            else
                LicRemunerada = ddlLicRemunerada.SelectedValue;

            if (ddlLicNoRemunerada.SelectedValue.Length == 0)
                LicNoRemunerada = null;
            else
                LicNoRemunerada = ddlLicNoRemunerada.SelectedValue;

            if (ddlPrimasExtralegales.SelectedValue.Length == 0)
                PrimasExtralegales = null;
            else
                PrimasExtralegales = ddlPrimasExtralegales.SelectedValue;

            if (ddlAnticipoCesantias.SelectedValue.Length == 0)
                AnticipoCesantias = null;
            else
                AnticipoCesantias = ddlAnticipoCesantias.SelectedValue;

            if (ddlSalud.SelectedValue.Length == 0)
                salud = null;
            else
                salud = ddlSalud.SelectedValue;

            if (ddlPension.SelectedValue.Length == 0)
                pension = null;
            else
                pension = ddlPension.SelectedValue;

            if (ddlRND.SelectedValue.Length == 0)
                HRD = null;
            else
                HRD = ddlRND.SelectedValue;

            if (ddlHEDD.SelectedValue.Length == 0)
                HEDD = null;
            else
                HEDD = ddlHEDD.SelectedValue;

            if (ddlHEND.SelectedValue.Length == 0)
                HEND = null;
            else
                HEND = ddlHEND.SelectedValue;

            if (ddlGanaDomingoCampo.SelectedValue.Length == 0)
                GanaDomingoCampo = null;
            else
                GanaDomingoCampo = ddlGanaDomingoCampo.SelectedValue;

            if (ddlFondoEmpleado.SelectedValue.Length == 0)
                fondoEmpleado = null;
            else
                fondoEmpleado = ddlFondoEmpleado.SelectedValue;

            if (ddlSindicato.SelectedValue.Length == 0)
                sindicato = null;
            else
                sindicato = ddlSindicato.SelectedValue;

            if (ddlPagaFestivo.SelectedValue.Length == 0)
                pagoFestivo = null;
            else
                pagoFestivo = ddlPagaFestivo.SelectedValue;

            if (ddlAprendizSena.SelectedValue.Length == 0)
                aprendizSena = null;
            else
                aprendizSena = ddlAprendizSena.SelectedValue;


            if ((parametros.ValidarEmpresaParametros(Convert.ToInt16(Session["empresa"])))==1)
            {
                operacion = "actualiza";
                object[] objValoresActualiza = new object[]{
                   AnticipoCesantias,      //@anticipoCesantias
                   aprendizSena,
                                ARP,    //@ARP
                                ATEP,    //@ATEP
                               CajaCompensacion,     //@cajaCompensacion
                                Cesantias,    //@cesantias
                                Convert.ToDecimal(txvDiasVacaciones.Text),
                                EnfermedadMaternidad,    //@EM
                                ddlEmbargos.SelectedValue.Trim(),//embargo
                                  Convert.ToInt16(Session["empresa"]),   //@empresa
                                   DateTime.Now, //@fechaEdicion
                                   DateTime.Now,//fechaRegitro
                                    fechaultimasC,//@fechaUlrimaCesantias
                                    fondoEmpleado,//fondoempleado
                                     FondoSolidaridad,//@fondoSolidaridad
                                     GanaDomingoCampo, //ganaDomingo
                                   HD, //@HD
                                   HED, //@HED
                                   HEDD, //@HEDD
                                   HEDF, //@HEDF
                                    HEN,//@HEN
                                    HEND,//@HEND
                                   HENF, //@HENF
                                    HF, //@HF
                                   HorasOrdinarias, //@HO
                                    Convert.ToDecimal(txvHFJD.Text), //@horaFinalDiurna
                                  Convert.ToDecimal(txvHFJN.Text),  //@horaInicioNocturna
                                   Convert.ToDecimal(txvHIJD.Text), //@horaInicioDiurna
                                  Convert.ToDecimal(txvHIJN.Text),  //@horaInicioNocturna
                                  HRD,  //@HRD
                                  HRF,  //@HRF
                                  HRN,  //@HRN
                                  ICBF,   //@ICBF
                                  incapacidades,  //@incapacidades
                                  Indecnizacion,  //@indemnizacion
                                 InteresesCesantias,   //@intereses
                                 IVM,   //@IVM
                                   Convert.ToDecimal(txvJornadaDiaria.Text),  //@jornadaDiaria
                                   Jornales, //@jornales
                                    LicNoRemunerada, //@licNoRemunerado
                                   LicRemunerada, //@licRemunerado
                                   Convert.ToDecimal(txvNoSalarioIntegral.Text),  //@noSalarioIntegral
                                   Convert.ToDecimal(txvNoSMLVParafiscales.Text),  //@noSMLVSEnaICBF
                                   chkPaga31.Checked,
                                   pagoFestivo,//@pagoFestivo
                                    pension,//@pension
                                  Permisos, //@permisos 
                                  chkPromediaGD.Checked,//@permisos
                                  Primas,   //@primas
                                  PrimasExtralegales, //@PrimasExtralegales
                                  chkPromediaFestivo.Checked,
                                  Retencion,  //@retencion
                                  Retroactivo,  //@retroactivo
                                    SalarioIntegral, //@salarioIntegral
                                   salud, //@salud
                                   Sena,  //@sena          
                                   sindicato,//sindicato
                                  SubsidioTranasporte, //@subsidioTransporte
                                   Sueldo,  //@sueldo
                                  Suspencion,  //@suspenciones
                                  ddlTipoJornadaDiaria.SelectedValue,  //@tipoJornadaDiaria
                                      Session["usuario"].ToString(),  //@usuarioRegistro
                                   Session["usuario"].ToString(),  //@usuarioEdicion
                                    Vacaciones //@vacaciones
                   
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nParametrosGeneral", operacion, "ppa", objValoresActualiza))
                {
                    case 0:
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        break;
                    case 1:
                        ManejoError("Errores al insertar el registro. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }
            }
            else
            {
                operacion = "inserta";

                object[] objValoresInserta = new object[]{
                                            AnticipoCesantias,  //@anticipoCesantias
                                            aprendizSena,
                                               ARP, //@ARP
                                                ATEP, //@ATEP
                                               CajaCompensacion, //@cajaCompensacion
                                               Cesantias, //@cesantias
                                               Convert.ToDecimal(txvDiasVacaciones.Text),
                                                EnfermedadMaternidad, //@EM
                                                ddlEmbargos.SelectedValue,
                                                 Convert.ToInt16(Session["empresa"]), //@empresa
                                               null, //@fechaEdicion
                                                DateTime.Now, //@fechaRegistro
                                               fechaultimasC, //@fechaUlrimaCesantias
                                               fondoEmpleado, //@fondoempleado
                                               FondoSolidaridad, //@fondoSolidaridad
                                                GanaDomingoCampo,//GanaDomingo
                                                HD, //@HD
                                                HED, //@HED
                                                HEDD, //@HEDD
                                               HEDF, //@HEDF
                                                HEN, //@HEN
                                                HEND, //@HEND
                                               HENF, //@HENF
                                               HF, //@HF
                                               HorasOrdinarias, //@HO
                                                 Convert.ToDecimal(txvHFJD.Text), //@horaFinalDiurna
                                                Convert.ToDecimal(txvHFJN.Text),  //@horaInicioNocturna
                                                Convert.ToDecimal(txvHIJD.Text), //@horaInicioDiurna
                                                Convert.ToDecimal(txvHIJN.Text),  //@horaInicioNocturna
                                                HRD, //@HRD
                                                HRF, //@HRF
                                               HRN, //@HRN
                                               ICBF, //@ICBF
                                                incapacidades,//@incapacidades
                                                  Indecnizacion,//@indemnizacion
                                                 InteresesCesantias,//@intereses
                                               IVM, //@IVM
                                                Convert.ToDecimal(txvJornadaDiaria.Text), //@jornadaDiaria
                                                Jornales, //@jornales
                                               LicNoRemunerada, //@licNoRemunerado
                                               LicRemunerada, //@licRemunerado
                                               Convert.ToDecimal(txvNoSalarioIntegral.Text), //@noSalarioIntegral
                                               Convert.ToDecimal(txvNoSMLVParafiscales.Text),  //@noSMLVSEnaICBF
                                               chkPaga31.Checked,
                                               pagoFestivo,//@pagoFestivo
                                                pension,//@pension
                                               Permisos,  //@permisos
                                               chkPromediaGD.Checked,//@pGanaDomingo
                                               Primas, //@primas
                                               PrimasExtralegales, //@PrimasExtralegales
                                               chkPromediaFestivo.Checked,//PromedioFestivo
                                                Retencion, //@retencion
                                                 Retroactivo,//@retroactivo
                                                SalarioIntegral,//@salarioIntegral
                                                salud,//@salud
                                                Sena,//@sena
                                                sindicato,
                                                     SubsidioTranasporte,//@subsidioTransporte
                                                 Sueldo,//@sueldo
                                               Suspencion, //@suspenciones
                                               ddlTipoJornadaDiaria.SelectedValue, //@tipoJornadaDiaria
                                               null, //@usuarioEdicion
                                               Session["usuario"].ToString(), //@usuarioRegistro
                                               Vacaciones //@vacaciones
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nParametrosGeneral", operacion, "ppa", objValoresInserta))
                {
                    case 0:
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
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
            {
                if (!IsPostBack)
                {
                    CargarCombos();
                    GetEntidad();
                }
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
        }
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {

        if (txvHIJD.Text.Length == 0 || txvHIJN.Text.Length == 0 || txvJornadaDiaria.Text.Length == 0 || txvNoSalarioIntegral.Text.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }
        Guardar();
    }


    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.calendarUltimaCesantias.Visible = true;
        this.txtUltimaCesantias.Visible = false;
        this.calendarUltimaCesantias.SelectedDate = Convert.ToDateTime(null);
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.calendarUltimaCesantias.Visible = false;
        this.txtUltimaCesantias.Visible = true;
        this.txtUltimaCesantias.Text = this.calendarUltimaCesantias.SelectedDate.ToShortDateString();
        this.txtUltimaCesantias.Enabled = false;
    }

    #endregion Eventos


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CargarCombos();
        GetEntidad();
    }
}
