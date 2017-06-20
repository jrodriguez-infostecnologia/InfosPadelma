using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Logistica_Pprogrmacion_ProgramacionGeneral : System.Web.UI.Page
{
    #region Instancias

    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    Cprogramacion programacion = new Cprogramacion();
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

            try
            {
                DataView dvProgramaciones = new DataView();
                DataTable dtProgramaciones = new DataTable();
                DataColumn dtColumnCol = new DataColumn();
                DataRow row = dtProgramaciones.NewRow();

                swBiocosta.swBiocosta programacionBI = new swBiocosta.swBiocosta();

                dvProgramaciones = programacionBI.programacionActivasPlanta(
                   ConfigurationManager.AppSettings["UsuarioBi"].ToString(),
                    ConfigurationManager.AppSettings["ClaveBi"].ToString(),
                    Convert.ToDateTime(niTxtFechaI.Text),
                    Convert.ToDateTime(niTxtFechaF.Text)
                ).Tables[0].DefaultView;

                dtProgramaciones = dvProgramaciones.ToTable();

                for (int x = 0; x < dtProgramaciones.Rows.Count; x++)
                {

                    if (programacion.VerificaProgramacionEnPlanta(dtProgramaciones.Rows[x].ItemArray.GetValue(0).ToString(), (int)this.Session["empresa"]) == 1)
                    {
                        dtProgramaciones.Rows.RemoveAt(x);
                        x = 0;
                    }

                }

                if (dtProgramaciones.Rows.Count > 0)
                {
                    this.gvLista.DataSource = dtProgramaciones;
                    this.gvLista.DataBind();
                }
                else
                {
                    this.nilblInformacion.Text = "no se encontraron registros";
                }
            }
            catch (Exception ex)
            {
                ManejoError(ex.Message, "C");
            }

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

        this.Response.Redirect("~/Logistica/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);


        seguridad.InsertaLog(
            this.Session["usuario"].ToString(),
            operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex",
            mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
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
                if (!IsPostBack)
                {
                    niTxtFechaF.Text = DateTime.Now.ToShortDateString();
                    niTxtFechaI.Text = niTxtFechaF.Text;
                }

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

        this.nilblInformacion.Text = "";
    }



    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            if (niTxtFechaI.Text.Trim().Length == 0 || niTxtFechaF.Text.Trim().Length == 0)
            {
                nilblInformacion.Text = "Campos de fechas vacias por favor corrija";
                return;
            }

            try
            {
                Convert.ToDateTime(niTxtFechaF.Text);
                Convert.ToDateTime(niTxtFechaI.Text);
            }
            catch
            {
                nilblInformacion.Text = "Formato de fecha no valida";
                return;
            }

            GetEntidad();
        }
        catch (Exception a)
        {
            nilblInformacion.Text = "Error al cargar programaciones debido a:   " + a.Message;
        }
    }



    protected void nilblRegresar_Click(object sender, ImageClickEventArgs e)
    {
        this.Response.Redirect("~/Logistica/Pprogramacion/Programacion.aspx");
    }
    #endregion Eventos


    protected void niLbFechaInicial_Click(object sender, EventArgs e)
    {
        this.CalendarInicial.Visible = true;
        this.niTxtFechaI.Visible = false;
        this.CalendarInicial.SelectedDate = Convert.ToDateTime(null);
    }
    protected void niLbFechaFinal_Click(object sender, EventArgs e)
    {
        this.CalendarFinal.Visible = true;
        this.niTxtFechaF.Visible = false;
        this.CalendarFinal.SelectedDate = Convert.ToDateTime(null);
    }
    protected void CalendarInicial_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarInicial.Visible = false;
        this.niTxtFechaI.Visible = true;
        this.niTxtFechaI.Text = this.CalendarInicial.SelectedDate.ToString();
    }
    protected void CalendarFinal_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFinal.Visible = false;
        this.niTxtFechaF.Visible = true;
        this.niTxtFechaF.Text = this.CalendarFinal.SelectedDate.ToString();

    }

}