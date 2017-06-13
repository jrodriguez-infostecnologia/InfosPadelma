CREATE proc [dbo].[spRecalculaJornalesCargadores]
@empresa int,
@tercero int,
@fechaInicial date,
@fechaFinal date
as
declare @fecha date, @jornal float,@noRegistro float, @claseLabor int=3,  @cantidadLabor decimal(18,3) =0   


									update aTransaccionTercero
									set jornales = 0
									from dbo.aTransaccion AS a INNER JOIN
									dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
									dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
									join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
									where a.empresa=@empresa  and d.claseLabor=@claseLabor and c.tercero=@tercero	
									and convert(date,a.fecha) between  @fechaInicial and @fechaFinal
									and  a.anulado=0 



                           declare @noPrestamo varchar(50)
                           declare curPrestamo insensitive cursor for
                                  select distinct c.tercero, b.fecha from aTransaccion a
                                  join aTransaccionNovedad b on b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa
                                  join aTransaccionTercero c on c.numero=b.numero and c.tipo=b.tipo and c.empresa=b.empresa and c.registroNovedad=b.registro
                                  join aNovedad d on d.codigo=c.novedad and d.empresa=c.empresa
                                  where  tercero=@tercero and a.fecha between @fechaInicial and @fechaFinal and a.anulado=0  --and d.claseLabor = 3
								  and b.fecha not in (select fecha from nFestivo where empresa=@empresa)
                                  group by c.tercero,b.fecha

                                  open curPrestamo                  
                                  fetch curPrestamo into @tercero,@fecha
                                  while( @@fetch_status = 0 )
                                  begin  
                                 
                                  if (select  sum(c.jornales) from aTransaccion a
                                  join aTransaccionNovedad b on b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa
                                  join aTransaccionTercero c on c.numero=b.numero and c.tipo=b.tipo and c.empresa=b.empresa and c.registroNovedad=b.registro
                                  join aNovedad d on d.codigo=c.novedad and d.empresa=c.empresa
                                  where  tercero=@tercero  and a.anulado=0  and b.fecha=@fecha group by tercero)<=0
                                  begin
                                        ---- recalcula
										set @cantidadLabor=0

											if exists (select * from vSeleccionaTransaccionesAgronomico a join aNovedad b on 
											a.codLabor = b.codigo and a.codEmpresa=b.empresa
											where fechaLabor = @fecha and a.codEmpresa=@empresa
											and a.idTercero = @tercero
											and b.claseLabor=@claseLabor
											and a.anulado=0)
											begin
											
													if exists (	select * from 
														vSeleccionaTransaccionesAgronomico a join aNovedad b on 
														a.codLabor = b.codigo and a.codEmpresa=b.empresa
														where fechaLabor = @fecha and a.codEmpresa=@empresa
														and a.idTercero = @tercero
														and b.claseLabor<>@claseLabor
														and a.anulado=0)
														begin
					
																set @cantidadLabor = (select SUM(jornalLabor) from 
																vSeleccionaTransaccionesAgronomico a join aNovedad b on 
																a.codLabor = b.codigo and a.codEmpresa=b.empresa
																where fechaLabor = @fecha and a.codEmpresa=@empresa
																and a.idTercero = @tercero
																and b.claseLabor<>@claseLabor
																and a.anulado=0 )		
					
																if 1 - @cantidadLabor > 0
																begin
																
																	update aTransaccionTercero
																	set jornales = 1-@cantidadLabor
																	from
																	 (
																	 select top 1 c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and  a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 and registro=e.registroTran and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 

																end
																else
															
																update aTransaccionTercero
																	set jornales = 0
																	from
																	 (
																	 select  c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and  a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 --and registro=e.registroTran 
																	 and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 
														end
														else
														begin
															update aTransaccionTercero
																	set jornales = 1
																	from
																	 (
															select top 1  c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 and registro=e.registroTran and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 
														end
											end
											else
														begin
														
															update aTransaccionTercero
																	set jornales = 0
																	from
																	 (
															select  c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 --and registro=e.registroTran 
																	 and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 
														end
										--- fin
                                  end
								  else
								  begin
										set @cantidadLabor=0

											if exists (select * from vSeleccionaTransaccionesAgronomico a join aNovedad b on 
											a.codLabor = b.codigo and a.codEmpresa=b.empresa
											where fechaLabor = @fecha and a.codEmpresa=@empresa
											and a.idTercero = @tercero
											and b.claseLabor=@claseLabor
											and a.anulado=0)
											begin
											
													if exists (	select * from 
														vSeleccionaTransaccionesAgronomico a join aNovedad b on 
														a.codLabor = b.codigo and a.codEmpresa=b.empresa
														where fechaLabor = @fecha and a.codEmpresa=@empresa
														and a.idTercero = @tercero
														and b.claseLabor<>@claseLabor
														and a.anulado=0)
														begin
					
																set @cantidadLabor = (select SUM(jornalLabor) from 
																vSeleccionaTransaccionesAgronomico a join aNovedad b on 
																a.codLabor = b.codigo and a.codEmpresa=b.empresa
																where fechaLabor = @fecha and a.codEmpresa=@empresa
																and a.idTercero = @tercero
																and b.claseLabor<>@claseLabor
																and a.anulado=0 )		
					
																if 1 - @cantidadLabor > 0
																begin
																
																update aTransaccionTercero
																	set jornales = 1-@cantidadLabor
																	from
																	 (
																	 select top 1 c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and  a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 and registro=e.registroTran and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 

																end
																else
															
																update aTransaccionTercero
																	set jornales = 0
																	from
																	 (
																	 select  c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and  a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 --and registro=e.registroTran 
																	 and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 
														end
														else
														begin
															update aTransaccionTercero
																	set jornales = 1
																	from
																	 (
															select top 1  c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 and registro=e.registroTran and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 
														end
											end
											else
														begin
														
															update aTransaccionTercero
																	set jornales = 0
																	from
																	 (
															select  c.tipo tipoTra, c.numero numeroTra, c.novedad conceptoAgro, 
																	  c.registro registroTran, c.registroNovedad registroConcepto,c.año añoLabor, c.mes mesLabor  from dbo.aTransaccion AS a INNER JOIN
																	 dbo.aTransaccionNovedad AS b ON b.numero = a.numero AND b.tipo = a.tipo AND b.empresa = a.empresa INNER JOIN
																	 dbo.aTransaccionTercero AS c ON c.numero = b.numero AND c.tipo = b.tipo AND c.empresa = b.empresa AND c.registroNovedad = b.registro 
																	 join dbo.aNovedad as d on d.codigo= c.novedad and c.empresa=d.empresa
																	 where c.tercero=@tercero and a.empresa=@empresa  and d.claseLabor=@claseLabor	
																	 and convert(date,b.fecha) = @fecha
																	 and a.anulado=0 )	e	
																	 where tipo=e.tipoTra and numero=e.numeroTra and novedad=e.conceptoAgro
																	 --and registro=e.registroTran 
																	 and registroNovedad=e.registroConcepto	
																	 and año=e.añoLabor and mes=e.mesLabor 
														end
										--- fin
									end

                                  fetch curPrestamo into @tercero,@fecha
                                  end
                                  close curPrestamo
                                  deallocate curPrestamo