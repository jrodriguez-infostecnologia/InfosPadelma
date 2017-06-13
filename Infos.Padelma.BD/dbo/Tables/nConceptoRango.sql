CREATE TABLE [dbo].[nConceptoRango] (
    [empresa]    INT             NOT NULL,
    [concepto]   VARCHAR (50)    NOT NULL,
    [registro]   INT             NOT NULL,
    [minimo]     MONEY           NOT NULL,
    [maximo]     MONEY           NOT NULL,
    [porcentaje] DECIMAL (18, 3) NOT NULL,
    [valor]      MONEY           NOT NULL,
    [por]        BIT             NOT NULL,
    CONSTRAINT [PK_nConceptoRango] PRIMARY KEY CLUSTERED ([empresa] ASC, [concepto] ASC, [registro] ASC)
);

