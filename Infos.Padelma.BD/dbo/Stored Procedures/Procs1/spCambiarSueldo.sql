-- Batch submitted through debugger: SQLQuery10.sql|7|0|C:\Users\DESARR~1\AppData\Local\Temp\~vs8ACF.sql
CREATE proc [dbo].[spCambiarSueldo]
@empresa int,
@ccosto varchar(50),
@empleado varchar(50),
@formaLiquidacion int,
@tipo int,
@sueldoAnterior float,
@sueldoNuevo float,
@porcentaje float,
@valorSueldo float,
@retorno int output
as

declare @error int =0,
@tercero int,
@codigo varchar(50), 
@nocontrato int,@salario int

	begin tran Actualiza

	declare cursorFuncionarios insensitive cursor for	
	select distinct  	a.tercero, 	a.codigo,b.id,b.salario
	from nFuncionario  a
	join nContratos  b on a.tercero = b.tercero and a.empresa = b.empresa 
	join nClaseContrato c on b.claseContrato = c.codigo and b.empresa=c.empresa 
	join cCentrosCosto k on k.codigo=b.ccosto and k.empresa=b.empresa
	where  a.empresa=@empresa
	and b.activo=1 
	and  b.ccosto like (case when @formaLiquidacion=2 then @ccosto	else '%%'  end)
	and convert(varchar(50),a.tercero) like (case when @formaLiquidacion=3 then @empleado else '%%' end)
	and  k.mayor like (case when @formaLiquidacion=4  then @ccosto	else '%%'  end)
	open cursorFuncionarios			
	fetch cursorFuncionarios into 	@tercero, 	@codigo,@nocontrato,@salario
	while( @@fetch_status = 0 )
	begin	

		if @tipo=1
		begin
				update nContratos set
				salarioAnterior=@salario,
				salario=@valorSueldo
				where tercero=@tercero and id=@nocontrato and activo=1 and empresa=@empresa

				set @error = ( @error + @@ERROR )	
		end

		if @tipo=2
		begin
				update nContratos set
				salarioAnterior=@salario,
				salario= (@salario) + (@salario* (@porcentaje/100))
				where tercero=@tercero and id=@nocontrato and activo=1 and empresa=@empresa

				set @error = ( @error + @@ERROR )	
		end
		
		if @tipo=3
		begin
				update nContratos set
				salarioAnterior=@salario,
				salario= @sueldoNuevo
				where tercero=@tercero and id=@nocontrato and activo=1 and empresa=@empresa
				and salario=@sueldoAnterior

				set @error = ( @error + @@ERROR )	
		end
	 
	
	fetch cursorFuncionarios into 	@tercero, 	@codigo,@nocontrato,@salario
	end	
	
	close cursorFuncionarios
	deallocate cursorFuncionarios 

		
	if( @error = 0 )
	begin
		set @retorno = 0
		commit tran Actualiza
	end		
	else
	begin
		set @retorno = 1
		rollback tran Actualiza
	end