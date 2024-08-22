use project;
select * from hr;
-- ganti nama di kolom ï»¿id menjadi emp_id
alter table hr
change column ï»¿id emp_id varchar(20)null;
select * from hr;

-- cek data type utk semua column
describe hr;

-- ganti column birthdate dari text -> date
select birthdate from hr;
-- karena values di column birthdate berantakan, maka ubah format datenya agar sama semua
-- format datenya year-month-
set sql_safe_updates =0;
update hr
set birthdate = case
	when birthdate like'%/%'then date_format(str_to_date(birthdate,'%m/%d/%Y'),'%Y-%m-%d')
    when birthdate like'%-%'then date_format(str_to_date(birthdate,'%m-%d-%Y'),'%Y-%m-%d')
	else null
end;
select birthdate from hr;

-- ganti column birthdate dari text -> date
describe hr;
alter table hr
modify column birthdate date;
describe hr;

-- ganti data type hire_date text to date
-- ganti juga values formatnya biar sama semua
select hire_date from hr;
update hr
set hire_date = case
	when hire_date like'%/%'then date_format(str_to_date(hire_date,'%m/%d/%Y'),'%Y-%m-%d')
    when hire_date like'%-%'then date_format(str_to_date(hire_date,'%m-%d-%Y'),'%Y-%m-%d')
	else null
end;
select hire_date from hr;

select * from hr;
describe hr;
select termdate from hr;

UPDATE hr
SET termdate = CASE
    WHEN termdate IS NULL OR termdate = '' THEN '0000-00-00'
    ELSE DATE(STR_TO_DATE(termdate, '%Y-%m-%d %H:%i:%s UTC'))
END
WHERE termdate IS NOT NULL OR termdate = '';

set sql_mode = '';
select hire_date from hr;

-- ganti column termdate dari text -> date
describe hr;
alter table hr
modify column termdate date;
describe hr;

-- ganti column hire_date dari text -> date
describe hr;
alter table hr
modify column hire_date date;
describe hr;

-- menambahkan column age
alter table hr add column age int;
select * from hr;
update hr
set age = timestampdiff(year,birthdate,curdate());
select birthdate, age from hr;

-- melihat minimum dan maximal age (termuda dan tertua)
select
	min(age) as youngest,
    max(age) as oldest
from hr;

select count(*) from hr where age < 18;