CREATE TABLE [dbo].[aLoteCcostoSigo] (
    [empresa]     INT          NOT NULL,
    [lote]        VARCHAR (50) NOT NULL,
    [mCcostoSigo] VARCHAR (50) NOT NULL,
    [aCcostoSigo] VARCHAR (50) NOT NULL,
    CONSTRAINT [PK_aLaborCcostoSigo] PRIMARY KEY CLUSTERED ([empresa] ASC, [lote] ASC)
);

