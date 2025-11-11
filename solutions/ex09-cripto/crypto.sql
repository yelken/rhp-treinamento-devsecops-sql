SET search_path TO hospital_data, public;

-- Exemplo: nova coluna criptografada para não perder dados originais imediatamente
ALTER TABLE patients ADD COLUMN IF NOT EXISTS phone_enc bytea, ADD COLUMN IF NOT EXISTS ssn_enc bytea;

-- Funções utilitárias
CREATE OR REPLACE FUNCTION set_encrypted_phone(p_id int, p_plain text)
RETURNS void
LANGUAGE plpgsql
AS $$
DECLARE
    k text := current_setting('app.encryption_key', true);
BEGIN
    IF k IS NULL THEN
        RAISE EXCEPTION 'Defina app.encryption_key na sessão.';
    END IF;
    UPDATE patients
    SET phone_enc = pgp_sym_encrypt(p_plain, k)
    WHERE id = p_id;
END;
$$;

CREATE OR REPLACE FUNCTION get_decrypted_phone(p_id int)
RETURNS text
LANGUAGE plpgsql
AS $$
DECLARE
    k text := current_setting('app.encryption_key', true);
    v text;
BEGIN
    IF k IS NULL THEN
        RAISE EXCEPTION 'Defina app.encryption_key na sessão.';
    END IF;
    SELECT pgp_sym_decrypt(phone_enc, k) INTO v
    FROM patients WHERE id = p_id;
    RETURN v;
END;
$$;

-- Migrar dados existentes (exemplo: phone e ssn)
DO $$
DECLARE
    k text := current_setting('app.encryption_key', true);
BEGIN
    IF k IS NULL THEN
        RAISE EXCEPTION 'Defina app.encryption_key = ''sua_chave_segura'' na sessão antes da migração.';
    END IF;
    UPDATE patients
    SET phone_enc = CASE WHEN phone IS NOT NULL THEN pgp_sym_encrypt(phone, k) ELSE NULL END,
        ssn_enc = CASE WHEN ssn IS NOT NULL THEN pgp_sym_encrypt(ssn, k) ELSE NULL END;
END;
$$;


