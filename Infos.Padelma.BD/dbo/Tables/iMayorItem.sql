CREATE TABLE [dbo].[iMayorItem] (
    [empresa]     INT            NOT NULL,
    [codigo]      VARCHAR (50)   NOT NULL,
    [planes]      VARCHAR (5)    NOT NULL,
    [descripcion] VARCHAR (950)  NOT NULL,
    [observacion] VARCHAR (1550) NOT NULL,
    [activo]      BIT            CONSTRAINT [DF_iMayorItem_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_iMayorItem] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_iMayorItem_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_iMayorItem_iPlanItem] FOREIGN KEY ([empresa], [planes]) REFERENCES [dbo].[iPlanItem] ([empresa], [codigo])
);

