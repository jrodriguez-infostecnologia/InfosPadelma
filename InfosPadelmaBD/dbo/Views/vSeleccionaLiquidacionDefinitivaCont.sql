
CREATE VIEW [dbo].[vSeleccionaLiquidacionDefinitivaCont]
AS
SELECT        a.empresa, a.tipo, a.numero, a.año, a.mes, a.fecha, a.fechaRegistro, a.usuario, a.anulado, a.cerrado, a.estado, a.observacion, a.usuarioAnulado, a.fechaAnulado, b.registro, b.noPeriodo, b.tercero, b.concepto, 
                         b.fechaInicial, b.fechaFinal, b.ccosto, b.departamento, CASE WHEN s.noMostrar = 1 THEN b.cantidadR ELSE b.cantidad END AS cantidad, b.porcentaje, b.valorUnitario, 
                         CASE WHEN s.noMostrar = 1 THEN b.valorTotalR ELSE b.valorTotal END AS valorTotal, b.signo, b.saldo, b.noDias, b.entidad, b.contrato, b.basePrimas, b.baseCajaCompensacion, b.baseCesantias, 
                         b.baseVacaciones, b.baseIntereses, b.baseSeguridadSocial, b.manejaRango, b.baseEmbargo, b.noPrestamo, b.cantidadR, b.valorTotalR, dbo.nContratos.banco, dbo.nContratos.cuentaBancaria, 
                         dbo.nContratos.tipoCuenta, dbo.nContratos.claseContrato, dbo.gBanco.descripcion AS nombreBanco, dbo.nClaseContrato.descripcion AS nombreCalseContrato, dbo.nContratos.codigoTercero, dbo.cTercero.id, 
                         dbo.cTercero.razonSocial AS nombreTercero, dbo.cTercero.direccion, dbo.gTipoCuenta.descripcion AS nombreTipoCuenta, dbo.nContratos.formaPago, dbo.nContratos.entidadPension, dbo.nContratos.entidadEps, 
                         dbo.nContratos.entidadCesantias, dbo.nContratos.entidadCaja, dbo.nContratos.entidadArp, dbo.nContratos.entidadSena, dbo.nContratos.entidadIcbf, dbo.nContratos.fechaIngreso, dbo.nContratos.fechaRetiro, 
                         dbo.nCargo.codigo AS codigoCago, dbo.nCargo.descripcion AS nombreCargo, dbo.cTercero.codigo, dbo.nContratos.salario, dbo.nContratos.departamento AS codDepartamento, b.fecha AS fechaLabor, 
                         dbo.cTercero.codigo AS IdTercero, s.descripcion AS nombreConcepto, s.noMostrar, s.prioridad, s.mostrarFecha, s.mostrarDetalle, b.tipoConcepto, b.desTipoConcepto, dbo.nContratos.fechaContratoHasta, 
                         dbo.nContratos.terminoContrato, dbo.nContratos.motivoRetiro, dbo.nContratos.tipoContizante, dbo.nContratos.tipoNomina, dbo.nContratos.salarioAnterior, dbo.nContratos.auxilioTransporte, 
                         dbo.nContratos.id AS noContrato, s.prestacionSocial
FROM            dbo.nLiquidacionNomina AS a INNER JOIN
                         dbo.nLiquidacionNominaDetalle AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
                         dbo.nContratos ON a.empresa = dbo.nContratos.empresa AND b.tercero = dbo.nContratos.tercero AND b.contrato = dbo.nContratos.id INNER JOIN
                         dbo.gBanco ON a.empresa = dbo.gBanco.empresa AND dbo.nContratos.banco = dbo.gBanco.codigo INNER JOIN
                         dbo.nClaseContrato ON a.empresa = dbo.nClaseContrato.empresa AND dbo.nContratos.claseContrato = dbo.nClaseContrato.codigo INNER JOIN
                         dbo.cTercero ON a.empresa = dbo.cTercero.empresa AND dbo.nContratos.tercero = dbo.cTercero.id INNER JOIN
                         dbo.gTipoCuenta ON a.empresa = dbo.gTipoCuenta.empresa AND dbo.nContratos.tipoCuenta = dbo.gTipoCuenta.codigo INNER JOIN
                         dbo.nCargo ON dbo.nContratos.empresa = dbo.nCargo.empresa AND dbo.nContratos.cargo = dbo.nCargo.codigo INNER JOIN
                         dbo.nConcepto AS s ON s.codigo = b.concepto AND s.empresa = b.empresa