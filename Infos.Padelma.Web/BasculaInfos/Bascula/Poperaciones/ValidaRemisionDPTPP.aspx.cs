using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bascula_Poperaciones_ValidaRemisionDPTPP : System.Web.UI.Page
{
    #region Instancias
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    Cvehiculos vehiculos = new Cvehiculos();

    #endregion Instancias

    #region Metodos

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

        this.Response.Redirect("~/Bascula/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.ForeColor = System.Drawing.Color.Green;
        this.nilblInformacion.Text = mensaje;

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

    #endregion Metodos

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
                this.txtRemision.Focus();
            }
        }
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (this.txtRemision.Text.Trim().Length == 0)
        {
            this.nilblInformacion.Text = "Debe seleccionar una remisión para continuar";
        }
        else
        {
            if (vehiculos.VerificaCarnet(this.txtRemision.Text, Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.nilblInformacion.Text = "El carnet ingresado no es válido. Por favor corrija";
                this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                this.txtRemision.Text = "";
            }
            else
            {
                this.Session["entrada"] = "ValidaRemisionDPTPP.aspx";

                this.Session["pagina"] = "RegistraDatosDPTPP.aspx";

                Response.Redirect("CapturaPesoDPT.aspx", false);
            }
        }
    }
    protected void txtRemision_TextChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        string numero = "";

        try
        {
            if (vehiculos.VerificaCarnet(this.txtRemision.Text, Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.nilblInformacion.Text = "El carnet ingresado no es válido. Por favor corrija";
                this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                this.txtRemision.Text = "";
            }
            else
            {
                numero = vehiculos.RetornaNumeroDespachoCarnet(this.txtRemision.Text, Convert.ToInt16(Session["empresa"]));

                foreach (DataRowView registro in vehiculos.RetornaDatosVehiculoRemision(numero, Convert.ToInt16(Session["empresa"])))
                {
                    this.lblVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
                    this.lblConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(0));
                    this.lblNombre.Text = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                    this.lblFechaHora.Text = Convert.ToString(registro.Row.ItemArray.GetValue(4));
                    this.lblRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(3));
                    this.lblOperacion.Text = Convert.ToString(registro.Row.ItemArray.GetValue(5));
                }
                lbRegistrar.Visible = true;

                this.Session["placa"] = numero;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al verificar la remisión seleccionada. Correspondiente a: " + ex.Message, "C");
        }
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("Despachos.aspx");
    }
}