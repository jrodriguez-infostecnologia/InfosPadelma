CREATE TABLE [dbo].[iItemsBodega] (
    [empresa] INT          NOT NULL,
    [item]    VARCHAR (50) NOT NULL,
    [bodega]  VARCHAR (5)  NOT NULL,
    CONSTRAINT [PK_iItemBodega] PRIMARY KEY CLUSTERED ([empresa] ASC, [item] ASC, [bodega] ASC)
);

