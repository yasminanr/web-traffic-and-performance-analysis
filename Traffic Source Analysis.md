## Traffic Source Analysis

### CASE 1
#### Request: FINDING TOP TRAFFIC SOURCE
**April 12, 2012**
<br>
The company has been live for almost a month now and is starting to generate sales. Write a query identifying where the bulk of the website sessions are coming from up to April 12 2012, break it down by UTM source, campaign, and referring domain.

````sql
SELECT 
	utm_source,
	utm_campaign,
	http_referer,
	COUNT(DISTINCT website_session_id) AS sessions_count
FROM website_sessions
WHERE created_at < '2012-04-12'
GROUP BY utm_source, utm_campaign, http_referer
ORDER BY sessions_count DESC;
````

#### Insights:
- Gsearch nonbrand has the highest session count among others.
- Dig deeper into gsearch nonbrand traffic to explore potential optimization opportunities.

### CASE 2
#### Request: TRAFFIC SOURCE CONVERSION RATES
**April 14, 2012**
<br>
It seems that gsearch nonbrand is the major traffic source, but we need to understand if those sessions are driving sales. 
Calculate its conversion rate (CVR) from session to order. If CVR >= 4%, increase the bids to drive volume, otherwise reduce bids.

````sql
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
````

#### Insights:
- The conversion rate is 2.88%, which is less than 4%, hence we're overspending on gsearch nonbrand campaign and have to reduce bids.- Next, we will have to monitor the impact of bid reduction for the campaign.
