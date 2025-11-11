SET search_path TO hospital_data, public;

SELECT *
FROM patients p
JOIN admissions a ON a.patient_id = p.id
ORDER BY a.admitted_at DESC;


