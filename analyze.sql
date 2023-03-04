
/*BEFORE INSERTING DATA*/

/*100K users for testing index*/

/*Exact match, before insert data*/


/*Creating b-tree index on student_name*/
CREATE INDEX idx_student_name 
ON student(username);

EXPLAIN ANALYZE select * from student 
WHERE username='b17fd'

DROP INDEX idx_student_name
/*checking index size*/
select pg_size_pretty(pg_relation_size('idx_student_name'))

/*Creating Hash Index on student_name*/
CREATE INDEX idx_student_name
ON student using hash(username)
/*When hash and btree is compared;
-with hash index sequential scan performed as a path of execution and resulted in 11.767 ms.
-with btree index index scan performed as a path of execution and resulted in 6.990 ms.
*/


/*AFTER INSERTING DATA*/
/*100K Users*/
/*Exact match, after insert data*/
INSERT INTO student(student_id,username,surname,birth_date,primary_skill,phone_number,subject_name)
SELECT student_id,  /*(array['Irmak','Ebru','Kaan','Mehmet'])[floor(random() * 3 + 1)],*/
md5(random()::text)::varchar(5),
(array['Tekin','Acikgöz','Durmaz','Oturak'])[floor(random() * 3 + 1)], 
NOW() + (random() * (NOW()+'90 days' - NOW())) + '30 days',
(array['Java','JavaScript','HTML','Python'])[floor(random() * 3 + 1)],
md5(random()::text)::varchar(11),
md5(random()::text)
FROM generate_series(1,100000) student_id


/*1000 of subject*/
INSERT INTO subject(subject_id, name,tutor)
SELECT student_id,
(array['Math','Science','Physic','English'])[floor(random() * 3 + 1)],
(array['Mr Sonmez','Mrs Filiz','Mr Nick','Mrs Ayse'])[floor(random() * 3 + 1)]
FROM generate_series(1,1000) student_id;
-----------------------------------------------------
/*AFTER INSERTING DATA*/
/*100K Users*/
/*partial match, before insert data*/

/*Analyze queries surname partial match*/
/*tree index*/
CREATE INDEX idx_surname 
ON student(surname);

/*hash*/
CREATE INDEX idx_surname
ON student using hash(surname)

EXPLAIN ANALYZE select * from student 
WHERE surname LIKE 'Te%'

DROP INDEX idx_surname

/*able to use gin index and create gin index for partial match*/
create extension pg_trgm; 
CREATE INDEX idx_surname
ON student using gin(surname gin_trgm_ops)

/*checking index size*/
select pg_size_pretty(pg_relation_size('idx_surname'));

------------------------------
/*PHONE NUMBER PARTIAL MATCH AFTER INSERT DATA*/
CREATE INDEX idx_phone 
ON student(phone_number);
DROP INDEX idx_surname_withmark

EXPLAIN ANALYZE select * from student 
WHERE phone_number LIKE '35%'

CREATE INDEX idx_phone
ON student using hash(phone_number)

CREATE INDEX idx_phone
ON student using gin(phone_number gin_trgm_ops)

/*surname PARTIAL MATCH with mark AFTER INSERT DATA*/

CREATE INDEX idx_surname_withmark
ON student using gin(surname gin_trgm_ops)

CREATE INDEX idx_surname_withmark
ON student using hash(username)

CREATE INDEX idx_surname_withmark
ON student(surname)

EXPLAIN ANALYZE select marks,surname FROM student inner join  student_exam on student_id =student_sid 
WHERE surname LIKE 'Durm%'

