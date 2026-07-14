/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/


select 
skills,
Round(Avg(salary_year_avg),0) average_salary_per_skill
from job_postings_fact j
    inner JOIN skills_job_dim sj ON sj.job_id = j.job_id
    inner join skills_dim s on s.skill_id = sj.skill_id
   WHERE job_title_short = 'Data Analyst'
   AND salary_year_avg is not null 
   --and job_work_from_home = 'True'
group by skills
ORDER BY average_salary_per_skill DESC
limit 10