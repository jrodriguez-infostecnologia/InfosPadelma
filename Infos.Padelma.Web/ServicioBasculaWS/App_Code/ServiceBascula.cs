using System;
using System.Web;
using System.Web.Services;
using System.Web.Services.Protocols;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Service : System.Web.Services.WebService
{
    public Service () {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    #region Instancias

    CPeso Peso = new CPeso();

    #endregion Instancias

    [WebMethod]
    public String LeerPeso()
    {
        String PesoLeido = "";

        PesoLeido = Peso.LeerPeso();

        return PesoLeido;
    }

    [WebMethod]
    public string EnviarTramaTablero(string Descripcion, string[] Argumentos, string[] Valores)
    {
        return Peso.EnviarTramaTablero(Descripcion, Argumentos, Valores);
    }

    [WebMethod]
    public string EnviarTramaGrabador(string Descripcion, string[] Argumentos, string[] Valores)
    {
        return Peso.EnviarGrabador(Descripcion, Argumentos, Valores);
    }

    [WebMethod]
    public string EnviarTramaSimpleGrabador(string Descripcion, string Argumentos, string Valores)
    {
        return Peso.EnviarGrabadorSimple(Descripcion, Argumentos, Valores);
    }


    //metodo para imprimir un tiquete de entrada de materia prima
    [WebMethod]
    public string ImprimirTiquteEMP(string usuario, string impresora, string tipo, string[] datos_tiquete)
    {
        string mensaje = "";
        try
        {
            mensaje = Tiquete.ImprimirTiqueteEMP(usuario, impresora, tipo, datos_tiquete);             
        }
        catch (Exception ex)
        {

            mensaje = ex.Message;
        }
        return mensaje;

    }
    //metodo para imprimir un tiquete de pesaje
    [WebMethod]
    public string ImprimirTiqutePES(string usuario, string impresora, string[] datos_tiquete)
    {

        string mensaje = "";
        try
        {
            Tiquete.ImprimirTiquetePES(usuario, impresora, datos_tiquete);
            mensaje = "Exito";

        }
        catch (Exception ex)
        {

            mensaje = ex.Message;
        }
        return mensaje;
    }

    //metodo para imprimir un tiquete de despacho
    [WebMethod]
    public string ImprimirTiquteDES(string Usuario, string Impresora, string [] datos_tiquete)
    {
        string mensaje = "";
        try
        {
            Tiquete.ImprimirTiqueteDES(Usuario, Impresora, datos_tiquete);
            mensaje = "Exito";
        }
        catch (Exception ex)
        {

            mensaje = ex.Message;
        }
        return mensaje;
    }
}
