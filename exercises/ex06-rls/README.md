# Ex06 — Row-Level Security (RLS) por departamento

## Objetivo
Aplicar RLS em `patients` para que leitores de relatório só vejam pacientes do próprio departamento.

## O que é RLS (Row-Level Security)?
RLS é um controle de acesso no próprio banco que filtra linhas automaticamente com base em políticas. Diferente de `GRANT`, que decide “se pode SELECT na tabela”, o RLS decide “quais linhas o usuário enxerga quando faz SELECT”.

- Sem RLS: permissões são por objeto (tabela, view).
- Com RLS: além da permissão de objeto, o banco aplica políticas por linha (ex.: “só linhas do seu departamento”).

Quando usar: quando o mesmo objeto (tabela/view) precisa servir dados diferentes a usuários diferentes, sem que a aplicação tenha que filtrar manualmente.

## Passos
1. Habilite RLS em `hospital_data.patients`.
2. Crie política baseada no `current_user` (associado a uma linha em `users`).
3. Use `SET SESSION AUTHORIZATION` para simular usuários.

## Critério de aceite
- `report_cli_med` só enxerga pacientes de Clínica Médica.
- `report_cir` só enxerga pacientes de Cirurgia.

## Dicas
- Veja `solutions/ex06-rls/rls.sql`.

## Exemplo de construção (passo a passo)
Siga a lógica abaixo (resumo didático — a implementação completa está na solução):

1) Ativar RLS na tabela:
```sql
ALTER TABLE hospital_data.patients ENABLE ROW LEVEL SECURITY;
```

2) Ligar o `current_user` a um departamento (este repo usa a tabela `hospital_data.users`):
```sql
-- Opcional: uma view que resolve o departamento do usuário logado
CREATE OR REPLACE VIEW hospital_data.current_user_department AS
SELECT u.username, u.department_id
FROM hospital_data.users u
WHERE u.username = current_user;
```

3) Criar a policy que filtra por departamento do usuário:
```sql
DROP POLICY IF EXISTS patient_rls_policy ON hospital_data.patients;
CREATE POLICY patient_rls_policy
ON hospital_data.patients
FOR SELECT
TO report_reader
USING (
  department_id = (SELECT department_id FROM hospital_data.current_user_department)
);
```

Observações:
- A policy é aplicada somente se o usuário também tiver `SELECT` na tabela (ou view) e `USAGE` no schema.
- Você pode criar políticas diferentes para `SELECT`, `INSERT`, `UPDATE`, `DELETE`.

## Como validar rapidamente
1) Garanta que os usuários lógicos existem na tabela `hospital_data.users` (já seeds em `db/init/02_seed.sql`). Exemplos: `report_cli_med` (Clínica Médica), `report_cir` (Cirurgia).
2) Garanta que o role `report_reader` exista e que o usuário simulado o possua (veja Ex05).
3) Simule a sessão do usuário e rode a consulta:
```sql
-- como superuser/dono, para simular identidade do usuário:
SET SESSION AUTHORIZATION report_cli_med;
SELECT id, department_id FROM hospital_data.patients; -- Deve retornar apenas do depto do usuário
RESET SESSION AUTHORIZATION;

SET SESSION AUTHORIZATION report_cir;
SELECT id, department_id FROM hospital_data.patients; -- Apenas de Cirurgia
RESET SESSION AUTHORIZATION;
```
Se os resultados estiverem filtrados por departamento do usuário, o RLS está funcionando.

## Nota: PII e PHI
- PII: dados pessoais identificáveis; PHI: PII com saúde.
- RLS é crucial para limitar a visibilidade de linhas sensíveis por usuário/departamento.


