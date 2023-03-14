# Web Traffic and Performance Analysis
We will use MySQL to analyze e-commerce website data from an online retailer called the Maven Fuzzy Factory.

### Entity Relationship Diagram
<img width="602" alt="Maven ERD" src="https://user-images.githubusercontent.com/70214561/220702404-e4aa5230-b446-43f8-99b9-d9e06373c84a.png">

### Tables
#### We will use 3 tables for our analyses:
`website_sessions` - This table shows each website session access by users, where the traffic is coming from and which source is helping to generate the orders. Records consist of unique website session id, UTM (Urchin Tracking Module) fields, user id, and device type. UTMs tracking parameters used by Google Analytics to track paid marketing activity.

<img width="1395" alt="website_sessions" src="https://user-images.githubusercontent.com/70214561/224379046-ac4c4aa3-ae14-4cfa-a1ed-fd1c66b75c35.png">

`website_pageviews` - This table shows every page viewed for each website session access by users. Records consist of website session id, website pageview id, and pageview url.

<img width="700" alt="website_pageview" src="https://user-images.githubusercontent.com/70214561/224379119-651446e4-233a-43c6-b37f-828d5a4d902e.png">

`orders` - This table shows every order made by customers. Records consist of customers' orders with order id, time when the order is created, website session id, unique user id, primary product id, count of products purchased, price in USD, and cost of goods sold (cogs) in USD.

<img width="1183" alt="orders" src="https://user-images.githubusercontent.com/70214561/224379204-0bafcf54-6e29-4215-a841-76b4f2092834.png">

### Traffic Source Analysis
- Analyze where our traffic is coming from, hence where our customers are coming from and which channels are driving the highest quality traffic 
- How it performs in terms of volume and conversion rates
- How to adjust bids to optimize marketing budgets

### Channel Portfolio Management
- Understanding which marketing channels are driving the most sessions and orders through your website 
- Understanding differences in user characteristics and conversion performance across marketing channels 
- Optimizing bids and allocating marketing spend across a multi-channel portfolio to achieve maximum performance 
- Identifying how much revenue we are generating from direct traffic - this is high margin revenue without a direct cost of customer acquisition
- Understanding whether or not our paid traffic is generating a “halo” effect, and promoting additional direct traffic

### Website Performance Analysis
- Find the most-viewed pages that customers view on our site
- Find the most common entry pages to our website - the first thing a user sees
- Bouce rates comparison between landing pages
- Analyzing test results and making recommendations on which version of landing pages we should use going forward
