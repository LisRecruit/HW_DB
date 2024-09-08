WITH client_project_count AS (
    SELECT CLIENT_ID, COUNT(*) AS project_count
    FROM project
    GROUP BY CLIENT_ID
)
SELECT CLIENT_ID, project_count
FROM client_project_count
WHERE project_count = (
    SELECT MAX(project_count)
    FROM client_project_count
);