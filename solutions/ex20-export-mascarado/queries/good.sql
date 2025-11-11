SET search_path TO hospital_data, public;

-- Export seguro (exemplo de seleção sem PII)
-- COPY (
--   SELECT id, department_id FROM vw_patients_masked
-- ) TO '/tmp/patients_masked.csv' CSV HEADER;

-- Alternativa sem depender da view:
-- COPY (
--   SELECT id, department_id FROM patients
-- ) TO '/tmp/patients_masked.csv' CSV HEADER;


