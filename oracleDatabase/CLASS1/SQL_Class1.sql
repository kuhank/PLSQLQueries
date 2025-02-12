-- connect to admin USER

@ C:\app\Admin\product\21c\dbhomeXE\demo\schema\human_resources\hr_main.sql

Parameter 1 :
------------
hr

Parameter 2 :
-------------
users

Parameter 3 :
-------------
temp

Parameter 4 :
----------------------
admin

Parameter 5 ::
----------------------
$ORACLE_HOME/demo/schema/log

Parameter 6 ::
----------------------
localhost:1521/XEPDB1


-- connect to HR USER

select * from employees;  -- No data will be present initially. Then execute the below commands in HR

@ C:\app\Admin\product\21c\dbhomeXE\demo\schema\human_resources\hr_cre.sql

@ C:\app\Admin\product\21c\dbhomeXE\demo\schema\human_resources\hr_popul.sql

@ C:\app\Admin\product\21c\dbhomeXE\demo\schema\human_resources\hr_idx.sql

@ C:\app\Admin\product\21c\dbhomeXE\demo\schema\human_resources\hr_code.sql

@ C:\app\Admin\product\21c\dbhomeXE\demo\schema\human_resources\hr_comnt.sql

@ C:\app\Admin\product\21c\dbhomeXE\demo\schema\human_resources\hr_analz.sql

-- connect to admin USER
CREATE USER login360 IDENTIFIED BY login360 DEFAULT TABLESPACE users TEMPORARY TABLESPACE TEMP;

GRANT CONNECT
	,RESOURCE
	TO login360;

GRANT CREATE SESSION
	TO login360;

-- list of tablespaces
SELECT *
FROM dba_tablespaces;

--size of table space
SELECT *
FROM dba_data_files;

SELECT *
FROM dba_free_space;

SELECT *
FROM dba_users;

SELECT *
FROM dba_roles;

SELECT *
FROM dba_sys_privs
WHERE grantee = 'LOGIN360';

SELECT *
FROM DBA_TABLES;

SELECT *
FROM DBA_TAB_COLUMNS;

SELECT *
FROM V$SESSION;

SELECT *
FROM V$SQL
WHERE ROWNUM <= 10;

DESC V$SQL;

-- data file --.dbf 
-- tablespace -- folder with multiple datafile
CREATE tablespace login360 datafile 'C:\APP\ADMIN\PRODUCT\21C\ORADATA\XE\XEPDB1\LOGIN360.DBF' SIZE 100 M AUTOEXTEND ON;

SELECT *
FROM DBA_TS_QUOTAS;

ALTER USER LOGIN360 QUOTA 500 M ON login360;

SELECT *
FROM DBA_USERS;

ALTER USER LOGIN360 DEFAULT TABLESPACE LOGIN360;


-- connect to login360 USER
CREATE TABLE customer (
	ID number(6)
	,NAME varchar2(50)
	,DOB DATE
	,EMAIL VARCHAR2(100)
	);

SELECT *
FROM customer;

SELECT *
FROM USER_USERS;

SELECT *
FROM USER_TABLES;

ALTER TABLE CUSTOMER MOVE TABLESPACE LOGIN360;

INSERT INTO customer (
	ID
	,NAME
	,DOB
	,EMAIL
	)
VALUES (
	1
	,'KUHAN'
	,'12-01-1994'
	,'KUHAN@GMAIL.COM'
	);

--SQL Error: ORA-01950: no privileges on tablespace 'USERS'
INSERT INTO customer (
	ID
	,NAME
	,DOB
	,EMAIL
	)
VALUES (
	1
	,'SHIVA'
	,'10/01/2000'
	,'SHIVA@GMAIL.COM'
	);

INSERT INTO customer (
	ID
	,NAME
	,DOB
	,EMAIL
	)
VALUES (
	3
	,'KISHORE'
	,'11012020'
	,'KISHORE@GMAIL.COM'
	);

INSERT INTO customer (
	ID
	,NAME
	,DOB
	,EMAIL
	)
VALUES (
	5
	,'DEFAULT'
	,'19010112'
	,'DEFAULT@GMAIL.COM'
	);

INSERT INTO customer (
	ID
	,NAME
	,DOB
	,EMAIL
	)
VALUES (
	5
	,'DEFAULT'
	,TO_DATE('19010112', 'yyyyMMdd')
	,'DEFAULT@GMAIL.COM'
	);

SELECT *
FROM v$nls_parameters;

ALTER session

SET NLS_DATE_FORMAT = 'DD-MM-YYYY';'DD-MM-RR'

COMMIT;

SELECT *
FROM CUSTOMER;

INSERT INTO customer (
	ID
	,NAME
	,DOB
	,EMAIL
	)
VALUES (
	1234
	,'ROLLBACK'
	,'12-01-1994'
	,'ROLLBACK@GMAIL.COM'
	);

SELECT *
FROM CUSTOMER;

ROLLBACK;

SELECT *
FROM CUSTOMER;

COMMIT;

UPDATE customer
SET ID = 0000;

SELECT *
FROM CUSTOMER;

ROLLBACK;

SELECT *
FROM CUSTOMER;

UPDATE customer
SET ID = 1234
WHERE ID = 5;

COMMIT;


------------ part 2

-- alter column
ALTER TABLE customer ADD country VARCHAR2 (50);

SELECT *
FROM customer;

-- drop a column
ALTER TABLE customer ADD city VARCHAR2 (50);

ALTER TABLE customer

DROP COLUMN city;

UPDATE customer
SET country = 'India';

COMMIT;

DESC customer;

ALTER TABLE customer ADD mobile INT;

INSERT ALL
INTO customer(mobile)
VALUES (1233435)
INTO customer(mobile)
VALUES (123456)

SELECT *
FROM dual;

SELECT sysdate
FROM dual;

SELECT *
FROM dual;

INSERT INTO customer (mobile)
VALUES ('+91 - 1233435');

SELECT *
FROM customer;

ALTER TABLE customer modify mobile VARCHAR(20);

---- ORA-01440: column to be modified must be empty to decrease precision or scale
----ORA-01439: column to be modified must be empty to change datatype
--altering column method`
CREATE TABLE customer_bk AS (SELECT * FROM customer);

TRUNCATE TABLE customer;

ALTER TABLE customer modify mobile VARCHAR(20);

INSERT INTO customer
SELECT *
FROM customer_bk;

INSERT INTO customer (mobile)
VALUES ('+91 - 1233435');

SELECT *
FROM customer;

DROP TABLE customer_bk;

DESC customer;

INSERT INTO customer (name)
VALUES ('A');

savepoint a;

INSERT INTO customer (name)
VALUES ('b');

savepoint b;

INSERT INTO customer (name)
VALUES ('c');

savepoint c;

INSERT INTO customer (name)
VALUES ('d');

ROLLBACK TO c;

SELECT *
FROM customer;

ROLLBACK TO b;

COMMIT;


--- part 3


--DDL 
-- create
CREATE TABLE DDL_scripts (
	id INT
	,numbers NUMERIC(8, 2)
	,NAMES VARCHAR(20)
	,name2 varchar2(20)
	,name3 CHAR(20)
	,dob DATE
	);

--alter 
ALTER TABLE DDL_scripts ADD numbers2 DECIMAL;

SELECT *
FROM DDL_scripts;

--rename
rename ddl_scripts TO ddl_Scripting;

SELECT *
FROM DDL_scripts;

SELECT *
FROM ddl_Scripting;

ALTER TABLE ddl_Scripting rename COLUMN numbers2 TO numbers4;

SELECT *
FROM ddl_scripting;

--truncate 
TRUNCATE TABLE ddl_Scripting;

--`drop
DROP TABLE ddl_Scripting;

-- no rollback 
-- auto commit
CREATE TABLE DDL_scripts (
	id INT
	,numbers NUMERIC(8, 2)
	,NAMES VARCHAR(20)
	,name2 varchar2(20)
	,name3 CHAR(20)
	,dob DATE
	);

COMMIT;

DROP TABLE DDL_scripts;

ROLLBACK;

SELECT *
FROM DDL_scripts;

-- DML -- need to explicitly commit and roll back
-- insert
CREATE TABLE DDL_scripts (
	id INT
	,numbers NUMERIC(8, 2)
	,NAMES VARCHAR(20)
	,name2 varchar2(20)
	,name3 CHAR(20)
	,dob DATE
	);

INSERT INTO ddl_Scripts
VALUES (
	1
	,23.23
	,'ad'
	,'df'
	,'gff'
	,'01-01-2023'
	);

SELECT *
FROM ddl_Scripts;

--update
UPDATE ddl_scripts
SET id = 30
WHERE dob = '01-01-2023';

SELECT *
FROM ddl_scripts;

COMMIT;

UPDATE ddl_scripts
SET id = 25
WHERE dob = '01-01-2023';

SELECT *
FROM ddl_scripts;

ROLLBACK;

SELECT *
FROM ddl_scripts;

--delete 
INSERT INTO ddl_Scripts
VALUES (
	5
	,23.23
	,'ad'
	,'df'
	,'gff'
	,'01-01-2023'
	);

COMMIT;

DELETE
FROM ddl_Scripts
WHERE id = 5;

SELECT *
FROM ddl_scripts;

ROLLBACK;

SELECT *
FROM ddl_scripts;

MERGE


-- DRL
--select
SELECT *
FROM user_tables;

SELECT *
FROM customer;

SELECT count(*)
FROM customer
WHERE name IS NULL;

SELECT name
	,count(*) totalRecords
FROM customer
GROUP BY name
HAVING count(*) > 1
ORDER BY 1;

DESC customer;

	-- TCL
	--commit
	--rollback
	--savepoint
	
	--DCL
	--grant
	--revoke
