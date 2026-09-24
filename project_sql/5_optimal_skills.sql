WITH skill_stats AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS demand_count,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
    JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst')
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
)
SELECT *
FROM skill_stats
WHERE demand_count > 10
ORDER BY avg_salary DESC
LIMIT 20;