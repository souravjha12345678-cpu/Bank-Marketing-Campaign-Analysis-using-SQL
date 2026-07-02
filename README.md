/*
===============================================================================
                         BANK MARKETING CAMPAIGN ANALYSIS
===============================================================================

Project Name : Bank Marketing Campaign Analysis

Author       : Your Name

Database     : MySQL

Project Goal :
Analyze customer demographics, financial behavior, and marketing campaign
performance to identify customers who are most likely to subscribe to a
term deposit and provide actionable business recommendations.

Dataset :
- Total Records : 45,211
- Target Variable : deposite

Skills Demonstrated :
✔ SQL
✔ Aggregate Functions
✔ Conditional Aggregation
✔ CASE Statements
✔ Business Analysis
✔ Customer Segmentation

===============================================================================
*/

USE bankDb;
# 📊 Bank Marketing Campaign Analysis using SQL

## 🎯 Project Objective

Analyze customer demographics, financial information, and marketing campaign performance to identify customers who are most likely to subscribe to a term deposit.

---

# 📈 Data Exploration

### Q1. Find the total number of customers.

```sql
SELECT COUNT(*) AS total_customers
FROM bank_data;
```

**Business Insight:**
> The dataset contains **45,211** customer records.

---

### Q2. Find the total number of subscribed customers.

```sql
SELECT COUNT(*) AS subscribed_customers
FROM bank_data
WHERE deposite = 'yes';
```

**Business Insight:**
> A total of **5,289** customers subscribed to the term deposit.

---

### Q3. Find the total number of non-subscribed customers.

```sql
SELECT COUNT(*) AS non_subscribed_customers
FROM bank_data
WHERE deposite = 'no';
```

**Business Insight:**
> A total of **39,922** customers did not subscribe to the term deposit.

---

### Q4. Calculate the overall subscription rate.

```sql
SELECT
ROUND(
    (SELECT COUNT(*)
     FROM bank_data
     WHERE deposite = 'yes') * 100.0 /
    (SELECT COUNT(*)
     FROM bank_data),
2) AS subscription_rate;
```

**Business Insight:**
> The overall subscription rate is **11.70%**, indicating that approximately **1 out of every 9 contacted customers** subscribed to the term deposit.

---

# 👥 Customer Demographic Analysis

### Q5. Which occupation has the highest number of subscribers?

```sql
SELECT
    occupation,
    COUNT(*) AS subscription_count
FROM bank_data
WHERE deposite = 'yes'
GROUP BY occupation
ORDER BY subscription_count DESC;
```

**Business Insight:**
> **Management** contributed the highest number of subscribers (**1,301**), making it the largest customer group purchasing term deposits.

---

### Q6. Which occupation has the highest subscription rate?

```sql
SELECT
    occupation,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY occupation
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> **Students** achieved the highest subscription rate (**28.68%**), indicating they are the most responsive occupation segment.

---

### Q7. Which age group subscribes the most?

```sql
SELECT
    age_group,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers
FROM bank_data
GROUP BY age_group
ORDER BY subscribed_customers DESC;
```

**Business Insight:**
> Customers aged **26–35** contributed the highest number of subscriptions (**1,869**).

---

### Q8. Which marital status has the highest subscription rate?

```sql
SELECT
    marital,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY marital
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> **Single** customers recorded the highest subscription rate (**14.95%**), suggesting they are more likely to subscribe than married or divorced customers.

---

### Q9. Which education level has the highest subscription rate?

```sql
SELECT
    education,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY education
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> Customers with **tertiary education** achieved the highest subscription rate (**15.01%**), indicating that education level positively influences the likelihood of subscribing.

# 💰 Financial Analysis

### Q10. Compare subscriptions based on personal loan.

```sql
SELECT
    loan,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY loan;
```

**Business Insight:**
> Customers **without personal loans** achieved the highest subscription rate (**12.66%**) with **4,805** successful subscriptions, indicating they are more likely to invest in term deposits.

---

### Q11. Compare subscriptions based on housing loan.

```sql
SELECT
    housing,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY housing
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> Customers **without housing loans** recorded the highest subscription rate (**16.70%**) with **3,354** subscriptions, making them a valuable customer segment.

---

### Q12. Compare subscriptions based on credit default.

```sql
SELECT
    default_credit,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY default_credit;
```

**Business Insight:**
> Customers **without a credit default** achieved a subscription rate of **11.80%** with **5,237** successful subscriptions, indicating that financially reliable customers are more likely to subscribe.

---

### Q13. What is the average account balance of subscribed customers?

```sql
SELECT
    AVG(balance) AS avg_balance
FROM bank_data
WHERE deposite = 'yes';
```

**Business Insight:**
> The average account balance of subscribed customers is **1,804.26**, suggesting that customers with stronger financial positions are more likely to invest in term deposits.

---

### Q14. Compare the average account balance of subscribers and non-subscribers.

```sql
SELECT
(
    SELECT AVG(balance)
    FROM bank_data
    WHERE deposite = 'yes'
) AS avg_balance_subscribers,

(
    SELECT AVG(balance)
    FROM bank_data
    WHERE deposite = 'no'
) AS avg_balance_non_subscribers;
```

**Business Insight:**
> Subscribers maintained an average account balance of **1,804.26**, compared to **1,303.71** for non-subscribers. This suggests that customers with higher account balances are more likely to subscribe to a term deposit.

---
# 📞 Campaign Analysis

### Q15. Which contact method resulted in the highest subscription rate?

```sql
SELECT
    contact,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY contact
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> **Cellular** was the most effective contact method, achieving the highest subscription rate of **14.91%**. This suggests that customers contacted through mobile phones are more likely to subscribe to a term deposit.

---

### Q16. Which month generated the highest number of subscriptions?

```sql
SELECT
    month,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY month
ORDER BY subscribed_customers DESC;
```

**Business Insight:**
> **May** recorded the highest number of successful subscriptions (**925 customers**), indicating that marketing campaigns during this month generated the largest volume of conversions.

---

### Q17. How does call duration affect subscriptions?

```sql
SELECT
    deposite,
    COUNT(*) AS total_customers,
    AVG(duration) AS avg_call_duration
FROM bank_data
GROUP BY deposite;
```

**Business Insight:**
> Customers who subscribed had an average call duration of **537.29 seconds**, compared to **221.18 seconds** for non-subscribers. This indicates that engaged customers typically spend more time speaking with the bank representative.

> **Note:** Longer call duration does not necessarily cause subscriptions; it may simply reflect that interested customers naturally remain on the call longer.

---

### Q18. How many contacts (campaign) are usually required before customers subscribe?

```sql
SELECT
    campaign,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY campaign
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> Most successful subscriptions occurred within the **first three customer contacts**.
>
> - **1 Contact:** 2,561 subscribers (14.59%)
> - **2 Contacts:** 1,401 subscribers (11.20%)
> - **3 Contacts:** 618 subscribers (11.19%)
>
> Additional contact attempts produced lower subscription rates, suggesting diminishing returns from repeated follow-up calls.

---

### Q19. Compare subscriptions based on previous campaign outcome.

```sql
SELECT
    poutcome,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY poutcome
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> Customers whose **previous campaign outcome was "Success"** achieved an outstanding subscription rate of **64.73%**, making previous campaign success the strongest predictor of future term deposit subscriptions.

---
# 👥 Customer Behavior Analysis

### Q20. Which age group has the highest subscription rate?

```sql
SELECT
    age_group,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY age_group
ORDER BY subscription_rate DESC;
```

**Business Insight:**
> Customers aged **60+** achieved the highest subscription rate (**42.26%**), making them the most responsive age segment for term deposit campaigns.

---

### Q21. Compare the average account balance and subscription rate across different age groups.

```sql
SELECT
    age_group,
    ROUND(AVG(balance),2) AS avg_balance,
    COUNT(*) AS total_customers,
    SUM(CASE WHEN deposite='yes' THEN 1 ELSE 0 END) AS subscribed_customers,
    ROUND(
        SUM(CASE WHEN deposite='yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
        2
    ) AS subscription_rate
FROM bank_data
GROUP BY age_group
ORDER BY avg_balance DESC;
```

**Business Insight:**
> Customers aged **60+** maintained the highest average account balance (**2,678.45**) and also recorded the highest subscription rate, indicating this segment represents a high-value customer group.

---

# 📌 Key Findings

- The dataset contains **45,211** customer records.
- Overall subscription rate is **11.70%**.
- **Management** contributed the highest number of subscribers.
- **Students** achieved the highest occupation-wise subscription rate (**28.68%**).
- Customers aged **26–35** generated the highest number of subscriptions.
- Customers aged **60+** achieved the highest subscription rate (**42.26%**).
- **Single** customers subscribed more frequently than other marital groups.
- Customers with **tertiary education** recorded the highest subscription rate.
- Customers **without personal loans** and **without housing loans** were more likely to subscribe.
- Subscribers maintained a significantly higher average account balance than non-subscribers.
- **Cellular** was the most effective contact method.
- **May** generated the highest number of subscriptions.
- Customers contacted **1–3 times** achieved the highest subscription rates.
- Customers with a **previous successful campaign outcome** achieved a **64.73%** subscription rate.

---

# 💼 Business Recommendations

### 1. Prioritize High-Potential Customer Segments

Focus future marketing campaigns on:

- Students
- Customers aged **60+**
- Single customers
- Customers with tertiary education

These groups demonstrated the highest likelihood of subscribing to a term deposit.

---

### 2. Target Customers Without Existing Loans

Customers without housing loans and personal loans showed higher subscription rates.

**Recommendation:**
Prioritize these customers during campaign planning to improve conversion rates.

---

### 3. Focus on High-Balance Customers

Subscribers maintained a higher average account balance than non-subscribers.

**Recommendation:**
Customers with larger account balances should receive priority when promoting investment products such as term deposits.

---

### 4. Re-engage Previous Successful Customers

Customers whose previous campaign outcome was **Success** achieved the highest subscription rate (**64.73%**).

**Recommendation:**
Include these customers as the highest-priority audience in future marketing campaigns.

---

### 5. Use Cellular as the Preferred Contact Method

Cellular achieved the highest subscription rate among all contact methods.

**Recommendation:**
Allocate more marketing efforts toward cellular communication while monitoring campaign performance.

---

### 6. Schedule Campaigns During High-Performing Months

May generated the largest number of successful subscriptions.

**Recommendation:**
Increase campaign activity during high-performing months while investigating seasonal trends that contribute to higher conversions.

---

### 7. Reduce Excessive Follow-up Calls

Most successful subscriptions occurred within the first three customer contacts.

**Recommendation:**
Limit repeated follow-up calls after three unsuccessful attempts to reduce marketing costs and improve campaign efficiency.

---

### 8. Personalize Marketing Campaigns

Rather than contacting every customer with the same strategy, segment customers using:

- Age Group
- Occupation
- Education
- Loan Status
- Account Balance

Personalized campaigns are likely to improve conversion rates.

---

### 9. Improve Customer Data Quality

The dataset contains several **Unknown** values across categorical fields.

**Recommendation:**
Improve data collection practices to reduce missing or unknown information, enabling more accurate customer segmentation and marketing decisions.

---

# 🏁 Conclusion

This SQL project analyzed customer demographics, financial information, and campaign performance to identify the characteristics of customers most likely to subscribe to a term deposit.

The analysis revealed that customer age, occupation, education level, financial status, previous campaign outcomes, and contact methods significantly influence subscription behavior. By applying these insights, the bank can optimize customer targeting, improve marketing efficiency, and increase future subscription rates.

---

## ⭐ Skills Demonstrated

- SQL Querying
- Data Exploration
- Aggregate Functions
- CASE Statements
- Conditional Aggregation
- Business Analysis
- Customer Segmentation
- Marketing Analytics
- Data-Driven Decision Making
