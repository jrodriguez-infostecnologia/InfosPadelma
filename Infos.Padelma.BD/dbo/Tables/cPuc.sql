CREATE TABLE [dbo].[cPuc] (
    [empresa]    INT           NOT NULL,
    [codigo]     VARCHAR (16)  NOT NULL,
    [raiz]       VARCHAR (16)  NOT NULL,
    [nombre]     VARCHAR (150) NOT NULL,
    [naturaleza] CHAR (1)      NOT NULL,
    [nivel]      INT           NOT NULL,
    [tipo]       CHAR (1)      NOT NULL,
    [tercero]    BIT           NOT NULL,
    [cCosto]     BIT           NOT NULL,
    [base]       BIT           NOT NULL,
    [activo]     BIT           NOT NULL,
    [clase]      VARCHAR (50)  NOT NULL,
    CONSTRAINT [PK_cPuc] PRIMARY KEY CLUSTERED ([codigo] ASC, [empresa] ASC)
);

