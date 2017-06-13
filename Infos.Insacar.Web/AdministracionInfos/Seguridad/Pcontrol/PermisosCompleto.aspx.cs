using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Seguridad_Pcontrol_PermisosCompletos : System.Web.UI.Page
{

    Cpermisos permisos = new Cpermisos();
    AccesoDatos.AccesoDatos CentidadMetodos = new AccesoDatos.AccesoDatos();
    SeguridadInfos.Security seguridad = new SeguridadInfos.Security();
    CIP ip = new CIP();
    string consulta = "C";
    string insertar = "I";
    string eliminar = "E";
    string imprime = "IM";
    string ingreso = "IN";
    string editar = "A";

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

        seguridad.InsertaLog(
              this.Session["usuario"].ToString(),
              operacion,
               ConfigurationManager.AppSettings["Modulo"].ToString() + '-' + this.Page.ToString(),
              "ex",
              mensaje,
              ip.ObtenerIP(), Convert.ToInt16(Session["empresa"]));


    }

    private void CargarDatos()
    {

        try
        {
            this.ddlEmpresa.DataSource = CcontrolesUsuario.OrdenarEntidadSinEmpresa(
                CentidadMetodos.EntidadGet("gEmpresa", "ppa"),"RazonSocial");
            this.ddlEmpresa.DataValueField = "id";
            this.ddlEmpresa.DataTextField = "RazonSocial";
            this.ddlEmpresa.DataBind();
            this.ddlEmpresa.Items.Insert(0, new ListItem("Seleccione una opción", ""));
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar las empresas  correspondiente a: " + ex.Message, "C");
        }

        try
        {
            CcontrolesUsuario.CreaNodoRaiz(
                        permisos.ModulosActivos(),
                        "codigo",
                        "descripcion",
                        this.tvPermisos);
        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los modulos correspondiente a: " + ex.Message, "C");
        }

        try
        {
            gvPerfiles.DataSource = permisos.PerfilesActivos();
            gvPerfiles.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los perfiles correspondiente a: " + ex.Message, "C");
        }

        try
        {
            gvUsuarios.DataSource = permisos.UsuariosActivos();
            gvUsuarios.DataBind();

        }
        catch (Exception ex)
        {
            ManejoError("Error al cargar los usuarios correspondiente a: " + ex.Message, "C");
        }

      



    }



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
                CargarDatos();
            }
        }

    }
    protected void lbCancelar_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void lbRegistrar_Click1(object sender, ImageClickEventArgs e)
    {

    }
    protected void ddlEmpresa_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void tvPermisos_TreeNodePopulate(object sender, TreeNodeEventArgs e)
    {
        CcontrolesUsuario.CreaNodoHijo(
            permisos.SeleccionaMenuModulo(e.Node.Value),
            "codigo",
            "descripcion",
            this.tvPermisos,
            e.Node);

        if (permisos.ValidaModulos(e.Node.Value) == 0)
        {
            CcontrolesUsuario.CreaNodoHijo(
            permisos.OperecionesActivos(),
            "codigo",
            "descripcion",
            this.tvPermisos,
            e.Node);
        }
    }
    protected void tvPermisos_SelectedNodeChanged(object sender, EventArgs e)
    {

       Session["modulo"]= this.tvPermisos.SelectedNode.Value;

       foreach (TreeNode tn in tvPermisos.SelectedNode.ChildNodes)
       {
          // PrintRecursive(tn);
       }

    }
}