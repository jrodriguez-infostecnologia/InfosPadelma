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
using Microsoft.Reporting.WebForms;
using System.Net;
using System.Security.Principal;
using System.Collections.Generic;
using System.Transactions;

public partial class Administracion_Caracterizacion : System.Web.UI.Page
{
    #region Instancias

    Ccatalogo catalogo = new Ccatalogo();
    CtransaccionAlmacen transaccionAlmacen = new CtransaccionAlmacen();
    Ctransaccion transacciones = new Ctransaccion();
    Cperiodos periodos = new Cperiodos();
    Coperadores operador = new Coperadores();

    #endregion Instancias

    #region Metodos

    private void CargaOperarios()
    {
        try
        {


            this.ddlOperario.DataSource = transacciones.GetOperarioConteoFecha(
                this.niCalendarFecha.SelectedDate);
            this.ddlOperario.DataValueField = "operario";
            this.ddlOperario.DataTextField = "operario";
            this.ddlOperario.DataBind();
            this.ddlOperario.Items.Insert(0, new ListItem("Seleccione una opción", ""));
          

             this.ddlOperarioNombre.DataSource = ((DataView)this.ddlOperario.DataSource);
            this.ddlOperarioNombre.DataValueField = "operario";
            this.ddlOperarioNombre.DataTextField = "nombre";
            this.ddlOperarioNombre.DataBind();
            this.ddlOperarioNombre.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar operarios. Correspondiente a: " + ex.Message;
        }
    }

    private void GetOperarios()
    {
        try
        {
            this.gvOperarios.DataSource = transacciones.GetOperarioConteoFecha(
                this.CalendarFechaOperario.SelectedDate);
            this.gvOperarios.DataBind();

           
         }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar operarios. Correspondiente a: " + ex.Message;
        }
    }

    private void GetConteo()
    {
        this.lblMensaje.Text = "";

        try
        {
            if (periodos.RetornaPeriodoCerrado(
                this.niCalendarFecha.SelectedDate.Year.ToString() + this.niCalendarFecha.SelectedDate.Month.ToString().PadLeft(2, '0')) == 1)
            {
                this.lblMensaje.Text = "Periodo Cerrado. No es posible continuar con la operación";
                return;
            }

            this.Session["conteo"] = null;
            this.gvConteo.DataSource = null;
            this.gvConteo.DataBind();

            object[] objKey = new object[] {
                this.ddlBodega.SelectedValue,
                this.niCalendarFecha.SelectedDate,
                this.ddlOperario.SelectedValue
            };

            foreach (DataRowView detalle in CentidadMetodos.EntidadGetKey(
                "iConteoFisico",
                "ppa",
                objKey).Tables[0].DefaultView)
            {
                transaccionAlmacen = new CtransaccionAlmacen(
                    Convert.ToString(detalle.Row.ItemArray.GetValue(4)),
                    Convert.ToString(detalle.Row.ItemArray.GetValue(2)),
                    Convert.ToDecimal(detalle.Row.ItemArray.GetValue(5)));

                List<CtransaccionAlmacen> listaTransaccion = null;

                if (this.Session["conteo"] == null)
                {
                    listaTransaccion = new List<CtransaccionAlmacen>();
                    listaTransaccion.Add(transaccionAlmacen);
                }
                else
                {
                    listaTransaccion = (List<CtransaccionAlmacen>)Session["conteo"];
                    listaTransaccion.Add(transaccionAlmacen);
                }

                this.Session["conteo"] = listaTransaccion;

                this.gvConteo.DataSource = listaTransaccion;
                this.gvConteo.DataBind();
            }
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar conteo. Correspondiente a: " + ex.Message;
        }
    }

  
    private void CargaCombos()
    {
        try
        {
            this.ddlBodega.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("iBodega", "ppa"),
                "descripcion");
            this.ddlBodega.DataValueField = "codigo";
            this.ddlBodega.DataTextField = "descripcion";
            this.ddlBodega.DataBind();
            this.ddlBodega.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar bodegas. Correspondiente a: " + ex.Message;
        }
    }

    private void CargaCombosBG()
    {
        try
        {
            this.ddlBodegaGenera.DataSource = CcontrolesUsuario.OrdenarEntidad(
                CentidadMetodos.EntidadGet("iBodega", "ppa"),
                "descripcion");
            this.ddlBodegaGenera.DataValueField = "codigo";
            this.ddlBodegaGenera.DataTextField = "descripcion";
            this.ddlBodegaGenera.DataBind();
            this.ddlBodegaGenera.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar bodegas. Correspondiente a: " + ex.Message;
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
            if (Cseguridad.VerificaAccesoPagina(
                this.Session["usuario"].ToString(),
                System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString(),
                "InventarioFisico.aspx") != 0)
            {
                if (!IsPostBack)
                {
                    this.Session["conteo"] = null; 
                }
            }
            else
            {
                this.lblMensaje.Text = "Usuario no autorizado para ingresar a esta página";
            }
        }
    }

    protected void lbPapeletas_Click(object sender, EventArgs e)
    {
      
            try
            {
                switch (catalogo.AsignarPapeleta())
                {
                    case 0:
                       
                    //this.lblMensaje.Text = "Papeletas generadas y asignadas correctamente";
                    this.lbFechaGenera.Visible = true;
                    this.lbRegistraGenera.Visible = true;
                    this.ddlBodegaGenera.Visible = true;
                    this.ddlBodegaGenera.Enabled = true;
                    this.Label8.Visible = true;
                    this.lbCancelarGenera.Visible = true;
                    this.txtFechaGenera.Visible = true;
                    CargaCombosBG();
                       break;

                    case 1:

                        this.lblMensaje.Text = "Error al generar y asignar papeletas. Operación no realizada";
                        break;
                }
            }
            catch (Exception ex)
            {
                this.lblMensaje.Text = "Error al generar papeletas. Correspondiente a: " + ex.Message;
            }
        
    }

    protected void lbConteo1_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        if (Cseguridad.VerificaAccesooperacion(
            this.Session["usuario"].ToString(),
            System.Configuration.ConfigurationSettings.AppSettings["Modulo"].ToString(),
            "AsignarConteo",
            "I") == 0)
        {
            this.lblMensaje.Text = "Usuario no autorizado para ejecutar esta opción";
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.calendarGenera.Visible = false;
        this.lbRegistraGenera.Visible = false;
        this.txtFechaGenera.Visible = false;
        this.calendarGenera.Visible = false;
        this.lbCancelarGenera.Visible = false;
        this.ddlBodegaGenera.Visible = false;
        this.Label8.Visible = false;
        this.lbFechaGenera.Visible = false;
        this.lbEstadoInventario.Visible = false;

        this.lbPapeletas.Visible = false;
        this.lbConteo1.Visible = false;
        this.lbDiferencias.Visible = false;
            this.lbFecha.Enabled = true;
        this.lbOperarios.Visible = false;
        this.UpdatePanelOperarios.Visible = false;

        CargaCombos();
    }

    protected void lbFecha_Click(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = true;
        this.txtFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
    }
    protected void CalendarFecha_SelectionChanged(object sender, EventArgs e)
    {
        this.niCalendarFecha.Visible = false;
        this.txtFecha.Visible = true;
        this.txtFecha.Text = this.niCalendarFecha.SelectedDate.ToString();
        this.txtFecha.Enabled = false;

        CargaOperarios();
       // GetConteo();
    }

    protected void txtPapeleta_TextChanged(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

       
    }

   

   

    protected void nilbCancelar_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.lbPapeletas.Visible = true;
        this.lbConteo1.Visible = true;
        this.lbDiferencias.Visible = true;
        this.niCalendarFecha.Visible = false;
        this.nilbCancelar.Visible = false;
        this.nilbRegistrar.Visible = false;
          this.gvConteo.DataSource = null;
        this.gvConteo.DataBind();
        this.Session["conteo"] = null;
        this.lbOperarios.Visible = true;
        this.lbEstadoInventario.Visible = true;
    }

  

    protected void nilbRegistrar_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";
        bool verificacion = true;

        try
        {
            if (periodos.RetornaPeriodoCerrado(
                this.niCalendarFecha.SelectedDate.Year.ToString() + this.niCalendarFecha.SelectedDate.Month.ToString().PadLeft(2, '0')) == 1)
            {
                this.lblMensaje.Text = "Periodo Cerrado. No es posible continuar con la operación";
                return;
            }

            if (this.gvConteo.Rows.Count == 0)
            {
                this.lblMensaje.Text = "Debe registrar por lo menos una papeleta para continuar";
                return;
            }

            if (this.txtFecha.Text.Trim().Length == 0 || this.ddlBodega.SelectedValue.Trim().Length == 0 || 
                this.ddlOperario.SelectedValue.Trim().Length == 0)
            {
                this.lblMensaje.Text = "Campos vacios. Por favor corrija";
                return;
            }

            using (TransactionScope ts = new TransactionScope())
            {


                if (Convert.ToBoolean(this.Session["editar"]) == true)
                {
                    foreach (GridViewRow registro in this.gvConteo.Rows)
                    {
                                                    switch (transacciones.InsertaConteoFisico1(
                                    this.niCalendarFecha.SelectedDate,
                                    this.Session["usuario"].ToString(),
                                    Convert.ToString(registro.Cells[0].Text),
                                    this.ddlBodega.SelectedValue,
                                   Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text),
                                    this.ddlOperario.SelectedValue.Trim()))
                            {
                                case 1:

                                    verificacion = false;
                                    break;
                            }
                        
                    }
                }
                else
                {
                    foreach (GridViewRow registro in this.gvConteo.Rows)
                    {
                        if (((TextBox)registro.Cells[3].FindControl("txtCantidad")).Text.Trim().Length != 0 &&
                          Convert.ToDecimal(((TextBox)registro.Cells[3].FindControl("txtCantidad")).Text.Trim()) != 0)
                        {
                            switch (transacciones.InsertaConteoFisico1(
                                    this.niCalendarFecha.SelectedDate,
                                    this.Session["usuario"].ToString(),
                                    Convert.ToString(registro.Cells[0].Text),
                                    this.ddlBodega.SelectedValue,
                                   Convert.ToDecimal(((TextBox)registro.FindControl("txtCantidad")).Text),
                                    this.ddlOperario.SelectedValue.Trim()))
                            {
                                case 1:

                                    verificacion = false;
                                    break;
                            }
                        }
                    }
                }
             

                if (verificacion == false)
                {
                    this.lblMensaje.Text = "Error al insertar el registro. Operación no realizada";
                }
                else
                {                    
                    CcontrolesUsuario.InhabilitarControles(
                        this.Page.Controls);
                    CcontrolesUsuario.LimpiarControles(
                        this.Page.Controls);

                    this.lbPapeletas.Visible = true;
                    this.lbConteo1.Visible = true;
                    this.lbDiferencias.Visible = true;
                    this.niCalendarFecha.Visible = false;
                    this.nilbCancelar.Visible = false;
                    this.nilbRegistrar.Visible = false;
                    this.gvConteo.DataSource = null;
                    this.gvConteo.DataBind();
                    this.Session["conteo"] = null;
                    this.lblMensaje.Visible = true;
                    this.lblMensaje.Text = "Conteo registrado satisfactoriamente";
                    this.lbOperarios.Visible = true;
                    this.lbEstadoInventario.Visible = true;
                    this.Session["editar"] = false;
                    ts.Complete();
                }
            }
            
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al guardar el registro. Correspondiente a: " + ex.Message;
        }
    }

    protected void ddlBodega_SelectedIndexChanged(object sender, EventArgs e)
    {
               this.ddlBodega.Focus();
    }

    protected void lbDiferencias_Click(object sender, EventArgs e)
    {
        string script = "";

        script = "<script language='javascript'>" +
            "Visualizacion('DiferenciasConteo');" +
            "</script>";

        Page.RegisterStartupScript("Visualizacion", script);
    }

    protected void ddlOperario_SelectedIndexChanged(object sender, EventArgs e)
    {
        //GetConteo();

        this.ddlOperario.Focus();
        this.ddlOperarioNombre.SelectedValue = this.ddlOperario.SelectedValue;
    }

    protected void ddlOperarioNombre_SelectedIndexChanged(object sender, EventArgs e)
    {
        //GetConteo();

        this.ddlOperarioNombre.Focus();
        this.ddlOperario.SelectedValue = this.ddlOperarioNombre.SelectedValue;
    }

    protected void lbOperarios_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

       
        CcontrolesUsuario.HabilitarControles(
            this.UpdatePanelOperarios.Controls);

       
        this.Session["editar"] = false;
        this.lbPapeletas.Visible = false;
        this.lbConteo1.Visible = false;
        this.lbDiferencias.Visible = false;        
        this.lbOperarios.Visible = false;
        this.UpdatePanelOperarios.Visible = true;
        this.nilbNuevoOperario.Visible = true;
        this.lbFechaOperario.Enabled = true;
        this.txtCodigoOperario.Enabled = true;
        this.lbEstadoInventario.Visible = false;
        }

    protected void lbFechaOperario_Click(object sender, EventArgs e)
    {
        this.CalendarFechaOperario.Visible = true;
        this.txtFechaOperario.Visible = false;
        this.CalendarFechaOperario.SelectedDate = Convert.ToDateTime(null);
    }

    protected void CalendarFechaOperario_SelectionChanged(object sender, EventArgs e)
    {
        this.CalendarFechaOperario.Visible = false;
        this.txtFechaOperario.Visible = true;
        this.txtFechaOperario.Text = this.CalendarFechaOperario.SelectedDate.ToString();
        this.txtFechaOperario.Enabled = false;

        GetOperarios();
    }

    protected void nilbCancelarOperarios_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        CcontrolesUsuario.InhabilitarControles(
            this.UpdatePanelOperarios.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.UpdatePanelOperarios.Controls);

        this.lbPapeletas.Visible = true;
        this.lbConteo1.Visible = true;
        this.lbDiferencias.Visible = true;
        this.CalendarFechaOperario.Visible = false;
        this.nilbCancelarOperarios.Visible = false;
        this.nilbRegistrarOperarios.Visible = false;
        this.lbOperarios.Visible = true;
        this.gvOperarios.DataSource = null;
        this.gvOperarios.DataBind();
        this.nilbNuevoOperario.Visible = false;
        this.UpdatePanelOperarios.Visible = false;
        this.lbEstadoInventario.Visible = true;
    }

    protected void nilbRegistrarOperarios_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        string operarion = "inserta";

        try
        {
            

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operarion = "actualiza";
            }

               if (this.txtFechaOperario.Text.Trim().Length == 0 || this.txtCodigoOperario.Text.Trim().Length == 0 ||
                this.txtNombreOperario.Text.Trim().Length == 0 )
                  {
                      this.lblMensaje.Text = "Campos vacios. Por favor corrija";
                      return;
                  }

                  object[] objValores = new object[]{
                this.CalendarFechaOperario.SelectedDate,
                Server.HtmlDecode(this.txtNombreOperario.Text.Trim()),
                Server.HtmlDecode(this.txtCodigoOperario.Text.Trim())             };

                  switch (CentidadMetodos.EntidadInsertUpdateDelete(
               "iConteoOperario",
               operarion,
               "ppa",
               objValores))
                  {
                      case 0:

                          GetOperarios();

                          CcontrolesUsuario.InhabilitarControles(
                              this.UpdatePanelOperarios.Controls);
                          CcontrolesUsuario.LimpiarControles(
                              this.UpdatePanelOperarios.Controls);

                          this.lblMensaje.Text = "Registro guardado satisfactoriamente";
                          this.nilbRegistrarOperarios.Visible = false;
                          this.nilbNuevoOperario.Visible = true;
                          break;

                      case 1:

                          this.lblMensaje.Text = "Error al guardar el registro. operación no realizada";
                          break;
                  }
                  
              

           
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al guardar el registro. Correspondiente a: " + ex.Message;
        }
    }

    protected void nilbNuevoOperario_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        CcontrolesUsuario.HabilitarControles(
            this.UpdatePanelOperarios.Controls);

        this.nilbNuevoOperario.Visible = false;
        this.nilbCancelarOperarios.Visible = true;
        this.nilbRegistrarOperarios.Visible = true;
        this.Session["editar"] = false;
        this.lbFechaOperario.Enabled = true;
        this.txtCodigoOperario.Enabled = true;
       


      
    }

    protected void gvOperarios_SelectedIndexChanged(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        try
        {
            CcontrolesUsuario.HabilitarControles(
                this.UpdatePanelOperarios.Controls);

            this.Session["editar"] = true;
            this.lbFechaOperario.Enabled = false;
            this.txtCodigoOperario.Enabled = false;

            if (this.gvOperarios.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtFechaOperario.Text = this.gvOperarios.SelectedRow.Cells[2].Text;
            }

            if (this.gvOperarios.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                this.txtCodigoOperario.Text = Server.HtmlDecode(this.gvOperarios.SelectedRow.Cells[3].Text);
            }
            else
            {
                this.txtCodigoOperario.Text = "";
            }

            if (this.gvOperarios.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.txtNombreOperario.Text = Server.HtmlDecode(this.gvOperarios.SelectedRow.Cells[4].Text);
            }
            else
            {
                this.txtNombreOperario.Text = "";
            }

              }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar los campos. Correspondiente a: " + ex.Message;
        }
    }

    protected void gvOperarios_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.lblMensaje.Text = "";

        try
        {
            object[] objValores = new object[]{
                Convert.ToDateTime(this.gvOperarios.Rows[e.RowIndex].Cells[2].Text),
                Server.HtmlDecode(this.gvOperarios.Rows[e.RowIndex].Cells[3].Text.Trim())
            };

            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "iConteoOperario",
                "elimina",
                "ppa",
                objValores))
            {
                case 0:

                    this.lblMensaje.Text = "Registro eliminado satisfactoriamente";

                    GetOperarios();
                    break;

                case 1:

                    this.lblMensaje.Text = "Error al eliminar el registro. Operación no realizada";
                    break;
            }
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al eliminar el registro. Correspondiente a: " + ex.Message;
        }
    }

    protected void lbRegistraGenera_Click(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";
        string script = "";

        if (this.txtFechaGenera.Text.Trim().Length == 0 || this.ddlBodegaGenera.SelectedValue.Trim().Length == 0 )
        {
            this.lblMensaje.Text = "Campos vacios. Por favor corrija";
            return;
        }
        else
        {
            try
            { 
            
            switch (catalogo.RegistrarPapeleta(this.calendarGenera.SelectedDate,Convert.ToString(this.Session["usuario"]),
                Convert.ToString(this.ddlBodegaGenera.SelectedValue)))
            {
                case 0:

                    this.lblMensaje.Text = "Papeletas generadas y asignadas correctamente";

                    script = "<script language='javascript'>" +
                        "Visualizacion('ConteoAlmacen');" +
                        "</script>";

                    Page.RegisterStartupScript("Visualizacion", script);
                    this.calendarGenera.Visible = false;
                    this.lbRegistraGenera.Visible = false;
                    this.txtFechaGenera.Visible = false;
                    this.calendarGenera.Visible = false;
                    this.lbCancelarGenera.Visible = false;
                    this.ddlBodegaGenera.Visible = false;
                    this.Label8.Visible = false;
                    this.lbFechaGenera.Visible = false;
                    
                    
                    break;



                case 1:

                    this.lblMensaje.Text = "Error al generar, ya existe el registro con esa fecha. Operación no realizada";

                    CcontrolesUsuario.InhabilitarControles(
                        this.Page.Controls);
                    CcontrolesUsuario.LimpiarControles(
                        this.Page.Controls);
                    break;
            }
            }
 catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al eliminar el registro. Correspondiente a: " + ex.Message;
        }
        
        }
    }

    protected void lbFechaGenera_Click(object sender, EventArgs e)
    {
        this.calendarGenera.Visible = true;
        this.txtFechaGenera.Visible = false;
        this.calendarGenera.SelectedDate = Convert.ToDateTime(null);
    }
    protected void calendarGenera_SelectionChanged(object sender, EventArgs e)
    {
        this.calendarGenera.Visible = false;
        this.txtFechaGenera.Visible = true;
        this.txtFechaGenera.Text = this.calendarGenera.SelectedDate.ToString();
        this.txtFechaGenera.Enabled = false;
    }

    #endregion Eventos      
   
   
    protected void lbCancelarGenera_Click(object sender, EventArgs e)
    {
        this.calendarGenera.Visible = false;
        this.lbRegistraGenera.Visible = false;
        this.txtFechaGenera.Visible = false;
        this.calendarGenera.Visible = false;
        this.lbCancelarGenera.Visible = false;
        this.ddlBodegaGenera.Visible = false;
        this.Label8.Visible = false;
        this.lbFechaGenera.Visible = false;
    }
    protected void txtCantidad_DataBinding(object sender, EventArgs e)
    {
        ((TextBox)sender).Text = CcontrolesUsuario.FormatoCifras(
            Convert.ToDecimal(((TextBox)sender).Text.Trim()));
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
        if (this.txtPapeleta1.Text.Trim().Length == 0 || this.txtPapeleta1.Text.Trim().Length == 0 ||
            this.txtFecha.Text.Trim().Length == 0 || this.ddlBodega.SelectedValue.Trim().Length == 0            )
        {
            this.lblMensaje.Text = "Campos vacios de papeletas, por favor corrija";
            return;
        }
        this.Session["editar"] = false;
        this.gvConteo.DataSource = catalogo.GetBuscarConteofisico(this.niCalendarFecha.SelectedDate,
            Convert.ToString(this.ddlBodega.SelectedValue),this.txtPapeleta1.Text,this.txtPapeleta2.Text           
            );
        this.gvConteo.DataBind();
       
    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        
        if (this.txtPapeleta1.Text.Trim().Length == 0 || this.txtPapeleta1.Text.Trim().Length == 0 ||
            this.txtFecha.Text.Trim().Length == 0 || this.ddlBodega.SelectedValue.Trim().Length == 0)
        {
            this.lblMensaje.Text = "Campos vacios de papeletas, por favor corrija";
            return;
        }
        this.Session["editar"] = true;
        this.gvConteo.DataSource = catalogo.GetBuscarConteofisicoEditar(this.niCalendarFecha.SelectedDate,
            Convert.ToString(this.ddlBodega.SelectedValue),this.txtPapeleta1.Text,this.txtPapeleta2.Text           
            );
        this.gvConteo.DataBind();

    }
    protected void gvConteo_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void lbEstadoInventario_Click(object sender, EventArgs e)
    {
        string script = "";

        script = "<script language='javascript'>" +
            "Visualizacion('EstadoInventario');" +
            "</script>";

        Page.RegisterStartupScript("Visualizacion", script);
    }
}
