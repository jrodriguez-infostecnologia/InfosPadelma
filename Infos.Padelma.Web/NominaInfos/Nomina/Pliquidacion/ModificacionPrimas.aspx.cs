using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Text.RegularExpressions;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Nomina_Pliquidacion_ModificacionPrimas : System.Web.UI.Page
{

    public List<LiquidacionPrimas> ListadoDetallePrimas
    {
        get
        {
            object o = ViewState["ListadoDetallePrimas"];
            return (o == null) ? null : (List<LiquidacionPrimas>)o;
        }
        set
        {
            ViewState["ListadoDetallePrimas"] = value;
        }
    }

    public string Tipo
    {
        get
        {
            object o = ViewState["Tipo"];
            return (o == null) ? null : (string)o;
        }
        set
        {
            ViewState["Tipo"] = value;
        }
    }
    public string Numero
    {
        get
        {
            object o = ViewState["Numero"];
            return (o == null) ? null : (string)o;
        }
        set
        {
            ViewState["Numero"] = value;
        }
    }


    #region Instancias

    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cperiodos periodo = new Cperiodos();
    CModificacionPrimas modificacionPrima = new CModificacionPrimas();
    #endregion Instancias

    #region Metodos

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }

    private string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }

    private void InitView()
    {
        GuardarParametros();
        CargarCabeceraPrima();
        CargarDetallePrima();
        CargarTerceros();
    }

    private void CargarTerceros()
    {
        string empresa = (Session["empresa"] ?? "").ToString();
        try
        {
            if (ListadoDetallePrimas.Count == 0)
                return;
            var ids = ListadoDetallePrimas.Select(item => item.CodigoTercero).Aggregate((s1, s2) => s1 + ", " + s2);
            var ds = modificacionPrima.CargarTerceros(empresa);
            var dv = ds.Tables[0].AsDataView();
            dv.RowFilter = "id not in (" + ids + ")";
            ddlTercero.DataSource = dv;
            ddlTercero.DataValueField = "id";
            ddlTercero.DataTextField = "descripcion";

            ddlTercero.DataBind();
            ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los terceros." + ex.ToString(), "IN");
        }
    }

    private void GuardarParametros()
    {
        Tipo = (Request["tipo"] ?? "").ToString();
        Numero = (Request["numero"] ?? "").ToString();
    }

    private void CargarCabeceraPrima()
    {
        string empresa = (Session["empresa"] ?? "").ToString();
        string tipo = (Tipo ?? "").ToString();
        string numero = (Numero ?? "").ToString();

        try
        {
            var dr = modificacionPrima.CargarCabeceraPrima(empresa, tipo, numero);
            if (dr == null)
                return;
            this.txtTipo.Text = dr["tipo"].ToString();
            this.txtNumero.Text = dr["numero"].ToString();
            this.txtPeriodoPago.Text = dr["periodo"].ToString();
            this.txtAñoPago.Text = dr["año"].ToString();
            this.txtFecha.Text = (!(dr["fecha"] is DateTime) ? "N/A" : ((DateTime)dr["fecha"]).ToString("yyyy/MM/dd"));
            this.txtObservacion.Text = dr["observacion"].ToString();
            this.txtAñoDesde.Text = dr["añoInicial"].ToString();
            this.txtAñoHasta.Text = dr["añoFinal"].ToString();
            this.txtPeriodoDesde.Text = dr["periodoInicial"].ToString();
            this.txtPeriodoHasta.Text = dr["periodoFinal"].ToString();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los detalles de la liquidación." + ex.ToString(), "IN");
        }
    }

    private void CargarDetallePrima()
    {
        string empresa = (Session["empresa"] ?? "").ToString();
        string tipo = (Tipo ?? "").ToString();
        string numero = (Numero ?? "").ToString();

        try
        {
            var ds = modificacionPrima.CargarDetallePrima(empresa, tipo, numero);
            ListadoDetallePrimas = new List<LiquidacionPrimas>();
            foreach (DataRow dr in ds.Tables[0].Rows)
            {
                var item = new LiquidacionPrimas();
                item.CodigoTercero = dr["codigoTercero"].ToString();
                item.IdentificacionTercero = dr["identificacionTercero"].ToString();
                item.NombreTercero = dr["nombreTercero"].ToString();
                item.FechaIngreso = (!(dr["fechaIngreso"] is DateTime) ? "N/A" : ((DateTime)dr["fechaIngreso"]).ToString("yyyy/MM/dd"));
                item.FechaInicial = (!(dr["fechaInicial"] is DateTime) ? "N/A" : ((DateTime)dr["fechaInicial"]).ToString("yyyy/MM/dd"));
                item.FechaFinal = (!(dr["fechaFinal"] is DateTime) ? "N/A" : ((DateTime)dr["fechaFinal"]).ToString("yyyy/MM/dd"));
                item.Basico = (!(dr["basico"] is int) ? "0" : ((int)dr["basico"]).ToString("#,#"));
                item.Transporte = !(dr["transporte"] is int) ? "0" : ((int)dr["transporte"]).ToString("#,#0");
                item.ValorPromedio = (!(dr["valorPromedio"] is int) ? "0" : ((int)dr["valorPromedio"]).ToString("#,#0"));
                item.Base = (!(dr["base"] is int) ? "0" : ((int)dr["base"]).ToString("#,#0"));
                item.DiasPromedio = dr["diasPromedio"].ToString();
                item.DiasPrimas = dr["diasPrimas"].ToString();
                item.ValorPrima = (!(dr["valorPrima"] is int) ? "0" : ((int)dr["valorPrima"]).ToString("#,#0"));
                item.Contrato = !(dr["contrato"] is int) ? 0 : (int)dr["contrato"];
                ListadoDetallePrimas.Add(item);
            }
            gvDetalleLiquidacion.DataSource = ListadoDetallePrimas;
            gvDetalleLiquidacion.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los detalles de la liquidación." + ex.ToString(), "IN");
        }
    }

    private void GuardarDatos()
    {
        string empresa = (Session["empresa"] ?? "").ToString();
        string tipo = (Tipo ?? "").ToString();
        string numero = (Numero ?? "").ToString();

        try
        {
            DataTable table = new DataTable();
            table.Columns.Add("empresa");
            table.Columns.Add("tipo");
            table.Columns.Add("numero");
            table.Columns.Add("tercero");
            table.Columns.Add("añoInicial");
            table.Columns.Add("añoFinal");
            table.Columns.Add("periodoInical");
            table.Columns.Add("periodoFinal");
            table.Columns.Add("fechaInicial");
            table.Columns.Add("fechaFinal");
            table.Columns.Add("fechaIngreso");
            table.Columns.Add("basico");
            table.Columns.Add("valorTransporte");
            table.Columns.Add("valorPromedio");
            table.Columns.Add("base");
            table.Columns.Add("diasPromedio");
            table.Columns.Add("diasPrimas");
            table.Columns.Add("valorPrima");
            table.Columns.Add("contrato");
            ListadoDetallePrimas.ForEach(item =>
            {
                var dr = table.NewRow();
                dr["empresa"] = Convert.ToInt32(empresa);
                dr["tipo"] = tipo;
                dr["numero"] = numero;
                dr["tercero"] = Convert.ToInt32(item.CodigoTercero);
                dr["añoInicial"] = Convert.ToInt32(txtAñoDesde.Text.Trim());
                dr["añoFinal"] = Convert.ToInt32(txtAñoHasta.Text.Trim());
                dr["periodoInical"] = Convert.ToInt32(txtPeriodoDesde.Text.Trim());
                dr["periodoFinal"] = Convert.ToInt32(txtPeriodoHasta.Text.Trim());
                dr["fechaInicial"] = Convert.ToDateTime(item.FechaInicial).ToString("yyyy/MM/dd");
                dr["fechaFinal"] = Convert.ToDateTime(item.FechaFinal).ToString("yyyy/MM/dd");
                dr["fechaIngreso"] = Convert.ToDateTime(item.FechaIngreso).ToString("yyyy/MM/dd");
                dr["basico"] = Convert.ToInt32(item.Basico);
                dr["valorTransporte"] = Convert.ToInt32(item.Transporte);
                dr["valorPromedio"] = Convert.ToInt32(item.ValorPromedio);
                dr["base"] = Convert.ToInt32(item.Base);
                dr["diasPromedio"] = Convert.ToInt32(item.DiasPromedio);
                dr["diasPrimas"] = Convert.ToInt32(item.DiasPrimas);
                dr["valorPrima"] = Convert.ToInt32(item.ValorPrima);
                dr["contrato"] = Convert.ToInt32(item.Contrato);
                table.Rows.Add(dr);
            });
            modificacionPrima.GuardarCambios(table);
            CargarDetallePrima();
            successMessage.Text = "Cambios guardados exitosamente";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los detalles de la liquidación." + ex.ToString(), "IN");
        }
    }

    private void GatheringAndValidation()
    {
        bool valid = true;
        Regex nonNumericRegex = new Regex(@"\D");
        foreach (GridViewRow dr in gvDetalleLiquidacion.Rows)
        {
            var item = ListadoDetallePrimas.Where(i => i.CodigoTercero == Server.HtmlDecode(dr.Cells[1].Text).Trim() && i.IdentificacionTercero == Server.HtmlDecode(dr.Cells[2].Text).Trim()).First();
            var txvBasico = ((TextBox)dr.FindControl("txvBasico"));
            var value = txvBasico.Text.Replace(",", "");
            txvBasico.BackColor = new Color();
            txvBasico.ForeColor = new Color();
            txvBasico.BorderColor = new Color();
            if (nonNumericRegex.IsMatch(value))
            {
                txvBasico.BackColor = Color.FromArgb(255, 218, 218);
                txvBasico.ForeColor = Color.DarkRed;
                txvBasico.BorderColor = Color.DarkRed;
                valid = false;
            }
            else
            {
                item.Basico = value;
            }

            var txvTransporte = ((TextBox)dr.FindControl("txvTransporte"));
            value = txvTransporte.Text.Replace(",", "");
            txvTransporte.BackColor = new Color();
            txvTransporte.ForeColor = new Color();
            txvTransporte.BorderColor = new Color();
            if (nonNumericRegex.IsMatch(value))
            {
                txvTransporte.BackColor = Color.FromArgb(255, 218, 218);
                txvTransporte.ForeColor = Color.DarkRed;
                txvTransporte.BorderColor = Color.DarkRed;
                valid = false;
            }
            else
            {
                item.Transporte = value;
            }

            var txvValorPromedio = (TextBox)dr.FindControl("txvValorPromedio");
            value = txvValorPromedio.Text.Replace(",", "");
            txvValorPromedio.BackColor = new Color();
            txvValorPromedio.ForeColor = new Color();
            txvValorPromedio.BorderColor = new Color();
            if (nonNumericRegex.IsMatch(value))
            {
                txvValorPromedio.BackColor = Color.FromArgb(255, 218, 218);
                txvValorPromedio.ForeColor = Color.DarkRed;
                txvValorPromedio.BorderColor = Color.DarkRed;
                valid = false;
            }
            else
            {
                item.ValorPromedio = value;
            }

            var txvDiasPromedio = (TextBox)dr.FindControl("txvDiasPromedio");
            value = txvDiasPromedio.Text.Replace(",", "");
            txvDiasPromedio.BackColor = new Color();
            txvDiasPromedio.ForeColor = new Color();
            txvDiasPromedio.BorderColor = new Color();
            if (nonNumericRegex.IsMatch(value))
            {
                txvDiasPromedio.BackColor = Color.FromArgb(255, 218, 218);
                txvDiasPromedio.ForeColor = Color.DarkRed;
                txvDiasPromedio.BorderColor = Color.DarkRed;
                valid = false;
            }
            else
            {
                item.DiasPromedio = value;
            }

            // Base calculado ValorPromedio*DiasPrimedio*30
            item.Base = Math.Round(Convert.ToDouble(item.DiasPromedio) != 0 ? Convert.ToDouble(item.ValorPromedio) / Convert.ToDouble(item.DiasPromedio) * 30 : 0,0).ToString();

            var txvDiasPrima = (TextBox)dr.FindControl("txvDiasPrima");
            value = txvDiasPrima.Text.Replace(",", "");
            txvDiasPrima.BackColor = new Color();
            txvDiasPrima.ForeColor = new Color();
            txvDiasPrima.BorderColor = new Color();
            if (nonNumericRegex.IsMatch(value))
            {
                txvDiasPrima.BackColor = Color.FromArgb(255, 218, 218);
                txvDiasPrima.ForeColor = Color.DarkRed;
                txvDiasPrima.BorderColor = Color.DarkRed;
                valid = false;
            }
            else
            {
                item.DiasPrimas = value;
            }

            // Calculado Base * DiasPrima / 360 
            item.ValorPrima = Math.Round(Convert.ToDouble(item.Base) * Convert.ToDouble(item.DiasPrimas) / 360,0).ToString();
        }

        if (!valid)
        {
            failMessage.Text = "Todos los campos de entrada deben ser números entreros positivos. Por favor, corrija.";
            return;
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
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
                return;
            }
            if (!IsPostBack)
            {
                InitView();
            }
            else
            {
                GatheringAndValidation();
                successMessage.Text = failMessage.Text = ddlTerceroVal.Text =
                txtFechaFinVal.Text = txtFechaIngresoVal.Text = txtFechaInicioVal.Text = "";
            }
        }
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("~/Nomina/Pliquidacion/LiquidacionPrimas.aspx", false);
    }

    protected void btnGuardar_Click(object sender, ImageClickEventArgs e)
    {
        GuardarDatos();
    }

    protected void gvDetalleLiquidacion_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        var dr = gvDetalleLiquidacion.Rows[e.RowIndex];
        var item = ListadoDetallePrimas.Where(i => i.CodigoTercero == Server.HtmlDecode(dr.Cells[1].Text).Trim() && i.IdentificacionTercero == Server.HtmlDecode(dr.Cells[2].Text).Trim()).First();
        ListadoDetallePrimas.Remove(item);
        gvDetalleLiquidacion.DataSource = ListadoDetallePrimas;
        gvDetalleLiquidacion.DataBind();
        CargarTerceros();
    }

    protected void btnCargar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            bool valid = true;
            if (ddlTercero.SelectedValue == "")
            {
                ddlTerceroVal.Text = "Debe seleccionar un tercero";
                valid = false;
            }
            if (txtFechaFin.Text.Trim() == "")
            {
                txtFechaFinVal.Text = "Debe seleccionar una fecha de fin";
                valid = false;
            }
            if (txtFechaIngreso.Text.Trim() == "")
            {
                txtFechaIngresoVal.Text = "Debe seleccionar una fecha de ingreso";
                valid = false;
            }
            if (txtFechaInicio.Text.Trim() == "")
            {
                txtFechaInicioVal.Text = "Debe seleccionar una fecha de inicio";
                valid = false;
            }
            if (!valid)
                return;

            var dr = modificacionPrima.CargarInformacionTercero(Session["empresa"].ToString(), ddlTercero.SelectedValue);
            var item = new LiquidacionPrimas()
            {
                CodigoTercero = !(dr["id"] is int) ? string.Empty : ((int)dr["id"]).ToString(),
                IdentificacionTercero = !(dr["identificacion"] is string) ? string.Empty : (string)dr["identificacion"],
                NombreTercero = !(dr["descripcion"] is string) ? string.Empty : (string)dr["descripcion"],
                Contrato = !(dr["contrato"] is int) ? int.MinValue : (int)dr["contrato"],
                FechaFinal = Convert.ToDateTime(txtFechaFin.Text).ToString("yyyy/MM/dd"),
                FechaInicial = Convert.ToDateTime(txtFechaInicio.Text).ToString("yyyy/MM/dd"),
                FechaIngreso = Convert.ToDateTime(txtFechaIngreso.Text).ToString("yyyy/MM/dd"),
                Base = "0",
                Basico = "0",
                DiasPrimas = "0",
                DiasPromedio = "0",
                Transporte = "0",
                ValorPrima = "0",
                ValorPromedio = "0"
            };
            ListadoDetallePrimas.Add(item);
            ListadoDetallePrimas = ListadoDetallePrimas.OrderBy(_i => Convert.ToInt32(_i.CodigoTercero)).ToList();

            gvDetalleLiquidacion.DataSource = ListadoDetallePrimas;
            gvDetalleLiquidacion.DataBind();

            CargarTerceros();

            ddlTercero.SelectedValue = "";
            txtFechaInicio.Text = "";
            txtFechaFin.Text = "";
            txtFechaIngreso.Text = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los detalles de la liquidación." + ex.ToString(), "IN");
        }
    }



    protected void lblFechaIngreso_Click(object sender, EventArgs e)
    {
        this.niCalendarFechaIngreso.Visible = true;
        this.txtFechaIngreso.Visible = false;
        this.niCalendarFechaIngreso.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFechaIngreso_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFechaIngreso.Visible = false;
        this.txtFechaIngreso.Visible = true;
        this.txtFechaIngreso.Text = this.niCalendarFechaIngreso.SelectedDate.ToShortDateString();
    }

    protected void txtFechaIngreso_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaIngreso.Text);
        }
        catch
        {
            failMessage.Text = "Formato de fecha no valido";
            txtFechaIngreso.Text = "";
            txtFechaIngreso.Focus();
        }
    }



    protected void lblFechaInicio_Click(object sender, EventArgs e)
    {
        this.CalendarFechaInicio.Visible = true;
        this.txtFechaInicio.Visible = false;
        this.CalendarFechaInicio.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFechaInicio_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaInicio.Visible = false;
        this.txtFechaInicio.Visible = true;
        this.txtFechaInicio.Text = this.CalendarFechaInicio.SelectedDate.ToShortDateString();
    }

    protected void txtFechaInicio_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaInicio.Text);
        }
        catch
        {
            failMessage.Text = "Formato de fecha no valido";
            txtFechaInicio.Text = "";
            txtFechaInicio.Focus();
        }
    }



    protected void lblFechaFin_Click(object sender, EventArgs e)
    {
        this.CalendarFechaFin.Visible = true;
        this.txtFechaFin.Visible = false;
        this.CalendarFechaFin.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFechaFin_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaFin.Visible = false;
        this.txtFechaFin.Visible = true;
        this.txtFechaFin.Text = this.CalendarFechaFin.SelectedDate.ToShortDateString();
    }

    protected void txtFechaFin_TextChanged(object sender, EventArgs e)
    {
        try
        {
            Convert.ToDateTime(txtFechaFin.Text);
        }
        catch
        {
            failMessage.Text = "Formato de fecha no valido";
            txtFechaFin.Text = "";
            txtFechaFin.Focus();
        }
    }

    #endregion Eventos

    #region EventosFuncionario

    #endregion EventosFuncionario



}
