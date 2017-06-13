CREATE proc spRetornaFuncionarioCcosto
@ccosto varchar(50),
@empresa int 
as

	select distinct a.tercero,convert(varchar,a.codigo)+ ' - '+ convert(varchar,a.tercero)+ ' - '+ a.descripcion as descripcion from nFuncionario a
	left join nContratos b on b.tercero=a.tercero and b.empresa=a.empresa 
	where b.ccosto=@ccosto and a.empresa=@empresa