SET search_path TO hospital_data, public;

BEGIN;
SELECT id, test_name, result_date
FROM lab_results
WHERE result_date >= current_date - INTERVAL '3 days'
FOR UPDATE;
COMMIT;


