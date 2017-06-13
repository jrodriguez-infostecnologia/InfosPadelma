
CREATE proc [dbo].[spSeleccionaConceptoxCcosto]
@empresa int,
@ccosto varchar(50)
as

declare @manejaHE bit =0;
declare @tabla  table (codigo varchar(50)) 

insert @tabla 
select HO from nParametrosGeneral
where empresa=@empresa and ho is not null
union 
select HRN from nParametrosGeneral
where empresa=@empresa and HRN is not null
union 
select 	HEN from nParametrosGeneral
where empresa=@empresa and hen is not null
union 
select HED from nParametrosGeneral
where empresa=@empresa and HED is not null
union 
select HD from nParametrosGeneral
where empresa=@empresa and HD is not null
union 
select 	HF from nParametrosGeneral
where empresa=@empresa and hf is not null
union 
select 	HRF from nParametrosGeneral
where empresa=@empresa and HRF is not null
union 
select HENF from nParametrosGeneral
where empresa=@empresa and HENF is not null
union 
select HEDF from nParametrosGeneral
where empresa=@empresa and HEDF is not null


select @manejaHE=manejaHE from cCentrosCosto
where codigo=@ccosto 
and empresa=@empresa


if @manejaHE = 1 
begin
	select * from nconcepto
	where empresa=@empresa
end
else 
begin
	select * from nconcepto
	where codigo not in
	(select * from @tabla)
	and empresa=@empresa
end