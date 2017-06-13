﻿using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Globalization;
using System.Threading;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;



public partial class Agronomico_Ptransaccion_SanidadVegetal : System.Web.UI.Page
{
    #region Instancias

    CentidadMetodos CentidadMetodos = new CentidadMetodos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CgrupoNovedad grupoNovedad = new CgrupoNovedad();
    CIP ip = new CIP();
    Clotes lotes = new Clotes();
    Coperadores operadores = new Coperadores();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    CtransaccionSanidad transaccionSanidad = new CtransaccionSanidad();
    Cperiodos periodo = new Cperiodos();
    Cseccion seccion = new Cseccion();
    Cnovedad novedades = new Cnovedad();
    CgrupoCaracteristica gcarateristica = new CgrupoCaracteristica();
    Ccaracteristicas caracteristica = new Ccaracteristicas();


    Ctransacciones transacciones = new Ctransacciones();

    #endregion Instancias

    #region Metodos

    private void Editar()
    {
        string operacion = "inserta";
        bool verificaEncabezado = false;
        bool verificaDetalle = false;
        string numerotransaccion = null;
        upDetalle.Update();
      


        try
        {
            using (TransactionScope ts = new TransactionScope())
            {

                DateTime fecha = Convert.ToDateTime(txtFecha.Text);
                DateTime fechaF = Convert.ToDateTime(txtFecha.Text);
                numerotransaccion = txtNumero.Text.Trim();
                this.Session["numerotransaccion"] = numerotransaccion;

                object[] objValo = new object[]{     
                             (int)this.Session["empresa"], //@empresa	int
                              txtNumero.Text,      //@numero	varchar
                              ddlTipoDocumento.SelectedValue      //@tipo	varchar       
                              };

                switch (CentidadMetodos.EntidadInsertUpdateDelete(
                    "aSanidadDetalle",
                    "elimina",
                    "ppa",
                    objValo))
                {

                    case 0:

                foreach (GridViewRow dl in gvLista.Rows)
                {
                    string grupoCaractesitica = null;
                    string caracteristica = null;
                    string cantidad = null;
                    string detalle = dl.Cells[14].Text.Trim();
                    DateTime fechaD = Convert.ToDateTime(dl.Cells[8].Text.Trim());
                    string concepto = dl.Cells[2].Text.Trim();
                    string linea = dl.Cells[10].Text.Trim();
                    string loteD = dl.Cells[9].Text.Trim();
                    string palma = null;

                    if (dl.Cells[11].Text.Trim() != "&nbsp;")
                    {
                        if (dl.Cells[11].Text.Trim().Trim().Length > 0)
                        {
                            palma = dl.Cells[11].Text;
                        }
                    }

                    if (dl.Cells[12].Text.Trim() != "&nbsp;")
                    {
                        if (dl.Cells[12].Text.Trim().Trim().Length > 0)
                        {
                            cantidad = dl.Cells[12].Text.Trim();
                        }
                    }

                    string unidadMedida = dl.Cells[13].Text.Trim();
                    int registro = Convert.ToInt32(dl.Cells[15].Text.Trim());

                    if (dl.Cells[4].Text.Trim() != "&nbsp;")
                    {
                        caracteristica = dl.Cells[4].Text.Trim();
                    }

                    if (dl.Cells[6].Text.Trim() != "&nbsp;")
                    {
                        grupoCaractesitica = dl.Cells[6].Text.Trim();
                    }


                   

                            object[] objValores1 = new object[]{
                                                         cantidad,  //@cantidad	decimal
                                                          caracteristica,
                                                          detalle,  //@detalle	varchar
                                                          false,  //@ejecutado	bit
                                                         (int)this.Session["empresa"],  //@empresa	int
                                                           fechaD, //@fecha	date
                                                           null,  //@fechaEjecutado	datetime
                                                           grupoCaractesitica,
                                                           concepto, //@item	int
                                                           linea, //@linea	int
                                                           loteD, //@lote	varchar
                                                           numerotransaccion, //@numero	varchar
                                                           palma,  //@palma	int
                                                           null, //@referenciaDetalle	nchar
                                                           registro,
                                                           ddlTipoDocumento.SelectedValue.Trim(), //@tipo	varchar
                                                            unidadMedida, //@uMedida	varchar
                                                            null //@usuarioEjecturado	datetime
                                 };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                "aSanidadDetalle",
                                "inserta",
                                "ppa",
                                objValores1))
                            {
                                case 1:
                                    ManejoError("Error al insertar el detalle de la transaccción", "I");
                                    verificaDetalle = true;
                                    break;
                            }
                    }
                break;

                }


                if (verificaEncabezado == false & verificaDetalle == false)
                {
                    //transacciones.ActualizaConsecutivo(ddlTipoDocumento.Text,  Convert.ToInt32( this.Session["empresa"]);
                    ts.Complete();
                    ManejoExito("Datos actualizados satisfactoriamente N° de transacción " + this.Session["numerotransaccion"].ToString(), "I");
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }

    }

    private void cargarDetalle()
    {
        List<CtransaccionSanidad> listaTransaccion = null;
        DataView dvNovedad = transacciones.RetornaTransaccionSanidadDetalle(ddlTipoDocumento.SelectedValue,
            txtNumero.Text,  Convert.ToInt32( this.Session["empresa"]));
        dvNovedad.Sort = "registro";


        foreach (DataRowView registro in dvNovedad)
        {

            transaccionSanidad = new CtransaccionSanidad(
                Convert.ToDateTime(registro.Row.ItemArray.GetValue(4).ToString()),//fecha
                registro.Row.ItemArray.GetValue(8).ToString(),//idConcepto
                registro.Row.ItemArray.GetValue(19).ToString(), //nombreConcepto
                registro.Row.ItemArray.GetValue(16).ToString(),
                 registro.Row.ItemArray.GetValue(22).ToString(), registro.Row.ItemArray.GetValue(17).ToString(), registro.Row.ItemArray.GetValue(23).ToString(),
                registro.Row.ItemArray.GetValue(9).ToString(), registro.Row.ItemArray.GetValue(10).ToString(),
                 registro.Row.ItemArray.GetValue(5).ToString(), registro.Row.ItemArray.GetValue(6).ToString(),
                registro.Row.ItemArray.GetValue(11).ToString(), registro.Row.ItemArray.GetValue(7).ToString(), Convert.ToInt16(registro.Row.ItemArray.GetValue(3).ToString()), "");

            hdRegistro.Value = Convert.ToInt16(registro.Row.ItemArray.GetValue(3).ToString()).ToString();

            if (this.Session["transaccion"] == null)
            {
                listaTransaccion = new List<CtransaccionSanidad>();
                listaTransaccion.Add(transaccionSanidad);
                this.Session["transaccion"] = listaTransaccion;
            }
            else
            {
                listaTransaccion = (List<CtransaccionSanidad>)Session["transaccion"];
                listaTransaccion.Add(transaccionSanidad);
            }

        }


        this.gvLista.DataSource = listaTransaccion;
        this.gvLista.DataBind();
        this.Session["editarDetalle"] = false;
        registroMayor(listaTransaccion);

    }

    private void manejoConsulta()
    {
        CcontrolesUsuario.LimpiarControles(upConsulta.Controls);
        CcontrolesUsuario.HabilitarControles(upConsulta.Controls);
        upGeneral.Visible = true;
        this.upDetalle.Visible = false;
        this.upEncabezado.Visible = false;
        this.upConsulta.Visible = true;
        this.niimbRegistro.BorderStyle = BorderStyle.None;
        this.imbConsulta.BorderStyle = BorderStyle.Solid;
        this.imbConsulta.BorderColor = System.Drawing.Color.Silver;
        this.imbConsulta.BorderWidth = Unit.Pixel(1);
        imbBusqueda.Visible = false;
        nitxtValor2.Visible = false;
        this.niimbRegistro.Enabled = true;
        lblTipoDocumento.Visible = false;
        ddlTipoDocumento.Visible = false;
        txtNumero.Visible = false;
        lblNumero.Visible = false;
        lbCancelar.Visible = false;
        lbRegistrar.Visible = false;
        this.Session["transaccion"] = null;
        this.lbRegistrar.Enabled = true;
        this.nilbNuevo.Visible = false;
        this.niimbImprimir.Visible = false;
        this.imbConsulta.Enabled = false;
        this.nilblInformacion.Text = "";
        gvParametros.DataSource = null;
        gvParametros.DataBind();
        CargaCampos();
    }

    private void cargarEncabezado()
    {
        upEncabezado.Visible = true;
        DataView dvEncabezado = transacciones.RetornaEncabezadoTransaccionSanidad(ddlTipoDocumento.SelectedValue, txtNumero.Text,  Convert.ToInt32( this.Session["empresa"]));
        foreach (DataRowView registro in dvEncabezado)
        {
            txtFecha.Text = Convert.ToDateTime(registro[3]).ToString();
            ddlFinca.SelectedValue = registro[4].ToString().Trim();
            txtObservacion.Text = registro.Row.ItemArray.GetValue(7).ToString();
            txtRemision.Text = registro.Row.ItemArray.GetValue(6).ToString();

            if (registro.Row.ItemArray.GetValue(5).ToString().Trim().Length > 0)
            {
                cargarSesiones();
                ddlSeccion.SelectedValue = registro.Row.ItemArray.GetValue(5).ToString().Trim();
            }

            if (registro.Row.ItemArray.GetValue(8).ToString().Trim().Length > 0)
            {
                ddlReferencia.SelectedValue = registro.Row.ItemArray.GetValue(8).ToString().Trim();
            }
        }
        CcontrolesUsuario.InhabilitarUsoControles(upEncabezado.Controls);
    }

    protected void Guardar()
    {
        string operacion = "inserta";
        bool verificaEncabezado = false;
        bool verificaDetalle = false;
        string numerotransaccion = null;
        upDetalle.Update();
        


        try
        {
            using (TransactionScope ts = new TransactionScope())
            {

                DateTime fecha = Convert.ToDateTime(txtFecha.Text);
                DateTime fechaF = Convert.ToDateTime(txtFecha.Text);
                numerotransaccion = transacciones.RetornaNumeroTransaccion(ddlTipoDocumento.SelectedValue,  Convert.ToInt32( this.Session["empresa"]));
                this.Session["numerotransaccion"] = numerotransaccion;


                object[] objValo = new object[]{     
                                                        false,    //  @anulado	bit
                                                        (int)this.Session["empresa"] ,  //@empresa	int
                                                        Convert.ToDateTime(txtFecha.Text),     //@fecha	date
                                                         null,   //@fechaAnulado	datetime
                                                         DateTime.Now,   //@fechaRegistro	datetime
                                                         ddlFinca.SelectedValue.Trim(),   //@finca	varchar
                                                         txtObservacion.Text.Trim(),   //@nota	varchar
                                                         numerotransaccion,   //@numero	varchar
                                                         ddlReferencia.SelectedValue.Trim(),   //@referencia	varchar
                                                         txtRemision.Text.Trim(),  //@remision	varchar
                                                         ddlSeccion.SelectedValue,   //@seccion	char
                                                         ddlTipoDocumento.SelectedValue,   //@tipo	varchar
                                                         this.Session["usuario"],  //@usuario	varchar
                                                         null   //@usuarioAnulado	varchar
                              };

                switch (CentidadMetodos.EntidadInsertUpdateDelete("aSanidad", operacion, "ppa", objValo))
                {
                    case 0:

                        foreach (GridViewRow dl in gvLista.Rows)
                        {
                            string grupoCaractesitica = null;
                            string caracteristica = null;
                            string detalle = dl.Cells[14].Text.Trim();
                            DateTime fechaD = Convert.ToDateTime(dl.Cells[8].Text.Trim());
                            string concepto = dl.Cells[2].Text.Trim();
                            string linea = dl.Cells[10].Text.Trim();
                            string loteD = dl.Cells[9].Text.Trim();
                            string palma = null;
                            string cantidad = null;

                            if (dl.Cells[11].Text.Trim() != "&nbsp;")
                            {
                                if (dl.Cells[11].Text.Trim().Trim().Length > 0)
                                {
                                    palma = dl.Cells[11].Text;
                                }
                            }

                            if (dl.Cells[12].Text.Trim() != "&nbsp;")
                            {
                                if (dl.Cells[12].Text.Trim().Trim().Length > 0)
                                {
                                    cantidad = dl.Cells[12].Text.Trim();
                                }
                            }

                            string unidadMedida = dl.Cells[13].Text.Trim();
                            int registro = Convert.ToInt32(dl.Cells[15].Text.Trim());

                            if (dl.Cells[4].Text.Trim() != "&nbsp;")
                            {
                                caracteristica = dl.Cells[4].Text.Trim();
                            }

                            if (dl.Cells[6].Text.Trim() != "&nbsp;")
                            {
                                grupoCaractesitica = dl.Cells[6].Text.Trim();
                            }




                            object[] objValores1 = new object[]{
                                                          cantidad,  //@cantidad	decimal
                                                          caracteristica,
                                                          detalle,  //@detalle	varchar
                                                          false,  //@ejecutado	bit
                                                         (int)this.Session["empresa"],  //@empresa	int
                                                           fechaD, //@fecha	date
                                                           null,  //@fechaEjecutado	datetime
                                                           grupoCaractesitica,
                                                           concepto, //@item	int
                                                           linea, //@linea	int
                                                           loteD, //@lote	varchar
                                                           numerotransaccion, //@numero	varchar
                                                           palma,  //@palma	int
                                                           null, //@referenciaDetalle	nchar
                                                           registro,
                                                           ddlTipoDocumento.SelectedValue.Trim(), //@tipo	varchar
                                                            unidadMedida, //@uMedida	varchar
                                                            null //@usuarioEjecturado	datetime
                                 };

                            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                                "aSanidadDetalle",
                                operacion,
                                "ppa",
                                objValores1))
                            {
                                case 1:
                                    ManejoError("Error al insertar el detalle de la transaccción", "I");
                                    verificaDetalle = true;
                                    break;
                            }
                        }
                        break;

                    case 1:
                        ManejoError("Error al insertar el detalle de la transaccción", "I");
                        verificaEncabezado = true;
                        break;
                }

                if (verificaEncabezado == false & verificaDetalle == false)
                {
                    transacciones.ActualizaConsecutivo(ddlTipoDocumento.Text,  Convert.ToInt32( this.Session["empresa"]));
                    ts.Complete();
                    ManejoExito("Datos registrados satisfactoriamente N° de transacción " + this.Session["numerotransaccion"].ToString(), "I");
                }
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al guardar los datos correspondiente a: " + ex.Message, operacion.Substring(0, 1).ToUpper());
        }
    }

    private object NovedadConfig(int posicion)
    {

        object retorno = null;
        string cadena;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            cadena = novedades.NovedadConfig(ddlConcepto.SelectedValue, Convert.ToInt16(Session["empresa"])).ToString();
            retorno = cadena.Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar posición de configuración del lote. Correspondiente a: " + ex.Message, "C");
            return null;
        }
    }

    private void ConfiguracionNovedad(string novedad)
    {
        try
        {
            bool configuracionNovedad = Convert.ToBoolean(NovedadConfig(16));
            ddlUmedida.SelectedValue = NovedadConfig(4).ToString().Trim();
            this.Session["manejalote"] = Convert.ToBoolean(NovedadConfig(12));
            txtPalma.Enabled = configuracionNovedad;
            txtPalma.Visible = configuracionNovedad;
            lblPalma.Enabled = configuracionNovedad;
            lblPalma.Visible = configuracionNovedad;



        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar el configuración de la novedad. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void cargarDetallereferencia()
    {
        if (ddlReferencia.Enabled == true)
        {
            ddlReferencia.DataSource = tipoTransaccion.GetReferencia(ddlTipoDocumento.SelectedValue,  Convert.ToInt32( this.Session["empresa"]));
            ddlReferencia.DataBind();
        }
    }

    private void EstadoInicialGrillaTransacciones()
    {
        for (int i = 0; i < this.gvTransaccion.Columns.Count; i++)
        {
            this.gvTransaccion.Columns[i].Visible = true;
        }

        foreach (GridViewRow registro in this.gvTransaccion.Rows)
        {
            this.gvTransaccion.Rows[registro.RowIndex].Visible = true;
        }
    }


    private void TabRegistro()
    {
        this.upGeneral.Visible = true;
        this.upConsulta.Visible = false;

        if (Convert.ToBoolean(this.Session["editar"]) == true)
        {
            this.upDetalle.Visible = true;
            this.upEncabezado.Visible = true;
        }

        this.niimbRegistro.BorderStyle = BorderStyle.None;
        this.imbConsulta.BorderStyle = BorderStyle.Solid;
        this.imbConsulta.BorderColor = System.Drawing.Color.White;
        this.imbConsulta.BorderWidth = Unit.Pixel(1);
        this.imbConsulta.Enabled = true;
        this.niimbRegistro.Enabled = false;
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.nilblRegistros.Text = "Nro. Registros 0";
        this.nilblMensajeEdicion.Text = "";
        this.niimbImprimir.Visible = false;
        this.Session["editar"] = null;
        CcontrolesUsuario.LimpiarControles(upConsulta.Controls);
        gvTransaccion.DataSource = null;
        gvTransaccion.DataBind();
        this.Session["novedadLoteSesion"] = null;
        this.Session["transaccion"] = null;
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.imbConsulta.BorderStyle = BorderStyle.None;
        this.niimbRegistro.BorderStyle = BorderStyle.Solid;
        this.niimbRegistro.BorderColor = System.Drawing.Color.Silver;
        this.niimbRegistro.BorderWidth = Unit.Pixel(1);
        this.niimbRegistro.Enabled = false;
        this.imbBusqueda.Enabled = true;
        this.niimbRegistro.Enabled = false;
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.nilblRegistros.Text = "Nro. Registros 0";
        this.nilblMensajeEdicion.Text = "";
        this.niimbImprimir.Visible = false;
        this.nilbNuevo.Visible = true;
        this.imbConsulta.Visible = true;
        this.upGeneral.Visible = true;
        this.upConsulta.Visible = false;
        this.upDetalle.Visible = false;
        this.upEncabezado.Visible = false;
        this.niimbRegistro.Enabled = false;
        this.imbConsulta.Enabled = true;
    }


    private void ManejoError(string error, string operacion)
    {
        this.Session["error"] = error;
        this.Session["paginaAnterior"] = this.Page.Request.FilePath.ToString();

        this.Response.Redirect("~/Agronomico/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {
        TabRegistro();

        CcontrolesUsuario.InhabilitarControles(
            this.upEncabezado.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upEncabezado.Controls);

        CcontrolesUsuario.InhabilitarControles(
            this.upDetalle.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upDetalle.Controls);

        InHabilitaEncabezado();

        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.Session["transaccion"] = null;
        this.nilblInformacion.Text = mensaje;
        this.nilblInformacion.ForeColor = System.Drawing.Color.Navy;
        this.lbRegistrar.Visible = false;

        this.niimbImprimir.Visible = true;

    }

    private void ManejoEncabezado()
    {
        CcontrolesUsuario.LimpiarControles(upEncabezado.Controls);
        CcontrolesUsuario.LimpiarControles(upDetalle.Controls);
        ddlFinca.DataSource = null;
        ddlFinca.DataBind();
        ddlSeccion.DataSource = null;
        ddlSeccion.DataBind();
        HabilitaEncabezado();
        CargarTipoTransaccion();
    }

    private void CargarTipoTransaccion()
    {
        try
        {
            this.ddlTipoDocumento.DataSource = tipoTransaccion.GetTipoTransaccionModulo(Convert.ToInt16(Session["empresa"]));
            this.ddlTipoDocumento.DataValueField = "codigo";
            this.ddlTipoDocumento.DataTextField = "descripcion";
            this.ddlTipoDocumento.DataBind();
            this.ddlTipoDocumento.Items.Insert(0, new ListItem("", ""));
            this.ddlTipoDocumento.SelectedValue = "";
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar tipos de transacción. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void CargaCampos()
    {
        try
        {
            this.niddlCampo.DataSource = transacciones.GetCamposEntidades("aSanidad", "");
            this.niddlCampo.DataValueField = "name";
            this.niddlCampo.DataTextField = "name";
            this.niddlCampo.DataBind();
            this.niddlCampo.Items.Insert(0, new ListItem("Selección de campo", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos para edición. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void cargarLotes()
    {
        try
        {
            this.ddlLote.DataSource = lotes.LotesSeccionFinca(this.ddlSeccion.SelectedValue.ToString().Trim(), Convert.ToInt16(this.Session["empresa"]), ddlFinca.SelectedValue.ToString().Trim());
            this.ddlLote.DataValueField = "codigo";
            this.ddlLote.DataTextField = "descripcion";
            this.ddlLote.DataBind();
            this.ddlLote.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar lotes. Correspondiente a: " + ex.Message, "C");
        }
    }

    protected void cargarLineas()
    {
        try
        {
            this.ddlLinea.DataSource = lotes.LineaLote(Convert.ToInt16(this.Session["empresa"]), ddlLote.SelectedValue);
            this.ddlLinea.DataValueField = "linea";
            this.ddlLinea.DataTextField = "linea";
            this.ddlLinea.DataBind();
            this.ddlLinea.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar lotes. Correspondiente a: " + ex.Message, "C");
        }
    }


    protected void cargarSesiones()
    {

        if (ddlFinca.SelectedValue.Trim().Length == 0)
        {
            nilblInformacion.Text = "Debe seleccionar una finca";
            return;
        }
        try
        {
            ddlSeccion.Enabled = true;

            this.ddlSeccion.DataSource = seccion.SeleccionaSesionesFinca(Convert.ToInt16(this.Session["empresa"]), ddlFinca.SelectedValue);
            this.ddlSeccion.DataValueField = "codigo";
            this.ddlSeccion.DataTextField = "descripcion";
            this.ddlSeccion.DataBind();
            this.ddlSeccion.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar secciones. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void CargarCombos()
    {
        try
        {
            this.ddlFinca.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(CentidadMetodos.EntidadGet("aFinca", "ppa"),
                "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlFinca.DataValueField = "codigo";
            this.ddlFinca.DataTextField = "descripcion";
            this.ddlFinca.DataBind();
            this.ddlFinca.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar finca. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            DataView dvConcepto = CentidadMetodos.EntidadGet("anovedad", "ppa").Tables[0].DefaultView;
            dvConcepto.RowFilter = "claseLabor =0 and empresa =" + Convert.ToInt16(this.Session["empresa"]).ToString(); ;
            dvConcepto.Sort = "descripcion";
            this.ddlConcepto.DataSource = dvConcepto;
            this.ddlConcepto.DataValueField = "codigo";
            this.ddlConcepto.DataTextField = "descripcion";
            this.ddlConcepto.DataBind();
            this.ddlConcepto.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar conceptos. Correspondiente a: " + ex.Message, "C");
        }


        try
        {
            this.ddlUmedida.DataSource = CcontrolesUsuario.OrdenarEntidadyActivos(
                CentidadMetodos.EntidadGet("gUnidadMedida", "ppa"), "descripcion", Convert.ToInt16(Session["empresa"]));
            this.ddlUmedida.DataValueField = "codigo";
            this.ddlUmedida.DataTextField = "descripcion";
            this.ddlUmedida.DataBind();
            this.ddlUmedida.Items.Insert(0, new ListItem("", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar unidades de medida. Correspondiente a: " + ex.Message, "C");
        }

    }

    private object TipoTransaccionConfig(int posicion)
    {
        object retorno = null;
        string cadena;
        char[] comodin = new char[] { '*' };
        int indice = posicion + 1;

        try
        {
            cadena = tipoTransaccion.TipoTransaccionConfig(ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"])).ToString();
            retorno = cadena.Split(comodin, indice).GetValue(posicion - 1);

            return retorno;
        }
        catch (Exception ex)
        {
            ManejoError("Error al recuperar posición de configuración de tipo de transacción. Correspondiente a: " + ex.Message, "C");

            return null;
        }
    }


    private string ConsecutivoTransaccion()
    {
        string numero = "";

        try
        {
            numero = transacciones.RetornaNumeroTransaccion(
                Convert.ToString(this.ddlTipoDocumento.SelectedValue),  Convert.ToInt32( this.Session["empresa"]));
        }
        catch (Exception ex)
        {
            ManejoError("Error al obtener el número de transacción. Correspondiente a: " + ex.Message, "C");
        }

        return numero;
    }


    private void HabilitaEncabezado()
    {
        this.nilblInformacion.Text = "";
        this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
        this.lbCancelar.Visible = true;
        this.nilbNuevo.Visible = false;
        this.lblTipoDocumento.Visible = true;
        this.ddlTipoDocumento.Visible = true;
        this.ddlTipoDocumento.Enabled = true;
        this.lblNumero.Visible = true;
        this.txtNumero.Visible = true;
        this.txtNumero.Text = "";
        this.ddlTipoDocumento.Focus();
        this.niCalendarFecha.Visible = false;
        this.lbRegistrar.Visible = true;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.Session["transaccion"] = null;
        this.niimbImprimir.Visible = false;


    }

    private void InHabilitaEncabezado()
    {
        this.nilblInformacion.Text = "";
        this.lbCancelar.Visible = false;
        this.nilbNuevo.Visible = true;
        this.lblTipoDocumento.Visible = false;
        this.ddlTipoDocumento.Visible = false;
        this.lblNumero.Visible = false;
        this.txtNumero.Visible = false;
        this.txtNumero.Text = "";
        this.nilbNuevo.Focus();
    }

    private void BusquedaTransaccion()
    {
        try
        {
            if (this.gvParametros.Rows.Count > 0)
            {
                string where = operadores.FormatoWhere(
                    (List<Coperadores>)Session["operadores"]);

                this.gvTransaccion.DataSource = transacciones.GetTransaccionCompleta(where, Convert.ToInt16(Session["empresa"]));
                this.gvTransaccion.DataBind();

                this.nilblRegistros.Text = "Nro. Registros " + Convert.ToString(this.gvTransaccion.Rows.Count);

                EstadoInicialGrillaTransacciones();
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al procesar la consulta de transacciones. Correspondiente a: " + ex.Message, "C");
        }
    }

    private int CompruebaTransaccionExistente()
    {
        try
        {
            object[] objkey = new object[]{ 
                (int)this.Session["empresa"],
                this.txtNumero.Text,
                 Convert.ToString(this.ddlTipoDocumento.SelectedValue)                 
                  };

            if (CentidadMetodos.EntidadGetKey(
                "aTransaccion",
                "ppa",
                objkey).Tables[0].DefaultView.Count > 0)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        catch (Exception ex)
        {
            ManejoError("Error al comprobar transacción existente. Correspondiente a: " + ex.Message, "C");

            return 1;
        }
    }

    private void ComportamientoConsecutivo()
    {
        if (this.txtNumero.Text.Length == 0)
        {
            this.txtNumero.Enabled = true;
            this.txtNumero.ReadOnly = false;
            this.txtNumero.Focus();
        }
        else
        {
            if (this.txtFecha.Visible == true)
            {
                if (CompruebaTransaccionExistente() == 1)
                {
                    this.nilblInformacion.Text = "Transacción existente. Por favor corrija";

                    return;
                }
                else
                {
                    this.nilblInformacion.Text = "";
                }
            }

            this.txtNumero.Enabled = false;

            CcontrolesUsuario.HabilitarControles(
                this.upEncabezado.Controls);

            this.niimbImprimir.Visible = false;
            this.nilbNuevo.Visible = false;
            this.txtFecha.Visible = false;
            this.txtFecha.Focus();
        }
    }

    #endregion Metodos

    #region Evento
    protected void Page_Load(object sender, EventArgs e)
    {
        if (this.Session["usuario"] == null)
        {
            this.Response.Redirect("~/Inicio.aspx");
        }
        else
        {
            if (!IsPostBack)
            {
                CargarCombos();
                CargaCampos();
                TabRegistro();

                this.Session["transaccion"] = null;
                this.Session["operadores"] = null;
            }
        }

    }
    protected void nilbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        this.Session["editar"] = false;
        this.Session["editarDetalle"] = false;
        this.Session["transaccion"] = null;
        this.hdRegistro.Value = "0";
        ManejoEncabezado();
    }
    protected void ddlTercero_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarSesiones();
        cargarLotes();
        cargarDetallereferencia();
    }

    protected void ddlLote_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarLineas();
    }


    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        InHabilitaEncabezado();

        CcontrolesUsuario.InhabilitarControles(
            this.upEncabezado.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upEncabezado.Controls);

        CcontrolesUsuario.InhabilitarControles(
            this.upDetalle.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.upDetalle.Controls);

        this.Session["transaccion"] = null;
        this.gvLista.DataSource = null;
        this.gvLista.DataBind();
        this.niCalendarFecha.Visible = false;
        this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
        this.lbRegistrar.Visible = false;

        this.lbCancelar.Visible = false;
        this.niimbImprimir.Visible = false;
        upEncabezado.Visible = false;
        upDetalle.Visible = false;
        TabRegistro();

    }
    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (gvLista.Rows.Count <= 0)
        {
            nilblInformacion.Text = "El detalle de la transacción debe tener por lo menos un registro";
            return;
        }

        bool validar = false;

        if (upEncabezado.Visible == true)
        {
            if (txtFecha.Enabled == true)
            {
                if (txtFecha.Text.Trim().Length == 0)
                {
                    validar = true;
                }
            }

            if (ddlFinca.Visible == true)
            {
                if (ddlFinca.SelectedValue.Trim().Length == 0)
                {
                    validar = true;
                }
            }


            if (txtFecha.Enabled == true)
            {
                if (txtFecha.Text.Trim().Length == 0)
                {
                    validar = true;
                }
            }
        }

        if (validar)
        {
            nilblInformacion.Text = "Campos vacios por favor corrija";
            return;
        }

        if (Convert.ToBoolean(Session["editar"]) == false)
        {
            Guardar();
        }
        else
        {
            Editar();
        }
    }
    protected void niimbBuscar_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void niimbRegistro_Click(object sender, ImageClickEventArgs e)
    {
        TabRegistro();
    }
    protected void niimbConsulta_Click(object sender, ImageClickEventArgs e)
    {
        manejoConsulta();

    }

    private void ComportamientoTransaccion()
    {
        upEncabezado.Visible = true;
        upDetalle.Visible = true;

        CcontrolesUsuario.ComportamientoCampoEntidad(
                          this.upEncabezado.Controls,
                          "aSanidad",
                          Convert.ToString(ddlTipoDocumento.SelectedValue),
                          (int)this.Session["empresa"]
                          );
        CcontrolesUsuario.ComportamientoCampoEntidad(
                         this.upDetalle.Controls,
                         "aSanidadDetalle",
                         Convert.ToString(ddlTipoDocumento.SelectedValue),
                         (int)this.Session["empresa"]
                         );
        this.btnRegistrar.Visible = true;
        ddlCaracteristica.Visible = false;
        ddlGrupoC.Visible = false;
        lblCaracteristica.Visible = false;
        lblGrupoC.Visible = false;
        lblPalma.Visible = false;
        txtPalma.Visible = false;

    }


    protected void ddlTipoDocumento_SelectedIndexChanged(object sender, EventArgs e)
    {

        try
        {

            CcontrolesUsuario.InhabilitarControles(
             this.upEncabezado.Controls);
            CcontrolesUsuario.LimpiarControles(
                this.upEncabezado.Controls);

            CcontrolesUsuario.InhabilitarControles(
                this.upDetalle.Controls);
            CcontrolesUsuario.LimpiarControles(
                this.upDetalle.Controls);

            this.gvLista.DataSource = null;
            this.gvLista.DataBind();

            this.Session["transaccion"] = null;

            this.niCalendarFecha.SelectedDate = Convert.ToDateTime(null);
            this.txtNumero.Text = ConsecutivoTransaccion();
            this.niimbImprimir.Visible = false;

            this.hdTransaccionConfig.Value = CcontrolesUsuario.TipoTransaccionConfig(
                this.ddlTipoDocumento.SelectedValue, Convert.ToInt16(Session["empresa"]));


            ComportamientoConsecutivo();
            ComportamientoTransaccion();
            

        }
        catch (Exception ex)
        {
            ManejoError("Error al comprobar transacción con referencia. Correspondiente a: " + ex.Message, "C");
        }

    }
    protected void txtNumero_TextChanged(object sender, EventArgs e)
    {

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
        //this.txtFecha.Enabled = false;
    }
    protected void btnRegistrar_Click(object sender, EventArgs e)
    {
        
        this.nilblInformacion.Text = "";
        string gCaracteristica = "";
        string ngCaracteristica = "";
        string caracteristica = "";
        string nCaracteristica = "";

        try
        {

            if (this.gvLista.Rows.Count >= 20)
            {
                this.nilblInformacion.Text = "El número de artículos no puede ser mayor a 20";
                return;
            }

            if (Convert.ToString(this.ddlTipoDocumento.SelectedValue).Trim().Length == 0 ||
                this.txtNumero.Text.Trim().Length == 0)
            {
                CcontrolesUsuario.MensajeError("Debe ingresar tipo y número de transacción", this.nilblInformacion);
                return;
            }

            if (CcontrolesUsuario.VerificaCamposRequeridos(this.upDetalle.Controls) == false)
            {
                CcontrolesUsuario.MensajeError("Campos vacios. Por favor corrija", this.nilblInformacion);
                return;
            }



            if (txtCantidad.Enabled == true)
            {
                if (Convert.ToDecimal(this.txtCantidad.Text) <= 0)
                {
                    this.nilblInformacion.Text = "La cantidad no puede ser igual o menor que cero. Por favor corrija";
                    return;
                }
            }

            if (txtFechaD.Enabled == true)
            {
                if (txtFechaD.Text.Trim().Length <= 0)
                {
                    this.nilblInformacion.Text = "La fecha del detalle no puede ser vacia por favor seleccione una fecha";
                    return;
                }
            }

            if (txtPalma.Enabled == true & txtPalma.Visible == true)
            {

                if (Convert.ToDecimal(this.txtPalma.Text) <= 0)
                {
                    this.nilblInformacion.Text = "El No. de palma no puede ser igual o menor que cero. Por favor corrija";
                    return;
                }
            }

            if (txtCantidad.Enabled == true)
            {
                if (transacciones.ValidarNumeroPalmas(ddlConcepto.SelectedValue.Trim(), ddlLote.SelectedValue.Trim(), ddlLinea.SelectedValue.Trim(),  Convert.ToInt32( this.Session["empresa"]), txtCantidad.Text) == 1)
                {
                    CcontrolesUsuario.MensajeError("Campos vacios. Por favor corrija", this.nilblInformacion);
                    return;
                }
            }

            if (txtPalma.Enabled == true)
            {
                if (transacciones.ValidarNumeroPalmas(ddlConcepto.SelectedValue.Trim(), ddlLote.SelectedValue.Trim(), ddlLinea.SelectedValue.Trim(), Convert.ToInt32(this.Session["empresa"]), txtPalma.Text) == 1)
                {
                    CcontrolesUsuario.MensajeError("Campos vacios. Por favor corrija", this.nilblInformacion);
                    return;
                }
            }

            if (Convert.ToBoolean(this.Session["editarDetalle"]) == false)
            {
                this.hdRegistro.Value = (Convert.ToInt16(hdRegistro.Value) +1).ToString();
            }
            else
            {
                this.hdRegistro.Value = (Convert.ToInt16(hdRegistro.Value)).ToString();
            }

            if (ddlGrupoC.SelectedValue != null & ddlGrupoC.Visible == true)
            {
                ngCaracteristica = ddlGrupoC.SelectedItem.Text;
                gCaracteristica = ddlGrupoC.SelectedValue.Trim().ToString();
                caracteristica = ddlCaracteristica.SelectedValue.Trim().ToString();
                nCaracteristica = ddlCaracteristica.SelectedItem.Text;
            }


            transaccionSanidad = new CtransaccionSanidad(cldFechaD.SelectedDate, ddlConcepto.SelectedValue, ddlConcepto.SelectedItem.ToString(), gCaracteristica, ngCaracteristica, caracteristica, nCaracteristica, txtCantidad.Text, ddlUmedida.SelectedValue,
                 ddlLote.SelectedValue, ddlLinea.SelectedValue, txtDetalle.Text, txtPalma.Text, Convert.ToInt16(this.hdRegistro.Value), "");

            List<CtransaccionSanidad> listaTransaccion = null;

            if (this.Session["transaccion"] == null)
            {
                listaTransaccion = new List<CtransaccionSanidad>();
                listaTransaccion.Add(transaccionSanidad);
            }
            else
            {
                listaTransaccion = (List<CtransaccionSanidad>)Session["transaccion"];
                listaTransaccion.Add(transaccionSanidad);
            }

            this.Session["transaccion"] = listaTransaccion;
            this.gvLista.DataSource = listaTransaccion;
            this.gvLista.Sort("registro", SortDirection.Descending);
            this.gvLista.DataBind();

            this.Session["editarDetalle"] = false;
            registroMayor(listaTransaccion);


            CcontrolesUsuario.LimpiarControles(
                this.upDetalle.Controls);
            CcontrolesUsuario.LimpiarCombos(
                this.upDetalle.Controls);

            CcontrolesUsuario.InhabilitarUsoControles(upEncabezado.Controls);
        }
        catch (Exception ex)
        {
            CcontrolesUsuario.MensajeError(
                "Error al insertar el registro. Correspondiente a: " + ex.Message,
                this.nilblInformacion);
        }

    }
    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.nilblInformacion.Text = "";

        try
        {
            List<CtransaccionSanidad> listaTransaccion = null;
            listaTransaccion = (List<CtransaccionSanidad>)Session["transaccion"];
            listaTransaccion.RemoveAt(e.RowIndex);
            this.gvLista.DataSource = listaTransaccion;
            this.gvLista.DataBind();

            if (listaTransaccion.Count == 0)
            {
                CcontrolesUsuario.HabilitarUsoControles(upEncabezado.Controls);
                ComportamientoTransaccion();

            }

            registroMayor(listaTransaccion);

        }
        catch (Exception ex)
        {
            this.nilblInformacion.Text = "Error al eliminar el registro. Correspondiente a: " + ex.Message;
        }
    }


    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            if ((Boolean)Session["editarDetalle"] == true)
            {
                nilblMensajeEdicion.Text = "Termine el registro para poder editar el seleccionado";
            }

            this.nilblInformacion.Text = "";
            this.Session["editarDetalle"] = true;
            this.hdRegistro.Value = this.gvLista.SelectedRow.Cells[15].Text;
            cargarLotes();
            if (this.ddlConcepto.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
                    this.ddlConcepto.SelectedValue = this.gvLista.SelectedRow.Cells[2].Text;
                manejoConcepto();
            }

            if (this.ddlGrupoC.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
                {
                    this.ddlGrupoC.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;
                    manejoCaracteristicaGrupo();

                }
            }

            if (this.ddlCaracteristica.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
                    this.ddlCaracteristica.SelectedValue = this.gvLista.SelectedRow.Cells[4].Text;
            }

            if (this.ddlUmedida.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[13].Text != "&nbsp;")
                    this.ddlUmedida.SelectedValue = this.gvLista.SelectedRow.Cells[13].Text;

            }
            if (this.txtFechaD.Visible == true)
            {
                if (this.gvLista.SelectedRow.Cells[8].Text != "&nbsp;")
                {
                    this.txtFechaD.Text = Convert.ToDateTime(this.gvLista.SelectedRow.Cells[8].Text).ToShortDateString();
                    this.cldFechaD.SelectedDate = Convert.ToDateTime(this.gvLista.SelectedRow.Cells[8].Text);
                }
            }

            if (this.gvLista.SelectedRow.Cells[12].Text != "&nbsp;")
            {
                txtCantidad.Text = this.gvLista.SelectedRow.Cells[12].Text;
                this.Session["cant"] = Convert.ToDecimal(this.gvLista.SelectedRow.Cells[12].Text);
            }
            else
                txtCantidad.Text = "0";


            if (this.gvLista.SelectedRow.Cells[9].Text != "&nbsp;")
            {
                ddlLote.SelectedValue = this.gvLista.SelectedRow.Cells[9].Text;
                cargarLineas();
            }
            else
                ddlLote.SelectedValue = "";


            if (this.gvLista.SelectedRow.Cells[10].Text != "&nbsp;")
                ddlLinea.SelectedValue = this.gvLista.SelectedRow.Cells[10].Text;
            else
                ddlLinea.SelectedValue = "";

            if (this.gvLista.SelectedRow.Cells[11].Text != "&nbsp;")
                txtPalma.Text = this.gvLista.SelectedRow.Cells[11].Text;
            else
                txtPalma.Text = "";

            if (this.gvLista.SelectedRow.Cells[14].Text != "&nbsp;")
            {
                StringWriter detalle = new StringWriter();
                // Decode the encoded string.
                HttpUtility.HtmlDecode(this.gvLista.SelectedRow.Cells[14].Text, detalle);
                txtDetalle.Text = detalle.ToString();
            }
            else
                txtDetalle.Text = "";


            List<CtransaccionSanidad> listaTransaccion = null;

            listaTransaccion = (List<CtransaccionSanidad>)this.Session["transaccion"];
            listaTransaccion.RemoveAt(this.gvLista.SelectedRow.RowIndex);

            this.gvLista.DataSource = listaTransaccion;
            this.gvLista.DataBind();

          


        }
        catch (Exception ex)
        {
            CcontrolesUsuarios.MensajeError("Error al cargar los campos del registro en el formulario. Correspondiente a: " + ex.Message, this.nilblInformacion);
        }
    }

    private void registroMayor(List<CtransaccionSanidad> listaTransaccion)
    {
        int mayor = 0;

        for (int x = 0; x < listaTransaccion.Count; x++)
        {

            if (listaTransaccion[x].Registro > mayor)
            {
                mayor = listaTransaccion[x].Registro;
                x = 0;
            }
        }

        this.hdRegistro.Value = mayor.ToString();
    }

    protected void niddlOperador_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (this.niddlOperador.SelectedValue.ToString() == "between")
        {
            this.nitxtValor2.Visible = true;
        }
        else
        {
            this.nitxtValor2.Visible = false;
            this.nitxtValor1.Text = "";
        }

        this.nitxtValor1.Focus();
    }
    protected void niimbAdicionar_Click(object sender, ImageClickEventArgs e)
    {
        foreach (GridViewRow registro in this.gvParametros.Rows)
        {
            if (Convert.ToString(this.niddlCampo.SelectedValue) == registro.Cells[1].Text &&
                Convert.ToString(this.niddlOperador.SelectedValue) == Server.HtmlDecode(registro.Cells[2].Text) &&
                this.nitxtValor1.Text == registro.Cells[3].Text)
            {
                return;
            }
        }

        operadores = new Coperadores(
            Convert.ToString(this.niddlCampo.SelectedValue),
            Server.HtmlDecode(Convert.ToString(this.niddlOperador.SelectedValue)),
            this.nitxtValor1.Text,
            this.nitxtValor2.Text);

        List<Coperadores> listaOperadores = null;

        if (this.Session["operadores"] == null)
        {
            listaOperadores = new List<Coperadores>();
            listaOperadores.Add(operadores);
        }
        else
        {
            listaOperadores = (List<Coperadores>)Session["operadores"];
            listaOperadores.Add(operadores);
        }

        this.Session["operadores"] = listaOperadores;

        this.imbBusqueda.Visible = true;
        this.gvParametros.DataSource = listaOperadores;
        this.gvParametros.DataBind();
        this.gvTransaccion.DataSource = null;
        this.gvTransaccion.DataBind();
        this.nilblRegistros.Text = "Nro. Registros 0";
        this.nilblMensajeEdicion.Text = "";

        EstadoInicialGrillaTransacciones();
    }
    protected void nitxtValor1_TextChanged(object sender, EventArgs e)
    {
        if (this.nitxtValor1.Text.Length > 0 && Convert.ToString(this.niddlCampo.SelectedValue).Length > 0)
        {
            this.niimbAdicionar.Enabled = true;
            this.imbBusqueda.Enabled = true;
        }
        else
        {
            this.niimbAdicionar.Enabled = false;
            this.imbBusqueda.Enabled = false;
        }

        this.niimbAdicionar.Focus();
    }
    protected void imbBusqueda_Click(object sender, ImageClickEventArgs e)
    {
        this.nilblMensajeEdicion.Text = "";

        BusquedaTransaccion();
    }
    protected void gvTransaccion_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        this.nilblMensajeEdicion.Text = "";

        using (TransactionScope ts = new TransactionScope())
        {
            try
            {
                bool anulado = false;

                foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[6].Controls)
                {
                    anulado = ((CheckBox)objControl).Checked;
                }

                if (anulado == true)
                {
                    this.nilblMensajeEdicion.Text = "Registro anulado no es posible su edición";
                    return;
                }
                bool ejecutado = false;

                foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[7].Controls)
                {
                    ejecutado = ((CheckBox)objControl).Checked;
                }

                if (ejecutado == true)
                {
                    this.nilblMensajeEdicion.Text = "Registro ejecutado no es posible su edición";
                    return;
                }

                bool aprobado = false;
                foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[8].Controls)
                {
                    aprobado = ((CheckBox)objControl).Checked;
                }

                if (aprobado == true)
                {
                    CcontrolesUsuario.MensajeError("Registro aprobado no es posible su edición", nilblMensajeEdicion);
                    return;
                }


                if (tipoTransaccion.RetornaTipoBorrado(this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text, Convert.ToInt16(Session["empresa"])) == "E")
                {
                    object[] objValores = new object[]{
                         Convert.ToInt16(Session["empresa"]),
                        Convert.ToString(this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text).Trim(),
                        Convert.ToString(this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text).Trim()
                    };

                    switch (CentidadMetodos.EntidadInsertUpdateDelete("asanidadDetalle", "elimina", "ppa", objValores))
                    {
                        case 0:
                            switch (CentidadMetodos.EntidadInsertUpdateDelete("asanidad", "elimina", "ppa", objValores))
                            {
                                case 0:
                                    this.nilblMensajeEdicion.Text = "Registro Eliminado Satisfactoriamente";
                                    BusquedaTransaccion();
                                    ts.Complete();
                                    break;

                                case 1:

                                    this.nilblMensajeEdicion.Text = "Error al eliminar el registro. Operación no realizada";
                                    break;
                            }
                            break;

                        case 1:

                            this.nilblMensajeEdicion.Text = "Error al eliminar el registro. Operación no realizada";
                            break;
                    }
                }
                else
                {
                    switch (transacciones.AnulaTransaccionSanidad(this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text,
                        this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text, this.Session["usuario"].ToString().Trim(), Convert.ToInt16(Session["empresa"])))
                    {
                        case 0:

                            this.nilblMensajeEdicion.Text = "Registro Anulado Satisfactoriamente N° "+ this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text;
                            BusquedaTransaccion();
                            ts.Complete();
                            break;
                        case 1:
                            this.nilblMensajeEdicion.Text = "Error al anular la transacción. Operación no realizada";
                            break;
                    }
                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al eliminar el registro. Correspondiente a: " + ex.Message, "E");
            }
        }
    }
    protected void gvTransaccion_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        bool anulado = false;

        lbCancelar.Visible = true;
        foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[6].Controls)
        {
            anulado = ((CheckBox)objControl).Checked;
        }

        if (anulado == true)
        {
            CcontrolesUsuario.MensajeError("Registro anulado no es posible su edición", nilblMensajeEdicion);
            return;
        }

        bool ejecutado = false;
        foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[7].Controls)
        {
            ejecutado = ((CheckBox)objControl).Checked;
        }

        if (ejecutado == true)
        {
            CcontrolesUsuario.MensajeError("Registro anulado no es posible su edición", nilblMensajeEdicion);
            return;
        }

        bool aprobado = false;
        foreach (Control objControl in gvTransaccion.Rows[e.RowIndex].Cells[8].Controls)
        {
            aprobado = ((CheckBox)objControl).Checked;
        }

        if (aprobado == true)
        {
            CcontrolesUsuario.MensajeError("Registro aprobado no es posible su edición", nilblMensajeEdicion);
            return;
        }


        try
        {

            DateTime fecha = Convert.ToDateTime(this.gvTransaccion.Rows[e.RowIndex].Cells[4].Text);
            

            manejoEncabezadoEdicion();
            CargarTipoTransaccion();
            this.nilblMensajeEdicion.Text = "";
            this.nilblInformacion.Text = "";
            this.Session["editar"] = true;
            this.Session["transaccion"] = null;
            txtNumero.Enabled = false;
            ddlTipoDocumento.Enabled = false;
            lbRegistrar.Visible = false;
            upConsulta.Visible = false;
            ddlTipoDocumento.SelectedValue = this.gvTransaccion.Rows[e.RowIndex].Cells[2].Text.Trim();
            txtNumero.Text = this.gvTransaccion.Rows[e.RowIndex].Cells[3].Text;
            txtFecha.Text = fecha.ToString();
            CargarCombos();
            ComportamientoTransaccion();
            cargarDetallereferencia();
            txtObservacion.Enabled = true;
            cargarEncabezado();
            cargarDetalle();
            cargarLotes();
            txtRemision.Focus();
            lbRegistrar.Visible = true;
            ddlConcepto.SelectedValue = "";
            upConsulta.Visible = true;

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los datos. Correspondiente a: " + ex.Message, "C");
        }

    }

    private void manejoEncabezadoEdicion()
    {
        CcontrolesUsuario.LimpiarControles(upConsulta.Controls);
        this.nilblInformacion.Text = "";
        this.nilblInformacion.ForeColor = System.Drawing.Color.Red;
        this.lbCancelar.Visible = true;
        this.nilbNuevo.Visible = false;
        this.lblTipoDocumento.Visible = true;
        this.ddlTipoDocumento.Visible = true;
        this.ddlTipoDocumento.Enabled = false;
        this.lblNumero.Visible = true;
        this.txtNumero.Visible = true;
        this.txtNumero.Text = "";
        this.Session["transaccion"] = null;
        this.niimbImprimir.Visible = false;
    }
    protected void lbFechaD_Click(object sender, EventArgs e)
    {
        this.cldFechaD.Visible = true;
        this.txtFechaD.Visible = false;
        this.cldFechaD.SelectedDate = Convert.ToDateTime(null);
    }
    protected void cldFechaD_SelectionChanged(object sender, EventArgs e)
    {
        this.cldFechaD.Visible = false;
        this.txtFechaD.Visible = true;
        this.txtFechaD.Text = this.cldFechaD.SelectedDate.ToString();
        //this.txtFechaD.Enabled = false;
    }
    protected void ddlSeccion_SelectedIndexChanged(object sender, EventArgs e)
    {
        cargarLotes();
    }
    protected void ddlConcepto_SelectedIndexChanged(object sender, EventArgs e)
    {
        manejoConcepto();

    }

    private void manejoConcepto()
    {
        CcontrolesUsuarios.LimpiarControles(upDetalle.Controls);
        CcontrolesUsuarios.HabilitarControles(upDetalle.Controls);
        ConfiguracionNovedad(ddlConcepto.SelectedValue.ToString().Trim());

        if (novedades.validaManejaCaracteristicas(ddlConcepto.SelectedValue.Trim(),  Convert.ToInt32( this.Session["empresa"])) == 1)
        {
            ddlGrupoC.DataSource = gcarateristica.BuscarEntidad("",  Convert.ToInt32( this.Session["empresa"]));
            ddlGrupoC.DataValueField = "codigo";
            ddlGrupoC.DataTextField = "descripcion";
            ddlGrupoC.DataBind();
            this.ddlGrupoC.Items.Insert(0, new ListItem("", ""));
            this.ddlGrupoC.SelectedValue = "";
            ddlGrupoC.Visible = true;
            ddlGrupoC.Enabled = true;
            lblGrupoC.Visible = true;
            lblCaracteristica.Visible = true;
            ddlCaracteristica.Visible = true;
        }
        else
        {
            ddlGrupoC.DataSource = null;
            ddlGrupoC.DataBind();
            ddlCaracteristica.DataSource = null;
            ddlCaracteristica.DataBind();
            ddlGrupoC.Visible = false;
            ddlGrupoC.Enabled = false;
            lblGrupoC.Visible = false;
            lblCaracteristica.Visible = false;
            ddlCaracteristica.Visible = false;
        }

        nilblInformacion.Text = "";
        ScriptManager1.SetFocus(ddlConcepto);

    }

    protected void gvParametros_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        List<Coperadores> listaOperadores = null;
        try
        {
            listaOperadores = (List<Coperadores>)Session["operadores"];
            listaOperadores.RemoveAt(e.RowIndex);
            this.gvParametros.DataSource = listaOperadores;
            this.gvParametros.DataBind();
            this.gvTransaccion.DataSource = null;
            this.gvTransaccion.DataBind();
            this.nilblRegistros.Text = "Nro. registros 0";
            this.nilblMensajeEdicion.Text = "";
            if (this.gvParametros.Rows.Count == 0)
                this.imbBusqueda.Visible = false;
            EstadoInicialGrillaTransacciones();
        }
        catch
        {

        }
    }

    protected void ddlGrupoC_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            manejoCaracteristicaGrupo();
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los datos. Correspondiente a: " + ex.Message, "C");
        }
    }

    private void manejoCaracteristicaGrupo()
    {
        DataView caracteristicas = caracteristica.RetornaCaracteristicaGrupo(Convert.ToInt32(ddlGrupoC.SelectedValue.Trim()),  Convert.ToInt32( this.Session["empresa"]));
        ddlCaracteristica.DataSource = caracteristicas;
        ddlCaracteristica.DataValueField = "codigo";
        ddlCaracteristica.DataTextField = "descripcion";
        ddlCaracteristica.DataBind();
        this.ddlCaracteristica.Items.Insert(0, new ListItem("", ""));
        this.ddlCaracteristica.SelectedValue = "";
    }

    protected void gvTransaccion_RowCommand(object sender, GridViewCommandEventArgs e)
    {

        using (TransactionScope ts = new TransactionScope())
        {
            try
            {

                if (e.CommandName == "Insert")
                {
                    bool anulado = false;
                    int index = Convert.ToInt32(e.CommandArgument);

                    foreach (Control objControl in gvTransaccion.Rows[index].Cells[6].Controls)
                    {
                        anulado = ((CheckBox)objControl).Checked;
                    }

                    if (anulado == true)
                    {
                        this.nilblMensajeEdicion.Text = "Registro anulado no es posible su edición";
                        return;
                    }
                    bool ejecutado = false;

                    foreach (Control objControl in gvTransaccion.Rows[index].Cells[7].Controls)
                    {
                        ejecutado = ((CheckBox)objControl).Checked;
                    }

                    if (ejecutado == true)
                    {
                        this.nilblMensajeEdicion.Text = "Registro ejecutado no es posible su edición";
                        return;
                    }

                    switch (transacciones.ApruebaTransaccionSanidad(this.gvTransaccion.Rows[index].Cells[2].Text,
                           this.gvTransaccion.Rows[index].Cells[3].Text, this.Session["usuario"].ToString().Trim(), Convert.ToInt16(Session["empresa"])))
                    {
                        case 0:

                            this.nilblMensajeEdicion.Text = "Registro aprobado Satisfactoriamente N°" + this.gvTransaccion.Rows[index].Cells[3].Text;
                            BusquedaTransaccion();
                            ts.Complete();
                            break;
                        case 1:
                            this.nilblMensajeEdicion.Text = "Error al aprobar la transacción. Operación no realizada";
                            break;
                    }

                }
            }
            catch (Exception a)
            {
                ManejoError("Error al aprobar el registro. Correspondiente a: " + a.Message, "E");
            }
        }
    }
    protected void gvLista_Sorting(object sender, GridViewSortEventArgs e)
    {

    }


    #endregion Evento


}