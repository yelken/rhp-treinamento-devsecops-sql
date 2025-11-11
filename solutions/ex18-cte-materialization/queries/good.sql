SET search_path TO hospital_data, public;

-- Remover materialização e filtrar cedo
WITH lr_filtered AS (
    SELECT
        id,
        patient_id,
        test_name,
        result_date
    FROM lab_results
    WHERE result_date >= current_date - INTERVAL '7 days'
)

SELECT *
FROM lr_filtered;


