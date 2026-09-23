# Introduction

SOON!!!

# Background

SOON!!!

Data hails from my [SQL Course](https://www.lukebarousse.com/sql). It's packed with insights on job titles, salaries, location, and essential skills.


### The questions I wanted to answer through my SQL queries were :

1. What are the top paying data analyst jobs and business analyst?
2. What skills are required for this top paying jobs?
3. What skills are most in demand for data analyst and business analyst?
4. Which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Used

SOON!!!

- **SQL :** SOON!!!
- **PostgreSQL :** SOON!!!
- **Visual Studio Code :** SOON!!!
- **Git & Github :** SOON!!!
# The Analysis

SOON!!!

### 1. Top paying data analyst jobs and business analyst

SOON!!!

```sql
SELECT 
    job_id,
    job_title,
    name AS company_name,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date
FROM
    job_postings_fact
LEFT JOIN
    company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst')
    AND job_location = 'Anywhere'
    AND salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT
    10;
```

SOON!!!

![Top Paying Roles]().

SOON!!!

### 2. Skills required for this top paying jobs

SOON!!!

```sql
WITH top_paying_jobs AS (
    SELECT 
        job_id,
        job_title,
        name AS company_name,
        salary_year_avg
    FROM
        job_postings_fact
    LEFT JOIN
        company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE
        (job_title_short = 'Data Analyst' OR job_title_short = 'Business Analyst')
        AND job_location = 'Anywhere'
        AND salary_year_avg IS NOT NULL
    ORDER BY
        salary_year_avg DESC
    LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM 
    top_paying_jobs
JOIN 
    skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id  
ORDER BY
    salary_year_avg DESC;

```

SOON!!!

![Top company skill count](assets\Skill_Count.png)

SOON!!!

### 3. Most in demand skills for data analyst and business analyst

SOON!!!

```sql
SELECT 
    skills,
    COUNT(job_postings_fact.job_id) AS demand_count
FROM 
    job_postings_fact
JOIN 
    skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
JOIN 
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    job_title_short = 'Data Analyst' OR
    job_title_short = 'Business Analyst'
GROUP BY 
    skills
ORDER BY
    demand_count DESC
LIMIT 5;
```

SOON!!!

![Top demanded skills]()

SOON!!!
### 4. Skills that are associated with higher salaries

SOON!!!

```sql
SELECT 
    skills,
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
    skills
ORDER BY
    avg_salary DESC
LIMIT 25;
```

SOON!!!

![Top paying skills]()

SOON!!!

### 5. The most optimal skills to learn

SOON!!!

```sql
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
```

SOON!!!

![Top optimal skills]()

SOON!!!

# What I Learned

SOON!!!

# Conclusion

SOON!!!

### Insight

SOON!!!

### Closing Thoughts

SOON!!!
