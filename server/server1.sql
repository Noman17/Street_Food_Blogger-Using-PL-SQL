SET SERVEROUTPUT ON;
SET VERIFY OFF;

clear screen;
/*
DROP TABLE DISTRICTS CASCADE CONSTRAINTS;
DROP TABLE AREAS CASCADE CONSTRAINTS;
DROP TABLE FOODS CASCADE CONSTRAINTS;
DROP TABLE REVIEWS CASCADE CONSTRAINTS;

CREATE TABLE DISTRICTS (
	DistID int, 
	DistName varchar2(25), 
    PRIMARY KEY(DistID)); 

CREATE TABLE AREAS (
	AreaID int, 
	AreaName varchar2(25),
	DistID int,
    PRIMARY KEY(AreaID),
	FOREIGN KEY(DistID) REFERENCES DISTRICTS(DistID)); 
	
CREATE TABLE FOODS (
	FoodID int, 
	FoodName varchar2(25),
	Price int,
	Rating float,
	AreaID int,
    PRIMARY KEY(FoodID),
	FOREIGN KEY(AreaID) REFERENCES AREAS(AreaID)); 
	
CREATE OR REPLACE TRIGGER insdist
AFTER INSERT
ON DISTRICTS
BEGIN
   DBMS_OUTPUT.PUT_LINE('VALUES INSERTED INTO DISTRICTS TABLE');
END;
/

insert into DISTRICTS (DistID, DistName) values (1, 'Barisal'); 
insert into DISTRICTS (DistID, DistName) values (2, 'Dhaka'); 
insert into DISTRICTS (DistID, DistName) values (3, 'Narayanganj'); 
insert into DISTRICTS (DistID, DistName) values (4, 'Noakhali'); 

insert into AREAS (AreaID, AreaName, DistID) values (1, 'Chasara', 3); 
insert into AREAS (AreaID, AreaName, DistID) values (2, 'TSC', 2); 

insert into FOODS (FoodID, FoodName, Price, Rating, AreaID) values (1, 'Chotpoti', 20, 4.2, 1); 
insert into FOODS (FoodID, FoodName, Price, Rating, AreaID) values (2, 'Fuchka', 30, 4.7, 1); 
insert into FOODS (FoodID, FoodName, Price, Rating, AreaID) values (3, 'Chicken Chap', 100, 5.0, 1); 

--SELECT * FROM DISTRICTS;
--SELECT * FROM AREAS;
--SELECT * FROM FOODS;

CREATE OR REPLACE VIEW myview(view_A, view_B) AS
SELECT S.DistID, S.DistName
FROM DISTRICTS S;

CREATE OR REPLACE VIEW myview1(view_A, view_B, view_C) AS
SELECT S.AreaID, S.AreaName, S.DistID
FROM AREAS S;

CREATE OR REPLACE VIEW myview2(view_A, view_B, view_C, view_D, view_E) AS
SELECT S.FoodID, S.FoodName, S.Price, S.Rating, S.AreaID
FROM FOODS S;

--SELECT * FROM myview;
--SELECT * FROM myview1;
--SELECT * FROM myview2;
*/

CREATE OR REPLACE PACKAGE mypack AS

	FUNCTION find_district(diname IN DISTRICTS.DistName%TYPE, temp OUT NUMBER)
	RETURN DISTRICTS.DistID%TYPE;
	
	FUNCTION find_area(arname IN AREAS.AreaName%TYPE, diid IN DISTRICTS.DistID%TYPE, temp OUT NUMBER)
	RETURN AREAS.AreaID%TYPE;
	
	PROCEDURE search_food(arid IN AREAS.AreaID%TYPE);

END mypack;
/

CREATE OR REPLACE PACKAGE BODY mypack AS

	FUNCTION find_district(diname IN DISTRICTS.DistName%TYPE, temp OUT NUMBER)
	RETURN DISTRICTS.DistID%TYPE
	IS
	id DISTRICTS.DistID%TYPE;
	CURSOR cur IS SELECT * FROM myview WHERE view_B = diname;
	r_cur cur%ROWTYPE;
	
	BEGIN
	
		temp := 0;	
		OPEN cur;
		LOOP
			FETCH cur INTO r_cur;
			EXIT WHEN cur%NOTFOUND;
			id := r_cur.view_A;
			temp := 1;
		END LOOP;
		CLOSE cur;
		RETURN id;
		
	END find_district;
	
	FUNCTION find_area(arname IN AREAS.AreaName%TYPE, diid IN DISTRICTS.DistID%TYPE, temp OUT NUMBER)
	RETURN AREAS.AreaID%TYPE
	IS
	id AREAS.AreaID%TYPE;
	CURSOR cur IS SELECT * FROM myview1 WHERE view_B = arname AND view_C = diid;
	r_cur cur%ROWTYPE;
	
	BEGIN
	
		temp := 0;
		OPEN cur;
		LOOP
			FETCH cur INTO r_cur;
			EXIT WHEN cur%NOTFOUND;
			id := r_cur.view_A;
			temp := 1;
		END LOOP;
		CLOSE cur;	
		RETURN id;
		
	END find_area;
	
	PROCEDURE search_food(arid IN AREAS.AreaID%TYPE)
	IS
	BEGIN
	
		DBMS_OUTPUT.PUT_LINE(chr(10));
		FOR R IN (SELECT view_B FROM myview1 WHERE view_A = arid) LOOP
			DBMS_OUTPUT.PUT_LINE('Foods near ' || R.view_B || ':');
		END LOOP;
		
		FOR R IN (SELECT view_A, view_B, view_C, view_D FROM myview2 WHERE view_E = arid) LOOP
			DBMS_OUTPUT.PUT_LINE('Food Name: ' || R.view_B || '      Price: ' || R.view_C || ' Tk      Rating: ' || R.view_D);
		END LOOP;
		
	END search_food;

END mypack;
/

ACCEPT A PROMPT "Enter District Name: "
ACCEPT B PROMPT "Enter Area Name: "

DECLARE
	dname varchar2(25);
	dtemp number;
	did DISTRICTS.DistID%TYPE;
	aname varchar2(25);
	atemp number;
	aid AREAS.AreaID%TYPE;
	dis_not_found EXCEPTION;
	ar_not_found EXCEPTION;
	
BEGIN
    dname := '&A';
	aname := '&B';
	
	did := mypack.find_district(dname, dtemp);
	--DBMS_OUTPUT.PUT_LINE('District ID of ' || dname || ' is ' || did);
	--DBMS_OUTPUT.PUT_LINE(dtemp);
	
	IF dtemp = 0 THEN
		RAISE dis_not_found;
	ELSE
		aid := mypack.find_area(aname, did, atemp);
		--DBMS_OUTPUT.PUT_LINE('Area ID of ' || aname || ' is ' || aid);
		--DBMS_OUTPUT.PUT_LINE(atemp);
		
		IF atemp = 0 THEN
			RAISE ar_not_found;
		ELSE
			mypack.search_food(aid);	
		END IF;
	END IF;
	
	EXCEPTION
		WHEN dis_not_found THEN
			DBMS_OUTPUT.PUT_LINE('DISTRICT NOT FOUND');
		WHEN ar_not_found THEN
			DBMS_OUTPUT.PUT_LINE('AREA NOT FOUND');
			
END;
/

ACCEPT A PROMPT "Enter District Name: "
ACCEPT B PROMPT "Enter Area Name: "
ACCEPT C PROMPT "Enter Food Name: "
ACCEPT D PROMPT "Enter Rating: "

DECLARE
	dname varchar2(25);
	dtemp number;
	did DISTRICTS.DistID%TYPE;
	aname varchar2(25);
	atemp number;
	aid AREAS.AreaID%TYPE;
	fname varchar2(25);
	rating float;
	revid number;
	disid number;
	arid number;
	rat float;
	revt number;
	ftemp number := 0;
	cnt number;
	frat float;
	frat1 float := 0;
	dis_not_found EXCEPTION;
	ar_not_found EXCEPTION;
	f_not_found EXCEPTION;
	
BEGIN
	dname := '&A';
	aname := '&B';
	fname := '&C';
	rating := '&D';
	
	did := mypack.find_district(dname, dtemp);
	--DBMS_OUTPUT.PUT_LINE('District ID of ' || dname || ' is ' || did);
	--DBMS_OUTPUT.PUT_LINE(dtemp);
	
	IF dtemp = 0 THEN
		RAISE dis_not_found;
	ELSE
		aid := mypack.find_area(aname, did, atemp);
		--DBMS_OUTPUT.PUT_LINE('Area ID of ' || aname || ' is ' || aid);
		--DBMS_OUTPUT.PUT_LINE(atemp);
		
		IF atemp = 0 THEN
			RAISE ar_not_found;
		ELSE
			FOR R IN (SELECT * FROM myview3@site1 WHERE view_B = did AND view_C = aid AND view_D = fname) LOOP
				revid := R.view_A;
				disid := R.view_B;
				arid := R.view_C;
				rat := R.view_E;
				revt := R.view_F;
				ftemp := 1;
			END LOOP;
			/*
			DBMS_OUTPUT.PUT_LINE(revid);
			DBMS_OUTPUT.PUT_LINE(disid);
			DBMS_OUTPUT.PUT_LINE(arid);
			DBMS_OUTPUT.PUT_LINE(rat);
			DBMS_OUTPUT.PUT_LINE(revt);
			DBMS_OUTPUT.PUT_LINE(ftemp);
			*/
			IF ftemp = 0 THEN
				RAISE f_not_found;
			ELSE
				SELECT COUNT(*) INTO cnt FROM myview3@site1;
				--DBMS_OUTPUT.PUT_LINE(cnt);
				
				INSERT INTO REVIEWS@site1 (ReviewID, DistID, AreaID, FoodName, Ratings, ReviewTime) VALUES (cnt+1, did, aid, fname, rating, revt+1); 
				
				FOR R IN(SELECT * FROM myview2 WHERE view_B = fname AND view_E = aid) LOOP
					frat := R.view_D;
				END LOOP;
				
				frat1 := ((frat * revt) + rating) / (revt+1);
				DBMS_OUTPUT.PUT_LINE(CHR(10));
				DBMS_OUTPUT.PUT_LINE('Updated rating for ' || fname || ' at ' || aname || ' is ' || ROUND(frat1, 1));
				UPDATE FOODS SET Rating = ROUND(frat1, 1) WHERE FoodName = fname AND AreaID = aid;
			END IF;
		END IF;
	END IF;
	
	EXCEPTION
		WHEN dis_not_found THEN
			DBMS_OUTPUT.PUT_LINE('DISTRICT NOT FOUND');
		WHEN ar_not_found THEN
			DBMS_OUTPUT.PUT_LINE('AREA NOT FOUND');
		WHEN f_not_found THEN
			DBMS_OUTPUT.PUT_LINE('FOOD NOT FOUND');
	
END;
/

commit;