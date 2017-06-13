CREATE TABLE [dbo].[gTipoCuenta] (
    [empresa]     INT           NOT NULL,
    [codigo]      CHAR (1)      NOT NULL,
    [descripcion] VARCHAR (250) NOT NULL,
    CONSTRAINT [PK_gTipoCuenta] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_gTipoCuenta_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

