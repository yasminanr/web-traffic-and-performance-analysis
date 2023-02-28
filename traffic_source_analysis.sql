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
	ROUND(100 * COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id), 2) AS session_order_conv_rate
FROM website_sessions ws
LEFT JOIN orders o 
	USING (website_session_id)
WHERE ws.created_at < '2012-04-14'
	AND ws.utm_source = 'gsearch'
	AND ws.utm_campaign = 'nonbrand';

-- Traffic Source Trending

SELECT 	
	MIN(DATE(created_at)) AS week_start_date,
	COUNT(DISTINCT website_session_id) AS sessions_count
FROM website_sessions 
WHERE created_at < '2012-05-10'
	AND utm_source = 'gsearch'
	AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at);

-- Bid Optimization for Paid Traffic

SELECT 	
	ws.device_type,
	COUNT(DISTINCT ws.website_session_id) AS sessions_count,
	COUNT(DISTINCT o.order_id) AS orders,
	ROUND(100 * COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id), 2) AS session_order_conv_rate
FROM website_sessions ws 
LEFT JOIN orders o 
	USING(website_session_id)
WHERE ws.created_at < '2012-05-11'
	AND utm_source = 'gsearch'
	AND utm_campaign = 'nonbrand'
GROUP BY ws.device_type;

-- Trending with Granular Segments

SELECT 
	MIN(DATE(created_at)) AS week_start_date,
	COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) AS desktop_sessions,
	COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mobile_sessions
FROM website_sessions 
WHERE created_at BETWEEN '2012-04-15' AND '2012-06-09'
	AND utm_source = 'gsearch'
	AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at);

