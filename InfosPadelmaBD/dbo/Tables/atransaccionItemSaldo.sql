CREATE TABLE [dbo].[atransaccionItemSaldo] (
    [empresa]      INT          NOT NULL,
    [tipo]         VARCHAR (50) NOT NULL,
    [numero]       VARCHAR (50) NOT NULL,
    [referencia]   VARCHAR (50) NOT NULL,
    [lote]         VARCHAR (50) NOT NULL,
    [item]         INT          NOT NULL,
    [fecha]        DATE         NOT NULL,
    [saldoInicial] FLOAT (53)   NOT NULL,
    [suma]         FLOAT (53)   NOT NULL,
    [resta]        FLOAT (53)   NOT NULL,
    [saldoFinal]   FLOAT (53)   NOT NULL,
    [anulado]      BIT          NOT NULL
);

