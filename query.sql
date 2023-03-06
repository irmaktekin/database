/*100K users for testing index*/
/*
INSERT INTO student(student_id,username,surname,birth_date,primary_skill,phone_number,subject_name)
SELECT student_id,  /*(array['Irmak','Ebru','Kaan','Mehmet'])[floor(random() * 3 + 1)],*/
md5(random()::text)::varchar(5),
(array['Tekin','Acikgöz','Durmaz','Oturak'])[floor(random() * 3 + 1)], 
NOW() + (random() * (NOW()+'90 days' - NOW())) + '30 days',
(array['Java','JavaScript','HTML','Python'])[floor(random() * 3 + 1)],
md5(random()::text)::varchar(11),
(array['Math','Biology','Turkish','English'])[floor(random() * 3 + 1)],
FROM generate_series(1,100000) student_id*/

select * from student
where student_id=6

/*Insert data to exam*/
INSERT INTO exam(exam_id, exam_name)
SELECT exam_id,
(array['Midterm1','Midterm2','Final','Makeup'])[floor(random() * 3 + 1)]
FROM generate_series(1,1000000) exam_id

select * from student_exam
select * from student inner join  student_exam on student_id =student_sid where username='Mic'

/*Insert data to student_exam, get the foreign key from students table*/
INSERT INTO student_exam(student_sid,marks)
SELECT student.student_id,
random_between(1,3)
FROM student 



/*Insert 1000 of subject*/
INSERT INTO subject(subject_id, name)
SELECT subject_id,
(array['Math','Science','Physic','English'])[floor(random() * 3 + 1)]
FROM generate_series(1,1000) subject_id;
/*According to subject name insert tutor name*/
update subject
SET tutor= case
when name= 'Math' then 'Mr Alex' when name='Science' then 'Mrs Jennifer'
when name='Physic' then 'Mr Ilyas' when name= 'English' then 'Mr Kaan' end

select * from subject

/*Insert data to student_subject, get the foreign key from students table*//*serial primary need*/
INSERT INTO student_subject(student_sid)
SELECT student.student_id
FROM student 


/*Trigger for updated at time stamp*/
CREATE TRIGGER set_timestamp
BEFORE UPDATE ON student
FOR EACH ROW
EXECUTE PROCEDURE trigger_set_timestamp();
/*Updating data for checking trigger*/
UPDATE student
SET username ='Tayfun'
where student_id=6




/*Checking the subject table*/
select * from subject
select * from student



/*Insert data to subject_exam, get the foreign key from students table*/
INSERT INTO subject_exam(exam_id,subject_name)
SELECT exam_id,
(array['Java','JavaScript','HTML','Python'])[floor(random() * 3 + 1)]
FROM generate_series(1,1000000) exam_id


/*Create trigger for adress table*/
CREATE TRIGGER check_adress
BEFORE UPDATE
ON adress
FOR EACH ROW
EXECUTE PROCEDURE check_adress()


/*call the average function for a student*/
select average_mark('Irmak')


/*Adress table*/
INSERT INTO adress(adress_id,postal_code, street_adress)
VALUES(3,'45030', 'Uncubozköy')

select * from adress2

UPDATE adress
SET postal_code ='800'
WHERE adress_id=1
