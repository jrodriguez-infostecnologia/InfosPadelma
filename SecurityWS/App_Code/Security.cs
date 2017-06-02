using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net;


/// <summary>
/// Summary description for SecurityAceites
/// </summary>
[WebService(Namespace = "http://tempuri.org/Security/Security.asmx")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class Security : System.Web.Services.WebService
{

    public Security()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    Logica seguridad = new Logica();

    [WebMethod]
    public int ValidarUsuario(string usuario, string idSys, string sitio)
    {
        try
        {
            int retorno = 0;

            retorno = seguridad.VerificaUsuario(
                usuario,
                idSys,
                sitio);

            return retorno;
        }
        catch
        {
            return 1;
        }
    }

    [WebMethod]
    public void InsertaLog(string usuario, string operacion, string entidad, string estado, string mensaje, string ip, int empresa)
    {
        seguridad.InsertaLog(usuario, operacion, entidad, estado, mensaje, ip,empresa);
    }

    [WebMethod]
    public int VerificaAccesoPagina(string usuario, string sitio, string pagina, int empresa)
    {
        try
        {
            return seguridad.VerificaAccesoPagina(
                usuario,
                sitio,
                pagina,
                empresa);
        }
        catch
        {
            return 0;
        }
    }

    [WebMethod]
    public int VerificaAccesoOperacion(string usuario, string sitio, string pagina, string operacion, int empresa)
    {
        try
        {
            return seguridad.VerificaAccesoOperacion(
                usuario,
                sitio,
                pagina,
                operacion,
                empresa);
        }
        catch
        {
            return 0;
        }
    }


    [WebMethod]
    public int RetornaEmpresa(string usuario)
    {
        try
        {
            return seguridad.RetornaEmpresa(usuario);
        }
        catch
        {
            return -1;
        }
    }
}

