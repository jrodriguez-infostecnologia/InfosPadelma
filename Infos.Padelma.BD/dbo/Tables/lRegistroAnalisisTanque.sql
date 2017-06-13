CREATE TABLE [dbo].[lRegistroAnalisisTanque] (
    [empresa]    INT          NOT NULL,
    [tipo]       VARCHAR (50) NOT NULL,
    [numero]     VARCHAR (50) NOT NULL,
    [tanque]     VARCHAR (50) NOT NULL,
    [porcentaje] INT          CONSTRAINT [DF_lRegistroAnalisisTanque_porcentaje] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_lRegistroAnalisisTanque] PRIMARY KEY CLUSTERED ([empresa] ASC, [tipo] ASC, [numero] ASC, [tanque] ASC),
    CONSTRAINT [CK_lRegistroAnalisisTanque] CHECK ([porcentaje]>=(0) AND [porcentaje]<=(100))
);

