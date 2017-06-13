CREATE TABLE [dbo].[pFrutaEstimadaTmp] (
    [empresa]  INT  NOT NULL,
    [fecha]    DATE NOT NULL,
    [pesoNeto] INT  NULL,
    CONSTRAINT [PK_pFrutaEstimadaTmp] PRIMARY KEY CLUSTERED ([empresa] ASC, [fecha] ASC)
);

