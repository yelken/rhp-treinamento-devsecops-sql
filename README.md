 ## Treinamento Prático de DevSecOps para Times de Dados (SQL) — RHP
 
 Bem-vindos! Este repositório contém 12 exercícios práticos focados em segurança aplicada ao dia a dia do time de dados (SQL, relatórios e pipelines). Cada exercício tem um enunciado claro e uma correção na pasta `solutions/`.
 
 ### Público-alvo
 - Analistas e engenheiros de dados que escrevem SQL e geram relatórios.
 - Objetivo: incorporar práticas de DevSecOps no ciclo de desenvolvimento de consultas, views, procedures e entregas de dados.
 
 ### Ambiente
 - Banco: PostgreSQL (via Docker Compose).
 - Dados de exemplo do hospital (fictícios) para praticar.
 - Ferramentas: SQLFluff (lint), Gitleaks (secret scan), GitHub Actions (CI).
 
 ### Como começar
 1) Pré-requisitos:
    - Docker Desktop e Docker Compose
    - Git e um editor de sua preferência
 2) Suba o banco:
    - `docker compose up -d`
    - Aguarde o serviço ficar saudável (healthcheck).
 3) Conexão ao banco:
    - Host: `localhost`
    - Porta: `5432`
    - DB: `hospital`
    - User: `rhp`
    - Password: `rhp_password`
 

 
 ### Estrutura
 - `docker-compose.yml`: orquestra o Postgres e carrega o schema/dados.
 - `db/init`: DDL/DML e dados de exemplo (carregados automaticamente).
 - `exercises/`: exercícios com enunciado e arquivos de apoio.
 - `solutions/`: gabaritos/soluções para conferência.
 - `.sqlfluff`: regras de lint de SQL.
 - `.gitleaks.toml`: configuração do Gitleaks.
 - `.github/workflows/ci.yml`: pipeline de CI (executa lint/scan/testes simples).

### Execução 100% em containers (ambiente efêmero)
- Suba banco e construa a imagem de ferramentas:
  ```bash
  docker compose build tools
  docker compose up -d db
  ```
- Use o container de ferramentas de forma efêmera (sem instalar nada no host):
  - Lint SQL (SQLFluff):
    ```bash
    docker compose run --rm tools sqlfluff lint .
    ```
  - Scan de segredos (Gitleaks):
    ```bash
    docker compose run --rm tools gitleaks detect --no-git -c .gitleaks.toml
    ```
  - Executar SQL contra o Postgres do compose (host `db` dentro da rede do compose):
    ```bash
    docker compose run --rm tools psql -h db -p 5432 -U rhp -d hospital -f db/init/01_schema.sql
    ```
  - Acessar o psql interativo:
    ```bash
    docker compose run --rm -it tools psql -h db -p 5432 -U rhp -d hospital
    ```
- Recursos opcionais já habilitados:
  - `pg_stat_statements`: habilitado via `shared_preload_libraries` no serviço `db`. Crie a extensão no psql quando precisar:
    ```sql
    CREATE EXTENSION IF NOT EXISTS pg_stat_statements;
    ```

### Nota rápida: PII e PHI
- PII (Personally Identifiable Information): dados pessoais que identificam uma pessoa (ex.: nome, CPF/RG, endereço, telefone, e-mail, data de nascimento, IP, biometria).
- PHI (Protected Health Information): PII associada a informações de saúde (ex.: exames, diagnósticos, internações).
- Boas práticas neste treinamento: minimizar PII em consultas (evitar `SELECT *`), usar views mascaradas, aplicar RBAC/RLS, criptografar colunas sensíveis e exportar somente o necessário.

### Lista de exercícios (1–26)
1. Higiene de repositório e governança de mudanças
2. Gestão de segredos (sem credenciais expostas)
3. Qualidade de SQL com lint (SQLFluff)
4. SQL Injection em SQL dinâmico (correção segura)
5. Privilégios mínimos e RBAC (GRANT/REVOKE)
6. RLS (Row-Level Security) por departamento
7. Classificação e mascaramento de dados (PII/PHI)
8. Trilha de auditoria (triggers) em dados sensíveis
9. Criptografia de coluna com pgcrypto (chave de sessão)
10. Anonimização para compartilhamento (pseudonimização e generalização)
11. CI para SQL: lint, scan de segredos e migrações
12. Backup e restauração testável (procedimento de DR)
13. SELECT * e vazamento de PII em joins
14. Junção cartesiana por falta de predicado
15. Falta de filtro e índice em relatórios
16. Predicados não sargáveis (funções na coluna)
17. Padrão N+1 e correlação ineficiente
18. Uso inadequado de CTE e materialização
19. Locks desnecessários em consultas de relatório
20. Export seguro: usar views mascaradas em vez de tabelas cruas
21. Princípio do Menor Dado (minimização de dados)
22. Orçamento de performance (tempo e custo por consulta)
23. Política de compartilhamento de dados (export responsável)
24. Responsabilidade sobre consultas (ética e LGPD)
25. Monitorar consultas com pg_stat_statements
26. Checklist de revisão de consultas (segurança e performance)

Cada exercício possui um `README.md` com:
- Objetivo
- Contexto
- Passo a passo
- Critério de aceite
- Dica(s)
- Onde validar

As correções ficam em `solutions/<exercicio>/`.



### Fluxo sugerido
1. Leia o enunciado do exercício em `exercises/ex0X-.../README.md`.
2. Edite os arquivos indicados no próprio exercício ou em `db/`.
3. Valide localmente (psql/cliente SQL, `docker compose`, linters).
4. Opcional: abra PR, veja o CI rodar e corrija até passar.
5. Compare com `solutions/` apenas após tentar resolver.

Bom estudo e mãos à obra!


