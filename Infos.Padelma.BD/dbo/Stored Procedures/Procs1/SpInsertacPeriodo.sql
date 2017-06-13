
CREATE PROCEDURE [dbo].[SpInsertacPeriodo] @empresa int,@año int,@mes int,@cerrado bit,
@fechaInicial date, @fechaFinal date,@Retorno int output  AS 
begin tran cPeriodo 
declare @descripcion varchar(250), @periodo varchar(6)
declare @fecha varchar(8)
if ( @mes < 10)
set @fecha = '19000' + cast(@mes as varchar(1)) + '01'
else
set @fecha = '1900' + cast(@mes as varchar(2)) + '01'
set @descripcion = datename( month, @fecha) + ' del ' + cast(@año as varchar(4))

set  @periodo=  cast(@año as varchar(4)) + RIGHT('00' + Ltrim(Rtrim(@mes)),2)
insert cPeriodo( empresa,año,mes,cerrado,descripcion, periodo, fechaInicial,fechaFinal ) 
select @empresa,@año,@mes,@cerrado,@descripcion, @periodo ,@fechaInicial,@fechaFinal
if (@@error = 0 ) begin set @Retorno = 0 commit tran cPeriodo end else begin set @Retorno = 1 rollback tran cPeriodo end