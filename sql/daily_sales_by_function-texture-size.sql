SELECT o.created_date,
       o.function,
       o.texture,
       o.size,
       SUM(o.rug_quantity) AS quantity
FROM shopify_ruggable.mv_ruggable_shopify_orders_detailed o
WHERE disc_equals_gross = 'include'
AND o.product_type IN ('Rug','Doormat')
AND customer_email IS NOT NULL
GROUP BY 1,2,3,4
ORDER BY 1,2,3,4
