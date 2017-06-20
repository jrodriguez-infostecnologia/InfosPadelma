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

    CordenCompra ordenCompra = new CordenCompra();
    Ctransaccion transacciones = new Ctransaccion();

    #endregion Instancias

    #region Metodos

    private void CalculaValores()
    {
        decimal valorTotal = 0;
        decimal valorIva = 0;

        try
        {
            foreach (GridViewRow registro in this.gvDetalle.Rows)
            {
                registro.Cells[7].Text = CcontrolesUsuario.FormatoCifras(
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text) * Convert.ToDecimal(registro.Cells[6].Text));

                valorTotal = valorTotal + Convert.ToDecimal(registro.Cells[7].Text);
                valorIva = valorIva + Convert.ToDecimal(registro.Cells[7].Text) * (Convert.ToDecimal(registro.Cells[9].Text) / 100);
            }

            foreach (DataListItem item in this.dlTotal.Items)
            {
                ((Label)item.FindControl("lblTotal")).Text = CcontrolesUsuario.FormatoCifras(valorTotal);
                ((Label)item.FindControl("lblIva")).Text = CcontrolesUsuario.FormatoCifras(valorIva);
                ((Label)item.FindControl("lblNeto")).Text = CcontrolesUsuario.FormatoCifras(
                    valorTotal + Convert.ToDecimal(((Label)item.FindControl("lblIva")).Text));
            }
        }
        catch (Exception ex)
        {
            this.nilblMensaje.Text = "Error al recalcular valores. Correspondiente a: " + ex.Message;
        }
    }

    private void GetTransaccion(string transaccion)
    {
        try
        {
            this.lblTransaccion.Text = transaccion;
            
            foreach (DataRowView registro in transacciones.GetDetalleSalida(
                transaccion))
            {
                
                this.lblFechaSal.Text = registro.Row.ItemArray.GetValue(14).ToString().Substring(0, 10);
                this.lblTercero.Text = registro.Row.ItemArray.GetValue(11).ToString();
                this.lblFecha.Text = registro.Row.ItemArray.GetValue(15).ToString();
                this.lblObservaciones.Text = registro.Row.ItemArray.GetValue(16).ToString();
                this.lblrealizado.Text = registro.Row.ItemArray.GetValue(17).ToString();

                //if (!this.lblRequisicion.Text.Contains(registro.Row.ItemArray.GetValue(12).ToString()))
                //{
                //    this.lblRequisicion.Text = this.lblRequisicion.Text + " " + registro.Row.ItemArray.GetValue(12).ToString();
                //}
            }

            this.gvDetalle.DataSource = transacciones.GetDetalleSalida(
                transaccion);
            this.gvDetalle.DataBind();

            this.dlTotal.DataSource = transacciones.GetTotalTransaccion(
                "SAC",
                transaccion);
            this.dlTotal.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar datos de la transacción seleccionada. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void GetEntidad()
    {
        try
        {
            this.nilblMensaje.Text = "";
            this.UpdatePanelTransaccion.Visible = true;
            GetTransaccion(Convert.ToString(Request.QueryString["numero"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar ordenes de compra. Correspondiente a: " + ex.Message, "C");
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
                "AprobarOc.aspx") != 0)
            {
                if (!IsPostBack)
                {
                    GetEntidad();
                }

                CalculaValores();
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

  

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }

    protected void txtCantidad_DataBinding(object sender, EventArgs e)
    {
        ((TextBox)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((TextBox)sender).Text.Trim()));
    }

    protected void txtCantidad_TextChanged(object sender, EventArgs e)
    {
        ((TextBox)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((TextBox)sender).Text.Trim()));
        ((TextBox)sender).Focus();
    }

  
    protected void lblTotal_DataBinding(object sender, EventArgs e)
    {
        ((Label)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((Label)sender).Text));
    }

       #endregion Eventos
}
