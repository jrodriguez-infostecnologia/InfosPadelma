CREATE proc spValidaCantidadValorConcepto
@concepto varchar(50),
@empresa int,
@valida bit output
as


If (select tipoLiquidacion from nConcepto where empresa=@empresa and codigo=@concepto ) in (1,2,4)
	set @valida = 1
else
	set @valida = 0