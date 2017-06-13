create proc [dbo].[spValidaContratosActivosTercero]
@empresa int,
@tercero varchar(10),
@retorno bit output
as


if exists(
select * from nContratos
where tercero=@tercero and empresa=@empresa
and activo=1
)
set @retorno=1
else
set @retorno=0