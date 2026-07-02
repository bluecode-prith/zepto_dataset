-- =====================================================
-- ZEPTO PRODUCT ANALYSIS USING POSTGRESQL
-- =====================================================

DROP TABLE IF EXISTS zepto;

CREATE TABLE zepto (
    sku_id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(150) NOT NULL,
    mrp NUMERIC(8,2),
    discountPercent NUMERIC(5,2),
    availableQuantity INTEGER,
    discountedSellingPrice NUMERIC(8,2),
    weightInGms INTEGER,
    outOfStock BOOLEAN,
    quantity INTEGER
);

-- Q1. Top 10 Best Value Products Based on Discount Percentage
SELECT name, category, mrp, discountPercent
FROM zepto
ORDER BY discountPercent DESC
LIMIT 10;

-- Q2. Top 10 Premium Products Currently Out of Stock
SELECT name, category, mrp
FROM zepto
WHERE outOfStock = TRUE
ORDER BY mrp DESC
LIMIT 10;

-- Q3. Estimated Revenue by Category
SELECT category,
       SUM(discountedSellingPrice * availableQuantity) AS estimated_revenue
FROM zepto
GROUP BY category
ORDER BY estimated_revenue DESC;

-- Q4. Top 10 Most Expensive Products
SELECT name, category, mrp
FROM zepto
ORDER BY mrp DESC
LIMIT 10;

-- Q5. Top 10 Highest Inventory Value Products
SELECT name,
       category,
       availableQuantity,
       discountedSellingPrice,
       (availableQuantity * discountedSellingPrice) AS inventory_value
FROM zepto
ORDER BY inventory_value DESC
LIMIT 10;

-- Q6. Top 10 Products with Highest Customer Savings
SELECT name,
       category,
       mrp,
       discountedSellingPrice,
       ROUND(mrp - discountedSellingPrice, 2) AS savings
FROM zepto
ORDER BY savings DESC
LIMIT 10;

-- Q7. Top 10 Products with Highest Available Stock
SELECT name,
       category,
       availableQuantity
FROM zepto
ORDER BY availableQuantity DESC
LIMIT 10;

-- Q8. Top 10 Categories with Highest Average Discount
SELECT category,
       ROUND(AVG(discountPercent), 2) AS average_discount
FROM zepto
GROUP BY category
ORDER BY average_discount DESC
LIMIT 10;

-- Q9. Top 10 Best Value Products (Lowest Price per Gram)
SELECT name,
       category,
       weightInGms,
       discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS price_per_gram
FROM zepto
WHERE weightInGms > 0
ORDER BY price_per_gram ASC
LIMIT 10;

-- Q10. Top 10 Categories with Maximum Out-of-Stock Products
SELECT category,
       COUNT(*) AS out_of_stock_products
FROM zepto
WHERE outOfStock = TRUE
GROUP BY category
ORDER BY out_of_stock_products DESC
LIMIT 10;
