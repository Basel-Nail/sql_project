/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/


with skills_demand as(
select 
s.skill_id,
s.skills,
count(*) AS demand
from job_postings_fact j
    inner JOIN skills_job_dim sj ON sj.job_id = j.job_id
    inner join skills_dim s on s.skill_id = sj.skill_id
   WHERE job_title_short = 'Data Analyst' 
   and job_work_from_home = 'True'
   AND salary_year_avg is not null
group by s.skill_id,s.skills), 

average_salary as(
select 
s.skill_id,
s.skills,
Round(Avg(salary_year_avg),0) average_salary_per_skill
from job_postings_fact j
    inner JOIN skills_job_dim sj ON sj.job_id = j.job_id
    inner join skills_dim s on s.skill_id = sj.skill_id
   WHERE job_title_short = 'Data Analyst'
   AND salary_year_avg is not null 
   and job_work_from_home = 'True'
group by s.skill_id,s.skills)

select skills_demand.skill_id,
    skills_demand.skills,
    demand,
    average_salary_per_skill from skills_demand
inner JOIN average_salary 
on 
skills_demand.skill_id = average_salary.skill_id
ORDER BY demand desc,average_salary_per_skill DESC
limit 10;