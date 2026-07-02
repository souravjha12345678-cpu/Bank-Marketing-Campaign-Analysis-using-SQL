use bankDb;
select* from bank_data;

/*
==========================================================
 BANK MARKETING DATA ANALYSIS
 Project Goal:
 Analyze customer and campaign data to identify which type
 of customers are more likely to subscribe to a term deposit.
==========================================================
*/

----------------------------------------------------------
-- DATA EXPLORATION
----------------------------------------------------------

-- 1. Find the total number of customers.
 SELECT count(*) FROM bank_data;
 -- Total number of customers are '45211'

-- 2. Find the total number of subscribed customers.
SELECT COUNT(*) AS subscribed_customers FROM bank_data
WHERE deposite ="yes";
-- subscribed customers '5289'

-- 3. Find the total number of customers who did not subscribe.
SELECT COUNT(*) non_subscribed_customers FROM bank_data
WHERE deposite ="no";
-- non subscribed customers 39922

-- 4. Calculate the overall subscription rate.
SELECT ((SELECT COUNT(*) FROM bank_data WHERE deposite ="yes")*100/
(SELECT COUNT(*) FROM bank_data)) as subscription_rate;
-- subscription rate '11.6985'

----------------------------------------------------------
-- CUSTOMER DEMOGRAPHIC ANALYSIS
----------------------------------------------------------

-- 5. Which occupation has the highest number of subscribers?
SELECT occupation,COUNT(*)AS subscription_count FROM bank_data
WHERE deposite ="yes"
group by occupation
ORDER BY COUNT(*) desc;
-- managment has highest number of subscribers 1301

-- 6. Which occupation has the highest subscription rate?
SELECT occupation,
sum(case 
when deposite = 'yes' then 1
else 0 end ) as subscription_count,
round(sum(case 
when deposite = 'yes' then 1
else 0 end)*100/count(*),2) AS subscription_rate
FROM bank_data
GROUP BY occupation 
ORDER BY subscription_rate desc;
-- student has highest subscription rate 28.68%


-- 7. Which age group subscribes the most?
SELECT age_group,sum(case 
 when deposite ='yes' then 1
 else 0 end) as subscription_count from bank_data
 group by age_group
 ORDER BY subscription_count DESC;
 -- age group '26-35' subscribes the most 1869

-- 8. Which marital status has the highest subscription rate?
SELECT marital,count(*) as total_customers,
sum(case when deposite ='yes' then 1
else 0 end) subscribed_customers , sum(case when deposite ='yes' then 1
	else 0 end)*100/count(*) as subscription_rate
 FROM bank_data
GROUP BY marital
order by subscription_rate DESC;
-- singles have the highest subscription rate 14.9492 %

-- 9. Which education level has the highest subscription rate?
select education,count(*) AS total_customers,
sum(case when deposite ='yes' then 1 else 0 end)AS subscribed_customers,
round(sum(case when deposite ='yes' then 1 else 0 end)*100/count(*),2) as subscription_rate
FROM bank_data
GROUP BY education 
ORDER BY subscription_rate DESC;
-- tertiary has the highest subscription rate 15.01 %
----------------------------------------------------------
-- FINANCIAL ANALYSIS
----------------------------------------------------------

-- 10. Compare subscription based on personal loan.
SELECT
loan,
COUNT(*) total_customers,
SUM(CASE
WHEN deposite='yes'THEN 1 ELSE 0 END) subscribed_customers,
ROUND(SUM(
CASE WHEN deposite='yes' THEN 1 ELSE 0 END)*100/
COUNT(*),2) subscription_rate
FROM bank_data
GROUP BY loan;
-- customers with no personal loan subscribed customers and subscription rate the most with 4805 subscribers and 12.66 % subscription rate 

-- 11. Compare subscription based on personal loan.
SELECT
housing,
COUNT(*) total_customers,
SUM(CASE
WHEN deposite='yes'THEN 1 ELSE 0 END) subscribed_customers,
ROUND(SUM(
CASE WHEN deposite='yes' THEN 1 ELSE 0 END)*100/
COUNT(*),2) subscription_rate
FROM bank_data
GROUP BY housing
ORDER BY subscription_rate DESC ;
-- customers with no house loan subscribed customers and subscription rate the most with 3354 subscribers and 16.70 % subscription rate 

-- 12. Compare subscription based on credit default.
SELECT
default_credit,
COUNT(*) total_customers,
SUM(CASE
WHEN deposite='yes'THEN 1 ELSE 0 END) subscribed_customers,
ROUND(SUM(
CASE WHEN deposite='yes' THEN 1 ELSE 0 END)*100/
COUNT(*),2) subscription_rate
FROM bank_data
GROUP BY default_credit;
-- customers with no DEFAULT CREDIT subscribed customers and subscription rate the most with 5237 subscribers and 11.80 % subscription rate 

-- 13. What is the average account balance of subscribed customers?
SELECT AVG(balance) as avg_balance FROM bank_data
WHERE deposite='yes';
-- average account balance of subscribed customers 1804.26

-- 14. Compare the average account balance of subscribers and non-subscribers.
SELECT (SELECT AVG(balance) as avg_balance FROM bank_data
WHERE deposite='yes')AS AVG_BAL_SUBS,(SELECT AVG(balance) as avg_balance FROM bank_data
WHERE deposite='no') AS AVG_BAL_NONSUBS;
-- Average balance of subscribers are 1804.26 
-- Average balance of non subscribers are 1303.71

----------------------------------------------------------
-- CAMPAIGN ANALYSIS
----------------------------------------------------------

-- 15. Which contact method resulted in the highest subscriptions rate?
SELECT contact,
sum(case when deposite='yes' then 1 else 0 END) as subscribed_customers,
sum(case when deposite='yes' then 1 else 0 END)*100/COUNT(*) AS subscription_rate
FROM bank_data
GROUP BY contact 
ORDER BY subscription_rate DESC;
-- cellular has highest subscriptions rate with 14.91 %

-- 16. Which month generated the highest number of subscriptions ?
SELECT month,
sum(case when deposite='yes' then 1 else 0 end) AS subscribe_customers,
sum(case when deposite='yes' then 1 else 0 END)*100/COUNT(*) AS subscription_rate
FROM bank_data
GROUP BY month
ORDER BY subscribe_customers DESC;
-- in May Month month generated the highest number of subscriptions with 925 

-- 17. How does call duration affect subscriptions?
SELECT deposite,
count(*) total_customers,
AVG(duration) AS avg_talktime
FROM bank_data
GROUP BY deposite;
-- avg talktime of non subscribed customers are 221.18
-- avg talktime of subscribed customers are 537.29

-- 18. How many contacts (campaign) are usually required before customers subscribe?
SELECT campaign,
SUM(CASE WHEN 
			deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
SUM(CASE WHEN
			deposite ='yes' THEN 1 ELSE 0 END)*100/COUNT(*) AS subscription_rate
FROM bank_data
GROUP BY campaign
ORDER BY subscription_rate DESC ;
-- campaign 1,2,3 got most subscribed customers and subscription rate with
-- 1 campaign 2561 subscribers and 14.59% subscription rate
-- 2 campaign 1401 subscribers and 11.20% subscription rate
-- 3 campaign 618 subscribers and 11.19% subscription rate

-- 19. Compare subscriptions based on previous campaign outcome (success, failure, unknown, other).
SELECT
poutcome,
COUNT(*) AS total_customers,
SUM(CASE WHEN deposite = 'yes' THEN 1 ELSE 0 END) AS subscribed_customers,
ROUND
	(SUM(CASE
			WHEN deposite = 'yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),2) AS subscription_rate
FROM bank_data
GROUP BY poutcome
ORDER BY subscription_rate DESC;
-- as par the previous outcome the previous year success customers subscription rate is higher with 64.73 %

----------------------------------------------------------
-- CUSTOMER BEHAVIOR ANALYSIS
----------------------------------------------------------

-- 20. -- Which age group has the highest subscription rate?
SELECT
age_group,
COUNT(*) AS total_customers,
SUM(CASE WHEN deposite='yes' THEN 1 ELSE 0 END) AS subscribed_customers,
ROUND(
	SUM(CASE WHEN deposite='yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS subscription_rate
FROM bank_data
GROUP BY age_group
ORDER BY subscription_rate DESC;
-- 60 + age group subscription rate is higher with 42.26 %



-- 21. Compare the average account balance and subscription rate across different age groups.
SELECT
age_group,
ROUND(AVG(balance),2) AS avg_balance,
COUNT(*) AS total_customers,
SUM(CASE WHEN deposite='yes' THEN 1 ELSE 0 END) AS subscribed_customers,
ROUND(
	SUM(CASE WHEN deposite='yes' THEN 1 ELSE 0 END)*100.0/COUNT(*),2) AS subscription_rate
FROM bank_data
GROUP BY age_group
ORDER BY avg_balance DESC;
-- 60 + age group subscription rate is higher and avg balance is 2678.45
