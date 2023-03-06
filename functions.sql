
/*AVERAGE MARK FUNC FOR STUDENT*/
create  function average_mark(x text)
    RETURNS TABLE (
        aver_mark NUMERIC
) 
   language plpgsql
  as
$$
DECLARE

begin
 -- logic
 	

	RETURN QUERY
	select avg(marks)
	from student inner join  student_exam on student_id =student_sid
	where username = x;
	
end;
$$
select average_mark('Claudette')


select * from student

/*AVERAGE MARK FUNC FOR SUBJECT*/
create  function average_mark_subject(x text)
    RETURNS TABLE (
        aver_mark NUMERIC
) 
   language plpgsql
  as
$$
DECLARE

begin
 -- logic
 	

	RETURN QUERY
	select avg(marks)
	from student inner join  student_exam on student_id =student_sid
	where subject_name = x;
	
end;
$$

select average_mark_subject('Sales')
select avg(marks)
	from student inner join  student_exam on student_id =student_sid
	where subject_name ='Science'
/*RED ZONE*/
create  function red_zone()
    RETURNS TABLE (
		user_name text
        
) 
   language plpgsql
  as
$$
DECLARE

begin
 -- logic
 	
	RETURN QUERY
	select username
	from student inner join  student_exam on student_id =student_sid
	where username IN
	(SELECT username FROM student inner join  student_exam on student_id =student_sid 
	 where marks < 3
	group by username having count (*) >=2);


end;
$$

select red_zone()

select * from student