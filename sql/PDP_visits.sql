WITH products AS (
    SELECT DISTINCT SPLIT_PART(handle,'-',1) AS handle_1,
                    SPLIT_PART(handle,'-',2) AS handle_2,
                    LISTAGG(DISTINCT tags, ', ') WITHIN GROUP (ORDER BY tags) OVER(PARTITION BY handle_1,handle_2) AS tags
    FROM shopify_ruggable.products
)
SELECT p.*,
       CASE
           WHEN d.tags ILIKE '%jute%' THEN 'jute'
           WHEN d.tags ILIKE '%plush%' THEN 'plush'
           WHEN d.tags ILIKE '%shag%' THEN 'shag'
           WHEN d.tags ILIKE '%outdoor%' THEN 'outdoor'
           WHEN d.tags ILIKE '%door%mat%' THEN 'doormat'
           WHEN d.tags ILIKE '%kids%' THEN 'kids'
           WHEN d.tags ILIKE '%star%wars%' THEN 'star wars'
           WHEN d.tags ILIKE '%disney%' OR d.tags ILIKE '%mickey%' THEN 'disney'
           WHEN d.tags ILIKE '%cynthia%rowley%' THEN 'cynthia rowley'
           WHEN d.tags ILIKE '%founder%farmhouse%' THEN 'founders farmhouse'
           ELSE 'general / other'
           END AS pdp_type
FROM heap.pageviews p
INNER JOIN products d
    ON SPLIT_PART(SPLIT_PART(p.path,'/',3),'-',1) = handle_1 AND
       SPLIT_PART(SPLIT_PART(p.path,'/',3),'-',2) = handle_2
WHERE p.session_time::DATE BETWEEN '2021-01-01' AND CURRENT_DATE-1
