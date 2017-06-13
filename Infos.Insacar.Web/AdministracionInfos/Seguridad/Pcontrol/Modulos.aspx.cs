using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;
using System.Transactions;
using System.Data;

public partial class Facturacion_Padministracion_Operaciones : System.Web.UI.Page
{
    #region Instancias

    Cmodulos modulos = new Cmodulos();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";

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
            if (seguridad.VerificaAccesoOperacion(
                             this.Session["usuario"].ToString(),//usuario
                              ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                              nombrePaginaActual(),//pagina
                             consulta,//operacion
                            Convert.ToInt16(this.Session["empresa"]))//empresa
                            == 0)
            {
                ManejoError("Usuario no autorizado para ejecutar esta operación", consulta);
                return;
            }


            this.gvLista.DataSource = modulos.BuscarEntidad(
                this.nitxtBusqueda.Text);

            this.gvLista.DataBind();

            this.nilblInformacion.Text = this.gvLista.Rows.Count.ToString() + " Registros encontrados";

            seguridad.InsertaLog(
               this.Session["usuario"].ToString(),
               consulta,
                ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
               "ex",
               this.gvLista.Rows.Count.ToString() + " Registros encontrados",
               ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));
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
                  ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        this.Response.Redirect("~/Seguridad/Error.aspx", false);
    }
    private void ManejoExito(string mensaje, string operacion)
    {
        this.nilblMensaje.Text = mensaje;

        CcontrolesUsuario.InhabilitarControles(
            this.Page.Controls);
        CcontrolesUsuario.LimpiarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = true;
        this.filMyFile.Visible = false;

        seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              operacion,
               ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex",
              mensaje,
              ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));

        GetEntidad();
    }

    private void EntidadKey()
    {
        object[] objKey = new object[] { this.txtCodigo.Text };

        try
        {
            if (CentidadMetodos.EntidadGetKey(
                "sModulos",
                "ppa",
                objKey).Tables[0].Rows.Count > 0)
            {
                this.nilblInformacion.Visible = true;
                this.nilblInformacion.Text = "Codigo" + this.txtCodigo.Text + " ya se encuentra registrado";

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
        string operacion = "inserta";

        try
        {

            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                operacion = "actualiza";
                if (Convert.ToBoolean(this.Session["sw"]) == true)
                    Session["ruta"] = lbRuta.Text;
            }

            object[] objValores = new object[]{      
                chkActivo.Checked,
                    this.txtCodigo.Text,
                    this.txtDescripcion.Text,
                    this.txtUrl.Text,
                    Convert.ToString(Session["ruta"]),
                    this.txtOrden.Text
                           };


            switch (CentidadMetodos.EntidadInsertUpdateDelete(
                "sModulos",
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
                  Convert.ToInt16(this.Session["empresa"])) != 0)
            {

                this.nitxtBusqueda.Focus();

                if (this.txtCodigo.Text.Length > 0)
                {
                    this.txtUrl.Focus();
                }

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
    protected void gvLista_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            editar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", editar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = true;

        this.nilblMensaje.Text = "";
        this.txtCodigo.Enabled = false;
        this.filMyFile.Visible = true;
        this.txtUrl.Focus();

        try
        {


            if (this.gvLista.SelectedRow.Cells[2].Text != "&nbsp;")
            {
                this.txtCodigo.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[2].Text);

            }


            if (this.gvLista.SelectedRow.Cells[3].Text != "&nbsp;")
            {
                txtDescripcion.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[3].Text);
            }
            else
            {
                this.txtDescripcion.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[4].Text != "&nbsp;")
            {
                this.txtUrl.Text = Server.HtmlDecode(this.gvLista.SelectedRow.Cells[4].Text);
            }
            else
            {
                this.txtUrl.Text = "";
            }


            if (this.gvLista.SelectedRow.Cells[5].Text != "&nbsp;")
            {
                this.txtOrden.Text = gvLista.SelectedRow.Cells[5].Text;
            }
            else
            {
                this.txtOrden.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[6].Text != "&nbsp;")
            {
                this.lbRuta.Text = gvLista.SelectedRow.Cells[6].Text;
            }
            else
            {
                this.txtOrden.Text = "";
            }

            if (this.gvLista.SelectedRow.Cells[7].Text != "&nbsp;")
            {
                foreach (Control objControl in this.gvLista.SelectedRow.Cells[7].Controls)
                {
                    if (objControl is CheckBox)
                    {
                        this.chkActivo.Checked = ((CheckBox)objControl).Checked;
                    }
                }
            }


        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los campos correspondiente a: " + ex.Message, "C");
        }
    }


    //private void CargaImagen(int codigo)
    //{
    //    string sql = "Select foto From gFoto Where id = " + Convert.ToString(codigo);
    //    SqlConnection SqlConn = new SqlConnection(ConfigurationManager.AppSettings["CadenaConexion"].ToString());
    //    SqlCommand SqlCom = new SqlCommand(sql, SqlConn);

    //    SqlConn.Open();
    //    byte[] byteImage = (byte[])SqlCom.ExecuteScalar();

    //    if (byteImage != null)
    //    {
    //        string Ruta = "\\\\192.168.2.11\\img\\imgen.jpg";
    //            //Path.GetTempFileName().Replace(".tmp",".jpg");
    //        int noBit =byteImage.Length;

    //        using (FileStream nuevoArchivo = new FileStream(Ruta,FileMode.Create,FileAccess.Write))
    //        {
    //            nuevoArchivo.Write(byteImage, 0, noBit);

    //        }
    //        Image1.Visible = true;
    //        Image1.ImageUrl = Ruta;
    //    }
    //    SqlConn.Close();

    //}





    protected void gvLista_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string operacion = "elimina";

        if (seguridad.VerificaAccesoOperacion(
                        this.Session["usuario"].ToString(),//usuario
                         ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                         nombrePaginaActual(),//pagina
                        eliminar,//operacion
                       Convert.ToInt16(this.Session["empresa"]))//empresa
                       == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", eliminar);
            return;
        }
        try
        {
            object[] objValores = new object[] { 
                Convert.ToString(this.gvLista.Rows[e.RowIndex].Cells[2].Text) 
            };

            if (CentidadMetodos.EntidadInsertUpdateDelete(
                "sModulos",
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
    protected void txtConcepto_TextChanged(object sender, EventArgs e)
    {
        EntidadKey();
    }


    #endregion Eventos

    protected void lbNuevo_Click(object sender, ImageClickEventArgs e)
    {
        if (seguridad.VerificaAccesoOperacion(
                            this.Session["usuario"].ToString(),//usuario
                             ConfigurationManager.AppSettings["modulo"].ToString(),//sitio
                             nombrePaginaActual(),//pagina
                            insertar,//operacion
                           Convert.ToInt16(this.Session["empresa"]))//empresa
                           == 0)
        {
            ManejoError("Usuario no autorizado para ejecutar esta operación", insertar);
            return;
        }

        CcontrolesUsuario.HabilitarControles(
            this.Page.Controls);

        this.nilbNuevo.Visible = false;
        this.Session["editar"] = false;


        this.txtCodigo.Enabled = true;
        this.txtCodigo.Focus();
        this.nilblInformacion.Text = "";
        // this.filMyFile.Visible = true;
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
        this.filMyFile.Visible = false;

    }

    private void WriteToFile(string strPath, ref byte[] Buffer)
    {
        FileStream newFile = new FileStream(strPath, FileMode.Create);
        newFile.Write(Buffer, 0, Buffer.Length);
        newFile.Close();
    }


    protected void lbRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        if (txtCodigo.Text.Length == 0 || txtDescripcion.Text.Length == 0 || txtUrl.Text.Length == 0 || txtUrl.Text.Length == 0)
        {
            nilblInformacion.Text = "Campos vacios, por favor corrija.";
            return;
        }

        if (filMyFile.HasFile)
        {
            String ruta;
            String file_ext;
            Session["sw"] = false;
            file_ext = System.IO.Path.GetExtension(filMyFile.FileName).ToUpper();
            if (file_ext == ".BMP" || file_ext == ".JPG" || file_ext == ".PNG" || file_ext == ".JPEG" || file_ext == ".GIF")
            {
                ruta = "~/Imagen/Modulos/" + filMyFile.FileName;
                Session["ruta"] = ruta.Substring(0, ruta.Length);
                filMyFile.SaveAs(Convert.ToString(ConfigurationManager.AppSettings["RutaModulo"]) + filMyFile.FileName);
                Guardar();
            }
            else
            {
                nilblInformacion.Text = "Imagen no valida al cargar";

            }
        }
        else
        {
            if (Convert.ToBoolean(this.Session["editar"]) == true)
            {
                Session["sw"] = true;
                Guardar();
                return;
            }

            nilblInformacion.Text = "No hay archivo";
        }


    }

    protected void gvLista_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        gvLista.PageIndex = e.NewPageIndex;
        GetEntidad();
        gvLista.DataBind();
    }
}
