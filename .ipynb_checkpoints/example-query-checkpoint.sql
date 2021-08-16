SELECT *
FROM shopify_ruggable.mv_ruggable_shopify_orders_detailed o
WHERE disc_equals_gross = 'include'
AND o.product_type IN ('Rug','Doormat')
AND customer_email IS NOT NULL
LIMIT 25
