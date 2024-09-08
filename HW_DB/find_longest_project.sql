WITH project_durations AS (
    SELECT ID, CLIENT_ID, START_DATE, FINISH_DATE, 
           EXTRACT(YEAR FROM AGE(FINISH_DATE, START_DATE)) * 12 +
           EXTRACT(MONTH FROM AGE(FINISH_DATE, START_DATE)) AS duration_months
    FROM project
)
SELECT ID, CLIENT_ID, START_DATE, FINISH_DATE, duration_months
FROM project_durations
WHERE duration_months = (
    SELECT MAX(duration_months)
    FROM project_durations
);