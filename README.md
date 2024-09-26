# Music_Store_Analysis
Analysis of a Music Store data 
The Owner of the Music store wants to know some details
The Problem Statements Which are working on this module are as follows with steps:
1) Which countriy have the max employees based on their job title?

![Screenshot 2024-09-26 143000](https://github.com/user-attachments/assets/3dab8556-d405-4c7b-a279-8598a875ef42)
2) (a) who is the senior most employee based on job title?

![Screenshot 2024-09-26 143513](https://github.com/user-attachments/assets/2cfdacf5-852d-4ae4-bcc7-cafd7cc2d748)

   (b) which country has the most invoices?
   
![Screenshot 2024-09-26 143605](https://github.com/user-attachments/assets/c06fff53-b41b-4ef8-b385-74bf78287027)

3) From which city we have done the highest business? We would like to throw a promotional Music Festival in the city where we made the most money.
   -- A query that returns one city that has the highest sum of invoice totals will give the answer.
   
![Screenshot 2024-09-26 144110](https://github.com/user-attachments/assets/192ca2da-0ba5-426a-b3de-148714acac85)

The Music Festival should be organized in Prague because the city has generated the highest total invoice

4) Who is Our most valuable customer from which country he belongs? The customer who spent the max amount will be "the most valuable customer".

![Screenshot 2024-09-26 144826](https://github.com/user-attachments/assets/79c47f46-1832-43a9-a247-5a817d9ea2c9)
5) Find Email, name & Genre of all the audience who listens to rock music(Sort Email Alphabetically).

![Screenshot 2024-09-26 145038](https://github.com/user-attachments/assets/77f9b36b-f1ee-45e5-8991-83a617e984c0)
There are total 58 customers who enjoy Rock music
6) Find Top 10 rock band (Artist) who have written the majority of the songs and the number of tracks.

![Screenshot 2024-09-26 150934](https://github.com/user-attachments/assets/8a703f48-26f4-4c3f-afe5-1487cfb20a30)
7) Extract Name and milliseconds (in descending order) for all the tracks that have song duration longer than the average song duration.

![Screenshot 2024-09-26 151124](https://github.com/user-attachments/assets/0c3f05b9-1df6-4467-a38d-e67ea9941d06)
There 168 tracks which have song duration longer than the average song duration.

8) Find how much amount is spent by each customer on the top artist? Give me their names and amount spent.
![Screenshot 2024-09-26 151445](https://github.com/user-attachments/assets/767638dd-3cfd-4409-8f51-14df2b02d086)
9) Find the most popular music genre for each country. We determine most popular genre as the genre highest amount of purchase trancations.
For countries where the maximum number of purchases is shared, provide all genres.
There are two methods to solve this query (i) By using CTE with ROW_NUMBER
![Screenshot 2024-09-26 151819](https://github.com/user-attachments/assets/ab9ac60b-ca18-4d6f-b789-430e337f5377)

ii) By using RECURSIVE
![Screenshot 2024-09-26 151936](https://github.com/user-attachments/assets/ec0e67aa-7932-4958-85d5-825a1abbdc4a)

10) Find country along with top customer and the amount spent by them. For countries where the top customer is shared, provide all customers who spent this amount.

![Screenshot 2024-09-26 152219](https://github.com/user-attachments/assets/41900d10-9f90-4632-a946-6ff728d447f5)
11) Find sales reprentative of each customer.

![Screenshot 2024-09-26 152617](https://github.com/user-attachments/assets/b169b884-5480-4a08-8f38-220ddfa8d385)
