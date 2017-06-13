
create proc [dbo].[SpRetornaDiaSemanaTransaccion]
@tipo varchar(50),
@empresa int,
@retorna int output
as

set @retorna =1

if (((SELECT DATENAME(dw, getdate())) = 'Lunes') and exists(select * from gTipoTransaccionDias where tipo=@tipo and lunes=1))
begin
	set @retorna=0
	return
end 
else
begin
	if (((SELECT DATENAME(dw, getdate())) = 'Martes') and exists(select * from gTipoTransaccionDias where tipo=@tipo and lunes=1))
	begin
		set @retorna=0
		return
	end
	else
	begin
		if (((SELECT DATENAME(dw, getdate())) = 'Miércoles') and exists(select * from gTipoTransaccionDias where tipo=@tipo and lunes=1))
		begin
			set @retorna=0
			return
		end
		else
		begin
				if (((SELECT DATENAME(dw, getdate())) = 'Jueves') and exists(select * from gTipoTransaccionDias where tipo=@tipo and lunes=1))
				begin
					set @retorna=0
					return
				end
				else
				begin
					if (((SELECT DATENAME(dw, getdate())) = 'Viernes') and exists(select * from gTipoTransaccionDias where tipo=@tipo and lunes=1))
					begin
						set @retorna=0
						return
					end
					else
					begin
						if (((SELECT DATENAME(dw, getdate())) = 'Sábado') and exists(select * from gTipoTransaccionDias where tipo=@tipo and lunes=1))
						begin
							set	@retorna=0
							return
						end
						else
						begin
							if (((SELECT DATENAME(dw, getdate())) = 'Domingo') and exists(select * from gTipoTransaccionDias where tipo=@tipo and lunes=1))
							begin
								set @retorna=0
								return
							end
						end
					end
				end
			end
		end
end