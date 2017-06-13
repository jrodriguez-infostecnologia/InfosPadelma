CREATE proc [dbo].[spInsertaConceptoLiquidacionContrato]
@empresa int,
@tercero int,
@concepto varchar(50),
@valor float,
@cantidad float,
@valorUnitario float,
@Retorno int output
 AS begin tran aLotes

		insert tmpliquidacionNomina
		select top 1 a.empresa,a.tercero,a.ccosto,a.fecha,a.departamento,@concepto,a.año,a.mes,a.noPeriodo,@cantidad,0, @valorUnitario,@valor,b.signo,0,1,a.fechaFinal,a.fechaFinal,b.baseSeguridadSocial,a.baseEmbargos,
		null,@cantidad,@valor,a.noContrato,null,null,null	 from tmpliquidacionNomina a
		 left join nConcepto b on b.codigo=@concepto and b.empresa=a.empresa
		where a.empresa=@empresa
		if (@@error = 0 ) begin set @Retorno = 0 commit tran aLotes end else begin set @Retorno = 1 rollback tran aLotes end