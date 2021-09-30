/***********************************************
** File: Assignment2-PartB.sql
** Desc: Manipulating, Categorizing, Sorting and Grouping & Summarizing Data
** Author:
** Date:
************************************************/





######## QUESTION 1 ########

# a) Show the list of databases.
show databases; 
# b) Select sakila database.
USE sakila;
# c) Show all tables in the sakila database.
SHOW FULL TABLES;
# d) Show each of the columns along with their data types for the actor table.
show columns from actor;
# e) Show the total number of records in the actor table.
SELECT 
    COUNT(*)
FROM
    actor;
# f) What is the first name and last name of all the actors in the actor table ?
SELECT 
    first_name, last_name
FROM
    actor;
# g) Insert your first name and middle initial ( in the last name column ) into the actors table.
insert into actor (first_name, last_name)
values ("JIANGHONG", "JM");

# h) Update your middle initial with your last name in the actors table.
UPDATE actor 
SET 
    last_name = "MAN"
WHERE
    actor_id = 201;
# i) Delete the record from the actor table where the first name matches your first name.
# Assume that nobody in the database has the same first name as mine.
DELETE FROM actor 
where first_name = "JIANGHONG";
# j) Create a table payment_type with the following specifications and appropriate data types
CREATE TABLE payment_type (
    payment_type_id smallint,
    type varchar(45)
);

INSERT INTO payment_type VALUES (1,'Credit Card'),
(2,'Cash'),
(3,'Paypal'),
(4,'Cheque');
# k) Rename table payment_type to payment_types.
ALTER TABLE payment_type
RENAME TO payment_types;
# l) Drop the table payment_types.
DROP TABLE payment_types;

######## QUESTION 2 ########
# a) List all the movies ( title & description ) that are rated PG-13 ?
SELECT 
    title, description
FROM
    film
WHERE
    rating = 'PG-13';
# b) List all movies that are either PG OR PG-13 using IN operator ?
SELECT 
    title, description
FROM
    film
WHERE
    rating IN ('PG' , 'PG-13');
# c) Report all payments greater than and equal to 2$ and Less than equal to 7$ ?
# Note : write 2 separate queries conditional operator and BETWEEN keyword
# 1:
SELECT 
    *
FROM
    payment
WHERE
    amount >= 2 AND amount <= 7;
# 2:
SELECT 
    *
FROM
    payment
WHERE
    amount BETWEEN 2 AND 7;
# d) List all addresses that have phone number that contain digits 589, start with 140 or end with 589
# Note : write 3 different queries
# 1
SELECT 
    *
FROM
    address
WHERE
    phone LIKE '%589%';
# 2
SELECT 
    *
FROM
    address
WHERE
    phone LIKE '140%';
# 3
SELECT 
    *
FROM
    address
WHERE
    phone LIKE '%589';
# e) List all staff members ( first name, last name, email ) whose password is NULL ?
SELECT 
    first_name, last_name, email
FROM
    staff
WHERE
    password IS NOT NULL;
# f) Select all films that have title names like ZOO and rental duration greater than or equal to 4
SELECT 
    *
FROM
    film
WHERE
    title LIKE '%Zoo%'
        AND rental_duration >= 4;
# g) What is the cost of renting the movie ACADEMY DINOSAUR for 2 weeks ?
# Note : use of column alias
SELECT 
    (rental_duration * 7 * 2 * rental_rate) AS cost
FROM
    film
WHERE
    title = 'ACADEMY DINOSAUR';
# h) List all unique districts where the customers, staff, and stores are located
# Note : check for NOT NULL values ???
SELECT DISTINCT
    a.district
FROM
    address AS a,
    customer AS c,
    staff AS w,
    store AS s
WHERE
    a.address_id IN (c.address_id , w.address_id, s.address_id);
# i) List the top 10 newest customers across all stores ???
select store_id, customer_id, create_date
from customer
order by create_date desc;


######## QUESTION 3 ########
# a) Show total number of movies
SELECT 
    COUNT(film_id)
FROM
    film;
# b) What is the minimum payment received and max payment received across all transactions ?
SELECT 
    MIN(amount), MAX(amount)
FROM
    payment;
# c) Number of customers that rented movies between Feb-2005 & May-2005 ( based on paymentDate ).
# Assume that there might be one customer rented different movies during this priod of time. We only calculate the distinct number of customers.
# Also assume that "between Feb-2005 & May-2005" means including the months Feb-2005 and May-2005.
SELECT 
    COUNT(DISTINCT customer_id) AS num
FROM
    payment
WHERE
    payment_date LIKE '2005-02%'
        OR payment_date LIKE '2005-03%'
        OR payment_date LIKE '2005-04%'
        OR payment_date LIKE '2005-05%';
# d) List all movies where replacement_cost is greater than 15$ or rental_duration is between 6 & 10 days
SELECT 
    *
FROM
    film
WHERE
    replacement_cost > 15
        OR rental_duration BETWEEN 6 AND 10;
# e) What is the total amount spent by customers for movies in the year 2005?
SELECT 
    SUM(amount) AS total
FROM
    payment
WHERE
    payment_date LIKE '2005%';
# f) What is the average replacement cost across all movies ?
SELECT 
    AVG(replacement_cost) AS avg_cost
FROM
    film;
# g) What is the standard deviation of rental rate across all movies ?
SELECT 
    STD(rental_rate) AS std_rate
FROM
    film;
# h) What is the midrange of the rental duration for all movies? ???
SELECT 
    SUM(rental_duration) / COUNT(rental_duration) AS median
FROM
    (SELECT 
        rental_duration
    FROM
        film
    ORDER BY 1
    LIMIT 500 , 2) AS t;

######## QUESTION 4 ########
# a) Customers sorted by first Name and last name in ascending order.
SELECT 
    *
FROM
    customer
ORDER BY first_name , last_name ASC; 
# b) Count of movies that are either G/NC-17/PG-13/PG/R grouped by rating.
SELECT 
    rating, COUNT(film_id)
FROM
    film
WHERE
    rating IN ('G' , 'NC-17', 'PG-13', 'PG', 'R')
GROUP BY rating;
# c) Number of addresses in each district.
SELECT 
    district, COUNT(address_id)
FROM
    address
GROUP BY district;
# d) Find the movies where rental rate is greater than 1$ and order result set by descending order.
SELECT 
    film_id, rental_rate
FROM
    film
WHERE
    rental_rate > 1
ORDER BY rental_rate DESC;
# e) Top 2 movies that are rated R with the highest replacement cost ? ?????不全
select film_id, replacement_cost, rating
from film
where rating = "R"
order by replacement_cost
limit 2;
# f) Find the most frequently occurring (mode) rental rate across products.
select rental_rate as mode, count(rental_rate) as count
from film
group by rental_rate
order by count desc
limit 1;
# g) Find the top 2 movies with movie length greater than 50 mins and which has commentaries as a special features.
# ??? top 2 lenghth descending? duplicate 
select film_id, length, special_features
from film
where length > 50 and special_features = "commentaries"
order by length desc
limit 5;
# h) List the years which has more than 2 movies released. ??? 全都是2006出的
select release_year, count(distinct film_id)
from film
group by release_year;






























