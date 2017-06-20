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

/// <summary>
/// Summary description for CcontrolesUsuario
/// </summary>
public class CcontrolesUsuario
{
    public CcontrolesUsuario()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    AccesoDatos.AccesoDatos AccesoDatos = new AccesoDatos.AccesoDatos();

    static public void MensajeError(string mensaje, Label etiqueta)
    {
        etiqueta.ForeColor = System.Drawing.Color.Red;
        etiqueta.Text = mensaje;
    }


    static public void MensajeExito(string mensaje, Label etiqueta)
    {
        etiqueta.ForeColor = System.Drawing.Color.Green;
        etiqueta.Text = mensaje;
    }

    static public void HabilitarControles(ControlCollection controles)
    {
        foreach (Control parenControl in controles)
        {
            foreach (Control objControl in parenControl.Controls)
            {
                if (objControl is TextBox)
                {
                    ((TextBox)objControl).ReadOnly = false;
                    ((TextBox)objControl).Visible = true;
                    ((TextBox)objControl).Enabled = true;
                }

                if (objControl is DropDownList)
                {
                    ((DropDownList)objControl).Enabled = true;
                    ((DropDownList)objControl).Visible = true;
                }

                if (objControl is CheckBox)
                {
                    ((CheckBox)objControl).Enabled = true;
                    ((CheckBox)objControl).Visible = true;
                }

                if (objControl is RadioButton)
                {
                    ((RadioButton)objControl).Enabled = true;
                    ((RadioButton)objControl).Visible = true;
                }

                if (objControl is Label)
                {
                    ((Label)objControl).Visible = true;
                }

                if (objControl is ImageButton)
                {
                    ((ImageButton)objControl).Visible = true;
                }

                if (objControl is Image)
                {
                    ((Image)objControl).Visible = true;
                }


                if (objControl is Button)
                {
                    ((Button)objControl).Visible = true;
                }

                if (objControl is LinkButton)
                {
                    ((LinkButton)objControl).Visible = true;
                }

                if (objControl is FileUpload)
                {
                    ((FileUpload)objControl).Visible = true;
                }
            }
        }
    }

    static public void InhabilitarControles(ControlCollection controles)
    {
        foreach (Control parenControl in controles)
        {
            foreach (Control objControl in parenControl.Controls)
            {
                if (objControl is TextBox)
                {
                    if (!((TextBox)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((TextBox)objControl).ReadOnly = true;
                        ((TextBox)objControl).Visible = false;
                    }
                }

                if (objControl is DropDownList)
                {
                    if (!((DropDownList)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((DropDownList)objControl).Enabled = false;
                        ((DropDownList)objControl).Visible = false;
                    }
                }

                if (objControl is CheckBox)
                {
                    if (!((CheckBox)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((CheckBox)objControl).Enabled = false;
                        ((CheckBox)objControl).Visible = false;
                    }
                }

                if (objControl is RadioButton)
                {
                    if (!((RadioButton)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((RadioButton)objControl).Enabled = false;
                        ((RadioButton)objControl).Visible = false;
                    }
                }

                if (objControl is Label)
                {
                    if (!((Label)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((Label)objControl).Visible = false;
                    }
                }

                if (objControl is Button)
                {
                    if (!((Button)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((Button)objControl).Visible = false;
                    }
                }

                if (objControl is ImageButton)
                {
                    if (!((ImageButton)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((ImageButton)objControl).Visible = false;
                    }
                }

                if (objControl is Image)
                {
                    if (!((Image)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((Image)objControl).Visible = false;
                    }
                }

                if (objControl is FileUpload)
                {
                    if (!((FileUpload)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((FileUpload)objControl).Visible = false;
                    }
                }

                if (objControl is LinkButton)
                {
                    if (!((LinkButton)objControl).ID.ToString().StartsWith("ni"))
                    {
                        ((LinkButton)objControl).Visible = false;
                    }
                }
            }
        }
    }

    static public void LimpiarControles(ControlCollection controles)
    {
        foreach (Control parentControl in controles)
        {
            foreach (Control objControl in parentControl.Controls)
            {
                if (objControl is TextBox)
                {
                    ((TextBox)objControl).Text = "";
                }

                if (objControl is CheckBox)
                {
                    ((CheckBox)objControl).Checked = false;
                }
            }
        }
    }

    static public void OpcionesDefault(ControlCollection controles, int estado)
    {
        switch (estado)
        {
            case 0:
                foreach (Control parentControl in controles)
                {
                    foreach (Control objControl in parentControl.Controls)
                    {
                        if (objControl is ImageButton)
                        {
                            if (((ImageButton)objControl).ID == "imbNuevo")
                            {
                                ((ImageButton)objControl).Enabled = true;
                                ((ImageButton)objControl).Visible = true;
                            }

                            if (((ImageButton)objControl).ID == "imbGuradar")
                            {
                                ((ImageButton)objControl).Enabled = false;
                                ((ImageButton)objControl).Visible = false;
                            }

                            if (((ImageButton)objControl).ID == "imbEliminar")
                            {
                                ((ImageButton)objControl).Enabled = false;
                                ((ImageButton)objControl).Visible = false;
                            }

                            if (((ImageButton)objControl).ID == "imbCancelar")
                            {
                                ((ImageButton)objControl).Enabled = false;
                                ((ImageButton)objControl).Visible = false;
                            }
                        }

                        if (objControl is Label)
                        {
                            if (((Label)objControl).ID == "lblMensaje")
                            {
                                ((Label)objControl).Text = "--";
                            }
                        }
                    }
                }
                break;

            case 1:
                foreach (Control parentControl in controles)
                {
                    foreach (Control objControl in parentControl.Controls)
                    {
                        if (objControl is ImageButton)
                        {
                            if (((ImageButton)objControl).ID == "imbNuevo")
                            {
                                ((ImageButton)objControl).Enabled = false;
                                ((ImageButton)objControl).Visible = false;
                            }

                            if (((ImageButton)objControl).ID == "imbGuradar")
                            {
                                ((ImageButton)objControl).Enabled = true;
                                ((ImageButton)objControl).Visible = true;
                            }

                            if (((ImageButton)objControl).ID == "imbEliminar")
                            {
                                ((ImageButton)objControl).Enabled = false;
                                ((ImageButton)objControl).Visible = false;
                            }

                            if (((ImageButton)objControl).ID == "imbCancelar")
                            {
                                ((ImageButton)objControl).Enabled = true;
                                ((ImageButton)objControl).Visible = true;
                            }
                        }
                    }
                }
                break;

            case 2:
                foreach (Control parentControl in controles)
                {
                    foreach (Control objControl in parentControl.Controls)
                    {
                        if (objControl is ImageButton)
                        {
                            if (((ImageButton)objControl).ID == "imbNuevo")
                            {
                                ((ImageButton)objControl).Enabled = false;
                                ((ImageButton)objControl).Visible = false;
                            }

                            if (((ImageButton)objControl).ID == "imbGuradar")
                            {
                                ((ImageButton)objControl).Enabled = true;
                                ((ImageButton)objControl).Visible = true;
                            }

                            if (((ImageButton)objControl).ID == "imbEliminar")
                            {
                                ((ImageButton)objControl).Enabled = true;
                                ((ImageButton)objControl).Visible = true;
                            }

                            if (((ImageButton)objControl).ID == "imbCancelar")
                            {
                                ((ImageButton)objControl).Enabled = true;
                                ((ImageButton)objControl).Visible = true;
                            }
                        }
                    }
                }
                break;
        }
    }

    static private TreeNode CreaNodo(string id, string texto)
    {
        TreeNode nodo = new TreeNode();
        nodo.Text = texto;
        nodo.Value = id;
        nodo.PopulateOnDemand = true;

        return nodo;
    }

    static private TreeNode CreaNodoHijo(string id, string texto)
    {
        TreeNode nodo = new TreeNode();
        nodo.Text = texto;
        nodo.Value = id;
        nodo.PopulateOnDemand = true;
        nodo.ShowCheckBox = true;

        return nodo;
    }

    static private TreeNode CreaNodoNoDemanda(string id, string texto)
    {
        TreeNode nodo = new TreeNode();
        nodo.Text = texto;
        nodo.Value = id;

        return nodo;
    }

    static public void CreaNodoRaiz(DataSet dsDatos, string id, string texto, TreeView arbol)
    {
        foreach (DataRow registro in dsDatos.Tables[0].Rows)
        {
            arbol.Nodes.Add(
                CreaNodo(
                    registro[id].ToString(),
                    registro[texto].ToString()));

            arbol.DataBind();
        }
    }

    static public void CreaNodoRaizNoDemanda(DataSet dsDatos, string id, string texto, TreeView arbol)
    {
        foreach (DataRow registro in dsDatos.Tables[0].Rows)
        {
            arbol.Nodes.Add(
                CreaNodoNoDemanda(
                    registro[id].ToString(),
                    registro[texto].ToString()));

            arbol.DataBind();
        }
    }

    static public void CreaNodoHijo(DataSet dsDatos, string id, string texto, TreeView arbol, TreeNode nodoPadre)
    {
        foreach (DataRow registro in dsDatos.Tables[0].Rows)
        {
            nodoPadre.ChildNodes.Add(CreaNodoHijo(registro[id].ToString(), registro[texto].ToString()));
            arbol.DataBind();
        }
    }

    static public void CreaNodoHijoNoDemanda(DataSet dsDatos, string id, string texto, TreeView arbol, TreeNode nodoPadre)
    {
        foreach (DataRow registro in dsDatos.Tables[0].Rows)
        {
            nodoPadre.ChildNodes.Add(CreaNodoNoDemanda(registro[id].ToString(), registro[texto].ToString()));
            arbol.DataBind();
        }
    }

    static public DataView OrdenarEntidad(DataView entidad, string campoOrden)
    {
        entidad.Sort = campoOrden;
        return entidad;
    }

    static public DataView OrdenarEntidad(DataSet entidad, string campoOrden, int empresa)
    {
        DataView dvEntidad = entidad.Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa);
        dvEntidad.Sort = campoOrden;

        return dvEntidad;
    }

    static public DataView OrdenarEntidadyActivos(DataSet entidad, string campoOrden, int empresa)
    {
        DataView dvEntidad = entidad.Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and activo=True";
        dvEntidad.Sort = campoOrden;
        return dvEntidad;
    }

    static public DataView OrdenarEntidadTercero(DataSet entidad, string campoOrden, string filtro, int empresa)
    {
        DataView dvEntidad = entidad.Tables[0].DefaultView;
        dvEntidad.RowFilter = "empresa=" + Convert.ToString(empresa) + " and activo=True and " + filtro + "=True";

        dvEntidad.Sort = campoOrden;
        return dvEntidad;
    }

}
