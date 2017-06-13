CREATE TABLE [dbo].[aLotesDetalle] (
    [empresa]   INT          NOT NULL,
    [lote]      VARCHAR (50) NOT NULL,
    [linea]     INT          NOT NULL,
    [noPalma]   INT          NOT NULL,
    [izquierda] BIT          CONSTRAINT [DF_aLotesDetalle_izquierda] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_aLotesDetalle] PRIMARY KEY CLUSTERED ([empresa] ASC, [lote] ASC, [linea] ASC),
    CONSTRAINT [FK_aLotesDetalle_gEmpresa] FOREIGN KEY ([empresa]) REFERENCES [dbo].[gEmpresa] ([id])
);

