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
using System.Drawing;
using System.Collections.Generic;




public partial class Laboratorio_Panalisis_RegistroAnalisis : System.Web.UI.Page
{
    #region Instancias

    Cvehiculos vehiculos = new Cvehiculos();
    Canalisis analisis = new Canalisis();
    Cproductos productos = new Cproductos();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    List<SELLO> ListaSellos = new List<SELLO>();
    CIP ip = new CIP();

    #endregion Instancias

    #region Metodos


    private void manejoSello()
    {
        try
        {
            int retorno = analisis.VerificaAnalisisSellos(Convert.ToInt16(ddlProducto.SelectedValue.Trim()), Convert.ToInt16(this.Session["empresa"]));

            if (retorno == 0)
            {
                lblSellos.Visible = false;
                txtSellos.Visible = false;
                imgAgregarSello.Visible = false;
            }
            else
            {
                lblSellos.Visible = true;
                txtSellos.Visible = true;
                imgAgregarSello.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error validar sellos debido a: " + ex.Message);
        }
    }

    protected string nombrePaginaActual()
    {
        string[] arrResult = HttpContext.Current.Request.RawUrl.Split('/');
        string result = arrResult[arrResult.GetUpperBound(0)];
        arrResult = result.Split('?');
        return arrResult[arrResult.GetLowerBound(0)];
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

        this.Response.Redirect("~/Laboratorio/Error.aspx", false);
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

    private void Guardar()
    {
        bool tanques = false;
        bool resultados = true;

        this.nilblMensaje.Text = "";

        if (lblSellos.Visible == true)
        {
            if (dtSellos.Items.Count == 0)
            {
                this.nilblMensaje.Text = "No hay sellos asignados por favor verifique";
                return;
            }
        }

        if (gvLista.Rows.Count == 0)
        {
            this.nilblMensaje.Text = "No hay análisis asociados por favor verifique";
            return;

        }

        if (gvTanques.Rows.Count == 0)
        {
            this.nilblMensaje.Text = "No hay bodegas asociados por favor verifique";
            return;

        }

        try
        {
            foreach (GridViewRow registro in this.gvLista.Rows)
            {
                if (((TextBox)registro.FindControl("txtResultado")).Text.Length == 0)
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtResultado")).Text);
            }
        }
        catch (Exception ex)
        {
            foreach (GridViewRow registro in this.gvLista.Rows)
            {
                if (((TextBox)registro.FindControl("txtResultado")).Text.Length == 0)
                    ((TextBox)registro.FindControl("txtResultado")).Text = "0";
            }

            this.nilblMensaje.Text = "Solo numeros verifique";
            return;
        }

        //if (this.txtSellos.Text.Trim().Length == 0)
        //{
        //    this.nilblMensaje.Text = "Por favor registre los sellos del vehículo";
        //    return;
        //}

        foreach (GridViewRow registro in this.gvTanques.Rows)
        {
            if (((CheckBox)registro.FindControl("chkSeleccion")).Checked == true)
                tanques = true;
        }

        foreach (GridViewRow registro in this.gvLista.Rows)
        {
            if (((TextBox)registro.FindControl("txtResultado")).Text.Length == 0)
                resultados = false;
        }

        if (tanques == false)
        {
            this.nilblMensaje.Text = "Debe seleccionar al menos un tanque para el despacho";
            return;
        }
        else
        {
            if (resultados == false)
            {
                this.nilblMensaje.Text = "Debe digitar los análisis completos";
                return;
            }
            else
            {
                try
                {
                    using (TransactionScope ts = new TransactionScope())
                    {
                        foreach (GridViewRow registro in this.gvLista.Rows)
                        {
                            object[] objValores = new object[] {                           
                            registro.Cells[0].Text,
                            Convert.ToInt16(Session["empresa"]),
                            DateTime.Now,
                            this.hdfRemision.Value.ToString(),
                            this.txtTipoTransaccion.Text.Trim(),
                            this.Session["usuario"],
                            ((TextBox)registro.FindControl("txtResultado")).Text
                        };

                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "inserta", "ppa", objValores) == 1)
                            {
                                this.nilblMensaje.Text = "Error al insertar los análisis. Operación no realizada";
                                return;
                            }
                        }

                        foreach (DataListItem registro in this.dtSellos.Items)
                        {

                            object[] objValoresTanques = new object[]{
                                     Convert.ToInt16(Session["empresa"]),
                                    DateTime.Now,
                                    this.hdfRemision.Value.ToString(), 
                                    ((Label) registro.FindControl("lblSello")).Text.Trim() ,
                                    this.txtTipoTransaccion.Text.Trim(),
                                    this.Session["usuario"]
                                };

                            if (CentidadMetodos.EntidadInsertUpdateDelete("lregistrosellos", "inserta", "ppa", objValoresTanques) == 1)
                            {
                                this.nilblMensaje.Text = "Error al registrar los tanques de despacho. Operación no realizada";
                                return;
                            }
                        }

                        foreach (GridViewRow registro in this.gvTanques.Rows)
                        {
                            if (((CheckBox)registro.FindControl("chkSeleccion")).Checked == true)
                            {
                                object[] objValoresTanques = new object[]{
                                     Convert.ToInt16(Session["empresa"]),
                                    this.hdfRemision.Value.ToString(),
                                    100/gvTanques.Rows.Count,
                                    registro.Cells[0].Text,
                                    this.txtTipoTransaccion.Text.Trim()
                                };

                                if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisisTanque", "inserta", "ppa", objValoresTanques) == 1)
                                {
                                    this.nilblMensaje.Text = "Error al registrar los tanques de despacho. Operación no realizada";
                                    return;
                                }
                            }
                        }

                        switch (vehiculos.ActualizaEstadoBasculaRemision(this.txtTipoTransaccion.Text, this.hdfRemision.Value.ToString(), "AR", this.txtSellos.Text, Convert.ToInt16(Session["empresa"])))
                        {
                            case 0:
                                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                                this.gvLista.DataSource = null;
                                this.gvLista.DataBind();
                                this.gvTanques.DataSource = null;
                                this.gvTanques.DataBind();
                                ManejoExito("Análisis registrados satisfactoriamente");
                                ts.Complete();
                                break;
                            case 1:
                                this.nilblMensaje.Text = "Error al actualizar el estado del vehículo en báscula";
                                break;
                        }
                    }
                }
                catch (Exception ex)
                {
                    this.nilblMensaje.Text = "Error al insertar el registro. Correspondiente a: " + ex.Message;
                }
            }
        }
    }

    private void TanquesProducto()
    {
        try
        {
            this.gvTanques.DataSource = vehiculos.SeleccionaBodegaTipo(txtTipoTransaccion.Text, ddlProducto.SelectedValue.Trim(), Convert.ToInt16(Session["empresa"]));
            this.gvTanques.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los tanques asociados al producto. Correspondiente a: " + ex.Message);
        }
    }

    private void AnalisisProducto()
    {
        try
        {
            this.gvLista.DataSource = analisis.GetAnalisisProducto(ddlProducto.SelectedValue.Trim(), Convert.ToInt16(Session["empresa"]), ConfigurationManager.AppSettings["modulo"].ToString());
            this.gvLista.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los análisis asociados al producto. Correspondiente a: " + ex.Message);
        }
    }

    private void CargarDatosVehiculo()
    {
        try
        {
            object[] objDatos = vehiculos.GetVehiculosAnalisisRemision(Convert.ToString(this.ddlVehiculo.SelectedValue), Convert.ToInt16(Session["empresa"]));

            this.txtTipoTransaccion.Text = Convert.ToString(objDatos.GetValue(9));
            this.txtPesoTara.Text = Convert.ToString(objDatos.GetValue(1));
            this.txtCliente.Text = Convert.ToString(objDatos.GetValue(2));
            this.ddlProducto.SelectedValue = Convert.ToString(objDatos.GetValue(4));
            this.txtCantidadProgramada.Text = Convert.ToString(objDatos.GetValue(5));
            this.txtRemolque.Text = Convert.ToString(objDatos.GetValue(7));
            this.txtConductor.Text = Convert.ToString(objDatos.GetValue(8));
            this.lblRemision.Text = "Remisión Nro. " + Convert.ToString(objDatos.GetValue(0));
            this.hdfRemision.Value = Convert.ToString(objDatos.GetValue(0));
            this.hdfVehiculo.Value = Convert.ToString(objDatos.GetValue(6));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar datos vehículos. Correspondiente a: " + ex.Message);
        }
    }

    private void ManejoError(string error)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
        this.Session["sellos"] = null;
        this.Response.Redirect("~/Laboratorio/Error.aspx", false);
    }

    private void ManejoExito(string mensaje)
    {
        this.txtSellos.Text = "";
        nilblMensaje.ForeColor = Color.Green;
        CcontrolesUsuario.InhabilitarUsoControles(this.Page.Controls);
        nilbCancelar.Visible = false;
        nilbRegistrar0.Visible = false;
        nilblMensaje.Text = "";
        this.nilbNuevo.Visible = true;
        this.Session["sellos"] = null;
        dtSellos.DataSource = null;
        dtSellos.DataBind();
        dtSellos.Visible = false;
        this.nilblMensaje.Text = mensaje;
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlVehiculo.DataSource = vehiculos.GetVehiculosAnalisis(Convert.ToInt16(Session["empresa"]));
            this.ddlVehiculo.DataValueField = "numero";
            this.ddlVehiculo.DataTextField = "cadena";
            this.ddlVehiculo.DataBind();
            this.ddlVehiculo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar vehículos. Correspondiente a: " + ex.Message);
        }

        cargarproducto();
    }

    private void cargarproducto()
    {
        try
        {
            DataView productosProduccion = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            //productosProduccion.RowFilter = "tipo in('P','T')";
            this.ddlProducto.DataSource = productosProduccion;
            this.ddlProducto.DataValueField = "codigo";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar novedades. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Metodos

    #region Eventos

    protected void txtSellos_TextChanged(object sender, EventArgs e)
    {
        try
        {
            nilblMensaje.Text = "";
            bool validar = false;

            if (txtSellos.Text.Trim().Length == 0)
            {
                nilblMensaje.Text = "Ingrese un sello valido";
                txtSellos.Focus();
                txtSellos.Text = "";
                return;
            }

            foreach (DataListItem row in dtSellos.Items)
            {
                if (((Label)row.FindControl("lblSello")).Text.Trim() == txtSellos.Text.Trim())
                {
                    validar = true;
                    break;
                }
            }

            if (analisis.ValidaSellos(txtSellos.Text.Trim(), Convert.ToInt16(this.Session["empresa"])) == 1)
            {
                nilblMensaje.Text = "Sello ya ingresado en otro despacho por favor corrija";
                txtSellos.Focus();
                txtSellos.Text = "";
                return;
            }

            if (validar == true)
            {
                nilblMensaje.Text = "Sello ya ingresado por favor corrija";
                txtSellos.Focus();
                txtSellos.Text = "";
                return;
            }

            cargasello();


        }
        catch (Exception ex)
        {
            nilblMensaje.Text = "Error al cargar sellos debido a: " + ex.Message;
        }
    }

    private void cargasello()
    {
        if (this.Session["sellos"] == null)
        {
            ListaSellos = new List<SELLO>();
            SELLO a = new SELLO(txtSellos.Text.Replace(" ",""), false);
            ListaSellos.Add(a);
            this.Session["sellos"] = ListaSellos;
        }
        else
        {
            ListaSellos = (List<SELLO>)this.Session["sellos"];
            SELLO a = new SELLO(txtSellos.Text.Replace(" ", ""),false);
            ListaSellos.Add(a);
            this.Session["sellos"] = ListaSellos;
        }

        dtSellos.DataSource = ListaSellos;
        dtSellos.DataBind();

        this.txtSellos.Text = "";
        this.txtSellos.Focus();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                CargarCombos();
            }
        }
    }

    protected void ddlVehiculo_SelectedIndexChanged(object sender, EventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.InhabilitarUsoControles(this.Page.Controls);
        cargarproducto();
        CargarDatosVehiculo();
        AnalisisProducto();
        TanquesProducto();
        manejoSello();
        this.txtSellos.Enabled = true;
        this.ddlVehiculo.Enabled = false;
        nilbNuevo.Visible = false;
        this.txtSellos.Focus();
        dtSellos.DataSource = null;
        dtSellos.DataBind();
    }


    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CargarCombos();
        this.nilblMensaje.Text = "";
        this.lblVehiculo.Visible = true;
        this.ddlVehiculo.Visible = true;
        this.ddlVehiculo.Enabled = true;
        this.ddlVehiculo.Focus();
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvTanques.DataSource = null;
        this.gvTanques.DataBind();
        nilbCancelar.Visible = true;
        nilbNuevo.Visible = false;
        this.Session["sellos"] = null;
        dtSellos.DataSource = null;
        dtSellos.DataBind();
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvTanques.DataSource = null;
        this.gvTanques.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblMensaje.Text = "";
        nilbCancelar.Visible = false;
        nilbRegistrar0.Visible = false;
        this.Session["sellos"] = null;
        dtSellos.DataSource = null;
        dtSellos.DataBind();
    }

    protected void imgAgregarSello_Click(object sender, ImageClickEventArgs e)
    {

    }

    protected void gvSellos_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void txtSellos_TextChanged(object sender, ImageClickEventArgs e)
    {
        nilblMensaje.Text = "";
        bool validar = false;

        if (txtSellos.Text.Trim().Length == 0)
        {
            nilblMensaje.Text = "Ingrese un sello valido";
            txtSellos.Focus();
            txtSellos.Text = "";
            return;
        }

        foreach (DataListItem row in dtSellos.Items)
        {
            if (((Label)row.FindControl("lblSello")).Text.Trim() == txtSellos.Text.Trim())
            {
                validar = true;
                break;
            }
        }

        if (validar == true)
        {
            nilblMensaje.Text = "Sello ya ingresado por favor corrija";
            txtSellos.Focus();
            txtSellos.Text = "";
            return;
        }


        cargasello();
    }

    protected void dtSellos_ItemCommand(object source, DataListCommandEventArgs e)
    {
        try
        {
            ListaSellos = new List<SELLO>();
            ListaSellos = (List<SELLO>)this.Session["sellos"];
            ListaSellos.RemoveAt(e.Item.ItemIndex);
            dtSellos.DataSource = ListaSellos;
            dtSellos.DataBind();
            txtSellos.Focus();
        }
        catch (Exception ex)
        {

        }

    }


    #endregion Eventos







}