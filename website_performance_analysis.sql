-- WEBSITE PERFORMANCE ANALYSIS

-- Finding Top Website Pages

SELECT 
	pageview_url,
	COUNT(DISTINCT website_pageview_id) AS pageviews_count
FROM website_pageviews wp 
WHERE created_at < '2012-06-09'
GROUP BY pageview_url 
ORDER BY pageviews_count DESC;

-- Finding Top Entry Pages

WITH entry_pageview AS
(
	SELECT 
		website_session_id,
		MIN(website_pageview_id) AS min_pageview_id
	FROM website_pageviews
	WHERE created_at < '2012-06-12'
	GROUP BY website_session_id
)
SELECT 
	wp.pageview_url AS landing_page,
	COUNT(DISTINCT ep.website_session_id) AS sessions_count
FROM entry_pageview ep
JOIN website_pageviews wp 
	ON ep.min_pageview_id = wp.website_pageview_id
GROUP BY landing_page;