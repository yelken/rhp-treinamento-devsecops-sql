SET search_path TO hospital_data, public;

WITH MATERIALIZED lr_all AS (
  SELECT * FROM lab_results
)
SELECT *
FROM lr_all
WHERE result_date >= current_date - INTERVAL '7 days';


