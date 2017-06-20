using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Oracle.DataAccess.Client;
/// <summary>
/// Summary description for AccesoDatos
/// </summary>
public class AccesoDatos
{
    public AccesoDatos()
    {
        //
        // TODO: Add constructor logic here
        //
    }

    public string GetCadenaConexion()
    {

        string Cadenaconexion = ConfigurationManager.AppSettings["CadenaConexion"];
        return Cadenaconexion;
    }




    public OracleDataReader GetDatosTiqueteEMP(string numtransaccion)
    {

        OracleConnection conexionoracle = new OracleConnection(GetCadenaConexion());
        conexionoracle.Open();
        OracleCommand Comado = new OracleCommand();
        Comado.Parameters.Add("numtransaccionx", OracleDbType.Varchar2, ParameterDirection.Input).Value = numtransaccion;
        Comado.Parameters.Add("cur_OUT", OracleDbType.RefCursor).Direction = ParameterDirection.Output;
        Comado.CommandText = "gets_bascula.Get_ImpresionBascula";
        Comado.CommandType = CommandType.StoredProcedure;
        Comado.Connection = conexionoracle;
        OracleDataReader lector = Comado.ExecuteReader();
        try
        {
            if (lector.Read())
            {                
                return lector;
              
            }
            else
            {
                conexionoracle.Close();
                lector.Close();
                return lector;
            }
            
        }
        catch (Exception)
        {

            conexionoracle.Close();
            lector.Close();
            return lector;
        }
        
    }

    public OracleDataReader GetDatosTiquetePES(string numtransaccion)
    {

        OracleConnection conexionoracle = new OracleConnection(GetCadenaConexion());
        conexionoracle.Open();
        OracleCommand Comado = new OracleCommand();
        Comado.Parameters.Add("numtransaccionx", OracleDbType.Varchar2, ParameterDirection.Input).Value = numtransaccion;
        Comado.Parameters.Add("cur_OUT", OracleDbType.RefCursor).Direction = ParameterDirection.Output;
        Comado.CommandText = "gets_bascula.Get_ImpresionBasculaPes";
        Comado.CommandType = CommandType.StoredProcedure;
        Comado.Connection = conexionoracle;
        OracleDataReader lector = Comado.ExecuteReader();
        try
        {
            if (lector.Read())
            {
                
                return lector;

            }
            else
            {
                conexionoracle.Close();
                lector.Close();
                return lector;
            }
           
        }
        catch (Exception)
        {

            conexionoracle.Close();
            lector.Close();
            return lector;
        }
    }


    
    public OracleDataReader GetAnalisisTarima(string numtransaccion, string analisis)
    {

        OracleConnection conexionoracle = new OracleConnection(GetCadenaConexion());
        conexionoracle.Open();
        OracleCommand Comado = new OracleCommand();
        Comado.Parameters.Add("numtranx", OracleDbType.Varchar2, ParameterDirection.Input).Value = numtransaccion;
        Comado.Parameters.Add("analisisx", OracleDbType.Varchar2, ParameterDirection.Input).Value = analisis;
        Comado.Parameters.Add("cur_OUT", OracleDbType.RefCursor).Direction = ParameterDirection.Output;
        Comado.CommandText = "Gets_Laboratorio.Get_AnaliByTranstipo";
        Comado.CommandType = CommandType.StoredProcedure;
        Comado.Connection = conexionoracle;
        OracleDataReader lector = Comado.ExecuteReader();
        try
        {
            if (lector.Read())
            {
               
                return lector;

            }
            else
            {
                conexionoracle.Close();
                lector.Close();
                return lector;

            }
           
        }
        catch (Exception)
        {

            conexionoracle.Close();
            lector.Close();
            return lector;
        }
    }

    public OracleDataReader GetDatosTiqueteDES(string numtransaccion)
    {

        OracleConnection conexionoracle = new OracleConnection(GetCadenaConexion());
        conexionoracle.Open();
        OracleCommand Comado = new OracleCommand();
        Comado.Parameters.Add("numtransaccionx", OracleDbType.Varchar2, ParameterDirection.Input).Value = numtransaccion;
        Comado.Parameters.Add("cur_OUT", OracleDbType.RefCursor).Direction = ParameterDirection.Output;
        Comado.CommandText = "gets_bascula.Get_ImpresionBasculaDesp";
        Comado.CommandType = CommandType.StoredProcedure;
        Comado.Connection = conexionoracle;
        OracleDataReader lector = Comado.ExecuteReader();
        try
        {
            if (lector.Read())
            {
               
                return lector;

            }
            else
            {
                conexionoracle.Close();
                lector.Close();
                return lector;

            }
            
        }
        catch (Exception)
        {

            conexionoracle.Close();
            lector.Close();
            return lector;
        }
    }

}

