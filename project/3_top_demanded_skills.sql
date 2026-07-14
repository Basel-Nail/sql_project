/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

select 
skills,
count(*) AS demand
from job_postings_fact j
    inner JOIN skills_job_dim sj ON sj.job_id = j.job_id
    inner join skills_dim s on s.skill_id = sj.skill_id
   WHERE job_title_short = 'Data Analyst' and job_work_from_home = 'True'
group by skills
ORDER BY demand DESC
limit 10

/*Another way
WITH remote_jobs AS (
    select *
    from job_postings_fact
    WHERE job_work_from_home = TRUE
    and job_title_short = 'Data Analyst'
)
select sj.skill_id,
    s.skills,
    count(j.job_id) num_of_jobs
from remote_jobs j
    inner JOIN skills_job_dim sj ON sj.job_id = j.job_id
    inner join skills_dim s on s.skill_id = sj.skill_id
GROUP BY sj.skill_id,
    s.skills
order by num_of_jobs DESC
limit 10;*/
