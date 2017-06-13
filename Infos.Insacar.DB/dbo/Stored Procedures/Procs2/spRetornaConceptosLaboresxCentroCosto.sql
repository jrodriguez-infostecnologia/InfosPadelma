CREATE proc  [dbo].[spRetornaConceptosLaboresxCentroCosto]
@empresa int,
@centroCosto varchar(50)
as
declare @manejaLabores bit

select @manejaLabores= case when @centroCosto='C' then 1 else isnull(manejaLC,0) end  from cCentrosCosto
where codigo=@centroCosto and empresa=@empresa 

if @manejaLabores = 0
	begin
		select codigo , codigo + ' - ' + descripcion descripcion   from nConcepto
		where empresa=@empresa
	end
		else 
		  begin
			select 'L'+codigo codigo, codigo + ' - ' + descripcion descripcion from aNovedad
			where empresa=@empresa
			union
			select codigo , codigo + ' - ' + descripcion descripcion   from nConcepto
		where empresa=@empresa
		  end