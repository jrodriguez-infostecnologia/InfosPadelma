CREATE proc [dbo].[spRetornaDatosPagosNomina]
@empresa int,
@periodo int,
@año int,
@mes int,
@documento varchar(50)
as

select * from npagosNomina
where empresa=@empresa and periodoNomina=@periodo and año=@año
and mes=@mes and numero=@documento