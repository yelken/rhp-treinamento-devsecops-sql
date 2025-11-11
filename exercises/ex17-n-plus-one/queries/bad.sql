SET search_path TO hospital_data, public;

-- Último resultado de exame por paciente (ineficiente)
SELECT
  p.id,
  (SELECT lr.test_name
   FROM lab_results lr
   WHERE lr.patient_id = p.id
   ORDER BY lr.result_date DESC
   LIMIT 1) AS last_test_name
FROM patients p
ORDER BY p.id;


