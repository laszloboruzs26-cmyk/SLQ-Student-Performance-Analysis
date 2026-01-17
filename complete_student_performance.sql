------------------------------------------------------------
--- EXPLORATORY DATA ANALYSIS
------------------------------------------------------------

-- view dataste - load data --

select *
from "StudentsPerformance";

-- we have all 8 columns 

select *
from "StudentsPerformance"
limit 10;

-- we can limit the  number of rows we see each time usefull for large datasets 


----------------------------
-- 1. Basic Inspection --

----------------------------


--  number of students within the database --

SELECT COUNT(*) AS no_of_students 
FROM "StudentsPerformance";

-- The number of students in the database is 1000, one student per row; 
-- this is discounting column headers 


-- Show distinct values: gender distribution --

SELECT *
FROM "StudentsPerformance"
WHERE gender LIKE 'female';

-- shows we have 518 female students out of the 1000 


SELECT *
FROM "StudentsPerformance"
WHERE gender LIKE 'male';


-- shows we have 482 male students out of the 1000 
-- conclusion: there are no null or NA values in the gender column 


-- student with standard lunch --

select *
FROM "StudentsPerformance"
WHERE lunch LIKE 'standard';

-- student with standard lunch fees 645 from 1000 


-- student with free lunch

select *
FROM "StudentsPerformance"
WHERE lunch LIKE 'free/reduced';

-- student with free lunch 355 from 1000 
-- conclusion: there are no null or NA values in the lunch column, also, we have more students
-- standard lunch fees, then free lunches

-- student test preparation 

select *
FROM "StudentsPerformance"
WHERE test_preparation_course LIKE 'completed';

-- 358 students completed the test preparation course 


select *
FROM "StudentsPerformance"
WHERE test_preparation_course LIKE 'none';

-- 642 students did not "none" complete the test preparation course --
-- Conclusion have a lower number of students completed the test preparation  
-- later we will show how this affects overall grades


----------------------------
-- 2. Performance metrics --

----------------------------

-- average math score ---

select AVG(math_score) as student_average_math_score
FROM "StudentsPerformance";

-- Average math score per 1000 students is 66.08 


-- average reading score --

select AVG(reading_score) as student_average_reading_score
FROM "StudentsPerformance";

-- Average reading score per 1000 students is 69.16 


-- average writing score --

select AVG(writing_score) as student_average_writing_score
FROM "StudentsPerformance";

-- Average writing score per 1000 students is 68.05 


-- average total score --

SELECT
  AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
FROM "StudentsPerformance";

-- average total score per all students is 67.77 

-- average total score per each student/ row --

SELECT
  math_score,
  reading_score,
  writing_score,
  (math_score + reading_score + writing_score) AS total_score
FROM students;

-- shows averages per line 



----------------------------
-- 3. Group analysis --

----------------------------

--  Average scores by gender --

Select gender, AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
from "StudentsPerformance"
WHERE gender LIKE 'female'
Group BY gender;

-- Overall average for female students is 69.56 

Select gender, AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
from "StudentsPerformance"
WHERE gender LIKE 'male'
Group BY gender;


-- Overall average for male students is 65.83
-- conclusion overall female scores are better 


-- Average scores by lunch type --
-- Average scores by lunch type standard --

Select lunch, AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
from "StudentsPerformance"
WHERE lunch LIKE 'standard'
Group BY lunch;

-- Average scores by standard lunch is 70.83 

-- Average scores by lunch type free --

Select lunch, AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
from "StudentsPerformance"
WHERE lunch LIKE 'free/reduced'
Group BY lunch;

-- Average scores by free lunch is 62.19
-- Conclusion studnets on standard lunch fees perform better


-- Average scores by test preparation course --
-- Average scores by test preparation course completed -- 

Select test_preparation_course, AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
from "StudentsPerformance"
WHERE test_preparation_course LIKE 'completed'
Group BY test_preparation_course;

-- test preparation completed, scored 72.66

-- Average scores by test preparation course none -- 

Select test_preparation_course, AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
from "StudentsPerformance"
WHERE test_preparation_course LIKE 'none'
Group BY test_preparation_course;

-- test preparation score 65.03 
-- Conclusion: Meaning that students with better preparation achieve better grades


----------------------------
-- 4. Feature engineering --

----------------------------


-- calculate score band for overall average dataset --

 SELECT
  overall_avg_score,
  CASE
    WHEN overall_avg_score >= 80 THEN 'High'
    WHEN overall_avg_score >= 60 THEN 'Medium'
    ELSE 'Low'
  END AS overall_avg_score_band
FROM (
  SELECT
    AVG((math_score + reading_score + writing_score) / 3.0) AS overall_avg_score
  FROM "StudentsPerformance"
);

-- Conclusion: Our overall average score is 67.77, making it an overall Medium on our score band


-- calculate score band for each student -- 

SELECT
  math_score,
  reading_score,
  writing_score,
  (math_score + reading_score + writing_score) / 3.0 AS avg_score,
  CASE
    WHEN (math_score + reading_score + writing_score) / 3.0 >= 80 THEN 'High'
    WHEN (math_score + reading_score + writing_score) / 3.0 >= 60 THEN 'Medium'
    ELSE 'Low'
  END AS student_performance_band
FROM "StudentsPerformance";

-- calculate score band for all 1000 students 



----------------------------
-- 5. Ranking --

----------------------------


-- Rank each student's total score --

SELECT
 math_score,
 reading_score,
 writing_score,
  (math_score + reading_score + writing_score) AS total_score,
  RANK() over (
         order by (math_score + reading_score + writing_score) DESC 
         )
         as score_rank
FROM "StudentsPerformance";

-- Conclusion: Ranked each student's total score; score rank 1 equals the best total score overall 
-- 1000 equals the worst score overall.

-- per gender score --

SELECT
  gender,
  (math_score + reading_score + writing_score) AS total_score,
  RANK() OVER (
    PARTITION BY gender
    ORDER BY (math_score + reading_score + writing_score) DESC
  ) AS gender_rank
FROM "StudentsPerformance";

-- per gender scores for male and female 

----------------------------
-- 6. Business insight --

----------------------------

-- Do students who completed the test preparation course perform better on average? --

SELECT
  test_preparation_course,
  (math_score + reading_score + writing_score) AS total_score,
  RANK() OVER (
    PARTITION BY test_preparation_course
    ORDER BY (math_score + reading_score + writing_score) DESC
  ) AS preparation_rank
FROM "StudentsPerformance";

-- Overall conclusion yes, students who did partake in the preparation course performed on average better then their classmates who didn't.

