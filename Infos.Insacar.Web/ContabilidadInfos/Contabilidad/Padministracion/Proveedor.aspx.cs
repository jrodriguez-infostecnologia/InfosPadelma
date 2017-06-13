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
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    ADInfos.AccesoDatos accesoDatos = new ADInfos.AccesoDatos();
    Cproveedor proveedor = new Cproveedor();
    CIP ip = new CIP();
    Cpuc puc = new Cpuc();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string editar = "A";

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
            if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             consulta,//operacion
                            Convert.ToInt16(this.Session["empresa"]))//empresa
                            == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", consulta);
                return;
            }

            gvClaseIR.Visible = false;

            this.gvLista.DataSource = proveedor.BuscarEntidad(
                this.nitxtBusqueda.Text, Convert.ToInt32(this.Session["empresa"]));

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            "C",
             ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            this.gvLista.Rows.Count.ToString() + " Registros encontrados",
            ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));
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
              error,
             ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));

        this.Response.Redirect("~/Contabilidad/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
             ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje,
            ip.ObtenerIP(), Convert.ToInt16(this.Session["empresa"]));

        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            DataView terceros = CcontrolesUsuario.OrdenarEntidad(
                accesoDatos.EntidadGet("cTercero", "ppa"),
                "descripcion", Convert.ToInt16(this.Session["empresa"]));
            terceros.RowFilter = "empresa=" + Convert.ToInt16(this.Session["empresa"]);
            this.ddlTercero.DataSource = terceros;
            this.ddlTercero.DataValueField = "id";
            this.ddlTercero.DataTextField = "descripcion";
            this.ddlTercero.DataBind();
            this.ddlTercero.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar terceros. Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            DataView claseProveedor = CcontrolesUsuario.OrdenarEntidad(
              accesoDatos.EntidadGet("cxpClaseProveedor", "ppa"),
              "descripcion", Convert.ToInt16(this.Session["empresa"]));
            claseProveedor.RowFilter = "empresa=" + Convert.ToInt16(this.Session["empresa"]);


            this.ddlClaseProveedor.DataSource = claseProveedor;
            this.ddlClaseProveedor.DataValueField = "codigo";
            this.ddlClaseProveedor.DataTextField = "descripcion";
            this.ddlClaseProveedor.DataBind();
            this.ddlClaseProveedor.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar clases de proveedor. Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            DataView ciudad = CcontrolesUsuario.OrdenarEntidad(
              accesoDatos.EntidadGet("gCiudad", "ppa"),
              "nombre", Convert.ToInt16(this.Session["empresa"]));
            ciudad.RowFilter = "empresa=" + Convert.ToInt16(this.Session["empresa"]);


            this.ddlCiudad.DataSource = ciudad;
            this.ddlCiudad.DataValueField = "codigo";
            this.ddlCiudad.DataTextField = "nombre";
            this.ddlCiudad.DataBind();
            this.ddlCiudad.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar ciudades. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            gvClaseIR.Visible = true;
            this.gvClaseIR.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(accesoDatos.EntidadGet("cClaseIR", "ppa"),
            "codigo", Convert.ToInt16(Session["empresa"]));
            gvClaseIR.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los centros de costo. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void EntidadKey()
    {
        if (ddlTercero.SelectedValue.ToString().Trim().Length == 0)
        {
            nilblMensaje.Text = "debe escojer un tercero primero";
            return;
        }
        object[] objKey = new object[] { 
            this.txtCodigo.Text,
           Convert.ToInt16(this.Session["empresa"]),
           Convert.ToInt16(ddlTercero.SelectedValue.ToString())
        };

        try
        {
            if (accesoDatos.EntidadGetKey(
                "cxpProveedor",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Destino " + this.txtCodigo.Text + " ya se encuentra registrado";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

                this.nilbNuevo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
        }
    }


    private void Guardar()
    {
        string operacion = "inserta";
        bool verificacion = false;

        try
        {

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }
            using (TransactionScope ts = new TransactionScope())
            {

                object[] objValores = new object[]{                
                chkActivo.Checked,
                ddlCiudad.SelectedValue.ToString().Trim(),
                ddlClaseProveedor.SelectedValue.ToString().Trim(),
                this.txtCodigo.Text,
                txtContacto.Text,
                txtDescripcion.Text,
                txtDireccion.Text,
                txtEmail.Text,
                Convert.ToInt16(this.Session["empresa"]),
                  chkEntradaDirecta.Checked,
                DateTime.Now,
                ddlTercero.SelectedValue,
                txtTelefono.Text
            };

                switch (accesoDatos.EntidadInsertUpdateDelete(
                    "cxpProveedor",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 0:
                        if (Convert.ToBoolean(this.Session["editar"]) == true)
                        {
                            foreach (GridViewRow registro in this.gvClaseIR.Rows)
                            {
                                if (proveedor.VerificaClaseIR(txtCodigo.Text, Convert.ToInt16(ddlTercero.SelectedValue), Convert.ToInt32(registro.Cells[1].Text), Convert.ToInt16(Session["empresa"])) == 0)
                                {
                                    if (((CheckBox)registro.FindControl("chkSelect")).Checked != true)
                                    {
                                        object[] objValoresElimina = new object[]{                
                                            Convert.ToInt16(registro.Cells[1].Text),
                                            Convert.ToInt16(Session["empresa"]),
                                            txtCodigo.Text,
                                            Convert.ToInt16(ddlTercero.SelectedValue)
                                                 };

                                        switch (accesoDatos.EntidadInsertUpdateDelete(
                                            "cxpProveedorCalseIR",
                                            "elimina",
                                            "ppa",
                                            objValoresElimina))
                                        {
                                            case 1:
                                                verificacion = true;
                                                break;
                                        }
                                    }
                                    else
                                    {
                                        string concepto;

                                        if (((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue == "")
                                        {
                                            concepto = null;
                                        }
                                        else
                                        {
                                            concepto = ((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue;
                                        }

                                        object[] objValoresClase = new object[]{                
                                                Convert.ToInt16(registro.Cells[1].Text),
                                                concepto,
                                                Convert.ToInt16(Session["empresa"]), 
                                                txtCodigo.Text,
                                                Convert.ToInt16(ddlTercero.SelectedValue)};

                                        switch (accesoDatos.EntidadInsertUpdateDelete(
                                            "cxpProveedorCalseIR",
                                            "actualiza",
                                            "ppa",
                                            objValoresClase))
                                        {
                                            case 1:
                                                verificacion = true;
                                                break;
                                        }
                                    }
                                }
                                else
                                {
                                    if (((CheckBox)registro.FindControl("chkSelect")).Checked == true)
                                    {
                                        string concepto;

                                        if (((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue == "")
                                        {
                                            concepto = null;
                                        }
                                        else
                                        {
                                            concepto = ((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue;
                                        }

                                        object[] objValoresClase = new object[]{                
                                                Convert.ToInt16(registro.Cells[1].Text),
                                                concepto,
                                                Convert.ToInt16(Session["empresa"]), 
                                                txtCodigo.Text,
                                                Convert.ToInt16(ddlTercero.SelectedValue)};

                                        switch (accesoDatos.EntidadInsertUpdateDelete(
                                            "cxpProveedorCalseIR",
                                            "inserta",
                                            "ppa",
                                            objValoresClase))
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
                            foreach (GridViewRow registro in this.gvClaseIR.Rows)
                            {
                                if (((CheckBox)registro.FindControl("chkSelect")).Checked == true)
                                {
                                    string concepto;

                                    if (((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue == "")
                                    {
                                        concepto = null;
                                    }
                                    else
                                    {
                                        concepto = ((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue;
                                    }

                                    object[] objValoresClase = new object[]{                
                                                Convert.ToInt16(registro.Cells[1].Text),
                                                concepto,
                                                Convert.ToInt16(Session["empresa"]), 
                                                txtCodigo.Text,
                                                Convert.ToInt16(ddlTercero.SelectedValue)};

                                    switch (accesoDatos.EntidadInsertUpdateDelete(
                                        "cxpProveedorCalseIR",
                                        "inserta",
                                        "ppa",
                                        objValoresClase))
                                    {
                                        case 1:
                                            verificacion = true;
                                            break;
                                    }

                                }
                            }
                        }
                        break;
                    case 1:
                        verificacion = true;
                        break;
                }

                if (verificacion == true)
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
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, "I");
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
            if (seguridad.VerificaAccesoPagina(
                    this.Session["usuario"].ToString(),
                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                    nombrePaginaActual(),
                    Convert.ToInt16(this.Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();

                if (this.txtCodigo.Text.Length > 0)
                {
                    this.txtDescripcion.Focus();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {

        CcontrolesUsuario.InhabilitarControles(
        this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        gvClaseIR.Visible = false;

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";

    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }



    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            editar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }


        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.ddlTercero.Enabled = false;
        this.txtDescripcion.Focus();
        txtCodigo.Enabled = false;

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.ddlTercero.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;

            }
            else
            {
                this.ddlTercero.SelectedValue = "";
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                txtCodigo.Text = this.gvLista.SelectedRow.Cells[3].Text;
                ValidaRegistro();
            }
            else
            {
                txtCodigo.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            }
            else
            {
                txtDescripcion.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                ddlClaseProveedor.SelectedValue = this.gvLista.SelectedRow.Cells[5].Text;
            }
            else
            {
                ddlClaseProveedor.SelectedValue = "";
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                txtContacto.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[6].Text);
            }
            else
            {
                txtContacto.Text = "";
            }


            if (this.gvLista.SelectedRow.Cells[7].Text.Trim() != "&nbsp;")
            {
                ddlCiudad.SelectedValue = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text.Trim());
            }
            else
            {
                ddlCiudad.SelectedValue = "";
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                txtDireccion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[7].Text);
            }
            else
            {
                txtDireccion.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
            {
                txtTelefono.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[8].Text);
            }
            else
            {
                txtTelefono.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
            {
                txtEmail.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[9].Text);
            }
            else
            {
                txtEmail.Text = "";
            }

            foreach (Control c in gvLista.SelectedRow.Cells[11].Controls)
            {
                if (c is CheckBox)
                {
                    chkEntradaDirecta.Checked = ((CheckBox)c).Checked;
                }
            }

            foreach (Control c in gvLista.SelectedRow.Cells[12].Controls)
            {

                if (c is CheckBox)
                {
                    chkActivo.Checked = ((CheckBox)c).Checked;
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            eliminar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", eliminar);
            return;
        }


        string operacion = "elimina";

        try
        {

            if (proveedor.EliminaClaseProveedor(Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[3].Text), Convert.ToInt16(this.gvLista.Rows[e.RowIndex].Cells[2].Text), Convert.ToInt16(this.Session["empresa"])) == 0)
            {
                object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[3].Text),
                Convert.ToInt16(this.Session["empresa"]),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text)            };

                if (accesoDatos.EntidadInsertUpdateDelete(
                    "cxpProveedor",
                    operacion,
                    "ppa",
                    objValores) == 0)
                {
                    ManejoExito("Datos eliminados satisfactoriamente", "E");
                }
                else
                {
                    ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
                }
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operación no realizada", "E");
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }

    protected void txtCodigo_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
        txtDescripcion.Focus();

    }

    protected void nilbNiveles_Click(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoPagina(
            this.Session["usuario"].ToString(),
            ConfigurationManager.AppSettings["Modulo"].ToString(),
            "Nivel.aspx",
            Convert.ToInt16(this.Session["empresa"])) != 0)
        {
            this.Response.Redirect("Nivel.aspx");
        }
        else
        {
            ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    private void ValidaRegistro()
    {
        foreach (GridViewRow registro in this.gvClaseIR.Rows)
        {
            if (proveedor.VerificaClaseIR(txtCodigo.Text, Convert.ToInt16(ddlTercero.SelectedValue), Convert.ToInt32(registro.Cells[1].Text), Convert.ToInt16(Session["empresa"])) == 0)
            {
                ((CheckBox)registro.FindControl("chkSelect")).Checked = true;


                foreach (DataRowView clases in proveedor.TerceroClase(Convert.ToInt16(registro.Cells[1].Text), txtCodigo.Text, Convert.ToInt16(ddlTercero.SelectedValue), Convert.ToInt16(Session["empresa"])))
                {
                    if (clases.Row.ItemArray.GetValue(3).ToString() == registro.Cells[1].Text)
                    {
                        ((DropDownList)registro.FindControl("ddlConcepto")).DataSource = proveedor.ConceptosClase(Convert.ToInt32(registro.Cells[1].Text), Convert.ToInt16(Session["empresa"]));
                        ((DropDownList)registro.FindControl("ddlConcepto")).DataValueField = "codigo";
                        ((DropDownList)registro.FindControl("ddlConcepto")).DataTextField = "descripcion";
                        ((DropDownList)registro.FindControl("ddlConcepto")).DataBind();
                        ((DropDownList)registro.FindControl("ddlConcepto")).Items.Insert(0, new ListItem("", ""));
                        ((DropDownList)registro.FindControl("ddlConcepto")).Enabled = true;

                        if (clases.Row.ItemArray.GetValue(4).ToString() == "")
                            ((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue = "";
                        else
                            ((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue = clases.Row.ItemArray.GetValue(4).ToString();

                    }
                    else
                    {
                        ((DropDownList)registro.FindControl("ddlConcepto")).Enabled = false;
                        ((DropDownList)registro.FindControl("ddlConcepto")).SelectedValue = "";
                    }

                }

            }
            else
            {
                ((CheckBox)registro.FindControl("chkSelect")).Checked = false;
                ((DropDownList)registro.FindControl("ddlConcepto")).DataSource = null;
                ((DropDownList)registro.FindControl("ddlConcepto")).DataBind();

            }
        }
    }

    #endregion Eventos

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (txtCodigo.Text.Length == 0 || txtDescripcion.Text.Length == 0 ||
            txtContacto.Text.Length == 0)
        {

            nilblMensaje.Text = "Campos vacios por favor corrija";
            return;
        }

        if (ddlClaseProveedor.SelectedIndex.ToString().Trim().Length == 0 || ddlCiudad.SelectedIndex.ToString().Trim().Length == 0 ||
            ddlTercero.SelectedIndex.ToString().Trim().Length == 0)
        {
            nilblMensaje.Text = "Seleccione un tercero /ciudad / clase proveedor";
            return;
        }


        Guardar();
    }

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             insertar,//operacion
                            Convert.ToInt16(this.Session["empresa"]))//empresa
                            == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", insertar);
            return;
        }


        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();

        this.ddlTercero.Enabled = true;
        this.ddlTercero.Focus();
        this.nilblInformacion.Text = "";
    }
    protected void nilbClaseProveedor_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("ClaseProveedor.aspx", false);
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("terceros.aspx");
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        gvLista.DataBind();
        GetEntidad();
    }
    protected void nilbTerceros_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("terceros.aspx");
    }

    protected void gvClaseIR_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {

        if (((CheckBox)this.gvClaseIR.Rows[e.RowIndex].FindControl("chkSelect")).Checked)
        {
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).Enabled = true;

            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).DataSource = proveedor.ConceptosClase(Convert.ToInt16(gvClaseIR.Rows[e.RowIndex].Cells[0].Text), Convert.ToInt16(Session["empresa"]));
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).DataValueField = "codigo";
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).DataTextField = "descripcion";
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).DataBind();
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).Items.Insert(0, new ListItem("", ""));

        }
        else
        {

            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).DataSource = null;
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).DataBind();
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).Items.Insert(0, new ListItem("", ""));
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).SelectedValue = "";
            ((DropDownList)this.gvClaseIR.Rows[e.RowIndex].FindControl("ddlConcepto")).Enabled = false;
        }

    }
    protected void chkSelect_CheckedChanged(object sender, EventArgs e)
    {
        CheckBox drop = (CheckBox)sender;
        GridViewRow row = (GridViewRow)drop.NamingContainer;

        int rowIndex = row.RowIndex;


        if (((CheckBox)this.gvClaseIR.Rows[rowIndex].FindControl("chkSelect")).Checked)
        {
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).Enabled = true;

            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).DataSource = proveedor.ConceptosClase(Convert.ToInt16(gvClaseIR.Rows[rowIndex].Cells[1].Text), Convert.ToInt16(Session["empresa"]));
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).DataValueField = "codigo";
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).DataTextField = "descripcion";
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).DataBind();
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).Items.Insert(0, new ListItem("", ""));

        }
        else
        {
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).DataSource = null;
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).DataBind();
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).Items.Insert(0, new ListItem("", ""));
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).SelectedValue = "";
            ((DropDownList)this.gvClaseIR.Rows[rowIndex].FindControl("ddlConcepto")).Enabled = false;
        }
    }

}
