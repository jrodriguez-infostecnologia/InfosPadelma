using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;
using System.Data;
using System.Transactions;
public partial class Inicio : System.Web.UI.Page
{


    #region Instancias

    cMenu menu = new cMenu();
    Cvehiculos vehiculos = new Cvehiculos();
    Canalisis analisis = new Canalisis();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();

    #endregion Instancias

    private void CargaCombos()
    {
        try
        {
            this.ddlBodega.DataSource = vehiculos.SeleccionaBodegaTipo(ConfigurationManager.AppSettings["tipomov"].ToString(), Convert.ToInt16(Session["empresa"]));
            this.ddlBodega.DataValueField = "codigo";
            this.ddlBodega.DataTextField = "descripcion";
            this.ddlBodega.DataBind();
            this.ddlBodega.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
        }
        catch
        {
            this.lblMensaje.Text = "Error al cargar bodegas";
        }
    }

    private void CargaProducto()
    {
        try
        {
            DataView producto = vehiculos.GetProductoTransaccion(
               ConfigurationManager.AppSettings["tipomov"].ToString(), Convert.ToInt16(this.Session["empresa"]));
            this.ddlProducto.DataSource = producto;
            this.ddlProducto.DataValueField = "producto";
            this.ddlProducto.DataTextField = "descripcion";
            this.ddlProducto.DataBind();
            this.ddlProducto.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
        }
        catch (Exception ex)
        {
            this.lblMensaje.Text = "Error al cargar productos. Correspondiente a: " + ex.Message;
        }


    }


    protected void Page_Load(object sender, EventArgs e)
    {


        Session["usuario"] = Convert.ToString(Request.QueryString["usuario"]);
        Session["empresa"] = Convert.ToInt16(Request.QueryString["empresa"]);
        Session["clave"] = Convert.ToString(Request.QueryString["clave"]);


   

        if (this.Session["usuario"] == null)
        {
            if (this.Parent != null)
            {
                this.Parent.Page.Response.Redirect("~/Inicio.aspx");
            }
            else
            {
                this.Response.Redirect("~/Inicio.aspx");
            }
        }
        else
        {

            try
            {


                this.lbUsuario.Text = this.Session["usuario"].ToString();
                this.lbNombreUsuario.Text = menu.RetornaNombreUsuario(
                    this.Session["usuario"].ToString());

                if (Session["empresa"] == null)
                {
                    Session["empresa"] = menu.RetornaCodigoEmpresaUsuario(
                    this.Session["usuario"].ToString());
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(
                       Convert.ToInt16(this.Session["empresa"].ToString()));
                }
                else
                {
                    this.lbEmpresa.Text = menu.RetornaNombreEmpresa(
                       Convert.ToInt16(this.Session["empresa"]));
                }
                if (!IsPostBack)
                {
                    CargaProducto();
                }
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Error al cargar el menu. Correspondiente a: " + ex.Message;
            }
        }
    }

    protected void btnSiguiente_Click(object sender, ImageClickEventArgs e)
    {
        this.lblMensaje.Text = "";

        if (this.txtRemision.Text.Trim().Length == 0 || ddlProducto.SelectedValue.Length == 0)
        {
            this.lblMensaje.Text = "Campos vacios por favor corrija";
        }
        else
        {
            if (vehiculos.VerificaRemision(this.txtRemision.Text,
                Convert.ToInt16(ddlProducto.SelectedValue),
                Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.lblMensaje.Text = "Remisión no valida";
                this.txtRemision.Text = "";
            }
            else
            {
                this.pRemision.Visible = false;
                this.pBodega.Visible = true;

                CargaCombos();
            }
        }
    }

    protected void btnRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        string numero = "";

        bool resultados = false;

        this.lblMensajeTotal.Text = "";

        try
        {

            foreach (GridViewRow registro in this.gvLista.Rows)
            {
                if (((TextBox)registro.FindControl("txtResultado")).Text.Length == 0)
                {
                    resultados = true;
                }
                try
                {
                    Convert.ToDecimal(((TextBox)registro.FindControl("txtResultado")).Text);
                }
                catch (Exception ex)
                {
                    lblMensajeTotal.Text = "Solo numeros";
                    return;
                }

            }


            if (resultados == true)
            {
                lblMensajeTotal.Text = "Ingrese porcentajes";
                return;
            }


            foreach (DataRowView registro in vehiculos.GetBasculaRemision(
                this.txtRemision.Text, Convert.ToInt16(Session["empresa"])))
            {
                numero = Convert.ToString(registro.Row.ItemArray.GetValue(2));
            }



            using (TransactionScope ts = new TransactionScope())
            
                try
                {

                    string usuario = this.Session["usuario"].ToString();
                    string coperativa = rblCooperativa.SelectedValue;



                    if (usuario==null){
                        usuario="tarima";
                    }

                    if (coperativa==null){
                    coperativa="";
                    }

                    switch (vehiculos.RegistroAnalisis(
              ConfigurationManager.AppSettings["tipomov"].ToString(),
              numero,
              ddlProducto.SelectedValue,
              usuario,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              0,
              Convert.ToString(this.ddlBodega.SelectedValue),
              Convert.ToInt16(Session["empresa"]),
             coperativa,
              0))
                    {
                        case 1:

                            this.lblMensajeTotal.Text = "Error al insertar los análisis";
                            break;
                    }



                    foreach (GridViewRow registro in this.gvLista.Rows)
                    {
                        object[] objValores = new object[] {                           
                            registro.Cells[0].Text,
                            Convert.ToInt16(Session["empresa"]),
                            DateTime.Now,
                           numero,
                            ConfigurationManager.AppSettings["tipomov"].ToString().Trim(),
                            this.Session["usuario"],
                            ((TextBox)registro.FindControl("txtResultado")).Text.Replace(",","")
                        };

                        if (CentidadMetodos.EntidadInsertUpdateDelete(
                            "lRegistroAnalisis",
                            "inserta",
                            "ppa",
                            objValores) == 1)
                        {
                            this.lblMensajeTotal.Text = "Error al insertar los análisis. Operación no realizada";
                            return;
                        }
                    }


                    switch (vehiculos.ActualizaEstadoBascula(
                         ConfigurationManager.AppSettings["tipomov"].ToString().Trim(),
                        numero,
                        "AR",
                        "",
                        Convert.ToInt16(Session["empresa"])))
                    {
                        case 0:

                            CcontrolesUsuario.LimpiarControles(
                                this.Page.Controls);

                            this.gvLista.DataSource = null;
                            this.gvLista.DataBind();

                            lblMensajeFinal.Text = "Análisis registrados satisfactoriamente";
                            pFinal.Visible = true;
                            ts.Complete();
                            pBodega.Visible = false;
                            pRemision.Visible = false;
                            pTotal.Visible = false;
                            pFinal.Visible = true;
                            break;

                        case 1:

                            this.lblMensajeTotal.Text = "Error al actualizar el estado del vehículo en báscula";
                            break;
                    }
                }
                catch (Exception ex)
                {
                    this.lblMensajeTotal.Text = "Error al insertar el registro. Correspondiente a: " + ex.Message;
                }
            }

        
        catch (Exception ex)
        {
            this.lblMensajeTotal.Text = "Error al insertar el registro. Correspondiente a: " + ex.Message;
        }




    }
    protected void btnTotalAtras_Click(object sender, ImageClickEventArgs e)
    {
        this.lblMensajeTotal.Text = "";
        this.pTotal.Visible = false;
        this.pBodega.Visible = true;

    }


    protected void txtRemision_TextChanged1(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        try
        {
            if (vehiculos.VerificaRemision(
                this.txtRemision.Text,
                Convert.ToInt16(ddlProducto.SelectedValue),
                Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.lblMensaje.Text = "Remisión no valida";
                this.txtRemision.Text = "";
                this.lblVehiculo.Text = "";
            }
            else
            {

                foreach (DataRowView registro in vehiculos.RetornaDatosVehiculoRemision(
                    this.txtRemision.Text, Convert.ToInt16(Session["empresa"])))
                {
                    this.lblVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
                    this.lblConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                    this.lblFinca.Text = Convert.ToString(registro.Row.ItemArray.GetValue(7));
                }
            }
        }
        catch
        {
            this.lblMensaje.Text = "Error al valida la remisión";
        }
    }

    protected void imbPrincipal_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect(menu.SeleccionaMenuPrincipal(this.Session["usuario"].ToString(), this.Session["clave"].ToString(), Convert.ToInt16(this.Session["empresa"])));
    }
    protected void btnSiguienteBodega_Click(object sender, ImageClickEventArgs e)
    {

        pTotal.Visible = true;
        pBodega.Visible = false;

        try
        {
            this.gvLista.DataSource = analisis.GetAnalisisProducto(ddlProducto.SelectedValue.Trim(), Convert.ToInt16(Session["empresa"]));
            this.gvLista.DataBind();
        }
        catch (Exception ex)
        {
            lblMensajeTotal.Text = "Error al cargar los análisis asociados al producto. Correspondiente a: " + ex.Message;
        }
        
    }
    protected void btnAtrasBodega_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        pRemision.Visible = true;
        Response.Redirect("~/Inicio.aspx");
    }
}