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
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    CtransaccionNovedad transaccionNovedad = new CtransaccionNovedad();
    Cperiodos periodo = new Cperiodos();
    string numerotransaccion = "";
    Ctransacciones transacciones = new Ctransacciones();
    CcambiarSueldo liquidacion = new CcambiarSueldo();
    Cgeneral general = new Cgeneral();
    Cfuncionarios funcionario = new Cfuncionarios();

    #endregion Instancias

    #region 

    private void Preliquidar()
    {
        try
        {
            switch (liquidacion.CambiarSueldoTercero(Convert.ToInt16(Session["empresa"]), ddlccosto.SelectedValue.Trim(), ddlEmpleado.SelectedValue.Trim(), Convert.ToInt32(ddlOpcionLiquidacion.SelectedValue), Convert.ToInt16(ddlTipo.SelectedValue), Convert.ToDecimal(txvProcentaje.Text), Convert.ToDecimal(txvValor.Text), Convert.ToDecimal(txvSueldoAnterior.Text), Convert.ToDecimal(txvSueldoNuevo.Text)))
            {
                case 0:
                    nilblInformacion.Text = "Datos Guardados satisfactoriamente";
                    break;
                case 1:
                    nilblInformacion.Text = "Error al guardar los datos";
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar empleados. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void CargarEmpleados()
    {
        try
        {
            DataView dvTerceroCCosto = funcionario.RetornaFuncionarioCcosto(ddlccosto.SelectedValue.ToString(), Convert.ToInt16(Session["empresa"]));
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

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Nomina/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

    }
    private void CargarCombos()
    {

       
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
                    CcontrolesUsuario.HabilitarControles(this.Page.Controls);
                    CcontrolesUsuario.LimpiarControles(Page.Controls);
                    CargarCombos();
                    this.Session["editar"] = null;
                    this.nilblInformacion.Text = "";
                    manejoOpcionLiquidacion();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }


    #endregion Eventos

    #region MetodosFuncionario




    #endregion MetodosFuncionario

    #region EventosFuncionario

    private void cargarCentroCosto(bool auxiliar)
    {
        try
        {

            this.ddlccosto.DataSource = general.CentroCosto(auxiliar, Convert.ToInt16(Session["empresa"]));
            this.ddlccosto.DataValueField = "codigo";
            this.ddlccosto.DataTextField = "descripcion";
            this.ddlccosto.DataBind();
            this.ddlccosto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los centros de costo. Correspondiente a: " + ex.Message, "C");
        }
    }
  
   

    protected void ddlOpcionLiquidacion_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoOpcionLiquidacion();
    }

    private void manejoOpcionLiquidacion()
    {
        switch (Convert.ToInt16(ddlOpcionLiquidacion.SelectedValue))
        {
            case 1:
                lblCcosto.Visible = false;
                lblEmpleado.Visible = false;
                ddlccosto.Visible = false;
                ddlEmpleado.Visible = false;
                break;

            case 2:
                cargarCentroCosto(true);
                lblCcosto.Text = "Centro costo";
                ddlccosto.Visible = true;
                ddlccosto.Enabled = true;
                ddlEmpleado.Visible = false;
                lblCcosto.Visible = true;
                lblEmpleado.Visible = false;
                ddlccosto.SelectedValue = "";
                break;
            case 3:
                cargarCentroCosto(true);
                lblCcosto.Text = "Centro costo";
                ddlccosto.Visible = true;
                ddlEmpleado.Visible = true;
                ddlccosto.SelectedValue = "";
                ddlEmpleado.SelectedValue = "";
                ddlccosto.Enabled = true;
                ddlEmpleado.Enabled = true;
                lblCcosto.Visible = true;
                lblEmpleado.Visible = true;
                break;
            case 4:
                cargarCentroCosto(false);
                lblCcosto.Text = "Mayor centro costo";
                ddlccosto.Visible = true;
                ddlEmpleado.Visible = false;
                ddlccosto.SelectedValue = "";
                ddlEmpleado.SelectedValue = "";
                ddlccosto.Enabled = true;
                ddlEmpleado.Enabled = false;
                lblCcosto.Visible = true;
                lblEmpleado.Visible = false;
                break;

        }

        lblPorcentaje.Visible = false;
        txvProcentaje.Visible = false;
        txvValor.Visible = false;
        txvSueldoAnterior.Visible = false;
        txvSueldoNuevo.Visible = false;
        lblValor.Visible = false;
        lblSueldoAnterior.Visible = false;
        lblSueldoNuevo.Visible = false;
    }

    protected void ddlccosto_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Convert.ToInt16(ddlOpcionLiquidacion.SelectedValue.Trim()) == 3)
            CargarEmpleados();
        else
        {
            ddlEmpleado.DataSource = null;
            ddlEmpleado.DataBind();
            ddlEmpleado.Visible = false;
        }
    }

    protected void lbPreLiquidar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (ddlccosto.SelectedValue.Trim().Length == 0 & ddlccosto.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costo para seguir";
                ddlccosto.Focus();
                return;
            }


            if (ddlEmpleado.SelectedValue.Trim().Length == 0 & ddlEmpleado.Visible == true)
            {
                nilblInformacion.Text = "Debe seleccionar un de centro de costp para seguir";
                ddlEmpleado.Focus();
                return;
            }

            Preliquidar();
        }
        catch (Exception ex)
        {
            ManejoError("Error al liquidar el documento debido a :" + ex.Message, "I");
        }
    }

    #endregion EventosFuncionario


    protected void ddlTipo_SelectedIndexChanged(object sender, EventArgs e)
    {
        switch (Convert.ToInt16(ddlTipo.SelectedValue))
        {
            case 1:
                lblPorcentaje.Visible = false;
                txvProcentaje.Visible = false;
                txvValor.Visible = true;
                txvSueldoAnterior.Visible = false;
                txvSueldoNuevo.Visible = false;
                lblValor.Visible = true;
                lblSueldoAnterior.Visible = false;
                lblSueldoNuevo.Visible = false;
                break;
            case 2:
                lblPorcentaje.Visible = true;
                txvProcentaje.Visible = true;
                txvValor.Visible = false;
                txvSueldoAnterior.Visible = false;
                txvSueldoNuevo.Visible = false;
                lblValor.Visible = false;
                lblSueldoAnterior.Visible = false;
                lblSueldoNuevo.Visible = false;
                break;
            case 3:
                lblPorcentaje.Visible = false;
                txvProcentaje.Visible = false;
                txvValor.Visible = false;
                txvSueldoAnterior.Visible = true;
                txvSueldoNuevo.Visible = true;
                lblValor.Visible = false;
                lblSueldoAnterior.Visible = true;
                lblSueldoNuevo.Visible = true;
                break;
        }

    }
}
