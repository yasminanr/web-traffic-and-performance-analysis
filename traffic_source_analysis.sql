USE mavenfuzzyfactory;

-- Tables used: website_sessions, website_pageviews, orders

-- Finding Top Traffic Sources

SELECT 
	utm_source,
	utm_campaign,
	http_referer,
	COUNT(DISTINCT website_session_id) AS sessions_count
FROM website_sessions
WHERE created_at < '2012-04-12'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY sessions_count DESC;

-- Traffic Source Conversion Rates

SELECT
	COUNT(DISTINCT ws.website_session_id) AS sessions_count,
	COUNT(DISTINCT o.order_id) AS orders,
	COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id) AS session_order_conv_rate
FROM website_sessions ws
LEFT JOIN orders o 
	USING (website_session_id)
WHERE ws.created_at < '2012-04-14'
	AND ws.utm_source = 'gsearch'
	AND ws.utm_campaign = 'nonbrand';
