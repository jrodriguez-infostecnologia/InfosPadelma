CREATE TABLE [dbo].[aTransaccionItem] (
    [empresa]    INT          NOT NULL,
    [tipo]       VARCHAR (50) NOT NULL,
    [numero]     VARCHAR (50) NOT NULL,
    [registro]   INT          NOT NULL,
    [lote]       VARCHAR (50) NOT NULL,
    [año]        INT          NOT NULL,
    [mes]        INT          NOT NULL,
    [fecha]      DATE         NOT NULL,
    [fechaFinal] DATE         NOT NULL,
    [item]       INT          NOT NULL,
    [uMedida]    VARCHAR (50) NOT NULL,
    [novedad]    VARCHAR (50) NULL,
    [cantidad]   FLOAT (53)   NOT NULL,
    [saldo]      FLOAT (53)   NOT NULL,
    [mBulto]     FLOAT (53)   NOT NULL,
    [pBulto]     FLOAT (53)   NOT NULL,
    [noPalmas]   FLOAT (53)   NOT NULL,
    [dosis]      FLOAT (53)   NOT NULL,
    [registror]  INT          NOT NULL,
    CONSTRAINT [PK_aTransaccionItem] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [registro] ASC, [lote] ASC),
    CONSTRAINT [FK_aTransaccionItem_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id]),
    CONSTRAINT [FK_aTransaccionItem_iItems] FOREIGN KEY ([empresa], [item]) REFERENCES [dbo].[iItems] ([empresa], [codigo])
);



