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

public partial class Nomina_Paminidtracion_ParametrosGeneral : System.Web.UI.Page
{
    #region Instancias


    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CparametrosGeneral parametros = new CparametrosGeneral();
    CIP ip = new CIP();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();

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
            if (parametros.BuscarEntidad(Convert.ToInt16(Session["empresa"])).Table.Rows.Count > 0)
            {
                Session["Editar"] = true;

                foreach (DataRowView r in parametros.BuscarEntidad(Convert.ToInt16(Session["empresa"])))
                {
                  ddlEntradas.SelectedValue   = r.Row.ItemArray.GetValue(1).ToString();			//	entradas
                    ddlEntradasAlt.SelectedValue   = r.Row.ItemArray.GetValue(2).ToString();			//	entradasAlt
                    ddlSalidas.SelectedValue   = r.Row.ItemArray.GetValue(3).ToString();			//	salidas
                    ddlSalidasAlt.SelectedValue   = r.Row.ItemArray.GetValue(4).ToString();			//	salidasAlt
                    ddlPesajes.SelectedValue   = r.Row.ItemArray.GetValue(5).ToString();			//	pesajes
                    ddlPesajesAlt.SelectedValue =  r.Row.ItemArray.GetValue(6).ToString();			//	pesajesAlt
                    ddlFrutaPalma.SelectedValue = r.Row.ItemArray.GetValue(7).ToString();			//	fruta
                    ddlFrutaPalmaAlt.SelectedValue = r.Row.ItemArray.GetValue(8).ToString();			//	frutaAlt
                    ddlAlmendra.SelectedValue = r.Row.ItemArray.GetValue(9).ToString();			//	almendra
                    ddlAlmendraAlt.SelectedValue = r.Row.ItemArray.GetValue(10).ToString();			//	almedraAlt
                    ddlNuez.SelectedValue = r.Row.ItemArray.GetValue(11).ToString();			//	nuez
                    ddlNuezAlt.SelectedValue = r.Row.ItemArray.GetValue(12).ToString();			//	nuezAlt
                    ddlAceitePalma.SelectedValue = r.Row.ItemArray.GetValue(13).ToString();			//	crudo
                    ddlAceitePalmaAlt.SelectedValue = r.Row.ItemArray.GetValue(14).ToString();			//	crudoAlt
                    ddlAceiteCrudoPalmiste.SelectedValue = r.Row.ItemArray.GetValue(15).ToString();			//	palmiste
                    ddlAceiteCrudoPalmisteAlt.SelectedValue = r.Row.ItemArray.GetValue(16).ToString();			//	palmisteAlt
                    ddlAceitePalmisteBlanqueado.SelectedValue = r.Row.ItemArray.GetValue(17).ToString();			//	blanqueado
                    ddlAceitePalmisteBlanqueadoAlt.SelectedValue = r.Row.ItemArray.GetValue(18).ToString();			//	blanqueadoAlt
                    ddlCascarilla.SelectedValue = r.Row.ItemArray.GetValue(19).ToString();			//	cascarilla
                    ddlCascarillaAlt.SelectedValue = r.Row.ItemArray.GetValue(20).ToString();			//	cascarillaAlt
                    ddlTorta.SelectedValue = r.Row.ItemArray.GetValue(21).ToString();			//	torta
                    ddlTortaAlt.SelectedValue = r.Row.ItemArray.GetValue(22).ToString();			//	tortaAlt
                    ddlRaquiz.SelectedValue = r.Row.ItemArray.GetValue(23).ToString();			//	raquiz
                    ddlRaquizAlt.SelectedValue = r.Row.ItemArray.GetValue(24).ToString();			//	raquizAlt
                    ddlRaquizPrensado.SelectedValue = r.Row.ItemArray.GetValue(25).ToString();			//	raquizPrensado
                    ddlRaquizPrensadoAlt.SelectedValue = r.Row.ItemArray.GetValue(26).ToString();			//	raquizPrensadoAlt
                    ddlFibra.SelectedValue = r.Row.ItemArray.GetValue(27).ToString();			//	fibra
                    ddlFibraAlt.SelectedValue = r.Row.ItemArray.GetValue(28).ToString();			//	fibraAlt
                    ddlTiquete.SelectedValue = r.Row.ItemArray.GetValue(29).ToString();			//	tiquete
                    ddlTiqueteAlt.SelectedValue = r.Row.ItemArray.GetValue(30).ToString();			//	tiqueteAlt
                    ddlOrdenEnvio.SelectedValue = r.Row.ItemArray.GetValue(31).ToString();			//	ordenEnvio
                    ddlOrdenEnvioAlt.SelectedValue = r.Row.ItemArray.GetValue(32).ToString();			//	ordenEnvioAlt
                    ddlRemComer.SelectedValue = r.Row.ItemArray.GetValue(33).ToString();			//	remisionComer
                    ddlRemComerAlt.SelectedValue = r.Row.ItemArray.GetValue(34).ToString();			//	remisionComerAlt
                    ddlRemInterna.SelectedValue = r.Row.ItemArray.GetValue(35).ToString();			//	remisionInt
                    ddlRemInternaAlt.SelectedValue = r.Row.ItemArray.GetValue(36).ToString();			//	remisionIntAlt
                    ddlOrdenSalida.SelectedValue = r.Row.ItemArray.GetValue(37).ToString();			//	ordenSalida
                    ddlOrdenSalidaAlt.SelectedValue = r.Row.ItemArray.GetValue(38).ToString();			//	ordenSalidaAlt
                    ddlAnulado.SelectedValue = r.Row.ItemArray.GetValue(39).ToString();   // anulado
                    ddlAnuladoAlt.SelectedValue = r.Row.ItemArray.GetValue(40).ToString();  //anuladoAlt
                    ddlFrutaDura.SelectedValue = r.Row.ItemArray.GetValue(41).ToString();  //frutaDura
                    ddlFrutaDuraAlt.SelectedValue = r.Row.ItemArray.GetValue(42).ToString();  //frutaDuraAlt
                    ddlFrutaTenera.SelectedValue = r.Row.ItemArray.GetValue(43).ToString();  //frutaTenera
                    ddlFrutaTeneraAlt.SelectedValue = r.Row.ItemArray.GetValue(44).ToString();  //frutaTeneraAlt
                    ddlAGL.SelectedValue = r.Row.ItemArray.GetValue(45).ToString();  //agl
                    ddlAGLAlt.SelectedValue = r.Row.ItemArray.GetValue(46).ToString();  //aglAlt
                    ddlH.SelectedValue = r.Row.ItemArray.GetValue(47).ToString();  //humedad
                    ddlHAlt.SelectedValue = r.Row.ItemArray.GetValue(48).ToString();  //humedadAlt
                    ddlI.SelectedValue = r.Row.ItemArray.GetValue(49).ToString();  //impurezas
                    ddlIAlt.SelectedValue = r.Row.ItemArray.GetValue(50).ToString(); //impurezasAlt

                }
            }
            else
            {
                Session["Editar"] = false;
            }


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

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblInformacion.Text = mensaje;

        GetEntidad();

        seguridad.InsertaLog(this.Session["usuario"].ToString(), operacion,
            ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
            "ex", mensaje, ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));


    }
    private void CargarCombos()
    {

        try
        {
            this.ddlEntradas.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlEntradas.DataValueField = "codigo";
            this.ddlEntradas.DataTextField = "descripcion";
            this.ddlEntradas.DataBind();
            this.ddlEntradas.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción entradas. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlEntradasAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlEntradasAlt.DataValueField = "codigo";
            this.ddlEntradasAlt.DataTextField = "descripcion";
            this.ddlEntradasAlt.DataBind();
            this.ddlEntradasAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción entradas alternas. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlSalidas.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSalidas.DataValueField = "codigo";
            this.ddlSalidas.DataTextField = "descripcion";
            this.ddlSalidas.DataBind();
            this.ddlSalidas.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción salidas. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlSalidasAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlSalidasAlt.DataValueField = "codigo";
            this.ddlSalidasAlt.DataTextField = "descripcion";
            this.ddlSalidasAlt.DataBind();
            this.ddlSalidasAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción salidas alternas. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPesajes.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPesajes.DataValueField = "codigo";
            this.ddlPesajes.DataTextField = "descripcion";
            this.ddlPesajes.DataBind();
            this.ddlPesajes.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción pesajes. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlPesajesAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlPesajesAlt.DataValueField = "codigo";
            this.ddlPesajesAlt.DataTextField = "descripcion";
            this.ddlPesajesAlt.DataBind();
            this.ddlPesajesAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción pesajes alterno. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlFrutaPalma.DataSource = items;
            this.ddlFrutaPalma.DataValueField = "codigo";
            this.ddlFrutaPalma.DataTextField = "descripcion";
            this.ddlFrutaPalma.DataBind();
            this.ddlFrutaPalma.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fruta. Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlFrutaPalmaAlt.DataSource = items;
            this.ddlFrutaPalmaAlt.DataValueField = "codigo";
            this.ddlFrutaPalmaAlt.DataTextField = "descripcion";
            this.ddlFrutaPalmaAlt.DataBind();
            this.ddlFrutaPalmaAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fruta alterno. Correspondiente a: " + ex.Message, "C");
        }



        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAlmendra.DataSource = items;
            this.ddlAlmendra.DataValueField = "codigo";
            this.ddlAlmendra.DataTextField = "descripcion";
            this.ddlAlmendra.DataBind();
            this.ddlAlmendra.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items almendra . Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAlmendraAlt.DataSource = items;
            this.ddlAlmendraAlt.DataValueField = "codigo";
            this.ddlAlmendraAlt.DataTextField = "descripcion";
            this.ddlAlmendraAlt.DataBind();
            this.ddlAlmendraAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fruta alterno. Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlNuez.DataSource = items;
            this.ddlNuez.DataValueField = "codigo";
            this.ddlNuez.DataTextField = "descripcion";
            this.ddlNuez.DataBind();
            this.ddlNuez.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items nuez . Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlNuezAlt.DataSource = items;
            this.ddlNuezAlt.DataValueField = "codigo";
            this.ddlNuezAlt.DataTextField = "descripcion";
            this.ddlNuezAlt.DataBind();
            this.ddlNuezAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items nuez alterna . Correspondiente a: " + ex.Message, "C");
        }



        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAceitePalma.DataSource = items;
            this.ddlAceitePalma.DataValueField = "codigo";
            this.ddlAceitePalma.DataTextField = "descripcion";
            this.ddlAceitePalma.DataBind();
            this.ddlAceitePalma.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items aceite crudo de palma . Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAceitePalmaAlt.DataSource = items;
            this.ddlAceitePalmaAlt.DataValueField = "codigo";
            this.ddlAceitePalmaAlt.DataTextField = "descripcion";
            this.ddlAceitePalmaAlt.DataBind();
            this.ddlAceitePalmaAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items aceite crudo de palma . Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAceiteCrudoPalmiste.DataSource = items;
            this.ddlAceiteCrudoPalmiste.DataValueField = "codigo";
            this.ddlAceiteCrudoPalmiste.DataTextField = "descripcion";
            this.ddlAceiteCrudoPalmiste.DataBind();
            this.ddlAceiteCrudoPalmiste.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items aceite crudo de palmiste  . Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAceiteCrudoPalmisteAlt.DataSource = items;
            this.ddlAceiteCrudoPalmisteAlt.DataValueField = "codigo";
            this.ddlAceiteCrudoPalmisteAlt.DataTextField = "descripcion";
            this.ddlAceiteCrudoPalmisteAlt.DataBind();
            this.ddlAceiteCrudoPalmisteAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items aceite crudo de palmiste alterno  . Correspondiente a: " + ex.Message, "C");
        }



        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAceitePalmisteBlanqueado.DataSource = items;
            this.ddlAceitePalmisteBlanqueado.DataValueField = "codigo";
            this.ddlAceitePalmisteBlanqueado.DataTextField = "descripcion";
            this.ddlAceitePalmisteBlanqueado.DataBind();
            this.ddlAceitePalmisteBlanqueado.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items aceite crudo de blanqueado  . Correspondiente a: " + ex.Message, "C");
        }


        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlAceitePalmisteBlanqueadoAlt.DataSource = items;
            this.ddlAceitePalmisteBlanqueadoAlt.DataValueField = "codigo";
            this.ddlAceitePalmisteBlanqueadoAlt.DataTextField = "descripcion";
            this.ddlAceitePalmisteBlanqueadoAlt.DataBind();
            this.ddlAceitePalmisteBlanqueadoAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items aceite crudo de blanqueado alterno . Correspondiente a: " + ex.Message, "C");
        }

        try
        {

            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlCascarilla.DataSource = items;
            this.ddlCascarilla.DataValueField = "codigo";
            this.ddlCascarilla.DataTextField = "descripcion";
            this.ddlCascarilla.DataBind();
            this.ddlCascarilla.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items cascarilla  . Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlCascarillaAlt.DataSource = items;
            this.ddlCascarillaAlt.DataValueField = "codigo";
            this.ddlCascarillaAlt.DataTextField = "descripcion";
            this.ddlCascarillaAlt.DataBind();
            this.ddlCascarillaAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items cascarilla  alterna . Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlTorta.DataSource = items;
            this.ddlTorta.DataValueField = "codigo";
            this.ddlTorta.DataTextField = "descripcion";
            this.ddlTorta.DataBind();
            this.ddlTorta.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items torta . Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlTortaAlt.DataSource = items;
            this.ddlTortaAlt.DataValueField = "codigo";
            this.ddlTortaAlt.DataTextField = "descripcion";
            this.ddlTortaAlt.DataBind();
            this.ddlTortaAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items torta alterna. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlRaquiz.DataSource = items;
            this.ddlRaquiz.DataValueField = "codigo";
            this.ddlRaquiz.DataTextField = "descripcion";
            this.ddlRaquiz.DataBind();
            this.ddlRaquiz.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items raquiz . Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlRaquizAlt.DataSource = items;
            this.ddlRaquizAlt.DataValueField = "codigo";
            this.ddlRaquizAlt.DataTextField = "descripcion";
            this.ddlRaquizAlt.DataBind();
            this.ddlRaquizAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items raquiz  alterno. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlRaquizPrensado.DataSource = items;
            this.ddlRaquizPrensado.DataValueField = "codigo";
            this.ddlRaquizPrensado.DataTextField = "descripcion";
            this.ddlRaquizPrensado.DataBind();
            this.ddlRaquizPrensado.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items raquiz  prensado. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlRaquizPrensadoAlt.DataSource = items;
            this.ddlRaquizPrensadoAlt.DataValueField = "codigo";
            this.ddlRaquizPrensadoAlt.DataTextField = "descripcion";
            this.ddlRaquizPrensadoAlt.DataBind();
            this.ddlRaquizPrensadoAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items raquiz  prensado alterno. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlFibra.DataSource = items;
            this.ddlFibra.DataValueField = "codigo";
            this.ddlFibra.DataTextField = "descripcion";
            this.ddlFibra.DataBind();
            this.ddlFibra.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fribra. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'P' ";
            this.ddlFibraAlt.DataSource = items;
            this.ddlFibraAlt.DataValueField = "codigo";
            this.ddlFibraAlt.DataTextField = "descripcion";
            this.ddlFibraAlt.DataBind();
            this.ddlFibraAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fribra alterno. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlTiquete.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlTiquete.DataValueField = "codigo";
            this.ddlTiquete.DataTextField = "descripcion";
            this.ddlTiquete.DataBind();
            this.ddlTiquete.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción tiquete. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlTiqueteAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlTiqueteAlt.DataValueField = "codigo";
            this.ddlTiqueteAlt.DataTextField = "descripcion";
            this.ddlTiqueteAlt.DataBind();
            this.ddlTiqueteAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción tiquete alterno. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlOrdenEnvio.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlOrdenEnvio.DataValueField = "codigo";
            this.ddlOrdenEnvio.DataTextField = "descripcion";
            this.ddlOrdenEnvio.DataBind();
            this.ddlOrdenEnvio.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo de transación  orden de envio. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlOrdenEnvioAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlOrdenEnvioAlt.DataValueField = "codigo";
            this.ddlOrdenEnvioAlt.DataTextField = "descripcion";
            this.ddlOrdenEnvioAlt.DataBind();
            this.ddlOrdenEnvioAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo de transación  orden de envio alterno. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlRemComer.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlRemComer.DataValueField = "codigo";
            this.ddlRemComer.DataTextField = "descripcion";
            this.ddlRemComer.DataBind();
            this.ddlRemComer.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo de transación  remisión comercizalidora. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlRemComerAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlRemComerAlt.DataValueField = "codigo";
            this.ddlRemComerAlt.DataTextField = "descripcion";
            this.ddlRemComerAlt.DataBind();
            this.ddlRemComerAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo de transación  remisión comercizalidora alterna. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlRemInterna.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlRemInterna.DataValueField = "codigo";
            this.ddlRemInterna.DataTextField = "descripcion";
            this.ddlRemInterna.DataBind();
            this.ddlRemInterna.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción remisión interna. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlRemInternaAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlRemInternaAlt.DataValueField = "codigo";
            this.ddlRemInternaAlt.DataTextField = "descripcion";
            this.ddlRemInternaAlt.DataBind();
            this.ddlRemInternaAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción remisión interna alterna. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlOrdenSalida.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlOrdenSalida.DataValueField = "codigo";
            this.ddlOrdenSalida.DataTextField = "descripcion";
            this.ddlOrdenSalida.DataBind();
            this.ddlOrdenSalida.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción orden de salida. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            this.ddlOrdenSalidaAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlOrdenSalidaAlt.DataValueField = "codigo";
            this.ddlOrdenSalidaAlt.DataTextField = "descripcion";
            this.ddlOrdenSalidaAlt.DataBind();
            this.ddlOrdenSalidaAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción orden de salida alterna. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlAnulado.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlAnulado.DataValueField = "codigo";
            this.ddlAnulado.DataTextField = "descripcion";
            this.ddlAnulado.DataBind();
            this.ddlAnulado.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción anulado. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlAnuladoAlt.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("gTipoTransaccion", "ppa"), "descripcion", Convert.ToInt16(this.Session["empresa"]));
            this.ddlAnuladoAlt.DataValueField = "codigo";
            this.ddlAnuladoAlt.DataTextField = "descripcion";
            this.ddlAnuladoAlt.DataBind();
            this.ddlAnuladoAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipo transacción anulado. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlAGL.DataSource = items;
            this.ddlAGL.DataValueField = "codigo";
            this.ddlAGL.DataTextField = "descripcion";
            this.ddlAGL.DataBind();
            this.ddlAGL.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items agl. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlAGLAlt.DataSource = items;
            this.ddlAGLAlt.DataValueField = "codigo";
            this.ddlAGLAlt.DataTextField = "descripcion";
            this.ddlAGLAlt.DataBind();
            this.ddlAGLAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items agl alterno. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlFrutaDura.DataSource = items;
            this.ddlFrutaDura.DataValueField = "codigo";
            this.ddlFrutaDura.DataTextField = "descripcion";
            this.ddlFrutaDura.DataBind();
            this.ddlFrutaDura.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items frutaDura. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlFrutaDuraAlt.DataSource = items;
            this.ddlFrutaDuraAlt.DataValueField = "codigo";
            this.ddlFrutaDuraAlt.DataTextField = "descripcion";
            this.ddlFrutaDuraAlt.DataBind();
            this.ddlFrutaDuraAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fruta dura Alterno. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlFrutaTenera.DataSource = items;
            this.ddlFrutaTenera.DataValueField = "codigo";
            this.ddlFrutaTenera.DataTextField = "descripcion";
            this.ddlFrutaTenera.DataBind();
            this.ddlFrutaTenera.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fruta tenera. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlFrutaTeneraAlt.DataSource = items;
            this.ddlFrutaTeneraAlt.DataValueField = "codigo";
            this.ddlFrutaTeneraAlt.DataTextField = "descripcion";
            this.ddlFrutaTeneraAlt.DataBind();
            this.ddlFrutaTeneraAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items fruta tenera. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlH.DataSource = items;
            this.ddlH.DataValueField = "codigo";
            this.ddlH.DataTextField = "descripcion";
            this.ddlH.DataBind();
            this.ddlH.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items humedad. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlHAlt.DataSource = items;
            this.ddlHAlt.DataValueField = "codigo";
            this.ddlHAlt.DataTextField = "descripcion";
            this.ddlHAlt.DataBind();
            this.ddlHAlt.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items humedad alterna. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlI.DataSource = items;
            this.ddlI.DataValueField = "codigo";
            this.ddlI.DataTextField = "descripcion";
            this.ddlI.DataBind();
            this.ddlI.Items.Insert(0, new ListItem("", ""));

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items impurezas. Correspondiente a: " + ex.Message, "C");
        }

        try
        {
            DataView items = CentidadMetodos.EntidadGet("iitems", "ppa").Tables[0].DefaultView;
            items.RowFilter = "empresa = " + this.Session["empresa"].ToString() + " and tipo = 'M' ";
            this.ddlIAlt.DataSource = items;
            this.ddlIAlt.DataValueField = "codigo";
            this.ddlIAlt.DataTextField = "descripcion";
            this.ddlIAlt.DataBind();
            this.ddlIAlt.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar items impurezas alterna. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void Guardar()
    {

string    agl=null;
string aglAlt = null;
string	almedraAlt	=	null;
string	almendra	=	null;
string anulado = null;
string anuladoAlt = null;
string	blanqueado	=	null;
string	blanqueadoAlt	=	null;
string	cascarilla	=	null;
string	cascarillaAlt	=	null;
string	crudo	=	null;
string	crudoAlt	=	null;
int	empresa	=	0;
string	entradas	=	null;
string	entradasAlt	=	null;
string	fibra	=	null;
string	fibraAlt	=	null;
string	fruta	=	null;
string	frutaAlt	=	null;
string frutaDura = null;
string frutaDuraAlt = null;
string frutaTenera = null;
string frutaTeneraAlt = null;
string humedad = null;
string humedadAlt = null;
string impurezas = null;
string impurezasAlt = null;
string	nuez	=	null;
string	nuezAlt	=	null;
string	ordenEnvio	=	null;
string	ordenEnvioAlt	=	null;
string	ordenSalida	=	null;
string	ordenSalidaAlt	=	null;
string	palmiste	=	null;
string	palmisteAlt	=	null;
string	pesajes	=	null;
string	pesajesAlt	=	null;
string	raquiz	=	null;
string	raquizAlt	=	null;
string	raquizPrensado	=	null;
string	raquizPrensadoAlt	=	null;
string	remisionComer	=	null;
string	remisionComerAlt	=	null;
string	remisionInt	=	null;
string	remisionIntAlt	=	null;
string	salidas	=	null;
string	salidasAlt	=	null;
string	tiquete	=	null;
string	tiqueteAlt	=	null;
string	torta	=	null;
string	tortaAlt	=	null;
string operacion = "inserta";

                
                
                if(ddlAlmendraAlt.SelectedValue.Trim().Length>0)
                 almedraAlt= ddlAlmendraAlt.SelectedValue.Trim();  //@almedraAlt

                if (ddlAlmendra.SelectedValue.Trim().Length > 0)
                almendra=ddlAlmendra.SelectedValue.Trim();  //@almendra

                if (ddlAceitePalmisteBlanqueado.SelectedValue.Trim().Length > 0)
                blanqueado=ddlAceitePalmisteBlanqueado.SelectedValue.Trim();  //@blanqueado

                if (ddlAceitePalmisteBlanqueadoAlt.SelectedValue.Trim().Length > 0)
                blanqueadoAlt=ddlAceitePalmisteBlanqueadoAlt.SelectedValue.Trim();  //@blanqueadoAlt

                if (ddlCascarilla.SelectedValue.Trim().Length > 0)
                cascarilla=ddlCascarilla.SelectedValue.Trim();  //@cascarilla

                if (ddlCascarillaAlt.SelectedValue.Trim().Length > 0)
                cascarillaAlt=ddlCascarillaAlt.SelectedValue.Trim();  //@cascarillaAlt

                if (ddlAceitePalma.SelectedValue.Trim().Length > 0)
                crudo=ddlAceitePalma.SelectedValue.Trim();  //@crudo

                if (ddlAceitePalmaAlt.SelectedValue.Trim().Length > 0)
                crudoAlt=ddlAceitePalmaAlt.SelectedValue.Trim();  //@crudoAlt


                empresa=(int)this.Session["empresa"];  //@empresa

                if (ddlEntradas.SelectedValue.Trim().Length > 0)
                entradas=ddlEntradas.SelectedValue.Trim();  //@entradas

                if (ddlEntradasAlt.SelectedValue.Trim().Length > 0)
                entradasAlt=ddlEntradasAlt.SelectedValue.Trim(); //@entradasAlt

                if (ddlFibra.SelectedValue.Trim().Length > 0)
                fibra=ddlFibra.SelectedValue.Trim();  //@fibra

                if (ddlFibraAlt.SelectedValue.Trim().Length > 0)
                fibraAlt=ddlFibraAlt.SelectedValue.Trim();  //@fibraAlt

                if (ddlFrutaPalma.SelectedValue.Trim().Length > 0)
                fruta=ddlFrutaPalma.SelectedValue.Trim(); //@fruta

                if (ddlFrutaPalmaAlt.SelectedValue.Trim().Length > 0)
                frutaAlt=ddlFrutaPalmaAlt.SelectedValue.Trim();  //@frutaAlt

                if (ddlNuez.SelectedValue.Trim().Length > 0)
                nuez=ddlNuez.SelectedValue.Trim();  //@nuez

                if (ddlNuezAlt.SelectedValue.Trim().Length > 0)
                nuezAlt=ddlNuezAlt.SelectedValue.Trim();  //@nuezAlt

                if (ddlOrdenEnvio.SelectedValue.Trim().Length > 0)
                ordenEnvio=ddlOrdenEnvio.SelectedValue.Trim();  //@ordenEnvio

                if (ddlOrdenEnvioAlt.SelectedValue.Trim().Length > 0)
                ordenEnvioAlt=ddlOrdenEnvioAlt.SelectedValue.Trim();  //@ordenEnvioAlt

                if (ddlOrdenSalida.SelectedValue.Trim().Length > 0)
                ordenSalida=ddlOrdenSalida.SelectedValue.Trim();  //@ordenSalida

                if (ddlOrdenSalidaAlt.SelectedValue.Trim().Length > 0)
                ordenSalidaAlt=ddlOrdenSalidaAlt.SelectedValue.Trim();  //@ordenSalidaAlt

                if (ddlAceiteCrudoPalmiste.SelectedValue.Trim().Length > 0)
                palmiste=ddlAceiteCrudoPalmiste.SelectedValue.Trim();  //@palmiste

                if (ddlAceiteCrudoPalmisteAlt.SelectedValue.Trim().Length > 0)
                palmisteAlt=ddlAceiteCrudoPalmisteAlt.SelectedValue.Trim();  //@palmisteAlt

                if (ddlPesajes.SelectedValue.Trim().Length > 0)
                pesajes=ddlPesajes.SelectedValue.Trim();  //@pesajes

                if (ddlPesajesAlt.SelectedValue.Trim().Length > 0)
                pesajesAlt=ddlPesajesAlt.SelectedValue.Trim();  //@pesajesAlt

                if (ddlRaquiz.SelectedValue.Trim().Length > 0)
                raquiz=ddlRaquiz.SelectedValue.Trim();  //@raquiz

                if (ddlRaquizAlt.SelectedValue.Trim().Length > 0)
                raquizAlt=ddlRaquizAlt.SelectedValue.Trim();  //@raquizAlt

                if (ddlRaquizPrensado.SelectedValue.Trim().Length > 0)
                raquizPrensado=ddlRaquizPrensado.SelectedValue.Trim();  //@raquizPrensado

                if (ddlRaquizPrensadoAlt.SelectedValue.Trim().Length > 0)
                raquizPrensadoAlt=ddlRaquizPrensadoAlt.SelectedValue.Trim();  //@raquizPrensadoAlt

                if (ddlRemComer.SelectedValue.Trim().Length > 0)
                remisionComer=ddlRemComer.SelectedValue.Trim();  //@remisionComer

                if (ddlRemComerAlt.SelectedValue.Trim().Length > 0)
                remisionComerAlt=ddlRemComer.SelectedValue.Trim();  //@remisionComerAlt

                if (ddlRemInterna.SelectedValue.Trim().Length > 0)
                remisionInt=ddlRemInterna.SelectedValue.Trim();  //@remisionInt

                if (ddlRemInternaAlt.SelectedValue.Trim().Length > 0)
                remisionIntAlt=ddlRemInternaAlt.SelectedValue.Trim();  //@remisionIntAlt

                if (ddlSalidas.SelectedValue.Trim().Length > 0)
                salidas=ddlSalidas.SelectedValue.Trim();  //@salidas

                if (ddlSalidasAlt.SelectedValue.Trim().Length > 0)
                salidasAlt=ddlSalidasAlt.SelectedValue.Trim();  //@salidasAlt

                if (ddlTiquete.SelectedValue.Trim().Length > 0)
                tiquete=ddlTiquete.SelectedValue.Trim();  //@tiquete

                if (ddlTiqueteAlt.SelectedValue.Trim().Length > 0)
                tiqueteAlt=ddlTiqueteAlt.SelectedValue.Trim();  //@tiqueteAlt

                if (ddlTorta.SelectedValue.Trim().Length > 0)
                torta=ddlTorta.SelectedValue.Trim(); //@torta

                if (ddlTortaAlt.SelectedValue.Trim().Length > 0)
                tortaAlt = ddlTortaAlt.SelectedValue.Trim(); //@tortaAlt

                if (ddlAlmendraAlt.SelectedValue.Trim().Length > 0)
                    almedraAlt = ddlAlmendraAlt.SelectedValue.Trim();  //@almedraAlt

               if (ddlAnulado.SelectedValue.Trim().Length > 0)
                    anulado = ddlAnulado.SelectedValue.Trim();  //@anulado


               if (ddlAnuladoAlt.SelectedValue.Trim().Length > 0)
                   anuladoAlt = ddlAnuladoAlt.SelectedValue.Trim();    //@anuladoAlt	varchar(50),	

               if (ddlFrutaDura.SelectedValue.Trim().Length > 0)
                   frutaDura = ddlFrutaDura.SelectedValue.Trim(); //@frutaDura	varchar(50)	,

               if (ddlFrutaDuraAlt.SelectedValue.Trim().Length > 0)
                   frutaDuraAlt = ddlFrutaDuraAlt.SelectedValue.Trim();  //@frutaDuraAlt	varchar(50)	,

               if (ddlFrutaTenera.SelectedValue.Trim().Length > 0)
                   frutaTenera = ddlFrutaTenera.SelectedValue.Trim();         //@frutaTenera	varchar(50)	,

               if (ddlFrutaTeneraAlt.SelectedValue.Trim().Length > 0)
                   frutaTeneraAlt = ddlFrutaTeneraAlt.SelectedValue.Trim();         //@frutaTeneraAlt	varchar(50)	,

               if (ddlAGL.SelectedValue.Trim().Length > 0)
                   agl = ddlAGL.SelectedValue.Trim();                     //@agl	varchar(50)	,

               if (ddlAGLAlt.SelectedValue.Trim().Length > 0)
                   aglAlt = ddlAGLAlt.SelectedValue.Trim();          //@aglAlt	varchar(50)	,

               if (ddlH.SelectedValue.Trim().Length > 0)
                   humedad = ddlH.SelectedValue.Trim();             //@humedad	varchar(50)	,

               if (ddlHAlt.SelectedValue.Trim().Length > 0)
                   humedadAlt = ddlHAlt.SelectedValue.Trim();               //@humedadAlt	varchar(50)	,

               if (ddlI.SelectedValue.Trim().Length > 0)
                   impurezas =  ddlI.SelectedValue.Trim();                //@impurezas	varchar(50)	,

               if (ddlIAlt.SelectedValue.Trim().Length > 0)
                   impurezasAlt = ddlIAlt.SelectedValue.Trim();                 //@impurezasAlt	varchar(50)	,


        try
        {

            if (Convert.ToBoolean(this.Session["Editar"]) == true)
            {
                operacion = "actualiza";
            }
                object[] objValores = new object[]{
                            agl	,
                            aglAlt	,
                            almedraAlt	,
                            almendra	,
                            anulado	,
                            anuladoAlt	,
                            blanqueado	,
                            blanqueadoAlt	,
                            cascarilla	,
                            cascarillaAlt	,
                            crudo	,
                            crudoAlt	,
                            empresa	,
                            entradas	,
                            entradasAlt	,
                            fibra	,
                            fibraAlt	,
                            fruta	,
                            frutaAlt	,
                            frutaDura	,
                            frutaDuraAlt	,
                            frutaTenera	,
                            frutaTeneraAlt	,
                            humedad	,
                            humedadAlt	,
                            impurezas	,
                            impurezasAlt	,
                            nuez	,
                            nuezAlt	,
                            ordenEnvio	,
                            ordenEnvioAlt	,
                            ordenSalida	,
                            ordenSalidaAlt	,
                            palmiste	,
                            palmisteAlt	,
                            pesajes	,
                            pesajesAlt	,
                            raquiz	,
                            raquizAlt	,
                            raquizPrensado	,
                            raquizPrensadoAlt	,
                            remisionComer	,
                            remisionComerAlt	,
                            remisionInt	,
                            remisionIntAlt	,
                            salidas	,
                            salidasAlt	,
                            tiquete	,
                            tiqueteAlt	,
                            torta	,
                            tortaAlt	

                };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("gParametrosGenerales", operacion, "ppa", objValores))
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
    #endregion Metodos

    #region Eventos

    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
            this.Response.Redirect("~/Inicio.aspx");
        else
        {
            if (seguridad.VerificaAccesoPagina(this.Session["usuario"].ToString(),
                ConfigurationManager.AppSettings["Modulo"].ToString(), nombrePaginaActual(), Convert.ToInt16(Session["empresa"])) != 0)
            {
                if (!IsPostBack)
                {
                    CargarCombos();
                    GetEntidad();
                }
            }
            else
                ManejoError("Usuario no autorizado para ingresar a esta página", "IN");
        }
    }

    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        Guardar();
    }


 
    #endregion Eventos


    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {
        CcontrolesUsuario.HabilitarControles(this.Page.Controls);
        CargarCombos();
        GetEntidad();
    }
}
