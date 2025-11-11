SET search_path TO hospital_data, public;

-- Índice recomendado (execute uma vez)
CREATE INDEX IF NOT EXISTS idx_patients_department_id
ON patients (department_id);

SELECT
    id,
    department_id
FROM patients
WHERE department_id = 1
ORDER BY id DESC;


