CREATE TABLE [dbo].[pCalibracionTanque] (
    [empresa]    INT             NOT NULL,
    [movimiento] VARCHAR (50)    NOT NULL,
    [tipo]       VARCHAR (2)     NOT NULL,
    [altura]     INT             NOT NULL,
    [volumen]    DECIMAL (18, 4) NOT NULL,
    [activo]     BIT             CONSTRAINT [DF_pCalibracionTanque_activo] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_pCalibracionTanque] PRIMARY KEY CLUSTERED ([empresa] ASC, [movimiento] ASC, [tipo] ASC, [altura] ASC)
);

