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

public partial class Administracion_Caracterizacion : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cdensidad densidad = new Cdensidad();
    CIP ip = new CIP();
    Ccaracteristica caracteristicas = new Ccaracteristica();
    Ctransaccion transacciones = new Ctransaccion();

    #endregion Instancias

    #region Funciones

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
    }
    private void Cancelar()
    {

        this.gvLista.Visible = true;
        this.nilbAsociarVariable.Visible = true;
        this.pAsociacion.Visible = false;
        this.ddlMovimientos.SelectedValue = "";

        this.chkResultado.Checked = false;
        this.pFormula.Visible = false;
        this.ddlAnalisisF.SelectedValue = "";
        this.txtConstante.Text = "";
        this.txtFormula.Text = "";
        this.lblExpresion.Text = "";
        this.lblResultadoFormula.Text = "";
        this.hdConteoItems.Value = "0";
        this.ddlItemsRetornaDatos.DataSource = null;
        this.ddlItemsRetornaDatos.DataBind();
        this.btnRegistrar.Visible = false;
        this.btnCancelar.Visible = false;
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

        this.Response.Redirect("~/Produccion/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        seguridad.InsertaLog(
        this.Session["usuario"].ToString(),
        operacion,
        ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
        "ex",
        mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));


    }
    private void CargaItemsRetornaDatos(int orden)
    {
        try
        {
            this.ddlItemsRetornaDatos.DataSource = transacciones.GetItemRetornaDatos(
                orden, Convert.ToInt16(Session["empresa"]));
            this.ddlItemsRetornaDatos.DataValueField = "codigo";
            this.ddlItemsRetornaDatos.DataTextField = "descripcion";
            this.ddlItemsRetornaDatos.DataBind();
            this.ddlItemsRetornaDatos.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblMensaje.ForeColor = System.Drawing.Color.Red;
            this.nilblMensaje.Text = "Error al cargar combos asociación. Correspondiente a: " + ex.Message;
        }
    }
    private void VerificaFormula()
    {
        string expresion = "";

        try
        {
            transacciones.VerificaFormulaP(this.niddlProducto.SelectedValue, this.txtFormula.Text.Trim(), "V", out expresion, Convert.ToInt16(Session["empresa"]));

            this.lblResultadoFormula.ForeColor = System.Drawing.Color.Navy;
            this.lblResultadoFormula.Text = expresion;
        }
        catch (Exception ex)
        {

            this.lblResultadoFormula.ForeColor = System.Drawing.Color.Orange;
            this.lblResultadoFormula.Text = ex.Message;
        }
    }
    private void CargaCombosAsociacion()
    {
        try
        {
            this.ddlAnalisisF.DataSource = DvProductoMovimiento(
                this.niddlProducto.SelectedValue, this.niddlModulo.SelectedValue.Trim());
            this.ddlAnalisisF.DataValueField = "codigo";
            this.ddlAnalisisF.DataTextField = "descripcion";
            this.ddlAnalisisF.DataBind();
            this.ddlAnalisisF.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            this.nilblMensaje.ForeColor = System.Drawing.Color.Red;
            this.nilblMensaje.Text = "Error al cargar combos asociación. Correspondiente a: " + ex.Message;
        }
    }
    private DataView DvProductoMovimiento(string producto, string modulo)
    {
        try
        {
            DataView dvVariables = caracteristicas.GetMovimientoProducto(
                producto, Convert.ToInt16(Session["empresa"]),modulo).Tables[0].DefaultView;

            return dvVariables;
        }
        catch (Exception ex)
        {
            this.nilblMensaje.ForeColor = System.Drawing.Color.Red;
            this.nilblMensaje.Text = "Error al cargar análisis asociados. Correspondiente a: " + ex.Message;
            return null;
        }
    }
    private void EntidadKey()
    {
        object[] objKey = new object[] { Convert.ToInt16(Session["empresa"]),niddlModulo.SelectedValue, ddlMovimientos.SelectedValue.Trim().ToString(), niddlProducto.SelectedValue };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "pProductoMovimiento",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblMensaje.Visible = true;
                this.nilblMensaje.Text = "Movimiento " + this.ddlMovimientos.SelectedItem.Text + " ya se encuentra asociado al producto " + niddlProducto.SelectedItem.Text;

                Cancelar();

            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }

    private void CargarMovimientos()
    {
        this.nilblMensaje.Text = "";

        try
        {

            CargaCombosAsociacion();

            this.nilblMensaje.Text = "";
            this.gvLista.Visible = true;
            this.nilbAsociarVariable.Visible = true;
            this.pAsociacion.Visible = false;
            this.ddlMovimientos.SelectedValue = "";

            this.chkResultado.Checked = false;
            this.pFormula.Visible = false;
            this.ddlAnalisisF.SelectedValue = "";
            this.txtConstante.Text = "";
            this.txtFormula.Text = "";
            this.lblExpresion.Text = "";
            this.lblResultadoFormula.Text = "";

            this.nilbAsociarVariable.Visible = true;

            CargarProductoMovimientos();

            if (this.gvLista.Rows.Count > 0)
            {
                this.nilblMensaje.Visible = true;
                this.nilblMensaje.Text = "";
            }
            else
            {
                this.nilblMensaje.ForeColor = System.Drawing.Color.Navy;
                this.nilblMensaje.Text = "!!Sin caracterizar!!";
            }

            CcontrolesUsuario.InhabilitarControles(
                this.Page.Controls);

            this.gvLista.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al retornar análisis. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void CargaMovimientosAsociados()
    {
        try
        {
            DataView dvConcepto = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            dvConcepto.RowFilter = "tipo in ('M','T','V','C','SA','VS','CS') and empresa=" + Session["empresa"].ToString();
            this.ddlMovimientos.DataSource = dvConcepto;
            this.ddlMovimientos.DataValueField = "codigo";
            this.ddlMovimientos.DataTextField = "descripcion";
            this.ddlMovimientos.DataBind();
            this.ddlMovimientos.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {

            ManejoError("Error al cargar movimientos. Correspondiente a: " + ex.Message, "C");
        }
    }
    private void CargarProductoMovimientos()
    {

        try
        {
            this.gvLista.DataSource = caracteristicas.GetMovimientoProducto(niddlProducto.SelectedValue, Convert.ToInt16(Session["empresa"]), niddlModulo.SelectedValue.Trim()).Tables[0].DefaultView;
            this.gvLista.DataBind();

            if (this.gvLista.Rows.Count == 0)
            {
                this.nilblMensaje.ForeColor = System.Drawing.Color.Navy;
                this.nilblMensaje.Text = "Elemento sin características definidas";
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los análisis asociados a la jerarquía. Correspondiente a: " + ex.Message, "C");
        }
    }
    void cargarProducto()
    {

        try
        {
            DataView dvProducto = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            dvProducto.RowFilter = "tipo in ('P','T','CP') and empresa=" + Session["empresa"].ToString();
            this.niddlProducto.DataSource = dvProducto;
            this.niddlProducto.DataValueField = "codigo";
            this.niddlProducto.DataTextField = "descripcion";
            this.niddlProducto.DataBind();
            this.niddlProducto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los productos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView dvProducto =CentidadMetodos.EntidadGet("smodulos", "ppa").Tables[0].DefaultView;
            dvProducto.Sort ="descripcion";
            this.niddlModulo.DataSource = dvProducto;
            this.niddlModulo.DataValueField = "codigo";
            this.niddlModulo.DataTextField = "descripcion";
            this.niddlModulo.DataBind();
            this.niddlModulo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los modulos. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Funciones

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
                    cargarProducto();
                }
                this.niddlProducto.Focus();

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }


        }
    }
    protected void nilbAsociarCaracteristica_Click(object sender, ImageClickEventArgs e)
    {
        CargaMovimientosAsociados();
        CargaCombosAsociacion();

        this.pAsociacion.Visible = true;
        this.nilblMensaje.Text = "";
        this.nilbAsociarVariable.Visible = false;
        this.pAsociacion.Visible = true;
        this.txtOrden.Text = "";
        this.txtPrioridad.Text = "";
        this.chkResultado.Checked = false;
        this.pFormula.Visible = false;
        this.ddlAnalisisF.SelectedValue = "";
        this.txtConstante.Text = "";
        this.txtFormula.Text = "";
        this.lblExpresion.Text = "";
        this.lblResultadoFormula.Text = "";
        this.btnRegistrar.Visible = true;
        this.btnCancelar.Visible = true;
        this.Session["editar"] = false;

    }

    protected void chkResultadoProduccion_CheckedChanged(object sender, EventArgs e)
    {
        this.chkResultado.Focus();

        if (this.chkResultado.Checked == true)
        {
            this.pFormula.Visible = true;

        }
        else
        {
            this.pFormula.Visible = false;
        }
    }

    protected void imbAddSentencia_Click(object sender, ImageClickEventArgs e)
    {
        if (this.ddlSentencia.SelectedValue.Trim().Length != 0)
        {
            if (this.ddlSentencia.SelectedValue.Trim().Equals("dbo.fRetornaDeTabla("))
            {

                this.txtFormula.Text = this.txtFormula.Text.Trim() + "|L" + this.ddlSentencia.SelectedValue.Trim();
                CargaItemsRetornaDatos(1);
            }

            else

                if (this.ddlSentencia.SelectedValue.StartsWith("dbo"))
                {
                    this.txtFormula.Text = this.txtFormula.Text.Trim() + "|F" + this.ddlSentencia.SelectedValue.Trim();

                    CargaItemsRetornaDatos(1);
                }

                else
                {
                    this.txtFormula.Text = this.txtFormula.Text.Trim() + "|S" + this.ddlSentencia.SelectedValue.Trim() + "|";
                }

            this.lblExpresion.Text = this.lblExpresion.Text + this.ddlSentencia.SelectedValue;
            this.ddlSentencia.SelectedIndex = 0;
        }
    }

    protected void imbAddVariable_Click(object sender, ImageClickEventArgs e)
    {
        if (this.txtFormula.Text.Trim().StartsWith("|Ldbo.fRetornaDeTabla("))
        {
            if (Convert.ToInt16(this.hdConteoItems.Value) == 3)
            {
                this.txtFormula.Text = this.txtFormula.Text.Trim() +"|V(" + this.ddlAnalisisF.SelectedValue.Trim() + ")|";
                this.lblExpresion.Text = this.lblExpresion.Text + this.ddlAnalisisF.SelectedItem;
                this.ddlAnalisisF.SelectedIndex = 0;
                this.ddlItemsRetornaDatos.DataSource = null;
                this.ddlItemsRetornaDatos.DataBind();
                this.txtFormula.Text = this.txtFormula.Text + "|S)|";
                this.lblExpresion.Text = this.lblExpresion.Text + ")";
            }


        }
        else if (this.ddlAnalisisF.SelectedValue.Trim().Length != 0)
        {
            this.txtFormula.Text = this.txtFormula.Text.Trim() + "|V(" + this.ddlAnalisisF.SelectedValue.Trim() + ")|";
            this.lblExpresion.Text = this.lblExpresion.Text + this.ddlAnalisisF.SelectedItem;
            this.ddlAnalisisF.SelectedIndex = 0;
        }
    }

    protected void imbAddConstante_Click(object sender, ImageClickEventArgs e)
    {
        if (this.txtConstante.Text.Trim().Length != 0)
        {
            this.txtFormula.Text = this.txtFormula.Text.Trim() + "|N" + this.txtConstante.Text.Trim() + "|";
            this.lblExpresion.Text = this.lblExpresion.Text + this.txtConstante.Text;
            this.txtConstante.Text = "";
        }
    }

    protected void imbUndo_Click(object sender, ImageClickEventArgs e)
    {
        if (this.txtFormula.Text.Trim().Length > 0)
        {
            this.txtFormula.Text = "";
            this.lblExpresion.Text = "";
            this.hdConteoItems.Value = "0";
        }
    }

    protected void imbValidarFormula_Click(object sender, ImageClickEventArgs e)
    {
        VerificaFormula();
    }


    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";
        this.nilblMensaje.Text = "";

        try
        {
            object[] objValores = new object[] {       
                Convert.ToInt16(Session["empresa"]),          
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
               niddlProducto.SelectedValue
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "pProductoMovimiento",
                operacion,
                "ppa",
                objValores) == 0)
            {
                CargarProductoMovimientos();
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
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.Session["editar"] = true;
        this.nilblMensaje.Text = "";
        CargaMovimientosAsociados();
        CargaCombosAsociacion();
        string formula = "", expresion = "";
        try
        {
            object[] objValores = new object[] { Convert.ToInt16(Session["empresa"]),  niddlModulo.SelectedValue.Trim() ,this.gvLista.SelectedRow.Cells[2].Text.Trim(),
                niddlProducto.SelectedValue.Trim()  };

            object[] objVariables = transacciones.DatosProductoMovmineto(
                objValores);
            formula = Convert.ToString(objVariables.GetValue(3));


            if (Convert.ToBoolean(objVariables.GetValue(6)) == true)
            {
                ddlMovimientos.SelectedValue = objVariables.GetValue(2).ToString();
                pAsociacion.Visible = true;
                chkResultado.Checked = true;
                this.txtOrden.Text = objVariables.GetValue(5).ToString();
                chkDecimal.Checked = Convert.ToBoolean(objVariables.GetValue(9));
                this.chkCalcular.Checked = Convert.ToBoolean(objVariables.GetValue(8));
                pFormula.Visible = true;
                this.txtPrioridad.Text = objVariables.GetValue(4).ToString();
                this.txtFormula.Text = objVariables.GetValue(3).ToString();
                this.chkMostrarInforme.Checked = Convert.ToBoolean(objVariables.GetValue(10));
                chkAlmacena.Checked = Convert.ToBoolean(objVariables.GetValue(7));
                chkActivo.Checked = Convert.ToBoolean(objVariables.GetValue(11));
                lblExpresion.Text = objVariables.GetValue(13).ToString();
                
                           
            }
            else
            {
                pAsociacion.Visible = true;
                ddlMovimientos.SelectedValue = objVariables.GetValue(2).ToString();
                chkResultado.Checked = false;
                this.txtOrden.Text = objVariables.GetValue(5).ToString();
                chkDecimal.Checked = Convert.ToBoolean(objVariables.GetValue(9));
                this.chkCalcular.Checked = Convert.ToBoolean(objVariables.GetValue(8));
                this.chkMostrarInforme.Checked = Convert.ToBoolean(objVariables.GetValue(10));
                chkAlmacena.Checked = Convert.ToBoolean(objVariables.GetValue(7));
                pFormula.Visible = false;
                chkActivo.Checked = Convert.ToBoolean(objVariables.GetValue(11));
                lblExpresion.Text = objVariables.GetValue(13).ToString();

            }


            if (formula.Trim().Length != 0)
                transacciones.VerificaFormulaP(niddlProducto.SelectedValue, formula, "V", out expresion, Convert.ToInt16(Session["empresa"]));

            this.nilblMensaje.Text = expresion;
            this.btnCancelar.Visible = true;
            this.btnRegistrar.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar la formula del análisis. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void imbItems_Click(object sender, ImageClickEventArgs e)
    {
        if (Convert.ToInt16(this.hdConteoItems.Value) == 4)
        {
            this.hdConteoItems.Value = "0";
        }

        if (this.ddlItemsRetornaDatos.SelectedValue.Trim().Length != 0)
        {
            this.txtFormula.Text = this.txtFormula.Text.Trim() + "'" + this.ddlItemsRetornaDatos.SelectedValue.Trim() + "'";
            this.lblExpresion.Text = this.lblExpresion.Text + this.ddlItemsRetornaDatos.SelectedValue;
            this.hdConteoItems.Value = Convert.ToString(Convert.ToInt16(this.hdConteoItems.Value) + 1);



            if (Convert.ToInt16(this.hdConteoItems.Value) == 4)
            {
                this.ddlItemsRetornaDatos.DataSource = null;
                this.ddlItemsRetornaDatos.DataBind();
                this.txtFormula.Text = this.txtFormula.Text + ",'" + Convert.ToString(Session["empresa"]) + "'||S)|";
                this.lblExpresion.Text = this.lblExpresion.Text + ")";
            }
            else
            {
                CargaItemsRetornaDatos(Convert.ToInt16(this.hdConteoItems.Value) + 1);

                this.ddlItemsRetornaDatos.SelectedIndex = 0;
                this.txtFormula.Text = this.txtFormula.Text + ",";
                this.lblExpresion.Text = this.lblExpresion.Text + ",";

                if (Convert.ToInt16(this.hdConteoItems.Value) == 3 && this.txtFormula.Text.Trim().StartsWith("|Ldbo.fRetornaDeTabla("))
                {
                    this.txtFormula.Text = this.txtFormula.Text + "'" + Convert.ToString(Session["empresa"]) + "',|";
                    this.ddlItemsRetornaDatos.DataSource = null;
                    this.ddlItemsRetornaDatos.DataBind();
                }
            }
        }
    }


    protected void ddlProducto_SelectedIndexChanged(object sender, EventArgs e)
    {
        if(niddlProducto.SelectedValue.Trim().Length>0 & niddlProducto.SelectedValue.Trim().Length>0)
             CargarMovimientos();
    }

    protected void btnRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        this.nilblMensaje.Text = "";

        string formula = "";
        int prioridad = 0, orden = 0;

        if (this.ddlMovimientos.SelectedValue.Trim().Length == 0)
        {
            this.nilblMensaje.ForeColor = System.Drawing.Color.Red;
            this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
            return;
        }

        if (chkResultado.Checked == true)
        {
            if (this.txtFormula.Text.Trim().Length == 0)
            {
                this.nilblMensaje.ForeColor = System.Drawing.Color.Red;
                this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
                return;
            }
            else
            {
                VerificaFormula();

                if (this.lblResultadoFormula.ForeColor == System.Drawing.Color.Orange)
                {
                    return;
                }
                else
                {
                    formula = this.txtFormula.Text.Trim();
                }
            }
        }

        if (this.txtOrden.Text.Trim().Length == 0)
        {
            this.nilblMensaje.ForeColor = System.Drawing.Color.Red;
            this.nilblMensaje.Text = "Campos vacios. Por favor corrija";
            return;
        }
        else
        {
            orden = Convert.ToInt16(this.txtOrden.Text);
        }

        if (this.txtPrioridad.Text.Trim().Length == 0)
        {
            prioridad = 0;
        }
        else
        {
            prioridad = Convert.ToInt16(this.txtPrioridad.Text);
        }

        string operacion = "inserta";


        object[] objValores = new object[]{
            chkActivo.Checked,
            this.chkAlmacena.Checked,
            Convert.ToUInt16(Session["empresa"]),
            lblExpresion.Text,
            formula,
            chkCalcular.Checked,
            this.chkDecimal.Checked,
            this.chkMostrarInforme.Checked,
            niddlModulo.SelectedValue.Trim(),
            this.ddlMovimientos.SelectedValue.Trim(),
            orden,
            prioridad,
            this.niddlProducto.SelectedValue,
            this.chkResultado.Checked
        };

        try
        {

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }
            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "pProductoMovimiento",
                operacion,
                "ppa",
                objValores))
            {
                case 0:

                    CargaCombosAsociacion();
                    CargarProductoMovimientos();

                    ManejoExito("Registro guardado exitosamente !!", "I");
                    this.gvLista.Visible = true;
                    this.ddlMovimientos.SelectedValue = "";
                    this.chkResultado.Checked = false;
                    this.chkAlmacena.Checked = false;
                    this.pFormula.Visible = false;
                    this.ddlAnalisisF.SelectedValue = "";
                    this.txtConstante.Text = "";
                    this.txtFormula.Text = "";
                    this.lblExpresion.Text = "";
                    this.lblResultadoFormula.Text = "";
                    this.btnRegistrar.Visible = false;
                    this.btnCancelar.Visible = false;
                    this.pAsociacion.Visible = false;
                    this.nilbAsociarVariable.Visible = true;
                    break;

                case 1:

                    ManejoError("Error al guardar el registro. Operación no realizada", "I");
                    break;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al insertar el registro. Correspondiente a: " + ex.Message, "I");
        }
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CargaCombosAsociacion();
        Cancelar();
        CargarProductoMovimientos();
        this.nilblMensaje.Text = "";
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        CargarMovimientos();
        gvLista.DataBind();
    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        if (niddlProducto.SelectedValue.Trim().Length > 0 & niddlModulo.SelectedValue.Trim().Length > 0)
            CargarMovimientos();
        else
            nilblMensaje.Text = "Seleccione un producto y un modulo valido";
    }

    protected void ddlVariable_SelectedIndexChanged(object sender, EventArgs e)
    {
        EntidadKey();
        txtOrden.Focus();
    }

    #endregion Eventos


}
