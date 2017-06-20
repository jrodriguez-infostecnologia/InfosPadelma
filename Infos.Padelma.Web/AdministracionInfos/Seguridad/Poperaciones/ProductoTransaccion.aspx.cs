using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Poperaciones_ProductoTransaccion : System.Web.UI.Page
{

    #region Instancias

    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Ctransacciones transacciones = new Ctransacciones();
    CtiposTransaccion tipoTransaccion = new CtiposTransaccion();
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



    private void GetEntidad()
    {
        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                                     nombrePaginaActual(), "C", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }
            string[] campos = { "tipo", "descripcion", "producto", "nombreProducto", "remision", "comercializadora" };
            this.gvLista.DataSource = tipoTransaccion.BuscarEntidadTransaccionProducto(
                Convert.ToString(nitxtBusqueda.Text), Convert.ToInt16(Session["empresa"])).ToTable(true, campos);

            this.gvLista.DataBind();

            this.nilblInformacion.Visible = true;
            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
                        this.Session["usuario"].ToString(), "C",
                      ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
                        this.gvLista.Rows.Count.ToString() + " Registros encontrados", ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar la tabla correspondiente a: " + ex.Message, "C");
        }
    }

    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er", error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;
        this.ddlTipoTransaccion.Enabled = true;
        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
        GetEntidad();
    }

    private void CargarCombos()
    {

        try
        {
            this.ddlTipoTransaccion.DataSource = transacciones.GetTipoTransaccionModulo(Convert.ToInt16(this.Session["empresa"]));
            this.ddlTipoTransaccion.DataValueField = "codigo";
            this.ddlTipoTransaccion.DataTextField = "descripcion";
            this.ddlTipoTransaccion.DataBind();
            this.ddlTipoTransaccion.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView productosProduccion = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iItems", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            productosProduccion.RowFilter = "tipo in('P','T','CP') and empresa = " + Session["empresa"].ToString();
            this.ddlProducto.DataSource = productosProduccion;
            this.ddlProducto.DataValueField = "codigo";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar novedades. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlRemision.DataSource = transacciones.GetTipoTransaccionModulo(Convert.ToInt16(this.Session["empresa"]));
            this.ddlRemision.DataValueField = "codigo";
            this.ddlRemision.DataTextField = "descripcion";
            this.ddlRemision.DataBind();
            this.ddlRemision.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar remisiones. Correspondiente a: " + ex.Message, "C");
        }

    }


    private void Guardar()
    {
        string operacion = "inserta";
        string remision = null;

        try
        {
            if (ddlRemision.SelectedValue.Length == 0)
                remision = null;
            else
                remision = ddlRemision.SelectedValue;


            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            object[] objValoresConcepto = new object[]{
                                                        Convert.ToInt16(Session["empresa"]),
                                                        ddlProducto.SelectedValue ,
                                                        Convert.ToString(ddlTipoTransaccion.SelectedValue)};

            switch (CentidadMetodos.EntidadInsertUpdateDelete("gTipoTransaccionProducto", operacion, "ppa", objValoresConcepto))
            {
                case 0:
                    ManejoExito("Asignación registrada correctamente", "I");
                    break;
                case 1:
                    this.nilblInformacion.Text = "Error al insertar el registro. operación no realizada";
                    break;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
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
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
             ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
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
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.nilblMensaje.Text = "";
        this.ddlTipoTransaccion.Focus();
        this.nilblInformacion.Text = "";
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.nilblMensaje.Text = "";
        this.ddlTipoTransaccion.Enabled = true;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlTipoTransaccion.SelectedValue.Length == 0 || ddlProducto.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }
        Guardar();
    }




    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.ddlTipoTransaccion.Enabled = false;
        this.ddlProducto.Enabled = false;
        this.ddlTipoTransaccion.Focus();

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                this.ddlTipoTransaccion.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text.Trim();
            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                this.ddlProducto.Text = this.gvLista.SelectedRow.Cells[4].Text.Trim();
            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                this.ddlRemision.Text = this.gvLista.SelectedRow.Cells[6].Text.Trim();

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[7].Controls)
            {
                if (objControl is CheckBox)
                    this.chkRemisionComercializadora.Checked = ((CheckBox)objControl).Checked;
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";

        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }


            object[] objValores = new object[] { 
                Convert.ToInt16(Session["empresa"]),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[4].Text), 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text)
                                
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete("gTipoTransaccionProducto", operacion, "ppa", objValores) == 0)
                ManejoExito("Registro eliminado satisfactoriamente", "E");
            else
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");


        }
        catch (Exception ex)
        {
            if (ex.HResult.ToString() == "-2146233087")
            {
                ManejoError("El código ('" + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)) +
                "' - ' " + Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[3].Text)) + "') tiene una asociación, no es posible eliminar el registro.", "E");
            }
            else
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }





    #endregion Eventos


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);

        this.nilbNuevo.Visible = true;
        this.nilblMensaje.Text = "";
        GetEntidad();
    }

    protected void gvAsignacion_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        CargarCombos();
        gvLista.DataBind();
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
}
