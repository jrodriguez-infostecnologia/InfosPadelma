﻿using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

/// <summary>
/// Descripción breve de Coperadores
/// </summary>
public class CModificacionNomina
{
    public CModificacionNomina() { }

    public DataSet CargarTipoDeDocumento(int año, int periodo, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@empresa", "@periodo" };
        object[] objValores = new object[] { año, empresa, periodo };

        return Cacceso.DataSetParametros(
            "spSeleccionaTipoDocumentoExistenteNominaDetalle",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet CargarNumeroDeDocumento(int año, int periodo, string tipo, int empresa)
    {
        string[] iParametros = new string[] { "@año", "@empresa", "@periodo", "@tipo" };
        object[] objValores = new object[] { año, empresa, periodo, tipo };

        return Cacceso.DataSetParametros(
            "spSeleccionaNumeroDocumentoExistenteNominaDetalle",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet CargarEmpleado(int año, int periodo, string tipo, int empresa, string numero)
    {
        string[] iParametros = new string[] { "@año", "@empresa", "@numero", "@periodo", "@tipo" };
        object[] objValores = new object[] { año, empresa, numero, periodo, tipo };

        return Cacceso.DataSetParametros(
            "spSeleccionaTerceroExistenteNominaDetalle",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet CargarContratos(int año, int periodo, string tipo, int empresa, string numero, int codigoTercero)
    {
        string[] iParametros = new string[] { "@año", "@CodTercero", "@empresa", "@numero", "@periodo", "@tipo" };
        object[] objValores = new object[] { año, codigoTercero, empresa, numero, periodo, tipo };

        return Cacceso.DataSetParametros(
            "spSeleccionaContratoExistenteNominaDetalle",
            iParametros,
            objValores,
            "ppa");
    }

    public DataSet CargarDetalleLiquidación(int año, int periodo, string tipo, int empresa, string numero, int codigoTercero, int codContrato)
    {
        string[] iParametros = new string[] { "@año", "@CodContrato", "@CodTercero", "@empresa", "@numero", "@periodo", "@tipo" };
        object[] objValores = new object[] { año, codContrato, codigoTercero, empresa, numero, periodo, tipo };

        return Cacceso.DataSetParametros(
            "spSeleccionaNominaDetalle",
            iParametros,
            objValores,
            "ppa");
    }

    public void ElimnarDetalleLiquidación(int año, int periodo, string tipo, int empresa, string numero, int codigoTercero, int codContrato)
    {
        string[] iParametros = new string[] { "@año", "@CodContrato", "@CodTercero", "@empresa", "@numero", "@periodo", "@tipo" };
        string[] oParametros = new string[] { "@retorno" };
        object[] objValores = new object[] { año, codContrato, codigoTercero, empresa, numero, periodo, tipo };

        Cacceso.ExecProc(
            "spEliminaNominaDetalle",
            iParametros,
            oParametros,
            objValores,
            "ppa");
    }

    public void GuardarDetalleLiqidación(int año, int periodo, string tipo, int empresa, string numero, int codigoTercero, int codContrato, List<LiquidacionDetalle> listadoDetalleLiquidacion)
    {
        foreach (var detalle in listadoDetalleLiquidacion)
        {
            string[] iParametros = new string[] { "@año", "@CodConcepto", "@Cantidad", "@CodContrato", "@CodTercero", "@empresa", "@numero", "@periodo", "@tipo", "@registro", "@valorTotal", "@valorUnitario" };
            string[] oParametros = new string[] { "@retorno" };
            object[] objValores = new object[] { año, codContrato, codigoTercero, empresa, numero, periodo, tipo, detalle.RegistroDetalleNomina, detalle.CodConcepto, detalle.Cantidad, detalle.ValorUnitario, detalle.ValorTotal };

            Cacceso.ExecProc(
                "spInsertarNominaDetalle",
                iParametros,
                oParametros,
                objValores,
                "ppa");
        }
    }
}