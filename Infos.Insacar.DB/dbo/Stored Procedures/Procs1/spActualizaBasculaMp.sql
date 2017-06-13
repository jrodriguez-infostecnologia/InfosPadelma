
CREATE PROCEDURE [dbo].[spActualizaBasculaMp]
	@tipo		varchar(50),
	@numero		varchar(50),
	@pesoTara	float,
	@pesoNeto	float,
	@tiquete	varchar(50),
	@empresa	int,
	@retorno	int output
AS
/***************************************************************************
Nombre: spActualizaBasculaMp
Tipo: Procedimiento Almacenado
INFOS TECNOLOGIA S.A.S

Argumentos de entrada: Tipo de transacción, número de transacción, tara, neto,
					   tiquete
Argumentos de salida: 
Descripción: Actualiza el segundo pesaje de materia prima
*****************************************************************************/

	declare @fecha datetime
	
	set @fecha = GETDATE()

	begin tran Actualiza
	
	declare @pesoDescuento float=0
	
	  set @pesoDescuento= round((select sum(valor)/100  from lRegistroAnalisis a join 
	  lAnalisis b on a.analisis=b.codigo and a.empresa=b.empresa 
	   where tipo = @tipo and
		a.numero = @numero and 
		a.empresa= @empresa
		and  b.descuenta=1) * @pesoNeto,0)

		update bRegistroBascula
		set
		pesoTara = @pesoTara,
		pesoNeto = @pesoNeto,
		pesoDescuento=@pesoDescuento,
		fechaTara = @fecha,
		fechaNeto = @fecha,
		estado = 'SP',
		tiquete = @tiquete		
		where
		tipo = @tipo and
		numero = @numero and 
		empresa= @empresa
		
		
	if( @@ERROR = 0 )
	begin
		commit tran Actualiza
		set @retorno = 0
		--exec spEviarCorreoProveedorTiquete @tiquete,@empresa
	end		
	else
	begin
		rollback tran Actualiza
		set @retorno = 1
	end