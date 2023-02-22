We will use e-commerce website data from an online reatiler called the Maven Fuzzy Factory.

## Entity Relationship Diagram


### Tables
`website_sessions` - This table shows each website session access by users, where the traffic is coming from and which source is helping to generate the orders. Records consist of unique website session id, UTM (Urchin Tracking Module) fields, user id, and device type. UTMs tracking parameters used by Google Analytics to track paid marketing activity.

`website-pageviews` - This table shows every page viewed for each website session access by users. Records consist of website session id, website pageview id, and pageview url.

`orders` - This table shows every order made by customers. Records consist of customers' orders with order id, time when the order is created, website session id, unique user id, primary product id, count of products purchased, price in USD, and cost of goods sold (cogs) in USD.
