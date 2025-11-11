SET search_path TO hospital_data, public;

SELECT id, full_name, department_id
FROM patients
ORDER BY id DESC;


