CREATE TABLE [dbo].[gTipoTransaccionCampo] (
    [empresa]         INT           NOT NULL,
    [tipoTransaccion] VARCHAR (50)  NOT NULL,
    [entidad]         VARCHAR (250) NOT NULL,
    [campo]           VARCHAR (250) NOT NULL,
    [tipoCampo]       VARCHAR (50)  CONSTRAINT [DF_gTipoTransaccionCampo_visible] DEFAULT ((0)) NOT NULL,
    [tercero]         BIT           CONSTRAINT [DF_gTipoTransaccionCampo_tercero] DEFAULT ((0)) NOT NULL,
    [aplicaCliente]   BIT           CONSTRAINT [DF_gTipoTransaccionCampo_aplicaCliente] DEFAULT ((0)) NOT NULL,
    [aplicaProveedor] BIT           CONSTRAINT [DF_gTipoTransaccionCampo_aplicaProveedor] DEFAULT ((0)) NOT NULL,
    [aplicaTercero]   BIT           CONSTRAINT [DF_gTipoTransaccionCampo_aplicaTercero] DEFAULT ((0)) NOT NULL,
    [terceroDefecto]  BIT           NOT NULL,
    CONSTRAINT [PK_gTipoTransaccionCampo] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipoTransaccion] ASC, [entidad] ASC, [campo] ASC),
    CONSTRAINT [CK_gTipoTransaccionCampo] CHECK ([tipoCampo]='txv' OR [tipoCampo]='chk' OR [tipoCampo]='ddl' OR [tipoCampo]='txt' OR [tipoCampo]='rbl'),
    CONSTRAINT [FK_gTipoTransaccionCampo_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_gTipoTransaccionCampo_gTipoTransaccion] FOREIGN KEY ([empresa], [tipoTransaccion]) REFERENCES [dbo].[gTipoTransaccion] ([empresa], [codigo])
);

