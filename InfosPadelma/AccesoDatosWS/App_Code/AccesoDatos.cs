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
using System.Data;


/// <summary>
/// Summary description for SecurityAceites
/// </summary>
[WebService(Namespace = "http://tempuri.org/AccesoDatosWS/AccesoDatos.asmx")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class AccesoDatos : System.Web.Services.WebService {
      

    public AccesoDatos()
    {

        //Uncomment the following line if using designed components 
        //InitializeComponent(); 
    }

    [WebMethod]
    public  DataSet EntidadGet(string entidad, string dBase) {
       return CentidadMetodos.EntidadGet(entidad, dBase);
    }

     [WebMethod]
       public object[] ExecProc(string SpNombre, string[] IParametros, string[] OParametros, object[] ObjValores, string Conexion)
    {
        return Cacceso.ExecProc( SpNombre, IParametros,  OParametros,  ObjValores,  Conexion);
    }

     [WebMethod]
     public DataSet DataSete(string SpNombre, string Conexion)
     {
         return Cacceso.DataSet(SpNombre, Conexion);
     }

     [WebMethod]
     public DataSet DataSetParametros(string SpNombre, string[] IParametros, object[] ObjValores, string Conexion)
     {
         return Cacceso.DataSetParametros(SpNombre, IParametros, ObjValores, Conexion);
     }

     [WebMethod]
     public int EntidadInsertUpdateDelete(string entidad, string operacion, string dBase, object[] valores)
     {
         return CentidadMetodos.EntidadInsertUpdateDelete(entidad, operacion, dBase, valores);
     }

     [WebMethod]
     public DataSet EntidadGetKey(string entidad, string dBase, object[] valores)
     {
         return CentidadMetodos.EntidadGetKey(entidad, dBase, valores);
     }
}

