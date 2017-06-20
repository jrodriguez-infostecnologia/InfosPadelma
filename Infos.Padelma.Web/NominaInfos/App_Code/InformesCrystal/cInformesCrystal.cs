using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de cInformesCrystal
/// </summary>
public class cInformesCrystal
{
    public cInformesCrystal()
    {
        //
        // TODO: Agregar aquí la lógica del constructor
        //
    }

    public DataSet PagoChequeBancolombia(string periodo, int año, string numero, int empresa)
    {
        string[] iParametros = new string[] {"@periodo" ,
"@año",
"@numero",
"@empresa"
        };
        object[] objValores = new object[] { periodo, año, numero, empresa };
        return Cacceso.DataSetParametros("spSeleccionaPagoCheques", iParametros, objValores, "ppa");
    }
}