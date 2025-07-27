USE ROLE SYSADMIN;
USE WAREHOUSE COMPUTE_WH;

CREATE OR REPLACE DATABASE DEMO6_DB
    COMMENT = 'Database for Chapter 6: Data Loading and Unloading';

CREATE OR REPLACE SCHEMA WS COMMENT = 'Schema for Worksheet Insert Examples';
CREATE OR REPLACE SCHEMA UI COMMENT = 'Schema for Web UI Uploads';
CREATE OR REPLACE SCHEMA SNOW COMMENT = 'Schema for SnowSQL loads';

CREATE OR REPLACE WAREHOUSE LOAD_WH
    COMMENT = 'Warehouse for CH6 Load examples';

USE WAREHOUSE LOAD_WH;
USE DATABASE DEMO6_DB;
USE SCHEMA WS;

CREATE OR REPLACE TABLE TABLE1 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING
) COMMENT = 'Single-Row Insert for Structured Data using Explicitly specified values';

INSERT INTO TABLE1 (ID, F_NAME, L_NAME, CITY)
VALUES (1, 'Anthony', 'Robinson', 'Atlanta');

SELECT * FROM TABLE1;

INSERT INTO TABLE1 (ID, F_NAME, L_NAME, CITY)
VALUES (2, 'Peggy', 'Mathison', 'Birmingham');

SELECT * FROM TABLE1;

CREATE OR REPLACE TABLE TABLE2 (
    ID INTEGER,
    VARIANT1 VARIANT
) COMMENT = 'Single-Row Insert for Semi-Structured JSON Data';

INSERT INTO TABLE2 (ID, VARIANT1)
SELECT 1, PARSE_JSON('{"f_name": "Anthony", "l_name": "Robinson", "city": "Atlanta"}');

SELECT * FROM TABLE2;

INSERT INTO TABLE2 (ID, VARIANT1)
SELECT 2, PARSE_JSON('{"f_name": "Peggy", "l_name": "Mathison", "city": "Birmingham"}');

SELECT * FROM TABLE2;

CREATE OR REPLACE TABLE TABLE3 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING
) COMMENT = 'Multi-row Insert for Structured Data using Explicitly specified values';

INSERT INTO TABLE3 (ID, F_NAME, L_NAME, CITY)
VALUES (1, 'Anthony', 'Robinson', 'Atlanta'),
       (2, 'Peggy', 'Mathison', 'Birmingham');

SELECT * FROM TABLE3;

CREATE OR REPLACE TABLE TABLE4 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING
) COMMENT = 'Multi-row Insert for Structured Data using Query, all columns same';

INSERT INTO TABLE4 (ID, F_NAME, L_NAME, CITY)
SELECT * FROM TABLE3 WHERE CONTAINS(CITY, 'Atlanta');

SELECT * FROM TABLE4;

CREATE OR REPLACE TABLE TABLE5 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING
) COMMENT = 'Multi-row Insert for Structured Data using Query, fewer columns';

INSERT INTO TABLE5 (ID, F_NAME, L_NAME)
SELECT ID, F_NAME, L_NAME FROM TABLE3 WHERE CONTAINS(CITY, 'Atlanta');

SELECT * FROM TABLE5;

CREATE OR REPLACE TABLE TABLE6 (
    ID INTEGER,
    FIRST_NAME STRING,
    LAST_NAME STRING,
    CITY_NAME STRING
) COMMENT = 'Table to be used for next Demo';

INSERT INTO TABLE6 (ID, FIRST_NAME, LAST_NAME, CITY_NAME)
VALUES (1, 'Anthony', 'Robinson', 'Atlanta'),
       (2, 'Peggy', 'Mathison', 'Birmingham');

CREATE OR REPLACE TABLE TABLE7 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING
) COMMENT = 'Multi-row Insert for Structured Data Using CTE';

INSERT INTO TABLE7 (ID, F_NAME, L_NAME, CITY)
WITH CTE AS (
    SELECT ID, FIRST_NAME AS F_NAME, LAST_NAME AS L_NAME, CITY_NAME AS CITY FROM TABLE6
)
SELECT ID, F_NAME, L_NAME, CITY FROM CTE;

SELECT * FROM TABLE7;

CREATE OR REPLACE TABLE TABLE8 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    ZIP_CODE STRING
) COMMENT = 'Table to be used for next Demo';

INSERT INTO TABLE8 (ID, F_NAME, L_NAME, ZIP_CODE)
VALUES (1, 'Anthony', 'Robinson', '30301'),
       (2, 'Peggy', 'Mathison', '35005');

CREATE OR REPLACE TABLE TABLE9 (
    ID INTEGER,
    ZIP_CODE STRING,
    CITY STRING,
    STATE STRING
) COMMENT = 'Table to be used for next Demo';

INSERT INTO TABLE9 (ID, ZIP_CODE, CITY, STATE)
VALUES (1, '30301', 'Atlanta', 'Georgia'),
       (2, '35005', 'Birmingham', 'Alabama');

CREATE OR REPLACE TABLE TABLE10 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING,
    STATE STRING,
    ZIP_CODE STRING
) COMMENT = 'MULTI ROW INSERTS FROM TWO TABLES USING AN INNER JOIN ON ZIP CODE';

INSERT INTO TABLE10 (ID, F_NAME, L_NAME, CITY, STATE, ZIP_CODE)
SELECT A.ID, A.F_NAME, A.L_NAME, B.CITY, B.STATE, A.ZIP_CODE
FROM TABLE8 A
INNER JOIN TABLE9 B ON A.ZIP_CODE = B.ZIP_CODE;

SELECT * FROM TABLE10;

CREATE OR REPLACE TABLE TABLE11 (
    VARIANT1 VARIANT
) COMMENT = 'Multi row Insert for Semi-Structured JSON Data';

INSERT INTO TABLE11
SELECT PARSE_JSON(COLUMN1)
FROM VALUES
    ('{ "_id": "1", "name": {"first": "Anthony", "last": "Robinson"}, "company": "Pascal", "email": "anthony@pascal.com", "phone": "+1 (999) 444-2222"}'),
    ('{ "id": "2", "name": {"first": "Peggy", "last": "Mathison"}, "company": "Ada", "email": "Peggy@ada.com", "phone": "+1 (999) 555-3333"}');

SELECT * FROM TABLE11;

CREATE OR REPLACE TABLE TABLE12 (
    ID INTEGER,
    FIRST_NAME STRING,
    LAST_NAME STRING,
    CITY_NAME STRING
) COMMENT = 'Source table for next demo for unconditional insert';

INSERT INTO TABLE12 (ID, FIRST_NAME, LAST_NAME, CITY_NAME)
VALUES (1, 'Anthony', 'Robinson', 'Atlanta'),
       (2, 'Peggy', 'Mathison', 'Birmingham');

CREATE OR REPLACE TABLE TABLE13 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING
) COMMENT = 'Target table for the unconditional insert. Destination table 1';

CREATE OR REPLACE TABLE TABLE14 (
    ID INTEGER,
    F_NAME STRING,
    L_NAME STRING,
    CITY STRING


CREATE OR REPLACE TABLE TABLE15 (
    ID INTEGER,
    FIRST_NAME STRING,
    LAST_NAME STRING,
    CITY_NAME STRING
) COMMENT = 'Source table to be used as part of next demo for Conditional multi-row insert';

INSERT INTO TABLE15 (ID, FIRST_NAME, LAST_NAME, CITY_NAME)
VALUES (1, 'Anthony', 'Robinson', 'Atlanta'),
       (2, 'Peggy', 'Mathison', 'Birmingham'),
       (3, 'Marshall', 'Baker', 'Chicago'),
       (4, 'Kevin', 'Cline', 'Denver'),
       (5, 'Amy', 'Ranger', 'Everly'),
       (6, 'Andy', 'Murray', 'Fresno');


CREATE OR REPLACE TABLE TABLE16 (
    id integer, f_name string, l_name string, city string)
comment = 'Destination Table 1 for Conditional Multi-TABLE Insert';

CREATE OR REPLACE TABLE TABLE17 (
    id integer, f_name string, l_name string, city string)
comment = 'Destination Table 2 for Conditional Multi-TABLE Insert';

INSERT ALL
    WHEN ID < 5 then
        INTO TABLE16
    WHEN ID < 3 THEN ID > 1
        INTO TABLE16
        INTO TABLE17
    WHEN ID = 1 THEN
        INTO TABLE16 (id, f_name) values (id, first_name)
    else 
        into TABLE17
select id, first_name, last_name, city_name
from TABLE15;


//ARRAY INSERTS
CREATE OR REPLACE TABLE TABLE18 (
    Array variant
) COMMENT = 'Table for ARRAY INSERTS';


insert into TABLE18 
select ARRAY_INSERT(array_construct(0, 1, 2, 3), 4, 4);

insert into TABLE18 
select ARRAY_INSERT(array_construct(0, 1, 2, 3), 7, 4);

create tables TABLE19 (Object variant)
comment = "Insert object"


insert into TABLE19
select OBJECT_INSERT(OBJECT_CONSTRUCT('a', 1, 'b', 2, 'c', 3), 'd', 4);
select * from TABLE19;
create or replace table table20
(id integer, f_name string, l_name string, city string)
comment = 'Load Structured Data from CSV file';