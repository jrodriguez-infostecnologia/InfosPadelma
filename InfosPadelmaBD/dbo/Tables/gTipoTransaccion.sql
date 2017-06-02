CREATE TABLE [dbo].[gTipoTransaccion] (
    [empresa]       INT           NOT NULL,
    [codigo]        VARCHAR (50)  NOT NULL,
    [descripcion]   VARCHAR (50)  NOT NULL,
    [numeracion]    BIT           NULL,
    [actual]        INT           NULL,
    [prefijo]       VARCHAR (50)  NULL,
    [longitud]      INT           NULL,
    [naturaleza]    INT           NOT NULL,
    [modulo]        VARCHAR (50)  NOT NULL,
    [modoAnulacion] CHAR (1)      NOT NULL,
    [referencia]    BIT           CONSTRAINT [DF_p_tipotransaccion_tipt_referencia] DEFAULT ((0)) NOT NULL,
    [vistaDs]       VARCHAR (250) NULL,
    [activo]        BIT           CONSTRAINT [DF_gTipoTransaccion_activo] DEFAULT ((0)) NOT NULL,
    [fechaRegistro] DATETIME      NOT NULL,
    CONSTRAINT [PK_p_tipotransaccion] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [CK_gTipoTransaccion] CHECK ([modoAnulacion]='A' OR [modoAnulacion]='E'),
    CONSTRAINT [FK_gTipoTransaccion_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

