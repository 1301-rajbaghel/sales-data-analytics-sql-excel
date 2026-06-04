-- Project Title: Sales Data Analytics Using SQL and Excel.
-- Student Name: Raj Pal
-- Course: BCA, 6 semester
-- Description: This SQL project analyzes e-commerce sales data
-- using aggregation, filtering, subqueries, and analytical queries.
create database sales_project;
Use sales_project;
DESCRIBE sales_data;
SELECT * FROM sales_data LIMIT 10;
-- Orders by Status
SELECT status,
       COUNT(*) AS total_orders,
       SUM(amount) AS revenue
FROM sales_data
GROUP BY status
ORDER BY total_orders DESC;
-- Top 10 Cities by Revenue
SELECT ship_city,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_city
ORDER BY total_revenue DESC
LIMIT 10;
-- Revenue by State
SELECT ship_state,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_state
ORDER BY total_revenue DESC;
-- Category wise sales
SELECT category,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY category
ORDER BY total_revenue DESC;
-- B2B vs B2C comparison
SELECT B2B,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY B2B;
-- Status-wise orders and revenue
SELECT status,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY status;
-- State-wise revenue analysis
SELECT ship_state,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_state
ORDER BY total_revenue DESC;
-- Category-wise revenue analysis
SELECT category,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY category
ORDER BY total_revenue DESC;
-- Overall dataset summary
SELECT COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue,
       AVG(amount) AS avg_order_value
FROM sales_data;
-- Order status performance
SELECT status,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY status
ORDER BY total_revenue DESC;
-- State-wise revenue ranking
SELECT ship_state,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_state
ORDER BY total_revenue DESC;
-- Category-wise revenue ranking
SELECT category,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY category
ORDER BY total_revenue DESC;
-- Monthly sales trend
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY month
ORDER BY month;
-- Top 5 states by total orders
SELECT ship_state,
       COUNT(*) AS total_orders
FROM sales_data
GROUP BY ship_state
ORDER BY total_orders DESC
LIMIT 5;
-- Average order value per state
SELECT ship_state,
       ROUND(AVG(amount),2) AS avg_order_value
FROM sales_data
GROUP BY ship_state
ORDER BY avg_order_value DESC;
-- most sold product categories (by quantity)
select category,
       sum(quantity) as total_quantity_sold
from sales_data
group by category
order by total_quantity_sold desc;
-- revenue contribution percentage by category
select category,
       sum(amount) as total_revenue,
       round(sum(amount)*100/(select sum(amount) from sales_data),2) as revenue_percentage
from sales_data
group by category
order by total_revenue desc;
-- revenue grouped into high, medium, low value orders
select
      case
          when amount>=1000 then 'High Value' 
          when amount between 500 and 999 then 'Medium Value'
          else'low value'
		end as order_type,
        count(*) as total_orders,
        sum(amount)as total_revenue
	from sales_data
    group by order_type;
    -- classify states based on total revenue performance
    select ship_state,
    sum(amount) as total_revenue,
    case
        when sum(amount)>5000000 then 'Top Performing'
        when sum(amount) between 2000000 and 5000000 then 'Average Performing'
        else'Low Performing'
	end as Performance_level
from sales_data
group by ship_state
order by total_revenue desc;
-- states generating more revenue than average state revenue
select ship_state,
	   sum(amount) as total_revenue
from sales_data
group by ship_state 
having sum(amount)>(
select avg(state_revenue)
from(
     select sum(amount) as state_revenue
     from sales_data
     group by ship_state
     )as state_avg
	);
    -- Show each category revenue and compare with total revenue
SELECT category,
       SUM(amount) AS category_revenue,
       (SELECT SUM(amount) FROM sales_data) AS total_revenue
FROM sales_data
GROUP BY category;
-- Optimized version using JOIN instead of correlated subquery
SELECT s1.*
FROM sales_data s1
JOIN (
    SELECT ship_state, AVG(amount) AS avg_amount
    FROM sales_data
    GROUP BY ship_state
) s2
ON s1.ship_state = s2.ship_state
WHERE s1.amount > s2.avg_amount;
-- Create index on ship_state
CREATE INDEX idx_state ON sales_data(ship_state);

-- Create index on amount
CREATE INDEX idx_amount ON sales_data(amount);
-- State-wise revenue summary
SELECT ship_state,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_state;
-- Category-wise revenue summary
SELECT category,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY category;
-- Status distribution
SELECT status,
       COUNT(*) AS total_orders,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY status;
-- category orders based on amount range
select order_id,
        amount,
        case
            when amount<500 then'Low Value'
            when amount between 500 and 1000 then 'Medium Value'
            else 'High Value'
            end as order_value_segment
		from sales_data;
        -- count orders by value segment
        select 
               case
                    when amount<500 then'Low value'
                    when amount between 500 and 1000 then'Medium Value'
                    else 'High Value'
			end as order_value_segment,
            count(*) as total_orders
		from sales_data
        group by order_value_segment;
        -- revenue contribution by value segment
        select
              case
                  when amount< 500 then 'Low Value'
                  when amount between 500 and 1000 then 'Medium Value'
                  else 'High Value'
				end as order_value_segement,
                sum(amount) as total_revenue
			from sales_data
            group by order_value_segement;
            -- monthly revenue trend
   -- top 5 state by revenue
   select ship_state,
          sum(amount) as total_revenue
	from sales_data
    group by ship_state
    order by total_revenue desc
    limit 5;
    -- bottom 5 states by revenue
    select ship_state,
           sum(amount) as total_revenue
		from sales_data
        group by ship_state
        order by total_revenue asc
        limit 5;
        -- states generating above average revenue
        select ship_state,
        sum(amount) as total_revenue
        from sales_data
        group by ship_state
        having sum(amount)>
        (select avg(state_revenue)
        from(
        select sum(amount) as state_revenue
        from sales_data
        group by ship_state
        ) as avg_table);
        -- total quantity sold by category
        select category,
        sum(quantity) as total_quantity
        from sales_data
        group by category
        order by total_quantity desc;
        -- average quantity per order
        select avg(quantity) as avg_quantity_per_order
        from sales_data;
        -- top 5 state by total quantity sold
        select ship_state,
        sum(quantity) as total_quantity
        from sales_data
        group by ship_state
        order by total_quantity desc
        limit 5;
        -- revenue by size
        select size,
        sum(amount) as total_revenue
        from sales_data
        group by size
        order by total_revenue desc;
-- most demanded size
select size,
count(*) as total_orders
from sales_data
group by size
order by total_orders desc;        
-- orders by courier status
select courier_status,
count(*) as total_orders
from sales_data
group by courier_status;
-- revenue lost due to cancelled courier order
select sum(amount) as cancelled_revenue_loss
from sales_data
where status= 'cancelled';
-- find states generating more revenue than the average state revenue
select ship_state,
       sum(amount) as total_revenue
from sales_data
group by ship_state
having sum(amount) >
        (
        select avg(state_revenue)
        from (
              select sum(amount) as state_revenue
              from sales_data
              group by ship_state
              ) as state_avg
		);
-- categories whose revenue is greater than average category revenue
select category,
	   sum(amount) as total_revenue
from sales_data
group by category
having sum(amount) >
       (
       select avg(category_revenue)
       from(
            select sum(amount) as category_revenue
            from sales_data
            group by category
		) as category_avg
 );
 -- find orders where order amount is higher  than average order amount
 select order_id,
        amount
from sales_data
where amount >
      (
      select avg(amount)
      from sales_data
	);
-- states having order count higher than average state order count
select ship_state,
       count(*) as total_orders
from sales_data
group by ship_state
having count(*) >
       (
       select avg(state_orders)
       from(
            select count(*) as state_orders
            from sales_data
            group by ship_state
            ) as avg_orders
	);
-- category generating the highest revenue
select category,
       sum(amount) as total_revenue
from sales_data
group by category
having sum(amount) =
  (
  select max(category_revenue)
  from(
       select sum(amount) as category_revenue
       from sales_data
       group by category
       ) as max_rev
	);
    -- orders that belong to top 3 revenue generating states
    select *
    from sales_data
    where ship_state IN
        (
        select ship_state
        from sales_data
        group by ship_state
        order by sum (amount) desc
        limit 3
	    );
        -- Revenue percentage contribution by category
SELECT category,
       SUM(amount) AS category_revenue,
       (SUM(amount) /
        (SELECT SUM(amount) FROM sales_data)) * 100 AS revenue_percentage
FROM sales_data
GROUP BY category
ORDER BY revenue_percentage DESC;
-- calculate total revenue lost due to cancelled orders
select sum(amount) as cancelled_revenue_loss
from sales_data
where status='cancelled';
-- find status with highest number of cancelled orders
select ship_state,
       count(*) as cancelled_orders
from sales_data
where status = 'cancelled'
group by ship_state
order by cancelled_orders desc;
-- categories with the most cancelled orders
select category,
       count(*) as cancelled_orders
from sales_data
where status = 'cancelled'
group by category
order by cancelled_orders desc;
use sales_project;
-- order with amount greater than 1000
select order_id
	   category,
       ship_state,
       amount
 from sales_data
 where amount > 1000
 order by amount desc;
 use sales_project;
 -- calculate average order value for each state
 select ship_state,
         avg(amount) as avg_order_value
from sales_data
group by ship_state
order by avg_order_value desc;
-- categories whose revenue is greater than overall average category revenue
select category,
       sum(amount) as total_revenue
from sales_data
group by category
having sum(amount) >
       (
       select avg(category_revenue)
       from(
            select sum(amount) as category_revenue
            from sales_data
            group by category
            ) as avg_rev
		);
-- Find the day with highest total revenue
SELECT order_date,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY order_date
ORDER BY total_revenue DESC
LIMIT 1;
-- compare revenue generated from B2B and B2C orders
select B2B,
       sum(amount) as total_revenue
from sales_data
group by B2B;
-- find states contributing more than 5 percent of total revenue
select ship_state,
       sum(amount) as total_revenue,
       (sum(amount) /
       (select sum(amount)  from sales_data))*100 as revenue_percentage
from sales_data
group by ship_state
having revenue_percentage > 5
order by revenue_percentage desc;
-- Analyze revenue generated by each category in every state
SELECT ship_state,
       category,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_state, category
ORDER BY ship_state, total_revenue DESC;
-- Calculate average order value for each product category
SELECT category,
       AVG(amount) AS avg_order_value
FROM sales_data
GROUP BY category
ORDER BY avg_order_value DESC;
-- Find states where customers buy higher quantities per order
SELECT ship_state,
       AVG(quantity) AS avg_quantity
FROM sales_data
GROUP BY ship_state
ORDER BY avg_quantity DESC;
-- Determine which categories sell the highest number of items
SELECT category,
       SUM(quantity) AS total_quantity_sold
FROM sales_data
GROUP BY category
ORDER BY total_quantity_sold DESC;
-- Identify category demand within the top 3 revenue generating states
SELECT ship_state,
       category,
       SUM(quantity) AS total_quantity
FROM sales_data
WHERE ship_state IN
      (
        SELECT ship_state
        FROM
        (
            SELECT ship_state
            FROM sales_data
            GROUP BY ship_state
            ORDER BY SUM(amount) DESC
            LIMIT 3
        ) AS top_states
      )
GROUP BY ship_state, category
ORDER BY ship_state, total_quantity DESC;
-- Classify orders into value segments
SELECT order_id,
       amount,
       CASE
           WHEN amount < 500 THEN 'Low Value'
           WHEN amount BETWEEN 500 AND 1000 THEN 'Medium Value'
           ELSE 'High Value'
       END AS order_value_segment
FROM sales_data;
-- Calculate revenue contribution by order value segment
SELECT
       CASE
           WHEN amount < 500 THEN 'Low Value'
           WHEN amount BETWEEN 500 AND 1000 THEN 'Medium Value'
           ELSE 'High Value'
       END AS order_segment,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY order_segment
ORDER BY total_revenue DESC;
-- Find category with the highest average quantity sold per order
SELECT category,
       AVG(quantity) AS avg_quantity
FROM sales_data
GROUP BY category
ORDER BY avg_quantity DESC
LIMIT 1;
-- count total orders based on fulfilment method
select fulfilment,
       count(order_id) as total_oorders
from sales_data
group by fulfilment;
-- Calculate total revenue generated by each fulfilment method
SELECT fulfilment,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY fulfilment
ORDER BY total_revenue DESC;
-- Count number of orders from each sales channel
SELECT sales_channel,
       COUNT(order_id) AS total_orders
FROM sales_data
GROUP BY sales_channel;
-- Calculate revenue generated from each sales channel
SELECT sales_channel,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY sales_channel
ORDER BY total_revenue DESC;
-- Count total orders by shipping service level
SELECT ship_service_level,
       COUNT(order_id) AS total_orders
FROM sales_data
GROUP BY ship_service_level;
-- Calculate revenue generated by shipping service level
SELECT ship_service_level,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_service_level
ORDER BY total_revenue DESC;
-- Count total orders placed from each city
SELECT ship_city,
       COUNT(order_id) AS total_orders
FROM sales_data
GROUP BY ship_city
ORDER BY total_orders DESC;
-- Calculate revenue generated from each city
SELECT ship_city,
       SUM(amount) AS total_revenue
FROM sales_data
GROUP BY ship_city
ORDER BY total_revenue DESC;
-- Find cities having more than 100 orders
SELECT ship_city,
       COUNT(order_id) AS total_orders
FROM sales_data
GROUP BY ship_city
HAVING COUNT(order_id) > 100
ORDER BY total_orders DESC;
-- Find states where order count is greater than 500
SELECT ship_state,
       COUNT(order_id) AS total_orders
FROM sales_data
GROUP BY ship_state
HAVING COUNT(order_id) > 500
ORDER BY total_orders DESC;
-- Count orders where amount is greater than 500
SELECT COUNT(order_id) AS orders_above_500
FROM sales_data
WHERE amount > 500;
-- Count orders where amount is less than 500
SELECT COUNT(order_id) AS orders_below_500
FROM sales_data
WHERE amount < 500;
-- Find orders where more than two items were purchased
SELECT order_id,
       quantity
FROM sales_data
WHERE quantity > 2;
-- Count orders where only one item was purchased
SELECT COUNT(order_id) AS single_item_orders
FROM sales_data
WHERE quantity = 1;
-- Find the highest order amount in the dataset
SELECT MAX(amount) AS highest_order_amount
FROM sales_data;
-- Find the lowest order amount in the dataset
SELECT MIN(amount) AS lowest_order_amount
FROM sales_data;
-- Find the maximum quantity ordered in a single order
SELECT MAX(quantity) AS max_quantity
FROM sales_data;
-- Find the minimum quantity ordered in a single order
SELECT MIN(quantity) AS min_quantity
FROM sales_data;
-- Count total unique cities where orders were placed
SELECT COUNT(DISTINCT ship_city) AS total_cities
FROM sales_data;
-- Count total unique states where orders were placed
SELECT COUNT(DISTINCT ship_state) AS total_states
FROM sales_data;
-- Count total number of orders placed from each postal code
SELECT 
       ship_postal_code,
       COUNT(order_id) AS total_orders
FROM 
       sales_data
GROUP BY 
       ship_postal_code
ORDER BY 
       total_orders DESC;
       -- Calculate total revenue generated from each postal code
SELECT 
       ship_postal_code,
       SUM(amount) AS total_revenue
FROM 
       sales_data
GROUP BY 
       ship_postal_code
ORDER BY 
       total_revenue DESC;
       -- Calculate average order value for each postal code
SELECT 
       ship_postal_code,
       AVG(amount) AS avg_order_value
FROM 
       sales_data
GROUP BY 
       ship_postal_code
ORDER BY 
       avg_order_value DESC;
       -- Calculate total quantity of items sold from each postal code
SELECT 
       ship_postal_code,
       SUM(quantity) AS total_quantity_sold
FROM 
       sales_data
GROUP BY 
       ship_postal_code
ORDER BY 
       total_quantity_sold DESC;
       -- Find postal codes where order count is greater than 50
SELECT 
       ship_postal_code,
       COUNT(order_id) AS total_orders
FROM 
       sales_data
GROUP BY 
       ship_postal_code
HAVING 
       COUNT(order_id) > 50
ORDER BY 
       total_orders DESC;
       -- Find postal codes where total revenue is greater than 100000
SELECT 
       ship_postal_code,
       SUM(amount) AS total_revenue
FROM 
       sales_data
GROUP BY 
       ship_postal_code
HAVING 
       SUM(amount) > 100000
ORDER BY 
       total_revenue DESC;
       -- Calculate revenue contribution percentage for each postal code
SELECT 
       ship_postal_code,
       SUM(amount) AS total_revenue,
       (
            SUM(amount) /
            (
                SELECT 
                       SUM(amount)
                FROM 
                       sales_data
            )
       ) * 100 AS revenue_percentage
FROM 
       sales_data
GROUP BY 
       ship_postal_code
ORDER BY 
       revenue_percentage DESC;
       -- Display both order count and revenue generated for each postal code
SELECT 
       ship_postal_code,
       COUNT(order_id) AS total_orders,
       SUM(amount) AS total_revenue,
       AVG(amount) AS average_order_value
FROM 
       sales_data
GROUP BY 
       ship_postal_code
ORDER BY 
       total_revenue DESC;
       -- Check how many records have NULL values in order_id column
SELECT 
       COUNT(*) AS null_order_id_count
FROM 
       sales_data
WHERE 
       order_id IS NULL;
       -- Check how many records have NULL values in amount column
SELECT 
       COUNT(*) AS null_amount_count
FROM 
       sales_data
WHERE 
       amount IS NULL;
       -- Check how many records have NULL values in quantity column
SELECT 
       COUNT(*) AS null_quantity_count
FROM 
       sales_data
WHERE 
       quantity IS NULL;
       -- Check how many records have NULL values in ship_city column
SELECT 
       COUNT(*) AS null_city_count
FROM 
       sales_data
WHERE 
       ship_city IS NULL;
-- Check how many records have NULL values in ship_state column
SELECT 
       COUNT(*) AS null_state_count
FROM 
       sales_data
WHERE 
       ship_state IS NULL;
       -- Check how many records have NULL values in ship_postal_code column
SELECT 
       COUNT(*) AS null_postal_code_count
FROM 
       sales_data
WHERE 
       ship_postal_code IS NULL;
       -- Identify records where order amount is negative
SELECT 
       order_id,
       amount
FROM 
       sales_data
WHERE 
       amount < 0;
       -- Find orders where quantity is equal to zero
SELECT 
       order_id,
       quantity
FROM 
       sales_data
WHERE 
       quantity = 0;
       -- Detect duplicate order IDs in the dataset
SELECT 
       order_id,
       COUNT(order_id) AS duplicate_count
FROM 
       sales_data
GROUP BY 
       order_id
HAVING 
       COUNT(order_id) > 1;
       -- Identify records where city or state information is missing
SELECT 
       order_id,
       ship_city,
       ship_state
FROM 
       sales_data
WHERE 
       ship_city IS NULL
       OR ship_state IS NULL;
       -- Analyze total revenue generated by each category within every state
SELECT
       ship_state,
       category,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_quantity_sold,
       SUM(amount) AS total_revenue,
       AVG(amount) AS average_order_value
FROM
       sales_data
GROUP BY
       ship_state,
       category
ORDER BY
       ship_state,
       total_revenue DESC;
       -- Count number of orders for each category in every city
SELECT
       ship_city,
       category,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_quantity_sold
FROM
       sales_data
GROUP BY
       ship_city,
       category
ORDER BY
       ship_city,
       total_orders DESC;
       -- Calculate revenue contribution of each category in every city
SELECT
       ship_city,
       category,
       SUM(amount) AS total_revenue,
       AVG(amount) AS average_order_value
FROM
       sales_data
GROUP BY
       ship_city,
       category
ORDER BY
       ship_city,
       total_revenue DESC;
       -- Identify categories generating highest revenue within each state
SELECT
       ship_state,
       category,
       SUM(amount) AS total_revenue
FROM
       sales_data
GROUP BY
       ship_state,
       category
ORDER BY
       total_revenue DESC;
       -- Analyze quantity of items sold in each state
SELECT
       ship_state,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_quantity,
       AVG(quantity) AS avg_quantity_per_order
FROM
       sales_data
GROUP BY
       ship_state
ORDER BY
       total_quantity DESC;
       -- Determine how many items were sold for each category
SELECT
       category,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_items_sold,
       AVG(quantity) AS average_quantity_per_order
FROM
       sales_data
GROUP BY
       category
ORDER BY
       total_items_sold DESC;
       -- Analyze revenue generated for each order status
SELECT
       status,
       COUNT(order_id) AS total_orders,
       SUM(amount) AS total_revenue,
       AVG(amount) AS average_order_value
FROM
       sales_data
GROUP BY
       status
ORDER BY
       total_revenue DESC;
       -- Evaluate category performance based on order status
SELECT
       category,
       status,
       COUNT(order_id) AS total_orders,
       SUM(amount) AS total_revenue
FROM
       sales_data
GROUP BY
       category,
       status
ORDER BY
       category,
       total_revenue DESC;
       -- Find the top 10 cities generating the highest revenue
SELECT
       ship_city,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_quantity_sold,
       SUM(amount) AS total_revenue,
       AVG(amount) AS average_order_value
FROM
       sales_data
GROUP BY
       ship_city
ORDER BY
       total_revenue DESC
LIMIT
       10;
       -- Find the top 10 postal codes with the highest number of orders
SELECT
       ship_postal_code,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_quantity_sold,
       SUM(amount) AS total_revenue
FROM
       sales_data
GROUP BY
       ship_postal_code
ORDER BY
       total_orders DESC
LIMIT
       10;
       -- Identify orders where amount is greater than the average order amount
SELECT
       order_id,
       ship_state,
       category,
       quantity,
       amount
FROM
       sales_data
WHERE
       amount >
       (
           SELECT
                  AVG(amount)
           FROM
                  sales_data
       )
ORDER BY
       amount DESC;
       -- Identify orders where quantity purchased is greater than the average quantity
SELECT
       order_id,
       ship_city,
       category,
       quantity
FROM
       sales_data
WHERE
       quantity >
       (
           SELECT
                  AVG(quantity)
           FROM
                  sales_data
       )
ORDER BY
       quantity DESC;
       -- Classify orders into low, medium, and high value segments
SELECT
       order_id,
       category,
       ship_state,
       quantity,
       amount,
       CASE
            WHEN amount < 500 THEN 'Low Value Order'
            WHEN amount BETWEEN 500 AND 1000 THEN 'Medium Value Order'
            ELSE 'High Value Order'
       END AS order_value_segment
FROM
       sales_data
ORDER BY
       amount DESC;
       -- Calculate revenue contribution percentage for each category
SELECT
       category,
       SUM(amount) AS category_revenue,
       (
            SUM(amount) /
            (
                SELECT
                       SUM(amount)
                FROM
                       sales_data
            )
       ) * 100 AS revenue_percentage
FROM
       sales_data
GROUP BY
       category
ORDER BY
       revenue_percentage DESC;
       -- Identify high value orders greater than 1000 grouped by state
SELECT
       ship_state,
       COUNT(order_id) AS total_high_value_orders,
       SUM(amount) AS total_revenue
FROM
       sales_data
WHERE
       amount > 1000
GROUP BY
       ship_state 
ORDER BY
       total_revenue DESC; 
       -- Rank categories based on total quantity sold
SELECT
       category,
       COUNT(order_id) AS total_orders,
       SUM(quantity) AS total_quantity_sold,
       SUM(amount) AS total_revenue
FROM
       sales_data
GROUP BY
       category
ORDER BY
       total_quantity_sold DESC;
       -- final summary of the dataset
select
      count(order_id) as total_orders,
      sum(quantity) as totl_items_sold,
      sum(amount) as total_revenue,
      avg(amount) as average_order_value
from
     sales_data;
     -- verify that important columns do not contain NULL values
select
      count(*) as missing_values_check
from
     sales_data
where
     order_id IS NULL
     OR amount IS NULL
     OR quantity IS NULL;
     -- =====================================================
-- Project Conclusion
-- =====================================================
-- This SQL project analyzed an e-commerce sales dataset
-- using various SQL techniques such as filtering,
-- aggregation, grouping, subqueries, and conditional logic.
-- Key insights extracted from the dataset include:
-- 1. State-wise and city-wise sales performance
-- 2. Category-wise revenue contribution
-- 3. Order value segmentation
-- 4. Demand patterns based on quantity sold
-- The analysis helps understand business performance
-- and supports data-driven decision making.
-- =====================================================
use sales_project;
select amount as fufa_ji_asked_question 
from sales_data
where amount >=  '531';


select   sales_channel as reference
from sales_data
where sales_channel!= 'amazon.in';

select * 
from sales_data
where ship_city='delhi'
and amount<'499'
and sales_channel='amazon.in';


select *
from sales_data
where amount='500';


select order_id as total_orders
from sales_data
group by  order_id; 

select ship_city ,count(order_id),min(amount),max(amount),count(sales_channel)
from sales_data
group by ship_city;

select *
from sales_data 
order by amount desc
limit 5;
