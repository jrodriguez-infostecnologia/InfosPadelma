using System;
using System.Collections.Generic;
using System.Text;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using Microsoft.Practices.EnterpriseLibrary.Data.Sql;
using System.Configuration;

public class Cacceso
{
    private static string GetCadenaConexion(string Conexion)
    {         
        string CadenaConexion = "";

        switch (Conexion)
        {
            case "ppa":

                CadenaConexion = ConfigurationManager.AppSettings["CadenaConexion"];
                break;
      
        }

        return CadenaConexion;
    }

    public static DataSet DataSet(string SpNombre, string Conexion)
    {
        SqlDatabase BdSql = new SqlDatabase(GetCadenaConexion(Conexion));
        DbCommand comando;
        
        comando = BdSql.GetStoredProcCommand(SpNombre);
        comando.CommandTimeout = 60;

        return BdSql.ExecuteDataSet(comando);
    }

    public static DataSet DataSetParametros(string SpNombre, string[] IParametros, object[] ObjValores, string Conexion)
    {
        SqlDatabase BdSql = new SqlDatabase(GetCadenaConexion(Conexion));
        DbCommand comando;            
        int i;

        comando = BdSql.GetStoredProcCommand(SpNombre);

        i = 0;

        foreach (string ParIn in IParametros)
        {
            if (ObjValores.GetValue(i) == null)
            {
                BdSql.AddInParameter(comando, ParIn, DbType.Boolean, null);
            }
            else
            {
                if (ObjValores.GetValue(i).GetType() == typeof(string))
                {
                    BdSql.AddInParameter(comando, ParIn, DbType.String, ObjValores.GetValue(i));
                }
                else
                {
                    if (ObjValores.GetValue(i).GetType() == typeof(DateTime))
                    {
                        BdSql.AddInParameter(comando, ParIn, DbType.Date, ObjValores.GetValue(i));
                    }
                    else
                    {
                        if (ObjValores.GetValue(i).GetType() == typeof(int))
                        {
                            BdSql.AddInParameter(comando, ParIn, DbType.Int32, ObjValores.GetValue(i));
                        }
                        else
                            if (ObjValores.GetValue(i).GetType() == typeof(bool))
                            {
                                BdSql.AddInParameter(comando, ParIn, DbType.Boolean, ObjValores.GetValue(i));
                            }
                            else
                            {
                                {
                                    BdSql.AddInParameter(comando, ParIn, DbType.Decimal, ObjValores.GetValue(i));
                                }
                            }
                    }
                }
            }

            i++;
        }

        comando.CommandTimeout = 60;
        BdSql.ExecuteNonQuery(comando);

        return BdSql.ExecuteDataSet(comando);
    }

    public static object[] ExecProc(string SpNombre, string[] IParametros, string[] OParametros, object[] ObjValores, string Conexion)
    {
        SqlDatabase BdSql = new SqlDatabase(GetCadenaConexion(Conexion));
        DbCommand comando;            
        Object[] ObjRetorno = new object[OParametros.GetLength(0)];
        int i;

        comando = BdSql.GetStoredProcCommand(SpNombre);
        comando.CommandTimeout = 300;

        i = 0;

        foreach (string ParIn in IParametros)
        {
            if (ObjValores.GetValue(i) == null)
            {
                BdSql.AddInParameter(comando, ParIn, DbType.Boolean, null);
            }
            else
            {
                if (ObjValores.GetValue(i).GetType() == typeof(string))
                {
                    BdSql.AddInParameter(comando, ParIn, DbType.String, ObjValores.GetValue(i));
                }
                else
                {
                    if (ObjValores.GetValue(i).GetType() == typeof(DateTime))
                    {
                        BdSql.AddInParameter(comando, ParIn, DbType.Date, ObjValores.GetValue(i));
                    }
                    else
                    {
                        if (ObjValores.GetValue(i).GetType() == typeof(int))
                        {
                            BdSql.AddInParameter(comando, ParIn, DbType.Int32, ObjValores.GetValue(i));
                        }
                        else
                            if (ObjValores.GetValue(i).GetType() == typeof(bool))
                            {
                                BdSql.AddInParameter(comando, ParIn, DbType.Boolean, ObjValores.GetValue(i));
                            }
                            else
                            {
                                {
                                    BdSql.AddInParameter(comando, ParIn, DbType.Decimal, ObjValores.GetValue(i));
                                }
                            }
                    }
                }
            }

            i++;
        }

        foreach (string Opar in OParametros)
        {
            BdSql.AddOutParameter(comando, Opar, DbType.String, 256);
        }

        BdSql.ExecuteNonQuery(comando);

        i = 0;

        foreach (string Opar in OParametros)
        {
            ObjRetorno.SetValue(BdSql.GetParameterValue(comando, Opar), i);

            i++;
        }

        return ObjRetorno;
    }
}

