using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_TipoNovedad : System.Web.UI.Page
{

    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Ctransacciones transacciones = new Ctransacciones();
    CIP ip = new CIP();
    Cnovedad novedades = new Cnovedad();


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
            selNovedades.Visible = false;
            this.gvLista.DataSource = novedades.BuscarEntidadTipo(
                Convert.ToString(nitxtBusqueda.Text), Convert.ToInt16(Session["empresa"]));

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

        seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              operacion,
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "er",
              error, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Agronomico/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;
        this.ddlTipoTransaccion.Enabled = true;
        this.selNovedades.Visible = false;

        seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              operacion,
              ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex",
              mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

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
            this.selNovedades.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("aNovedad", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.selNovedades.DataValueField = "codigo";
            this.selNovedades.DataTextField = "descripcion";
            this.selNovedades.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar novedades. Correspondiente a: " + ex.Message, "C");
        }

    }


    private void Guardar()
    {
        string operacion = "inserta";
        bool verificacion = false;
        try
        {

            using (TransactionScope ts = new TransactionScope())
            {
                for (int x = 0; x < this.selNovedades.Items.Count; x++)
                {
                    if (this.selNovedades.Items[x].Selected)
                    {
                        verificacion = true;
                    }
                }

                if (verificacion == false)
                {
                    this.nilblInformacion.Text = "Debe seleccionar al menos una novedad para realizar la registro";
                    return;
                }

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                }

                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    for (int x = 0; x < this.selNovedades.Items.Count; x++)
                    {
                        if (novedades.VerificaNovedadTipo(ddlTipoTransaccion.SelectedValue, Convert.ToInt32(this.selNovedades.Items[x].Value), Convert.ToInt16(Session["empresa"])) == 0)
                        {
                            if (this.selNovedades.Items[x].Selected == false)
                            {

                                object[] objValoresConcepto = new object[]{
                                                        Convert.ToInt16(Session["empresa"]),
                                                        Convert.ToInt16(this.selNovedades.Items[x].Value),
                                Convert.ToString(ddlTipoTransaccion.SelectedValue)};

                                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                "aTipoNovedad",
                                "elimina",
                                "ppa",
                                objValoresConcepto))
                                {
                                    case 1:
                                        verificacion = true;
                                        break;
                                }

                            }

                        }
                        else
                        {
                            if (this.selNovedades.Items[x].Selected == true)
                            {

                                object[] objValoresConcepto = new object[]{
                                                       
                                                        Convert.ToInt16(Session["empresa"]),
                                                        Convert.ToInt16(this.selNovedades.Items[x].Value),
                                 Convert.ToString(ddlTipoTransaccion.SelectedValue)};

                                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                "aTipoNovedad",
                                "inserta",
                                "ppa",
                                objValoresConcepto))
                                {
                                    case 1:
                                        verificacion = true;
                                        break;
                                }

                            }
                        }
                    }
                }
                else
                {
                    for (int x = 0; x < this.selNovedades.Items.Count; x++)
                    {
                        if (this.selNovedades.Items[x].Selected == true)
                        {

                            object[] objValoresConcepto = new object[]{
                                                       
                                                        Convert.ToInt16(Session["empresa"]),
                                                        Convert.ToInt16(this.selNovedades.Items[x].Value) ,
                            Convert.ToString(ddlTipoTransaccion.SelectedValue)};

                            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                            "aTipoNovedad",
                            operacion,
                            "ppa",
                            objValoresConcepto))
                            {
                                case 1:
                                    verificacion = true;
                                    break;
                            }
                        }
                    }
                }

                if (verificacion == false)
                {
                    this.nilblInformacion.Text = "Error al insertar el registro. operación no realizada";
                }
                else
                {
                    ManejoExito("Asignación registrada correctamente", "I");
                    ts.Complete();
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }
    }

    private void ValidaRegistro()
    {
        for (int x = 0; x < this.selNovedades.Items.Count; x++)
        {
            if (novedades.VerificaNovedadTipo(ddlTipoTransaccion.SelectedValue, Convert.ToInt32(selNovedades.Items[x].Value), Convert.ToInt16(Session["empresa"])) == 0)
                selNovedades.Items[x].Selected = true;
            else
                selNovedades.Items[x].Selected = false;
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

        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                          ConfigurationManager.AppSettings["Modulo"].ToString(),
                           nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        CargarCombos();

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        this.ddlTipoTransaccion.Focus();
        this.nilblInformacion.Text = "";
        this.selNovedades.Visible = true;


    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.ddlTipoTransaccion.Enabled = true;
        this.selNovedades.Visible = false;
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (ddlTipoTransaccion.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        Guardar();
    }




    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(), ConfigurationManager.AppSettings["Modulo"].ToString(),
        nombrePaginaActual(), "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.selNovedades.Visible = true;
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.ddlTipoTransaccion.Enabled = false;
        this.ddlTipoTransaccion.Focus();

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.ddlTipoTransaccion.Text = this.gvLista.SelectedRow.Cells[2].Text.Trim();
                ValidaRegistro();

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
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                      ConfigurationManager.AppSettings["Modulo"].ToString(),
                                       nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }


            object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), 
                Convert.ToInt16(Session["empresa"])
            };

            if (novedades.EliminaNovedades(Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(Session["empresa"])) == 0)
            {
                if (CentidadMetodos.EntidadInsertUpdateDelete("aTipoNovedad", operacion, "ppa", objValores) == 0)
                {
                    ManejoExito("Registro eliminado satisfactoriamente", "E");
                }
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");

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
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }



    protected void nilblListado_Click(object sender, EventArgs e)
    {
        Response.Redirect("ListadoDestinos.aspx");
    }

    protected void nilbRegresar_Click(object sender, EventArgs e)
    {
        this.Response.Redirect("Programacion.aspx");
    }

    #endregion Eventos

    #region MetodosFuncionario




    #endregion MetodosFuncionario

    #region EventosFuncionario


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
           this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    #endregion EventosFuncionario

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
