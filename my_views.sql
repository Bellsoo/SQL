


-- Vue ALL_WORKERS

CREATE OR REPLACE VIEW ALL_WORKERS AS
SELECT last_name, first_name, age, first_day AS start_date
FROM WORKERS_FACTORY_1
WHERE last_day IS NULL
UNION ALL
SELECT last_name, first_name, NULL AS age, start_date
FROM WORKERS_FACTORY_2
WHERE end_date IS NULL
ORDER BY start_date DESC;


-- Vue ALL_WORKERS_ELAPSED

CREATE OR REPLACE VIEW ALL_WORKERS_ELAPSED AS
SELECT last_name, first_name, SYSDATE - start_date AS days_elapsed
FROM ALL_WORKERS;


-- Vue BEST_SUPPLIERS 

CREATE OR REPLACE VIEW BEST_SUPPLIERS AS
SELECT s.name, SUM(sb.quantity) AS total_quantity
FROM SUPPLIERS s
JOIN SUPPLIERS_BRING_TO_FACTORY_1 sb ON s.supplier_id = sb.supplier_id
GROUP BY s.name
HAVING SUM(sb.quantity) > 1000
ORDER BY SUM(sb.quantity) DESC;


-- Vue ROBOTS_FACTORIES

CREATE OR REPLACE VIEW ROBOTS_FACTORIES AS
SELECT r.model, f.main_location
FROM ROBOTS r
JOIN ROBOTS_FROM_FACTORY rf ON r.id = rf.robot_id
JOIN FACTORIES f ON rf.factory_id = f.id;
