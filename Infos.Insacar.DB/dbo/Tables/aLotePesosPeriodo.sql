CREATE TABLE [dbo].[aLotePesosPeriodo] (
    [empresa]      INT             NOT NULL,
    [año]          INT             NOT NULL,
    [mes]          INT             NOT NULL,
    [finca]        VARCHAR (50)    NOT NULL,
    [seccion]      VARCHAR (50)    NULL,
    [lote]         VARCHAR (50)    NOT NULL,
    [pesoRacimo]   DECIMAL (18, 3) NOT NULL,
    [automatico]   BIT             CONSTRAINT [DF_aLotePesosPeriodo_aturomatico] DEFAULT ((0)) NOT NULL,
    [fechaInicial] DATE            NULL,
    [fechaFinal]   DATE            NULL,
    CONSTRAINT [PK_aLotePesosPeriodo] PRIMARY KEY CLUSTERED ([empresa] ASC, [año] ASC, [mes] ASC, [finca] ASC, [lote] ASC)
);

