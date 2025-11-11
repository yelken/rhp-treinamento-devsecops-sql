SET search_path TO hospital_data, public;

CREATE TABLE IF NOT EXISTS lab_results_audit (
    audit_id bigserial PRIMARY KEY,
    op text NOT NULL,
    actor text NOT NULL,
    changed_at timestamptz NOT NULL DEFAULT now(),
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
        INSERT INTO lab_results_audit (op, actor, row_id, before_json, after_json)
        VALUES ('INSERT', current_user, NEW.id, NULL, to_jsonb(NEW));
        RETURN NEW;
    ELSIF (TG_OP = 'UPDATE') THEN
        INSERT INTO lab_results_audit (op, actor, row_id, before_json, after_json)
        VALUES ('UPDATE', current_user, NEW.id, to_jsonb(OLD), to_jsonb(NEW));
        RETURN NEW;
    ELSIF (TG_OP = 'DELETE') THEN
        INSERT INTO lab_results_audit (op, actor, row_id, before_json, after_json)
        VALUES ('DELETE', current_user, OLD.id, to_jsonb(OLD), NULL);
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$;

DROP TRIGGER IF EXISTS trg_lab_results_audit ON lab_results;
CREATE TRIGGER trg_lab_results_audit
AFTER INSERT OR UPDATE OR DELETE ON lab_results
FOR EACH ROW
EXECUTE FUNCTION fn_lab_results_audit();


