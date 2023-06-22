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
    c.delta_change    customer_change,
    DATEDIFF(
        ss, 
        (SELECT MAX(v) FROM (values (o.delta_change_at), (c.delta_change_at)) AS value(v)),
        GETDATE()
    ) AS seconds_passed
FROM   [dbo].[customer_delta] c,
    [dbo].[order_delta] o
WHERE  o.customer_id = c.id;