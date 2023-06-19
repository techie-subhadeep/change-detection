-- Shipment Table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='shipment' and xtype='U')
BEGIN
    CREATE TABLE [dbo].[shipment] (
        [id]      INT            NOT NULL,
        [customer_name]    NVARCHAR (50)  NOT NULL,
        [address] NVARCHAR (100) NOT NULL,
        [contact] NVARCHAR (50)  NOT NULL,
        [item]    NVARCHAR (50) NOT NULL,
        [quantity] INT           NOT NULL,
        [modifed_at] DATETIME DEFAULT GETDATE(),
        CONSTRAINT [PK_shipment] PRIMARY KEY CLUSTERED ([id] ASC)
    );
END
GO