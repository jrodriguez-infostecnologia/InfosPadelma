using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Laboratorio_Padministracion_AnalisisItems : System.Web.UI.Page
{

    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Canalisis analisis = new Canalisis();
    CIP ip = new CIP();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Cnivel nivel = new Cnivel();
    Cjerarquia jerarquia = new Cjerarquia();
    Cformulacion formulacion = new Cformulacion();



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
            selItems.Visible = false;
            this.gvLista.DataSource = formulacion.BuscarEntidad(
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

        this.Response.Redirect("~/Laboratorio/Error.aspx", false);
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
        this.selItems.Visible = false;
        this.txtCodigo.Enabled = true;

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
            this.ddlTipoTransaccion.DataSource = tipoTransaccion.GetTipoTransaccionModulo(Convert.ToInt16(Session["empresa"]));
            this.ddlTipoTransaccion.DataValueField = "codigo";
            this.ddlTipoTransaccion.DataTextField = "descripcion";
            this.ddlTipoTransaccion.DataBind();
            this.ddlTipoTransaccion.Items.Insert(0, new ListItem("", ""));
            this.ddlTipoTransaccion.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlNivel.DataSource = nivel.BuscarEntidad("", Convert.ToInt16(Session["empresa"]));
            this.ddlNivel.DataValueField = "codigo";
            this.ddlNivel.DataTextField = "descripcion";
            this.ddlNivel.DataBind();
            this.ddlNivel.Items.Insert(0, new ListItem("", ""));
            this.ddlNivel.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
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
                for (int x = 0; x < this.selItems.Items.Count; x++)
                {
                    if (this.selItems.Items[x].Selected)
                    {
                        verificacion = true;
                    }
                }

                if (verificacion == false)
                {
                    this.nilblInformacion.Text = "Debe seleccionar al menos una novedad para realizar la registro";
                    return;
                }

                if (ddlTipoTransaccion.SelectedValue.Trim().Length == 0)
                {
                    nilblInformacion.Text = "Seleccione un tipo de transaccion valido";
                    return;
                }

                if (ddlNivel.SelectedValue.Trim().Length == 0)
                {
                    nilblInformacion.Text = "Seleccione un nivel valido";
                    return;
                }

                if (txtDescripcion.Text.Trim().Length == 0)
                {
                    nilblInformacion.Text = "Ingrese una descripción valida";
                    return;
                }
                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    operacion = "actualiza";
                }

                string codigo = txtCodigo.Text;

                object[] objEncabezado = new object[]{
                               codigo, //@codigo	int
                               txtDescripcion.Text, //@descripcion	varchar
                               Convert.ToInt32(this.Session["empresa"]), //@empresa	int
                               ddlNivel.SelectedValue.Trim(), //@jerarquia	varchar
                               ddlTipoTransaccion.SelectedValue.Trim() //@tipoTransaccion	varchar
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "lFormulacion",
                operacion,
                "ppa",
                objEncabezado))
                {
                    case 0:

                        // inicio de detalle

                        if (Convert.ToBoolean(this.Session["editar"]) == true)
                        {
                            object[] objValoresConcepto = new object[]
                                {
                                     Convert.ToInt16(Session["empresa"]),                                                       
                                     Convert.ToString(txtCodigo.Text)
                                };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                            "lformulacionDetalle",
                            "elimina",
                            "ppa",
                            objValoresConcepto))
                            {
                                case 1:
                                    verificacion = true;
                                    break;
                            }
                        }

                        for (int x = 0; x < this.selItems.Items.Count; x++)
                        {
                            if (this.selItems.Items[x].Selected == true)
                            {

                                object[] objValoresConcepto = new object[]
                                        {
                                              Convert.ToInt32(this.Session["empresa"]),   //@empresa	int
                                               codigo,         //@formulacion	int
                                               this.selItems.Items[x].Value  //@item	int
                                        };

                                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                "lformulacionDetalle",
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

                        // fin de detalle

                        break;


                    case 1:
                        verificacion = true;
                        break;
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
        for (int x = 0; x < this.selItems.Items.Count; x++)
        {
            if (formulacion.verificaItemFormulacion(txtCodigo.Text, Convert.ToInt32(selItems.Items[x].Value), Convert.ToInt32(this.Session["empresa"])) == 1)
                selItems.Items[x].Selected = true;
            else
                selItems.Items[x].Selected = false;
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

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(Page.Controls);


        CargarCombos();

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        this.txtCodigo.Enabled = true;

        this.ddlTipoTransaccion.Focus();
        this.nilblInformacion.Text = "";
        this.selItems.Visible = true;


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
        this.selItems.Visible = false;
        this.txtCodigo.Enabled = true;
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
        if (seguridad.VerificaAccesoOperacion(
       this.Session["usuario"].ToString(),
       ConfigurationManager.AppSettings["Modulo"].ToString(),
        nombrePaginaActual(),
       "A", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.selItems.Visible = true;
        CargarCombos();
        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        try
        {
            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = this.gvLista.SelectedRow.Cells[2].Text.Trim();
                this.txtCodigo.Enabled = false;
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.txtDescripcion.Text = this.gvLista.SelectedRow.Cells[3].Text.Trim();
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                ddlNivel.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text.Trim();
                obtenerJerarquias();
            }
            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                ddlTipoTransaccion.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text.Trim();
            }

            ValidaRegistro();



        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

        try
        {
            if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                      ConfigurationManager.AppSettings["Modulo"].ToString(),
                                       nombrePaginaActual(), "E", Convert.ToInt16(Session["empresa"])) == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
                return;
            }

            bool verificacion = false;

            object[] objValores = new object[]
                                {
                                    Convert.ToInt16(Session["empresa"]),                                                       
                                    this.gvLista.Rows[e.RowIndex].Cells[2].Text, 
                                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
            "lformulacionDetalle",
            "elimina",
            "ppa",
            objValores))
            {
                case 1:
                    verificacion = true;
                    break;
            }


            object[] objValoresCabeza = new object[]
                                {
                                    this.gvLista.Rows[e.RowIndex].Cells[2].Text, 
                                    Convert.ToInt16(Session["empresa"])                                                    
                                    
                                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
            "lformulacion",
            "elimina",
            "ppa",
            objValoresCabeza))
            {
                case 1:
                    verificacion = true;
                    break;
            }




            if (verificacion == false)
            {
                ManejoExito("Registro eliminado satisfactoriamente", "E");
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


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
           this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    protected void ddlNivel_SelectedIndexChanged(object sender, EventArgs e)
    {
        obtenerJerarquias();
    }

    private void obtenerJerarquias()
    {
        try
        {
            this.selItems.DataSource = jerarquia.GetNivelJerarquia(Convert.ToInt16(ddlNivel.SelectedValue.Trim()), Convert.ToInt16(this.Session["empresa"]));
            this.selItems.DataValueField = "codigo";
            this.selItems.DataTextField = "descripcion";
            this.selItems.DataBind();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
        }
    }

    #endregion Eventos



}
