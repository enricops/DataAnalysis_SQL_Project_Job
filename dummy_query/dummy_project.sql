/* REVISI PROJECT NOMOR 5
///////////////////////////////////////////////////////////////////////////////// VERSI 1 MASIH BANYAK BUG HASIL AMBURADUL; sudah dirubah dan berhasil running tapi perlu dirapihkan kembali
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS demand_count
    FROM 
        job_postings_fact
    JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND
        salary_year_avg IS NOT NULL OR
        job_title_short = 'Business Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_title_short = 'Data Analyst' AND 
        salary_year_avg IS NOT NULL OR
        job_title_short = 'Business Analyst' AND
        salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
///////////////////////////////////////////////////////////////////////////////// VERSI 2 SUDAH OPTIMAL DAN HASIL RUNNING SUDAH TIDAK ADA BUG DAN BERJALAN DENGAN LANCAR
WITH skills_demand AS (
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(job_postings_fact.job_id) AS demand_count
    FROM 
        job_postings_fact
    JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst')
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_dim.skill_id
), average_salary AS (
    SELECT 
        skills_job_dim.skill_id,
        ROUND(AVG(salary_year_avg), 0) AS avg_salary
    FROM 
        job_postings_fact
    JOIN 
        skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    JOIN 
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst')
        AND salary_year_avg IS NOT NULL
    GROUP BY 
        skills_job_dim.skill_id
)

SELECT
    skills_demand.skill_id,
    skills_demand.skills,
    demand_count,
    avg_salary
FROM
    skills_demand
JOIN
    average_salary ON skills_demand.skill_id = average_salary.skill_id
WHERE
    demand_count > 10
ORDER BY 
    avg_salary DESC;
///////////////////////////////////////////////////////////////////////////////// VERSI 3 SUDAH DI IMPROVISASI DAN DITINGKATKAN MENJADI LEBIH SINGKAT DAN EFISIEN
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
ORDER BY avg_salary DESC;
*/
