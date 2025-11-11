SET search_path TO hospital_data, public;

-- TODO: criar vw_patients_anon
-- 1) pseudônimo = digest(id || salt, 'sha256')
-- 2) idade por faixas: 0-12, 13-17, 18-39, 40-64, 65+


