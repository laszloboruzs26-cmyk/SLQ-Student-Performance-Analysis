# SQL Data Science Task — Student Performance Analysis
SLQ Student Performance Analysis - demonstrates skills




## Project Description
This project analyses student academic performance using SQL to understand how demographic factors and test preparation influence outcomes.  
The work demonstrates practical SQL skills through exploratory analysis, aggregation, feature engineering, ranking, and business insight generation using a single public dataset.

The project is designed to reflect real-world data analyst workflows, focusing on clear logic, reproducible queries, and business-relevant conclusions.




## Objectives
The main goals of this project are to:

- Inspect and validate the structure of the dataset
- Analyse overall academic performance
- Examine the impact of demographic and socioeconomic factors
- Segment students into performance bands
- Rank students based on academic outcomes
- Answer business-driven questions using SQL




## Dataset
**Original dataset (public source):**  
**Students Performance Dataset – Kaggle**  
https://www.kaggle.com/datasets/spscientist/students-performance-in-exams

The dataset contains **1,000 student records**, with the following columns:

- `gender`
- `race_ethnicity`
- `parental_level_of_education`
- `lunch`
- `test_preparation_course`
- `math_score`
- `reading_score`
- `writing_score`

Each row represents one student, and all scores range from **0 to 100**.




## Tools & Technologies
- SQL — core analysis language
- DuckDB / SQLite / SQL execution engine
- CSV — data source format
- SQL editor / text editor




## Key Findings
- Students who completed the test preparation course achieved higher average scores
- Students with standard lunch outperformed those with free/reduced lunch
- Female students achieved slightly higher overall average scores than male students
- Most students fall into the Medium performance band, with fewer in High and Low bands




## Recommendations
Based on the analysis:

- Expand access to test preparation programs, as they show a strong positive impact on academic performance
- Provide additional academic support for students receiving free/reduced lunch
- Use performance band segmentation to target interventions for low-performing students
- Continue monitoring demographic performance differences to support equitable outcomes
