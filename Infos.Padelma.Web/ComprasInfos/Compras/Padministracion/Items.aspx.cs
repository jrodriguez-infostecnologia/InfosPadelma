using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Compras_Padministracion_Items : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Citems items = new Citems();
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



    private void Consecutivo()
    {
        try
        {
            this.txtCodigo.Text = items.Consecutivo(Convert.ToInt16(Session["empresa"]));
            txtPapeleta.Text = items.RetornaPapeleta(Convert.ToInt16(Session["empresa"])); ;
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el consecutivo. Correspondiente a: " + ex.Message, "C");
        }
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
            gvPlanes.Visible = false;
            upCabeza.Visible = false;
            this.gvLista.DataSource = items.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(this.Session["usuario"].ToString(), "C",
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

        this.Response.Redirect("~/Compras/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        CcontrolesUsuario.InhabilitarControles(this.upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(this.upCabeza.Controls);
      

        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(this.Session["usuario"].ToString(),
            operacion, ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(), "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void CargarCriterios()
    {
        foreach (GridViewRow registro in gvPlanes.Rows)
        {
            string producto = registro.Cells[0].Text;

            foreach (DataRowView criterio in items.ConsultaCriteriosItems(Convert.ToInt16(txtCodigo.Text), Convert.ToInt16(Session["empresa"])))
            {
                if (criterio.Row.ItemArray.GetValue(2).ToString() == producto)
                {
                    ((DropDownList)registro.FindControl("ddlCriterio")).SelectedValue = criterio.Row.ItemArray.GetValue(3).ToString();
                }
            }
        }
    }


    private void CargarCombos()
    {
        try
        {
            gvPlanes.Visible = true;
            this.gvPlanes.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("iPlanItem", "ppa"),
            "codigo", Convert.ToInt16(Session["empresa"]));
            gvPlanes.DataBind();


            foreach (GridViewRow registro in gvPlanes.Rows)
            {
                string producto = registro.Cells[0].Text;

                if (producto != "")
                {
                    if (items.ConsultaMayorPlan(producto, Convert.ToInt16(Session["empresa"])) == null)
                    {
                        ((DropDownList)registro.FindControl("ddlCriterio")).Visible = false;
                    }
                    else
                    {
                        ((DropDownList)registro.FindControl("ddlCriterio")).Visible = true;
                        ((DropDownList)registro.FindControl("ddlCriterio")).DataSource = items.ConsultaMayorPlan(producto, Convert.ToInt16(Session["empresa"]));
                        ((DropDownList)registro.FindControl("ddlCriterio")).DataValueField = "codigo";
                        ((DropDownList)registro.FindControl("ddlCriterio")).DataTextField = "descripcion";
                        ((DropDownList)registro.FindControl("ddlCriterio")).DataBind();
                        ((DropDownList)registro.FindControl("ddlCriterio")).Items.Insert(0, new ListItem("", ""));
                    }
                }

                else
                {
                    ((DropDownList)registro.FindControl("ddlCriterio")).Visible = false;
                    ((DropDownList)registro.FindControl("ddlCriterio")).DataSource = null;
                    ((DropDownList)registro.FindControl("ddlCriterio")).DataBind();
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los centros de costo. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            this.ddlUmedidaCompra.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gUnidadMedida", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlUmedidaCompra.DataValueField = "codigo";
            this.ddlUmedidaCompra.DataTextField = "descripcion";
            this.ddlUmedidaCompra.DataBind();
            this.ddlUmedidaCompra.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidad de medida compra. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            this.ddlUmedidaConsumo.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gUnidadMedida", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlUmedidaConsumo.DataValueField = "codigo";
            this.ddlUmedidaConsumo.DataTextField = "descripcion";
            this.ddlUmedidaConsumo.DataBind();
            this.ddlUmedidaConsumo.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidad de medida consumo. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void Guardar()
    {
        string operacion = "inserta", grupoIR = null, papeleta;
        int codigo;
        bool venta = false, compra = false;
        try
        {
            foreach (ListItem registro in chklForma.Items)
            {
                if (registro.Value == "V" && registro.Selected == true)
                    venta = true;
                if (registro.Value == "C" && registro.Selected == true)
                    compra = true;
            }


            if (chkGrupoIR.Checked)
                grupoIR = ddlGrupoIR.SelectedValue;



            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                codigo = Convert.ToInt16(txtCodigo.Text);
                papeleta = this.txtPapeleta.Text;

                object[] objValores = new object[]{
                    chkActivo.Checked, //@activo
                    codigo,//@codigo
                    compra,//@compras
                    this.txtDescripcion.Text,//@descripcion
                    txtDesCorta.Text,//@descripcionAbreviada
                    Convert.ToInt16(Session["empresa"]),//@empresa
                    DateTime.Now,//@fechaActualiza
                    null,//@foto
                    grupoIR,//@grupoIR
                    chkGrupoIR.Checked,//@manejaIR
                    Convert.ToDecimal(txvMaximo.Text), //@maximo
                    Convert.ToDecimal(txvMinimo.Text),//@minimo
                    txtNotas.Text,//@notas
                    Convert.ToDecimal(txvOrden.Text),//@orden
                    papeleta,//@papeleta
                    txtReferencia.Text,//referencia
                    Convert.ToDecimal(txvReposicion.Text),//@tiempoReposicion
                    rblTipo.SelectedValue.ToString(),//@tipo
                    ddlUmedidaCompra.SelectedValue,//@uMedidaCompra
                    ddlUmedidaConsumo.SelectedValue,//@uMedidaConsumo
                    Convert.ToString(Session["usuario"]),//@usuarioActualiza
                    venta //@ventas
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "iItems",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:
                        object[] objValoresCriterio = new object[] {
                        Convert.ToInt16(Session["empresa"])  , txtCodigo.Text  };

                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                            "iItemsCriterios",
                            "elimina",
                            "ppa",
                            objValoresCriterio))
                        {
                            case 0:
                                foreach (GridViewRow registro in gvPlanes.Rows)
                                {
                                    if (((DropDownList)registro.FindControl("ddlCriterio")).SelectedValue.Length != 0)
                                    {

                                        object[] objValoresCriterios = new object[]{
                                    Convert.ToInt16(Session["empresa"]),//@empresa
                                    DateTime.Now,//@fechaRegistro
                                    ((DropDownList)registro.FindControl("ddlCriterio")).SelectedValue,
                                    registro.Cells[0].Text,
                                    txtCodigo.Text 
                                };

                                        switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                            "iItemsCriterios",
                                            "inserta",
                                            "ppa",
                                            objValoresCriterios))
                                        {
                                            case 1:
                                                ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                                                break;
                                        }
                                    }
                                }
                                break;
                            case 1:
                                ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                                break;
                        }
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        break;

                    case 1:

                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }


            }
            else
            {
                if (rblTipo.SelectedValue == "T" || rblTipo.ToolTip == "I")
                    papeleta = items.RetornaPapeleta(Convert.ToInt16(Session["empresa"]));
                else
                    papeleta = null;
                Consecutivo();
                codigo = Convert.ToInt16(txtCodigo.Text);

                object[] objValores = new object[]{
                    chkActivo.Checked, //@activo
                    codigo,//@codigo
                    compra,//@compras
                    this.txtDescripcion.Text,//@descripcion
                    txtDesCorta.Text,//@descripcionAbreviada
                    Convert.ToInt16(Session["empresa"]),//@empresa
                    null,//@fechaActualiza
                    DateTime.Now,//@fechaRegistro
                    null,//@foto
                    grupoIR,//@grupoIR
                    chkGrupoIR.Checked,//@manejaIR
                    Convert.ToDecimal(txvMaximo.Text), //@maximo
                    Convert.ToDecimal(txvMinimo.Text),//@minimo
                    txtNotas.Text,//@notas
                    papeleta,//@papeleta
                    txtReferencia.Text,//referencia
                    Convert.ToDecimal(txvReposicion.Text),//@tiempoReposicion
                    rblTipo.SelectedValue.ToString(),//@tipo
                    ddlUmedidaCompra.SelectedValue,//@uMedidaCompra
                    ddlUmedidaConsumo.SelectedValue,//@uMedidaConsumo
                    null,//@usuarioActualiza
                    Convert.ToString(Session["usuario"]),//@usuarioRegistro
                    venta //@ventas
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "iItems",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:

                        foreach (GridViewRow registro in gvPlanes.Rows)
                        {
                            if (((DropDownList)registro.FindControl("ddlCriterio")).SelectedValue.Length != 0)
                            {

                                object[] objValoresCriterios = new object[]{
                                    Convert.ToInt16(Session["empresa"]),//@empresa
                                    DateTime.Now,//@fechaRegistro
                                    ((DropDownList)registro.FindControl("ddlCriterio")).SelectedValue,
                                    registro.Cells[0].Text,
                                    txtCodigo.Text 
                                };

                                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                    "iItemsCriterios",
                                    operacion,
                                    "ppa",
                                    objValoresCriterios))
                                {
                                    case 1:
                                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                                        break;
                                }
                            }
                        }
                        ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                        break;
                    case 1:

                        ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());
                        break;
                }

            }


        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }

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

        upCabeza.Visible = true;
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);
        CcontrolesUsuario.HabilitarControles(upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(upCabeza.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;
        Consecutivo();
        CargarCombos();
        ddlGrupoIR.Enabled = false;
        txtCodigo.Enabled = false;
        txtPapeleta.Enabled = false;
        txtReferencia.Focus();

    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        this.nilbNuevo.Visible = true;

        GetEntidad();

    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {

        CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(this.Page.Controls);
        CcontrolesUsuario.HabilitarControles(upCabeza.Controls);
        CcontrolesUsuario.LimpiarControles(upCabeza.Controls);
        upCabeza.Visible = false;

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.gvPlanes.DataSource = null;
        this.gvPlanes.DataBind();

        gvPlanes.Visible = false;

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (chkGrupoIR.Checked)
        {
            if (ddlGrupoIR.SelectedValue.Length == 0)
            {
                nilblInformacion.Text = "Debe seleccionar un grupo impuesto o retención";
                return;
            }
        }

        if (txtDesCorta.Text.Length == 0 || txtDescripcion.Text.Length == 0 || ddlUmedidaCompra.SelectedValue.Length == 0 || ddlUmedidaConsumo.SelectedValue.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        if (rblTipo.SelectedValue == "T" || rblTipo.ToolTip == "I")
        {
            if (Convert.ToDecimal(txvMaximo.Text) <= 0 || Convert.ToDecimal(txvMinimo.Text) <= 0 || Convert.ToDecimal(txvReposicion.Text) <= 0)
            {
                nilblInformacion.Text = "Campos en 0 (cero) por favor corrija";
                return;
            }
        }

        if (Convert.ToDecimal(txvMaximo.Text) > Convert.ToDecimal(txvMinimo.Text))
        {
            nilblInformacion.Text = "El campo maximo no puede ser menor o igual al campo minimo";
            return;
        }

        Guardar();

    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
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

            object[] objValoresCriterio = new object[] {
                        Convert.ToInt16(Session["empresa"])  ,
                         Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text))
                                  };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "iItemsCriterios",
                "elimina",
                "ppa",
                objValoresCriterio))
            {
                case 0:
                    object[] objValores = new object[] {
                        Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text)),
                        Convert.ToInt16(Session["empresa"])           };


                    switch (CentidadMetodos.EntidadInsertUpdateDelete(
                        "iItems",
                        "elimina",
                        "ppa",
                        objValores))
                    {
                        case 1:

                            ManejoError("Error al eliminar el registro. Operación no realizada", "E");
                            break;
                    }
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
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }



    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(), "A", Convert.ToInt16(this.Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }
        
        upCabeza.Visible = true;
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CcontrolesUsuario.HabilitarControles(this.upCabeza.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        CargarCombos();
        this.txtReferencia.Focus();

        try
        {


            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
                this.txtCodigo.Enabled = false;
                CargarCriterios();
            }
            else
            {
                this.txtCodigo.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text.Trim());
            }
            else
            {
                txtDescripcion.Text = "";
            }
            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                txtDesCorta.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            }
            else
            {
                txtDesCorta.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                txtReferencia.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[5].Text);
            }
            else
            {
                txtReferencia.Text = "";
            }

            foreach (Control c in this.gvLista.SelectedRow.Cells[6].Controls)
            {
                if (c is CheckBox)
                    chkGrupoIR.Checked = ((CheckBox)c).Checked;
            }


            if (chkGrupoIR.Checked)
            {
                cargarGrupoIR();
                ddlGrupoIR.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text);
            }
            else
                ddlGrupoIR.SelectedValue = "";

            foreach (ListItem reg in rblTipo.Items)
            {
                if (reg.Value == Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text))
                    reg.Selected = true;
                else
                    reg.Selected = false;

            }

            foreach (ListItem reg in chklForma.Items)
            {
                if (reg.Value == "C")
                {
                    foreach (Control c in this.gvLista.SelectedRow.Cells[9].Controls)
                    {
                        if (c is CheckBox)
                            reg.Selected = ((CheckBox)c).Checked;
                    }
                }
                else
                {
                    foreach (Control c in this.gvLista.SelectedRow.Cells[10].Controls)
                    {
                        if (c is CheckBox)
                            reg.Selected = ((CheckBox)c).Checked;
                    }
                }


            }

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
            {
                ddlUmedidaCompra.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[11].Text);
            }

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
            {
                ddlUmedidaConsumo.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[12].Text);
            }

            if (this.gvLista.SelectedRow.Cells[13].Text != "&nbsp;")
            {
                txtPapeleta.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[13].Text);
            }
            else
            {
                txtPapeleta.Text = "";
            }
            if (this.gvLista.SelectedRow.Cells[14].Text != "&nbsp;")
            {
                txvReposicion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[14].Text);
            }
            else
            {
                txvReposicion.Text = "0";
            }

            if (this.gvLista.SelectedRow.Cells[15].Text != "&nbsp;")
            {
                txvMinimo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[15].Text);
            }
            else
            {
                txvMinimo.Text = "0";
            }
            if (this.gvLista.SelectedRow.Cells[16].Text != "&nbsp;")
            {
                txvMaximo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[16].Text);
            }
            else
            {
                txvMaximo.Text = "0";
            }


            if (this.gvLista.SelectedRow.Cells[17].Text != "&nbsp;")
            {
                txtNotas.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[17].Text);
            }
            else
            {
                txtNotas.Text = "";
            }

            foreach (Control c in this.gvLista.SelectedRow.Cells[18].Controls)
            {
                if (c is CheckBox)
                    chkActivo.Checked = ((CheckBox)c).Checked;
            }
            
            if (this.gvLista.SelectedRow.Cells[19].Text != "&nbsp;")
            {
                txvOrden.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[19].Text);
            }
            else
            {
                txvOrden.Text = "0";
            }

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }

    }
    protected void chkGrupoIR_CheckedChanged(object sender, EventArgs e)
    {
        cargarGrupoIR();
    }

    private void cargarGrupoIR()
    {
        if (chkGrupoIR.Checked)
        {
            ddlGrupoIR.Enabled = true;
            try
            {

                this.ddlGrupoIR.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cGrupoIR", "ppa"),
                    "descripcion", Convert.ToInt16(Session["empresa"]));
                this.ddlGrupoIR.DataValueField = "codigo";
                this.ddlGrupoIR.DataTextField = "descripcion";
                this.ddlGrupoIR.DataBind();
                this.ddlGrupoIR.Items.Insert(0, new ListItem("", ""));
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar unidad de medida consumo. Correspondiente a: " + ex.Message, "C");
            }
        }
        else
        {
            this.ddlGrupoIR.DataSource = null;
            ddlGrupoIR.DataBind();
            ddlGrupoIR.Enabled = false;
        }
    }


}