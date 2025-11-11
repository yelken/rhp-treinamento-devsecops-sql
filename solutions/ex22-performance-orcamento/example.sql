SET search_path TO hospital_data, public;

-- Exemplo: medir e otimizar
EXPLAIN ANALYZE
SELECT
    id,
    admitted_at
FROM admissions
WHERE admitted_at >= current_date - INTERVAL '7 days'
ORDER BY admitted_at DESC;

-- Orçamento sugerido:
-- - Tempo total < 200 ms em ambiente local
-- - Rows lidas < 10k (ajuste conforme volume)


