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

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    Cperiodos periodos = new Cperiodos();

    #endregion Instancias

    #region Metodos

      private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        Cseguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "er",
            error);

        this.Response.Redirect("~/Almacen/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        Cseguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje);

       
    }

    private void CargarCombos()
    {
        try
        {
            this.ddlAno.DataSource = periodos.GetAnosPeriodos();
            this.ddlAno.DataValueField = "ano";
            this.ddlAno.DataTextField = "ano";
            this.ddlAno.DataBind();
            this.ddlAno.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar años. Correspondiente a: " + ex.Message, "C");
        }
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
            if (Cseguridad.VerificaAccesoPagina(
                this.Session["usuario"].ToString(),
                System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString(),
                "TrasladoSaldos.aspx") != 0)
            {
               
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

    protected void lbNuevo_Click(object sender, EventArgs e)
    {
        if (CvalidacionOperacion.VerificaOperacion(
            this.Session["usuario"].ToString(),
            "TrasladoSaldos.aspx",
            "I") == false)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "I");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();

        
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);
           

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }

    

    protected void lbRegistrar_Click(object sender, EventArgs e)
    {
        if (periodos.RetornaPeriodoCerrado(
           Convert.ToString(this.ddlAno.SelectedValue) +
           Convert.ToString(this.ddlMes.SelectedValue).PadLeft(2, '0')) == 1)
        {
            ManejoError("Periodo cerrado. No es posible trasladar los saldos", "I");
        }
        else
        {
            try
            {
                if (periodos.TrasladaSaldos(
               Convert.ToInt16(this.ddlAno.SelectedValue),
               Convert.ToInt16(this.ddlMes.SelectedValue)) == 1)
                {
                    ManejoError("Error al trasladar los saldos. No es posible trasladar los saldos", "I");
                }
                else
                {
                    ManejoExito("Saldos trasladados correctamente...", "I");
                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al trasladar saldos. Correspondiente a: " + ex.Message, "C");
            }
        
        }

    }


   
   

    #endregion Eventos
    protected void ddlAno_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
}
