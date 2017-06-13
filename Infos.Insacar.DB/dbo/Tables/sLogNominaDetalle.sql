CREATE TABLE [dbo].[sLogNominaDetalle] (
    [empresa]  INT            NOT NULL,
    [id]       INT            NOT NULL,
    [tabla]    VARCHAR (150)  NOT NULL,
    [columna]  VARCHAR (250)  NOT NULL,
    [valorAnt] VARCHAR (8000) NULL,
    [valorDes] VARCHAR (8000) NULL,
    [usuario]  VARCHAR (50)   NOT NULL
);

