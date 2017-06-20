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

    Crequisicion requisicion = new Crequisicion();
    Ctransaccion transaccion = new Ctransaccion();

    #endregion Instancias

    #region Metodos

    private void GetEntidad()
    {
        try
        {
            this.gvLista.DataSource = requisicion.GetPorAprobar(
                Convert.ToString(this.Session["usuario"]));
            this.gvLista.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar requisiciones. Correspondiente a: " + ex.Message, "C");
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
                "AprobarRequisiciones.aspx") != 0)
            {
                if (!IsPostBack)
                {
                    GetEntidad();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }

    protected void imbActualizar_Click(object sender, ImageClickEventArgs e)
    {
        GetEntidad();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.nilblMensaje.Text = "";

        try
        {            
            if (((GridView)this.gvLista.SelectedRow.FindControl("gvDetalle")).Visible == false)
            {
                ((ImageButton)this.gvLista.SelectedRow.FindControl("imbGuardar")).Visible = true;
                ((LinkButton)this.gvLista.SelectedRow.FindControl("lbVerUltimas")).Visible = true;
                ((ImageButton)this.gvLista.SelectedRow.FindControl("imbAprobar")).ImageUrl = "~/Imagenes/botones/Atras.png";
                ((ImageButton)this.gvLista.SelectedRow.FindControl("imbAprobar")).ToolTip = "Clic aquí para regresar";
                ((GridView)this.gvLista.SelectedRow.FindControl("gvDetalle")).Visible = true;
                ((GridView)this.gvLista.SelectedRow.FindControl("gvDetalle")).DataSource = requisicion.GetPorAprobarDetalle(
                    this.gvLista.SelectedRow.Cells[1].Text);
                ((GridView)this.gvLista.SelectedRow.FindControl("gvDetalle")).DataBind();

                foreach (GridViewRow registro in this.gvLista.Rows)
                {
                    if (registro.RowIndex != this.gvLista.SelectedRow.RowIndex)
                    {
                        registro.Visible = false;
                    }
                }
            }
            else
            {
                ((ImageButton)this.gvLista.SelectedRow.FindControl("imbGuardar")).Visible = false;
                ((LinkButton)this.gvLista.SelectedRow.FindControl("lbVerUltimas")).Visible = false;
                ((ImageButton)this.gvLista.SelectedRow.FindControl("imbAprobar")).ImageUrl = "~/Imagenes/botones/Asignar1.png";
                ((ImageButton)this.gvLista.SelectedRow.FindControl("imbAprobar")).ToolTip = "Clic aquí para aprobar la requisición";
                ((GridView)this.gvLista.SelectedRow.FindControl("gvDetalle")).Visible = false;
                ((GridView)this.gvLista.SelectedRow.FindControl("gvDetalle")).DataSource = null;
                ((GridView)this.gvLista.SelectedRow.FindControl("gvDetalle")).DataBind();

                foreach (GridViewRow registro in this.gvLista.Rows)
                {
                    registro.Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar detalle de requisición. Correspondiente a: " + ex.Message, "C");
        }
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

    protected void gvLista_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        this.nilblMensaje.Text = "";

        bool verificacion = false;

        try
        {
            foreach (GridViewRow registro in ((GridView)this.gvLista.Rows[e.RowIndex].FindControl("gvDetalle")).Rows)
            {
                if (((TextBox)registro.Cells[0].FindControl("txtCantidad")).Text.Trim().Length != 0 &&
                    Convert.ToDecimal(((TextBox)registro.Cells[0].FindControl("txtCantidad")).Text.Trim()) != 0)
                {
                    verificacion = true;
                }
            }

            if (verificacion == false)
            {
                this.nilblMensaje.Text = "No ha seleccionado ninguna cantidad para aprobar. Por favor corrija";
                return;
            }

            using (TransactionScope ts = new TransactionScope())
            {
                foreach (GridViewRow registro in ((GridView)this.gvLista.Rows[e.RowIndex].FindControl("gvDetalle")).Rows)
                {
                    if (((TextBox)registro.Cells[0].FindControl("txtCantidad")).Text.Trim().Length != 0 &&
                        Convert.ToDecimal(((TextBox)registro.Cells[0].FindControl("txtCantidad")).Text.Trim()) != 0)
                    {
                        switch (requisicion.Aprueba(
                            this.gvLista.Rows[e.RowIndex].Cells[1].Text.Trim(),
                            registro.Cells[1].Text,
                            Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text),
                            this.Session["usuario"].ToString(),
                            Convert.ToInt16(registro.Cells[7].Text)))
                        {
                            case 1:

                                verificacion = false;
                                break;
                        }
                    }
                }

                if (verificacion == false)
                {
                    ManejoError("Error al actualizar el registro. Operación no realizada", "A");
                    return;
                }
                transaccion.EnviaCorreo(gvLista.Rows[e.RowIndex].Cells[1].Text.ToString().Trim());
                ManejoExito("Requisición aprobada satisfactoriamente", "A");
                GetEntidad();            
                ts.Complete();
              
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al aprobar la requisición. Correspondiente a: " + ex.Message, "A");
        }
    }

    #endregion Eventos


    protected void lbVerUltimas_Click(object sender, EventArgs e)
    {
        this.nilblMensaje.Text = "";
        
        string script = "<script language='javascript'>" +
                    "VerMovimiento('" +
                    this.gvLista.SelectedRow.Cells[1].Text + "');" +
                    "</script>";
        Page.RegisterStartupScript("VerUltimasCompras", script); 
    }
}
