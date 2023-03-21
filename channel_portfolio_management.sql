-- CHANNEL PORTFOLIO MANAGEMENT

-- Analyzing Channel Portfolio

SELECT 
	MIN(DATE(created_at)) AS week_start_date,
	COUNT(DISTINCT CASE WHEN utm_source = 'bsearch' THEN website_session_id ELSE NULL END) AS bsearch_sessions,
	COUNT(DISTINCT CASE WHEN utm_source = 'gsearch' THEN website_session_id ELSE NULL END) AS gsearch_sessions
FROM website_sessions 
WHERE created_at BETWEEN '2012-08-22' AND '2012-11-29'
	AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at);

-- Comparing Channel Characteristics

SELECT 
	utm_source,
	COUNT(DISTINCT website_session_id) AS sessions_count,
	COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mobile_sessions,
	COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END)/COUNT(DISTINCT website_session_id) AS mobile_pct
FROM website_sessions 
WHERE created_at BETWEEN '2012-08-22' AND '2012-11-30'
	AND utm_campaign = 'nonbrand'
GROUP BY utm_source;

-- Cross-Channel Bid Optimization

SELECT 
	ws.device_type,
	ws.utm_source,
	COUNT(DISTINCT ws.website_session_id) AS sessions_count,
	COUNT(DISTINCT o.order_id) AS order_count,
	COUNT(DISTINCT o.order_id)/COUNT(DISTINCT ws.website_session_id) AS session_order_conv_rate
FROM website_sessions ws 
LEFT JOIN orders o 
	USING (website_session_id)
WHERE ws.created_at BETWEEN '2012-08-22' AND '2012-09-19'
	AND utm_campaign = 'nonbrand'
GROUP BY ws.device_type, ws.utm_source;