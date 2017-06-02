CREATE TABLE [dbo].[gUnidadMedida] (
    [empresa]     INT          NOT NULL,
    [codigo]      VARCHAR (50) NOT NULL,
    [descripcion] VARCHAR (50) NOT NULL,
    [desCorta]    CHAR (3)     NOT NULL,
    [activo]      BIT          CONSTRAINT [DF_gUnidadMedida_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_gUnidadMedida] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_gUnidadMedida_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

