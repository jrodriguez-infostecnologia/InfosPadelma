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
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    CtipoTransaccion tipoTransaccion = new CtipoTransaccion();
    Ctransacciones transacciones = new Ctransacciones();


    #endregion Instancias


    private void guardar()
    {
        string numero = "";
        this.lblVariables.Text = "";

        try
        {
            foreach (DataRowView registro in vehiculos.GetBasculaRemision(this.txtRemision.Text, Convert.ToInt16(Session["empresa"])))
                numero = Convert.ToString(registro.Row.ItemArray.GetValue(2));

            using (TransactionScope ts = new TransactionScope())

                try
                {

                    string usuario = ConfigurationManager.AppSettings["usuarioTarima"];
                    string coperativa = rblCooperativa.SelectedValue;

                    if (coperativa == null)
                        coperativa = "";

                    switch (vehiculos.RegistroAnalisis(ConfigurationManager.AppSettings["tipomov"].ToString(), numero, lblIdProducto.Text, usuario, Convert.ToInt16(txtSacos.Text), 0, 0, 0, 0, 0, 0, 0, 0, Convert.ToString(this.ddlBodega.SelectedValue), Convert.ToInt16(Session["empresa"]), coperativa, Convert.ToDecimal(txtPesoSacos.Text)))
                    {
                        case 1:
                            this.lblResultados.Text = "Error al insertar los análisis";
                            break;
                    }

                    if (gvVariedad.Rows.Count > 0)
                    {
                        foreach (GridViewRow registro in this.gvVariedad.Rows)
                        {
                            object[] objValores = new object[] {                           
                            registro.Cells[0].Text,
                            Convert.ToInt16(Session["empresa"]),
                            DateTime.Now,
                           numero,
                            ConfigurationManager.AppSettings["tipomov"].ToString().Trim(),
                            this.Session["usuario"],
                            ((TextBox)registro.FindControl("txtValor")).Text.Replace(",","")
                        };

                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "inserta", "ppa", objValores) == 1)
                            {
                                this.lblResultados.Text = "Error al insertar los análisis. Operación no realizada";
                                return;
                            }
                        }
                    }

                    if (gvCaracteristicas.Rows.Count > 0)
                    {
                        foreach (GridViewRow registro in this.gvCaracteristicas.Rows)
                        {
                            object[] objValores = new object[] {                           
                            registro.Cells[0].Text,
                            Convert.ToInt16(Session["empresa"]),
                            DateTime.Now,
                           numero,
                            ConfigurationManager.AppSettings["tipomov"].ToString().Trim(),
                            this.Session["usuario"],
                            ((TextBox)registro.FindControl("txtValor")).Text.Replace(",","")
                        };

                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "inserta", "ppa", objValores) == 1)
                            {
                                this.lblResultados.Text = "Error al insertar los análisis. Operación no realizada";
                                return;
                            }
                        }
                    }

                    if (gvVariables.Rows.Count > 0)
                    {
                        foreach (GridViewRow registro in this.gvVariables.Rows)
                        {
                            object[] objValores = new object[] {                           
                            registro.Cells[0].Text,
                            Convert.ToInt16(Session["empresa"]),
                            DateTime.Now,
                           numero,
                            ConfigurationManager.AppSettings["tipomov"].ToString().Trim(),
                            this.Session["usuario"],
                            ((TextBox)registro.FindControl("txtValor")).Text.Replace(",","")
                        };

                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "inserta", "ppa", objValores) == 1)
                            {
                                this.lblResultados.Text = "Error al insertar los análisis. Operación no realizada";
                                return;
                            }
                        }
                    }

                    if (gvResultados.Rows.Count > 0)
                    {
                        foreach (GridViewRow registro in this.gvResultados.Rows)
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

                            if (CentidadMetodos.EntidadInsertUpdateDelete("lRegistroAnalisis", "inserta", "ppa", objValores) == 1)
                            {
                                this.lblResultados.Text = "Error al insertar los análisis. Operación no realizada";
                                return;
                            }
                        }
                    }

                    switch (vehiculos.ActualizaEstadoBascula(ConfigurationManager.AppSettings["tipomov"].ToString().Trim(), numero, "AR", "", Convert.ToInt16(Session["empresa"])))
                    {
                        case 0:

                            CcontrolesUsuario.LimpiarControles(this.Page.Controls);
                            lblMensajeFinal.Text = "Análisis registrados satisfactoriamente";
                            ts.Complete();
                            pBodega.Visible = false;
                            pRemision.Visible = false;
                            pResultados.Visible = false;
                            pFinal.Visible = true;
                            break;
                        case 1:
                            this.lblResultados.Text = "Error al actualizar el estado del vehículo en báscula";
                            break;
                    }
                }
                catch (Exception ex)
                {
                    this.lblResultados.Text = "Error al insertar el registro. Correspondiente a: " + ex.Message;
                }
        }
        catch (Exception ex)
        {
            this.lblVariables.Text = "Error al insertar el registro. Correspondiente a: " + ex.Message;
        }

    }
    private void CargaCombos()
    {
        try
        {
            this.ddlBodega.DataSource = vehiculos.SeleccionaBodegaTipo(ConfigurationManager.AppSettings["tipomov"].ToString(), lblIdProducto.Text, Convert.ToInt16(Session["empresa"]));
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
        //try
        //{
        //    DataView producto = vehiculos.GetProductoTransaccion(
        //       ConfigurationManager.AppSettings["tipomov"].ToString(), Convert.ToInt16(this.Session["empresa"]));
        //    this.ddlProducto.DataSource = producto;
        //    this.ddlProducto.DataValueField = "producto";
        //    this.ddlProducto.DataTextField = "descripcion";
        //    this.ddlProducto.DataBind();
        //    this.ddlProducto.Items.Insert(0, new ListItem("Seleccione una opción...", ""));
        //}
        //catch (Exception ex)
        //{
        //    this.lblMensaje.Text = "Error al cargar productos. Correspondiente a: " + ex.Message;
        //}
    }





    protected void Page_Load(object sender, EventArgs e)
    {


        Session["usuario"] = ConfigurationManager.AppSettings["usuarioTarima"].ToString();
        Session["empresa"] = ConfigurationManager.AppSettings["empresa"].ToString();
        Session["clave"] = ConfigurationManager.AppSettings["claveTarima"].ToString();

        try
        {




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

    protected void btnSiguiente_Click(object sender, ImageClickEventArgs e)
    {
        this.lblMensaje.Text = "";

        if (this.txtRemision.Text.Trim().Length == 0)
        {
            this.lblMensaje.Text = "Campos vacios por favor corrija";
        }
        else
        {
            if (vehiculos.VerificaRemision(this.txtRemision.Text, Convert.ToInt16(lblIdProducto.Text), Convert.ToInt16(Session["empresa"])) == 1)
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
        guardar();

    }

    protected void txtRemision_TextChanged1(object sender, EventArgs e)
    {
        this.lblMensaje.Text = "";

        try
        {
            if (vehiculos.VerificaRemision(this.txtRemision.Text, 0, Convert.ToInt16(Session["empresa"])) == 1)
            {
                this.lblMensaje.Text = "Remisión no valida";
                this.txtRemision.Text = "";
                this.lblVehiculo.Text = "";
            }
            else
            {

                foreach (DataRowView registro in vehiculos.RetornaDatosVehiculoRemision(this.txtRemision.Text, Convert.ToInt16(Session["empresa"])))
                {
                    this.lblVehiculo.Text = Convert.ToString(registro.Row.ItemArray.GetValue(2));
                    this.lblConductor.Text = Convert.ToString(registro.Row.ItemArray.GetValue(1));
                    this.lblFinca.Text = Convert.ToString(registro.Row.ItemArray.GetValue(7));
                    this.lblIdProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(8));
                    this.lblNombreProducto.Text = Convert.ToString(registro.Row.ItemArray.GetValue(9));
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
        lblMensajeBodega.Text = "";
        if (ddlBodega.SelectedValue.Trim().Length == 0)
        {
            lblMensajeBodega.Text = "Debe seleccionar una bodega para continuar";
            return;
        }

        pSacos.Visible = true;
        pBodega.Visible = false;

    }
    protected void btnAtrasBodega_Click(object sender, ImageClickEventArgs e)
    {
        pBodega.Visible = false;
        pRemision.Visible = true;
        lblMensajeBodega.Text = "";
    }
    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        pRemision.Visible = true;
        Response.Redirect("~/Inicio.aspx");
    }
    protected void btnSiguienteSacos_Click(object sender, ImageClickEventArgs e)
    {
        this.lblSacos.Text = "";


        if (this.txtSacos.Text.Trim().Length == 0 || this.txtPesoSacos.Text.Length == 0)
        {
            this.lblSacos.Text = "Campos Vacios !!";
        }
        else
        {
            try
            {
                Convert.ToInt16(this.txtSacos.Text);
                Convert.ToDecimal(this.txtPesoSacos.Text);
            }
            catch
            {

                this.lblSacos.Text = "Solo se permiten numeros";
                return;
            }

            try
            {
                DataView variedades = tipoTransaccion.SeleccionaProductoMovimiento(Convert.ToInt32(lblIdProducto.Text), Convert.ToUInt16(ConfigurationManager.AppSettings["empresa"].ToString()), ConfigurationManager.AppSettings["Modulo"].ToString());
                variedades.Sort = "orden";
                variedades.RowFilter = "tipo = 'V' and resultado = 0";
                gvVariedad.DataSource = variedades;
                gvVariedad.DataBind();

            }
            catch (Exception ex)
            {
                this.lblSacos.Text = "Error al cargar variedades debido a :" + ex.Message;
                return;
            }

            this.pSacos.Visible = false;
            this.pVariedad.Visible = true;

        }
    }

    protected void btnAtrasSacos_Click(object sender, ImageClickEventArgs e)
    {
        txtPesoSacos.Text = "0";
        txtSacos.Text = "0";
        pSacos.Visible = false;
        pBodega.Visible = true;
        lblSacos.Text = "";
    }
    protected void btnSiguienteVariedades_Click(object sender, ImageClickEventArgs e)
    {
        this.lblVariedad.Text = "";
        decimal sumavariedad = 0;

        bool validar = false;
        try
        {
            foreach (GridViewRow gvr in gvVariedad.Rows)
            {
                sumavariedad += Convert.ToDecimal(((TextBox)gvr.FindControl("txtValor")).Text);
            }
        }
        catch
        {

            this.lblVariedad.Text = "Solo se permiten numeros";
            return;
        }



        if (Convert.ToDecimal(txtSacos.Text) != sumavariedad & chkSacos.Checked == true)
        {
            this.lblVariedad.Text = "La cantidad en la variedad no corresponde al total de sacos";
            return;
        }

        foreach (GridViewRow gvr in gvVariedad.Rows)
        {
            if (((TextBox)gvr.FindControl("txtValor")).Text.Trim().Length == 0)
            {
                validar = true;
            }
        }

        if (validar)
        {
            this.lblVariedad.Text = "Campos en cero";
        }
        else
        {


            try
            {
                DataView caracteristica = tipoTransaccion.SeleccionaProductoMovimiento(Convert.ToInt32(lblIdProducto.Text), Convert.ToUInt16(ConfigurationManager.AppSettings["empresa"].ToString()), ConfigurationManager.AppSettings["Modulo"].ToString());
                caracteristica.Sort = "orden";
                caracteristica.RowFilter = "tipo = 'C' and resultado=0";
                gvCaracteristicas.DataSource = caracteristica;
                gvCaracteristicas.DataBind();

            }
            catch (Exception ex)
            {
                this.lblVariedad.Text = "Error al cargar variedades debido a :" + ex.Message;
                return;
            }

            if (chkSacos.Checked == true)
            {
                try
                {
                    DataView variables = tipoTransaccion.SeleccionaProductoMovimiento(Convert.ToInt32(lblIdProducto.Text), Convert.ToUInt16(ConfigurationManager.AppSettings["empresa"].ToString()), ConfigurationManager.AppSettings["Modulo"].ToString());
                    variables.Sort = "orden";
                    variables.RowFilter = "tipo = 'M' and resultado=0";
                    gvVariables.DataSource = variables;
                    gvVariables.DataBind();

                }
                catch (Exception ex)
                {
                    this.lblCaracteristicas.Text = "Error al cargar variedades debido a :" + ex.Message;
                    return;
                }

            }

            if (chkSacos.Checked == true)
            {
                pResultados.Visible = true;
                pVariedad.Visible = false;
                calcular();
            }
            else
            {
                this.pCaracteristca.Visible = true;
                this.pVariedad.Visible = false;
            }




        }
    }

    protected void btnAtrasVariedad_Click(object sender, ImageClickEventArgs e)
    {
        gvVariedad.DataSource = null;
        gvVariedad.DataBind();
        pVariedad.Visible = false;
        pSacos.Visible = true;
    }

    protected void btnSiguienteCaracteristica_Click(object sender, ImageClickEventArgs e)
    {
        decimal sumaCaracteristicas = 0;
        decimal sumaVariedad = 0;



        bool validar = false;
        try
        {
            foreach (GridViewRow gvr in gvCaracteristicas.Rows)
            {
                Convert.ToDecimal(((TextBox)gvr.FindControl("txtValor")).Text);
            }
        }
        catch
        {

            this.lblCaracteristicas.Text = "Solo se permiten numeros";
            return;
        }




        foreach (GridViewRow gvr in gvCaracteristicas.Rows)
        {
            if (((TextBox)gvr.FindControl("txtValor")).Text.Trim().Length == 0)
            {
                validar = true;
            }
        }


        foreach (GridViewRow gvr in gvCaracteristicas.Rows)
        {
            if (((TextBox)gvr.FindControl("txtValor")).Text.Trim().Length == 0)
            {
                sumaCaracteristicas += Convert.ToDecimal(((TextBox)gvr.FindControl("txtValor")).Text);
            }
        }

        foreach (GridViewRow gvr in gvVariedad.Rows)
        {
            if (((TextBox)gvr.FindControl("txtValor")).Text.Trim().Length == 0)
            {
                sumaVariedad += Convert.ToDecimal(((TextBox)gvr.FindControl("txtValor")).Text);
            }
        }

        if (sumaCaracteristicas > sumaVariedad)
        {
            this.lblCaracteristicas.Text = "las caracteristicas no pueden ser mayor a las variedades";
            return;
        }


        if (validar)
        {
            this.lblCaracteristicas.Text = "Campos en cero";
        }
        else
        {


            try
            {
                DataView variables = tipoTransaccion.SeleccionaProductoMovimiento(Convert.ToInt32(lblIdProducto.Text), Convert.ToUInt16(ConfigurationManager.AppSettings["empresa"].ToString()), ConfigurationManager.AppSettings["Modulo"].ToString());
                variables.Sort = "orden";
                variables.RowFilter = "tipo = 'M' and ( resultado=0 or mCalcular=1)";
                gvVariables.DataSource = variables;
                gvVariables.DataBind();

                foreach (GridViewRow gv in gvVariables.Rows)
                {
                    ((TextBox)gv.FindControl("txtValor")).Enabled = !((CheckBox)gv.FindControl("ChkMostrar")).Checked;
                }

            }
            catch (Exception ex)
            {
                this.lblCaracteristicas.Text = "Error al cargar variedades debido a :" + ex.Message;
                return;
            }




            this.pVariables.Visible = true;
            this.pCaracteristca.Visible = false;
        }


    }
    protected void btnSiguienteAnalisis_Click(object sender, ImageClickEventArgs e)
    {

        bool validar = false;
        decimal sumaVariables = 0;
        decimal sumaVariedad = 0;



        if (validar)
            this.lblVariables.Text = "Campos en cero";
        else
            calcular();
    }

    private void calcular()
    {
        try
        {
            string varObj = "";
            DataView vResultado = tipoTransaccion.SeleccionaProductoMovimiento(Convert.ToInt32(lblIdProducto.Text), Convert.ToUInt16(ConfigurationManager.AppSettings["empresa"].ToString()), ConfigurationManager.AppSettings["Modulo"].ToString());
            vResultado.Sort = "orden";
            vResultado.RowFilter = "tipo = 'M' and resultado=1 and mCalcular=0";
            gvResultados.DataSource = vResultado;
            gvResultados.DataBind();

            foreach (DataRowView registro in transacciones.GetMovimientoResultadoProducto(Convert.ToInt16(lblIdProducto.Text), Convert.ToInt16(Session["empresa"]), ConfigurationManager.AppSettings["Modulo"].ToString()))
            {
                varObj = "";

                foreach (GridViewRow fila in gvVariedad.Rows)
                {
                    varObj = varObj + "|" + fila.Cells[0].Text + "(" + Convert.ToDecimal(((TextBox)fila.FindControl("txtValor")).Text) + ")|";
                }

                foreach (GridViewRow fila in gvCaracteristicas.Rows)
                {
                    varObj = varObj + "|" + fila.Cells[0].Text + "(" + Convert.ToDecimal(((TextBox)fila.FindControl("txtValor")).Text) + ")|";
                }

                foreach (GridViewRow fila in gvVariables.Rows)
                {
                    varObj = varObj + "|" + fila.Cells[0].Text + "(" + Convert.ToDecimal(((TextBox)fila.FindControl("txtValor")).Text) + ")|";
                }

                foreach (GridViewRow filaResultado in gvResultados.Rows)
                {
                    decimal resultado = Convert.ToDecimal(((TextBox)filaResultado.FindControl("txtResultado")).Text);
                    decimal sacos = Convert.ToInt32(txtSacos.Text);
                    decimal resultadosacos = resultado + sacos;

                    if (chkSacos.Checked == true & resultado == 0)
                        varObj = varObj + "|" + filaResultado.Cells[0].Text.Trim() + "(" + resultadosacos + ")|";
                    else
                        varObj = varObj + "|" + filaResultado.Cells[0].Text.Trim() + "(" + resultado + ")|";

                }

                foreach (DataRowView resultado in transacciones.EjecutaFormulaA(lblIdProducto.Text, Convert.ToString(registro.Row.ItemArray.GetValue(0)), varObj, "R", DateTime.Now, Convert.ToInt16(Session["empresa"])))
                {
                    foreach (GridViewRow filaResultado in gvResultados.Rows)
                    {
                        if (filaResultado.Cells[0].Text == resultado.Row.ItemArray.GetValue(2).ToString())
                            ((TextBox)filaResultado.FindControl("txtResultado")).Text = Convert.ToString(decimal.Round(Convert.ToDecimal(resultado.Row.ItemArray.GetValue(0)), 2));
                    }

                }

                pVariables.Visible = false;
                pResultados.Visible = true;
            }
        }
        catch (Exception ex)
        {
            lblVariables.Text = "Error al calcular. Correspondiente a: " + ex.Message;
            return;
        }
    }

    private void calcularAnalisis()
    {
        try
        {
            string varObj = "";

            foreach (DataRowView registro in transacciones.GetMovimientoResultadoProducto(Convert.ToInt16(lblIdProducto.Text), Convert.ToInt16(Session["empresa"]), ConfigurationManager.AppSettings["Modulo"].ToString()))
            {
                varObj = "";

                foreach (GridViewRow fila in gvCaracteristicas.Rows)
                {
                    varObj = varObj + "|" + fila.Cells[0].Text + "(" + Convert.ToDecimal(((TextBox)fila.FindControl("txtValor")).Text) + ")|";
                }

                foreach (GridViewRow filaResultado in gvVariedad.Rows)
                {
                    decimal resultado = Convert.ToDecimal(((TextBox)filaResultado.FindControl("txtValor")).Text);
                    decimal sacos = Convert.ToInt32(txtSacos.Text);
                    decimal resultadosacos = resultado + sacos;

                    if (chkSacos.Checked == true & resultado == 0)
                        varObj = varObj + "|" + filaResultado.Cells[0].Text.Trim() + "(" + resultadosacos + ")|";
                    else
                        varObj = varObj + "|" + filaResultado.Cells[0].Text.Trim() + "(" + resultado + ")|";
                }


                foreach (GridViewRow filaResultado in gvVariables.Rows)
                {
                    decimal resultado = Convert.ToDecimal(((TextBox)filaResultado.FindControl("txtValor")).Text);
                    decimal sacos = Convert.ToInt32(txtSacos.Text);
                    decimal resultadosacos = resultado + sacos;

                    if (chkSacos.Checked == true & resultado == 0)
                        varObj = varObj + "|" + filaResultado.Cells[0].Text.Trim() + "(" + resultadosacos + ")|";
                    else
                        varObj = varObj + "|" + filaResultado.Cells[0].Text.Trim() + "(" + resultado + ")|";
                }
                foreach (DataRowView resultado in transacciones.EjecutaFormulaA(lblIdProducto.Text, Convert.ToString(registro.Row.ItemArray.GetValue(0)), varObj, "R", DateTime.Now, Convert.ToInt16(Session["empresa"])))
                {
                    foreach (GridViewRow filaResultado in gvVariables.Rows)
                    {
                        if (filaResultado.Cells[0].Text == resultado.Row.ItemArray.GetValue(2).ToString())
                            ((TextBox)filaResultado.FindControl("txtValor")).Text = Convert.ToString(decimal.Round(Convert.ToDecimal(resultado.Row.ItemArray.GetValue(0)), 2));
                    }
                }
            }
        }
        catch (Exception ex)
        {


        }
    }

    protected void btnAtrasCaracteristica_Click(object sender, ImageClickEventArgs e)
    {
        pCaracteristca.Visible = false;
        pVariedad.Visible = true;
        gvCaracteristicas.DataSource = null;
        gvCaracteristicas.DataBind();
        lblCaracteristicas.Text = "";
    }
    protected void btnAtrasResultado_Click(object sender, ImageClickEventArgs e)
    {
        lblResultados.Text = "";
        if (chkSacos.Checked == true)
        {
            pVariedad.Visible = true;
            pResultados.Visible = false;
        }
        else
        {
            pVariables.Visible = true;
            pResultados.Visible = false;

        }
    }

    protected void btnAtrasAnalisis_Click(object sender, ImageClickEventArgs e)
    {
        pVariables.Visible = false;
        pCaracteristca.Visible = true;
        lblAnalisis.Text = "";
    }

    protected void txtValor_TextChanged1(object sender, EventArgs e)
    {
        try
        {
            calcularAnalisis();
            ((TextBox)sender).Focus();
        }
        catch (Exception ex)
        {
        }
    }
    protected void btnCalcular_Click(object sender, ImageClickEventArgs e)
    {
        try
        {
            calcularAnalisis();
            btnSiguienteAnalisis.Visible = true;

        }
        catch (Exception ex)
        {
            btnSiguienteAnalisis.Visible = false;
        }
    }
}