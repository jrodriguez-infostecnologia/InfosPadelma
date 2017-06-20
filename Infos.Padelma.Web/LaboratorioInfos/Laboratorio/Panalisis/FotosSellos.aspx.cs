using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Laboratorio_Panalisis_FotosSellos : System.Web.UI.Page
{
    Cvehiculos vehiculos = new Cvehiculos();
    Canalisis analisis = new Canalisis();
    Cproductos productos = new Cproductos();
    Cdespachos despachos = new Cdespachos();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();



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

        this.Response.Redirect("~/Laboratorio/Error.aspx", false);
    }

    private void ManejoExito(string mensaje, string operacion)
    {


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
        this.nilblMensaje.Text = mensaje;

    }


    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            try
            {
                CcontrolesUsuario.LimpiarControles(Page.Controls);
                gvLista.DataSource = null;
                gvLista.DataBind();

                string tiquete = Request.QueryString["tiquete"].ToString();
                foreach (DataRowView registro in despachos.SeleccionaTiqueteDespacho(tiquete, Convert.ToInt16(this.Session["empresa"])))
                {
                    lblFecha.Text = registro.Row.ItemArray.GetValue(3).ToString();
                    lblCantidad.Text = registro.Row.ItemArray.GetValue(15).ToString();
                    lblOrdenEnvio.Text = registro.Row.ItemArray.GetValue(25).ToString();
                    lblProducto.Text = registro.Row.ItemArray.GetValue(5).ToString();
                    lblTipo.Text = registro.Row.ItemArray.GetValue(26).ToString();
                    lblNumero.Text = registro.Row.ItemArray.GetValue(27).ToString();
                    lblRemolque.Text = registro.Row.ItemArray.GetValue(9).ToString();
                    lblPlaca.Text = registro.Row.ItemArray.GetValue(8).ToString();
                    lblTiquete.Text = tiquete;
                }

                if (tiquete.Trim().Length > 0)
                {
                    gvLista.DataSource = despachos.RetornaSellosDespacho(lblNumero.Text, lblTipo.Text, Convert.ToInt16(this.Session["empresa"]));
                    gvLista.DataBind();
                }
            }
            catch (Exception ex)
            {
                ManejoError("Error al cargar tiquete debido a:  " + ex.Message, "C");
            }

        }

    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {
        Response.Write("<script language='JavaScript'>");
        Response.Write("javascript:window.close()");
        Response.Write("</script>");
    }
    protected void btnRegistrar_Click(object sender, ImageClickEventArgs e)
    {
        bool validar = false;
        this.nilblMensaje.Text = "";

        foreach (GridViewRow registro in gvLista.Rows)
        {
            if (!((FileUpload)registro.FindControl("fuSello")).HasFiles)
            {
                validar = true;
            }

            if (validar)
            {
                nilblMensaje.Text = "Por favor seleecione todas las imagenes de los sellos";
                return;
            }

            FileUpload fuFoto = ((FileUpload)registro.FindControl("fuSello"));
            string[] formatos = new string[] { "jpg", "jpeg", "bmp", "png", "gif" };
            string Extension = Path.GetExtension(fuFoto.PostedFile.FileName).Replace(".", "");

            if (Array.IndexOf(formatos, Extension.ToLower()) < 0)
            {
                nilblMensaje.Text = "Formato de imagen inválido.";
                return;
            }
        }


        Guardar();
    }

    private static System.Drawing.Image RedimensionarImagen(Stream stream)
    {
        System.Drawing.Image img = System.Drawing.Image.FromStream(stream);
        // Tamaño máximo de la imagen (altura o anchura)
        const int max = 720;
        int h = img.Height;
        int w = img.Width;
        int newH, newW;

        if (h > w && h > max)
        {
            // Si la imagen es vertical y la altura es mayor que max,
            // se redefinen las dimensiones.
            newH = max;
            newW = (w * max) / h;
        }
        else if (w > h && w > max)
        {
            // Si la imagen es horizontal y la anchura es mayor que max,
            // se redefinen las dimensiones.
            newW = max;
            newH = (h * max) / w;
        }
        else
        {
            newH = h;
            newW = w;
        }
        if (h != newH && w != newW)
        {
            // Si las dimensiones cambiaron, se modifica la imagen
            Bitmap newImg = new Bitmap(img, newW, newH);
            Graphics g = Graphics.FromImage(newImg);
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBilinear;
            g.DrawImage(img, 0, 0, newImg.Width, newImg.Height);
            return newImg;
        }
        else
        {
            return img;
        }
    }

    private void Guardar()
    {
        try
        {
            bool validar = false;
            foreach (GridViewRow registro in gvLista.Rows)
            {
                DateTime fechaDespacho = Convert.ToDateTime(lblFecha.Text.Trim());
                int año = fechaDespacho.Year;
                int mes = fechaDespacho.Month;
                FileUpload fuFoto = ((FileUpload)registro.FindControl("fuSello"));
                string extdefecto = ".jpg";
                string FileName = lblOrdenEnvio.Text + "_" + registro.Cells[0].Text;
                string ex = Path.GetExtension(fuFoto.PostedFile.FileName);
                string FolderPath = ConfigurationManager.AppSettings["FolderPath"].ToString() + "\\" + año + "\\" + mes;
                string FilePath = Path.Combine(@FolderPath, FileName + extdefecto);
                string urlFotos = ConfigurationManager.AppSettings["urlFotos"].ToString()+año+"/"+mes+"/" + FileName + extdefecto;
                System.Drawing.Image imagenRedimensionada = RedimensionarImagen(fuFoto.PostedFile.InputStream);

                if (!Directory.Exists(FolderPath))
                {
                    Directory.CreateDirectory(FolderPath);
                }

                if (File.Exists(FilePath))
                {
                    File.Delete(FilePath);
                    imagenRedimensionada.Save(FilePath);
                }
                else
                {
                    imagenRedimensionada.Save(FilePath);
                }

                switch (despachos.ActualizarImagenSello(lblTipo.Text, lblNumero.Text, registro.Cells[0].Text, Convert.ToInt16(this.Session["empresa"]),
                     FilePath, urlFotos))
                {
                    case 1:
                        validar = true;
                        break;
                }

            }
            if (validar == false)
            {
                Response.Write("<script language='JavaScript'>");
                Response.Write("javascript:alert('Sellos guardados con exito');");
                Response.Write("javascript:window.close();");
                Response.Write("</script>");
            }
            else
            {
                Response.Write("<script language='JavaScript'>");
                Response.Write("javascript:alert('Error al guardar sellos');");
                Response.Write("javascript:window.close();");
                Response.Write("</script>");
            }
        }
        catch (Exception ex)
        {
            Response.Write("<script language='JavaScript'>");
            Response.Write("javascript:alert('Error al guardar sellos');");
            Response.Write("javascript:window.close();");
            Response.Write("</script>");
        }
    }


}