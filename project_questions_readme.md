# dbt Project Questions and Responses

## Week 1:
### 1. How many users do we have?
We have 130 users.

### 2. On average, how many orders do we receive per hour?
On average, we receive 7.68 [7.680851] orders per hour. Based on the number of orders placed between the earliest and latest order create datetimes.

### 3. On average, how long does an order take from being placed to being delivered?
On average, an order takes 3.89 [3.891803] days to be delivered after the order is placed.

### 4. How many users have only made one purchase? Two purchases? Three+ purchases?
Number of users with 1 order: 25
Number of users wtih 2 orders: 28
Number of users with 3+ orders: 71

### 5. On average, how many unique sessions do we have per hour?
On average, we get 10.14 [10.140351] unique sessions per hour. Based on number of unqiue sessions created between the earliest and latest available event created datetimes.

## Week 2
### 1. What is our ser repeat rate? Use [Repeat Rate] = [Users who purchase 2+ times] / [Total users who purchased].
Repeat rate is 0.798387

### 2. What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?
- Good indicators of a user who is likely to purchase again: 
    - This might be things like whether they created an account versus using guest checkout, or signed up for email promotions/alerts on the site.
    - Could also look at users who come back to the site repeatedly, whether they purchase or not.
    - If the site offers "favoriting" certain items or pages, does the user use this feature.
- Indicators of users *not* likely to purchase again:
    - Users who use guest checkout versus creating an account.
    - Users who don't spend a lot of time on the site during a session.
    - Users with 1 purchase who submitted a return claim on that order (and did not replace the item).
    - Users with more than N days since last purchase.
- More data that could be useful for this would be user account data, user site traffic data, cart history, purchase history, return history.

### 3. Explain the marts models you added. Why did you organize the models the way you did?
