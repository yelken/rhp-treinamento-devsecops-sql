SET search_path TO hospital_data, public;

-- Índice recomendado (execute uma vez)
CREATE INDEX IF NOT EXISTS idx_admissions_admitted_at
ON admissions (admitted_at);

SELECT
    id,
    admitted_at
FROM admissions
WHERE
    admitted_at >= DATE '2025-01-01'
    AND admitted_at < DATE '2025-01-02'
ORDER BY
    admitted_at;


