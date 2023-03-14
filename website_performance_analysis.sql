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

-- Calculating Bounce Rates of the Homepage

WITH first_pageview AS
(
	SELECT 
		website_session_id,
		MIN(website_pageview_id) AS min_pageview_id
	FROM website_pageviews
	WHERE created_at < '2012-06-14'
	GROUP BY website_session_id
),
sessions_landing_page AS 
(
	SELECT 
		fp.website_session_id,
		wp.pageview_url AS landing_page
	FROM first_pageview fp
	JOIN website_pageviews wp 
		ON fp.min_pageview_id = wp.website_pageview_id
	WHERE wp.pageview_url = '/home'
),
bounced_sessions AS 
(
	SELECT 	
		sl.website_session_id,
		sl.landing_page,
		COUNT(wp.website_pageview_id) AS pages_viewed_count
	FROM sessions_landing_page sl
	JOIN website_pageviews wp 
		USING(website_session_id)
	GROUP BY sl.website_session_id, sl.landing_page
	HAVING pages_viewed_count = 1
)
SELECT 	
	sl.landing_page,
	COUNT(DISTINCT sl.website_session_id) AS sessions_count,
	COUNT(DISTINCT bs.website_session_id) AS bounced_sessions_count,
	COUNT(DISTINCT bs.website_session_id)/COUNT(DISTINCT sl.website_session_id) AS bounce_rate
FROM sessions_landing_page sl
LEFT JOIN bounced_sessions bs 
	USING (website_session_id);
	
-- Analyzing Landing Page Tests

-- 1. Find the first instance of /lander-1

SELECT
	MIN(created_at) AS first_created_at,
	MIN(website_pageview_id) AS first_pageview_id
FROM website_pageviews 
WHERE pageview_url = '/lander-1';

-- 2. Bounce Rates Comparison

WITH first_pageview AS
(
	SELECT 
		wp.website_session_id,
		MIN(wp.website_pageview_id) AS min_pageview_id
	FROM website_pageviews wp
	JOIN website_sessions ws
		USING (website_session_id)
	WHERE wp.created_at < '2012-07-28'
		AND wp.website_pageview_id >= 23504
		AND ws.utm_source = 'gsearch'
		AND ws.utm_campaign = 'nonbrand'
	GROUP BY wp.website_session_id
),
sessions_landing_page AS 
(
	SELECT 
		fp.website_session_id,
		wp.pageview_url AS landing_page
	FROM first_pageview fp
	JOIN website_pageviews wp 
		ON fp.min_pageview_id = wp.website_pageview_id 
	WHERE wp.pageview_url IN ('/home', '/lander-1')
),
bounced_sessions AS 
(
	SELECT 	
		sl.website_session_id,
		sl.landing_page,
		COUNT(wp.website_pageview_id) AS pages_viewed_count
	FROM sessions_landing_page sl
	JOIN website_pageviews wp 
		USING(website_session_id)
	GROUP BY sl.website_session_id, sl.landing_page
	HAVING pages_viewed_count = 1
)
SELECT 
	sl.landing_page,
	COUNT(DISTINCT sl.website_session_id) AS sessions_count,
	COUNT(DISTINCT bs.website_session_id) AS bounced_sessions_count,
	COUNT(DISTINCT bs.website_session_id)/COUNT(DISTINCT sl.website_session_id) AS bounce_rate
FROM sessions_landing_page sl
LEFT JOIN bounced_sessions bs 
	USING (website_session_id)
GROUP BY sl.landing_page;