--to install an extension
create extension pg_stat_statements;
create extension pgcrypto;

--listing installed extensions:
select * from pg_extension;

--create a new table called "employees
create table employees (
   id serial primary key,
   first_name varchar(255),
   last_name varchar(255),
   email varchar(255),
   encrypted_password text
);

--insert sample employee data into the table. 
insert into employees (first_name, last_name, email, encrypted_password) values
   ('bandarenka', 'uladzislau', 'bandarenka.uladzislau@student.ehu.lt', crypt('aboba1492', gen_salt('bf'))),
   ('mikita', 'dubrovin', 'mikita.dubrovin@student.ehu.lt', crypt('aboba1491', gen_salt('bf'))),
   ('taras', 'rybirn', 'taras.rybirn@student.ehu.lt', crypt('aboba1498', gen_salt('bf')));

--select all employees:  
select * from employees;

--update an employee's personal information, such as their last name
update employees set last_name = 'С#' where email = 'bandarenka.uladzislau@student.ehu.lt';

select * from employees;

-- delete an employee record using the email column
delete from employees where email = 'bandarenka.uladzislau@student.ehu.lt';

select * from employees;

--configure the pg_stat_statements extension
alter system set shared_preload_libraries to 'pg_stat_statements';
alter system set pg_stat_statements.track to 'all';

--run the following query to gather statistics for the executed statements:
select * from pg_stat_statements;

--- analyze the output of the pg_stat_statements view (self-check)

--identify the most frequently executed queries
select query, calls 
from pg_stat_statements
order by calls desc;

-- determine which queries have the highest average and total runtime
select query, total_plan_time as total_time , total_plan_time /calls as avg_time
from pg_stat_statements
order by avg_time, total_time desc;
