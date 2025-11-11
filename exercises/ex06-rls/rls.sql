SET search_path TO hospital_data, public;

-- TODO:
-- 1) ALTER TABLE patients ENABLE ROW LEVEL SECURITY;
-- 2) Criar policy que verifica se o departamento do current_user (em hospital_data.users)
--    bate com o department_id do paciente.
-- 3) Política apenas para SELECT para role report_reader.


