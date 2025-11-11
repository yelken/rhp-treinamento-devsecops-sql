-- Habilitar (se permitido no ambiente)
CREATE EXTENSION IF NOT EXISTS pg_stat_statements;

-- Top 5 por tempo total
SELECT
    query,
    calls,
    total_exec_time,
    mean_exec_time
FROM pg_stat_statements
ORDER BY total_exec_time DESC
LIMIT 5;

-- Top 5 por média
SELECT
    query,
    calls,
    total_exec_time,
    mean_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 5;


