CREATE TABLE [dbo].[pTransaccionJerarquiaAnalisis] (
    [tipo]          VARCHAR (50)    NOT NULL,
    [numero]        VARCHAR (50)    NOT NULL,
    [año]           INT             NOT NULL,
    [mes]           INT             NOT NULL,
    [fecha]         DATETIME        NOT NULL,
    [empresa]       INT             NOT NULL,
    [jerarquia]     INT             NOT NULL,
    [registro]      INT             NOT NULL,
    [analisis]      VARCHAR (50)    NOT NULL,
    [resultado]     BIT             NOT NULL,
    [prioridad]     INT             NOT NULL,
    [valor]         DECIMAL (18, 4) NOT NULL,
    [fechaRegistro] DATETIME        NOT NULL,
    [usuario]       VARCHAR (50)    NOT NULL,
    CONSTRAINT [PK_pTransaccionJerarquiaAnalisis] PRIMARY KEY CLUSTERED ([tipo] ASC, [numero] ASC, [año] ASC, [mes] ASC, [fecha] ASC, [empresa] ASC, [jerarquia] ASC, [registro] ASC, [analisis] ASC)
);

