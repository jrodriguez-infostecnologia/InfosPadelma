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

    
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    CparametrosAno parametrosaño = new CparametrosAno();


    Ccargos cargos = new Ccargos();

    #endregion Instancias

    #region Metodos


    private void Guardar()
    {
        string operacion = "inserta";

        try
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
                operacion = "actualiza";

            object[] objValores = new object[]{          
                Convert.ToInt16(Session["empresa"]),
                txtFecha.Text
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete("nFestivo", operacion, "ppa", objValores))
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

            this.gvLista.DataSource = parametrosaño.BuscarEntidadFestivos(nitxtBusqueda.Text, Convert.ToInt16(Session["empresa"]));
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

        this.Response.Redirect("~/Nomina/Error.aspx", false);
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


    private void EntidadKey()
    {
        object[] objKey = new object[] { Convert.ToInt16(Session["empresa"]), this.txtFecha.Text };
        try
        {
            if (CentidadMetodos.EntidadGetKey("nFestivo", "ppa", objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "fecha " + this.txtFecha.Text + " ya se encuentra registrado";
                CcontrolesUsuario.InhabilitarControles(this.Page.Controls);
                this.nilbNuevo.Visible = true;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al validar la llave primaria correspondiente a: " + ex.Message, "C");
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
                txtFecha.Focus();

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
        }
    }


    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.CalendarFecha.Visible = true;
        //this.txtFecha.Visible = false;
        this.CalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }

    protected void txtFechaIngreso_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }

    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.nilblInformacion.Text = "";
        this.CalendarFecha.Visible = false;
        this.txtFecha.Text = this.CalendarFecha.SelectedDate.ToString();
        EntidadKey();
    }

    protected void lbGenerar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            parametrosaño.GeneraDominicales(
                 this.txtAno.Text,
                Convert.ToInt16(Session["empresa"]));

            ManejoExito("Registros generados", "I");
            GetEntidad();
        }
        catch (Exception ex)
        {
            ManejoError("Error al generar los dominicales del año seleccionado. Correspondiente a: " + ex.Message, "I");
        }

    }


    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {

    }

    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             "E",//operacion
                            Convert.ToInt16(this.Session["empresa"]))//empresa
                            == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "E");
            return;
        }


        string operacion = "elimina";

        try
        {
            object[] objValores = new object[] { 
                Convert.ToInt16(this.Session["empresa"]),
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[1].Text),                
                };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "nFestivo",
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
        catch (Exception ex)
        {
            ManejoError("Error al eliminar los datos correspondiente a: " + ex.Message, "E");
        }

    }


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;

        GetEntidad();

    }


    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                         this.Session["usuario"].ToString(),//usuario
                          ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                          nombrePaginaActual(),//pagina
                         "I",//operacion
                        Convert.ToInt16(this.Session["empresa"]))//empresa
                        == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "I");
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

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
        CalendarFecha.Visible = false;
    }


    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }

    protected void gvLista_PageIndexChanging1(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }

    #endregion Eventos















}
