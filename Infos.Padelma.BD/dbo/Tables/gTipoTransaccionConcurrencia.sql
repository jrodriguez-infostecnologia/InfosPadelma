CREATE TABLE [dbo].[gTipoTransaccionConcurrencia] (
    [transaccion]  VARCHAR (50) NOT NULL,
    [empresa]      INT          NOT NULL,
    [concurrencia] CHAR (1)     NOT NULL,
    [control]      BIT          NOT NULL,
    CONSTRAINT [PK_gTransaccionConcurrencia] PRIMARY KEY CLUSTERED ([transaccion] ASC, [empresa] ASC)
);

