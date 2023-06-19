-- Create View to Create Shipment
CREATE OR ALTER VIEW [dbo].[shipment]
AS
SELECT o.id          shipment_id,
    NAME          customer_name,
    address,
    contact,
    item,
    quantity,
    o.delta_change_at order_change_at,
    o.delta_change    order_change,
    c.delta_change_at customer_change_at,
    c.delta_change    customer_change
FROM   [dbo].[customer_delta] c,
    [dbo].[order_delta] o
WHERE  o.customer_id = c.id
    AND ( o.delta_change_at > Dateadd(second, -30, Getdate())
            OR c.delta_change_at > Dateadd(second, -30, Getdate()) );
GO