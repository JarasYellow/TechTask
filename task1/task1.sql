create table employees
(
    emp_id        bigint primary key,
    full_name     varchar(50),
    position      varchar(50),
    hire_date     date,
    salary        numeric,
    department_id bigint,
    foreign key (department_id) references departments (department_id)
);

create table departments
(
    department_id   bigint primary key,
    department_name varchar(100),
    location_id     bigint,
    foreign key (location_id) references locations (location_id)
);

create table job_history
(
    employee_id   bigint primary key,
    start_date    date,
    end_date      date,
    job_id        varchar(50),
    department_id bigint,
    foreign key (employee_id) references employees (emp_id),
    foreign key (department_id) references departments (department_id),
    foreign key (job_id) references jobs (job_id)
);

create table jobs
(
    job_id    varchar(50) primary key,
    job_title varchar(50)
);

create table locations
(
    location_id bigint primary key,
    city        varchar(20)
);

insert into employees
values (1, 'Zharas Merekebaev', 'Data Engineer', '2023-10-23', 100000, 1),
       (2, 'Zharas Ospanovich', 'ML Engineer', '2022-08-01', 300000, 1),
       (3, 'Nursat Kulymzhanov', 'Data Scientist', '2023-02-01', 400000, 1),
       (4, 'Ulan Kozhabekov', 'Backend Developer', '2022-04-01', 500000, 2),
       (5, 'Ramazan Bauyrzhanuly', 'IOS Developer', '2023-11-15', 200000, 2),
       (6, 'Erzhan Ashimovich', 'Frontend Developer', '2023-09-01', 350000, 2),
       (7, 'Arai Kasymova', 'Product Designer', '2022-01-25', 450000, 3),
       (8, 'Zhanna Maratovna', 'UX/UI Designer', '2023-05-02', 250000, 3),
       (9, 'Arai Kairatovna', 'Senior Designer', '2023-06-18', 480000, 3);

insert into departments
values (1, 'Data', 1),
       (2, 'Development', 2),
       (3, 'Design', 3);

insert into locations
values (1, 'Astana'),
       (2, 'Almaty'),
       (3, 'Shymkent');

insert into jobs
values ('DE', 'Data Engineering'),
       ('DEV', 'Developing'),
       ('DES', 'Designing');

insert into job_history (employee_id, start_date, end_date, job_id, department_id)
values (1, '2023-10-23', '2024-11-25', 'DE', 1),
       (2, '2022-08-01', '2024-10-01', 'DE', 1),
       (3, '2023-02-01', '2024-04-15', 'DE', 1),
       (4, '2022-04-01', '2023-06-12', 'DEV', 2),
       (5, '2023-11-15', '2025-02-07', 'DEV', 2),
       (6, '2023-09-01', '2024-03-16', 'DEV', 2),
       (7, '2022-01-25', '2023-02-04', 'DES', 3),
       (8, '2023-05-02', '2024-05-03', 'DES', 3),
       (9, '2023-06-18', '2024-06-20', 'DES', 3);

-- Task 1
select full_name, salary, position from employees e
join departments d on e.department_id = d.department_id
where full_name like '%Zharas%' and d.department_name = 'Data';

-- Task 2
select d.department_name, avg(salary) from employees e
inner join departments d on d.department_id = e.department_id
group by department_name;

-- Task 3

SELECT e.position AS "Position",AVG(e.salary) AS "Average salary by position",
CASE
    WHEN AVG(e.salary) > (SELECT AVG(salary) FROM employees) THEN 'Yes'
    ELSE 'No'
END AS "More than average salary"
FROM employees e
GROUP BY e.position;
