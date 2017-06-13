CREATE TABLE [dbo].[gTipoCuentaBancaria] (
    [empresa]     INT           NOT NULL,
    [codigo]      VARCHAR (50)  NOT NULL,
    [descripcion] VARCHAR (550) NOT NULL,
    CONSTRAINT [PK_gTipoCuentaBancaria] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC)
);

