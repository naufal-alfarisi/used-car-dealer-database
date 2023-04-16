# SQL Project: Car Dealer Database
Designing a database of a used car dealer using PostgreSQL and Python

# Description
This repository contain python script for creating dummy data mostly using faker library as well as the exported csv files and some sql files for querying the data

# About the data
Here is the case, I need to create a relational database for a used car dealer. This database has to have user information both the seller and buyer, the car details, the city they are in, and the bid offered by the buyer.

In that case, there are several rules as listed below:
1. For every car, there has to be a seller with detailed info in the user table but they may sell or buy multiple cars.
2. There are several pieces of information that the seller has to put on a car, which is the brand, model, type, transmission, and year. Other info like mileage or color is optional.
3. If a buyer wants to buy the car they may send a bid for that car.

# ERD
The realation between tables is as shown in the image below

![ERD Car Dealer](https://user-images.githubusercontent.com/128882248/232313384-89a304d9-837b-476b-87f6-6a37fa7fbbf0.png)
