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

public partial class Facturacion_Padministracion_Clientes1 : System.Web.UI.Page
{
    #region Instancias

    Cperiodo periodos = new Cperiodo();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";
    #endregion Instancias

    #region Metodos

    private void OpcionesDefecto()
    {
        this.nilblOperacion.Text = "";
        this.nilblOperacion.Visible = false;
        this.niddlAno.Visible = false;
        this.nilbEjecutar.Visible = false;
        this.nilblCancelar.Visible = false;
        this.nitxtAno.Visible = false;
        this.nichkCerrarA�o.Visible = false;

    }

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
                       Convert.ToInt32(this.Session["empresa"]))//empresa
                       == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operaci�n", consulta);
                return;
            }

            this.gvLista.DataSource = periodos.BuscarEntidad(
                this.nitxtBusqueda.Text, Convert.ToInt32(this.Session["empresa"]));

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
               this.Session["usuario"].ToString(),
               consulta,
                ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
               "ex",
               this.gvLista.Rows.Count.ToString() + " Registros encontrados",
               ip.ObtenerIP(), Convert.ToInt32(this.Session["empresa"]));
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
              ip.ObtenerIP(), Convert.ToInt32(this.Session["empresa"]));

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

        seguridad.InsertaLog(
               this.Session["usuario"].ToString(),
               operacion,
                ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
               "ex",
               mensaje,
               ip.ObtenerIP(), Convert.ToInt32(this.Session["empresa"]));

        GetEntidad();
    }

    private void CargarCombos()
    {
        try
        {
            this.niddlAno.DataSource = periodos.GetAnosPeriodos();
            this.niddlAno.DataValueField = "a�o";
            this.niddlAno.DataTextField = "a�o";
            this.niddlAno.DataBind();
            this.niddlAno.Items.Insert(0, new ListItem("", "Seleccione una opci�n"));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar a�os. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void EntidadKey()
    {
        if (txtA�o.Text.Length == 0 || txtMes.Text.Length == 0)
        {
            return;
        }
        object[] objKey = new object[] { this.txtA�o.Text, Convert.ToInt32(this.Session["empresa"]), txtMes.Text };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "aPeriodo",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Periodo " + this.txtA�o.Text + " ya se encuentra registrado";

                CcontrolesUsuario.InhabilitarControles(
                    this.Page.Controls);

                this.nilbNuevo.Visible = true;
                this.txtA�o.Text = "";
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

        try
        {
            Convert.ToInt32(this.txtA�o.Text);
            Convert.ToInt32(this.txtMes.Text);
        }
        catch
        {
            nilblMensaje.Text = "a�o/mes debe ser un numero";
            return;

        }
        if (!(Convert.ToInt32(txtMes.Text) <= 13 && Convert.ToInt32(txtMes.Text) >= 1))
        {
            nilblMensaje.Text = "Mes no valido";
            return;
        }


        try
        {


            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
            }
            

            object[] objValores = new object[]{   
                Convert.ToInt32(this.txtA�o.Text),
                this.chkCerrado.Checked,
                Convert.ToInt32(this.Session["empresa"]),
                Convert.ToInt32(this.txtMes.Text )             
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "aPeriodo",
                operacion,
                "ppa",
                objValores))
            {
                case 0:

                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                    break;

                case 1:

                    ManejoError("Errores al insertar el registro. Operaci�n no realizada", operacion.Substring(0, 1).ToUpper());
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

            if (seguridad.VerificaAccesoPagina(
                    this.Session["usuario"].ToString(),
                    ConfigurationManager.AppSettings["Modulo"].ToString(),
                    nombrePaginaActual(),
                    Convert.ToInt32(this.Session["empresa"])) != 0)
            {
                this.nitxtBusqueda.Focus();

                this.nitxtBusqueda.Focus();

                if (this.txtA�o.Text.Length > 0)
                {
                    this.chkCerrado.Focus();
                }
            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta p�gina", "IN");
            }


        }
    }

    protected void lbNuevo_Click(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             insertar,//operacion
                            Convert.ToInt32(this.Session["empresa"]))//empresa
                            == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", insertar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;

        CargarCombos();

        this.txtA�o.Enabled = true;
        this.txtA�o.Focus();
        this.nilblInformacion.Text = "";
        this.niddlAno.Visible = false;
        this.nilbEjecutar.Visible = false;
        this.nilblOperacion.Visible = false;
        this.nilblCancelar.Visible = false;
        this.nitxtAno.Visible = false;
        this.nichkCerrarA�o.Visible = false;

    }

    protected void lbCancelar_Click(object sender, EventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.nitxtAno.Visible = false;
        this.niddlAno.Visible = false;
        // this.nirfvAno.Enabled = false;
        this.nilblMensaje.Text = "";
    }

    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();
    }

    protected void lbRegistrar_Click(object sender, EventArgs e)
    {
        Guardar();
    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            editar,//operacion
                           Convert.ToInt32(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", editar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;
        this.nilblOperacion.Visible = false;
        this.niddlAno.Visible = false;
        this.nitxtAno.Visible = false;
        this.nichkCerrarA�o.Visible = false;
        this.nilblCancelar.Visible = false;
        this.nilbEjecutar.Visible = false;

        this.nilblMensaje.Text = "";
        this.txtA�o.Enabled = false;
        this.chkCerrado.Focus();

        try
        {
            CargarCombos();

            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtA�o.Text = this.gvLista.SelectedRow.Cells[2].Text;
            }
            else
            {
                this.txtA�o.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.txtMes.Text = this.gvLista.SelectedRow.Cells[3].Text;
            }
            else
            {
                this.txtMes.Text = "";
            }

            foreach (Control objControl in this.gvLista.SelectedRow.Cells[6].Controls)
            {
                if (objControl is CheckBox)
                {
                    this.chkCerrado.Checked = ((CheckBox)objControl).Checked;
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
                            Convert.ToInt32(this.Session["empresa"]))//empresa
                            == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operaci�n", eliminar);
            return;
        }

        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                Convert.ToInt32(this.gvLista.Rows[e.RowIndex].Cells[2].Text), 
                Convert.ToInt32(this.Session["empresa"]),
                  Convert.ToInt32(this.gvLista.Rows[e.RowIndex].Cells[3].Text) 
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "aPeriodo",
                operacion,
                "ppa",
                objValores) == 0)
            {
                ManejoExito("Datos eliminados satisfactoriamente", "E");
            }
            else
            {
                ManejoError("Errores al eliminar el registro. Operaci�n no realizada", "E");
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }
    }

    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void nilbAbrirAnos_Click(object sender, EventArgs e)
    {
        this.nilblOperacion.Text = "Seleccione el a�o que desea abrir";
        this.nilblOperacion.Visible = true;
        this.niddlAno.Visible = true;
        this.nilbEjecutar.Visible = true;
        this.nilblCancelar.Visible = true;
        this.nitxtAno.Visible = false;
        this.nichkCerrarA�o.Visible = true;
        this.niddlAno.Focus();
        this.nilblMensaje.Text = "";
        this.nichkCerrarA�o.Enabled = true;
        CcontrolesUsuario.InhabilitarControles(Page.Controls);


        this.Session["opcion"] = "abrir";

        CargarCombos();
    }


    protected void nilbEjecutar_Click(object sender, ImageClickEventArgs e)
    {

        int conteo = 0;

        try
        {
            switch (this.Session["opcion"].ToString())
            {
                case "abrir":

                    if (periodos.AbrirCerrarPeriodosAno(
                        Convert.ToInt32(this.niddlAno.SelectedValue),
                         Convert.ToInt32(this.Session["empresa"]),
                        out conteo,
                        nichkCerrarA�o.Checked) == 0)
                    {
                        if (!chkCerrado.Checked)
                        {
                            ManejoExito("Peridos abiertos satisfactoriamente. " + conteo.ToString() + " registros afectados", "A");
                        }
                        else
                        {
                            ManejoExito("Peridos cerrados satisfactoriamente. " + conteo.ToString() + " registros afectados", "A");

                        }
                    }
                    else
                    {
                        ManejoError("Error al abrir/cerrar los periodos. Operaci�n no realizada", "A");
                    }
                    break;


                case "generar":

                    if (periodos.GenerarPeriodosAno(
                        Convert.ToInt32(this.nitxtAno.Text),
                        out conteo,
                        Convert.ToInt32(this.Session["empresa"])
                        ) == 0)
                    {
                        ManejoExito("Peridos generados satisfactoriamente. " + conteo.ToString() + " registros afectados", "I");
                    }
                    else
                    {
                        ManejoError("Error al generar los periodos. Operaci�n no realizada", "I");
                    }
                    break;

                case "eliminar":

                    if (periodos.EliminarPeriodosAno(
                        Convert.ToInt32(this.nitxtAno.Text),
                         Convert.ToInt32(this.Session["empresa"])
                        ) == 0)
                    {
                        ManejoExito("Peridos eliminados satisfactoriamente.", "E");
                    }
                    else
                    {
                        ManejoError("Error al eliminar los periodos. Operaci�n no realizada", "E");
                    }
                    break;
            }

            OpcionesDefecto();
        }
        catch (Exception ex)
        {
            ManejoError("Error al ejecutar la operaci�n seleccionada. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void nilbCerrarPeriodosAno_Click(object sender, EventArgs e)
    {
        this.nilblOperacion.Text = "Seleccione el a�o que desea cerrar";
        this.nilblOperacion.Visible = true;
        this.niddlAno.Visible = true;
        this.nilbEjecutar.Visible = true;
        this.nilblCancelar.Visible = true;
        this.nitxtAno.Visible = false;
        this.niddlAno.Focus();
        this.nilblMensaje.Text = "";
        this.nichkCerrarA�o.Enabled = true;
        this.nichkCerrarA�o.Visible = true;


        this.Session["opcion"] = "cerrar";

        CargarCombos();
    }

    protected void nilbGenerarPeriodosAno_Click(object sender, EventArgs e)
    {
        //this.nirfvAno.Enabled = true;
        this.nilblOperacion.Text = "Digite el a�o que desea generar";
        this.nilblOperacion.Visible = true;
        this.niddlAno.Visible = false;
        this.nilbEjecutar.Visible = true;
        this.nilblCancelar.Visible = true;
        this.nitxtAno.Visible = true;
        this.nitxtAno.Focus();
        this.nichkCerrarA�o.Visible = false;

        this.nilblMensaje.Text = "";

        this.Session["opcion"] = "generar";

        CargarCombos();
    }

    protected void lbEliminarPeriodos_Click(object sender, EventArgs e)
    {
        //this.nirfvAno.Enabled = true;
        this.nilblOperacion.Text = "Digite el a�o que desea eliminar";
        this.nilblOperacion.Visible = true;
        this.niddlAno.Visible = false;
        this.nilbEjecutar.Visible = true;
        this.nilblCancelar.Visible = true;
        this.nitxtAno.Visible = true;
        this.nitxtAno.Focus();
        this.nichkCerrarA�o.Visible = false;
        this.nilblMensaje.Text = "";

        this.Session["opcion"] = "eliminar";

        CargarCombos();
    }

    protected void nilblCancelar_Click(object sender, EventArgs e)
    {
        OpcionesDefecto();
    }

    #endregion Eventos





    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
}
