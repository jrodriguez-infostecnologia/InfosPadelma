create proc [dbo].[spVerificaNovedadTipo]
@empresa int,
@novedad int,
@tipo varchar(50) ,
@retorno int output
as

	if exists(select * from aTipoNovedad where novedad=@novedad and tipo=@tipo and empresa=@empresa)
			set @retorno=0
	else
			set @retorno=1