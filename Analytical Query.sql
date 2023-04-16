SELECT 
	t.model,
	COUNT (DISTINCT p.product_id) AS count_product,
	COUNT (b.bid_id) AS count_bid
FROM
	car_product p
JOIN
	car_type t USING (car_id)
JOIN
	bid b USING (product_id)
GROUP BY 
	t.model
ORDER BY 
	count_product DESC;

	CREATE TEMPORARY TABLE avg_city_price AS
	SELECT c.city_name AS city_name, AVG (p.price) AS avg_price
	FROM car_product p
	JOIN user_info u ON u.user_id = p.seller_id
	JOIN city c ON u.city = c.city_id
	GROUP BY c.city_name;


SELECT
	c.city_name,
	t.brand,
	t.model,
	p.year,
	p.price,
	a.avg_price AS avg_city_price
FROM
	car_product p
JOIN
	car_type t USING (car_id)
JOIN 
	user_info u ON u.user_id = p.seller_id
JOIN 
	city c ON u.city = c.city_id
JOIN
	avg_city_price a USING (city_name)
ORDER BY
	c.city_name;
	
SELECT 
	p.product_id,
	b.bid_id,
	t.brand,
	b.buyer_id,
	b.date,
	b.price
FROM
	car_product p
JOIN
	car_type t USING (car_id)
JOIN
	bid b USING (product_id)
ORDER BY p.product_id, b.bid_id;

/*
WITH bid2 AS (
SELECT * FROM bid)

SELECT 
	t.model,
	b1.buyer_id,
	b1.date AS date_first_bid,
	b2.date AS date_second_bid,
	b1.price AS price_first_bid,
	b2.price AS price_second_bid
FROM bid b1
JOIN bid2 b2 USING (product_id)
JOIN car_product p USING (product_id)
JOIN car_type t USING (car_id)
WHERE b1.date < b2.date
ORDER BY product_id;
*/

SELECT *,
ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY date) AS bid_num
FROM bid;

WITH bid_rank AS (
SELECT *,
ROW_NUMBER() OVER (PARTITION BY b.product_id ORDER BY b.date) AS bid_num
FROM bid b
)
SELECT 
    t.model,
    b1.buyer_id,
    b1.date AS date_first_bid,
    b2.date AS date_second_bid,
    b1.price AS price_first_bid,
    b2.price AS price_second_bid
FROM bid_rank b1
JOIN bid_rank b2 ON b1.product_id = b2.product_id AND b1.bid_num = 1 AND b2.bid_num = 2
JOIN car_product p ON b1.product_id = p.product_id
JOIN car_type t ON p.car_id = t.car_id
WHERE b1.date < b2.date
ORDER BY b1.product_id;

WITH avg_bid1 AS (
SELECT AVG (b.price) AS avg_bid, t.model AS model
FROM bid b
JOIN car_product p USING (product_id)
JOIN car_type t USING (car_id)
WHERE b.date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY t.model
)
SELECT 
t.model, 
ROUND (AVG (p.price)) AS avg_price,
ROUND (a.avg_bid) AS avg_bid_6mo,
ROUND (AVG (p.price) - a.avg_bid) AS difference,
((AVG (p.price) - a.avg_bid)/AVG (p.price))*100 AS difference_percentage
FROM car_product p JOIN car_type t USING (car_id)
JOIN avg_bid1 a USING (model)
GROUP BY t.model, a.avg_bid
ORDER BY model;

SELECT
  t.brand,
  t.model,
  AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '1 month' THEN b.price END) AS avg_1mo,
  AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '2 month' THEN b.price END) AS avg_2mo,
  AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '3 month' THEN b.price END) AS avg_3mo,
  AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '4 month' THEN b.price END) AS avg_4mo,
  AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '5 month' THEN b.price END) AS avg_5mo,
  AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '6 month' THEN b.price END) AS avg_6mo
FROM bid b
JOIN car_product p USING (product_id)
JOIN car_type t USING (car_id)
GROUP BY t.brand, t.model;

CREATE FUNCTION avg_prices_6mo(brand_name VARCHAR, model_name VARCHAR)
RETURNS TABLE (brand VARCHAR, model VARCHAR, avg_1mo NUMERIC, avg_2mo NUMERIC, avg_3mo NUMERIC, avg_4mo NUMERIC, avg_5mo NUMERIC, avg_6mo NUMERIC)
LANGUAGE plpgsql
AS $$
BEGIN
  RETURN QUERY
  SELECT
    t.brand,
    t.model,
    AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '1 month' THEN b.price END) AS avg_1mo,
    AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '2 month' THEN b.price END) AS avg_2mo,
    AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '3 month' THEN b.price END) AS avg_3mo,
    AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '4 month' THEN b.price END) AS avg_4mo,
    AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '5 month' THEN b.price END) AS avg_5mo,
    AVG(CASE WHEN b.date >= CURRENT_DATE - INTERVAL '6 month' THEN b.price END) AS avg_6mo
  FROM bid b
  JOIN car_product p USING (product_id)
  JOIN car_type t USING (car_id)
  WHERE t.brand = brand_name AND t.model = model_name
  GROUP BY t.brand, t.model;
END;
$$;

SELECT * FROM avg_prices_6mo('Suzuki', 'Ertiga');