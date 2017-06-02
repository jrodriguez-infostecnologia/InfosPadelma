CREATE proc spsSeleccionaSellosDespachos
@tiquete varchar(50),
@empresa int
as
DECLARE @cadena varchar(1000)

SELECT @cadena= COALESCE(@cadena + '-', '') + Sello FROM lRegistroSellos a
join bRegistroBascula b on b.numero=a.numero and b.tipo=a.tipo and b.empresa=a.empresa
where b.tiquete=@tiquete and a.empresa=@empresa and a.anulado=0

select @cadena sello