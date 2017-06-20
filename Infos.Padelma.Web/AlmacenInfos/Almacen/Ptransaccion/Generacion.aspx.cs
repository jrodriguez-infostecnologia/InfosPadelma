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

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    Ctransaccion transacciones = new Ctransaccion();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Cusuario usuario = new Cusuario();

    #endregion Instancias

    #region Metodos

    public void CargarSalidas()
    {
        try
        {

            this.gvLista.DataSource = transacciones.SalidasAC(this.ddlProveedor.SelectedValue,
                                                                this.ddlPeriodo.SelectedValue);
            this.gvLista.DataBind();
            this.nilblresultado.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
            this.nilbRegistrar.Visible = true;
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar líneas. Correspondiente a: " + ex.Message, "C");
        }
    
    }

    public void CargaCombo()
    {

        try
        {
            this.ddlProveedor.DataSource = transacciones.GetProveedorAC();
            this.ddlProveedor.DataValueField = "codigo";
            this.ddlProveedor.DataTextField = "descripcion";
            this.ddlProveedor.DataBind();
            this.ddlProveedor.Items.Insert(0, new ListItem("Seleccione una opción", ""));
            
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar líneas. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPeriodo.DataSource = transacciones.GetPeriodosAbiertos();
            this.ddlPeriodo.DataValueField = "periodo";
            this.ddlPeriodo.DataTextField = "periodo";
            this.ddlPeriodo.DataBind();
            this.ddlPeriodo.Items.Insert(0, new ListItem("Seleccione una opción", ""));


        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar líneas. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string requisicion= tipoTransaccion.RetornaConsecutivo("REQUI");
        string Cotizacion = tipoTransaccion.RetornaConsecutivo("COT");
        try
        {

            switch (transacciones.EjecutaRequisicion(
                    this.ddlPeriodo.SelectedValue,
                    this.ddlProveedor.SelectedValue,
                    this.txtObservaciones.Text))
                {
                    case 0:

                        ManejoExito("Requisición generada satisfactoriamente No. " + 
                            requisicion + " y Cotización No. " + Cotizacion, "I");
                        break;

                    case 1:

                        ManejoError("Error al ejecutar las salidas", "I");
                        break;

                    case 2:

                        ManejoError("No existen salidas de almacen en consignación", "I");
                        break;

                                 
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, "I");
        }
    }

    private void GetEntidad()
    {
        try
        {
            //((DataList)this.gvRequisicion.HeaderRow.FindControl("dlLista")).DataSource = transacciones.GetEstudioCompras(
            //        Convert.ToString(this.ddlProveedor.SelectedValue));
            //((DataList)this.gvRequisicion.HeaderRow.FindControl("dlLista")).DataBind();

            //foreach (GridViewRow registro in this.gvRequisicion.Rows)
            //{
            //    DataList dlProductoTercero = ((DataList)registro.FindControl("dlListaTerceroProducto"));

            //    dlProductoTercero.DataSource = transacciones.GetEstudioCompras(
            //            Convert.ToString(this.ddlProveedor.SelectedValue));
            //    dlProductoTercero.DataBind();

            //    foreach (DataListItem item in dlProductoTercero.Items)
            //    {
            //        ((GridView)item.FindControl("gvProducto")).DataSource = transacciones.GetCotizacionProveedorProducto(
            //            this.ddlProveedor.SelectedValue,
            //            ((Label)item.FindControl("lblProveedor")).Text.Trim(),
            //            registro.Cells[0].Text.Trim(),
            //            ((Label)item.FindControl("lblCotizacion")).Text.Trim());
            //        ((GridView)item.FindControl("gvProducto")).DataBind();
            //    }
            //}
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cotizaciones. Correspondiente a: " + ex.Message, "C");
        }
    }

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
        this.nilblresultado.Text = "";

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        Cseguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje);

        this.nilbNuevo.Visible = true;
        this.nilbRegistrar.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

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
                "Generacion.aspx") != 0)
            {
                
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

    protected void nilbNuevo_Click(object sender, EventArgs e)
    {
        CargaCombo();

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilblMensaje.Text = "";
        this.nilblresultado.Text = "";
        this.nilbNuevo.Visible = false;
        this.lbCancelar.Visible = true;
        this.btnVer.Visible = true;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbRegistrar.Visible = false;
    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilblMensaje.Text = "";
        this.nilblresultado.Text = "";
        this.nilbNuevo.Visible = true;
        this.nilbRegistrar.Visible = false;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
       
    }

   

    protected void lbRegistrar_Click(object sender, EventArgs e)
    {
        Guardar();
    }
         
      #endregion Eventos
    protected void Button1_Click(object sender, EventArgs e)
    {
        CargarSalidas();
        
    }
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblMensaje.Text = "";
        this.nilblresultado.Text = "";

        string script = "<script language='javascript'>" +
                    "VerMovimiento('" +
                    this.gvLista.SelectedRow.Cells[3].Text +  "');" +
                    "</script>";
        Page.RegisterStartupScript("VerMovimiento", script);           
    }
}
