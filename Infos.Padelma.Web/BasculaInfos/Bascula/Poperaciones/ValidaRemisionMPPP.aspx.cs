using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Bascula_Poperaciones_ValidaRemisionMPPP : System.Web.UI.Page
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

    }
    protected void txtRemision_TextChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";

        try
        {
            if (vehiculos.VerificaRemision(
                this.txtRemision.Text, Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.nilblInformacion.Text = "La remisión ingresada no es válida. Por favor corrija";
                this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                this.txtRemision.Text = "";
            }
            else
            {
                foreach (DataRowView registro in vehiculos.RetornaDatosVehiculoRemision(
                    this.txtRemision.Text, Convert.ToInt16(Session["empresa"])))
                {
                    this.lblVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
                    this.lblConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(0));
                    this.lblNombre.Text = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                    this.lblFechaHora.Text = Convert.ToString(registro.Row.ItemArray.GetValue(4));
                    this.lblRemolque.Text = Convert.ToString(registro.Row.ItemArray.GetValue(3));
                    this.lblOperacion.Text = Convert.ToString(registro.Row.ItemArray.GetValue(5));

                }
                lbRegistrar.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al verificar la remisión seleccionada. Correspondiente a: " + ex.Message,"I");
        }
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("MateriaPrima.aspx");
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (this.txtRemision.Text.Trim().Length == 0)
        {
            this.nilblInformacion.Text = "Debe seleccionar una remisión para continuar";
        }
        else
        {
            if (vehiculos.VerificaRemision(
                this.txtRemision.Text, Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.nilblInformacion.Text = "La remisión ingresada no es válida. Por favor corrija";
                this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
                this.txtRemision.Text = "";
            }
            else
            {
                this.Session["entradamp"] = "ValidaRemisionMPPP.aspx";
                this.Session["placamp"] = Convert.ToString(this.txtRemision.Text);
                this.Session["paginamp"] = "RegistraDatosMPPP.aspx";
                Response.Redirect("CapturaPesoMP.aspx", false);
            }
        }

    }
}