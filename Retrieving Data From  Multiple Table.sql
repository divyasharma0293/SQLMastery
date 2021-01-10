/* retrieve order_id, name of product, quantity and unit price*/
use mosh_sql_store;
SELECT 
    oi.order_id, p.name, oi.quantity, oi.unit_price
FROM
    order_items oi
        JOIN
    products p ON p.product_id = oi.product_id;


/******************************************/
/*       SELF JOINS                       */
/******************************************/
use mosh_sql_hr;
SELECT 
    e1.employee_id,
    e1.first_name,
    e1.last_name,
    COALESCE(CONCAT(e2.first_name, ' ', e2.last_name),
            'Top Manager') AS Manager
FROM
    employees e1
        LEFT JOIN
    employees e2 ON e2.employee_id = e1.reports_to;
    
    
/* Using Multiple Tables retrieve order ID, order date, Name of customer and the status of the order*/
USE mosh_sql_store;
SELECT 
    o.order_id, o.order_date, c.first_name, c.last_name, os.name
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
        JOIN
    order_statuses os ON os.order_status_id = o.status;
    
    
/*payment and customer details*/
USE mosh_sql_invoicing;
SELECT 
    c.client_id, c.name, p.date, p.amount, pm.name
FROM
    payments p
        JOIN
    payment_methods pm ON pm.payment_method_id = p.payment_method
        LEFT JOIN
    clients c ON p.client_id = c.client_id
ORDER BY amount DESC;


/******************************************/
/*       Implicit Join                    */
/******************************************/
SELECT 
    c.client_id, c.name, p.date, p.amount, pm.name
FROM
    payments p,
    clients c,
    payment_methods pm
WHERE
    c.client_id = p.client_id
        AND pm.payment_method_id = p.payment_method;


/******************************************/
/*       Outer Joins                      */
/******************************************/
USE mosh_sql_store;
SELECT 
    c.customer_id, c.first_name, c.last_name, o.order_id
FROM
    customers c
        LEFT JOIN
    orders o ON c.customer_id = o.customer_id
ORDER BY 1;

/*products and how many time it has been ordered*/
SELECT 
    p.name, oi.quantity
FROM
    products p
        LEFT JOIN
    order_items oi ON p.product_id = oi.product_id;


/* product which has never been ordered */
SELECT 
    p.name, oi.quantity
FROM
    products p
        LEFT JOIN
    order_items oi ON p.product_id = oi.product_id
WHERE
    quantity IS NULL;


/* order, customer name, name of the shipper and status if processed or shipped */
SELECT 
    o.order_date,
    o.order_id,
    c.first_name,
    c.last_name,
    s.name,
    os.name
FROM
    orders o
        JOIN
    customers c ON o.customer_id = c.customer_id
        LEFT JOIN
    shippers s ON s.shipper_id = o.shipper_id
        LEFT JOIN
    order_statuses os ON os.order_status_id = o.status;


/******************************************/
/*       USING                            */
/*Using caluse is used to match only one column when
  more than one column matches */
/******************************************/
SELECT 
    *
FROM
    order_items oi
        JOIN
    order_item_notes oin USING (product_id);


/*client and payment methods */
USE mosh_sql_invoicing;
SELECT 
    p.date, c.name, p.amount, pm.name
FROM
    payments p
        JOIN
    clients c USING (client_id)
        JOIN
    payment_methods pm ON pm.payment_method_id = p.payment_method;


/******************************************************************/
/*       Natural Joins                                            */
/* it allows sql engine to pick up the keys by itself for joining */
/******************************************************************/
USE mosh_sql_store;
SELECT 
    o.order_id, c.first_name
FROM
    orders o
        NATURAL JOIN
    customers c;

/******************************************************************/
/*                 CROSS JOIN                                     */
/* In cross join, each row from 1st table joins all the rows from the 2nd table */                                           
/******************************************************************/
/* cross join between shippers and products using implicit and explict*/
SELECT 
    s.name, p.name
FROM
    shippers s
        CROSS JOIN
    products p;

/******************************************************************/
/*       UNION                                                    */
/*The UNION operator is used to combine the result-set of two or more SELECT statements.

Each SELECT statement within UNION must have the same number of columns
The columns must also have similar data types
The columns in each SELECT statement must also be in the same order*/
/******************************************************************/
SELECT 
    *, 'Active' AS status
FROM
    orders
WHERE
    order_date >= CURDATE() - INTERVAL 2 YEAR 
UNION SELECT 
    *, 'Archieved' AS status
FROM
    orders
WHERE
    order_date < CURDATE() - INTERVAL 2 YEAR;
    
/******************************************************************/
/*                     CASE WHEN                                 */
/*****************************************************************/    
/* customer and point status */
SELECT 
    customer_id,
    first_name,
    points,
    CASE
        WHEN points > 3000 THEN 'Gold'
        WHEN points > 2000 AND points <= 3000 THEN 'Silver'
        ELSE 'Bronze'
    END AS type
FROM
    customers
ORDER BY 2; 
