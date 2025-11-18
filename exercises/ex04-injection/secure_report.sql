SET search_path TO hospital_data, public;

CREATE OR REPLACE FUNCTION report_patients(order_by TEXT)
RETURNS TABLE (id INT, full_name TEXT, department_id INT)
LANGUAGE plpgsql
AS $$
DECLARE
    order_sql TEXT;
BEGIN
    order_sql := CASE lower(order_by)
        WHEN 'id' THEN 'id'
        WHEN 'full_name' THEN 'full_name'
        WHEN 'department_id' THEN 'department_id'
        ELSE 'id'
    END; 

    RETURN QUERY EXECUTE format(
        'SELECT id, 
                full_name, 
                department_id 
        FROM hospital_data.patients 
        ORDER BY %I'
    , order_by);
END;
$$;


