SET search_path TO hospital_data, public;

-- NÃO USE EM PRODUÇÃO: vulnerável (exercício para corrigir)
CREATE OR REPLACE FUNCTION report_patients(order_by TEXT)
RETURNS TABLE (id INT, full_name TEXT, department_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT id, full_name, department_id FROM hospital_data.patients ORDER BY ' || order_by;
END;
$$;


