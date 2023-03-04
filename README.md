# Web Traffic and Performance Analysis
We will use MySQL to analyze e-commerce website data from an online retailer called the Maven Fuzzy Factory.

### Entity Relationship Diagram
<img width="602" alt="Maven ERD" src="https://user-images.githubusercontent.com/70214561/220702404-e4aa5230-b446-43f8-99b9-d9e06373c84a.png">

### Tables
#### We will use 3 tables for our analyses:
`website_sessions` - This table shows each website session access by users, where the traffic is coming from and which source is helping to generate the orders. Records consist of unique website session id, UTM (Urchin Tracking Module) fields, user id, and device type. UTMs tracking parameters used by Google Analytics to track paid marketing activity.

`website_pageviews` - This table shows every page viewed for each website session access by users. Records consist of website session id, website pageview id, and pageview url.

`orders` - This table shows every order made by customers. Records consist of customers' orders with order id, time when the order is created, website session id, unique user id, primary product id, count of products purchased, price in USD, and cost of goods sold (cogs) in USD.

### Traffic Source Analysis
We will analyze:
- Where our traffic is coming from, hence where our customers are coming from and which channels are driving the highest quality traffic 
- How it performs in terms of volume and conversion rates
- How to adjust bids to optimize marketing budgets
