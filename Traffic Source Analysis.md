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
<img width="664" alt="Screenshot 2023-04-04 at 00 52 47" src="https://user-images.githubusercontent.com/70214561/230494628-faed3a71-8ed1-48a8-9c6a-35958eb65bd4.png">

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
<img width="479" alt="Screenshot 2023-04-04 at 01 02 30" src="https://user-images.githubusercontent.com/70214561/230494681-a752e35b-96dd-4625-a9c7-70c79952eab1.png">

#### Insights:
- The conversion rate is 2.88%, which is less than 4%, hence we're overspending on gsearch nonbrand campaign and have to reduce bids.
- Next, we will have to monitor the impact of bid reduction for the campaign.

### CASE 3
#### Request: TRAFFIC SOURCE TREND ANALYSIS AFTER BIDDING DOWN
**May 12, 2012**
<br>
Based on the conversion rate analysis, we bid down the gsearch nonbrand on 2012-04-15. Pull the gsearch nonbrand trended session volume by week until May 5 to see if the bid changes have caused volume to drop at all.

````sql
SELECT 	
	MIN(DATE(created_at)) AS week_start_date,
	COUNT(DISTINCT website_session_id) AS sessions_count
FROM website_sessions 
WHERE created_at < '2012-05-10'
	AND utm_source = 'gsearch'
	AND utm_campaign = 'nonbrand'
GROUP BY WEEK(created_at);
````
<img width="328" alt="Screenshot 2023-04-08 at 02 22 29" src="https://user-images.githubusercontent.com/70214561/230666147-13b4f61d-11ad-4ff1-bec6-ce2c2748c6db.png">

#### Insights:
- The sessions after April 15, 2012 have dropped, so it does look like gsearch nonbrand is sensitive to bid changes.
- Continue to monitor session volume. 
- We want to make campaigns more efficient by maximising volume at the lowest possible bid.
