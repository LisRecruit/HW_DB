WITH project_durations AS (
    SELECT p.ID AS project_id, 
           EXTRACT(YEAR FROM AGE(p.FINISH_DATE, p.START_DATE)) * 12 +
           EXTRACT(MONTH FROM AGE(p.FINISH_DATE, p.START_DATE)) AS duration_months
    FROM project p
),
project_costs AS (
    SELECT p.ID AS project_id, 
           SUM(w.SALARY) * pd.duration_months AS project_cost
    FROM project p
    JOIN project_worker pw ON p.ID = pw.PROJECT_ID
    JOIN worker w ON pw.WORKER_ID = w.ID
    JOIN project_durations pd ON p.ID = pd.project_id
    GROUP BY p.ID, pd.duration_months
)
SELECT p.ID, p.CLIENT_ID, pc.project_cost
FROM project p
JOIN project_costs pc ON p.ID = pc.project_id
ORDER BY pc.project_cost DESC;