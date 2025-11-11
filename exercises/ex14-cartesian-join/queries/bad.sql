SET search_path TO hospital_data, public;

-- Falta o predicado de join entre patients e admissions
SELECT COUNT(*)
FROM patients p, admissions a
WHERE a.department_id = 1;


