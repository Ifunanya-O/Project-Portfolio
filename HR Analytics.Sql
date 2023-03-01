/* Skills used: Joins,
  CTE,
  Windows Functions,Subqueries,
  Aggregate Functions, 
  Converting DATA Types,
  CASE statement 
  Tool used: Google BigQuery */
  
SELECT
  *
FROM
  `fiery-azimuth-376322.HR_Data.Employee File`; 
  
  /*Various data of exited employees*/
SELECT
  emp_no,
  job_role,
  monthly_income,
  job_involvement,
  years_at_company,
  years_in_current_role
FROM
  `fiery-azimuth-376322.HR_Data.Employee File`
WHERE
  Attrition = TRUE; 
  
  /*Total NO OF Employees,
  NO OF Exited Employees,
  NO OF Employees still IN the Company,
  Average Age OF ALL Employees,
  Attrition Rate;
  This was later used FOR visualization
   on Tableau*/
WITH
  Employee_Records AS (
  SELECT
    COUNT(*) AS Total_Employee_Count,
    SUM (CASE
        WHEN Attrition = TRUE THEN 1
      ELSE
      0
    END
      ) AS Attrition_Count,
    SUM (CASE
        WHEN Attrition = FALSE THEN 1
      ELSE
      0
    END
      ) AS Active_Employees,
    ROUND(AVG(age),0) AS Avg_Age
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`)
SELECT
  *,
  ROUND((Attrition_Count/Total_Employee_Count),4) AS Attrition_Rate
FROM
  Employee_Records; 
  
  /*Total employee count,
  Exited employee count,
  average employee age,
  attrition rate FOR male employees */
WITH
  Male_Employee_Records AS (
  SELECT
    COUNT(*) AS Male_Employees,
    SUM (CASE
        WHEN Attrition = TRUE THEN 1
      ELSE
      0
    END
      ) AS Male_Attr_Count,
    SUM (CASE
        WHEN Attrition = FALSE THEN 1
      ELSE
      0
    END
      ) AS Active_Male_Emp,
    ROUND(AVG(age),0) AS Male_Avg_Age
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    LOWER(Gender) = 'male')
SELECT
  *,
  ROUND((Male_Attr_Count/Male_Employees *100),2) AS Male_Attr_Rate
FROM
  Male_Employee_Records; 
  
  /*Total Number OF male employees,
  Exited male employees count,
  average OF female employees*/
WITH
  Female_Employee_Records AS (
  SELECT
    COUNT(*) AS Female_Employees,
    SUM (CASE
        WHEN Attrition = TRUE THEN 1
      ELSE
      0
    END
      ) AS Female_Attr_Count,
    SUM (CASE
        WHEN Attrition = FALSE THEN 1
      ELSE
      0
    END
      ) AS Active_Female_Emp,
    ROUND(AVG(age),0) AS Female_Avg_Age
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    LOWER(Gender) = 'female')
SELECT
  *,
  ROUND((Female_Attr_Count/Female_Employees *100),2) AS Female_Attr_Rate
FROM
  Female_Employee_Records; 
  
  /*Attrition Count OF Male
  AND Female employees respectively;
  This was later used FOR visualization
   on Tableau*/
SELECT
  COUNT(*) AS male_attr_count,
  (
  SELECT
    COUNT(*)
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    Attrition = TRUE
    AND LOWER(Gender) = 'female') AS female_attr_count
FROM
  `fiery-azimuth-376322.HR_Data.Employee File`
WHERE
  Attrition = TRUE
  AND LOWER(Gender) = 'male'; 
  
  /*Attrition Count BY Department,
  NO OF employees that have LEFT
  FROM each department;
  This was later used FOR visualization
   on Tableau*/
SELECT
  COUNT(*) AS HR_Attrition,
  (
  SELECT
    COUNT(*)
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    Attrition = TRUE
    AND LOWER(department) = 'r&d') AS RD_Attrition,
  (
  SELECT
    COUNT(*)
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    Attrition = TRUE
    AND LOWER(department) = 'sales') AS Sales_Attrition
FROM
  `fiery-azimuth-376322.HR_Data.Employee File`
WHERE
  Attrition = TRUE
  AND LOWER(department) = 'hr'; 
  
  /*Shows the No of employees for each age;
  This was later used FOR visualization
   on Tableau*/
SELECT
  a.age,
  COUNT(age) AS employees_by_age
FROM (
  SELECT
    age,
    ROW_NUMBER() OVER (PARTITION BY age) AS row_num
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`) AS a
GROUP BY
  a.age
ORDER BY
  a.age ASC; 
  
  /*NO OF employees FOR each age,
  grouped further BY gender*/
SELECT
  *
FROM (
  SELECT
    a.age,
    a.gender,
    COUNT(age) AS maleemp_by_age
  FROM (
    SELECT
      age,
      gender,
      ROW_NUMBER() OVER w
    FROM
      `fiery-azimuth-376322.HR_Data.Employee File`
    WHERE
      LOWER(Gender) = 'male'
    WINDOW
      w AS (
      PARTITION BY
        age) ) AS a
  GROUP BY
    a.age,
    a.gender
  ORDER BY
    a.age ASC) AS m
JOIN (
  SELECT
    a2.age,
    a2.gender,
    COUNT(age) AS femaleemp_by_age
  FROM (
    SELECT
      age,
      gender,
      ROW_NUMBER() OVER w
    FROM
      `fiery-azimuth-376322.HR_Data.Employee File`
    WHERE
      LOWER(Gender) = 'female'
    WINDOW
      w AS (
      PARTITION BY
        age) ) AS a2
  GROUP BY
    a2.age,
    a2.gender
  ORDER BY
    a2.age ASC) AS f
ON
  m.age = f.age
WHERE
  m.age = f.age
ORDER BY
  m.age; 
  
  /*NO OF exited employees FOR each ageband,
  grouped further BY gender;
  This was later used FOR visualization
   on Tableau*/
SELECT *,
  ROW_NUMBER() OVER (PARTITION BY a.gender)
FROM (
  SELECT
    CF_age_band,
    gender,
    COUNT(CF_age_band) AS maleemp_by_ageband,
    FROM
      `fiery-azimuth-376322.HR_Data.Employee File`
    WHERE Attrition = TRUE AND
    LOWER(Gender) = 'male'
    GROUP BY CF_age_band, gender) AS a
JOIN (
  SELECT
    CF_age_band,
    gender,
    COUNT(CF_age_band) AS femaleemp_by_ageband,
    FROM
      `fiery-azimuth-376322.HR_Data.Employee File`
    WHERE Attrition = TRUE AND
    LOWER(Gender) = 'female'
    GROUP BY CF_age_band, gender) AS a2
ON
  a.CF_age_band = a2.CF_age_band
WHERE
  a.CF_age_band = a2.CF_age_band
ORDER BY
  a.CF_age_band; 
   
  /*No of Exited Employees 
  by their level of education*/
SELECT
  a.education,
  COUNT(education) AS attr_by_education
FROM (
  SELECT
    education,
    ROW_NUMBER() OVER (PARTITION BY education)
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    Attrition = TRUE) AS a
GROUP BY
  a.education
ORDER BY
  a.education; 
  
  /*No of exited employees per job role 
  and job satisfaction level;
  This was later used FOR visualization
   on Tableau*/
SELECT
  a.job_role,
  a.job_satisfaction,
  COUNT(job_satisfaction) AS jobsatisfaction_count
FROM (
  SELECT
    job_role,
    job_satisfaction,
    ROW_NUMBER() OVER (PARTITION BY job_satisfaction) AS row_num
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    Attrition = TRUE) AS a
GROUP BY
  job_role,
  job_satisfaction
ORDER BY
  job_role,
  job_satisfaction;

 /*No of exited employees per commute_distance;
 This was later used FOR visualization
   on Tableau*/
SELECT
  a.distance_from_home,
  COUNT(distance_from_home) AS employeecommute_count
FROM (
  SELECT
    distance_from_home,
    ROW_NUMBER() OVER (PARTITION BY distance_from_home) AS row_num
  FROM
    `fiery-azimuth-376322.HR_Data.Employee File`
  WHERE
    Attrition = TRUE) AS a
GROUP BY
  distance_from_home
ORDER BY
  employeecommute_count DESC;