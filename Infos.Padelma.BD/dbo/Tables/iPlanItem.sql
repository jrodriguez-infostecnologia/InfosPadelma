CREATE TABLE [dbo].[iPlanItem] (
    [empresa]       INT            NOT NULL,
    [codigo]        VARCHAR (5)    NOT NULL,
    [descripcion]   VARCHAR (950)  NOT NULL,
    [observacion]   VARCHAR (1550) NOT NULL,
    [presentaMayor] BIT            NOT NULL,
    [activo]        BIT            CONSTRAINT [DF_iPlanItem_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_iPlanItem] PRIMARY KEY CLUSTERED ([empresa] ASC, [codigo] ASC),
    CONSTRAINT [FK_iPlanItem_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

