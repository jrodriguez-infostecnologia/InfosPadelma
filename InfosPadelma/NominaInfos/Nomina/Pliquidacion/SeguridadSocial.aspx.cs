using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_Liquidacion : System.Web.UI.Page
{

    #region Instancias


    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Coperadores operadores = new Coperadores();
    Cperiodos periodo = new Cperiodos();
    string numerotransaccion = "";
    CseguridadSocial seguridadSocial = new CseguridadSocial();

    #endregion Instancias

    #region Metodos

    private void cargarCombo()
    {
        try
        {
            DataView dvTerceroCCosto = CcontrolesUsuario.OrdenarEntidad(CentidadMetodos.EntidadGet("nFuncionario", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlEmpleado.DataSource = dvTerceroCCosto;
            this.ddlEmpleado.DataValueField = "tercero";
            this.ddlEmpleado.DataTextField = "descripcion";
            this.ddlEmpleado.DataBind();
            this.ddlEmpleado.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void verificaPeriodoCerrado(int año, int mes, int empresa, DateTime fecha)
    {
        if (periodo.RetornaPeriodoCerradoNomina(año, mes, Convert.ToInt16(Session["empresa"]), fecha) == 1)
        {
            ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
            return;
        }
    }

    private void LiquidarSeguridadSocial()
    {

        this.gvLista.DataSource = seguridadSocial.LiquidaSeguridadSocial(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(nitxvAño.Text), Convert.ToInt16(niddlMes.SelectedValue));
        this.gvLista.DataBind();
        this.nilblInformacion.Visible = true;
        this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
        nilblMensaje.Text = "Liquidación generada satisfactoriamente";
    }
    private void verificaPeriodoCerradoContable(int año, int mes, int empresa)
    {
        if (periodo.RetornaPeriodoCerrado(año, mes, empresa) == 1)
        {
            ManejoError("Periodo cerrado. No es posible realizar nuevas transacciones", "I");
        }

    }
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
            if (nitxvAño.Text.Length == 0)
            {
                nilblInformacion.Text = "Debe digitar un año antes de buscar";
                return;
            }


            this.gvLista.DataSource = seguridadSocial.BuscarEntidad(Convert.ToInt16(Session["empresa"]), Convert.ToInt32(nitxvAño.Text), Convert.ToInt16(niddlMes.SelectedValue), nitxtFiltro.Text);
            this.gvLista.DataBind();
            this.nilblInformacion.Visible = true;
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
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
      "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }
    private void EntidadKey()
    {
        object[] objKey = new object[] { ""
            //ddlAño.SelectedValue, ddlCentroCosto.SelectedValue, Convert.ToInt16(Session["empresa"]), ddlMes.SelectedValue, ddlPeriodo.SelectedValue
        };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "nConceptosFijos",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Ya se encuentra registrada la combinación";

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
            string ING = " ", RET = " ", TDE = " ", TAE = " ", TDP = " ", TAP = " ", VSP = " ", VTE = " ", VST = " ", SLN = " ", IGE = " ", LMA = " ", VAC = " ", AVP = " ", VCT = " ", IRP = " ", ExS = "N";

            if (chkING.Checked)
                ING = "X";
            if (chkRET.Checked)
                RET = "X";
            if (chkTDE.Checked)
                TDE = "X";
            if (chkTAE.Checked)
                TAE = "X";
            if (chkTDP.Checked)
                TDP = "X";
            if (chkTAP.Checked)
                TAP = "X";
            if (chkVST.Checked)
                VST = "X";
            if (chkSLN.Checked)
                SLN = "X";
            if (chkIGE.Checked)
                IGE = "X";
            if (chkLMA.Checked)
                LMA = "X";
            if (chkVAC.Checked)
                VAC = "X";
            if (chkAVP.Checked)
                AVP = "X";
            if (chkVCT.Checked)
                VCT = "X";
            if (chkExoneraSalud.Checked)
                ExS = "S";


            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                object[] objValoEditar = new object[]{   
                    Convert.ToDecimal(txvAño.Text),
                    AVP,
                    Convert.ToDecimal(txvDiasARP.Text),
                    Convert.ToDecimal(txvDiasCaja.Text),
                    Convert.ToDecimal(txvDiasPension.Text),
                    Convert.ToDecimal(txvDiasSalud.Text),
                                      Convert.ToInt16(Session["empresa"]),    //@empresa	int
                                      ExS,
                    Convert.ToDecimal(txvIBCArp.Text),
                    Convert.ToDecimal(txvIBCCaja.Text),
                    Convert.ToDecimal(txvIBCPension.Text),
                    Convert.ToDecimal(txvIBCSalud.Text),
                    ddlEmpleado.SelectedValue,
                    IGE,ING,    
                    Convert.ToDecimal(txvIRP.Text),
                    LMA,ddlMes.SelectedValue,
                    Convert.ToDecimal(txvpARP.Text),
                    Convert.ToDecimal(txvpCaja.Text),
                    Convert.ToDecimal(txvpFondo.Text),
                    Convert.ToDecimal(txvpPension.Text),
                    Convert.ToDecimal(txvpSalud.Text),
                    Convert.ToDecimal(lbRegistro.Text),
                    RET,SLN,TAE,TAP,TDE,TDP,VAC,
                    Convert.ToDecimal(txvValorARP.Text),
                    Convert.ToDecimal(txvValorCaja.Text),
                    Convert.ToDecimal(txvValorFondo1.Text),
                    Convert.ToDecimal(txvValorFondo2.Text),
                    Convert.ToDecimal(txvValorICBF.Text),
                    Convert.ToDecimal(txvValorPension.Text),
                    Convert.ToDecimal(txvValorSalud.Text),
                    Convert.ToDecimal(txvValorSena.Text),
                    VCT,VSP,VST,VTE                              
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nSeguridadSocial", operacion, "ppa", objValoEditar))
                {
                    case 0:
                        ManejoExito("Datos actualizado satisfactoriamente", "I");
                        break;
                    case 1:
                        ManejoError("Error al insertar el detalle de la transaccción", "I");
                        break;
                }
            }
            else
            {
                object[] objValo = new object[]{   
                    Convert.ToDecimal(txvAño.Text),
                    AVP,
                    Convert.ToDecimal(txvDiasARP.Text),
                    Convert.ToDecimal(txvDiasCaja.Text),
                    Convert.ToDecimal(txvDiasPension.Text),
                    Convert.ToDecimal(txvDiasSalud.Text),
                                      Convert.ToInt16(Session["empresa"]),    //@empresa	int
                                      ExS,
                    Convert.ToDecimal(txvIBCArp.Text),
                    Convert.ToDecimal(txvIBCCaja.Text),
                    Convert.ToDecimal(txvIBCPension.Text),
                    Convert.ToDecimal(txvIBCSalud.Text),
                    ddlEmpleado.SelectedValue,
                    IGE,ING,IRP,LMA,ddlMes.SelectedValue,
                    Convert.ToDecimal(txvpARP.Text),
                    Convert.ToDecimal(txvpCaja.Text),
                    Convert.ToDecimal(txvpFondo.Text),
                    Convert.ToDecimal(txvpPension.Text),
                    Convert.ToDecimal(txvpSalud.Text),
                    RET,SLN,TAE,TAP,TDE,TDP,VAC,
                    Convert.ToDecimal(txvValorARP.Text),
                    Convert.ToDecimal(txvValorCaja.Text),
                    Convert.ToDecimal(txvValorFondo1.Text),
                    Convert.ToDecimal(txvValorFondo2.Text),
                    Convert.ToDecimal(txvValorICBF.Text),
                    Convert.ToDecimal(txvValorPension.Text),
                    Convert.ToDecimal(txvValorSalud.Text),
                    Convert.ToDecimal(txvValorSena.Text),
                    VCT,VSP,VST,VTE                              
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("nSeguridadSocial", operacion, "ppa", objValo))
                {
                    case 0:
                        ManejoExito("Datos registrados satisfactoriamente", "I");
                        break;
                    case 1:
                        ManejoError("Error al insertar el detalle de la transaccción", "I");
                        break;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }
    }
    private string ConsecutivoTransaccion()
    {
        string numero = "";

        try
        {
            // numero = transacciones.RetornaNumeroTransaccion(ConfigurationManager.AppSettings["TipoTransaccionNomina"].ToString(), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el número de transacción. Correspondiente a: " + ex.Message, "C");
        }

        return numero;
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
                // nitxvAño.Text = DateTime.Now.Year.ToString();
            }
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
        if (nitxvAño.Text.Length == 0 || niddlMes.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Seleccione un año y mes a liquidar, antes de registrar";
            return;
        }

        verificaPeriodoCerradoContable(Convert.ToInt32(nitxvAño.Text), Convert.ToInt32(niddlMes.SelectedValue), Convert.ToInt16(Session["empresa"]));

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        cargarCombo();
        this.nilbNuevo.Visible = false;
        this.nibtnLiquidar.Visible = false;
        this.Session["editar"] = null;
        this.nilblInformacion.Text = "";
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.nibtnLiquidar.Visible = true;
        this.Session["editar"] = null;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            object[] objValores = new object[] {
                Convert.ToInt16(gvLista.Rows[e.RowIndex].Cells[44].Text),
                Convert.ToInt16(Session["empresa"]),
                Convert.ToInt16(gvLista.Rows[e.RowIndex].Cells[45].Text),
                Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[2].Text),
                
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("nSeguridadSocial", "elimina", "ppa", objValores))
            {
                case 0:
                    ManejoExito("Registro eliminado satisfactoriamente", "E");
                    break;
                case 1:
                    ManejoError("Error al eliminar el registro. Operación no realizada", "E");
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    protected void btnLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        if (nitxvAño.Text.Length == 0 || niddlMes.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Seleccione un año y mes a liquidar";
            return;
        }
        verificaPeriodoCerradoContable(Convert.ToInt32(nitxvAño.Text), Convert.ToInt32(niddlMes.SelectedValue), Convert.ToInt16(Session["empresa"]));


        LiquidarSeguridadSocial();
    }
    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        ddlMes.Enabled = false;
        txvAño.Enabled = false;

        cargarCombo();
        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.lbRegistro.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            else
                this.lbRegistro.Text = "0";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                ddlEmpleado.SelectedValue = this.gvLista.SelectedRow.Cells[3].Text;
            ddlEmpleado.Enabled = false;

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                this.txvIBCPension.Text = this.gvLista.SelectedRow.Cells[6].Text;
            else
                this.txvIBCPension.Text = "0";

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
                this.txvDiasPension.Text = this.gvLista.SelectedRow.Cells[7].Text;
            else
                this.txvDiasPension.Text = "0";

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                this.txvpPension.Text = this.gvLista.SelectedRow.Cells[8].Text;
            else
                this.txvpPension.Text = "0";

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
                this.txvValorPension.Text = this.gvLista.SelectedRow.Cells[9].Text;
            else
                this.txvValorPension.Text = "0";

            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                this.txvValorFondo1.Text = this.gvLista.SelectedRow.Cells[10].Text;
            else
                this.txvValorFondo1.Text = "0";

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                this.txvValorFondo2.Text = this.gvLista.SelectedRow.Cells[11].Text;
            else
                this.txvValorFondo2.Text = "0";

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
                this.txvIBCSalud.Text = this.gvLista.SelectedRow.Cells[12].Text;
            else
                this.txvIBCSalud.Text = "0";

            if (this.gvLista.SelectedRow.Cells[13].Text != "&nbsp;")
                this.txvDiasSalud.Text = this.gvLista.SelectedRow.Cells[13].Text;
            else
                this.txvDiasSalud.Text = "0";

            if (this.gvLista.SelectedRow.Cells[14].Text != "&nbsp;")
                this.txvpSalud.Text = this.gvLista.SelectedRow.Cells[14].Text;
            else
                this.txvpSalud.Text = "0";

            if (this.gvLista.SelectedRow.Cells[15].Text != "&nbsp;")
                this.txvValorSalud.Text = this.gvLista.SelectedRow.Cells[15].Text;
            else
                this.txvValorSalud.Text = "0";

            if (this.gvLista.SelectedRow.Cells[16].Text != "&nbsp;")
                this.txvIBCArp.Text = this.gvLista.SelectedRow.Cells[16].Text;
            else
                this.txvIBCArp.Text = "0";

            if (this.gvLista.SelectedRow.Cells[17].Text != "&nbsp;")
                this.txvDiasARP.Text = this.gvLista.SelectedRow.Cells[17].Text;
            else
                this.txvDiasARP.Text = "0";

            if (this.gvLista.SelectedRow.Cells[18].Text != "&nbsp;")
                this.txvpARP.Text = this.gvLista.SelectedRow.Cells[18].Text;
            else
                this.txvpARP.Text = "0";

            if (this.gvLista.SelectedRow.Cells[19].Text != "&nbsp;")
                this.txvValorARP.Text = this.gvLista.SelectedRow.Cells[19].Text;
            else
                this.txvValorARP.Text = "0";

            if (this.gvLista.SelectedRow.Cells[20].Text != "&nbsp;")
                this.txvIBCCaja.Text = this.gvLista.SelectedRow.Cells[20].Text;
            else
                this.txvIBCCaja.Text = "0";

            if (this.gvLista.SelectedRow.Cells[21].Text != "&nbsp;")
                this.txvDiasCaja.Text = this.gvLista.SelectedRow.Cells[21].Text;
            else
                this.txvDiasCaja.Text = "0";

            if (this.gvLista.SelectedRow.Cells[22].Text != "&nbsp;")
                this.txvpCaja.Text = this.gvLista.SelectedRow.Cells[22].Text;
            else
                this.txvpCaja.Text = "0";

            if (this.gvLista.SelectedRow.Cells[23].Text != "&nbsp;")
                this.txvValorCaja.Text = this.gvLista.SelectedRow.Cells[23].Text;
            else
                this.txvValorCaja.Text = "0";

            if (this.gvLista.SelectedRow.Cells[24].Text != "&nbsp;")
                this.txvValorSena.Text = this.gvLista.SelectedRow.Cells[24].Text;
            else
                this.txvValorSena.Text = "0";

            if (this.gvLista.SelectedRow.Cells[25].Text != "&nbsp;")
                this.txvValorICBF.Text = this.gvLista.SelectedRow.Cells[25].Text;
            else
                this.txvValorICBF.Text = "0";

            if (this.gvLista.SelectedRow.Cells[26].Text == "X")
                chkING.Checked = true;
            else
                chkING.Checked = false;

            if (this.gvLista.SelectedRow.Cells[27].Text == "X")
                chkRET.Checked = true;
            else
                chkRET.Checked = false;
            if (this.gvLista.SelectedRow.Cells[28].Text == "X")
                chkTDE.Checked = true;
            else
                chkTDE.Checked = false;
            if (this.gvLista.SelectedRow.Cells[29].Text == "X")
                chkTAE.Checked = true;
            else
                chkTAE.Checked = false;
            if (this.gvLista.SelectedRow.Cells[30].Text == "X")
                chkTDP.Checked = true;
            else
                chkTDP.Checked = false;
            if (this.gvLista.SelectedRow.Cells[31].Text == "X")
                chkTAP.Checked = true;
            else
                chkTAP.Checked = false;

            if (this.gvLista.SelectedRow.Cells[32].Text == "X")
                chkVSP.Checked = true;
            else
                chkVSP.Checked = false;

            if (this.gvLista.SelectedRow.Cells[33].Text == "X")
                chkVTE.Checked = true;
            else
                chkVTE.Checked = false;

            if (this.gvLista.SelectedRow.Cells[34].Text == "X")
                chkVST.Checked = true;
            else
                chkVST.Checked = false;

            if (this.gvLista.SelectedRow.Cells[35].Text == "X")
                chkSLN.Checked = true;
            else
                chkSLN.Checked = false;
            if (this.gvLista.SelectedRow.Cells[36].Text == "X")
                chkIGE.Checked = true;
            else
                chkIGE.Checked = false;
            if (this.gvLista.SelectedRow.Cells[37].Text == "X")
                chkLMA.Checked = true;
            else
                chkLMA.Checked = false;

            if (this.gvLista.SelectedRow.Cells[38].Text == "X")
                chkVAC.Checked = true;
            else
                chkVAC.Checked = false;

            if (this.gvLista.SelectedRow.Cells[39].Text == "X")
                chkAVP.Checked = true;
            else
                chkAVP.Checked = false;

            if (this.gvLista.SelectedRow.Cells[40].Text == "X")
                chkVCT.Checked = true;
            else
                chkVCT.Checked = false;

            if (this.gvLista.SelectedRow.Cells[41].Text != "&nbsp;")
                txvIRP.Text = this.gvLista.SelectedRow.Cells[41].Text;
            else
                this.txvIRP.Text = "0";

            if (this.gvLista.SelectedRow.Cells[42].Text == "S")
                chkExoneraSalud.Checked = true;
            else
                chkExoneraSalud.Checked = false;

            if (this.gvLista.SelectedRow.Cells[43].Text != "&nbsp;")
                txvpFondo.Text = this.gvLista.SelectedRow.Cells[43].Text;
            else
                this.txvpFondo.Text = "0";

            if (this.gvLista.SelectedRow.Cells[44].Text != "&nbsp;")
                txvAño.Text = this.gvLista.SelectedRow.Cells[44].Text;
            else
                this.txvAño.Text = "0";

            if (this.gvLista.SelectedRow.Cells[45].Text != "&nbsp;")
                ddlMes.SelectedValue = this.gvLista.SelectedRow.Cells[45].Text;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }
    protected void nibtnGenerarPlano_Click(object sender, ImageClickEventArgs e)
    {
        if (nitxvAño.Text.Length == 0)
        {
            nilblInformacion.Text = "Debe digitar el año";
            return;
        }
        string script = "<script language='javascript'>" +
                         "VisualizacionPlano(" + Convert.ToString(this.Session["empresa"]) + "," + Convert.ToString(nitxvAño.Text) + "," + Convert.ToString(niddlMes.SelectedValue) + ")" +
                          "</script>";
        Page.RegisterStartupScript("VisualizacionPlano", script);

    }
    #endregion Eventos



}

