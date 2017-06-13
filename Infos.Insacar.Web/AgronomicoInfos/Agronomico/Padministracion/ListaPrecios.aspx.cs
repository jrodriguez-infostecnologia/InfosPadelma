using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Agronomico_Padministracion_ListaPrecios : System.Web.UI.Page
{

    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cseccion sesion = new Cseccion();
    CListaPrecios listaPrecios = new CListaPrecios();
    CIP ip = new CIP();
    Clineas lineas;
    Cnovedad novedad = new Cnovedad();
    Clotes lotes = new Clotes();
    Cseccion sesionesFinca = new Cseccion();
    Cfinca finca = new Cfinca();


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

            this.gvLista.DataSource = listaPrecios.BuscarEntidad(Convert.ToInt16(this.Session["empresa"]));
            this.gvLista.DataBind();

            gvNovedades.DataSource = null;
            gvNovedades.DataBind();
            gvLista.Visible = true;

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

    private void CargarCombos()
    {
        try
        {
            this.ddlAño.DataSource = lotes.PeriodoAñoAbierto(Convert.ToInt16(Session["empresa"]));
            this.ddlAño.DataValueField = "año";
            this.ddlAño.DataTextField = "año";
            this.ddlAño.DataBind();
            this.ddlAño.Items.Insert(0, new ListItem("Año...", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar año. Correspondiente a: " + ex.Message, "C");
        }



    }

    private void cargarNovedades()
    {
        if (novedad.verificarRegistroPrecio(Convert.ToInt32(ddlAño.SelectedValue.Trim()), (int)this.Session["empresa"]) == 1)
        {
            this.Session["editar"] = true;
        }
        else
        {
            this.Session["editar"] = false;
        }

        if (ddlAño.SelectedValue.Trim().Length > 0)
        {
            gvNovedades.DataSource = novedad.SeleccionaNovedadPrecios((int)this.Session["empresa"], Convert.ToInt32(ddlAño.SelectedValue.Trim()));
            gvNovedades.DataBind();
            gvNovedades.Visible = true;
        }
        else
        {
            gvNovedades.DataSource = null;
            gvNovedades.DataBind();
            gvNovedades.Visible = false;
        }

    }


    #endregion

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
                ddlAño.Focus();

            }
            else
            {
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
            }
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
        if (seguridad.VerificaAccesoOperacion(this.Session["usuario"].ToString(),
                                   ConfigurationManager.AppSettings["Modulo"].ToString(),
                                   nombrePaginaActual(), "I", Convert.ToInt16(Session["empresa"])) == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", "C");
            return;
        }

        gvNovedades.DataSource = null;
        gvNovedades.DataBind();
        gvNovedades.Visible = false;

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(Page.Controls);

        CargarCombos();

        this.nilbNuevo.Visible = false;
        gvNovedades.DataSource = null;
        gvNovedades.DataSource = null;
        this.Session["editar"] = false;

        this.nilblInformacion.Text = "";
    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);

        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();

        this.gvNovedades.DataSource = null;
        this.gvNovedades.DataBind();

        this.nilbNuevo.Visible = true;
        this.nilblInformacion.Text = "";
        this.Session["editar"] = false;
        gvNovedades.DataSource = null;
        gvNovedades.DataBind();
        gvNovedades.Visible = false;
    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        bool validar = false;
        foreach (GridViewRow gvr in gvNovedades.Rows)
        {
            if (((TextBox)gvr.FindControl("txtPrecioTerceros")).Text.Length == 0 || ((TextBox)gvr.FindControl("txtPrecioContratistas")).Text.Length == 0
                || ((TextBox)gvr.FindControl("txtPrecioOtros")).Text.Length == 0)
            {
                validar = true;
            }

        }

        if (validar == true)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        Guardar();


    }


    private void Guardar()
    {
        bool validar = false;
        string operacion = "inserta";
        bool modificado = false;

        try
        {

            operacion = "inserta";

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                modificado = true;
                operacion = "inserta";
                object[] objValoresEliminaDetalle = new object[] { Convert.ToDecimal(ddlAño.SelectedValue.Trim()), (int)this.Session["empresa"] };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("anovedadloteprecio", "elimina", "ppa", objValoresEliminaDetalle))
                {
                    case 1:
                        validar = true;
                        break;
                }
            }

            foreach (GridViewRow r in gvNovedades.Rows)
            {

                decimal precioTerceros = Convert.ToDecimal(((TextBox)r.FindControl("txtPrecioTerceros")).Text);
                decimal precioContratistas = Convert.ToDecimal(((TextBox)r.FindControl("txtPrecioContratistas")).Text);
                decimal precioOtros = Convert.ToDecimal(((TextBox)r.FindControl("txtPrecioOtros")).Text);
                decimal porcentaje = Convert.ToDecimal(((TextBox)r.FindControl("txtPorcentaje")).Text);
                bool baseSueldo = Convert.ToBoolean(((CheckBox)r.FindControl("chkBaseSueldo")).Checked);

                object[] objValores = new object[]{
                                            Convert.ToDecimal( ddlAño.SelectedValue.Trim()),  //@año
                                            baseSueldo, //@baseSueldo
                                              (int) this.Session["empresa"], //@empresa
                                               DateTime.Now, //@fechaRegistro
                                               modificado, //@modificado
                                               r.Cells[0].Text.Trim(), //@novedad
                                               porcentaje, //@porcentaje
                                               precioContratistas, //@precioContratistas
                                               precioTerceros, //@precioDestajo
                                               precioOtros, //@precioOtros
                                               r.RowIndex, //@registro
                                               this.Session["usuario"].ToString() //@usuario           
                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "anovedadloteprecio",
                    operacion,
                    "ppa",
                    objValores))
                {
                    case 1:
                        validar = true;
                        break;
                }


                if (!validar)
                {
                    ManejoExito("Datos insertados satisfactoriamente", operacion.Substring(0, 1).ToUpper());
                }
                else
                {
                    ManejoError("Errores al insertar el registro. Operación no realizada", operacion.Substring(0, 1).ToUpper());

                }
            }


        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }

    }




    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvNovedades.PageIndex = e.NewPageIndex;
        DataView Lote = lotes.SeleccionaLoteDetalle(Convert.ToInt16(this.Session["empresa"]), ddlAño.SelectedValue.Trim());
        gvNovedades.DataSource = Lote;
        gvNovedades.DataBind();

    }






    protected void ddlNovedad_SelectedIndexChanged(object sender, EventArgs e)
    {

        manejoControles();

        verificaRegistros();

    }

    protected void verificaRegistros()
    {



    }
    protected void manejoControles()
    {



    }

    protected void cargarLotes()
    {


    }

    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            CcontrolesUsuario.HabilitarControles(Page.Controls);
            CargarCombos();
            if (gvLista.Rows[gvLista.SelectedIndex].Cells[1].Text != "&nbsp;")
                ddlAño.SelectedValue = gvLista.Rows[gvLista.SelectedIndex].Cells[1].Text.Trim();
            else
                ddlAño.SelectedValue = "";
            cargarNovedades();
            nilbNuevo.Visible = false;
            gvLista.Visible = false;


        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }


    }

    protected void ddlAño_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            cargarNovedades();



        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar novedades debido a : " + ex.Message, "C");

        }
    }
    protected void chkBaseSueldo_CheckedChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow gv in gvNovedades.Rows)
        {
            if ((((CheckBox)gv.FindControl("chkBaseSueldo")).Checked == true))
            {
                ((TextBox)gv.FindControl("txtPrecioTerceros")).Enabled = false;
                ((TextBox)gv.FindControl("txtPrecioContratistas")).Enabled = false; ;
                ((TextBox)gv.FindControl("txtPrecioOtros")).Enabled = false;
                ((TextBox)gv.FindControl("txtPorcentaje")).Enabled = false;
            }
            else
            {
                ((TextBox)gv.FindControl("txtPrecioTerceros")).Enabled = true;
                ((TextBox)gv.FindControl("txtPrecioContratistas")).Enabled = true;
                ((TextBox)gv.FindControl("txtPrecioOtros")).Enabled = true;
                ((TextBox)gv.FindControl("txtPorcentaje")).Enabled = true;

            }
        }
    }
}