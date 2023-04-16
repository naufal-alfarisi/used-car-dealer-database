SELECT 
	p.product_id,
	t.brand,
	t.model,
	p.year,
	p.price
FROM 
	car_product p
JOIN 
	car_type t USING (car_id)
WHERE 
	p.year >= 2015
ORDER BY 
	p.year ASC;

SELECT * FROM bid;

SELECT
    p.product_id,
    t.brand,
    t.model,
    p.year,
    p.price,
    p.date_posted
FROM
    car_product p
JOIN
    car_type t USING (car_id)
JOIN
    user_info u ON p.seller_id = u.user_id
WHERE
    (u.first_name || ' ' || u.last_name) LIKE '%Arta Thamrin%';

SELECT 
	p.product_id,
	t.brand,
	t.model,
	p.year,
	p.price
FROM 
	car_product p
JOIN 
	car_type t USING (car_id)
WHERE 
	t.model LIKE '%Yaris%';

WITH city2 AS (SELECT*FROM city)

SELECT p.product_id, t.model, p.year, p.price, 
sqrt(power(c1.latitude - c2.latitude, 2) + power(c1.longitude - c2.longitude, 2)) AS distance 
FROM city c1 
CROSS JOIN city2 c2
JOIN user_info u ON u.city = c1.city_id
JOIN car_product p ON p.seller_id = u.user_id
JOIN car_type t USING (car_id)
WHERE c1.city_id = 3173
ORDER BY distance ASC;
	

