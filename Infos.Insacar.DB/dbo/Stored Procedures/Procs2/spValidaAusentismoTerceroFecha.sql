CREATE proc [dbo].[spValidaAusentismoTerceroFecha]
@fi date,
@ff date,
@tercero int,
@empresa int,
@retorno int output
as
	if exists(select *  from nIncapacidad a  where a.tercero=@tercero and anulado=0 and a.empresa=@empresa 
	and (fechaInicial between @fi and @ff or fechaFinal between @fi and @ff	))
		set @retorno =1
	else
		set @retorno =0