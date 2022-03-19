SET SERVEROUTPUT ON;
SET VERIFY OFF;

clear screen;

--DROP TABLE REVIEWS CASCADE CONSTRAINTS;
/*
CREATE TABLE REVIEWS (
	ReviewID int, 
	DistID int, 
	AreaID int,
	FoodName varchar2(25),
	Ratings float,
	ReviewTime int,
    PRIMARY KEY(ReviewID)); 

insert into AREAS@server1 (AreaID, AreaName, DistID) values (3, 'Lebur Char', 1); 
insert into AREAS@server1 (AreaID, AreaName, DistID) values (4, 'Puran Dhaka', 2); 
insert into AREAS@server1 (AreaID, AreaName, DistID) values (5, 'College Road', 3); 
insert into AREAS@server1 (AreaID, AreaName, DistID) values (6, 'Dhanmondi', 2); 
insert into AREAS@server1 (AreaID, AreaName, DistID) values (7, 'Khanpur', 3); 
insert into AREAS@server1 (AreaID, AreaName, DistID) values (8, 'DIT', 3); 

insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (4, 'Chicken Chap', 90, 4.5, 7); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (5, 'Burger', 35, 4.2, 1); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (6, 'Dudh Chaa', 10, 4.8, 1); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (7, 'Momo', 70, 4.9, 2); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (8, 'Bhelpuri', 20, 5.0, 2); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (9, 'Lebu Chaa', 6, 5.0, 1); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (10, 'Fuchka', 40, 4.6, 7); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (11, 'Lebu Chaa', 10, 4.9, 2);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (12, 'Burger', 45, 4.6, 5); 
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (13, 'Chicken Chap', 100, 5.0, 1);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (14, 'Fuchka', 30, 4.9, 2);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (15, 'Momo', 60, 4.4, 1);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (16, 'Chotpoti', 30, 5.0, 6);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (17, 'Dudh Chaa', 15, 4.6, 2);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (18, 'Momo', 80, 4.5, 7);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (19, 'Fuchka', 60, 5.0, 6);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (20, 'Bhelpuri', 20, 4.9, 1);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (21, 'Chotpoti', 40, 4.6, 7);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (22, 'Lebu Chaa', 10, 5.0, 7);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (23, 'Bhelpuri', 20, 4.6, 4);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (24, 'Lacchi', 40, 5.0, 4);
insert into FOODS@server1 (FoodID, FoodName, Price, Rating, AreaID) values (25, 'Lebu Chaa', 10, 4.6, 3);

insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (1, 3, 1, 'Fuchka', 4.6, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (2, 3, 1, 'Fuchka', 4.7, 3); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (7, 3, 1, 'Chotpoti', 4.2, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (8, 3, 1, 'Chicken Chap', 5.0, 2);
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (9, 3, 7, 'Chicken Chap', 4.5, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (10, 3, 1, 'Burger', 4.2, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (11, 3, 1, 'Dudh Chaa', 4.8, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (12, 2, 2, 'Momo', 4.9, 2);  
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (13, 2, 2, 'Bhelpuri', 5.0, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (14, 3, 1, 'Lebu Chaa', 5.0, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (15, 3, 7, 'Fuchka', 4.6, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (16, 2, 2, 'Lebu Chaa', 4.9, 2);  
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (17, 3, 5, 'Burger', 4.6, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (18, 3, 1, 'Chicken Chap', 5.0, 2);
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (19, 2, 2, 'Fuchka', 4.9, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (20, 3, 1, 'Momo', 4.4, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (21, 2, 6, 'Chotpoti', 5.0, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (22, 2, 2, 'Dudh Chaa', 4.6, 2);  
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (23, 3, 7, 'Momo', 4.5, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (24, 2, 6, 'Fuchka', 5.0, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (25, 3, 1, 'Bhelpuri', 4.9, 2);
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (26, 3, 7, 'Chotpoti', 4.6, 2);  
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (27, 3, 7, 'Lebu Chaa', 5.0, 2); 
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (25, 2, 4, 'Bhelpuri', 4.6, 2);
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (26, 2, 4, 'Lacchi', 5.0, 2);  
insert into REVIEWS (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) values (27, 1, 3, 'Lebu Chaa', 4.6, 2); 

CREATE OR REPLACE VIEW myview3(view_A, view_B, view_C, view_D, view_E, view_F) AS
SELECT S.ReviewID, S.DistID, S.AreaID, S.FoodName, S.Ratings, S.ReviewTime
FROM REVIEWS S;
*/
SELECT * FROM myview3;

-- Horizontal Fragmentation
/*
CREATE TABLE high_reviewed AS 
SELECT * FROM REVIEWS 
WHERE ReviewTime >= 5; 
*/

select * from high_reviewed;

/*
CREATE TABLE low_reviewed AS 
SELECT * FROM REVIEWS 
WHERE ReviewTime < 5; 
*/

select * from low_reviewed;

select * from AREAS@server1;
select * from FOODS@server1;

commit;