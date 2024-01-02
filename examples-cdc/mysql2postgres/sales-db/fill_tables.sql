-- Set params
SET @number_of_sales = '100';
SET @number_of_users = '100';
SET @number_of_products = '100';
SET @number_of_stores = '100';
SET @number_of_countries = '100';
SET @number_of_cities = '30';
SET @status_names = '5';
SET @start_date = '2023-01-01 00:00:00';
SET @end_date = '2023-02-01 00:00:00';

USE source;

TRUNCATE TABLE city ;
TRUNCATE TABLE product ;
TRUNCATE TABLE country ;
TRUNCATE TABLE status_name;
TRUNCATE TABLE users;
TRUNCATE TABLE order_status;
TRUNCATE TABLE sale;
TRUNCATE TABLE store;


-- Filling of products
INSERT INTO product
WITH RECURSIVE t(id) AS (
    SELECT 1
    UNION ALL
    SELECT id + 1
    FROM t
    WHERE id + 1 <= @number_of_products
)
SELECT id, CONCAT_WS(' ','Product', id)
FROM t;


-- Filling of countries
INSERT INTO country
WITH RECURSIVE t(id) AS (
    SELECT 1
    UNION ALL
    SELECT id + 1
    FROM t
    WHERE id + 1 <= @number_of_countries
)
SELECT id, CONCAT('Country ', id)
FROM t;



-- Filling of cities
INSERT INTO city
WITH RECURSIVE t(id) AS (
    SELECT 1
    UNION ALL
    SELECT id + 1
    FROM t
    WHERE id + 1 <= @number_of_cities
)
SELECT id
    , CONCAT('City ', id)
    , FLOOR(RAND() * (@number_of_countries + 1))
FROM t;


-- Filling of stores
INSERT INTO store
WITH RECURSIVE t(id) AS (
    SELECT 1
    UNION ALL
    SELECT id + 1
    FROM t
    WHERE id + 1 <= @number_of_stores
)
SELECT id
    , CONCAT('Store ', id)
    , FLOOR(RAND() * (@number_of_cities + 1))
FROM t;

-- Filling of users
INSERT INTO users
WITH RECURSIVE t(id) AS (
    SELECT 1
    UNION ALL
    SELECT id + 1
    FROM t
    WHERE id + 1 <= @number_of_users
)
SELECT id
    , CONCAT('User ', id)
FROM t;

-- Filling of status_names
INSERT INTO status_name
WITH RECURSIVE t(status_name_id) AS (
    SELECT 1
    UNION ALL
    SELECT status_name_id + 1
    FROM t
    WHERE status_name_id + 1 <= @status_names
)
SELECT status_name_id
    , CONCAT('Status Name ', status_name_id)
FROM t;

-- Filling of sales  
INSERT INTO sale
WITH RECURSIVE t(sale_id) AS (
    SELECT 1
    UNION ALL
    SELECT sale_id + 1
    FROM t
    WHERE sale_id + 1 <= @number_of_sales
)
SELECT UUID() AS sale_id
    , ROUND(RAND() * 10, 3) AS amount
    , DATE_ADD(@start_date, INTERVAL RAND() * 5 DAY) AS date_sale
    , FLOOR(RAND() * (@number_of_products + 1)) AS product_id
    , FLOOR(RAND() * (@number_of_users + 1)) AS user_id
    , FLOOR(RAND() * (@number_of_stores + 1)) AS store_id
FROM  t;

-- Filling of order_status
INSERT INTO order_status
WITH RECURSIVE t(order_status_id) AS (
    SELECT 1
    UNION ALL
    SELECT order_status_id + 1
    FROM t
    WHERE order_status_id + 1 <= @number_of_sales
)
SELECT UUID() AS order_status_id
    , DATE_ADD(@start_date, INTERVAL RAND() * 5 DAY) AS update_at
    , FLOOR(RAND() * (@number_of_sales + 1)) AS sale_id
    , FLOOR(RAND() * (@status_names + 1)) AS status_name_id
FROM t;
