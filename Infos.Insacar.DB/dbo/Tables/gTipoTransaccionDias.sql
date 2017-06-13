CREATE TABLE [dbo].[gTipoTransaccionDias] (
    [empresa]   INT          NOT NULL,
    [tipo]      VARCHAR (50) NOT NULL,
    [lunes]     BIT          CONSTRAINT [DF_gTipoTransaccionDias_lunes] DEFAULT ((0)) NOT NULL,
    [martes]    BIT          CONSTRAINT [DF_gTipoTransaccionDias_martes] DEFAULT ((0)) NOT NULL,
    [miercoles] BIT          CONSTRAINT [DF_gTipoTransaccionDias_miercoles] DEFAULT ((0)) NOT NULL,
    [jueves]    BIT          CONSTRAINT [DF_gTipoTransaccionDias_jueves] DEFAULT ((0)) NOT NULL,
    [viernes]   BIT          CONSTRAINT [DF_gTipoTransaccionDias_viernes] DEFAULT ((0)) NOT NULL,
    [sabado]    BIT          CONSTRAINT [DF_gTipoTransaccionDias_sabado] DEFAULT ((0)) NOT NULL,
    [domingo]   BIT          CONSTRAINT [DF_gTipoTransaccionDias_domingo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_gTipoTransaccionDias] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC)
);

