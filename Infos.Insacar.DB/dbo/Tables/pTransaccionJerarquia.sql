CREATE TABLE [dbo].[pTransaccionJerarquia] (
    [tipo]           VARCHAR (50)  NOT NULL,
    [numero]         VARCHAR (50)  NOT NULL,
    [año]            INT           NOT NULL,
    [mes]            INT           NOT NULL,
    [fecha]          DATETIME      NOT NULL,
    [empresa]        INT           NOT NULL,
    [fechaRegistro]  DATETIME      NOT NULL,
    [usuario]        VARCHAR (50)  NOT NULL,
    [observacion]    VARCHAR (500) NOT NULL,
    [anulado]        BIT           NOT NULL,
    [usuarioAnulado] VARCHAR (50)  NULL,
    CONSTRAINT [PK_pTransaccionJerarquia_1] PRIMARY KEY CLUSTERED ([tipo] ASC, [numero] ASC, [año] ASC, [mes] ASC, [fecha] ASC, [empresa] ASC)
);

