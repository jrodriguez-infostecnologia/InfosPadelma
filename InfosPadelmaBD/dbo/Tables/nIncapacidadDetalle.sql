CREATE TABLE [dbo].[nIncapacidadDetalle] (
    [empresa]   INT        NOT NULL,
    [tercero]   INT        NOT NULL,
    [numero]    INT        NOT NULL,
    [fecha]     DATE       NOT NULL,
    [cantidad]  FLOAT (53) NOT NULL,
    [valor]     FLOAT (53) NOT NULL,
    [cantidadR] FLOAT (53) NOT NULL,
    [valorR]    FLOAT (53) NOT NULL,
    CONSTRAINT [PK_nIncapacidadDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [tercero] ASC, [numero] ASC, [fecha] ASC)
);

