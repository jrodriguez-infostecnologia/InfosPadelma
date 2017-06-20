using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Almacen_Padministracion_Bodega : System.Web.UI.Page
{
    #region instancias
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cbodega bodega = new Cbodega();
    CIP ip = new CIP();
    
    
    #endregion



    #region Metodos

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text, Convert.ToInt16(Session["empresa"]) };
        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "iBodega",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Código " + this.txtCodigo.Text + " ya se encuentra registrado";

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
        string operacion = "inserta", ccosto=null, cuenta=null,proveedor=null;

        if (this.txtDescripcion.Text.Length == 0 || this.txtCodigo.Text.Length == 0)
        {
            this.nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        try
        {


            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }

            if (chkCcosto.Checked ==true ) {
                ccosto = ddlCcosto.SelectedValue.Trim();
            }

            if (chkCuenta.Checked == true) {
                cuenta = ddlCuenta.SelectedValue.Trim();   
            }

            if (chkProveedor.Checked == true) {
                proveedor = ddlProveedor.SelectedValue.Trim();
            }
         

            object[] objValores = new object[]{
                chkActivo.Checked, //@activo
                ccosto,//@cCosto
                txtCodigo.Text.Trim(), //@codigo
                cuenta,//@Cuenta
                txtDesCorta.Text,//@desCorta
                txtDescripcion.Text,//@descripcion
                (int)this.Session["empresa"],//@empresa
                chkManejaExistencia.Checked,
                chkProduccion.Checked,
                proveedor,//@proveedor
                chkCcosto.Checked,//@validaCcosto
                chkCuenta.Checked,//@validaCuenta
                chkProveedor.Checked//@validaProveedor
                };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "iBodega",
                operacion,
                "ppa",
                objValores))
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
    protected void CargarCombos() {
        try
        {

            this.ddlCcosto.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cCentrosCosto", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlCcosto.DataValueField = "codigo";
            this.ddlCcosto.DataTextField = "descripcion";
            this.ddlCcosto.DataBind();
            this.ddlCcosto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar centro de costos. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView proveedor = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cTercero", "ppa"),
                "razonSocial", Convert.ToInt16(Session["empresa"]));
            proveedor.RowFilter = "proveedor=1";
            this.ddlProveedor.DataSource = proveedor;
            this.ddlProveedor.DataValueField = "id";
            this.ddlProveedor.DataTextField = "razonSocial";
            this.ddlProveedor.DataBind();
            this.ddlProveedor.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar proveedores. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView cuentas = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("cPuc", "ppa"),
                "nombre", Convert.ToInt16(Session["empresa"]));

            cuentas.RowFilter = "nivel > 5";
          
            this.ddlCuenta.DataSource = cuentas;
            this.ddlCuenta.DataValueField = "codigo";
            this.ddlCuenta.DataTextField = "nombre";
            this.ddlCuenta.DataBind();
            this.ddlCuenta.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar cuentas. Correspondiente a: " + ex.Message, "C");
        }
    
    }

    protected void CargarAuxiliares()
    {
        DataView auxiliares = bodega.SeleccionaAuxiliaresBodega((int)this.Session["empresa"], txtCodigo.Text.Trim());

        if (chkCcosto.Checked==true)
        {
            ddlCcosto.SelectedValue = auxiliares.Table.Rows[0].ItemArray.GetValue(0).ToString();
        }
        else {
            ddlCcosto.SelectedValue = "";
            ddlCcosto.Enabled = false;
        }

        if (chkCuenta.Checked==true)
        {
            ddlCuenta.SelectedValue = auxiliares.Table.Rows[0].ItemArray.GetValue(2).ToString();
        }
        else {
            ddlCuenta.SelectedValue = "";
            ddlCuenta.Enabled = false;
        }

        if (chkProveedor.Checked == true)
        {
            ddlProveedor.SelectedValue = auxiliares.Table.Rows[0].ItemArray.GetValue(1).ToString();
        }
        else {
            ddlProveedor.SelectedValue = "";
            ddlProveedor.Enabled = false;
        }
        
    
    }

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

        this.Response.Redirect("~/Almacen/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

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
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
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
        

            this.gvLista.DataSource = bodega.BuscarEntidad(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();

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

    #endregion
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void chkCcosto_CheckedChanged(object sender, EventArgs e)
    {
        if (chkCcosto.Checked)
        {
            ddlCcosto.Enabled = true;
        }
        else {
            ddlCcosto.Enabled = false;
            ddlCcosto.SelectedValue = "";
        }
    }
    protected void chkProveedor_CheckedChanged(object sender, EventArgs e)
    {
        if (chkProveedor.Checked)
        {
            ddlProveedor.Enabled = true;
        }
        else {

            ddlProveedor.Enabled = false;
            ddlProveedor.SelectedValue = "";
        }
    }
    protected void chkCuenta_CheckedChanged(object sender, EventArgs e)
    {
        if (chkCuenta.Checked)
        {
            ddlCuenta.Enabled = true;
        }
        else {
            ddlCuenta.Enabled = false;
            ddlCuenta.SelectedValue = "";
        }

    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
           this.Page.Controls);

        this.nilbNuevo.Visible = true;


        GetEntidad();
    }

    #region eventos
    #endregion
    protected void gvLista_SelectedIndexChanged1(object sender, EventArgs e)
    {
          if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             "A",//operacion
                            Convert.ToInt16(this.Session["empresa"]))//empresa
                            == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "A");
            return;
        }


        CcontrolesUsuario.HabilitarControles(
           this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        CargarCombos();

        try
        {


            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);
                this.txtCodigo.Enabled = false;
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
                foreach (Control c in this.gvLista.SelectedRow.Cells[5].Controls) {
                    if (c is CheckBox) {
                        chkCcosto.Checked = ((CheckBox)c).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                foreach (Control c in this.gvLista.SelectedRow.Cells[6].Controls)
                {
                    if (c is CheckBox)
                    {
                        chkProveedor.Checked = ((CheckBox)c).Checked;
                    }
                }
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                foreach (Control c in this.gvLista.SelectedRow.Cells[7].Controls)
                {
                    if (c is CheckBox)
                    {
                        chkCuenta.Checked = ((CheckBox)c).Checked;
                    }
                }
            }

            foreach (Control c in this.gvLista.SelectedRow.Cells[8].Controls)
            {
                if (c is CheckBox)
                {
                    chkManejaExistencia.Checked = ((CheckBox)c).Checked;
                }
            }
            foreach (Control c in this.gvLista.SelectedRow.Cells[9].Controls)
            {
                if (c is CheckBox)
                {
                    chkProduccion.Checked = ((CheckBox)c).Checked;
                }
            }
 
                foreach (Control c in this.gvLista.SelectedRow.Cells[10].Controls)
                {
                    if (c is CheckBox)
                    {
                        chkActivo.Checked = ((CheckBox)c).Checked;
                    }
                }
          


                CargarAuxiliares();                
          
            
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

            object[] objValores = new object[] {
                Convert.ToString(Server.HtmlDecode(this.gvLista.Rows[e.RowIndex].Cells[2].Text.Trim())),
                Convert.ToInt16(Session["empresa"])
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "iBodega",
                "elimina",
                "ppa",
                objValores))
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
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }
    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(
           this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();
        ddlCcosto.Enabled = false;
        ddlCuenta.Enabled = false;
        ddlProveedor.Enabled = false;
        

        
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (chkCcosto.Checked) {
            if (ddlCcosto.SelectedValue.Trim().Length == 0) {
                nilblInformacion.Text = "debe seleccionar un centro de costo valido";
            }
        }

        if (chkCuenta.Checked) {
            if (ddlCuenta.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "debe seleccionar una cuenta de costo valido";
            }
        }

        if (chkProveedor.Checked) {

            if (ddlProveedor.SelectedValue.Trim().Length == 0)
            {
                nilblInformacion.Text = "debe seleccionar un proveedor valido";
            }
             
        }

        Guardar();
    }
    protected void txtCodigo_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
        txtDescripcion.Focus();
    }
}