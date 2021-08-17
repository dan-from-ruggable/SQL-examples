SELECT p.landing_page,
       COUNT(DISTINCT p.session_id) AS num_sessions
FROM heap.pageviews p
WHERE p.session_time::DATE BETWEEN '2021-01-01' AND CURRENT_DATE-1
GROUP BY 1
ORDER BY 2 DESC
