CREATE TABLE [dbo].[iItemsCriterios] (
    [empresa]       INT          NOT NULL,
    [item]          INT          NOT NULL,
    [idPlan]        VARCHAR (5)  NOT NULL,
    [idMayor]       VARCHAR (50) NOT NULL,
    [fechaRegistro] DATETIME     NOT NULL,
    CONSTRAINT [PK_t125] PRIMARY KEY NONCLUSTERED ([empresa] ASC, [item] ASC, [idPlan] ASC, [idMayor] ASC) WITH (FILLFACTOR = 90),
    CONSTRAINT [FK_iItemsCriterios_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_iItemsCriterios_iItems] FOREIGN KEY ([empresa], [item]) REFERENCES [dbo].[iItems] ([empresa], [codigo]),
    CONSTRAINT [FK_iItemsCriterios_iMayorItem] FOREIGN KEY ([empresa], [idMayor]) REFERENCES [dbo].[iMayorItem] ([empresa], [codigo]),
    CONSTRAINT [FK_iItemsCriterios_iPlanItem] FOREIGN KEY ([empresa], [idPlan]) REFERENCES [dbo].[iPlanItem] ([empresa], [codigo])
);

