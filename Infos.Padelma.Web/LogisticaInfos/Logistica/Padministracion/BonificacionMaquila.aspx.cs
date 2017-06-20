using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistica_Padministracion_Mercado : System.Web.UI.Page
{

    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cbonificacion mercados = new Cbonificacion();
    CIP ip = new CIP();


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
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
    "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        this.Response.Redirect("~/Logistica/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }

    private void CargarCombos()
    {
    }

    private void Guardar()
    {
        string operacion = "inserta";
        try
        {
            if (txvDesde.Text.Trim().Length == 0 || txvHasta.Text.Trim().Length == 0 || txvBonifica.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Campos vacios por favor corrija";
                return;
            }

            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            object[] objValores = new object[]{
                    Convert.ToDecimal(txvBonifica.Text),
                    Convert.ToDecimal(txvDesde.Text),
                   Convert.ToInt16(Session["empresa"]),
                   Convert.ToDecimal(txvHasta.Text)
                    
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("logBonificaMaquila", operacion, "ppa", objValores))
            {
                case 0:
                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                    break;
                case 1:
                    ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                    break;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }

    }

    private void GetEntidad()
    {
        try
        {
           

            this.gvLista.DataSource = mercados.BuscarEntidad( Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, "C");
        }
    }
    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
                GetEntidad();
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

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.nilblInformacion.Text = "";
    }

    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }


    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            object[] objValores = new object[] {
                Convert.ToDecimal(this.gvLista.Rows[e.RowIndex].Cells[2].Text),
                Convert.ToInt16(Session["empresa"]),
                Convert.ToDecimal(this.gvLista.Rows[e.RowIndex].Cells[3].Text)
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("logBonificaMaquila", "elimina", "ppa", objValores))
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
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro.", "E");
            }
            else
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
        }
    }

      protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(          this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        CargarCombos();
        this.txvDesde.Enabled = false;
        this.txvHasta.Enabled = false;
        this.txvDesde.Focus();

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.txvDesde.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
            else
                this.txvDesde.Text = "0";

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
                this.txvHasta.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            else
                txvHasta.Text = "0";

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.txvBonifica.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            else
                this.txvBonifica.Text = "0";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

 
    #endregion Eventos


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(           this.Page.Controls);
        this.nilbNuevo.Visible = true;
        GetEntidad();
    }
}