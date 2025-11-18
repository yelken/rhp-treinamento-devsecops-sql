SET search_path TO hospital_data, public;

-- TODO:
-- 1) Criar tabela hospital_data.lab_results_audit (...)

CREATE TABLE IF NOT EXISTS lab_results_audit (
    audit_id bigserial primary key,
    op text NOT NULL,
    actor text NOT NULL,
    changed_at timestamptz NOT NULL default now(),
    row_id int,
    before_json jsonb,
    after_json jsonb
);

CREATE OR REPLACE FUNCTION fn_lab_results_audit()
RETURNS trigger
LANGUAGE plpgsql
AS $$
BEGIN
    IF (TG_OP = 'INSERT') THEN
        INSERT INTO lab_results_audit(op, actor, row_id, before_json, after_json)
        VALUES ('INSERT', current_user, NEW.id, NULL, to_jsonb(NEW));
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO lab_results_audit(op, actor, row_id, before_json, after_json)
        VALUES ('UPDATE', current_user, NEW.id, to_jsonb(OLD), to_jsonb(NEW));
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO lab_results_audit(op, actor, row_id, before_json, after_json)
        VALUES ('DELETE', current_user, OLD.id, to_jsonb(OLD), NULL);
    END IF;
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_lab_results_audit ON lab_results;
CREATE TRIGGER trg_lab_results_audit AFTER INSERT OR UPDATE OR DELETE on lab_results
FOR EACH ROW EXECUTE FUNCTION fn_lab_results_audit();

-- 2) Criar função plpgsql que registra operação (TG_OP), usuário (current_user), timestamps e dados relevantes
-- 3) Criar trigger FOR EACH ROW em INSERT/UPDATE/DELETE


