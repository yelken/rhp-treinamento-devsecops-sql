SET search_path TO hospital_data, public;

SELECT id, admitted_at
FROM admissions
WHERE date_trunc('day', admitted_at) = DATE '2025-01-01'
ORDER BY admitted_at;


