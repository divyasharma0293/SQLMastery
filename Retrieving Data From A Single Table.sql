/*retrieve all data from customers */
SELECT 
    *
FROM
    customers
WHERE
    customer_id > 5
ORDER BY first_name;


/*return all the products name, unit price, new price (unit price *1.1) */
SELECT 
    name, unit_price, unit_price * 1.1 AS new_price
FROM
    products;


/*get the orders placed this year*/
SELECT 
    *
FROM
    orders
WHERE
    YEAR(order_date) = 2020;


/*
get items of order #6 where total price is greater than 30 
*/
SELECT 
    order_id,
    product_id,
    quantity,
    unit_price,
    quantity * unit_price AS total_price
FROM
    order_items
WHERE
    order_id = 6
        AND quantity * unit_price > 30;


/*return products with quanity in stock equal to 49, 38, 72*/
SELECT 
    *
FROM
    products
WHERE
    quantity_in_stock IN (49 , 38, 72);
    

/*return customers born between 1/1/1990 and 1/1/2000*/
SELECT 
    *
FROM
    customers
WHERE
    YEAR(birth_date) BETWEEN 1990 AND 2000;
    

/*get the orders that are not shipped*/
SELECT 
    *
FROM
    orders
WHERE
    shipped_date IS NULL;
    

/* offset start from 2nd record */
SELECT 
    *
FROM
    order_items
LIMIT 5 OFFSET 2;


-- customer 5 records start from 6 for pagniation (example 1-5 for one page, 6-10 for second page...)
SELECT 
    *
FROM
    customers
LIMIT 5 , 6;


/*get top 3 loyal customers*/
SELECT 
    *
FROM
    customers
ORDER BY points DESC
LIMIT 3;


/*get customers addresses contain TRAIL or AVENUE OR phone numbers end with 9*/
SELECT 
    *
FROM
    customers
WHERE
    address LIKE '%Trail%'
        OR address LIKE '%AVENUE%'
        OR phone LIKE '%9';
        
/* or using REGEXP*/
SELECT 
    *
FROM
    customers
WHERE
    address REGEXP 'Trail|Avenue';

SELECT 
    *
FROM
    customers
WHERE
    phone REGEXP '9$';

SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP 'field';

SELECT 
    *
FROM
    customers
WHERE
    first_name REGEXP 'I...';

SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP 'field|rose|mac';

SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP '^field|mac|rose';
    

/*
ge
ie
me
includes in last name
*/
SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP '[gim]e';
    

/*
ae
be
...
he
includes in last name
*/
SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP '[a-h]e';
    

/*
Get the customers whose
- first names are ELKA or AMBUR
- last names end with EY or ON
- last name start with MY or contain SE
- last name contain B followed by R or U
*/
SELECT 
    *
FROM
    customers
WHERE
    first_name REGEXP 'Elka|Ambur';

SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP 'ey$|on$';

SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP '^my|se';

SELECT 
    *
FROM
    customers
WHERE
    last_name REGEXP 'b[r|u]';
