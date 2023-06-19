-- Create Copy Trigger for Customer
CREATE OR ALTER TRIGGER  [dbo].[tgr_copy_customer]
ON [dbo].[customer]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT * from inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[customer_delta]
        SELECT *,NEWID() delta_change_id, GETDATE() AS delta_change_at, 'U' AS delta_change
        FROM inserted;
    END

    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[customer_delta]
        SELECT *,NEWID() delta_change_id, GETDATE() AS delta_change_at, 'I' AS delta_change
        FROM inserted;
    END

    IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS(SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[customer_delta]
        SELECT *,NEWID() delta_change_id, GETDATE() AS delta_change_at, 'D' AS delta_change
        FROM deleted;
    END
END
GO


-- Create Copy Trigger for Order
CREATE OR ALTER TRIGGER  [dbo].[tgr_copy_order]
ON [dbo].[order]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS(SELECT * from inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[order_delta]
        SELECT *,NEWID() delta_change_id, GETDATE() AS delta_change_at, 'U' AS delta_change
        FROM inserted;
    END

    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS(SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[order_delta]
        SELECT *,NEWID() delta_change_id, GETDATE() AS delta_change_at, 'I' AS delta_change
        FROM inserted;
    END

    IF EXISTS(SELECT * FROM deleted) AND NOT EXISTS(SELECT * FROM inserted)
    BEGIN
        INSERT INTO [dbo].[order_delta]
        SELECT *,NEWID() delta_change_id, GETDATE() AS delta_change_at, 'D' AS delta_change
        FROM deleted;
    END
END
GO