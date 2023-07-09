-- Número total de clientes
SELECT COUNT(DISTINCT customer_id) AS total_customers
FROM olist_customers_dataset;

-- Número total de pedidos realizados
SELECT COUNT(DISTINCT order_id) AS total_orders
FROM olist_orders_dataset;

-- Distribución de los estados de los clientes
SELECT customer_state, COUNT(*) AS total_customers
FROM olist_customers_dataset
GROUP BY customer_state;

-- Número de pedidos por estado del cliente
SELECT c.customer_state, COUNT(*) AS total_orders
FROM olist_orders_dataset o
JOIN olist_customers_dataset c ON o.customer_id = c.customer_id
GROUP BY c.customer_state;

-- Número de pedidos por estado de entrega
SELECT o.order_status, COUNT(*) AS total_orders
FROM olist_orders_dataset o
GROUP BY o.order_status;

-- Valor total de pagos procesados por tipo de pago
SELECT payment_type, SUM(payment_value) AS total_payment_value
FROM olist_order_payments_dataset
GROUP BY payment_type;

-- Cantidad de productos por categoría
SELECT pc.product_category_name_english AS category, COUNT(*) AS total_products
FROM olist_products_dataset p
JOIN product_category_name_translation pc ON p.product_category_name = pc.product_category_name
GROUP BY pc.product_category_name_english
ORDER BY total_products DESC;

-- Número de reseñas por puntuación
SELECT review_score, COUNT(*) AS total_reviews
FROM olist_order_reviews_dataset
GROUP BY review_score;

-- Promedio de tiempo de entrega de pedidos
SELECT AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS average_delivery_time
FROM olist_orders_dataset;

--10 clientes principales en la categoría "bed_bath_table"
SELECT c.customer_id, c.customer_unique_id, c.customer_city, c.customer_state, COUNT(DISTINCT o.order_id) AS total_orders, SUM(oi.price) AS total_amount
FROM olist_customers_dataset c
JOIN olist_orders_dataset o ON c.customer_id = o.customer_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pc ON p.product_category_name = pc.product_category_name
WHERE pc.product_category_name_english = 'bed_bath_table'
GROUP BY c.customer_id, c.customer_unique_id, c.customer_city, c.customer_state
ORDER BY total_amount DESC
LIMIT 10;

--Obtener las reseñas de los productos en la categoría
SELECT r.review_score, r.review_comment_title, r.review_comment_message
FROM olist_order_reviews_dataset r
JOIN olist_orders_dataset o ON r.order_id = o.order_id
JOIN olist_order_items_dataset oi ON o.order_id = oi.order_id
JOIN olist_products_dataset p ON oi.product_id = p.product_id
JOIN product_category_name_translation pc ON p.product_category_name = pc.product_category_name
WHERE pc.product_category_name_english = 'bed_bath_table';
