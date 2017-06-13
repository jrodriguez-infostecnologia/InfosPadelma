CREATE TABLE [dbo].[cxcClienteClaseIR] (
    [empresa]  INT          NOT NULL,
    [tercero]  INT          NOT NULL,
    [cliente]  VARCHAR (10) NOT NULL,
    [clase]    INT          NOT NULL,
    [concepto] VARCHAR (5)  NULL,
    CONSTRAINT [PK_cxcClienteClaseIR] PRIMARY KEY CLUSTERED ([empresa] ASC, [tercero] ASC, [cliente] ASC, [clase] ASC)
);

